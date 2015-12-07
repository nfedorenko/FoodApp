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
    int productCost;
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
        self.productPrice = [productDetails[@"pizzaPrice"] longValue];
        NSLog(@"%@", productDetails);
        [self.tableView reloadData];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Dissmiss call event

#warning MODULE

- (IBAction)buySelectedProduct:(id)sender {
    //тут покупается пицца, только она не записывается в историю, а просто минусуются деньги со счета

    PFUser *currentUser = [PFUser currentUser];
    PFQuery *query = [PFQuery queryWithClassName:@"_User"];
    [query getObjectInBackgroundWithId:currentUser.objectId block:^(PFObject *accountInformationGetts, NSError *error) {
        int currentBallance = [accountInformationGetts[@"dinnersCredit"] integerValue];
        int transitBallance = currentBallance - productCost;
        [self customerObjectUpdate:transitBallance :currentUser.objectId :true];
        NSLog(@"%@", accountInformationGetts);
    }];
}

- (IBAction)customerLoungeCenter:(id)sender {
    [self dismissViewControllerAnimated:true completion:nil];
}

- (void)customerObjectUpdate:(int)pricing :(NSString *)objectIdent :(BOOL)closeAccessor {
    PFQuery *query = [PFQuery queryWithClassName:@"_User"];
    [query getObjectInBackgroundWithId:objectIdent
                                 block:^(PFObject *bankInterface, NSError *error) {
                                     bankInterface[@"dinnersCredit"] = @(pricing);
                                     [bankInterface saveInBackground];
                                 }];
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
