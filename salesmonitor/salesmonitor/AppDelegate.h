//
//  AppDelegate.h
//  salesmonitor
//
//  Created by goodcore2 on 6/4/13.
//  Copyright (c) 2013 GoodCore. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "Reachability.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

// reachabaility
@property (nonatomic, retain) Reachability *hostReach;
@property (nonatomic) BOOL isNetworkAvailable;

@end
