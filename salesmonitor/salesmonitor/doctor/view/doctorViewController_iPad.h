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
#import "BlockActionSheet.h"
#import "CustomImageView.h"


typedef enum dataOperationTypes {
    add = 1,
    update,
    delete
    } dataOperation;


@interface doctorViewController_iPad : UIViewController < UITableViewDelegate
                                                            , UITableViewDataSource
                                                            , MFMailComposeViewControllerDelegate
                                                            , MFMessageComposeViewControllerDelegate
                                                            , UITextFieldDelegate
                                                            , UITextViewDelegate
                                                            , UINavigationControllerDelegate
                                                            , UIImagePickerControllerDelegate
, UIPopoverControllerDelegate
, DoctorControllerDelegate>{
    UIPopoverController *popoverController;
}

@property (nonatomic, retain) UIPopoverController *popoverController;

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
