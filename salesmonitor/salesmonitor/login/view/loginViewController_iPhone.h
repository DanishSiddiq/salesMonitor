//
//  loginViewController_iPhone.h
//  salesmonitor
//
//  Created by goodcore2 on 6/4/13.
//  Copyright (c) 2013 GoodCore. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "loginController.h"
#import "productViewController_iPhone.h"


@interface loginViewController_iPhone : UIViewController <loginControllerDelegate>

// protocol implementation
- (void) authenticateUser : (NSInteger)responseCode msg : (NSString *) msg;

@end
