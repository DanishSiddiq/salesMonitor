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
@property (nonatomic, strong) NSMutableArray *loadSales;
@property (nonatomic, strong) BarChartView *barChartValue;
@property (nonatomic, strong) UITableView *tblSale;


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
    _loadSales = [[NSMutableArray alloc] init];
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
    [self initializeTableSale];
}

-(void) customizeNavigationBar {
    
    [_navBarContainer setHidden:YES];
}

- (void) initializeMainView {
    [self.view setFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
}

- (void) initializeViewHeaderValue {
 
    _vwHeaderChartValue = [[UIView alloc] initWithFrame:CGRectMake(0
                                                                  , 90
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

- (void) initializeTableSale {
    _tblSale = [[UITableView alloc] initWithFrame:CGRectMake(0
                                                             , 580
                                                             ,[UIScreen mainScreen].bounds.size.width
                                                             , [UIScreen mainScreen].bounds.size.height - 630)];
    _tblSale.delegate = self;
    _tblSale.dataSource = self;
    [self.view addSubview:_tblSale];
}

// updating views on getting data from server
- (void) salesDataFromServer : (NSMutableArray *) salesReport{
    
    
    [_loadSales removeAllObjects];
    [_loadSales addObjectsFromArray:salesReport];
    
    __block UILabel *lblResult;
    
    if([_loadSales count] > 0){
        lblResult = (UILabel *)[_vwHeaderChartValue viewWithTag:10];
        lblResult.text = @"Budget/Sale Value Chart";
        
        [self customizeBarChartForBudget];
        [_tblSale reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationFade];
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

- (void) customizeBarChartForBudget{
    
    NSMutableArray *chartDataArray = [[NSMutableArray alloc] init];
    for (NSMutableDictionary *saleReport in _loadSales) {
        
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
                                                                       , 120.0f
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

// table delegates
#pragma sale table delagates
- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return  [_loadSales count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 40.0f;
}

- (CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 40.0f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 1.0f;
}

- (UIView *) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    UIView *viewHeader = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 40)];
    [viewHeader setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"background_gradient"]]];
    
    UILabel *lblDate = [[UILabel alloc] initWithFrame: CGRectMake(4, 6, 64, 30)];
    [lblDate setBackgroundColor:[UIColor clearColor]];
    lblDate.numberOfLines = 1;
    lblDate.font = [UIFont fontWithName:@"Helvetica" size:12.0];
    lblDate.textColor = [UIColor darkGrayColor];
    lblDate.contentMode = UIViewContentModeBottomLeft;
    lblDate.textAlignment = NSTextAlignmentCenter;
    lblDate.adjustsFontSizeToFitWidth = YES;
    lblDate.text = @"Date";
    
    UIView *viewSeperatorDate = [[UIView alloc] initWithFrame:CGRectMake(68, 0, 1, 40)];
    [viewSeperatorDate setBackgroundColor:[UIColor lightGrayColor]];
    
    UILabel *lblbudgetUnit = [[UILabel alloc] initWithFrame:CGRectMake(69, 6, 62, 30)];
    lblbudgetUnit.backgroundColor = [UIColor clearColor];
    lblbudgetUnit.font = [UIFont fontWithName:@"HelveticaNeue" size:12];
    lblbudgetUnit.numberOfLines = 1;
    lblbudgetUnit.contentMode = UIViewContentModeTopLeft;
    lblbudgetUnit.textAlignment = NSTextAlignmentCenter;
    lblbudgetUnit.textColor = [UIColor grayColor];
    lblbudgetUnit.adjustsFontSizeToFitWidth = YES;
    lblbudgetUnit.text = @"BDG Unit";
    
    UIView *viewSeperatorBudgetUnit = [[UIView alloc] initWithFrame:CGRectMake(131 , 0, 1, 40)];
    [viewSeperatorBudgetUnit setBackgroundColor:[UIColor lightGrayColor]];
    
    UILabel *lblBudgetValue = [[UILabel alloc] initWithFrame:CGRectMake(132, 6, 62, 30)];
    lblBudgetValue.backgroundColor = [UIColor clearColor];
    lblBudgetValue.font = [UIFont fontWithName:@"HelveticaNeue" size:12];
    lblBudgetValue.numberOfLines = 1;
    lblBudgetValue.contentMode = UIViewContentModeTopLeft;
    lblBudgetValue.textAlignment = NSTextAlignmentCenter;
    lblBudgetValue.textColor = [UIColor grayColor];
    lblBudgetValue.adjustsFontSizeToFitWidth = YES;
    lblBudgetValue.text = @"BDG Value";
    
    UIView *viewSeperatorBudgetValue = [[UIView alloc] initWithFrame:CGRectMake(195 , 0, 1, 40)];
    [viewSeperatorBudgetValue setBackgroundColor:[UIColor lightGrayColor]];
    
    UILabel *lblSaleUnit = [[UILabel alloc] initWithFrame:CGRectMake(196, 6, 62, 30)];
    lblSaleUnit.backgroundColor = [UIColor clearColor];
    lblSaleUnit.font = [UIFont fontWithName:@"HelveticaNeue" size:12];
    lblSaleUnit.numberOfLines = 1;
    lblSaleUnit.contentMode = UIViewContentModeTopLeft;
    lblSaleUnit.textAlignment = NSTextAlignmentCenter;
    lblSaleUnit.textColor = [UIColor grayColor];
    lblSaleUnit.adjustsFontSizeToFitWidth = YES;
    lblSaleUnit.text = @"Sale Unit";
    
    UIView *viewSeperatorSaleUnit = [[UIView alloc] initWithFrame:CGRectMake(258 , 0, 1, 40)];
    [viewSeperatorSaleUnit setBackgroundColor:[UIColor lightGrayColor]];
    
    UILabel *lblSaleValue = [[UILabel alloc] initWithFrame:CGRectMake(259, 6, 61, 30)];
    lblSaleValue.backgroundColor = [UIColor clearColor];
    lblSaleValue.font = [UIFont fontWithName:@"HelveticaNeue" size:12];
    lblSaleValue.numberOfLines = 1;
    lblSaleValue.contentMode = UIViewContentModeTopLeft;
    lblSaleValue.textAlignment = NSTextAlignmentCenter;
    lblSaleValue.textColor = [UIColor grayColor];
    lblSaleValue.adjustsFontSizeToFitWidth = YES;
    lblSaleValue.text = @"Sale Value";
    
    [viewHeader addSubview:lblDate];
    [viewHeader addSubview:viewSeperatorDate];
    [viewHeader addSubview:lblbudgetUnit];
    [viewHeader addSubview:viewSeperatorBudgetUnit];
    [viewHeader addSubview:lblBudgetValue];
    [viewHeader addSubview:viewSeperatorBudgetValue];
    [viewHeader addSubview:lblSaleUnit];
    [viewHeader addSubview:viewSeperatorSaleUnit];
    [viewHeader addSubview:lblSaleValue];
    
    return viewHeader;
}

- (UIView *) tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    NSString *branchCellIdentifier = [NSString stringWithFormat:@"SaleCell"];
    UITableViewCell *cell;
    UILabel *lblDate, *lblbudgetUnit, *lblBudgetValue, *lblSaleUnit, *lblSaleValue;
    UIView *viewSeperatorDate, *viewSeperatorBudgetUnit, *viewSeperatorBudgetValue, *viewSeperatorSaleUnit;
    
    cell = [tableView dequeueReusableCellWithIdentifier:branchCellIdentifier];
    
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:branchCellIdentifier];
        [cell setFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 40)];
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        
        lblDate = [[UILabel alloc] initWithFrame: CGRectMake(4, 6, 64, 30)];
        [lblDate setBackgroundColor:[UIColor clearColor]];
        lblDate.numberOfLines = 1;
        lblDate.font = [UIFont fontWithName:@"Helvetica" size:12.0];
        lblDate.textColor = [UIColor darkGrayColor];
        lblDate.contentMode = UIViewContentModeBottomLeft;
        lblDate.lineBreakMode = NSLineBreakByTruncatingTail;
        lblDate.adjustsFontSizeToFitWidth = YES;
        lblDate.tag = 10;
        
        viewSeperatorDate = [[UIView alloc] initWithFrame:CGRectMake(68, 0, 1, 40)];
        [viewSeperatorDate setBackgroundColor:[UIColor lightGrayColor]];
        
        lblbudgetUnit = [[UILabel alloc] initWithFrame:CGRectMake(72, 6, 59, 30)];
        lblbudgetUnit.backgroundColor = [UIColor clearColor];
        lblbudgetUnit.font = [UIFont fontWithName:@"HelveticaNeue" size:11];
        lblbudgetUnit.numberOfLines = 1;
        lblbudgetUnit.contentMode = UIViewContentModeTopLeft;
        lblbudgetUnit.lineBreakMode = NSLineBreakByTruncatingTail;
        lblbudgetUnit.textColor = [UIColor grayColor];
        lblbudgetUnit.adjustsFontSizeToFitWidth = YES;
        lblbudgetUnit.tag = 20;
        
        viewSeperatorBudgetUnit = [[UIView alloc] initWithFrame:CGRectMake(131 , 0, 1, 40)];
        [viewSeperatorBudgetUnit setBackgroundColor:[UIColor lightGrayColor]];
        
        
        lblBudgetValue = [[UILabel alloc] initWithFrame:CGRectMake(135, 6, 59, 30)];
        lblBudgetValue.backgroundColor = [UIColor clearColor];
        lblBudgetValue.font = [UIFont fontWithName:@"HelveticaNeue" size:11];
        lblBudgetValue.numberOfLines = 1;
        lblBudgetValue.contentMode = UIViewContentModeTopLeft;
        lblBudgetValue.lineBreakMode = NSLineBreakByTruncatingTail;
        lblBudgetValue.textColor = [UIColor grayColor];
        lblBudgetValue.adjustsFontSizeToFitWidth = YES;
        lblBudgetValue.tag = 30;
        
        viewSeperatorBudgetValue = [[UIView alloc] initWithFrame:CGRectMake(195 , 0, 1, 40)];
        [viewSeperatorBudgetValue setBackgroundColor:[UIColor lightGrayColor]];
        
        lblSaleUnit = [[UILabel alloc] initWithFrame:CGRectMake(199, 6, 59, 30)];
        lblSaleUnit.backgroundColor = [UIColor clearColor];
        lblSaleUnit.font = [UIFont fontWithName:@"HelveticaNeue" size:11];
        lblSaleUnit.numberOfLines = 1;
        lblSaleUnit.contentMode = UIViewContentModeTopLeft;
        lblSaleUnit.lineBreakMode = NSLineBreakByTruncatingTail;
        lblSaleUnit.textColor = [UIColor grayColor];
        lblSaleUnit.adjustsFontSizeToFitWidth = YES;
        lblSaleUnit.tag = 40;
        
        viewSeperatorSaleUnit = [[UIView alloc] initWithFrame:CGRectMake(258 , 0, 1, 40)];
        [viewSeperatorSaleUnit setBackgroundColor:[UIColor lightGrayColor]];
        
        lblSaleValue = [[UILabel alloc] initWithFrame:CGRectMake(262, 6, 58, 30)];
        lblSaleValue.backgroundColor = [UIColor clearColor];
        lblSaleValue.font = [UIFont fontWithName:@"HelveticaNeue" size:11];
        lblSaleValue.numberOfLines = 1;
        lblSaleValue.contentMode = UIViewContentModeTopLeft;
        lblSaleValue.lineBreakMode = NSLineBreakByTruncatingTail;
        lblSaleValue.textColor = [UIColor grayColor];
        lblSaleValue.adjustsFontSizeToFitWidth = YES;
        lblSaleValue.tag = 50;
        
        
        [cell.contentView addSubview:lblDate];
        [cell.contentView addSubview:viewSeperatorDate];
        [cell.contentView addSubview:lblbudgetUnit];
        [cell.contentView addSubview:viewSeperatorBudgetUnit];
        [cell.contentView addSubview:lblBudgetValue];
        [cell.contentView addSubview:viewSeperatorBudgetValue];
        [cell.contentView addSubview:lblSaleUnit];
        [cell.contentView addSubview:viewSeperatorSaleUnit];
        [cell.contentView addSubview:lblSaleValue];
        
    }
    else{
        
        lblDate = (UILabel *)[cell.contentView viewWithTag:10];
        lblbudgetUnit = (UILabel *)[cell.contentView viewWithTag:20];
        lblBudgetValue = (UILabel *)[cell.contentView viewWithTag:30];
        lblSaleUnit = (UILabel *)[cell.contentView viewWithTag:40];
        lblSaleValue = (UILabel *)[cell.contentView viewWithTag:50];
        
    }
    
    NSMutableDictionary *saleReport = [_loadSales objectAtIndex:indexPath.row];
    
    lblDate.text = [NSString stringWithFormat:@"%@, %@", [saleReport valueForKey:KEY_SALES_MONTH], [saleReport valueForKey:KEY_SALES_YEAR]];
    lblbudgetUnit.text = [[saleReport valueForKey:KEY_SALES_BUDGET_UNIT] description];
    lblBudgetValue.text = [[saleReport valueForKey:KEY_SALES_VALUE] description];
    lblSaleUnit.text = [[saleReport valueForKey:KEY_SALES_UNIT] description];
    lblSaleValue.text = [[saleReport valueForKey:KEY_SALES_VALUE] description];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}


@end

