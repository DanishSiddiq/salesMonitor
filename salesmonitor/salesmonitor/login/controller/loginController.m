//
//  loginController.m
//  salesmonitor
//
//  Created by goodcore2 on 6/4/13.
//  Copyright (c) 2013 GoodCore. All rights reserved.
//

#import "loginController.h"


@interface  loginController()

@property (nonatomic, strong) id viewController;
@property (nonatomic, strong) AppDelegate *salesMonitorDelegate;

@end

@implementation loginController


-(id) init : (id) viewController salesMonitorDelegate : (AppDelegate *)salesMonitorDelegate{
    
    self = [super init];
    
    if(self){
        
        _viewController = viewController;
        _salesMonitorDelegate = salesMonitorDelegate;
    }
    
    return self;
}

- (void) authenticateUserAtServer : (NSString *) email pass : (NSString *) pass{
    
    if(![_salesMonitorDelegate isNetworkAvailable]){
        
    }
    else{
                
        NSString *urlString = [NSString stringWithFormat:KEY_SERVER_URL_LOGIN];
        NSURL *url = [NSURL URLWithString:urlString];
        NSURLRequest *request = [NSURLRequest requestWithURL:url];
        
        
        AFJSONRequestOperation *operation =
        [AFJSONRequestOperation
         JSONRequestOperationWithRequest:request
         success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
             
             if([_viewController respondsToSelector:@selector(authenticateUser:userData:)]){
                 
             }
         }
         failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON)
         {
             if([self.viewController respondsToSelector:@selector(authenticateUser:userData:)]){
                 [_viewController authenticateUser:0 userData:nil];
             }
         }];
        [operation start];
     }
}

@end
