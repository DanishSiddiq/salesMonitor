//
//  productController.m
//  salesmonitor
//
//  Created by goodcore2 on 6/5/13.
//  Copyright (c) 2013 GoodCore. All rights reserved.
//

#import "productController.h"


@interface productController ()

@property (nonatomic) BOOL isIphone;
@property (nonatomic, strong) NSMutableArray *loadProduct;
@property (nonatomic, strong) id<productControllerDelegate> viewController;

@end

@implementation productController

- (id)      init : (BOOL) isIphone
     loadProduct :(NSMutableArray *) loadProduct
  viewController : (id<productControllerDelegate>)viewController{
    
    self = [super init];
    
    if(self){
        _loadProduct = loadProduct;
        _isIphone   = isIphone;
        _viewController    = viewController;
    }
    
    return self;
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
    return _isIphone ? 80.0f : 160.0f;
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
    
    cell = [tableView dequeueReusableCellWithIdentifier:branchCellIdentifier];
    
    if (cell == nil)
    {
        cell = _isIphone ? [self createCellContentForIphone:tableView branchCellIdentifier:branchCellIdentifier]
                        : [self createCellContentForIpad:tableView branchCellIdentifier:branchCellIdentifier];
    }    
    
    if(_isIphone){
        [self populateCellContentForIPhone:cell row:indexPath.row];
    }
    else{
        [self populateCellContentForIPad:cell row:indexPath.row];
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if([_viewController respondsToSelector:@selector(productSelected:)]){
        [_viewController productSelected:[_loadProduct objectAtIndex:indexPath.row]];
    }
}


// creation logic and data manipulation logic
// for iphone
- (UITableViewCell *) createCellContentForIphone :(UITableView *) tableView branchCellIdentifier:(NSString *) branchCellIdentifier {
    
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:branchCellIdentifier];
    [cell setFrame:CGRectMake(0, 0, tableView.frame.size.width, 80) ];
    [cell setBackgroundColor:[UIColor clearColor]];
    
    UIImageView *imgViewBG = [[UIImageView alloc] initWithFrame:CGRectMake(0, 05, tableView.frame.size.width, 70)];
    [imgViewBG setContentMode:UIViewContentModeScaleAspectFill];
    [imgViewBG setClipsToBounds:YES];
    [imgViewBG setImage:[UIImage imageNamed:@"iphonemedDetailsBar"]];
    
    
    UIImageView *imgViewProduct = [[UIImageView alloc] initWithFrame:CGRectMake(2, 07, 58, 58)];
    [imgViewProduct setContentMode:UIViewContentModeScaleAspectFill];
    [imgViewProduct setClipsToBounds:YES];
    [[imgViewProduct layer] setBorderColor:[UIColor colorWithRed:146/255.0f green:146/255.0f blue:146/255.0f alpha:1.0].CGColor];
    [[imgViewProduct layer] setBorderWidth:1.0];
    imgViewProduct.tag = 10;
    
    UILabel *lblName = [[UILabel alloc] initWithFrame:CGRectMake(64, 7, 140, 20)];
    [lblName setBackgroundColor:[UIColor clearColor]];
    lblName.numberOfLines = 1;
    lblName.font = [UIFont fontWithName:@"Helvetica" size:18.0];
    lblName.textColor = [UIColor colorWithRed:0/255.0f green:83/255.0f blue:167/255.0f alpha:1.0];
    lblName.contentMode = UIViewContentModeBottomLeft;
    lblName.lineBreakMode = NSLineBreakByTruncatingTail;
    lblName.tag = 20;
    
    UILabel *lblTheraputicClass = [[UILabel alloc] initWithFrame:CGRectMake(64, 26, 220, 16)];
    lblTheraputicClass.backgroundColor = [UIColor clearColor];
    lblTheraputicClass.font = [UIFont fontWithName:@"HelveticaNeue" size:14];
    lblTheraputicClass.numberOfLines = 1;
    lblTheraputicClass.contentMode = UIViewContentModeTopLeft;
    lblTheraputicClass.lineBreakMode = NSLineBreakByTruncatingTail;
    lblTheraputicClass.textColor = [UIColor colorWithRed:197/255.0f green:197/255.0f blue:197/255.0f alpha:1.0];
    lblTheraputicClass.backgroundColor = [UIColor colorWithRed:51/255.0f green:51/255.0f blue:51/255.0f alpha:1.0];
    lblTheraputicClass.tag = 30;
    
    UILabel *lblIndication = [[UILabel alloc] initWithFrame:CGRectMake(64, 48, 220, 22)];
    lblIndication.backgroundColor = [UIColor clearColor];
    lblIndication.font = [UIFont fontWithName:@"HelveticaNeue" size:14];
    lblIndication.numberOfLines = 2;
    lblIndication.contentMode = UIViewContentModeTopLeft;
    lblIndication.lineBreakMode = NSLineBreakByTruncatingTail;
    lblIndication.textColor = [UIColor grayColor];
    lblIndication.backgroundColor = [UIColor colorWithRed:235/255.0f green:235/255.0f blue:235/255.0f alpha:1.0];
    lblIndication.tag = 40;
    
    UIView *vwBackPrice = [[UIView alloc] initWithFrame:CGRectMake(212, 07, 70, 18)];
    [vwBackPrice setBackgroundColor:[UIColor colorWithRed:71/255.0f green:192/255.0f blue:88/255.0f alpha:1.0]];
    
    UIImageView *imgViewPrice = [[UIImageView alloc] initWithFrame:CGRectMake(214, 8, 16, 16)];
    [imgViewPrice setClipsToBounds:YES];
    [imgViewPrice setContentMode:UIViewContentModeScaleAspectFill];
    [imgViewPrice setImage:[UIImage imageNamed:@"priceIcon"]];
    
    UILabel *lblPrice = [[UILabel alloc] initWithFrame:CGRectMake(236, 7, 36, 18)];
    lblPrice.backgroundColor = [UIColor clearColor];
    lblPrice.font = [UIFont fontWithName:@"HelveticaNeue" size:14];
    lblPrice.numberOfLines = 1;
    lblPrice.contentMode = UIViewContentModeTopLeft;
    lblPrice.lineBreakMode = NSLineBreakByTruncatingTail;
    lblPrice.textColor = [UIColor colorWithRed:0/255.0f green:83/255.0f blue:167/255.0f alpha:1.0];
    lblPrice.tag = 50;
    
    UILabel *lblSaleUnit = [[UILabel alloc] initWithFrame:CGRectMake(tableView.frame.size.width - 34 , 7, 34, 35)];
    lblSaleUnit.backgroundColor = [UIColor clearColor];
    lblSaleUnit.font = [UIFont fontWithName:@"HelveticaNeue" size:14];
    lblSaleUnit.numberOfLines = 1;
    lblSaleUnit.contentMode = UIViewContentModeCenter;
    lblSaleUnit.textAlignment = NSTextAlignmentCenter;
    lblSaleUnit.lineBreakMode = NSLineBreakByTruncatingTail;
    lblSaleUnit.textColor = [UIColor colorWithRed:0/255.0f green:83/255.0f blue:167/255.0f alpha:1.0];
    lblSaleUnit.tag = 60;
    
    UILabel *lblBudgetUnit = [[UILabel alloc] initWithFrame:CGRectMake(tableView.frame.size.width - 34 , 44, 34, 35)];
    lblBudgetUnit.backgroundColor = [UIColor clearColor];
    lblBudgetUnit.font = [UIFont fontWithName:@"HelveticaNeue" size:14];
    lblBudgetUnit.numberOfLines = 1;
    lblBudgetUnit.contentMode = UIViewContentModeCenter;
    lblBudgetUnit.textAlignment = NSTextAlignmentCenter;
    lblBudgetUnit.lineBreakMode = NSLineBreakByTruncatingTail;
    lblBudgetUnit.textColor = [UIColor colorWithRed:0/255.0f green:83/255.0f blue:167/255.0f alpha:1.0];
    lblBudgetUnit.tag = 70;
    
    [cell.contentView addSubview:imgViewBG];
    [cell.contentView addSubview:imgViewProduct];
    [cell.contentView addSubview:lblName];
    [cell.contentView addSubview:lblTheraputicClass];
    [cell.contentView addSubview:lblIndication];
    [cell.contentView addSubview:vwBackPrice];
    [cell.contentView addSubview:imgViewPrice];
    [cell.contentView addSubview:lblPrice];
    [cell.contentView addSubview:lblSaleUnit];
    [cell.contentView addSubview:lblBudgetUnit];
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    
    return cell;
}

