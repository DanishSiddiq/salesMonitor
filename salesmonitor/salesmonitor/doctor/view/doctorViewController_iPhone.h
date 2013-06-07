//
//  doctorViewController_iPhone.h
//  salesmonitor
//
//  Created by goodcore2 on 6/6/13.
//  Copyright (c) 2013 GoodCore. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "DoctorController.h"

@interface doctorViewController_iPhone : UIViewController <UITableViewDelegate, UITableViewDataSource, DoctorControllerDelegate >


- (id)initWithNibName:(NSString *)nibNameOrNil
               bundle:(NSBundle *)nibBundleOrNil
salesMonitorDelegate : (AppDelegate *) salesMonitorDelegate
      navBarContainer: (UIView *) navBarContainer;

@end
