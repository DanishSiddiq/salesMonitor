//
//  loginViewController_iPhone.m
//  salesmonitor
//
//  Created by goodcore2 on 6/4/13.
//  Copyright (c) 2013 GoodCore. All rights reserved.
//

#import "loginViewController_iPhone.h"

@interface loginViewController_iPhone ()

@property (nonatomic, strong) loginController *loginController;
@property (nonatomic, strong) AppDelegate *salesMonitorDelegate;

@property (nonatomic, strong) IBOutlet UITextField *txtEmail;
@property (nonatomic, strong) IBOutlet UITextField *txtPassword;

- (IBAction)btnPressedLogin:(id)sender;
- (IBAction)btnPressedInfo:(id)sender;

@end

@implementation loginViewController_iPhone

@synthesize txtEmail, txtPassword;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self initializeController];
    [self initializeViews];
}

-(void) viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    [self customizeNavigationBar ];
    [self.navigationController setNavigationBarHidden:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



// controller related methods
-(void) initializeController{
    
    _salesMonitorDelegate = [[UIApplication sharedApplication] delegate];
    self.loginController = [[loginController alloc] init:self salesMonitorDelegate:_salesMonitorDelegate];
}

- (void) authenticateUser : (NSInteger)responseCode msg : (NSString *) msg{
    
    if(responseCode == 0){
        
        [self.navigationController pushViewController:[[productViewController_iPhone alloc]
                                                       initWithNibName:@"productViewController_iPhone"
                                                       bundle:nil
                                                       salesMonitorDelegate:_salesMonitorDelegate]
                                             animated:YES];
    }
    else{
        
        SIAlertView *alertView = [[SIAlertView alloc] initWithTitle:@"Login Failed" andMessage:msg];
        [alertView addButtonWithTitle:@"Ok"
                                 type:SIAlertViewButtonTypeDestructive
                              handler:^(SIAlertView *alertView) {
                              }];
        alertView.transitionStyle = SIAlertViewTransitionStyleSlideFromTop;
        [alertView show];
        
    }
    
}

// view related methods
- (void) initializeViews {
    
    [self initializeMainView];
    [self customizeTextFields];
}

- (void) customizeNavigationBar {
    
    UIView *navBarContainer;
    
    for(UIView *sv in [self.navigationController.navigationBar subviews]){
        if([sv tag] == 1000){
            navBarContainer = sv;
            break;
        }
    }
    
    [navBarContainer removeFromSuperview];
    navBarContainer = nil;
}

- (void) initializeMainView {
    [self.view setFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
}

- (void) customizeTextFields {
    
    txtEmail.keyboardType = UIKeyboardTypeEmailAddress;
    txtPassword.secureTextEntry = YES;
}


// button selectors
- (IBAction)btnPressedLogin:(id)sender {
    
    [self.loginController authenticateUserAtServer:txtEmail.text pass:txtPassword.text];
}

- (IBAction)btnPressedInfo:(id)sender {
    
    // setting product in controller
    UIImageView *imgViewInfo = [[UIImageView alloc] initWithFrame:CGRectMake(30
                                                                             , 60
                                                                             , [UIScreen mainScreen].bounds.size.width - 60
                                                                             , [UIScreen mainScreen].bounds.size.height - 120)];
    [imgViewInfo setImage:[UIImage imageNamed:@"iphone-about"]];
    [[KGModal sharedInstance] showWithContentView:imgViewInfo andAnimated:YES];
}




@end
