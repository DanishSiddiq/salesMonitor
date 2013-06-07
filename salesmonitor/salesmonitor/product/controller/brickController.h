//
//  brickController.h
//  salesmonitor
//
//  Created by goodcore2 on 6/6/13.
//  Copyright (c) 2013 GoodCore. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <QuartzCore/QuartzCore.h>
#import <MapKit/MapKit.h>
#import "applicationConstants.h"
#import "CustomAnnotation.h"


@protocol brickControllerDelegate <NSObject>
@required
-(void)brickSelected:(NSMutableDictionary *) brick;
@end

@interface brickController : NSObject <MKMapViewDelegate, UIGestureRecognizerDelegate>

- (id) init : (BOOL) isIphone
  loadBrick :(NSMutableArray *) loadBrick
  viewController : (id<brickControllerDelegate>)viewController;

@end
