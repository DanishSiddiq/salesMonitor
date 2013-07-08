//
//  AdvanceReportViewController_iPhone.m
//  salesmonitor
//
//  Created by goodcore2 on 6/17/13.
//  Copyright (c) 2013 GoodCore. All rights reserved.
//

#import "AdvanceReportViewController_iPhone.h"

@interface AdvanceReportViewController_iPhone ()

// nav bar item at right in previous view
@property (strong, nonatomic) UIView *navBarContainer;

@property (nonatomic, strong) UIWebView *wvReport;

@end

@implementation AdvanceReportViewController_iPhone

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
    
    [self initializeViews];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void) initializeViews {
    
    [self customizeNavigationBar];
    [self initializeMainView];
    [self initializeWebViewReport ];
}

- (void) customizeNavigationBar{
    
    // icons in navigation bar
    _navBarContainer = [[UIView alloc] initWithFrame:CGRectMake(10, 10, [UIScreen mainScreen].bounds.size.width-10, 67)];
    [_navBarContainer setBackgroundColor:[UIColor clearColor]];
    
    UIImageView *imgViewBackGround = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width-10, 67)];
    [imgViewBackGround setContentMode:UIViewContentModeScaleAspectFill];
    [imgViewBackGround setClipsToBounds:YES];
    [imgViewBackGround setImage:[UIImage imageNamed:@"topBarBg"]];
    [imgViewBackGround setTag:10];
    
    UIImageView *imgViewLogo = [[UIImageView alloc] initWithFrame:CGRectMake(90, 0, 267, 63)];
    [imgViewLogo setContentMode:UIViewContentModeScaleAspectFill];
    [imgViewLogo setClipsToBounds:YES];
    [imgViewLogo setImage:[UIImage imageNamed:@"barLogo"]];
    [imgViewLogo setTag:20];
    
    UIButton *btnNavBarBack = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 84, 67)];
    [btnNavBarBack setImage:[UIImage imageNamed:@"backBtn"] forState:UIControlStateNormal];
    btnNavBarBack.imageView.contentMode = UIViewContentModeScaleToFill;
    [btnNavBarBack addTarget:self action:@selector(btnPressedNavBarBack:) forControlEvents:UIControlEventTouchUpInside];
    
    [_navBarContainer addSubview:imgViewBackGround];
    [_navBarContainer addSubview:imgViewLogo];
    [_navBarContainer addSubview:btnNavBarBack];
    [self.view addSubview:_navBarContainer];
    
}

- (void) initializeMainView {
    
    [self.view setFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
}

- (void) initializeWebViewReport{
    
    _wvReport = [[UIWebView alloc] initWithFrame:CGRectMake(10
                                                            , 87
                                                            , [UIScreen mainScreen].bounds.size.width - 10
                                                            , [UIScreen mainScreen].bounds.size.height - 117)];
    [_wvReport setBackgroundColor:[UIColor clearColor]];
    _wvReport.delegate = self;
    [self.view addSubview:_wvReport];
    
    NSURL *url = [[NSURL alloc] initWithString:KEY_SERVER_URL_REPORT_ADVANCE];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [_wvReport loadRequest:request];
}


// selectors
- (void) btnPressedNavBarBack : (UIButton *) sender{
    
    [self.navigationController popViewControllerAnimated:YES];
}

@end
