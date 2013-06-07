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
    return 1.0f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 1.0f;
}

- (UIView *) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
}

- (UIView *) tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    NSString *branchCellIdentifier = [NSString stringWithFormat:@"BranchCell"];
    UITableViewCell *cell;
    UILabel *lblName, *lblPrice, *lblSaleUnit, *lblTotalSale;
    UIView *viewSeperatorName, *viewSeperatorPrice, *viewSeperatorUnit;
    
    cell = [tableView dequeueReusableCellWithIdentifier:branchCellIdentifier];
    
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:branchCellIdentifier];
        [cell setFrame:_isIphone ?  CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width -20, 50)
                      :   CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 50) ];
        
        lblName = [[UILabel alloc] initWithFrame:_isIphone ? CGRectMake(4, 6, [UIScreen mainScreen].bounds.size.width -207, 40)
                                                : CGRectMake(8, 10, [UIScreen mainScreen].bounds.size.width - 304, 40)];
        [lblName setBackgroundColor:[UIColor clearColor]];
        lblName.numberOfLines = 1;
        lblName.font = [UIFont fontWithName:@"Helvetica" size:_isIphone ? 16.0 : 20.0];
        lblName.textColor = [UIColor darkGrayColor];
        lblName.contentMode = UIViewContentModeBottomLeft;
        lblName.lineBreakMode = NSLineBreakByTruncatingTail;
        lblName.tag = 10;
        
        viewSeperatorName = [[UIView alloc] initWithFrame:_isIphone ? CGRectMake([UIScreen mainScreen].bounds.size.width - 203, 0, 1, 50)
                                                         : CGRectMake([UIScreen mainScreen].bounds.size.width - 296 , 10, 2, 50)];
        [viewSeperatorName setBackgroundColor:[UIColor lightGrayColor]];
        
        
        lblPrice = [[UILabel alloc] initWithFrame:_isIphone ? CGRectMake([UIScreen mainScreen].bounds.size.width - 202, 6, 60, 40)
                                                      :CGRectMake([UIScreen mainScreen].bounds.size.width - 294, 10, 90, 40)];
        lblPrice.backgroundColor = [UIColor clearColor];
        lblPrice.font = [UIFont fontWithName:@"HelveticaNeue" size:_isIphone ? 11 : 15];
        lblPrice.numberOfLines = 1;
        lblPrice.contentMode = UIViewContentModeTopLeft;
        lblPrice.lineBreakMode = NSLineBreakByTruncatingTail;
        lblPrice.textColor = [UIColor grayColor];
        lblPrice.tag = 20;
        
        viewSeperatorPrice = [[UIView alloc] initWithFrame:_isIphone ? CGRectMake([UIScreen mainScreen].bounds.size.width - 142 , 0, 1, 50)
                                                         : CGRectMake([UIScreen mainScreen].bounds.size.width - 204, 10, 2, 50)];
        [viewSeperatorPrice setBackgroundColor:[UIColor lightGrayColor]];
        
        
        lblSaleUnit = [[UILabel alloc] initWithFrame:_isIphone ? CGRectMake([UIScreen mainScreen].bounds.size.width -141, 6, 60, 40)
                                                 :CGRectMake([UIScreen mainScreen].bounds.size.width -202, 10, 90, 40)];
        lblSaleUnit.backgroundColor = [UIColor clearColor];
        lblSaleUnit.font = [UIFont fontWithName:@"HelveticaNeue" size:_isIphone ? 11 : 15];
        lblSaleUnit.numberOfLines = 1;
        lblSaleUnit.contentMode = UIViewContentModeTopLeft;
        lblSaleUnit.lineBreakMode = NSLineBreakByTruncatingTail;
        lblSaleUnit.textColor = [UIColor grayColor];
        lblSaleUnit.tag = 30;

        
        viewSeperatorUnit = [[UIView alloc] initWithFrame:_isIphone ? CGRectMake([UIScreen mainScreen].bounds.size.width - 81 , 0, 1, 50)
                                                          : CGRectMake([UIScreen mainScreen].bounds.size.width - 112, 10, 2, 50)];
        [viewSeperatorUnit setBackgroundColor:[UIColor lightGrayColor]];
        
        
        lblTotalSale = [[UILabel alloc] initWithFrame:_isIphone ? CGRectMake([UIScreen mainScreen].bounds.size.width - 80, 6, 60, 40)
                                                    :CGRectMake([UIScreen mainScreen].bounds.size.width - 110, 10, 90, 40)];
        lblTotalSale.backgroundColor = [UIColor clearColor];
        lblTotalSale.font = [UIFont fontWithName:@"HelveticaNeue" size:_isIphone ? 11 : 15];
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
    }
    else{
        
        lblName = (UILabel *)[cell.contentView viewWithTag:10];
        lblPrice = (UILabel *)[cell.contentView viewWithTag:20];
        lblSaleUnit = (UILabel *)[cell.contentView viewWithTag:30];
        lblTotalSale = (UILabel *)[cell.contentView viewWithTag:40];
    }
    
    
    //now populate data for the views
    NSMutableDictionary *product = [_loadProduct objectAtIndex:indexPath.row];
    
    lblName.text = [product valueForKey:KEY_BRICKS_PRODUCT_NAME];
    lblPrice.text = [[product valueForKey:KEY_BRICKS_PRODUCT_PRICE] description];
    lblSaleUnit.text = [[product valueForKey:KEY_BRICKS_PRODUCT_SALES_UNIT] description];
    lblTotalSale.text = [[product valueForKey:KEY_BRICKS_PRODUCT_TOTAL_SALE] description];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
}

@end
