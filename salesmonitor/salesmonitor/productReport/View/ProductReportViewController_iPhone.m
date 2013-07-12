//
//  ProductReportViewController_iPhone.m
//  salesmonitor
//
//  Created by goodcore2 on 6/6/13.
//  Copyright (c) 2013 GoodCore. All rights reserved.
//

#import "ProductReportViewController_iPhone.h"

@interface ProductReportViewController_iPhone ()

// nav bar item at right in previous view
@property (strong, nonatomic) UIView *navBarContainer;

@property (nonatomic, strong) AppDelegate *salesMonitorDelegate;
@property (nonatomic, strong) ProductReportController *productReportController;
@property (nonatomic, strong) NSMutableDictionary *productSelected;
@property (strong, nonatomic) IBOutlet UIImageView *imgViewBg;
@property (nonatomic, strong) IBOutlet UIButton *btnFrom;
@property (nonatomic, strong) IBOutlet UIButton *btnTo;
@property (nonatomic, strong) NSMutableArray *loadSales;
@property (nonatomic, strong) UITableView *tblSale;

@property (nonatomic, strong) NSNumber *fromDate;
@property (nonatomic, strong) NSNumber *toDate;

@property (nonatomic) BOOL isBtnFromSelected;

@end

@implementation ProductReportViewController_iPhone

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (id)initWithNibName:(NSString *)nibNameOrNil
               bundle:(NSBundle *)nibBundleOrNil
