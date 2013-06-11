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
#import "ProductReportController.h"
#import "GDataXMLNode.h"
#import "BarChartView.h"
#import "ChartData.h"


@interface ProductReportViewController_iPad : UIViewController <ProductReportDelegate>

- (id)initWithNibName:(NSString *)nibNameOrNil
               bundle:(NSBundle *)nibBundleOrNil
salesMonitorDelegate : (AppDelegate *) salesMonitorDelegate
     productSelected : (NSMutableDictionary *)productSelected
      navBarContainer: (UIView *) navBarContainer;


- (IBAction)btnFromPressed:(id)sender;
- (IBAction)btnToPressed:(id)sender;
- (IBAction)btnPressedReport:(id)sender;

@end