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
    
    _navBarContainer = [[UIView alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width - 125, 0, 125, 45)];
    [_navBarContainer setBackgroundColor:[UIColor clearColor]];
    
    UIButton *btnDoctorList = [[UIButton alloc] initWithFrame:CGRectMake(0, 10, 22, 22)];
    [btnDoctorList setBackgroundImage:[UIImage imageNamed:@"icon-list.png"] forState:UIControlStateNormal & UIControlStateSelected];
    [btnDoctorList addTarget:self action:@selector(btnNavBarPressedDoctorList:) forControlEvents:UIControlEventTouchUpInside];
    [btnDoctorList setTag:40];
    
    UIButton *btnProductReport = [[UIButton alloc] initWithFrame:CGRectMake(42, 10, 22, 22)];
    [btnProductReport setBackgroundImage:[UIImage imageNamed:@"icon-list.png"] forState:UIControlStateNormal & UIControlStateSelected];
    [btnProductReport addTarget:self action:@selector(btnNavBarPressedProductReport:) forControlEvents:UIControlEventTouchUpInside];
    [btnProductReport setTag:30];
    
    UIButton *btnListView = [[UIButton alloc] initWithFrame:CGRectMake(84, 10, 22, 22)];
    [btnListView setBackgroundImage:[UIImage imageNamed:@"icon-list.png"] forState:UIControlStateNormal & UIControlStateSelected];
    [btnListView addTarget:self action:@selector(btnNavBarPressedSwitchView:) forControlEvents:UIControlEventTouchUpInside];
    [btnListView setHidden:YES];
    [btnListView setTag:10];
    
    UIButton *btnMapView = [[UIButton alloc] initWithFrame:CGRectMake(84, 10, 22, 22)];
    [btnMapView setBackgroundImage:[UIImage imageNamed:@"icon-map.png"] forState:UIControlStateNormal & UIControlStateSelected];
    [btnMapView addTarget:self action:@selector(btnNavBarPressedSwitchView:) forControlEvents:UIControlEventTouchUpInside];
    [btnMapView setTag:20];
    
    [_navBarContainer addSubview:btnDoctorList];
    [_navBarContainer addSubview:btnProductReport];
    [_navBarContainer addSubview:btnListView];
    [_navBarContainer addSubview:btnMapView];
    
    [self.navigationController.navigationBar addSubview:_navBarContainer];
    
    self.navigationItem.leftBarButtonItem = nil;
    self.navigationItem.hidesBackButton = YES;
}

- (void) initializeMainView {
    [self.view setFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
}

- (void) initializeViewContainer {
    
    _viewContainer = [[UIView alloc] initWithFrame:CGRectMake(0
                                                              , 0
                                                              , [UIScreen mainScreen].bounds.size.width
                                                              , [UIScreen mainScreen].bounds.size.height-45)];
    [_viewContainer setBackgroundColor:[UIColor whiteColor]];
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
- (void) btnNavBarPressedDoctorList : (UIButton *) sender{
    
    doctorViewController_iPhone *doctoViewController = [[doctorViewController_iPhone alloc]
                                                        initWithNibName:_isIphone ? @"doctorViewController_iPhone" : @"doctorViewController_iPad"
                                                        bundle:nil
                                                        salesMonitorDelegate:_salesMonitorDelegate
                                                        navBarContainer:_navBarContainer];
    [self.navigationController pushViewController:doctoViewController animated:YES];
    
}

- (void) btnNavBarPressedProductReport : (UIButton *) sender{
    
    [self productSelected:nil];
}

- (void) btnNavBarPressedSwitchView : (UIButton *) sender {
    
    if([_mapBrick isHidden]){
        
        [self updateMapView];
        
        [UIView transitionWithView:_navBarContainer duration:1.0 options:UIViewAnimationOptionTransitionFlipFromLeft
                        animations:^{
                            [[_navBarContainer viewWithTag:10] setHidden:NO];
                            [[_navBarContainer viewWithTag:20] setHidden:YES];
                            
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
        
        [UIView transitionWithView:_navBarContainer duration:1.0 options:UIViewAnimationOptionTransitionFlipFromRight
                        animations:^{
                            [[_navBarContainer viewWithTag:10] setHidden:YES];
                            [[_navBarContainer viewWithTag:20] setHidden:NO];
                            
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
    
    if([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone){
        
        ProductReportViewController_iPhone *productReport = [[ProductReportViewController_iPhone alloc]
                                                             initWithNibName:@"ProductReportViewController_iPhone"
                                                             bundle:nil
                                                             salesMonitorDelegate:_salesMonitorDelegate
                                                             productSelected:productSelected
                                                             navBarContainer:_navBarContainer];
        
        [self.navigationController pushViewController:productReport animated:YES];
    }
    else{
        
        ProductReportViewController_iPad *productReport = [[ProductReportViewController_iPad alloc]
                                                             initWithNibName:@"ProductReportViewController_iPad"
                                                             bundle:nil
                                                           salesMonitorDelegate:_salesMonitorDelegate
                                                           productSelected:productSelected
                                                           navBarContainer:_navBarContainer];
        
        [self.navigationController pushViewController:productReport animated:YES];
    }
}


-(void)brickSelected:(NSMutableDictionary *) brick{
    
    // setting product in controller
    [_brickProductController setLoadProduct:[brick valueForKey:KEY_BRICKS_SALES]];
    
    UITableView *tblBrickProduct = [[UITableView alloc] initWithFrame:CGRectMake(10
                                                                                 , 0
                                                                                 , [UIScreen mainScreen].bounds.size.width - 20
                                                                                 , [[brick valueForKey:KEY_BRICKS_SALES] count]*50)];
    
    tblBrickProduct.delegate = _brickProductController;
    tblBrickProduct.dataSource = _brickProductController;
    tblBrickProduct.bounces = NO;
    [tblBrickProduct setShowsVerticalScrollIndicator:NO];
    [tblBrickProduct setShowsHorizontalScrollIndicator:NO];
    
    [[KGModal sharedInstance] showWithContentView:tblBrickProduct andAnimated:YES];
    
}

@end
