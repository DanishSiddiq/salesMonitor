//
//  ProductReportViewController_iPad.m
//  salesmonitor
//
//  Created by goodcore2 on 6/6/13.
//  Copyright (c) 2013 GoodCore. All rights reserved.
//

#import "ProductReportViewController_iPad.h"

@interface ProductReportViewController_iPad ()

// nav bar item at right in previous view
@property (strong, nonatomic) UIView *navBarContainer;

@property (nonatomic, strong) AppDelegate *salesMonitorDelegate;
@property (nonatomic, strong) ProductReportController *productReportController;
@property (nonatomic, strong) UIView *vwHeaderChartValue;
@property (nonatomic, strong) BarChartView *barChartValue;

@property (nonatomic, strong) NSMutableDictionary *productSelected;
@property (nonatomic, strong) IBOutlet UIButton *btnFrom;
@property (nonatomic, strong) IBOutlet UIButton *btnTo;

@property (nonatomic, strong) NSNumber *fromDate;
@property (nonatomic, strong) NSNumber *toDate;

@property (nonatomic) BOOL isBtnFromSelected;

@end

@implementation ProductReportViewController_iPad

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
    _productReportController = [[ProductReportController alloc] init:self salesMonitorDelegate:_salesMonitorDelegate];
    
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

- (void) initializeViews {
    [self customizeNavigationBar];
    [self initializeMainView];
    [self initializeViewHeaderValue];    
}

-(void) customizeNavigationBar {
    
    [_navBarContainer setHidden:YES];
}

