//
//  PurchaseCell.h
//  Easy Food
//
//  Created by Nikita on 24.11.15.
//  Copyright © 2015 Apple Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PurchaseCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;

@property (weak, nonatomic) IBOutlet UIButton *purchaseAction;
@property (weak, nonatomic) IBOutlet UILabel *secondPriceLabel;

- (IBAction)checkBox:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UIButton *buttonOne;
@property (weak, nonatomic) IBOutlet UIButton *buttonTwo;

@end
