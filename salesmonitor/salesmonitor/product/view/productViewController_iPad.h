//
//  productViewController_iPad.h
//  salesmonitor
//
//  Created by goodcore2 on 7/4/13.
//  Copyright (c) 2013 GoodCore. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "applicationConstants.h"
#import "AppDelegate.h"
#import "productController.h"
#import "brickController.h"
#import "ZoomedMapView.h"
#import "CustomAnnotation.h"
#import "ProductReportViewController_iPad.h"
#import "brickProductController.h"
#import "KGModal.h"
#import "doctorViewController_iPad.h"

@interface productViewController_iPad : UIViewController <productControllerDelegate, brickControllerDelegate>


// custom constructor
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil salesMonitorDelegate : (AppDelegate *) salesMonitorDelegate;


// protocol implementation
-(void)productSelected:(NSMutableDictionary *) product;

@end