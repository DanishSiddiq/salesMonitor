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
- (void) initializeData {
    
    // device orientation
    _isIphone = ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone);
    _loadProduct = [[NSMutableArray alloc] init];
    _indexData = 0;
    
    // for common functionlity
    _productController = [[productController alloc] init:_isIphone loadProduct:_loadProduct];

}

- (void) initializeViews {
    
    [self customizeNavigationBar ];
    [self initializeViewContainer];
    [self initializeMapBrick];
    [self initialzieViewProductTable];
    
}

- (void) customizeNavigationBar {
    
    _navBarContainer = [[UIView alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width - 45, 0, 45, 45)];
    [_navBarContainer setBackgroundColor:[UIColor clearColor]];
    
    UIButton *btnListView = [[UIButton alloc] initWithFrame:CGRectMake(10, 10, 22, 22)];
    [btnListView setBackgroundImage:[UIImage imageNamed:@"icon-list.png"] forState:UIControlStateNormal & UIControlStateSelected];
    [btnListView addTarget:self action:@selector(btnNavBarPressedSwitchView) forControlEvents:UIControlEventTouchUpInside];
    [btnListView setHidden:YES];
    [btnListView setTag:10];
    
    UIButton *btnMapView = [[UIButton alloc] initWithFrame:CGRectMake(10, 10, 22, 22)];
    [btnMapView setBackgroundImage:[UIImage imageNamed:@"icon-map.png"] forState:UIControlStateNormal & UIControlStateSelected];
    [btnMapView addTarget:self action:@selector(btnNavBarPressedSwitchView) forControlEvents:UIControlEventTouchUpInside];
    [btnMapView setTag:20];
    
    [_navBarContainer addSubview:btnListView];
    [_navBarContainer addSubview:btnMapView];
    
    [self.navigationController.navigationBar addSubview:_navBarContainer];
    
    self.navigationItem.leftBarButtonItem = nil;
    self.navigationItem.hidesBackButton = YES;
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
    _mapBrick.delegate = self;
    
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
- (void) btnNavBarPressedSwitchView {
    
    if([_mapBrick isHidden]){
        
        //[self updateMapView];
        
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


@end
