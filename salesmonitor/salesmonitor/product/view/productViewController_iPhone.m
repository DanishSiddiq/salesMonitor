//
//  productViewController_iPhone.m
//  salesmonitor
//
//  Created by goodcore2 on 6/4/13.
//  Copyright (c) 2013 GoodCore. All rights reserved.
//

#import "productViewController_iPhone.h"

@interface productViewController_iPhone ()

@property (nonatomic) BOOL isIphone;
@property (nonatomic, strong) AppDelegate *salesMonitorDelegate;

@property (strong, nonatomic) IBOutlet UIImageView *imgViewBg;

@property (strong, nonatomic) UIView *navBarContainer;
@property (strong, nonatomic) UIView *viewContainer;

@property (strong, nonatomic) MKMapView  *mapBrick;
@property (nonatomic, strong) brickController *brickController;
@property (nonatomic, strong) NSMutableArray *loadBrick;
@property (nonatomic, strong) brickProductController *brickProductController;

@property (nonatomic, strong) UITableView *tblProduct;
@property (nonatomic, strong) productController *productController;
@property (nonatomic, strong) NSMutableArray *loadProduct;
@property (nonatomic, strong) NSTimer *timerProductList;
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
    [_navBarContainer setHidden:NO];
}

- (void) viewDidAppear:(BOOL)animated {
    
    [super viewDidAppear:animated];
    
    if([_salesMonitorDelegate isLoadingFirstTime]){
        
        [self updateTable];
        [_salesMonitorDelegate setIsLoadingFirstTime:NO];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


// view related methods
- (void) initializeData {
    
    // device orientation
    _indexData = 0;
    _isIphone = ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone);
    _loadProduct = [[NSMutableArray alloc] init];
    _loadBrick = [[NSMutableArray alloc] init];
    
    // for common functionlity
    _productController = [[productController alloc] init:_isIphone loadProduct:_loadProduct viewController:self];
    _brickController = [[brickController alloc] init:_isIphone loadBrick:_loadBrick viewController:self];
    _brickProductController = [[brickProductController alloc] init:_isIphone];

}

- (void) initializeViews {
    
    [self customizeNavigationBar ];
    [self initializeMainView];
    [self initializeViewContainer];
    [self initializeMapBrick];
    [self initialzieViewProductTable];
    
}

- (void) customizeNavigationBar {
    
    _navBarContainer = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 45)];
    [_navBarContainer setBackgroundColor:[UIColor clearColor]];
    [_navBarContainer setTag:1000];
    
    UIButton *btnNavBarDoctorList = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 80, 45)];
    [btnNavBarDoctorList setBackgroundImage:[UIImage imageNamed:@"iphonebarIcon1"] forState:UIControlStateNormal];
    [btnNavBarDoctorList setBackgroundImage:[UIImage imageNamed:@"iphonebarIcon1Selected"] forState:UIControlStateSelected];
    [btnNavBarDoctorList addTarget:self action:@selector(btnPressedNavBarDoctorList:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *btnNavBarAdvanceReport = [[UIButton alloc] initWithFrame:CGRectMake(80, 0, 80, 45)];
    [btnNavBarAdvanceReport setBackgroundImage:[UIImage imageNamed:@"iphonebarIcon2"] forState:UIControlStateNormal];
    [btnNavBarAdvanceReport setBackgroundImage:[UIImage imageNamed:@"iphonebarIcon2Selected"] forState:UIControlStateSelected];
    [btnNavBarAdvanceReport addTarget:self action:@selector(btnPressedNavBarAdvanceReports:) forControlEvents:UIControlEventTouchUpInside];
    
    UIView *btnSwitchContainer = [[UIView alloc] initWithFrame:CGRectMake(160, 0, 80, 45)];
    
    UIButton *btnNavBarListView = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 80, 45)];
    [btnNavBarListView setBackgroundImage:[UIImage imageNamed:@"iphonebarIcon6"] forState:UIControlStateNormal];
    [btnNavBarListView setBackgroundImage:[UIImage imageNamed:@"iphonebarIcon6Selected"] forState:UIControlStateSelected];
    [btnNavBarListView addTarget:self action:@selector(btnPressedNavBarSwitchView:) forControlEvents:UIControlEventTouchUpInside];
    [btnNavBarListView setHidden:YES];
    [btnNavBarListView setTag:10];
    
    UIButton *btnNavBarMapView = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 80, 45)];
    [btnNavBarMapView setBackgroundImage:[UIImage imageNamed:@"iphonebarIcon3"] forState:UIControlStateNormal];
    [btnNavBarMapView setBackgroundImage:[UIImage imageNamed:@"iphonebarIcon3Selected"] forState:UIControlStateSelected];
    [btnNavBarMapView addTarget:self action:@selector(btnPressedNavBarSwitchView:) forControlEvents:UIControlEventTouchUpInside];
    [btnNavBarMapView setTag:20];
    
    [btnSwitchContainer addSubview:btnNavBarListView];
    [btnSwitchContainer addSubview:btnNavBarMapView];
    
    UIButton *btnNavBarLogout = [[UIButton alloc] initWithFrame:CGRectMake(240, 0, 80, 45)];
    [btnNavBarLogout setBackgroundImage:[UIImage imageNamed:@"iphonebarIcon4"] forState:UIControlStateNormal];
    [btnNavBarLogout setBackgroundImage:[UIImage imageNamed:@"iphonebarIcon4Selected"] forState:UIControlStateSelected];
    [btnNavBarLogout addTarget:self action:@selector(btnPressedNavBarLogout:) forControlEvents:UIControlEventTouchUpInside];
    
    
    [_navBarContainer addSubview:btnNavBarDoctorList];
    [_navBarContainer addSubview:btnNavBarAdvanceReport];
    [_navBarContainer addSubview:btnSwitchContainer];
    [_navBarContainer addSubview:btnNavBarLogout];
    
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"iphonetopBarBg"] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar addSubview:_navBarContainer];
    
    self.navigationItem.leftBarButtonItem = nil;
    self.navigationItem.hidesBackButton = YES;
}

