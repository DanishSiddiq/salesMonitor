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
#import "applicationConstants.h"

@protocol DoctorControllerDelegate <NSObject>
@required
    -(void)doctorEdit:(NSMutableDictionary *) doctor;
    -(void)doctorDelete:(NSMutableDictionary *) doctor;
    -(void)doctorView:(NSMutableDictionary *) doctor;
    -(void) doctorMessage : (NSMutableDictionary *) doctor;
    -(void) doctorCall : (NSMutableDictionary *) doctor;
    -(void) doctorMail : (NSMutableDictionary *) doctor;

@end

@interface DoctorController : NSObject <UITableViewDataSource, UITableViewDelegate>


- (id)      init : (BOOL) isIphone
      loadDoctor :(NSMutableArray *) loadDoctor
  viewController : (id<DoctorControllerDelegate>)viewController;

@end
