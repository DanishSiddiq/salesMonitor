//
//  CustomImageView.m
//  salesmonitor
//
//  Created by goodcore2 on 7/3/13.
//  Copyright (c) 2013 GoodCore. All rights reserved.
//

#import "CustomImageView.h"

@implementation CustomImageView

@synthesize cacheImagePath;

- (id) init {
    
    self = [super init];
    if (self) {
        // Initialization code
        cacheImagePath = [NSMutableString stringWithFormat:@""];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        cacheImagePath = [NSMutableString stringWithFormat:@""];
        
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
