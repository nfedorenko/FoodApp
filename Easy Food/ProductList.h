//
//  ProductList.h
//  Easy Food
//
//  Created by Dmitriy Groschovskiy on 22.09.15.
//  Copyright © 2015 Apple Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProductList : UIViewController <UITableViewDataSource, UITableViewDelegate> {
    IBOutlet UITableView *tableView;

    NSArray *pizzaName;
    NSArray *pizzaPricing;
    NSArray *pizzaDescription;
}

@property (weak, nonatomic) NSArray *databaseSQLResponseAtJSON;

@end
