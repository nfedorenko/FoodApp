//
//  RegistrationController.h
//  Easy Food
//
//  Created by Dmitriy Groschovskiy on 22.09.15.
//  Copyright © 2015 Apple Inc. All rights reserved.
//  Workstation Red Hat Linux (dmitriy-mac.inside.google.com) with 256 GB RAM
//  Compilation cluster: 10.29.0.200 (local.cluster.google)
//  Google Engineering Dept. - +1 (657) 777-3120
//

#import <UIKit/UIKit.h>

@interface RegistrationController : UIViewController

// Engineering auth details
@property (weak, nonatomic) IBOutlet UITextField *username;
@property (weak, nonatomic) IBOutlet UITextField *password;

// Customer database details
@property (weak, nonatomic) IBOutlet UITextField *firstName;
@property (weak, nonatomic) IBOutlet UITextField *lastName;
@property (weak, nonatomic) IBOutlet UITextView *livingAddress;

@property (weak, nonatomic) IBOutlet UIButton *createNewAccButton;
@property (weak, nonatomic) IBOutlet UIButton *facebookButton;


@end
