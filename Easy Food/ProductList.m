//
//  ProductList.m
//  Easy Food
//
//  Created by Dmitriy Groschovskiy on 22.09.15.
//  Copyright © 2015 Apple Inc. All rights reserved.
//

#import <Parse/Parse.h>
#import "ProductList.h"
#import "TableFoodItem.h"

@interface ProductList () 

@end

@implementation ProductList

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIRefreshControl *refreshControl = [[UIRefreshControl alloc] init];
    [refreshControl addTarget:self action:@selector(refresh:) forControlEvents:UIControlEventValueChanged];
    [tableView addSubview:refreshControl];

    [self customerDatabaseInformationCenter];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)customerLoungeController:(id)sender {
    [self dismissViewControllerAnimated:true completion:nil];
}

- (void)refresh:(UIRefreshControl *)refreshControl {
    [self customerDatabaseInformationCenter];
    [refreshControl endRefreshing];
}

#pragma mark - Easy Food Product Information List

- (void)customerDatabaseInformationCenter {
    PFQuery *query = [PFQuery queryWithClassName:@"FFEating"];
    [query orderByDescending:@"createdAt"];
    [query findObjectsInBackgroundWithBlock:^(NSArray *customerDetails, NSError *error) {
        if (!error) {
            NSLog(@"%@",customerDetails);
            self.databaseSQLResponseAtJSON = [[NSArray alloc] initWithArray:customerDetails];
            pizzaName = [self.databaseSQLResponseAtJSON valueForKey:@"pizzaName"];
            pizzaDescription = [self.databaseSQLResponseAtJSON valueForKey:@"pizzaDescription"];
            pizzaPricing = [[self.databaseSQLResponseAtJSON valueForKey:@"pizzaPrice"] stringValue];
            
            [tableView reloadData];
        }
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.databaseSQLResponseAtJSON count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TableFoodItem *cellController = [tableView dequeueReusableCellWithIdentifier:@"connectNews"];
    if (!cellController) {
        [tableView registerNib:[UINib nibWithNibName:@"TableFoodItem" bundle:nil] forCellReuseIdentifier:@"connectNews"];
        cellController = [tableView dequeueReusableCellWithIdentifier:@"connectNews"];
    }

    return cellController;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(TableFoodItem *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    cell.pizzaName.text = [pizzaName objectAtIndex:indexPath.row];
    cell.pizzaPrice.text = [pizzaPricing objectAtIndex:indexPath.row];
    cell.pizzaComposition.text = [pizzaDescription objectAtIndex:indexPath.row];
    
    /*
     dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
     PFFile *currentFile = [artistArtworks objectAtIndex:indexPath.row];
     NSData *fileData = [currentFile getData];
     dispatch_async(dispatch_get_main_queue(), ^{
     cell.artistArtwork.image = [UIImage imageWithData:fileData];
     });
     });
     */
}

@end