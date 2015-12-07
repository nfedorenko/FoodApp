//
//  PaymentGateway.m
//  Easy Food
//
//  Created by Dmitriy Groschovskiy on 22.09.15.
//  Copyright © 2015 Apple Inc. All rights reserved.
//

#import "PaymentGateway.h"
#import <Parse/Parse.h>
#import "PayeezySDK.h"
#import "MMDrawerController.h"
#import "LeftMenuViewController.h"

@interface PaymentGateway () {
    UIScrollView *scrollingObject;
}

#define KApiKey     @"y6pWAJNyJyjGv66IsVuWnklkKUPFbb0a"
#define KApiSecret  @"86fbae7030253af3cd15faef2a1f4b67353e41fb6799f576b5093ae52901e6f786fbae7030253af3cd15faef2a1f4b67353e41fb6799f576b5093ae52901e6f7"
#define KToken      @"fdoa-a480ce8951daa73262734cf102641994c1e55e7cdf4c02b6"
#define KURL        @"https://api-cert.payeezy.com/v1/transactions"

@end

@implementation PaymentGateway

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.creditCardHolder.delegate = self;
    self.creditCardNumber.delegate = self;
    self.creditCardSecureCode.delegate = self;
    self.creditCardAmountValue.delegate = self;
    self.creditCardExpiration.delegate = self;
    
    [scrollingObject setScrollEnabled:true];
    [scrollingObject setContentSize:CGSizeMake(320, 130)];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWasShown:) name:UIKeyboardDidShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillBeHidden:) name:UIKeyboardDidHideNotification object:nil];
    
    [self.creditCardHolder setDelegate:self];
    [self.creditCardNumber setDelegate:self];
    [self.creditCardSecureCode setDelegate:self];
    [self.creditCardExpiration setDelegate:self];
    [self.creditCardAmountValue setDelegate:self];
    
    //mine editing
    UIBarButtonItem* back = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemCancel
                                                                         target:self
                                                                         action:@selector(bactAction)];
    self.navigationItem.rightBarButtonItem = back;
}

-(void)bactAction{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"CustomerLounge" bundle:nil];
    UIViewController *cvc = [storyboard instantiateViewControllerWithIdentifier:@"CustomerPortal"];
    //[self presentViewController:vc animated:true completion:nil];
    
    UIStoryboard *storyboard1 = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UIViewController *lvc = [storyboard1 instantiateViewControllerWithIdentifier:@"id"];
    MMDrawerController* vc = [[MMDrawerController alloc]initWithCenterViewController:cvc leftDrawerViewController:lvc];
    vc.openDrawerGestureModeMask = MMOpenDrawerGestureModePanningCenterView;
    vc.closeDrawerGestureModeMask = MMOpenDrawerGestureModePanningCenterView;
    vc.maximumLeftDrawerWidth = 280;
    [self presentViewController:vc animated:YES completion:nil];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [self.creditCardHolder resignFirstResponder];
    [self.creditCardNumber resignFirstResponder];
    [self.creditCardSecureCode resignFirstResponder];
    [self.creditCardExpiration resignFirstResponder];
    [self.creditCardAmountValue resignFirstResponder];
    
    return YES;
}

- (void)keyboardWasShown:(NSNotification *)notification {
    NSDictionary *info = [notification userInfo];
    CGSize kbSize = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    UIEdgeInsets contentInsets = UIEdgeInsetsMake(0.0, 0.0, kbSize.height, 0);
    scrollingObject.contentInset = contentInsets;
    scrollingObject.scrollIndicatorInsets = contentInsets;
}

- (void)keyboardWillBeHidden:(NSNotification *)notification {
    UIEdgeInsets contentInsets = UIEdgeInsetsZero;
    scrollingObject.contentInset = contentInsets;
    scrollingObject.scrollIndicatorInsets = contentInsets;
}

#pragma mark - Payment Processing Gateway

