//
//  productViewController_iPhone.h
//  salesmonitor
//
//  Created by goodcore2 on 6/4/13.
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


@interface productViewController_iPhone : UIViewController <productControllerDelegate>


// custom constructor
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil salesMonitorDelegate : (AppDelegate *) salesMonitorDelegate;


// protocol implementation
-(void)productSelected:(NSMutableDictionary *) product;

@end
