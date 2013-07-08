//
//  ProductReportController.m
//  salesmonitor
//
//  Created by goodcore2 on 6/10/13.
//  Copyright (c) 2013 GoodCore. All rights reserved.
//

#import "ProductReportController.h"

@interface  ProductReportController()

@property (nonatomic) BOOL isIphone;
@property (nonatomic, strong) id<ProductReportDelegate> viewController;
@property (nonatomic, strong) AppDelegate *salesMonitorDelegate;
@property (nonatomic, strong) NSMutableArray *loadSales;
@property (nonatomic, strong) NSMutableDictionary *productSelected;

@end

@implementation ProductReportController

-(id)           init :(BOOL) isIphone
       viewController:(id<ProductReportDelegate>) viewController
salesMonitorDelegate : (AppDelegate *)salesMonitorDelegate
     productSelected : (NSMutableDictionary *)productSelected
            loadSales: (NSMutableArray *)loadSales{
    
    self = [super init];
    
    if(self){
        
        _isIphone = isIphone;
        _viewController = viewController;
        _salesMonitorDelegate = salesMonitorDelegate;
        _productSelected = productSelected;
        _loadSales = loadSales;
    }
    
    return self;
}

- (void) fetchDataFromServer : (NSNumber *) fromDate toDate : (NSNumber *) toDate {
 
    if(![_salesMonitorDelegate isNetworkAvailable]){
        
        SIAlertView *alertView = [[SIAlertView alloc] initWithTitle:@"Network Issue" andMessage:@"Internet not available"];
        [alertView addButtonWithTitle:@"Ok"
                                 type:SIAlertViewButtonTypeDestructive
                              handler:^(SIAlertView *alertView) {
                              }];
        alertView.transitionStyle = SIAlertViewTransitionStyleSlideFromTop;
        [alertView show];
        
    }
    else{
        
        
        NSString *urlString = [NSString stringWithFormat:KEY_SERVER_REPORT_SALE
                               , [[_salesMonitorDelegate userData] valueForKey:KEY_USER_ID]
                               , fromDate
                               , toDate
                               , _productSelected ? [_productSelected valueForKey:KEY_PRODUCT_ID] : @""];
        
        NSURL *url = [NSURL URLWithString:urlString];
        NSURLRequest *request = [NSURLRequest requestWithURL:url];
        
        
        AFJSONRequestOperation *operation =
        [AFJSONRequestOperation
         JSONRequestOperationWithRequest:request
         success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
             [SVProgressHUD dismiss];
             
             if([_viewController respondsToSelector:@selector(salesDataFromServer:)]){
             
                 [_viewController salesDataFromServer:JSON];
             }
         }
         failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON)
         {          
             [SVProgressHUD dismiss];
             
             SIAlertView *alertView = [[SIAlertView alloc] initWithTitle:@"Server not Responded"
                                                              andMessage:@"custom message on basis of code"];
             [alertView addButtonWithTitle:@"Ok"
                                      type:SIAlertViewButtonTypeDestructive
                                   handler:^(SIAlertView *alertView) {
                                   }];
             alertView.transitionStyle = SIAlertViewTransitionStyleSlideFromTop;
             [alertView show];
             
         }];
        operation.JSONReadingOptions = NSJSONReadingMutableContainers | NSJSONReadingMutableLeaves;
        [operation start];
        [SVProgressHUD showWithStatus:@"Loading Sales Report" maskType:SVProgressHUDMaskTypeClear];
    }
}


#pragma sale table delagates
- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return  [_loadSales count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return _isIphone ? 40.0f : 50.0f;
}

- (CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return ([_loadSales count] <= 0) ? 1.0f : (_isIphone ? 40.0f : 50.0f);
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 1.0f;
}

- (UIView *) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    if([_loadSales count] <= 0){
        return [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
    }
    else{
        
        return _isIphone ? [self createHeaderViewForIphone] : [self createHeaderViewForIpad];
    }
}

