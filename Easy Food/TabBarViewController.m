//
//  TabBarViewController.m
//  Easy Food
//
//  Created by Nikita on 24.11.15.
//  Copyright © 2015 Apple Inc. All rights reserved.
//

#import "TabBarViewController.h"

@interface TabBarViewController ()

@end

@implementation TabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.tabBar.backgroundColor = [UIColor clearColor];
        self.tabBar.tintColor = [UIColor colorWithRed:0.2 green:0.6 blue:0.6 alpha:1];
    }
    return self;
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    //CGRect rect = CGRectMake(0, 0, 100, 100);
    UIImage* image = [UIImage imageNamed:@"30px-22.png"];
    
    [self.tabBar.items objectAtIndex:0].image = [self imageWithImage:image scaledToSize:CGSizeMake(25, 25)];
    [[self.tabBar.items objectAtIndex:0] setTitle:@"Menu"];
    image = [UIImage imageNamed:@"30px-38.png"];
    [self.tabBar.items objectAtIndex:1].image = [self imageWithImage:image scaledToSize:CGSizeMake(25, 25)];
    [[self.tabBar.items objectAtIndex:1] setTitle:@"Stash"];
    image = [UIImage imageNamed:@"30px-31.png"];
    [self.tabBar.items objectAtIndex:2].image = [self imageWithImage:image scaledToSize:CGSizeMake(25, 25)];
    [[self.tabBar.items objectAtIndex:2] setTitle:@"Map"];
    image = [UIImage imageNamed:@"30px-21.png"];
    [self.tabBar.items objectAtIndex:3].image = [self imageWithImage:image scaledToSize:CGSizeMake(25, 25)];
    [[self.tabBar.items objectAtIndex:3] setTitle:@"News"];
 
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (UIImage *)imageWithImage:(UIImage *)image scaledToSize:(CGSize)newSize {
    UIGraphicsBeginImageContextWithOptions(newSize, NO, 0.0);
    [image drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
