//
//  TableFoodItem.h
//  Easy Food
//
//  Created by Dmitriy Groschovskiy on 24.09.15.
//  Copyright © 2015 Apple Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TableFoodItem : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *pizzaName;
@property (weak, nonatomic) IBOutlet UILabel *pizzaPrice;
@property (weak, nonatomic) IBOutlet UILabel *pizzaComposition;
@property (weak, nonatomic) IBOutlet UIImageView *pizzaImage;

@end
