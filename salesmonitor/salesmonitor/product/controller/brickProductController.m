//
//  brickProductController.m
//  salesmonitor
//
//  Created by goodcore2 on 6/7/13.
//  Copyright (c) 2013 GoodCore. All rights reserved.
//

#import "brickProductController.h"

@interface brickProductController ()

@property (nonatomic) BOOL isIphone;
@property (nonatomic, strong) NSMutableArray *loadProduct;

@end

@implementation brickProductController

- (id)  init : (BOOL) isIphone {
    
    self = [super init];
    
    if(self){
        _isIphone   = isIphone;
    }
    
    return self;
}

- (void) setLoadProduct : (NSMutableArray *) loadProduct{
    _loadProduct = loadProduct;
}

// selectors and delegates
#pragma product table delegate
- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return  [_loadProduct count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return _isIphone ? 50.0f : 50.0f;
}

- (CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return ([_loadProduct count] <= 0) ? 1.0f : 40.0f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 1.0f;
}

- (UIView *) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    if([_loadProduct count] <= 0 ){
        
        return [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
    }
    else{
        return _isIphone ? [self createHeaderViewForIphone] : [self createHeaderViewForIpad];
    }
}

- (UIView *) createHeaderViewForIpad {
    
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width - 40, 40) ];
    [headerView setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"background_gradient"]]];
    
    UIView *vwBgName = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width - 302, 40)];
    [vwBgName setBackgroundColor:[UIColor colorWithRed:112/255.0f green:112/255.0f blue:112/255.0f alpha:1.0f]];
    
    UILabel *lblName = [[UILabel alloc] initWithFrame:CGRectMake(8, 5, [UIScreen mainScreen].bounds.size.width - 304, 30)];
    [lblName setBackgroundColor:[UIColor clearColor]];
    lblName.font = [UIFont fontWithName:@"HelveticaNeueLTStd-LtCn" size: 18.0];
    lblName.textColor = [UIColor whiteColor];
    lblName.contentMode = UIViewContentModeCenter;
    lblName.textAlignment = NSTextAlignmentCenter;
    lblName.text = @"Name";
    
    UIView *viewSeperatorName = [[UIView alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width - 296 , 0, 2, 40)];
    [viewSeperatorName setBackgroundColor:[UIColor colorWithRed:112/255.0f green:112/255.0f blue:112/255.0f alpha:1.0]];
    
    UIView *vwBgPrice = [[UIView alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width - 290
                                                                 , 0, 82, 40)];
    [vwBgPrice setBackgroundColor:[UIColor colorWithRed:112/255.0f green:112/255.0f blue:112/255.0f alpha:1.0f]];
    
    UILabel *lblPrice = [[UILabel alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width - 294, 5, 90, 30)];
    lblPrice.backgroundColor = [UIColor clearColor];
    lblPrice.font = [UIFont fontWithName:@"HelveticaNeueLTStd-LtCn" size:18.0];
    lblPrice.contentMode = UIViewContentModeCenter;
    lblPrice.textColor = [UIColor whiteColor];
    lblPrice.textAlignment = NSTextAlignmentCenter;
    lblPrice.text = @"Price";
    
    UIView *viewSeperatorPrice = [[UIView alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width - 204, 0, 2, 40)];
    [viewSeperatorPrice setBackgroundColor:[UIColor colorWithRed:112/255.0f green:112/255.0f blue:112/255.0f alpha:1.0]];
    
    UIView *vwBgSaleUnit = [[UIView alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width -198, 0, 82, 40)];
    [vwBgSaleUnit setBackgroundColor:[UIColor colorWithRed:112/255.0f green:112/255.0f blue:112/255.0f alpha:1.0f]];
    
    UILabel *lblSaleUnit = [[UILabel alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width -202, 5, 90, 30)];
    lblSaleUnit.backgroundColor = [UIColor clearColor];
    lblSaleUnit.font = [UIFont fontWithName:@"HelveticaNeueLTStd-LtCn" size: 18.0];
    lblSaleUnit.contentMode = UIViewContentModeCenter;
    lblSaleUnit.textAlignment = NSTextAlignmentCenter;
    lblSaleUnit.textColor = [UIColor whiteColor];
    lblSaleUnit.text = @"Sales";
    
    UIView *viewSeperatorUnit = [[UIView alloc] initWithFrame: CGRectMake([UIScreen mainScreen].bounds.size.width - 112, 0, 2, 40)];
    [viewSeperatorUnit setBackgroundColor:[UIColor colorWithRed:112/255.0f green:112/255.0f blue:112/255.0f alpha:1.0]];
    
    UIView *vwBgTotalSale = [[UIView alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width - 106, 0, 90, 40)];
    [vwBgTotalSale setBackgroundColor:[UIColor colorWithRed:112/255.0f green:112/255.0f blue:112/255.0f alpha:1.0f]];
    
    UILabel *lblTotalSale = [[UILabel alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width - 110, 5, 90, 30)];
    lblTotalSale.backgroundColor = [UIColor clearColor];
    lblTotalSale.font = [UIFont fontWithName:@"HelveticaNeueLTStd-LtCn" size: 18.0];
    lblTotalSale.contentMode = UIViewContentModeCenter;
    lblTotalSale.textAlignment = NSTextAlignmentCenter;
    lblTotalSale.textColor = [UIColor whiteColor];
    lblTotalSale.text = @"Total";
    
    [headerView addSubview:vwBgName];
    [headerView addSubview:lblName];
    [headerView addSubview:viewSeperatorName];
    [headerView addSubview:vwBgPrice];
    [headerView addSubview:lblPrice];
    [headerView addSubview:viewSeperatorPrice];
    [headerView addSubview:vwBgSaleUnit];
    [headerView addSubview:lblSaleUnit];
    [headerView addSubview:viewSeperatorUnit];
    [headerView addSubview:vwBgTotalSale];
    [headerView addSubview:lblTotalSale];
    
    return headerView;
}

