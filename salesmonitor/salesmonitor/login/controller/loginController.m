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
        
        AFJSONRequestOperation *operation = [[AFJSONRequestOperation alloc] initWithRequest:request];
        
        [operation setUploadProgressBlock:^(NSUInteger bytesWritten, long long totalBytesWritten, long long totalBytesExpectedToWrite) {
            NSLog(@"login call start, %lld, %lld",totalBytesWritten, totalBytesExpectedToWrite);
        }];
        
        [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id JSON) {
            [SVProgressHUD dismiss];
            
            if([_viewController respondsToSelector:@selector(authenticateUser:)]){
                [self populateData:JSON];
                [_viewController authenticateUser:0];
            }
        }
        failure:^(AFHTTPRequestOperation *operation, NSError *error) {

            [SVProgressHUD dismiss];
            NSLog(@"ERROR saving publish message to server: %@", error);
            
            if([self.viewController respondsToSelector:@selector(authenticateUser:)]){
                [_viewController authenticateUser:-1];
            }
        }];        
            
        operation.JSONReadingOptions = NSJSONReadingMutableContainers | NSJSONReadingMutableLeaves;
        [operation start];
        [SVProgressHUD showWithStatus:@"Signing" maskType:SVProgressHUDMaskTypeClear];
     }
}


- (void) populateData : (NSDictionary *) userData {
    
    [[_salesMonitorDelegate userData] removeAllObjects];
    [[_salesMonitorDelegate userData] addEntriesFromDictionary:userData];
}

@end
