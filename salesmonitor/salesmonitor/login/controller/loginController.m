//
//  loginController.m
//  salesmonitor
//
//  Created by goodcore2 on 6/4/13.
//  Copyright (c) 2013 GoodCore. All rights reserved.
//

#import "loginController.h"


@interface  loginController()

@property (nonatomic, strong) id<loginControllerDelegate> viewController;
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
        
        SIAlertView *alertView = [[SIAlertView alloc] initWithTitle:@"Network Issue" andMessage:@"Internet not available"];
        [alertView addButtonWithTitle:@"Ok"
                                 type:SIAlertViewButtonTypeDestructive
                              handler:^(SIAlertView *alertView) {
                              }];
        alertView.transitionStyle = SIAlertViewTransitionStyleSlideFromTop;
        [alertView show];
        
    }
    else{
        
        NSMutableDictionary *dictCredential = [[NSMutableDictionary alloc]
                                                    initWithObjectsAndKeys: email, @"username", pass,  @"password"
                                                    , nil];
        
        NSString *urlString = [NSString stringWithFormat:KEY_SERVER_URL_LOGIN];
        NSURL *url = [NSURL URLWithString:urlString];
        
        AFHTTPClient *httpClient = [[AFHTTPClient alloc] initWithBaseURL:url];
        httpClient.parameterEncoding = AFJSONParameterEncoding;
        NSMutableURLRequest *request = [httpClient requestWithMethod:@"POST" path:@"" parameters:dictCredential];
        AFJSONRequestOperation *operation = [AFJSONRequestOperation
                                             JSONRequestOperationWithRequest:request
                                             success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
                                                 
                                                 [SVProgressHUD dismiss];
                                                 
                                                 if([_viewController respondsToSelector:@selector(authenticateUser:msg:)]){
                                                     [self populateData:JSON];
                                                     [_viewController authenticateUser:0 msg:@"Success"];
                                                 }
                                             }
                                             failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
                                                 
                                                 [SVProgressHUD dismiss];
                                                 NSLog(@"ERROR saving publish message to server: %@", error);
                                                 
                                                 if([self.viewController respondsToSelector:@selector(authenticateUser:msg:)]){
                                                     [_viewController authenticateUser:1 msg:[JSON valueForKey:KEY_ERROR]];
                                                 }
                                             }];
        
            
        operation.JSONReadingOptions = NSJSONReadingMutableContainers | NSJSONReadingMutableLeaves;
        [operation start];
        [SVProgressHUD showWithStatus:@"Signing" maskType:SVProgressHUDMaskTypeClear];
     }
}


- (void) populateData : (NSDictionary *) userData {
    
    [_salesMonitorDelegate setIsLoadingFirstTime:YES];
    [[_salesMonitorDelegate userData] removeAllObjects];
    [[_salesMonitorDelegate userData] addEntriesFromDictionary:userData];
}

@end
