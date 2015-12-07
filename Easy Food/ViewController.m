//
//  ViewController.m
//  Easy Food
//
//  Created by Dmitriy Groschovskiy on 22.09.15.
//  Copyright © 2015 Apple Inc. All rights reserved.
//  Workstation Red Hat Linux (dmitriy-mac.inside.google.com) with 256 GB RAM
//  Compilation cluster: 10.29.0.200 (local.cluster.google)
//  Google Engineering Dept. - +1 (657) 777-3120
//

#import "ViewController.h"
#import "RegistrationController.h"
#import "TabBarViewController.h"
#import "MMDrawerController.h"

#import <Parse/Parse.h>
#import "GoogleVanilla.h"
#import "PasswordRecovery.h"
#import "CustomerLounge.h"

@interface ViewController ()

@end

@implementation ViewController 

- (void)viewDidLoad {
    [super viewDidLoad];
    [scrollView setScrollEnabled:true];
    self.startButton.layer.cornerRadius = 25;
    self.facebookButton.layer.cornerRadius = 25;

    

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
-(void)showTabBarControler{
    
    TabBarViewController* vc = [[TabBarViewController alloc]init];
    
    UIStoryboard *customStoryboard = [UIStoryboard storyboardWithName:@"CustomerLounge" bundle:nil];
    UIStoryboard *mainStoryboard1 = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    UIViewController *secondVC = [mainStoryboard1 instantiateViewControllerWithIdentifier:@"AboutUsController"];
    UINavigationController* navAboutus = [[UINavigationController alloc]initWithRootViewController:secondVC];
    
    UIViewController * foughtVC = [mainStoryboard1 instantiateViewControllerWithIdentifier:@"NewsViewController"];
    UINavigationController* navNews = [[UINavigationController alloc]initWithRootViewController:foughtVC];
    
    UIViewController *threeVC = [mainStoryboard1 instantiateViewControllerWithIdentifier:@"productList"];
    UINavigationController* navMenu = [[UINavigationController alloc]initWithRootViewController:threeVC];
    
    UIViewController *firstVC = [customStoryboard instantiateViewControllerWithIdentifier:@"CustomerPortal"];
    UINavigationController* navLounge = [[UINavigationController alloc]initWithRootViewController:firstVC];
    
    NSArray* arrayVC = [NSArray arrayWithObjects:navMenu,navLounge,navAboutus,navNews, nil];
    [vc setViewControllers:arrayVC animated:YES];
    UIViewController *lvc = [mainStoryboard1 instantiateViewControllerWithIdentifier:@"id"];
    
    MMDrawerController* сvc = [[MMDrawerController alloc]initWithCenterViewController:vc leftDrawerViewController:lvc];
    сvc.openDrawerGestureModeMask = MMOpenDrawerGestureModePanningCenterView;
    сvc.closeDrawerGestureModeMask = MMOpenDrawerGestureModePanningCenterView;
    сvc.maximumLeftDrawerWidth = 270;

    vc.tabBar.barTintColor = [UIColor colorWithRed:0.952 green:0.9215 blue:0.8005 alpha:1];
    [self presentViewController:сvc animated:YES completion:nil];
}

#pragma mark - Customer Authorization

- (IBAction)authWithCredentials:(id)sender {
   dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0u), ^{
        [PFUser logInWithUsernameInBackground:self.username.text password:self.password.text
                                        block:^(PFUser *user, NSError *error) {
                                            if (user) {
     /*
                                              UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"CustomerLounge" bundle:nil];
                                                UIViewController *cvc = [storyboard instantiateViewControllerWithIdentifier:@"CustomerPortal"];
                                                //[self presentViewController:vc animated:true completion:nil];
                                              
                                                UIStoryboard *storyboard1 = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
                                                UIViewController *lvc = [storyboard1 instantiateViewControllerWithIdentifier:@"id"];
                                                MMDrawerController* vc = [[MMDrawerController alloc]initWithCenterViewController:cvc leftDrawerViewController:lvc];
                                                vc.openDrawerGestureModeMask = MMOpenDrawerGestureModePanningCenterView;
                                                vc.closeDrawerGestureModeMask = MMOpenDrawerGestureModePanningCenterView;
                                                vc.maximumLeftDrawerWidth = 280;
                                                [self presentViewController:vc animated:YES completion:nil];
                                           */
                                                [self showTabBarControler];
                                                
                                            } else {
                                                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Easy Food Service" message:@"Please check your entered data and try again. If you have forgotten your password, use password recovery wizard." delegate:nil cancelButtonTitle:@"Okay" otherButtonTitles:nil];
                                                [alert show];
                                            }
                                        }];
        dispatch_async(dispatch_get_main_queue(), ^{
            
        });
    });
    

}

- (IBAction)registerWithCredentials:(id)sender {
    RegistrationController *registerViewController = [[RegistrationController alloc] initWithNibName:@"RegistrationController" bundle:nil];
    [self presentViewController:registerViewController animated:true completion:nil];
}

- (IBAction)forgotMyPassword:(id)sender {
    PasswordRecovery *recoveryViewController = [[PasswordRecovery alloc] initWithNibName:@"PasswordRecovery" bundle:nil];
    [self presentViewController:recoveryViewController animated:true completion:nil];
}

@end
