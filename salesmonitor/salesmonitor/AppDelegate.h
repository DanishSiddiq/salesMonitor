//
//  AppDelegate.h
//  salesmonitor
//
//  Created by goodcore2 on 6/4/13.
//  Copyright (c) 2013 GoodCore. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "SIAlertView.h"
#import "BlockAlertView.h"
#import "Reachability.h"
#import <QuartzCore/QuartzCore.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (nonatomic) BOOL isLoadingFirstTime;

// reachabaility
@property (nonatomic, retain) Reachability *hostReach;
@property (nonatomic) BOOL isNetworkAvailable;

// user data
@property (nonatomic, strong) NSMutableDictionary *userData;

@end
