//
//  DoctorController.h
//  salesmonitor
//
//  Created by goodcore2 on 6/7/13.
//  Copyright (c) 2013 GoodCore. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <QuartzCore/QuartzCore.h>
#import "Custombutton.h"
#import "AFNetworking.h"
#import "SVProgressHUD.h"
#import "applicationConstants.h"
#import "AppDelegate.h"

@protocol DoctorControllerDelegate <NSObject>
@required
-(void)doctorSelected:(NSInteger) selectedIndex;
-(void)doctorAdd : (BOOL) isSuccess msg : (NSString *)msg;
-(void)doctorUpdate : (BOOL) isSuccess msg : (NSString *)msg;
@end

@interface DoctorController : NSObject <UITableViewDataSource, UITableViewDelegate>


- (id)      init : (BOOL) isIphone
      loadDoctor :(NSMutableArray *) loadDoctor
    salesMonitorDelegate : (AppDelegate *)salesMonitorDelegate
  viewController : (id<DoctorControllerDelegate>)viewController;

- (void) add : (NSMutableDictionary *) doctor;
- (void) update : (NSMutableDictionary *) doctor _id : (NSString *) _id;

@end
