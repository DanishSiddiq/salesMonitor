//
//  loginViewController_iPad.m
//  salesmonitor
//
//  Created by goodcore2 on 6/4/13.
//  Copyright (c) 2013 GoodCore. All rights reserved.
//

#import "loginViewController_iPad.h"

@interface loginViewController_iPad ()

@property (nonatomic, strong) loginController *loginController;

@end

@implementation loginViewController_iPad

@synthesize txtEmail, txtPassword;
@synthesize loginController;

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

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


// controller related methods
-(void) initializeController{
    
    self.loginController = [[loginController alloc] init];
}

- (void) authenticateUser : (NSInteger)responseCode  userData:(NSMutableDictionary *) userData{
    
    // 0 in application means no error
    if(responseCode == 0){
        [self.navigationController pushViewController:[[productViewController_iPad alloc]
                                                       initWithNibName:@"productViewController_iPad" bundle:nil] animated:YES];
    }
    else{
        
        // show error message from global file
    }
}


// view related methods
- (void) initializeViews {
    
    [self initializeMainView];
    [self customizeTextFields];
}

- (void) initializeMainView {
    [self.view setFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    [self.navigationController setNavigationBarHidden:YES];
}

- (void) customizeTextFields {
    
    txtEmail.keyboardType = UIKeyboardTypeEmailAddress;
    txtPassword.secureTextEntry = YES;
}

// button selectors
- (IBAction)btnPressedLogin:(id)sender {
    
    [self.loginController authenticateUserAtServer:txtEmail.text pass:txtPassword.text];
}


@end
