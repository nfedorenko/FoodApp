//
//  PasswordRecovery.m
//  Easy Food
//
//  Created by Dmitriy Groschovskiy on 22.09.15.
//  Copyright © 2015 Apple Inc. All rights reserved.
//  Workstation Red Hat Linux (dmitriy-mac.inside.google.com) with 256 GB RAM
//  Compilation cluster: 10.29.0.200 (local.cluster.google)
//  Google Engineering Dept. - +1 (657) 777-3120
//

#import "PasswordRecovery.h"
#import <Parse/Parse.h>

@interface PasswordRecovery ()

@end

@implementation PasswordRecovery

- (void)viewDidLoad {
    [super viewDidLoad];
    self.restoreButton.layer.cornerRadius = 25;
    self.restoreFromFacebook.layer.cornerRadius = 25;
    UIColor *color = [UIColor colorWithRed:0.952 green:0.9215 blue:0.8005 alpha:1];
    self.username.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"example@email.com" attributes:@{NSForegroundColorAttributeName: color}];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)restorePassword:(id)sender {
    [PFUser requestPasswordResetForEmailInBackground:self.username.text];
}

- (IBAction)closeController:(id)sender {
    [self dismissViewControllerAnimated:true completion:nil];
}


@end
