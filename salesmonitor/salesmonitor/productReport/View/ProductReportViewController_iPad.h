//
//  ProductReportViewController_iPad.h
//  salesmonitor
//
//  Created by goodcore2 on 6/6/13.
//  Copyright (c) 2013 GoodCore. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "ActionSheetDatePicker.h"

@interface ProductReportViewController_iPad : UIViewController

- (id)initWithNibName:(NSString *)nibNameOrNil
               bundle:(NSBundle *)nibBundleOrNil
salesMonitorDelegate : (AppDelegate *) salesMonitorDelegate
     productSelected : (NSMutableDictionary *)productSelected;
- (IBAction)btnFromPressed:(id)sender;
- (IBAction)btnToPressed:(id)sender;

@end