- (void) initializeMainView {
    [self.view setFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
}

- (void) initializeViewHeaderValue {
 
    _vwHeaderChartValue = [[UIView alloc] initWithFrame:CGRectMake(0
                                                                  , 120
                                                                  , [UIScreen mainScreen].bounds.size.width
                                                                  , 30)];
    
    UILabel *lblHeading = [[UILabel alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width/2 - 200
                                                                    , 0
                                                                    , 400
                                                                    , 30)];
    lblHeading.textAlignment = NSTextAlignmentCenter;
    lblHeading.contentMode = UIViewContentModeTop;
    lblHeading.font = [UIFont fontWithName:@"Helvetica" size:16.0 ];
    lblHeading.text = @"Select dates";
    lblHeading.tag = 10;

    [_vwHeaderChartValue addSubview:lblHeading];
    [self.view addSubview:_vwHeaderChartValue];
}

// updating views on getting data from server
- (void) salesDataFromServer : (NSMutableArray *) salesReport{
    
    __block UILabel *lblResult;
    
    if([salesReport count] > 0){
        lblResult = (UILabel *)[_vwHeaderChartValue viewWithTag:10];
        lblResult.text = @"Budget/Sale Value Chart";
        
        [self customizeBarChartForBudget:salesReport];
    }
    else{
        
        [UIView animateWithDuration:1.5 animations:^{
            [_barChartValue setAlpha:0.0];
            
        } completion:^(BOOL finished) {
            
            lblResult = (UILabel *)[_vwHeaderChartValue viewWithTag:10];
            lblResult.text = @"No data exist for selected dates";
            
            
            [_barChartValue removeFromSuperview];
            _barChartValue = nil;
        }];
        
    }
}

- (void) customizeBarChartForBudget : (NSMutableArray *) salesReport{
    
    NSMutableArray *chartDataArray = [[NSMutableArray alloc] init];
    for (NSMutableDictionary *saleReport in salesReport) {
        
        ChartData *cd = [[ChartData alloc]
                         initWithName:[NSString stringWithFormat:@"BGT %@, %@", [saleReport valueForKey:KEY_SALES_MONTH], [saleReport valueForKey:KEY_SALES_YEAR]]
                         value:[NSString stringWithFormat:@"%.2f", [[saleReport valueForKey:KEY_SALES_BUDGET_VALUE] floatValue]]
                         color:KEY_GRAPH_BAR_BUDGET_COLOR labelColor:@"000000"];
        [chartDataArray addObject:cd];
        
        ChartData *cd2 = [[ChartData alloc]
                          initWithName:[NSString stringWithFormat:@"SALE %@, %@", [saleReport valueForKey:KEY_SALES_MONTH], [saleReport valueForKey:KEY_SALES_YEAR]]
                          value:[NSString stringWithFormat:@"%.2f", [[saleReport valueForKey:KEY_SALES_VALUE] floatValue]]
                          color:KEY_GRAPH_BAR_BUDGET_COLOR_ALTERNATE labelColor:@"000000"];
        [chartDataArray addObject:cd2];
    }
    
    if([self saveXML:(chartDataArray) fileName:KEY_GRAPH_XML_FILE_VALUE]){
        
        [_barChartValue removeFromSuperview];
        _barChartValue = nil;
        
        
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentsDirectory = [paths objectAtIndex:0];
        NSString *documentsPath = [documentsDirectory
                                   stringByAppendingPathComponent:KEY_GRAPH_XML_FILE_VALUE];
        
        
        _barChartValue = [[BarChartView alloc] initWithFrame:CGRectMake(20.0f
                                                                       , 150.0f
                                                                       , [UIScreen mainScreen].bounds.size.width -40
                                                                       , 450)];
        [_barChartValue setXmlData:[NSData dataWithContentsOfFile:documentsPath]];
        [self.view addSubview:_barChartValue];
        
        [UIView animateWithDuration:1.5 animations:^{
            [_vwHeaderChartValue setAlpha:1.0];
            
        } completion:^(BOOL finished) {
            
            [_vwHeaderChartValue setHidden:NO];
        }];

    }
}


// creating xml
- (BOOL) saveXML:(NSMutableArray *)chartDataArray fileName : (NSString *) fileName {
    
    GDataXMLElement * chartElement = [GDataXMLNode elementWithName:@"chart"];
    [chartElement addAttribute:[GDataXMLNode elementWithName:@"showAxisY" stringValue:@"false"]];
    [chartElement addAttribute:[GDataXMLNode elementWithName:@"showAxisX" stringValue:@"true"]];
    [chartElement addAttribute:[GDataXMLNode elementWithName:@"colorAxisY" stringValue:@"000000"]];
    [chartElement addAttribute:[GDataXMLNode elementWithName:@"plotVerticalLines" stringValue:@"true"]];
    
    for(ChartData *data in chartDataArray) {
        
        GDataXMLElement * chartNode =
        [GDataXMLNode elementWithName:@"chartData"];
        
        [chartNode addAttribute:[GDataXMLNode elementWithName:@"label" stringValue:data.label]];
        [chartNode addAttribute:[GDataXMLNode elementWithName:@"value" stringValue:data.value]];
        [chartNode addAttribute:[GDataXMLNode elementWithName:@"color" stringValue:data.color]];
        [chartNode addAttribute:[GDataXMLNode elementWithName:@"labelColor" stringValue:data.labelColor]];
        
        [chartElement addChild:chartNode];
    }
    
    GDataXMLDocument *document = [[GDataXMLDocument alloc]
                                  initWithRootElement:chartElement];
    NSData *xmlData = document.XMLData;
    NSString *filePath = [self dataFilePath:TRUE fileName:fileName];
    return [xmlData writeToFile:filePath atomically:YES];
}

// saving to file
- (NSString *)dataFilePath:(BOOL)forSave fileName : (NSString *) fileName{
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *documentsPath = [documentsDirectory
                               stringByAppendingPathComponent:fileName];
    return documentsPath;
}

// selectors
- (IBAction)btnFromPressed:(id)sender {
    
    _isBtnFromSelected = YES;
    
    CGRect frame = [_btnFrom frame];
    frame.origin.x = 185;
    frame.origin.y = -190;
    
    UIButton *btnClear = [[UIButton alloc] initWithFrame:frame];
    [self.view addSubview:btnClear];
    
    NSDate *myDate = [NSDate date];
    ActionSheetDatePicker *datePicker = [[ActionSheetDatePicker alloc] initWithTitle:@""
                                                                      datePickerMode:UIDatePickerModeDate
                                                                        selectedDate:myDate
                                                                              target:self
                                                                              action:@selector(dateWasSelected:element:)
                                                                              origin:btnClear];
    
    [datePicker addCustomButtonWithTitle:@"Today" value:[NSDate date]];
    datePicker.hideCancel = NO;
    [datePicker showActionSheetPicker];
    
    [btnClear removeFromSuperview];
    btnClear = nil;
}

- (IBAction)btnToPressed:(id)sender {

    _isBtnFromSelected = NO;
    
    CGRect frame = [_btnTo frame];
    frame.origin.x = 300;
    frame.origin.y = -190;
    
    UIButton *btnClear = [[UIButton alloc] initWithFrame:frame];
    [self.view addSubview:btnClear];
    
    NSDate *myDate = [NSDate date];
    ActionSheetDatePicker *datePicker = [[ActionSheetDatePicker alloc] initWithTitle:@""
                                                                      datePickerMode:UIDatePickerModeDate
                                                                        selectedDate:myDate
                                                                              target:self
                                                                              action:@selector(dateWasSelected:element:)
                                                                              origin:btnClear ];

    [datePicker addCustomButtonWithTitle:@"Today" value:[NSDate date]];
    datePicker.hideCancel = NO;
    [datePicker showActionSheetPicker];
    
    
    [btnClear removeFromSuperview];
    btnClear = nil;
}

- (IBAction)btnPressedReport:(id)sender {
    
    [_productReportController fetchDataFromServer:_fromDate toDate:_toDate];
}

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