salesMonitorDelegate : (AppDelegate *) salesMonitorDelegate
     productSelected : (NSMutableDictionary *)productSelected
      navBarContainer: (UIView *) navBarContainer
{
    self = [self initWithNibName:nibNameOrNil bundle:nibBundleOrNil];

    if (self) {
        _salesMonitorDelegate   = salesMonitorDelegate;
        _productSelected        = productSelected;
        _navBarContainer        = navBarContainer;
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
    
    _isBtnFromSelected = NO;
    _fromDate = [[NSNumber alloc] init];
    _toDate = [[NSNumber alloc] init];
    _loadSales = [[NSMutableArray alloc] init];
    _productReportController = [[ProductReportController alloc] init:YES
                                                      viewController:self
                                                salesMonitorDelegate:_salesMonitorDelegate
                                                     productSelected:_productSelected
                                                           loadSales:_loadSales];
    
    [self initializeDates];
}

- (void) initializeDates {
    
    NSDate *resultDate = [NSDate date];
    
    NSCalendar *gregorian = [[NSCalendar alloc]
                             initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *dayComponents =
    [gregorian components:(NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit) fromDate:resultDate];
    
    [dayComponents setHour: 00];
    [dayComponents setMinute:00];
    [dayComponents setSecond:00];
    resultDate = [gregorian dateFromComponents:dayComponents];
    
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    [format setDateStyle:NSDateFormatterMediumStyle];
    [_btnFrom setTitle:[format stringFromDate:resultDate] forState:UIControlStateNormal];
    _fromDate = [NSNumber numberWithLongLong:[resultDate timeIntervalSince1970]*1000];
    
    [dayComponents setHour: 11];
    [dayComponents setMinute:59];
    [dayComponents setSecond:59];
    resultDate = [gregorian dateFromComponents:dayComponents];
    
    [_btnTo setTitle:[format stringFromDate:resultDate] forState:UIControlStateNormal];
    _toDate = [NSNumber numberWithLongLong:[resultDate timeIntervalSince1970]*1000];
    
}

-(void) customizeNavigationBar {
    
    UIButton *btnNavBarBack = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 45, 30)];
    [btnNavBarBack setImage:[UIImage imageNamed:@"titlebar-back-btn"] forState:UIControlStateNormal];
    btnNavBarBack.imageView.contentMode = UIViewContentModeScaleToFill;
    [btnNavBarBack addTarget:self action:@selector(btnPressedNavBarBack:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btnNavBarBack];
    
    [_navBarContainer setHidden:YES];
}

- (void) initializeViews {
 
    [self customizeNavigationBar];
    [self initializeMainView];
    [self initializeTableSale];
}

- (void) initializeMainView {
    
    [self.view setFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    [_imgViewBg setFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
}

- (void) initializeTableSale {
    _tblSale = [[UITableView alloc] initWithFrame:CGRectMake(0
                                                             , 65
                                                             ,[UIScreen mainScreen].bounds.size.width
                                                             , [UIScreen mainScreen].bounds.size.height - 110)];
    _tblSale.delegate = _productReportController;
    _tblSale.dataSource = _productReportController;
    _tblSale.backgroundColor = [UIColor clearColor];
    _tblSale.separatorColor = [UIColor colorWithRed:112/255.0f green:112/255.0f blue:112/255.0f alpha:1.0];
    [self.view addSubview:_tblSale];
}

// updating views on getting data from server
- (void) salesDataFromServer : (NSMutableArray *) salesReport{
    
    [_loadSales removeAllObjects];
    [_loadSales addObjectsFromArray:[salesReport sortedArrayUsingComparator:^NSComparisonResult(id a, id b) {
        CGFloat first  = [[a valueForKey:KEY_SALES_MONTH_NUMBER] floatValue] + ([[a valueForKey:KEY_SALES_YEAR] floatValue] * 12);
        CGFloat second = [[b valueForKey:KEY_SALES_MONTH_NUMBER] floatValue] + ([[b valueForKey:KEY_SALES_YEAR] floatValue] * 12);
        
        NSNumber *firstNumber = [NSNumber numberWithFloat:first];
        NSNumber *secondNumer = [NSNumber numberWithFloat:second];
        return [firstNumber compare:secondNumer];
    }]];
    [_tblSale reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationFade];
}


// selectors
- (void) btnPressedNavBarBack : (id) sender {
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)tbnFromPressed:(id)sender {
    
    _isBtnFromSelected = YES;
    
    NSDate *myDate = [NSDate date];
    ActionSheetDatePicker *datePicker = [[ActionSheetDatePicker alloc] initWithTitle:@""
                                                                      datePickerMode:UIDatePickerModeDate
                                                                        selectedDate:myDate
                                                                              target:self
                                                                              action:@selector(dateWasSelected:element:)
                                                                              origin:sender];
    
    [datePicker addCustomButtonWithTitle:@"Today" value:[NSDate date]];
    datePicker.hideCancel = NO;
    [datePicker showActionSheetPicker];
    
}

- (IBAction)btnToPressed:(id)sender {
    
    _isBtnFromSelected = NO;
    
    NSDate *myDate = [NSDate date];
    ActionSheetDatePicker *datePicker = [[ActionSheetDatePicker alloc] initWithTitle:@""
                                                                      datePickerMode:UIDatePickerModeDate
                                                                        selectedDate:myDate
                                                                              target:self
                                                                              action:@selector(dateWasSelected:element:)
                                                                              origin:sender];
    
    [datePicker addCustomButtonWithTitle:@"Today" value:[NSDate date]];
    datePicker.hideCancel = NO;
    [datePicker showActionSheetPicker];
}

- (IBAction)btnPressedReport:(id)sender {
    // call server to get report data
    [_productReportController fetchDataFromServer:_fromDate toDate:_toDate];
}

// date time was selected
-(void) dateWasSelected:(NSDate *)resultDate element:(UIButton *)button {
    
    NSCalendar *gregorian = [[NSCalendar alloc]
                             initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *dayComponents =
    [gregorian components:(NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit) fromDate:resultDate];
    
    
    [dayComponents setHour:_isBtnFromSelected ? 00 : 11];
    [dayComponents setMinute:_isBtnFromSelected ? 00 : 59];
    [dayComponents setSecond:_isBtnFromSelected ? 00 : 59];
    
    resultDate = [gregorian dateFromComponents:dayComponents];
    
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    [format setDateStyle:NSDateFormatterMediumStyle];
    
    if(_isBtnFromSelected){
        
        if([[NSNumber numberWithLongLong:[resultDate timeIntervalSince1970]*1000] doubleValue] < [_toDate doubleValue]){
            
            [_btnFrom setTitle:[format stringFromDate:resultDate] forState:UIControlStateNormal];
            _fromDate = [NSNumber numberWithLongLong:[resultDate timeIntervalSince1970]*1000];
        }
        else{
            
            SIAlertView *alertView = [[SIAlertView alloc] initWithTitle:@"Correction" andMessage:@"From date must be less than To date"];
            [alertView addButtonWithTitle:@"Ok"
                                     type:SIAlertViewButtonTypeDestructive
                                  handler:^(SIAlertView *alertView) {
                                  }];
            alertView.transitionStyle = SIAlertViewTransitionStyleSlideFromTop;
            [alertView show];
        }
    }
    else{
        
        if([[NSNumber numberWithLongLong:[resultDate timeIntervalSince1970]*1000] doubleValue] > [_fromDate doubleValue]){
            
            [_btnTo setTitle:[format stringFromDate:resultDate] forState:UIControlStateNormal];
            _toDate = [NSNumber numberWithLongLong:[resultDate timeIntervalSince1970]*1000];
        }
        else{
            
            SIAlertView *alertView = [[SIAlertView alloc] initWithTitle:@"Correction" andMessage:@"To date must be greater than From date"];
            [alertView addButtonWithTitle:@"Ok"
                                     type:SIAlertViewButtonTypeDestructive
                                  handler:^(SIAlertView *alertView) {
                                  }];
            alertView.transitionStyle = SIAlertViewTransitionStyleSlideFromTop;
            [alertView show];
        }
    }
}

@end
