//
//  productViewController_iPhone.m
//  salesmonitor
//
//  Created by goodcore2 on 6/4/13.
//  Copyright (c) 2013 GoodCore. All rights reserved.
//

#import "productViewController_iPhone.h"

@interface productViewController_iPhone ()

@property (strong, nonatomic) UIView *navBarContainer;
@property (nonatomic, strong) productController *productController;
@property (nonatomic, strong) AppDelegate *salesMonitorDelegate;
@property (nonatomic, strong) UITableView *tblProduct;
@property (nonatomic, strong) NSMutableArray *loadData;
@property (nonatomic, strong) NSTimer *timerProductList;

@property (nonatomic) BOOL isIphone;


@property (nonatomic) NSInteger indexData;

@end

@implementation productViewController_iPhone

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil salesMonitorDelegate : (AppDelegate *) salesMonitorDelegate
{
    self = [self initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        _salesMonitorDelegate   = salesMonitorDelegate;
        _isIphone                = YES;
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

- (void) viewWillAppear:(BOOL)animated{

    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:NO ];
}

- (void) viewDidAppear:(BOOL)animated {
    
    [super viewDidAppear:animated];
    
    [self updateTable];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


// view related methods

- (void) customizeNavigationBar {
    
    _navBarContainer = [[UIView alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width - 45, 0, 45, 45)];
    [_navBarContainer setBackgroundColor:[UIColor clearColor]];
    
    UIButton *btnListView = [[UIButton alloc] initWithFrame:CGRectMake(10, 10, 22, 22)];
    [btnListView setBackgroundImage:[UIImage imageNamed:@"icon-list.png"] forState:UIControlStateNormal & UIControlStateSelected];
    [btnListView addTarget:self action:@selector(btnNavBarPressedSwitchView) forControlEvents:UIControlEventTouchUpInside];
    [btnListView setTag:10];
    
    UIButton *btnMapView = [[UIButton alloc] initWithFrame:CGRectMake(10, 10, 22, 22)];
    [btnMapView setBackgroundImage:[UIImage imageNamed:@"icon-map.png"] forState:UIControlStateNormal & UIControlStateSelected];
    [btnMapView addTarget:self action:@selector(btnNavBarPressedSwitchView) forControlEvents:UIControlEventTouchUpInside];
    [btnMapView setHidden:YES];
    [btnMapView setTag:20];
    
    [_navBarContainer addSubview:btnListView];
    [_navBarContainer addSubview:btnMapView];
    
    [self.navigationController.navigationBar addSubview:_navBarContainer];

    self.navigationItem.leftBarButtonItem = nil;
    self.navigationItem.hidesBackButton = YES;
}

- (void) initializeData {
    
    // device orientation
    _isIphone = ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone);
    _loadData = [[NSMutableArray alloc] init];
    _indexData = 0;
    
    // for common functionlity
    _productController = [[productController alloc] init:_isIphone loadData:_loadData];

}

- (void) initializeViews {
    
    [self customizeNavigationBar ];
    [self initialzieViewProductTable];
    
}

- (void) initialzieViewProductTable{
    
    _tblProduct = [[UITableView alloc] initWithFrame:CGRectMake(0
                                                                , 0
                                                                , [UIScreen mainScreen].bounds.size.width,
                                                                [UIScreen mainScreen].bounds.size.height - 45)];
    
    [_tblProduct setDataSource:_productController];
    [_tblProduct setDelegate:_productController];
    [self.view addSubview:_tblProduct];
}


- (void) updateTable {
    
    [_loadData removeAllObjects];
    [_tblProduct reloadData];
    _timerProductList = [NSTimer scheduledTimerWithTimeInterval:0.1f target:self selector:@selector(performTableUpdates:)
                                                     userInfo:nil
                                                      repeats:YES];
    
}
-(void)performTableUpdates:(NSTimer*)timer
{
    
    [self.view setUserInteractionEnabled:NO];
    
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:_indexData inSection:0];
    
    if(_indexData < [[[_salesMonitorDelegate userData] valueForKeyPath:KEY_PATH_PRODUCT_BUSINESS] count])
    {
        
        [_loadData addObject:[[[_salesMonitorDelegate userData] valueForKeyPath:KEY_PATH_PRODUCT_BUSINESS] objectAtIndex:_indexData]];
        [_tblProduct beginUpdates];
        [_tblProduct insertRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationLeft];
        [_tblProduct endUpdates];
        
        if( [[[_salesMonitorDelegate userData] valueForKeyPath:KEY_PATH_PRODUCT_BUSINESS] count] - _indexData == 1 )
        {
            _indexData = 0;
            [_timerProductList invalidate];
            _timerProductList = nil;
            [self.view setUserInteractionEnabled:YES];
        }
        else{
            _indexData++;
        }
    }
    else
    {
        _indexData = 0;
        [_timerProductList invalidate];
        _timerProductList = nil;
        [self.view setUserInteractionEnabled:YES];
    }
}

@end
