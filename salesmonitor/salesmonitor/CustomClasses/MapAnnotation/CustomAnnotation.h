//
//  CustomAnnotation.h
//  ATMNavigator
//
//  Created by goodcore2 on 5/7/13.
//  Copyright (c) 2013 Postnik. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface CustomAnnotation : NSObject <MKAnnotation>


@property (nonatomic, copy) NSString *title, *subtitle;
@property (nonatomic, assign) CLLocationCoordinate2D coordinate;

@property (nonatomic) NSInteger tag;

@end
