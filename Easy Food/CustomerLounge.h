//
//  CustomerLounge.h
//  Easy Food
//
//  Created by Dmitriy Groschovskiy on 22.09.15.
//  Copyright © 2015 Google Inc. All rights reserved.
//  Workstation Red Hat Linux (dmitriy-mac.inside.google.com) with 256 GB RAM
//  Compilation cluster: 10.29.0.200 (local.cluster.google)
//  Google Engineering Dept. - +1 (657) 777-3120
//

#import <UIKit/UIKit.h>
@class MMDrawerController;

@interface CustomerLounge : UIViewController <UITableViewDelegate, UITableViewDataSource> {
    IBOutlet UITableView *tableView;
    NSArray *purchaseName;
    NSArray *purchaseCost;
}

@property (weak, nonatomic) IBOutlet UILabel *firstName;
@property (weak, nonatomic) IBOutlet UILabel *lastName;
@property (strong, nonatomic) IBOutlet UILabel *creditValue;
@property (weak, nonatomic) IBOutlet UIImageView *profileImage;
@property (strong,nonatomic) MMDrawerController* centerController;
@property (weak, nonatomic) NSArray *purchaseStack;

- (IBAction)infoAction:(UIButton *)sender;
- (IBAction)callAction:(UIButton *)sender;
@end