- (UIView *) createHeaderViewForIphone {
    
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width -30, 40)];
    [headerView setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"background_gradient"]]];
    
    UIView *vwBgName = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width - 207, 40)];
    [vwBgName setBackgroundColor:[UIColor colorWithRed:112/255.0f green:112/255.0f blue:112/255.0f alpha:1.0f]];
    
    UILabel *lblName = [[UILabel alloc] initWithFrame:CGRectMake(4, 5, [UIScreen mainScreen].bounds.size.width -207, 30)];
    [lblName setBackgroundColor:[UIColor clearColor]];
    lblName.font = [UIFont fontWithName:@"Helvetica" size:14.0];
    lblName.textColor = [UIColor whiteColor];
    lblName.contentMode = UIViewContentModeCenter;
    lblName.textAlignment = NSTextAlignmentCenter;
    lblName.text = @"Name";
    
    UIView *viewSeperatorName = [[UIView alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width - 203, 0, 1, 40)];
    [viewSeperatorName setBackgroundColor:[UIColor colorWithRed:112/255.0f green:112/255.0f blue:112/255.0f alpha:1.0]];
    
    UIView *vwBgPrice = [[UIView alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width - 198, 0, 52, 40)];
    [vwBgPrice setBackgroundColor:[UIColor colorWithRed:112/255.0f green:112/255.0f blue:112/255.0f alpha:1.0f]];
    
    UILabel *lblPrice = [[UILabel alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width - 202, 5, 60, 30)];
    lblPrice.backgroundColor = [UIColor clearColor];
    lblPrice.font = [UIFont fontWithName:@"HelveticaNeue" size:14.0];
    lblPrice.contentMode = UIViewContentModeCenter;
    lblPrice.textColor = [UIColor whiteColor];
    lblPrice.textAlignment = NSTextAlignmentCenter;
    lblPrice.text = @"Price";
    
    UIView *viewSeperatorPrice = [[UIView alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width - 142 , 0, 1, 40)];
    [viewSeperatorPrice setBackgroundColor:[UIColor colorWithRed:112/255.0f green:112/255.0f blue:112/255.0f alpha:1.0]];
    
    UIView *vwBgSaleUnit = [[UIView alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width -136, 0, 52, 40)];
    [vwBgSaleUnit setBackgroundColor:[UIColor colorWithRed:112/255.0f green:112/255.0f blue:112/255.0f alpha:1.0f]];
    
    UILabel *lblSaleUnit = [[UILabel alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width -141, 5, 60, 30)];
    lblSaleUnit.backgroundColor = [UIColor clearColor];
    lblSaleUnit.font = [UIFont fontWithName:@"HelveticaNeue" size:14.0];
    lblSaleUnit.contentMode = UIViewContentModeCenter;
    lblSaleUnit.textAlignment = NSTextAlignmentCenter;
    lblSaleUnit.textColor = [UIColor whiteColor];
    lblSaleUnit.text = @"Sales";
    
    UIView *viewSeperatorUnit = [[UIView alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width - 81 , 0, 1, 40)];
    [viewSeperatorUnit setBackgroundColor:[UIColor colorWithRed:112/255.0f green:112/255.0f blue:112/255.0f alpha:1.0]];
    
    UIView *vwBgTotalSale = [[UIView alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width - 76, 0, 60,40)];
    [vwBgTotalSale setBackgroundColor:[UIColor colorWithRed:112/255.0f green:112/255.0f blue:112/255.0f alpha:1.0f]];
    
    UILabel *lblTotalSale = [[UILabel alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width - 80, 5, 60, 30)];
    lblTotalSale.backgroundColor = [UIColor clearColor];
    lblTotalSale.font = [UIFont fontWithName:@"HelveticaNeue" size:14.0];
    lblTotalSale.contentMode = UIViewContentModeCenter;
    lblTotalSale.textAlignment = NSTextAlignmentCenter;
    lblTotalSale.textColor = [UIColor whiteColor];
    lblTotalSale.text = @"Total";
    
    [headerView addSubview:vwBgName];
    [headerView addSubview:lblName];
    [headerView addSubview:viewSeperatorName];
    [headerView addSubview:vwBgPrice];
    [headerView addSubview:lblPrice];
    [headerView addSubview:viewSeperatorPrice];
    [headerView addSubview:vwBgSaleUnit];
    [headerView addSubview:lblSaleUnit];
    [headerView addSubview:viewSeperatorUnit];
    [headerView addSubview:vwBgTotalSale];
    [headerView addSubview:lblTotalSale];
    
    return headerView;
}