- (void) populateCellContentForIPhone : (UITableViewCell *) cell row : (NSInteger) row {
    
    
    UIImageView *imgViewProduct = (UIImageView *)[cell.contentView viewWithTag:10];
    UILabel *lblName = (UILabel *)[cell.contentView viewWithTag:20];
    UILabel *lblTheraputicClass = (UILabel *)[cell.contentView viewWithTag:30];
    UILabel *lblIndication = (UILabel *)[cell.contentView viewWithTag:40];
    UILabel *lblPrice = (UILabel *)[cell.contentView viewWithTag:50];
    UILabel *lblSaleUnit = (UILabel *)[cell.contentView viewWithTag:60];
    UILabel *lblBudgetUnit = (UILabel *)[cell.contentView viewWithTag:70];
    
    //now populate data for the views
    NSMutableDictionary *product = [_loadProduct objectAtIndex:row];
    
    NSURL *candidateURL = [NSURL URLWithString: [product valueForKey:KEY_PRODUCT_PACKSHOT] ? [product valueForKey:KEY_PRODUCT_PACKSHOT] : @""];
    if (candidateURL && candidateURL.scheme && candidateURL.host){
        
        [imgViewProduct setImageWithURL:candidateURL
                       placeholderImage:[UIImage imageNamed:@"blue-circle.png"]
                                success:^(UIImage *image) {
                                }
                                failure:^(NSError *error) {
                                }
         ];
    }
    else{
        
        [imgViewProduct setImage:[UIImage imageNamed:@"blue-circle.png"]];
    }
    
    lblName.text = [product valueForKey:KEY_PRODUCT_NAME];
    lblTheraputicClass.text = [product valueForKey:KEY_PRODUCT_THERAPUTIC_CLASS];
    lblIndication.text = [product valueForKey:KEY_PRODUCT_INDICATION];
    lblPrice.text = [NSString stringWithFormat:@"$ %@", [[product valueForKey:KEY_PRODUCT_PRICE] description]];
    lblSaleUnit.text = [[product valueForKey:KEY_PRODUCT_SALES_UNIT] description];
    lblBudgetUnit.text = [[product valueForKey:KEY_PRODUCT_BUDGET_UNITS] description];
    
    
    CGSize size = [[product valueForKey:KEY_PRODUCT_THERAPUTIC_CLASS]
                   sizeWithFont:lblTheraputicClass.font
                   constrainedToSize:lblTheraputicClass.frame.size
                   lineBreakMode:lblTheraputicClass.lineBreakMode];
    
    
    if(size.width < 220){
        
        lblTheraputicClass.frame = CGRectMake(lblTheraputicClass.frame.origin.x
                                              , lblTheraputicClass.frame.origin.y
                                              , size.width
                                              , size.height);
    }
}