- (IBAction)paymentProcessingInterface:(id)sender {
    NSString* cardHolderName = _creditCardHolder.text;
    NSDecimalNumber* valueEntered = [NSDecimalNumber decimalNumberWithString:_creditCardAmountValue.text];
    NSString* cardNumber  = _creditCardNumber.text;
    NSString* cardSecurityCode = _creditCardSecureCode.text;

    if (![valueEntered isEqualToNumber:[NSDecimalNumber notANumber]]) {

        NSString *amount = [[NSString stringWithFormat:@"%@",valueEntered] stringByReplacingOccurrencesOfString:@"." withString:@""];

        NSDictionary* credit_card = @{
                                      @"type":@"visa",
                                      @"cardholder_name":cardHolderName,
                                      @"card_number":cardNumber,
                                      @"exp_date":@"0450",
                                      @"cvv":cardSecurityCode
                                      };
        PayeezySDK* myClient = [[PayeezySDK alloc]initWithApiKey:KApiKey apiSecret:KApiSecret merchantToken:KToken url:KURL];
        
        //myClient.url = KURL;
        
        [myClient submitAuthorizeTransactionWithCreditCardDetails:credit_card[@"type"]
                                                   cardHolderName:credit_card[@"cardholder_name"]
                                                       cardNumber:credit_card[@"card_number"]
                                          cardExpirymMonthAndYear:credit_card[@"exp_date"]
                                                          cardCVV:credit_card[@"cvv"]
                                                     currencyCode:@"GBP"
                                                      totalAmount:amount
                                         merchantRefForProcessing:@"abc1412096293369"
         
                                                       completion:^(NSDictionary *dict, NSError *error) {
                                                           
                                                           NSString *authStatusMessage = nil;
                                                           
                                                           if (error == nil)
                                                           {
                                                               authStatusMessage = [NSString stringWithFormat:@"Transaction Successful\rType:%@\rTransaction ID:%@\rTransaction Tag:%@\rCorrelation Id:%@\rBank Response Code:%@",
                                                                                    [dict objectForKey:@"transaction_type"],
                                                                                    [dict objectForKey:@"transaction_id"],
                                                                                    [dict objectForKey:@"transaction_tag"],
                                                                                    [dict objectForKey:@"correlation_id"],
                                                                                    [dict objectForKey:@"bank_resp_code"]];
                                                               //[self voidRefundCaptureTransaction:@"abc1412096293369" :[dict objectForKey:@"transaction_tag"] :@"capture" :[dict objectForKey:@"transaction_id"] :amount];

                                                               PFUser *currentUser = [PFUser currentUser];
                                                               PFQuery *paymentProcessing = [PFQuery queryWithClassName:@"_User"];
                                                               [paymentProcessing getObjectInBackgroundWithId:currentUser.objectId block:^(PFObject *merchantTerminal, NSError *error) {
                                                                   int long dispatcherCredit = [merchantTerminal[@"currentCredit"] integerValue];
                                                                   int deviceCredit = [self.creditCardTopUpAmount.text floatValue] * 26940;
                                                                   int long transferCredit = dispatcherCredit + deviceCredit;

                                                                   PFQuery *query = [PFQuery queryWithClassName:@"_User"];
                                                                   [query getObjectInBackgroundWithId:currentUser.objectId block:^(PFObject *paymentResponse, NSError *error) {
                                                                       paymentResponse[@"currentCredit"] = @(transferCredit);
                                                                       [paymentResponse saveInBackground];
                                                                   }];
                                                                   
                                                               }];
                                                               
                                                           } else {
                                                               authStatusMessage = [NSString stringWithFormat:@"Error was encountered processing transaction: %@", error.debugDescription];
                                                           }
                                                           
                                                           UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"First Data Payment Authorization"
                                                                                                           message:authStatusMessage delegate:self
                                                                                                 cancelButtonTitle:@"Dismiss"
                                                                                                 otherButtonTitles:nil];
                                                           [alert show];
                                                       }];
    }

}

@end
