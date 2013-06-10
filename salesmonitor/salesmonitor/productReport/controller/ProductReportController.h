//
//  ProductReportController.h
//  salesmonitor
//
//  Created by goodcore2 on 6/10/13.
//  Copyright (c) 2013 GoodCore. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AppDelegate.h"
#import "applicationConstants.h"
#import "AFNetworking.h"
#import "SVProgressHUD.h"

@protocol ProductReportDelegate <NSObject>
@required

- (void) salesDataFromServer : (NSMutableArray *) salesReport;

@end

@interface ProductReportController : NSObject

-(id) init : (id<ProductReportDelegate>) viewController salesMonitorDelegate : (AppDelegate *)salesMonitorDelegate;
- (void) fetchDataFromServer : (NSNumber *) fromDate toDate : (NSNumber *) toDate ;

@end
