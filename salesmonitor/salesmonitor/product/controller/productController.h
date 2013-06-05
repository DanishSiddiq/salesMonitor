//
//  productController.h
//  salesmonitor
//
//  Created by goodcore2 on 6/5/13.
//  Copyright (c) 2013 GoodCore. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface productController : NSObject <UITableViewDataSource, UITableViewDelegate>

// constructor
- (id) init : (BOOL) isIphone loadData :(NSMutableArray *) loadData ;

@end
