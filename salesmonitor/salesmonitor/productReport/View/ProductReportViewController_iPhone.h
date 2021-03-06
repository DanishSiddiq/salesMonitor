//
//  ProductReportViewController_iPhone.h
//  salesmonitor
//
//  Created by goodcore2 on 6/6/13.
//  Copyright (c) 2013 GoodCore. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "ActionSheetDatePicker.h"
#import "ProductReportController.h"

@interface ProductReportViewController_iPhone : UIViewController <ProductReportDelegate>

- (id)initWithNibName:(NSString *)nibNameOrNil
               bundle:(NSBundle *)nibBundleOrNil
salesMonitorDelegate : (AppDelegate *) salesMonitorDelegate
     productSelected : (NSMutableDictionary *)productSelected
      navBarContainer: (UIView *) navBarContainer;


- (IBAction)tbnFromPressed:(id)sender;
- (IBAction)btnToPressed:(id)sender;
- (IBAction)btnPressedReport:(id)sender;


@end
