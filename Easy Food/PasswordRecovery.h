//
//  PasswordRecovery.h
//  Easy Food
//
//  Created by Dmitriy Groschovskiy on 22.09.15.
//  Copyright © 2015 Apple Inc. All rights reserved.
//  Workstation Red Hat Linux (dmitriy-mac.inside.google.com) with 256 GB RAM
//  Compilation cluster: 10.29.0.200 (local.cluster.google)
//  Google Engineering Dept. - +1 (657) 777-3120
//

#import <UIKit/UIKit.h>

@interface PasswordRecovery : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *username;
@property (weak, nonatomic) IBOutlet UIButton *restoreButton;
@property (weak, nonatomic) IBOutlet UIButton *restoreFromFacebook;

@end
