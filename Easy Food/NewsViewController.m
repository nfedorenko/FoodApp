//
//  NewsViewController.m
//  Easy Food
//
//  Created by Nikita on 27.11.15.
//  Copyright © 2015 Apple Inc. All rights reserved.
//

#import "NewsViewController.h"
#import "ContentOfPageViewController.h"

@interface NewsViewController ()

@property (strong,nonatomic) UIPageViewController* pageViewController;
@property (assign,nonatomic) NSInteger pageCount;

@end

@implementation NewsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.pageViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"PageViewController"];
    self.pageViewController.dataSource = self;
    self.pageCount = 4;
    ContentOfPageViewController* startVC = (ContentOfPageViewController*)[self viewControllerAtIndex:0];
    NSArray* viewControllers = [NSArray arrayWithObject:startVC];
    self.pageViewController.view.backgroundColor = [UIColor clearColor];
    
    [self.pageViewController setViewControllers:viewControllers
                                      direction:UIPageViewControllerNavigationDirectionForward
                                       animated:YES
                                     completion:nil];
    self.pageViewController.view.frame = CGRectMake(50, 100, self.view.frame.size.width - 100, self.view.frame.size.height - 200);
    [self addChildViewController:self.pageViewController];
    [self.view addSubview:self.pageViewController.view];
    [self.pageViewController didMoveToParentViewController:self];
    
    //set setting
    [self parametersOfView];
    
}

#pragma mark - view settings
-(void)parametersOfView{
    
    //navigation bar style edite
    self.navigationItem.title = @"News";
    self.navigationController.navigationBar.tintColor = [UIColor colorWithRed:0.2 green:0.6 blue:0.6 alpha:1];
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:0.952 green:0.9215 blue:0.8005 alpha:1];
    UIColor* colore = [UIColor colorWithRed:0.2 green:0.6 blue:0.6 alpha:1];
    NSDictionary* dictionary = [[NSDictionary alloc]initWithObjectsAndKeys:colore, NSForegroundColorAttributeName,nil];
    self.navigationController.navigationBar.titleTextAttributes = dictionary;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UIPageViewControllerDataSource

-(nullable UIViewController *)viewControllerAtIndex: (NSInteger) index {
    if (self.pageCount == 0 || index > self.pageCount) {
        return nil;
    }
    ContentOfPageViewController* vc = [self.storyboard instantiateViewControllerWithIdentifier:@"ContentOfPageViewController"];
    vc.indexPage = index;
    vc.view.backgroundColor = [UIColor colorWithRed:((float)(arc4random_uniform(10)))/10.0 green:((float)(arc4random_uniform(10)))/10.0 blue:((float)(arc4random_uniform(10)))/10.0 alpha:1];
    return vc;
    
}


- (nullable UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController{
    ContentOfPageViewController* vc = (ContentOfPageViewController*)viewController;
    NSInteger index = vc.indexPage;
    if (index == 0 || index == NSNotFound) {
        return nil;
    }
    index--;
    return [self viewControllerAtIndex:index];
}
- (nullable UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController{
    ContentOfPageViewController* vc = (ContentOfPageViewController*)viewController;
    NSInteger index = vc.indexPage;
    if (index == NSNotFound) {
        return nil;
    }
    index++;
    if (index == self.pageCount) {
        return nil;
    }

    return [self viewControllerAtIndex:index];
}
- (NSInteger)presentationCountForPageViewController:(UIPageViewController *)pageViewController{
    return self.pageCount;
}
- (NSInteger)presentationIndexForPageViewController:(UIPageViewController *)pageViewController{
    return 0;
}

@end
