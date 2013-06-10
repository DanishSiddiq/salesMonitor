//
//  ProductReportController.m
//  salesmonitor
//
//  Created by goodcore2 on 6/10/13.
//  Copyright (c) 2013 GoodCore. All rights reserved.
//

#import "ProductReportController.h"

@interface  ProductReportController()

@property (nonatomic, strong) id<ProductReportDelegate> viewController;
@property (nonatomic, strong) AppDelegate *salesMonitorDelegate;

@end

@implementation ProductReportController

-(id) init : (id<ProductReportDelegate>) viewController salesMonitorDelegate : (AppDelegate *)salesMonitorDelegate{
    
    self = [super init];
    
    if(self){
        _viewController = viewController;
        _salesMonitorDelegate = salesMonitorDelegate;
    }
    
    return self;
}

- (void) fetchDataFromServer : (NSNumber *) fromDate toDate : (NSNumber *) toDate {
 
    if(![_salesMonitorDelegate isNetworkAvailable]){
        
        SIAlertView *alertView = [[SIAlertView alloc] initWithTitle:@"Network Issue" andMessage:@"Internet not available"];
        [alertView addButtonWithTitle:@"Ok"
                                 type:SIAlertViewButtonTypeDestructive
                              handler:^(SIAlertView *alertView) {
                              }];
        alertView.transitionStyle = SIAlertViewTransitionStyleSlideFromTop;
        [alertView show];
        
    }
    else{
        
        
        NSString *urlString = [NSString stringWithFormat:KEY_SERVER_REPORT_SALE
                               , [[_salesMonitorDelegate userData] valueForKey:KEY_USER_ID]
                               , fromDate
                               , toDate];
        
        NSURL *url = [NSURL URLWithString:urlString];
        NSURLRequest *request = [NSURLRequest requestWithURL:url];
        
        
        AFJSONRequestOperation *operation =
        [AFJSONRequestOperation
         JSONRequestOperationWithRequest:request
         success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
             [SVProgressHUD dismiss];
             
             if([_viewController respondsToSelector:@selector(salesDataFromServer:)]){
             
                 [_viewController salesDataFromServer:JSON];
             }
         }
         failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON)
         {          
             [SVProgressHUD dismiss];
             
             SIAlertView *alertView = [[SIAlertView alloc] initWithTitle:@"Server not Responded"
                                                              andMessage:@"custom message on basis of code"];
             [alertView addButtonWithTitle:@"Ok"
                                      type:SIAlertViewButtonTypeDestructive
                                   handler:^(SIAlertView *alertView) {
                                   }];
             alertView.transitionStyle = SIAlertViewTransitionStyleSlideFromTop;
             [alertView show];
             
         }];
        operation.JSONReadingOptions = NSJSONReadingMutableContainers | NSJSONReadingMutableLeaves;
        [operation start];
        [SVProgressHUD showWithStatus:@"Loading Sales Report" maskType:SVProgressHUDMaskTypeClear];
    }
}

@end
