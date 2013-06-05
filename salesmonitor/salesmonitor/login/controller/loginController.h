//
//  loginController.h
//  salesmonitor
//
//  Created by goodcore2 on 6/4/13.
//  Copyright (c) 2013 GoodCore. All rights reserved.
//

#import <Foundation/Foundation.h>

// thrif party
#import "AFNetworking.h"

#import "applicationConstants.h"
#import "AppDelegate.h"

@protocol loginControllerDelegate <NSObject>

// after selection of already activated bot
- (void) authenticateUser : (NSInteger)responseCode;

@end

@interface loginController : NSObject

-(id) init : (id) viewController salesMonitorDelegate : (AppDelegate *)salesMonitorDelegate;

// call server for authenticating user
- (void) authenticateUserAtServer : (NSString *) email pass : (NSString *) pass;

@end