- (UIView *) tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    NSString *branchCellIdentifier = [NSString stringWithFormat:@"BranchCell"];    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:branchCellIdentifier];
    
    if (cell == nil)
    {
        cell = _isIphone ? [self createCellContentForIphone:tableView branchCellIdentifier:branchCellIdentifier]
                : [self createCellContentForIpad:tableView branchCellIdentifier:branchCellIdentifier];
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
    
    UILabel *lblName, *lblPrice, *lblSaleUnit, *lblTotalSale;
    UIView *viewSeperatorName, *viewSeperatorPrice, *viewSeperatorUnit;
    
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:branchCellIdentifier];
    [cell setFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width-40, 50) ];
    
    lblName = [[UILabel alloc] initWithFrame:CGRectMake(8, 10, [UIScreen mainScreen].bounds.size.width - 304, 40)];
    [lblName setBackgroundColor:[UIColor clearColor]];
    lblName.numberOfLines = 1;
    lblName.font = [UIFont fontWithName:@"HelveticaNeueLTStd-LtCn" size: 20.0];
    lblName.textColor = [UIColor darkGrayColor];
    lblName.contentMode = UIViewContentModeBottomLeft;
    lblName.lineBreakMode = NSLineBreakByTruncatingTail;
    lblName.textAlignment = NSTextAlignmentLeft;
    lblName.tag = 10;
    
    viewSeperatorName = [[UIView alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width - 296 , 0, 2, 50)];
    [viewSeperatorName setBackgroundColor:[UIColor colorWithRed:112/255.0f green:112/255.0f blue:112/255.0f alpha:1.0]];
    
    lblPrice = [[UILabel alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width - 294, 10, 90, 40)];
    lblPrice.backgroundColor = [UIColor clearColor];
    lblPrice.font = [UIFont fontWithName:@"HelveticaNeue" size:15];
    lblPrice.numberOfLines = 1;
    lblPrice.contentMode = UIViewContentModeTopLeft;
    lblPrice.lineBreakMode = NSLineBreakByTruncatingTail;
    lblPrice.textColor = [UIColor grayColor];
    lblPrice.tag = 20;
    
    viewSeperatorPrice = [[UIView alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width - 204, 0, 2, 50)];
    [viewSeperatorPrice setBackgroundColor:[UIColor colorWithRed:112/255.0f green:112/255.0f blue:112/255.0f alpha:1.0]];
    
    lblSaleUnit = [[UILabel alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width -202, 10, 90, 40)];
    lblSaleUnit.backgroundColor = [UIColor clearColor];
    lblSaleUnit.font = [UIFont fontWithName:@"HelveticaNeue" size: 15];
    lblSaleUnit.numberOfLines = 1;
    lblSaleUnit.contentMode = UIViewContentModeTopLeft;
    lblSaleUnit.lineBreakMode = NSLineBreakByTruncatingTail;
    lblSaleUnit.textColor = [UIColor grayColor];
    lblSaleUnit.tag = 30;
    
    viewSeperatorUnit = [[UIView alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width - 112, 0, 2, 50)];
    [viewSeperatorUnit setBackgroundColor:[UIColor colorWithRed:112/255.0f green:112/255.0f blue:112/255.0f alpha:1.0]];
    
    lblTotalSale = [[UILabel alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width - 110, 10, 90, 40)];
    lblTotalSale.backgroundColor = [UIColor clearColor];
    lblTotalSale.font = [UIFont fontWithName:@"HelveticaNeue" size:15];
    lblTotalSale.numberOfLines = 1;
    lblTotalSale.contentMode = UIViewContentModeTopLeft;
    lblTotalSale.lineBreakMode = NSLineBreakByTruncatingTail;
    lblTotalSale.textColor = [UIColor grayColor];
    lblTotalSale.tag = 40;
    
    [cell.contentView addSubview:lblName];
    [cell.contentView addSubview:viewSeperatorName];
    [cell.contentView addSubview:lblPrice];
    [cell.contentView addSubview:viewSeperatorPrice];
    [cell.contentView addSubview:lblSaleUnit];
    [cell.contentView addSubview:viewSeperatorUnit];
    [cell.contentView addSubview:lblTotalSale];
    
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    
    return cell;
}

