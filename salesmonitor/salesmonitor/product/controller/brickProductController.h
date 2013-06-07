//
//  brickProductController.h
//  salesmonitor
//
//  Created by goodcore2 on 6/7/13.
//  Copyright (c) 2013 GoodCore. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "applicationConstants.h"

@interface brickProductController : NSObject <UITableViewDataSource, UITableViewDelegate>

- (id)  init : (BOOL) isIphone;

- (void) setLoadProduct : (NSMutableArray *) loadProduct;

@end
