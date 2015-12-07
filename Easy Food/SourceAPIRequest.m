//
//  SourceAPIRequest.m
//  Easy Food
//
//  Created by Dmitriy Groschovskiy on 28.09.15.
//  Copyright © 2015 Apple Inc. All rights reserved.
//

#import "SourceAPIRequest.h"
#import "TableFoodItem.h"
#import <Parse/Parse.h>
#import "ProductDetails.h"
#import "MMDrawerController.h"

@interface SourceAPIRequest () {
    NSArray *pizzaObjectId;
    NSArray *pizzaName;
    NSArray *pizzaPrice;
    NSArray *pizzaShortDesc;
    NSArray *pizzaImages;
}

@end

@implementation SourceAPIRequest

- (void)viewDidLoad {
    [super viewDidLoad];
    
    PFQuery *query = [PFQuery queryWithClassName:@"FFEating"];
    [query orderByDescending:@"createdAt"];
    [query findObjectsInBackgroundWithBlock:^(NSArray *musicLibrary, NSError *error) {
        if (!error) {
            pizzaObjectId = [musicLibrary valueForKey:@"objectId"];
            pizzaName = [musicLibrary valueForKey:@"pizzaName"];
            pizzaPrice = [musicLibrary valueForKey:@"pizzaPrice"];
            pizzaShortDesc = [musicLibrary valueForKey:@"pizzaDescription"];
            [tableView reloadData];
            NSLog(@"%@", musicLibrary);
        }
    }];
    //set settings
    [self parametersOfView];

}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - view settings
-(void)parametersOfView{
    
    //table view edite
    tableView.backgroundColor = [UIColor clearColor];
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    //navigation bar style edite
    self.navigationItem.title = @"Menu";
    self.navigationController.navigationBar.tintColor = [UIColor colorWithRed:0.2 green:0.6 blue:0.6 alpha:1];
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:0.952 green:0.9215 blue:0.8005 alpha:1];
    UIColor* colore = [UIColor colorWithRed:0.2 green:0.6 blue:0.6 alpha:1];
    NSDictionary* dictionary = [[NSDictionary alloc]initWithObjectsAndKeys:colore, NSForegroundColorAttributeName,nil];
    self.navigationController.navigationBar.titleTextAttributes = dictionary;
    
}

#pragma mark - Expirimental Table Version

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [pizzaName count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TableFoodItem *cell = [tableView dequeueReusableCellWithIdentifier:@"foodItemCell"];
    if (!cell) {
        [tableView registerNib:[UINib nibWithNibName:@"TableFoodItem" bundle:nil] forCellReuseIdentifier:@"foodItemCell"];
        cell = [tableView dequeueReusableCellWithIdentifier:@"foodItemCell"];
    }
    cell.backgroundColor = [UIColor clearColor];
    return cell;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(TableFoodItem *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    cell.pizzaName.text = [pizzaName objectAtIndex:indexPath.row];
    cell.pizzaPrice.text = [NSString stringWithFormat:@"%@ BYR",[[pizzaPrice objectAtIndex:indexPath.row] stringValue]];
    cell.pizzaComposition.text = [pizzaShortDesc objectAtIndex:indexPath.row];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    ProductDetails *productDelegate = [storyboard instantiateViewControllerWithIdentifier:@"ProductDetails"];
    productDelegate.delegateObjectId = [pizzaObjectId objectAtIndex:indexPath.row];
    NSLog(@"pizza567%@", [pizzaObjectId objectAtIndex:indexPath.row]);
    [self.navigationController pushViewController:productDelegate animated:YES];
}


-(void)dealloc{
    NSLog(@"Menu dealocated");
}

@end
