//
//  brickController.m
//  salesmonitor
//
//  Created by goodcore2 on 6/6/13.
//  Copyright (c) 2013 GoodCore. All rights reserved.
//

#import "brickController.h"

@interface brickController ()

@property (nonatomic, strong) id<brickControllerDelegate> viewController;
@property (nonatomic, strong) NSMutableArray *loadBrick;
@property (nonatomic) BOOL isIphone;
    
@end

@implementation brickController


- (id) init : (BOOL) isIphone loadBrick :(NSMutableArray *) loadBrick   viewController : (id<brickControllerDelegate>)viewController{
    
    self = [super init];
    
    if(self){
        _loadBrick = loadBrick;
        _isIphone = isIphone;
        _viewController = viewController;
    }
    
    return self;
}


////////////////////// MAP View Delegate
- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation {
    
    if([annotation isKindOfClass:[MKUserLocation class]]){
        return nil;
    }
    else if([annotation isKindOfClass:[CustomAnnotation class]]){
        static NSString *annotIdentifier = @"annot";
        
        MKPinAnnotationView *pin = (MKPinAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:annotIdentifier];
        UIImageView *imgViewBrick;
        UIButton *btnClear;
        
        if (!pin)
        {
            pin = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:annotIdentifier];
            pin.canShowCallout = YES;
            
            imgViewBrick = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 34, 34)];
            [[imgViewBrick layer] setCornerRadius:17];
            [[imgViewBrick layer] setBorderColor:[UIColor grayColor].CGColor];
            [[imgViewBrick layer] setBorderWidth:2];
            [imgViewBrick setContentMode:UIViewContentModeScaleAspectFill];
            [imgViewBrick setClipsToBounds:YES];
            [imgViewBrick setUserInteractionEnabled:YES];
            
            
            btnClear = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 34, 34)];
            [btnClear setBackgroundColor:[UIColor clearColor]];
            [btnClear addTarget:self action:@selector(btnClearPressed:) forControlEvents:UIControlEventTouchUpInside];
            [btnClear setTag:10];
            

            [imgViewBrick addSubview:btnClear];
            [pin setImage:[UIImage imageNamed:@"pin_annotation"]];
        }
        else
        {
            pin.annotation = annotation;
            imgViewBrick =  (UIImageView *)[pin leftCalloutAccessoryView];
            btnClear = (UIButton *)[imgViewBrick viewWithTag:10];
        }
        
        imgViewBrick.tag = [(CustomAnnotation *)annotation tag];
        [imgViewBrick setImage:[UIImage imageNamed:@"distributor"]];
        pin.leftCalloutAccessoryView  = imgViewBrick;
        
        return pin;
    }
    else{
        return nil;
    }
}

- (void)btnClearPressed:(UIButton *)sender{
    
    UIImageView *imgView = (UIImageView *)[sender superview];
    NSMutableDictionary *brickSelected = [_loadBrick objectAtIndex:[imgView tag]];
    
    if([_viewController respondsToSelector:@selector(brickSelected:)]){
        [_viewController brickSelected:brickSelected];
    }
}

@end
