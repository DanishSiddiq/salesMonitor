//
//  productController.h
//  salesmonitor
//
//  Created by goodcore2 on 6/5/13.
//  Copyright (c) 2013 GoodCore. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <QuartzCore/QuartzCore.h>
#import "applicationConstants.h"
#import "UIImageView+WebCache.h"


@protocol productControllerDelegate <NSObject>
@required
    -(void)productSelected:(NSMutableDictionary *) product;
@end

@interface productController : NSObject <UITableViewDataSource, UITableViewDelegate>


// constructor
- (id)      init : (BOOL) isIphone
     loadProduct :(NSMutableArray *) loadProduct
  viewController : (id<productControllerDelegate>)viewController;


@end
