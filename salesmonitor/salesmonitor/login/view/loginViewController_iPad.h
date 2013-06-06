//
//  loginViewController_iPad.h
//  salesmonitor
//
//  Created by goodcore2 on 6/4/13.
//  Copyright (c) 2013 GoodCore. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "loginController.h"
#import "productViewController_iPhone.h"


@interface loginViewController_iPad : UIViewController <loginControllerDelegate>

@property (nonatomic, strong) IBOutlet UITextField *txtEmail;
@property (nonatomic, strong) IBOutlet UITextField *txtPassword;
- (IBAction)btnPressedLogin:(id)sender;


// protocol implementation
- (void) authenticateUser : (NSInteger)responseCode;

@end
