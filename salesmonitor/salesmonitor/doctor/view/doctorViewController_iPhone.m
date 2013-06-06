//
//  doctorViewController_iPhone.m
//  salesmonitor
//
//  Created by goodcore2 on 6/6/13.
//  Copyright (c) 2013 GoodCore. All rights reserved.
//

#import "doctorViewController_iPhone.h"

@interface doctorViewController_iPhone ()

@property (nonatomic) BOOL isIphone;
@property (nonatomic, strong) AppDelegate *salesMonitorDelegate;
@property (nonatomic, strong) UITableView *tblDoctor;
@property (nonatomic, strong) NSMutableArray *doctors;

@end

@implementation doctorViewController_iPhone

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (id) initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil salesMonitorDelegate:(AppDelegate *)salesMonitorDelegate{

    self = [self initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    
    if (self) {
        _salesMonitorDelegate   = salesMonitorDelegate;
        _isIphone   = YES;
    }
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self initializeData];
    [self initializeViews];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// view related methods
- (void) initializeData {
    
    _isIphone = ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone);
}

- (void) initializeViews {
    [self customizeNavigationBar];
    [self initializeDoctorTable];
}

- (void) customizeNavigationBar{

}

- (void) initializeMainView {
    
    [self.view setFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
}

- (void) initializeDoctorTable {
    _tblDoctor = [[UITableView alloc] initWithFrame:CGRectMake(0
                                                               , 0
                                                               , [UIScreen mainScreen].bounds.size.width
                                                               , [UIScreen mainScreen].bounds.size.height - 45)];
    
    _tblDoctor.delegate = nil;
    _tblDoctor.dataSource = nil;
    [self.view addSubview:_tblDoctor];
}

@end
