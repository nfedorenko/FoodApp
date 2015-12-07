//
//  RegistrationController.m
//  Easy Food
//
//  Created by Dmitriy Groschovskiy on 22.09.15.
//  Copyright © 2015 Google Inc. All rights reserved.
//  Workstation Red Hat Linux (dmitriy-mac.inside.google.com) with 256 GB RAM
//  Compilation cluster: 10.29.0.200 (local.cluster.google)
//  Google Engineering Dept. - +1 (657) 777-3120
//

#import "RegistrationController.h"
#import <Parse/Parse.h>

@interface RegistrationController ()

@end

@implementation RegistrationController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.createNewAccButton.layer.cornerRadius = 25;
    self.facebookButton.layer.cornerRadius = 25;
    UIColor *color = [UIColor colorWithRed:0.952 green:0.9215 blue:0.8005 alpha:1];
    self.username.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"example@email.com" attributes:@{NSForegroundColorAttributeName: color}];
    self.lastName.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"last name" attributes:@{NSForegroundColorAttributeName: color}];
    self.password.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"password" attributes:@{NSForegroundColorAttributeName: color}];
    self.firstName.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"first name" attributes:@{NSForegroundColorAttributeName: color}];
    
    

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)registerWithCredentials:(id)sender {
    PFUser *customer = [PFUser user];
    customer.username = self.username.text;
    customer.password = self.password.text;
    customer.email = self.username.text;

    customer[@"firstName"] = self.firstName.text;
    customer[@"lastName"] = self.lastName.text;
    customer[@"livingAddress"] = self.livingAddress.text;
    customer[@"currentCredit"] = @50000;
    
    [customer signUpInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (!error) {
            [self dismissViewControllerAnimated:true completion:nil];
        } else {
            NSString *errorString = [error userInfo][@"error"];
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert Center" message:errorString delegate:nil cancelButtonTitle:@"Okay" otherButtonTitles:nil];
            [alert show];
        }
    }];
}

- (IBAction)closeController:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
