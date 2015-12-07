//
//  PurchaseCell.m
//  Easy Food
//
//  Created by Nikita on 24.11.15.
//  Copyright © 2015 Apple Inc. All rights reserved.
//

#import "PurchaseCell.h"

@interface PurchaseCell ()

@property (assign,nonatomic) BOOL isFirstPressed;

@end


@implementation PurchaseCell


- (void)awakeFromNib {
    self.purchaseAction.layer.cornerRadius = 5;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)checkBox:(UIButton *)sender {
    if (self.isFirstPressed) {
        [sender setBackgroundImage:[UIImage imageNamed:@"RadioButton_Off_White.png"] forState:UIControlStateNormal];
        self.isFirstPressed = NO;
    }else{
        [sender setBackgroundImage:[UIImage imageNamed:@"RadioButton_On_White.png"] forState:UIControlStateNormal];
        self.isFirstPressed = YES;
    }
}
@end
