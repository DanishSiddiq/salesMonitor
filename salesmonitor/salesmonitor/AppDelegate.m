//
//  AppDelegate.m
//  salesmonitor
//
//  Created by goodcore2 on 6/4/13.
//  Copyright (c) 2013 GoodCore. All rights reserved.
//

#import "AppDelegate.h"
#import "loginViewController_iPhone.h"
#import "loginViewController_iPad.h"


@interface AppDelegate ()

@property (nonatomic, retain) SIAlertView *alertView;

@end

@implementation AppDelegate

@synthesize hostReach, isNetworkAvailable;
@synthesize userData;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        
        self.window.rootViewController = [[UINavigationController alloc]
                                          initWithRootViewController:[[loginViewController_iPhone alloc]
                                                                      initWithNibName:@"loginViewController_iPhone" bundle:nil]];
        
    } else {
        
        self.window.rootViewController = [[UINavigationController alloc]
                                          initWithRootViewController:[[loginViewController_iPad alloc]
                                                                      initWithNibName:@"loginViewController_iPad" bundle:nil]];
    }
    
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    // all the custom classes require to update the status
    [self initializeCustomClasses];
    
    return YES;
    
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


// Initialization code
- (void) initializeCustomClasses {
    
    // reach ability
    isNetworkAvailable = YES;
    
    // user data
    userData = [[NSMutableDictionary alloc] init];
    
    // custom alert view
    _alertView = [[SIAlertView alloc] initWithTitle:@"" andMessage:@""];
    [_alertView addButtonWithTitle:@"Ok"
                             type:SIAlertViewButtonTypeDestructive
                          handler:^(SIAlertView *alertView) {
                          }];
    
    // reachability
    hostReach = [Reachability reachabilityForInternetConnection];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector: @selector(internetAvailabilityChanged:)
                                                 name:kReachabilityChangedNotification
                                               object: nil];
    [hostReach startNotifier];
    [self internetAvailabilityChanged: self];
    
}

#pragma mark - Reachibility delegate
- (void) internetAvailabilityChanged: (id) sender {
    
    Reachability *connectionMonitor = [Reachability reachabilityForInternetConnection];
    BOOL hasInternet = [connectionMonitor currentReachabilityStatus] != NotReachable;
    
    if (hasInternet){
        
        // if previously network was not connected
        if(!isNetworkAvailable){
            
            _alertView.title = @"Network Connected";
            _alertView.message = @"Internet restored";
            _alertView.transitionStyle = SIAlertViewTransitionStyleSlideFromBottom;
            [_alertView show];
            
            /*double delayInSeconds = 2.0;
            dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
            dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
                
                [_alertView dismissAnimated:YES];
            });*/
        }
    }
    else{
        
        // if previously network was available
        if(isNetworkAvailable){
            
            _alertView.title = @"Network Issue";
            _alertView.message = @"Internet not reachable";
            _alertView.transitionStyle = SIAlertViewTransitionStyleSlideFromBottom;
            [_alertView show];
            
        }
    }
    
    isNetworkAvailable = hasInternet;
}

@end
