//
//  doctorViewController_iPad.h
//  salesmonitor
//
//  Created by goodcore2 on 6/12/13.
//  Copyright (c) 2013 GoodCore. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "DoctorController.h"
#import "applicationConstants.h"
#import <MessageUI/MessageUI.h>

@interface doctorViewController_iPad : UIViewController < UITableViewDelegate
                                                            , UITableViewDataSource
                                                            , DoctorControllerDelegate
                                                            , MFMailComposeViewControllerDelegate
                                                            , MFMessageComposeViewControllerDelegate  >


- (id)initWithNibName:(NSString *)nibNameOrNil
               bundle:(NSBundle *)nibBundleOrNil
salesMonitorDelegate : (AppDelegate *) salesMonitorDelegate
      navBarContainer: (UIView *) navBarContainer;


// doctor delegates
-(void)doctorSelected:(NSInteger) selectedIndex;


@end
