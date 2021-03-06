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
#import "applicationConstants.h"
#import <MessageUI/MessageUI.h>

@interface doctorViewController_iPhone : UIViewController< UITableViewDelegate
                                                            , UITableViewDataSource
                                                            , DoctorControllerDelegate
                                                            , MFMailComposeViewControllerDelegate
                                                            , MFMessageComposeViewControllerDelegate
                                                            , UITextFieldDelegate
                                                            , UITextViewDelegate>


- (id)initWithNibName:(NSString *)nibNameOrNil
               bundle:(NSBundle *)nibBundleOrNil
salesMonitorDelegate : (AppDelegate *) salesMonitorDelegate
      navBarContainer: (UIView *) navBarContainer;


// doctor delegates
-(void)doctorSelected:(NSInteger) selectedIndex;
-(void)doctorAdd : (BOOL) isSuccess msg : (NSString *)msg;
-(void)doctorUpdate : (BOOL) isSuccess msg : (NSString *)msg;
-(void)doctorDelete : (BOOL) isSuccess msg : (NSString *)msg;

@end
