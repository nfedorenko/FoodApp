//
//  PaymentGateway.h
//  Easy Food
//
//  Created by Dmitriy Groschovskiy on 22.09.15.
//  Copyright © 2015 Apple Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PaymentGateway : UIViewController

// Credit Card Information Outlet
@property (weak, nonatomic) IBOutlet UITextField *creditCardHolder;
@property (weak, nonatomic) IBOutlet UITextField *creditCardNumber;
@property (weak, nonatomic) IBOutlet UITextField *creditCardExpiration;
@property (weak, nonatomic) IBOutlet UITextField *creditCardSecureCode;
@property (weak, nonatomic) IBOutlet UITextField *creditCardAmountValue;
@property (weak, nonatomic) IBOutlet UITextField *creditCardTopUpAmount;

@end
