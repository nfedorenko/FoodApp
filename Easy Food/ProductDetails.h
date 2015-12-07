//
//  ProductDetails.h
//  Easy Food
//
//  Created by Dmitriy Groschovskiy on 22.09.15.
//  Copyright © 2015 Apple Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProductDetails : UIViewController <UITableViewDataSource,UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UILabel *productName;
@property (assign, nonatomic) NSInteger productPrice;
@property (weak, nonatomic) IBOutlet UIImageView *productImage;
@property (weak ,nonatomic) IBOutlet UILabel*productDescription;

@property (strong, nonnull, nonatomic) NSString *delegateObjectId;
@property (strong, nonnull, nonatomic) IBOutlet UIPickerView *picker;
@property (weak, nonatomic) IBOutlet UITableView *tableView;



@end