- (UIView *) createHeaderViewForIpad {    
    
    UIView *viewHeader = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 640, 50)];
    [viewHeader setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"background_gradient"]]];
    
    UIView *vwBgDate = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 132, 50)];
    [vwBgDate setBackgroundColor:[UIColor colorWithRed:112/255.0f green:112/255.0f blue:112/255.0f alpha:1.0f]];
    
    UILabel *lblDate = [[UILabel alloc] initWithFrame: CGRectMake(8, 6, 128, 40)];
    [lblDate setBackgroundColor:[UIColor clearColor]];
    lblDate.numberOfLines = 1;
    lblDate.font = [UIFont fontWithName:@"Helvetica" size:12.0];
    lblDate.textColor = [UIColor whiteColor];
    lblDate.contentMode = UIViewContentModeBottomLeft;
    lblDate.textAlignment = NSTextAlignmentCenter;
    lblDate.adjustsFontSizeToFitWidth = YES;
    lblDate.text = @"Date";
    
    UIView *viewSeperatorDate = [[UIView alloc] initWithFrame: CGRectMake(136, 0, 2, 50)];
    [viewSeperatorDate setBackgroundColor:[UIColor colorWithRed:112/255.0f green:112/255.0f blue:112/255.0f alpha:1.0]];
    
    UIView *vwBgBudgetUnit = [[UIView alloc] initWithFrame:CGRectMake(142, 0, 116, 50)];
    [vwBgBudgetUnit setBackgroundColor:[UIColor colorWithRed:112/255.0f green:112/255.0f blue:112/255.0f alpha:1.0f]];
    
    UILabel *lblbudgetUnit = [[UILabel alloc] initWithFrame: CGRectMake(138, 6, 124, 40)];
    lblbudgetUnit.backgroundColor = [UIColor clearColor];
    lblbudgetUnit.font = [UIFont fontWithName:@"HelveticaNeue" size:12];
    lblbudgetUnit.numberOfLines = 1;
    lblbudgetUnit.contentMode = UIViewContentModeTopLeft;
    lblbudgetUnit.textAlignment = NSTextAlignmentCenter;
    lblbudgetUnit.textColor = [UIColor whiteColor];
    lblbudgetUnit.adjustsFontSizeToFitWidth = YES;
    lblbudgetUnit.text = @"BDG Unit";
    
    UIView *viewSeperatorBudgetUnit = [[UIView alloc] initWithFrame: CGRectMake(262 , 0, 2, 50)];
    [viewSeperatorBudgetUnit setBackgroundColor:[UIColor colorWithRed:112/255.0f green:112/255.0f blue:112/255.0f alpha:1.0]];
    
    UIView *vwBgBudgetValue = [[UIView alloc] initWithFrame:CGRectMake(268, 0, 114, 50)];
    [vwBgBudgetValue setBackgroundColor:[UIColor colorWithRed:112/255.0f green:112/255.0f blue:112/255.0f alpha:1.0f]];
    
    UILabel *lblBudgetValue = [[UILabel alloc] initWithFrame: CGRectMake(264, 6, 124, 40)];
    lblBudgetValue.backgroundColor = [UIColor clearColor];
    lblBudgetValue.font = [UIFont fontWithName:@"HelveticaNeue" size:12];
    lblBudgetValue.numberOfLines = 1;
    lblBudgetValue.contentMode = UIViewContentModeTopLeft;
    lblBudgetValue.textAlignment = NSTextAlignmentCenter;
    lblBudgetValue.textColor = [UIColor whiteColor];
    lblBudgetValue.adjustsFontSizeToFitWidth = YES;
    lblBudgetValue.text = @"BDG Value";
    
    UIView *viewSeperatorBudgetValue = [[UIView alloc] initWithFrame: CGRectMake(388 , 0, 2, 50)];
    [viewSeperatorBudgetValue setBackgroundColor:[UIColor colorWithRed:112/255.0f green:112/255.0f blue:112/255.0f alpha:1.0]];
    
    UIView *vwBgSaleUnit = [[UIView alloc] initWithFrame:CGRectMake(394, 0, 116, 50)];
    [vwBgSaleUnit setBackgroundColor:[UIColor colorWithRed:112/255.0f green:112/255.0f blue:112/255.0f alpha:1.0f]];
    
    UILabel *lblSaleUnit = [[UILabel alloc] initWithFrame: CGRectMake(390, 6, 124, 40)];
    lblSaleUnit.backgroundColor = [UIColor clearColor];
    lblSaleUnit.font = [UIFont fontWithName:@"HelveticaNeue" size:12];
    lblSaleUnit.numberOfLines = 1;
    lblSaleUnit.contentMode = UIViewContentModeTopLeft;
    lblSaleUnit.textAlignment = NSTextAlignmentCenter;
    lblSaleUnit.textColor = [UIColor whiteColor];
    lblSaleUnit.adjustsFontSizeToFitWidth = YES;
    lblSaleUnit.text = @"Sale Unit";
    
    UIView *viewSeperatorSaleUnit = [[UIView alloc] initWithFrame: CGRectMake(514 , 0, 2, 50)];
    [viewSeperatorSaleUnit setBackgroundColor:[UIColor colorWithRed:112/255.0f green:112/255.0f blue:112/255.0f alpha:1.0]];
    
    UIView *vwBgSaleValue = [[UIView alloc] initWithFrame:CGRectMake(520, 0, 120, 50)];
    [vwBgSaleValue setBackgroundColor:[UIColor colorWithRed:112/255.0f green:112/255.0f blue:112/255.0f alpha:1.0f]];
    
    UILabel *lblSaleValue = [[UILabel alloc] initWithFrame: CGRectMake(516, 6, 124, 40)];
    lblSaleValue.backgroundColor = [UIColor clearColor];
    lblSaleValue.font = [UIFont fontWithName:@"HelveticaNeue" size:12];
    lblSaleValue.numberOfLines = 1;
    lblSaleValue.contentMode = UIViewContentModeTopLeft;
    lblSaleValue.textAlignment = NSTextAlignmentCenter;
    lblSaleValue.textColor = [UIColor whiteColor];
    lblSaleValue.adjustsFontSizeToFitWidth = YES;
    lblSaleValue.text = @"Sale Value";
    
    [viewHeader addSubview:vwBgDate];
    [viewHeader addSubview:lblDate];
    [viewHeader addSubview:viewSeperatorDate];
    [viewHeader addSubview:vwBgBudgetUnit];
    [viewHeader addSubview:lblbudgetUnit];
    [viewHeader addSubview:viewSeperatorBudgetUnit];
    [viewHeader addSubview:vwBgBudgetValue];
    [viewHeader addSubview:lblBudgetValue];
    [viewHeader addSubview:viewSeperatorBudgetValue];
    [viewHeader addSubview:vwBgSaleUnit];
    [viewHeader addSubview:lblSaleUnit];
    [viewHeader addSubview:viewSeperatorSaleUnit];
    [viewHeader addSubview:vwBgSaleValue];
    [viewHeader addSubview:lblSaleValue];
    
    return viewHeader;
    
}


