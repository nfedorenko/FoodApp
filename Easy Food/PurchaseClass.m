//
//  PurchaseClass.m
//  Easy Food
//
//  Created by Nikita on 01.12.15.
//  Copyright © 2015 Apple Inc. All rights reserved.
//

#import "PurchaseClass.h"
#import <Parse/Parse.h>
#import <LocalAuthentication/LocalAuthentication.h>

@implementation PurchaseClass

- (void)purchaseItemFromStore:(float)pizzaPrice {
    /*
    PFUser *currentUser = [PFUser currentUser][@"dinnerItems"];
    PFQuery *queryItem = [PFQuery queryWithClassName:@"YYYXXX"];
    [queryItem getObjectInBackgroundWithId:currentUser block:^(PFObject *restaurantQuery, NSError *Error){
        float currentWalletValue = restaurantQuery[@"currentCredit"];
        float transactionValue = currentWalletValue - pizzaPrice;
        
        if (transactionValue > 0) {
            // SAVE
            
            PFQuery *saveDigitalMoney = [PFQuery queryWithClassName:@"YYYXXX"];
            [saveDigitalMoney getObjectInBackgroundWithId:@"" block:^(PFObject *customerObject, NSError *Error) {
                customerObject[@"currentCredit"] = transactionValue;
            }];
        } else {
            self.superclass;
            NSLog(@"Developer Debug: Engout money for transaction");
        }
        // PFQuery to Google SQL reqest for save data
    }];
    */
}

@end