// ipad
- (UITableViewCell *) createCellContentForIpad: (UITableView *) tableView branchCellIdentifier: (NSString *) branchCellIdentifier {
    
    
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:branchCellIdentifier];
    [cell setFrame:CGRectMake(0, 0, tableView.frame.size.width, 160) ];
    [cell setBackgroundColor:[UIColor clearColor]];
    
    UIImageView *imgViewBG = [[UIImageView alloc] initWithFrame:CGRectMake(0, 10, tableView.frame.size.width, 140)];
    [imgViewBG setContentMode:UIViewContentModeScaleAspectFill];
    [imgViewBG setClipsToBounds:YES];
    [imgViewBG setImage:[UIImage imageNamed:@"medDetailsBar"]];
    
    
    UIImageView *imgViewProduct = [[UIImageView alloc] initWithFrame:CGRectMake(4, 14, 132, 132)];
    [imgViewProduct setContentMode:UIViewContentModeScaleAspectFill];
    [imgViewProduct setClipsToBounds:YES];
    [[imgViewProduct layer] setBorderColor:[UIColor colorWithRed:146/255.0f green:146/255.0f blue:146/255.0f alpha:1.0].CGColor];
    [[imgViewProduct layer] setBorderWidth:1.0];
    imgViewProduct.tag = 10;
    
    UILabel *lblName = [[UILabel alloc] initWithFrame:CGRectMake(140, 14, 400, 26)];
    [lblName setBackgroundColor:[UIColor clearColor]];
    lblName.numberOfLines = 1;
    lblName.font = [UIFont fontWithName:@"HelveticaNeue-ThCn" size:30.0];
    lblName.textColor = [UIColor colorWithRed:0/255.0f green:83/255.0f blue:167/255.0f alpha:1.0];
    lblName.contentMode = UIViewContentModeBottomLeft;
    lblName.lineBreakMode = NSLineBreakByTruncatingTail;
    lblName.tag = 20;
    
    UILabel *lblTheraputicClass = [[UILabel alloc] initWithFrame:CGRectMake(140, 40, tableView.frame.size.width - 225, 22)];
    lblTheraputicClass.backgroundColor = [UIColor clearColor];
    lblTheraputicClass.font = [UIFont fontWithName:@"HelveticaNeue" size:16];
    lblTheraputicClass.numberOfLines = 1;
    lblTheraputicClass.lineBreakMode = NSLineBreakByTruncatingTail;
    lblTheraputicClass.textColor = [UIColor whiteColor];
    lblTheraputicClass.backgroundColor = [UIColor colorWithRed:51/255.0f green:51/255.0f blue:51/255.0f alpha:1.0];
    lblTheraputicClass.tag = 30;
    
    UILabel *lblIndication = [[UILabel alloc] initWithFrame:CGRectMake(140, 72, tableView.frame.size.width - 225, 72)];
    lblIndication.backgroundColor = [UIColor clearColor];
    lblIndication.font = [UIFont fontWithName:@"HelveticaNeue" size:15];
    lblIndication.numberOfLines = 2;
    lblIndication.contentMode = UIViewContentModeTopLeft;
    lblIndication.lineBreakMode = NSLineBreakByTruncatingTail;
    lblIndication.textColor = [UIColor grayColor];
    lblIndication.backgroundColor = [UIColor colorWithRed:235/255.0f green:235/255.0f blue:235/255.0f alpha:1.0];
    lblIndication.tag = 40;
    
    UIView *vwBackPrice = [[UIView alloc] initWithFrame:CGRectMake(530, 12, 142, 27)];
    [vwBackPrice setBackgroundColor:[UIColor colorWithRed:71/255.0f green:192/255.0f blue:88/255.0f alpha:1.0]];
    
    UIImageView *imgViewPrice = [[UIImageView alloc] initWithFrame:CGRectMake(530, 12, 32, 27)];
    [imgViewPrice setClipsToBounds:YES];
    [imgViewPrice setContentMode:UIViewContentModeScaleAspectFill];
    [imgViewPrice setImage:[UIImage imageNamed:@"priceIcon"]];
    
    UILabel *lblPrice = [[UILabel alloc] initWithFrame:CGRectMake(570, 17, 100, 28)];
    lblPrice.backgroundColor = [UIColor clearColor];
    lblPrice.font = [UIFont fontWithName:@"HelveticaNeueLTStd-ThCn" size:22];
    lblPrice.numberOfLines = 1;
    lblPrice.contentMode = UIViewContentModeTopLeft;
    lblPrice.lineBreakMode = NSLineBreakByTruncatingTail;
    lblPrice.textColor = [UIColor whiteColor];
    lblPrice.tag = 50;
    
    UILabel *lblSaleUnit = [[UILabel alloc] initWithFrame:CGRectMake(tableView.frame.size.width - 73.5 , 17, 70, 60)];
    lblSaleUnit.backgroundColor = [UIColor clearColor];
    lblSaleUnit.font = [UIFont fontWithName:@"HelveticaNeueLTStd-HvCn" size:20];
    lblSaleUnit.numberOfLines = 1;
    lblSaleUnit.contentMode = UIViewContentModeCenter;
    lblSaleUnit.textAlignment = NSTextAlignmentCenter;
    lblSaleUnit.lineBreakMode = NSLineBreakByTruncatingTail;
    lblSaleUnit.textColor = [UIColor colorWithRed:0/255.0f green:83/255.0f blue:167/255.0f alpha:1.0];
    lblSaleUnit.tag = 60;
    
    UILabel *lblBudgetUnit = [[UILabel alloc] initWithFrame:CGRectMake(tableView.frame.size.width - 73.5 , 90, 70, 60)];
    lblBudgetUnit.backgroundColor = [UIColor clearColor];
    lblBudgetUnit.font = [UIFont fontWithName:@"HelveticaNeueLTStd-HvCn" size:20];
    lblBudgetUnit.numberOfLines = 1;
    lblBudgetUnit.contentMode = UIViewContentModeCenter;
    lblBudgetUnit.textAlignment = NSTextAlignmentCenter;
    lblBudgetUnit.lineBreakMode = NSLineBreakByTruncatingTail;
    lblBudgetUnit.textColor = [UIColor colorWithRed:0/255.0f green:83/255.0f blue:167/255.0f alpha:1.0];
    lblBudgetUnit.tag = 70;
    
    [cell.contentView addSubview:imgViewBG];
    [cell.contentView addSubview:imgViewProduct];
    [cell.contentView addSubview:lblName];
    [cell.contentView addSubview:lblTheraputicClass];
    [cell.contentView addSubview:lblIndication];
    [cell.contentView addSubview:vwBackPrice];
    [cell.contentView addSubview:imgViewPrice];
    [cell.contentView addSubview:lblPrice];
    [cell.contentView addSubview:lblSaleUnit];
    [cell.contentView addSubview:lblBudgetUnit];
    
    
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    
    return cell;
}