- (UIView *) createHeaderViewForIphone {
    
    
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
    [viewSeperatorDate setBackgroundColor:[UIColor colorWithRed:112/255.0f green:112/255.0f blue:112/255.0f alpha:1.0]];
    
    UILabel *lblbudgetUnit = [[UILabel alloc] initWithFrame:CGRectMake(69, 6, 62, 30) ];
    lblbudgetUnit.backgroundColor = [UIColor clearColor];
    lblbudgetUnit.font = [UIFont fontWithName:@"HelveticaNeue" size:12];
    lblbudgetUnit.numberOfLines = 1;
    lblbudgetUnit.contentMode = UIViewContentModeTopLeft;
    lblbudgetUnit.textAlignment = NSTextAlignmentCenter;
    lblbudgetUnit.textColor = [UIColor grayColor];
    lblbudgetUnit.adjustsFontSizeToFitWidth = YES;
    lblbudgetUnit.text = @"BDG Unit";
    
    UIView *viewSeperatorBudgetUnit = [[UIView alloc] initWithFrame:CGRectMake(131 , 0, 1, 40) ];
    [viewSeperatorBudgetUnit setBackgroundColor:[UIColor colorWithRed:112/255.0f green:112/255.0f blue:112/255.0f alpha:1.0]];
    
    UILabel *lblBudgetValue = [[UILabel alloc] initWithFrame: CGRectMake(132, 6, 62, 30)];
    lblBudgetValue.backgroundColor = [UIColor clearColor];
    lblBudgetValue.font = [UIFont fontWithName:@"HelveticaNeue" size:12];
    lblBudgetValue.numberOfLines = 1;
    lblBudgetValue.contentMode = UIViewContentModeTopLeft;
    lblBudgetValue.textAlignment = NSTextAlignmentCenter;
    lblBudgetValue.textColor = [UIColor grayColor];
    lblBudgetValue.adjustsFontSizeToFitWidth = YES;
    lblBudgetValue.text = @"BDG Value";
    
    UIView *viewSeperatorBudgetValue = [[UIView alloc] initWithFrame:CGRectMake(195 , 0, 1, 40)];
    [viewSeperatorBudgetValue setBackgroundColor:[UIColor colorWithRed:112/255.0f green:112/255.0f blue:112/255.0f alpha:1.0]];
    
    UILabel *lblSaleUnit = [[UILabel alloc] initWithFrame: CGRectMake(196, 6, 62, 30)];
    lblSaleUnit.backgroundColor = [UIColor clearColor];
    lblSaleUnit.font = [UIFont fontWithName:@"HelveticaNeue" size:12];
    lblSaleUnit.numberOfLines = 1;
    lblSaleUnit.contentMode = UIViewContentModeTopLeft;
    lblSaleUnit.textAlignment = NSTextAlignmentCenter;
    lblSaleUnit.textColor = [UIColor grayColor];
    lblSaleUnit.adjustsFontSizeToFitWidth = YES;
    lblSaleUnit.text = @"Sale Unit";
    
    UIView *viewSeperatorSaleUnit = [[UIView alloc] initWithFrame: CGRectMake(258 , 0, 1, 40) ];
    [viewSeperatorSaleUnit setBackgroundColor:[UIColor colorWithRed:112/255.0f green:112/255.0f blue:112/255.0f alpha:1.0]];
    
    UILabel *lblSaleValue = [[UILabel alloc] initWithFrame: CGRectMake(259, 6, 61, 30)];
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
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:branchCellIdentifier];
    
    if (cell == nil)
    {
        cell = _isIphone ? [self createCellContentForIphone:tableView branchCellIdentifier:branchCellIdentifier]
                        :   [self createCellContentForIpad:tableView branchCellIdentifier:branchCellIdentifier];
    }
    
    if(_isIphone){
        
        [self populateCellContentForIphone:cell row:indexPath.row];
    }
    else{
        
        [self populateCellContentForIpad:cell row:indexPath.row];
    }
    
    if(indexPath.row % 2 == 0){
        
        [cell.contentView setBackgroundColor:[UIColor whiteColor]];
    }
    else{
        
        [cell.contentView setBackgroundColor:[UIColor colorWithRed:230/255.0f green:230/255.0f blue:230/255.0f alpha:1.0]];
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}


