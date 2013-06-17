//
//  AdvanceReportViewController_iPhone.m
//  salesmonitor
//
//  Created by goodcore2 on 6/17/13.
//  Copyright (c) 2013 GoodCore. All rights reserved.
//

#import "AdvanceReportViewController_iPhone.h"

@interface AdvanceReportViewController_iPhone ()

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
    
    UIButton *btnNavBarBack = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 45, 30)];
    [btnNavBarBack setImage:[UIImage imageNamed:@"titlebar-back-btn"] forState:UIControlStateNormal];
    btnNavBarBack.imageView.contentMode = UIViewContentModeScaleToFill;
    [btnNavBarBack addTarget:self action:@selector(btnPressedNavBarBack:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btnNavBarBack];
    
}

- (void) initializeMainView {
    
    [self.view setFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
}

- (void) initializeWebViewReport{
    
    _wvReport = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
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