- (void) populateCellContentForIPad : (UITableViewCell *) cell row: (NSInteger) row {
    
    UIImageView *imgViewProduct = (UIImageView *)[cell.contentView viewWithTag:10];
    UILabel *lblName = (UILabel *)[cell.contentView viewWithTag:20];
    UILabel *lblTheraputicClass = (UILabel *)[cell.contentView viewWithTag:30];
    UILabel *lblIndication = (UILabel *)[cell.contentView viewWithTag:40];
    UILabel *lblPrice = (UILabel *)[cell.contentView viewWithTag:50];
    UILabel *lblSaleUnit = (UILabel *)[cell.contentView viewWithTag:60];
    UILabel *lblBudgetUnit = (UILabel *)[cell.contentView viewWithTag:70];
    
    //now populate data for the views
    NSMutableDictionary *product = [_loadProduct objectAtIndex:row];
    
    NSURL *candidateURL = [NSURL URLWithString: [product valueForKey:KEY_PRODUCT_PACKSHOT] ? [product valueForKey:KEY_PRODUCT_PACKSHOT] : @""];
    if (candidateURL && candidateURL.scheme && candidateURL.host){
        
        [imgViewProduct setImageWithURL:candidateURL
                       placeholderImage:[UIImage imageNamed:@"blue-circle.png"]
                                success:^(UIImage *image) {
                                }
                                failure:^(NSError *error) {
                                }
         ];
    }
    else{
        
        [imgViewProduct setImage:[UIImage imageNamed:@"blue-circle.png"]];
    }
    
    lblName.text = [[product valueForKey:KEY_PRODUCT_NAME] uppercaseString];
    lblTheraputicClass.text = [product valueForKey:KEY_PRODUCT_THERAPUTIC_CLASS];
    lblIndication.text = [product valueForKey:KEY_PRODUCT_INDICATION];
    lblPrice.text = [NSString stringWithFormat:@"$ %@", [[product valueForKey:KEY_PRODUCT_PRICE] description]];
    lblSaleUnit.text = [[product valueForKey:KEY_PRODUCT_SALES_UNIT] description];
    lblBudgetUnit.text = [[product valueForKey:KEY_PRODUCT_BUDGET_UNITS] description];
    
    
    CGSize size = [[product valueForKey:KEY_PRODUCT_THERAPUTIC_CLASS]
                   sizeWithFont:lblTheraputicClass.font
                   constrainedToSize:lblTheraputicClass.frame.size
                   lineBreakMode:lblTheraputicClass.lineBreakMode];
    
    
    if(size.width < 300){
        
        lblTheraputicClass.frame = CGRectMake(lblTheraputicClass.frame.origin.x
                                              , lblTheraputicClass.frame.origin.y
                                              , size.width
                                              , size.height);
    }
}

@end