// for ipad
- (UITableViewCell *) createCellContentForIpad: (UITableView *) tableView branchCellIdentifier: (NSString *) branchCellIdentifier {
    
    UILabel *lblDate, *lblbudgetUnit, *lblBudgetValue, *lblSaleUnit, *lblSaleValue;
    UIView *viewSeperatorDate, *viewSeperatorBudgetUnit, *viewSeperatorBudgetValue, *viewSeperatorSaleUnit;
    
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:branchCellIdentifier];
    [cell setFrame: CGRectMake(0, 0, 640, 50)];
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    
    lblDate = [[UILabel alloc] initWithFrame: CGRectMake(8, 6, 128, 40)];
    [lblDate setBackgroundColor:[UIColor clearColor]];
    lblDate.numberOfLines = 1;
    lblDate.font = [UIFont fontWithName:@"Helvetica" size:12.0];
    lblDate.textColor = [UIColor darkGrayColor];
    lblDate.contentMode = UIViewContentModeBottomLeft;
    lblDate.lineBreakMode = NSLineBreakByTruncatingTail;
    lblDate.adjustsFontSizeToFitWidth = YES;
    lblDate.tag = 10;
    
    viewSeperatorDate = [[UIView alloc] initWithFrame: CGRectMake(136, 0, 2, 50)];
    [viewSeperatorDate setBackgroundColor:[UIColor colorWithRed:112/255.0f green:112/255.0f blue:112/255.0f alpha:1.0]];
    
    lblbudgetUnit = [[UILabel alloc] initWithFrame: CGRectMake(142, 6, 120, 40)];
    lblbudgetUnit.backgroundColor = [UIColor clearColor];
    lblbudgetUnit.font = [UIFont fontWithName:@"HelveticaNeue" size:11];
    lblbudgetUnit.numberOfLines = 1;
    lblbudgetUnit.contentMode = UIViewContentModeTopLeft;
    lblbudgetUnit.lineBreakMode = NSLineBreakByTruncatingTail;
    lblbudgetUnit.textColor = [UIColor grayColor];
    lblbudgetUnit.adjustsFontSizeToFitWidth = YES;
    lblbudgetUnit.tag = 20;
    
    viewSeperatorBudgetUnit = [[UIView alloc] initWithFrame: CGRectMake(262 , 0, 2, 50)];
    [viewSeperatorBudgetUnit setBackgroundColor:[UIColor colorWithRed:112/255.0f green:112/255.0f blue:112/255.0f alpha:1.0]];
    
    lblBudgetValue = [[UILabel alloc] initWithFrame:CGRectMake(268, 6, 120, 40)];
    lblBudgetValue.backgroundColor = [UIColor clearColor];
    lblBudgetValue.font = [UIFont fontWithName:@"HelveticaNeue" size:11];
    lblBudgetValue.numberOfLines = 1;
    lblBudgetValue.contentMode = UIViewContentModeTopLeft;
    lblBudgetValue.lineBreakMode = NSLineBreakByTruncatingTail;
    lblBudgetValue.textColor = [UIColor grayColor];
    lblBudgetValue.adjustsFontSizeToFitWidth = YES;
    lblBudgetValue.tag = 30;
    
    viewSeperatorBudgetValue = [[UIView alloc] initWithFrame:CGRectMake(388 , 0, 2, 50)];
    [viewSeperatorBudgetValue setBackgroundColor:[UIColor colorWithRed:112/255.0f green:112/255.0f blue:112/255.0f alpha:1.0]];
    
    lblSaleUnit = [[UILabel alloc] initWithFrame: CGRectMake(394, 6, 120, 40)];
    lblSaleUnit.backgroundColor = [UIColor clearColor];
    lblSaleUnit.font = [UIFont fontWithName:@"HelveticaNeue" size:11];
    lblSaleUnit.numberOfLines = 1;
    lblSaleUnit.contentMode = UIViewContentModeTopLeft;
    lblSaleUnit.lineBreakMode = NSLineBreakByTruncatingTail;
    lblSaleUnit.textColor = [UIColor grayColor];
    lblSaleUnit.adjustsFontSizeToFitWidth = YES;
    lblSaleUnit.tag = 40;
    
    viewSeperatorSaleUnit = [[UIView alloc] initWithFrame:CGRectMake(514 , 0, 2, 50)];
    [viewSeperatorSaleUnit setBackgroundColor:[UIColor colorWithRed:112/255.0f green:112/255.0f blue:112/255.0f alpha:1.0]];
    
    lblSaleValue = [[UILabel alloc] initWithFrame:CGRectMake(520, 6, 120, 40)];
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
    
    return cell;
    
}


