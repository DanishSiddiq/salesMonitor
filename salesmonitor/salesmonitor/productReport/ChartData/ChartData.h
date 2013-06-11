//
//  ChartData.h
//  salesmonitor
//
//  Created by goodcore2 on 6/11/13.
//  Copyright (c) 2013 GoodCore. All rights reserved.
//

#import <Foundation/Foundation.h>

// class for the chart attributes
@interface ChartData :  NSObject{
    NSString *_label;
    NSString *_value;
    NSString *_color;
    NSString *_labelColor;
}

@property(nonatomic, strong) NSString *label;
@property(nonatomic, strong) NSString *value;
@property(nonatomic, strong) NSString *color;
@property(nonatomic, strong) NSString *labelColor;

- (id)initWithName:(NSString *)label value:(NSString *)value color:(NSString *)color labelColor:(NSString *)labelColor;

@end