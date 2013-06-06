//
//  ProductReportViewController_iPad.m
//  salesmonitor
//
//  Created by goodcore2 on 6/6/13.
//  Copyright (c) 2013 GoodCore. All rights reserved.
//

#import "ProductReportViewController_iPad.h"

@interface ProductReportViewController_iPad ()

@property (nonatomic, strong) AppDelegate *salesMonitorDelegate;
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
{
    self = [self initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    
    if (self) {
        _salesMonitorDelegate   = salesMonitorDelegate;
        _productSelected        = productSelected;
    }
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    _isBtnFromSelected = NO;
    _fromDate = [[NSNumber alloc] init];
    _toDate = [[NSNumber alloc] init];
    
    NSLog(@"%@", _productSelected);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) initalizeView {
    
}


// selectors
- (IBAction)btnFromPressed:(id)sender {
    
    _isBtnFromSelected = YES;
    
    CGRect frame = [_btnFrom frame];
    frame.origin.x = 195;
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
    frame.origin.x = 275;
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

-(void) dateWasSelected:(NSDate *)resultDate element:(UIButton *)button {
    
    NSCalendar *gregorian = [[NSCalendar alloc]
                             initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *dayComponents =
    [gregorian components:(NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit) fromDate:resultDate];
    [dayComponents setHour:00];
    [dayComponents setMinute:00];
    [dayComponents setSecond:00];
    
    resultDate = [gregorian dateFromComponents:dayComponents];
    
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    [format setDateStyle:NSDateFormatterMediumStyle];
    
    if(_isBtnFromSelected){
        [_btnFrom setTitle:[format stringFromDate:resultDate] forState:UIControlStateNormal];
        _fromDate = [NSNumber numberWithLongLong:[resultDate timeIntervalSince1970]*1000];
    }
    else{
        [_btnTo setTitle:[format stringFromDate:resultDate] forState:UIControlStateNormal];
        _toDate = [NSNumber numberWithLongLong:[resultDate timeIntervalSince1970]*1000];
    }
    
}


@end