- (void) populateCellContentForIpad : (UITableViewCell *) cell row: (NSInteger) row{
    
    UILabel *lblDate = (UILabel *)[cell.contentView viewWithTag:10];
    UILabel *lblbudgetUnit = (UILabel *)[cell.contentView viewWithTag:20];
    UILabel *lblBudgetValue = (UILabel *)[cell.contentView viewWithTag:30];
    UILabel *lblSaleUnit = (UILabel *)[cell.contentView viewWithTag:40];
    UILabel *lblSaleValue = (UILabel *)[cell.contentView viewWithTag:50];
    
    NSMutableDictionary *saleReport = [_loadSales objectAtIndex:row];
    
    lblDate.text = [NSString stringWithFormat:@"%@, %@", [saleReport valueForKey:KEY_SALES_MONTH], [saleReport valueForKey:KEY_SALES_YEAR]];
    lblbudgetUnit.text = [[saleReport valueForKey:KEY_SALES_BUDGET_UNIT] description];
    lblBudgetValue.text = [[saleReport valueForKey:KEY_SALES_BUDGET_VALUE] description];
    lblSaleUnit.text = [[saleReport valueForKey:KEY_SALES_UNIT] description];
    lblSaleValue.text = [[saleReport valueForKey:KEY_SALES_VALUE] description];
}

