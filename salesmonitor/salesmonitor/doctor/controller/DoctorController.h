//
//  DoctorController.h
//  salesmonitor
//
//  Created by goodcore2 on 6/7/13.
//  Copyright (c) 2013 GoodCore. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <QuartzCore/QuartzCore.h>

@protocol DoctorControllerDelegate <NSObject>
@required
    -(void)doctorEdit:(NSMutableDictionary *) doctor;
    -(void)doctorDelete:(NSMutableDictionary *) doctor;
    -(void)doctorView:(NSMutableDictionary *) doctor;
@end

@interface DoctorController : NSObject


- (id)      init : (BOOL) isIphone
      loadDoctor :(NSMutableArray *) loadDoctor
  viewController : (id<DoctorControllerDelegate>)viewController;

@end
