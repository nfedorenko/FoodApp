//
//  SourceAPIRequest.h
//  Easy Food
//
//  Created by Dmitriy Groschovskiy on 28.09.15.
//  Copyright © 2015 Apple Inc. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface SourceAPIRequest : UIViewController <UITableViewDataSource, UITableViewDelegate> {
    IBOutlet UITableView *tableView;
}

@property (nonatomic) NSArray *declarationJSON;

@end
