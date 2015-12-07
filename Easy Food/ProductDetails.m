//
//  ProductDetails.m
//  Easy Food
//
//  Created by Dmitriy Groschovskiy on 22.09.15.
//  Copyright © 2015 Apple Inc. All rights reserved.
//

#import "ProductDetails.h"
#import <Parse/Parse.h>
#import "PurchaseCell.h"

@interface ProductDetails () {
    float productCost;
}

@end

@implementation ProductDetails

- (void)viewDidLoad {
    [super viewDidLoad];
    self.picker.delegate = self;
    self.picker.dataSource = self;
    self.tableView.separatorColor = [UIColor blackColor];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    
    
    PFQuery *moreInformation = [PFQuery queryWithClassName:@"FFEating"];
    [moreInformation getObjectInBackgroundWithId:self.delegateObjectId block:^(PFObject *productDetails, NSError *error) {
        self.productName.text = productDetails[@"pizzaName"];
        self.productDescription.text = productDetails[@"pizzaDescription"];
        productCost = [productDetails[@"pizzaPrice"] floatValue];
        self.productPrice = [productDetails[@"pizzaPrice"] longValue];
        NSLog(@"%@", productDetails);
        [self.tableView reloadData];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Dissmiss call event

- (IBAction)buySelectedProduct:(id)sender {
    PFUser *currentUser = [PFUser currentUser];
    PFQuery *query = [PFQuery queryWithClassName:@"_User"];
    [query getObjectInBackgroundWithId:currentUser.objectId block:^(PFObject *datastoreObject, NSError *error) {
        float customerCredit = [datastoreObject[@"dinnersCredit"] floatValue];
        float processingCredit = customerCredit - productCost;
        
        PFQuery *query = [PFQuery queryWithClassName:@"_User"];
        [query getObjectInBackgroundWithId:currentUser.objectId block:^(PFObject *writePaymentResult, NSError *error) {
            writePaymentResult[@"dinnersCredit"] = @(processingCredit);
            [writePaymentResult saveInBackground];
            
            PFObject *paymentLog = [PFObject objectWithClassName:@"FFHistory"];
            paymentLog[@"productName"] = self.productName.text;
            paymentLog[@"productPrice"] = @(productCost);
            [paymentLog saveInBackground];
        }];
    }];
}

- (IBAction)customerLoungeCenter:(id)sender {
    [self dismissViewControllerAnimated:true completion:nil];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    PurchaseCell* cell = [[PurchaseCell alloc]init];
    switch (indexPath.row) {
        case 0:
            cell = [tableView dequeueReusableCellWithIdentifier:@"firstCell"];
            cell.priceLabel.text = [NSString stringWithFormat:@"%ld BYR", (long)self.productPrice];
            break;
        case 1:
            cell = [tableView dequeueReusableCellWithIdentifier:@"secondCell"];
            cell.secondPriceLabel.text = [NSString stringWithFormat:@"% 1.f BYR", self.productPrice * 1.3];
            break;
        case 2:
            cell = [tableView dequeueReusableCellWithIdentifier:@"threeCell"];
            break;
            
        default:
            break;
    }
    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 2) {
        return 150;
    }
    return 62;
}

@end