- (void) initializeMainView {
    [self.view setFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    [_imgViewBg setFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
}

- (void) initializeViewContainer {
    
    _viewContainer = [[UIView alloc] initWithFrame:CGRectMake(0
                                                              , 0
                                                              , [UIScreen mainScreen].bounds.size.width
                                                              , [UIScreen mainScreen].bounds.size.height-45)];
    [_viewContainer setBackgroundColor:[UIColor clearColor]];
    [self.view addSubview:_viewContainer];
}

- (void) initializeMapBrick {
    
    _mapBrick = [[MKMapView alloc] initWithFrame:CGRectMake(0
                                                            , 0
                                                            , [UIScreen mainScreen].bounds.size.width
                                                            , [UIScreen mainScreen].bounds.size.height-45)];
    [_mapBrick showsUserLocation];
    _mapBrick.delegate = _brickController;
    
    [_mapBrick setHidden:YES];
    [_viewContainer addSubview:_mapBrick];
}

- (void) initialzieViewProductTable{
    
    _tblProduct = [[UITableView alloc] initWithFrame:CGRectMake(0
                                                                , 0
                                                                , [UIScreen mainScreen].bounds.size.width,
                                                                [UIScreen mainScreen].bounds.size.height - 45)];
    
    [_tblProduct setShowsHorizontalScrollIndicator:NO];
    [_tblProduct setShowsVerticalScrollIndicator:NO];
    [_tblProduct setSeparatorColor:[UIColor clearColor]];
    [_tblProduct setBackgroundColor:[UIColor clearColor]];
    
    [_tblProduct setDataSource:_productController];
    [_tblProduct setDelegate:_productController];
    [_viewContainer addSubview:_tblProduct];
}

- (void) updateTable {
    
    [_loadProduct removeAllObjects];
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
        
        [_loadProduct addObject:[[[_salesMonitorDelegate userData] valueForKeyPath:KEY_PATH_PRODUCT_BUSINESS] objectAtIndex:_indexData]];
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


// selectors
- (void) btnPressedNavBarDoctorList : (UIButton *) sender{
    
        
    doctorViewController_iPhone *doctorViewController = [[doctorViewController_iPhone alloc]
                                                            initWithNibName:@"doctorViewController_iPhone"
                                                            bundle:nil
                                                            salesMonitorDelegate:_salesMonitorDelegate
                                                            navBarContainer:_navBarContainer];
    [self.navigationController pushViewController:doctorViewController animated:YES];
    
}

- (void) btnPressedNavBarAdvanceReports : (UIButton *) sender {
    
    [self productSelected:nil];    
}

- (void) btnPressedNavBarSwitchView : (UIButton *) sender {
    
    UIView *btnSwitchContainer = [sender superview];
    
    if([_mapBrick isHidden]){
        
        [self updateMapView];
        
        [UIView transitionWithView:btnSwitchContainer duration:1.0 options:UIViewAnimationOptionTransitionFlipFromLeft
                        animations:^{
                            [[btnSwitchContainer viewWithTag:10] setHidden:NO];
                            [[btnSwitchContainer viewWithTag:20] setHidden:YES];
                            
                        } completion:^(BOOL finished) {
                            if(finished){
                            }
                        }];
        
        [UIView transitionWithView:_viewContainer duration:1.0 options:UIViewAnimationOptionTransitionFlipFromLeft
                        animations:^{
                            [_tblProduct setHidden:YES];
                            [_mapBrick setHidden:NO];
                            
                        } completion:^(BOOL finished) {
                            if(finished){
                            }
                        }];
        
    }
    else{
        
        [UIView transitionWithView:btnSwitchContainer duration:1.0 options:UIViewAnimationOptionTransitionFlipFromRight
                        animations:^{
                            [[btnSwitchContainer viewWithTag:10] setHidden:YES];
                            [[btnSwitchContainer viewWithTag:20] setHidden:NO];
                            
                        } completion:^(BOOL finished) {
                            if(finished){
                            }
                        }];
        
        
        [UIView transitionWithView:_viewContainer duration:1.0 options:UIViewAnimationOptionTransitionFlipFromRight
                        animations:^{
                            [_mapBrick setHidden:YES];
                            [_tblProduct setHidden:NO ];
                            
                        } completion:^(BOOL finished) {
                        }];
    }
}

- (void) btnPressedNavBarLogout : (UIButton *) sender{
    
    [[_salesMonitorDelegate userData] removeAllObjects];
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void) updateMapView {
    
    // first remove obselete annotations
    NSMutableArray *toRemove = [NSMutableArray arrayWithCapacity:10];
    for (id annotation in _mapBrick.annotations){
        if (annotation != _mapBrick.userLocation){
            [toRemove addObject:annotation];
        }
    }
    [_mapBrick removeAnnotations:toRemove];
    
    // remove all previous objects
    [_loadBrick removeAllObjects];
    [_loadBrick addObjectsFromArray:[[_salesMonitorDelegate userData] valueForKey:KEY_BRICKS]];
    
    NSInteger rowIndex = 0;
    for (NSMutableDictionary *brickInfo in _loadBrick) {
        
        if([[brickInfo valueForKey:KEY_BRICKS_LOCATION] valueForKey:KEY_BRICKS_LOCATION_LAT]
           && [[brickInfo valueForKey:KEY_BRICKS_LOCATION] valueForKey:KEY_BRICKS_LOCATION_LONG]){
            
            CustomAnnotation *annotation = [CustomAnnotation new];
            annotation.coordinate = (CLLocationCoordinate2D){
                [[brickInfo valueForKeyPath:KEY_PATH_BRICKS_LOCATION_LAT] doubleValue]
                ,   [[brickInfo valueForKeyPath:KEY_PATH_BRICKS_LOCATION_LONG] doubleValue]};
            
            [annotation setTitle:[brickInfo valueForKey:KEY_BRICKS_NAME]];
            [annotation setSubtitle:[brickInfo valueForKey:KEY_BRICKS_DISTRIBUTOR_NAME]];
            [annotation setTag:rowIndex];
            [_mapBrick addAnnotation:annotation];
        }
        
        // keep refernce to stream item
        rowIndex++;
    }
    
    ZoomedMapView *zoomMap = [[ZoomedMapView alloc] init];
    [zoomMap zoomMapViewToFitAnnotations:_mapBrick animated:NO];
}


// protocol methods
-(void) productSelected:(NSMutableDictionary *) productSelected{
    
        
    ProductReportViewController_iPhone *productReport = [[ProductReportViewController_iPhone alloc]
                                                             initWithNibName:@"ProductReportViewController_iPhone"
                                                             bundle:nil
                                                             salesMonitorDelegate:_salesMonitorDelegate
                                                             productSelected:productSelected
                                                             navBarContainer:_navBarContainer];
        
    [self.navigationController pushViewController:productReport animated:YES];
}


-(void)brickSelected:(NSMutableDictionary *) brick{
    
    // setting product in controller
    [_brickProductController setLoadProduct:[brick valueForKey:KEY_BRICKS_SALES]];
    
    UITableView *tblBrickProduct = [[UITableView alloc] initWithFrame:CGRectMake(15
                                                                                 , 0
                                                                                 , [UIScreen mainScreen].bounds.size.width - 30
                                                                                 , [[brick valueForKey:KEY_BRICKS_SALES] count]*50)];
    
    tblBrickProduct.delegate = _brickProductController;
    tblBrickProduct.dataSource = _brickProductController;
    tblBrickProduct.bounces = NO;
    [tblBrickProduct setShowsVerticalScrollIndicator:NO];
    [tblBrickProduct setShowsHorizontalScrollIndicator:NO];
    
    [[KGModal sharedInstance] showWithContentView:tblBrickProduct andAnimated:YES];
    
}

@end