- (void) populateCellContentForIpad : (UITableViewCell *) cell row: (NSInteger) row{
    
    UILabel *lblName = (UILabel *)[cell.contentView viewWithTag:10];
    UILabel *lblPrice = (UILabel *)[cell.contentView viewWithTag:20];
    UILabel *lblSaleUnit = (UILabel *)[cell.contentView viewWithTag:30];
    UILabel *lblTotalSale = (UILabel *)[cell.contentView viewWithTag:40];
    
    //now populate data for the views
    NSMutableDictionary *product = [_loadProduct objectAtIndex:row];
    
    lblName.text = [NSString stringWithFormat:@"   %@",[product valueForKey:KEY_BRICKS_PRODUCT_NAME]];
    lblPrice.text = [NSString stringWithFormat:@"   %@",[[product valueForKey:KEY_BRICKS_PRODUCT_PRICE] description]];
    lblSaleUnit.text = [NSString stringWithFormat:@"   %@",[[product valueForKey:KEY_BRICKS_PRODUCT_SALES_UNIT] description]];
    lblTotalSale.text = [NSString stringWithFormat:@"   %@",[[product valueForKey:KEY_BRICKS_PRODUCT_TOTAL_SALE] description]];
}


// for iphone
- (UITableViewCell *) createCellContentForIphone: (UITableView *) tableView branchCellIdentifier: (NSString *) branchCellIdentifier {
    
    UILabel *lblName, *lblPrice, *lblSaleUnit, *lblTotalSale;
    UIView *viewSeperatorName, *viewSeperatorPrice, *viewSeperatorUnit;
    
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:branchCellIdentifier];
    [cell setFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width -30, 50)];
    
    lblName = [[UILabel alloc] initWithFrame:CGRectMake(4, 6, [UIScreen mainScreen].bounds.size.width -207, 40)];
    [lblName setBackgroundColor:[UIColor clearColor]];
    lblName.numberOfLines = 1;
    lblName.font = [UIFont fontWithName:@"Helvetica" size:16.0];
    lblName.textColor = [UIColor darkGrayColor];
    lblName.contentMode = UIViewContentModeBottomLeft;
    lblName.textAlignment = NSTextAlignmentLeft;
    lblName.lineBreakMode = NSLineBreakByTruncatingTail;
    lblName.tag = 10;
    
    viewSeperatorName = [[UIView alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width - 203, 0, 1, 50)];
    [viewSeperatorName setBackgroundColor:[UIColor colorWithRed:112/255.0f green:112/255.0f blue:112/255.0f alpha:1.0]];
    
    lblPrice = [[UILabel alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width - 202, 6, 60, 40)];
    lblPrice.backgroundColor = [UIColor clearColor];
    lblPrice.font = [UIFont fontWithName:@"HelveticaNeue" size: 11 ];
    lblPrice.numberOfLines = 1;
    lblPrice.contentMode = UIViewContentModeTopLeft;
    lblPrice.lineBreakMode = NSLineBreakByTruncatingTail;
    lblPrice.textColor = [UIColor grayColor];
    lblPrice.tag = 20;
    
    viewSeperatorPrice = [[UIView alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width - 142 , 0, 1, 50)];
    [viewSeperatorPrice setBackgroundColor:[UIColor colorWithRed:112/255.0f green:112/255.0f blue:112/255.0f alpha:1.0]];
    
    lblSaleUnit = [[UILabel alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width -141, 6, 60, 40)];
    lblSaleUnit.backgroundColor = [UIColor clearColor];
    lblSaleUnit.font = [UIFont fontWithName:@"HelveticaNeue" size:11];
    lblSaleUnit.numberOfLines = 1;
    lblSaleUnit.contentMode = UIViewContentModeTopLeft;
    lblSaleUnit.lineBreakMode = NSLineBreakByTruncatingTail;
    lblSaleUnit.textColor = [UIColor grayColor];
    lblSaleUnit.tag = 30;
    
    viewSeperatorUnit = [[UIView alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width - 81 , 0, 1, 50)];
    [viewSeperatorUnit setBackgroundColor:[UIColor colorWithRed:112/255.0f green:112/255.0f blue:112/255.0f alpha:1.0]];
    
    lblTotalSale = [[UILabel alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width - 80, 6, 60, 40)];
    lblTotalSale.backgroundColor = [UIColor clearColor];
    lblTotalSale.font = [UIFont fontWithName:@"HelveticaNeue" size:11];
    lblTotalSale.numberOfLines = 1;
    lblTotalSale.contentMode = UIViewContentModeTopLeft;
    lblTotalSale.lineBreakMode = NSLineBreakByTruncatingTail;
    lblTotalSale.textColor = [UIColor grayColor];
    lblTotalSale.tag = 40;
    
    
    [cell.contentView addSubview:lblName];
    [cell.contentView addSubview:viewSeperatorName];
    [cell.contentView addSubview:lblPrice];
    [cell.contentView addSubview:viewSeperatorPrice];
    [cell.contentView addSubview:lblSaleUnit];
    [cell.contentView addSubview:viewSeperatorUnit];
    [cell.contentView addSubview:lblTotalSale];
    
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    
    return cell;
}

- (void) populateCellContentForIphone : (UITableViewCell *) cell row: (NSInteger) row{
 
    UILabel *lblName = (UILabel *)[cell.contentView viewWithTag:10];
    UILabel *lblPrice = (UILabel *)[cell.contentView viewWithTag:20];
    UILabel *lblSaleUnit = (UILabel *)[cell.contentView viewWithTag:30];
    UILabel *lblTotalSale = (UILabel *)[cell.contentView viewWithTag:40];
    
    //now populate data for the views
    NSMutableDictionary *product = [_loadProduct objectAtIndex:row];
    
    lblName.text = [NSString stringWithFormat:@"   %@",[product valueForKey:KEY_BRICKS_PRODUCT_NAME]];
    lblPrice.text = [NSString stringWithFormat:@"   %@",[[product valueForKey:KEY_BRICKS_PRODUCT_PRICE] description]];
    lblSaleUnit.text = [NSString stringWithFormat:@"   %@",[[product valueForKey:KEY_BRICKS_PRODUCT_SALES_UNIT] description]];
    lblTotalSale.text = [NSString stringWithFormat:@"   %@",[[product valueForKey:KEY_BRICKS_PRODUCT_TOTAL_SALE] description]];
}

@end