// for iphone
- (UITableViewCell *) createCellContentForIphone: (UITableView *) tableView branchCellIdentifier: (NSString *) branchCellIdentifier {
    
    UILabel *lblDate, *lblbudgetUnit, *lblBudgetValue, *lblSaleUnit, *lblSaleValue;
    UIView *viewSeperatorDate, *viewSeperatorBudgetUnit, *viewSeperatorBudgetValue, *viewSeperatorSaleUnit;
    
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:branchCellIdentifier];
    [cell setFrame: CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 40)];
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
    [viewSeperatorDate setBackgroundColor:[UIColor colorWithRed:112/255.0f green:112/255.0f blue:112/255.0f alpha:1.0]];
    
    lblbudgetUnit = [[UILabel alloc] initWithFrame: CGRectMake(72, 6, 59, 30)];
    lblbudgetUnit.backgroundColor = [UIColor clearColor];
    lblbudgetUnit.font = [UIFont fontWithName:@"HelveticaNeue" size:11];
    lblbudgetUnit.numberOfLines = 1;
    lblbudgetUnit.contentMode = UIViewContentModeTopLeft;
    lblbudgetUnit.lineBreakMode = NSLineBreakByTruncatingTail;
    lblbudgetUnit.textColor = [UIColor grayColor];
    lblbudgetUnit.adjustsFontSizeToFitWidth = YES;
    lblbudgetUnit.tag = 20;
    
    viewSeperatorBudgetUnit = [[UIView alloc] initWithFrame: CGRectMake(131 , 0, 1, 40)];
    [viewSeperatorBudgetUnit setBackgroundColor:[UIColor colorWithRed:112/255.0f green:112/255.0f blue:112/255.0f alpha:1.0]];
    
    lblBudgetValue = [[UILabel alloc] initWithFrame:CGRectMake(135, 6, 59, 30) ];
    lblBudgetValue.backgroundColor = [UIColor clearColor];
    lblBudgetValue.font = [UIFont fontWithName:@"HelveticaNeue" size:11];
    lblBudgetValue.numberOfLines = 1;
    lblBudgetValue.contentMode = UIViewContentModeTopLeft;
    lblBudgetValue.lineBreakMode = NSLineBreakByTruncatingTail;
    lblBudgetValue.textColor = [UIColor grayColor];
    lblBudgetValue.adjustsFontSizeToFitWidth = YES;
    lblBudgetValue.tag = 30;
    
    viewSeperatorBudgetValue = [[UIView alloc] initWithFrame:CGRectMake(195 , 0, 1, 40)];
    [viewSeperatorBudgetValue setBackgroundColor:[UIColor colorWithRed:112/255.0f green:112/255.0f blue:112/255.0f alpha:1.0]];
    
    lblSaleUnit = [[UILabel alloc] initWithFrame: CGRectMake(199, 6, 59, 30)];
    lblSaleUnit.backgroundColor = [UIColor clearColor];
    lblSaleUnit.font = [UIFont fontWithName:@"HelveticaNeue" size:11];
    lblSaleUnit.numberOfLines = 1;
    lblSaleUnit.contentMode = UIViewContentModeTopLeft;
    lblSaleUnit.lineBreakMode = NSLineBreakByTruncatingTail;
    lblSaleUnit.textColor = [UIColor grayColor];
    lblSaleUnit.adjustsFontSizeToFitWidth = YES;
    lblSaleUnit.tag = 40;
    
    viewSeperatorSaleUnit = [[UIView alloc] initWithFrame:CGRectMake(258 , 0, 1, 40)];
    [viewSeperatorSaleUnit setBackgroundColor:[UIColor colorWithRed:112/255.0f green:112/255.0f blue:112/255.0f alpha:1.0]];
    
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
    
    return cell;
}

- (void) populateCellContentForIphone : (UITableViewCell *) cell row: (NSInteger) row{
    
    UILabel *lblDate = (UILabel *)[cell.contentView viewWithTag:10];
    UILabel *lblbudgetUnit = (UILabel *)[cell.contentView viewWithTag:20];
    UILabel *lblBudgetValue = (UILabel *)[cell.contentView viewWithTag:30];
    UILabel *lblSaleUnit = (UILabel *)[cell.contentView viewWithTag:40];
    UILabel *lblSaleValue = (UILabel *)[cell.contentView viewWithTag:50];
    
    NSMutableDictionary *saleReport = [_loadSales objectAtIndex:row];
    
    lblDate.text = [NSString stringWithFormat:@"%@, %@", [saleReport valueForKey:KEY_SALES_MONTH], [saleReport valueForKey:KEY_SALES_YEAR]];
    lblbudgetUnit.text = [[saleReport valueForKey:KEY_SALES_BUDGET_UNIT] description];
    lblBudgetValue.text = [[saleReport valueForKey:KEY_SALES_BUDGET_VALUE] description];
    lblSaleUnit.text = [[saleReport valueForKey:KEY_SALES_UNIT] description];
    lblSaleValue.text = [[saleReport valueForKey:KEY_SALES_VALUE] description];
}

@end
