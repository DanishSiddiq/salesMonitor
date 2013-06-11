//
//  ChartData.m
//  salesmonitor
//
//  Created by goodcore2 on 6/11/13.
//  Copyright (c) 2013 GoodCore. All rights reserved.
//

#import "ChartData.h"

@implementation ChartData

@synthesize label = _label;
@synthesize value = _value;
@synthesize color = _color;
@synthesize labelColor = _labelColor;

-(id)initWithName:(NSString *)label value:(NSString *)value color:(NSString *)color labelColor:(NSString *)labelColor{
    if ((self = [super init])) {
        self.label = label;
        self.value = value;
        self.color = color;
        self.labelColor = labelColor;
    }
    return self;
}

- (void) dealloc {
    self.label = nil;
    self.value = nil;
    self.color = nil;
    self.labelColor = nil;
}

@end
