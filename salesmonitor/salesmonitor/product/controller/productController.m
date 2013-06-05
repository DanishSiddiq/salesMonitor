//
//  productController.m
//  salesmonitor
//
//  Created by goodcore2 on 6/5/13.
//  Copyright (c) 2013 GoodCore. All rights reserved.
//

#import "productController.h"


@interface productController ()

@property (nonatomic, strong) NSMutableArray *loadData;
@property (nonatomic) BOOL isIphone;

@end

@implementation productController

- (id) init : (BOOL) isIphone loadData :(NSMutableArray *) loadData {
    
    self = [super init];
    
    if(self){
        _loadData = loadData;
        _isIphone = isIphone;
    }
    
    return self;
}

// selectors and delegates
#pragma product table delegate
- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return  [_loadData count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 100.0;
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
    UIImageView *imgViewProduct;
    UILabel *lblName, *lblTheraputicClass, *lblIndication, *lblPrice;
    
    cell = [tableView dequeueReusableCellWithIdentifier:branchCellIdentifier];
    
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:branchCellIdentifier];
        [cell setFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 100)];
        
        imgViewProduct = [[UIImageView alloc] initWithFrame:CGRectMake(4, 2, 96, 96)];
        [imgViewProduct setContentMode:UIViewContentModeScaleAspectFill];
        [imgViewProduct setClipsToBounds:YES];
        [[imgViewProduct layer] setCornerRadius:3];
        [[imgViewProduct layer] setBorderColor:[UIColor grayColor].CGColor];
        [[imgViewProduct layer] setBorderWidth:1.25];
        imgViewProduct.tag = 10;
        
        lblName = [[UILabel alloc] initWithFrame:CGRectMake(104, 6, 215, 28)];
        [lblName setBackgroundColor:[UIColor clearColor]];
        lblName.numberOfLines = 1;
        lblName.font = [UIFont fontWithName:@"Helvetica" size:16.0];
        lblName.textColor = [UIColor darkGrayColor];
        lblName.contentMode = UIViewContentModeBottomLeft;
        lblName.lineBreakMode = NSLineBreakByTruncatingTail;
        lblName.tag = 20;
        
        lblTheraputicClass = [[UILabel alloc] initWithFrame:CGRectMake(104, 35, 215, 22)];
        lblTheraputicClass.backgroundColor = [UIColor clearColor];
        lblTheraputicClass.font = [UIFont fontWithName:@"HelveticaNeue" size:14];
        lblTheraputicClass.numberOfLines = 1;
        lblTheraputicClass.contentMode = UIViewContentModeTopLeft;
        lblTheraputicClass.lineBreakMode = NSLineBreakByTruncatingTail;
        lblTheraputicClass.textColor = [UIColor grayColor];
        lblTheraputicClass.tag = 30;
                
        lblIndication = [[UILabel alloc] initWithFrame:CGRectMake(104, 57, 215, 28)];
        lblIndication.backgroundColor = [UIColor clearColor];
        lblIndication.font = [UIFont fontWithName:@"HelveticaNeue" size:11];
        lblIndication.numberOfLines = 2;
        lblIndication.contentMode = UIViewContentModeTopLeft;
        lblIndication.lineBreakMode = NSLineBreakByTruncatingTail;
        lblIndication.textColor = [UIColor grayColor];
        lblIndication.tag = 40;
        
        lblPrice = [[UILabel alloc] initWithFrame:CGRectMake(104, 86, 238, 14)];
        lblPrice.backgroundColor = [UIColor clearColor];
        lblPrice.font = [UIFont fontWithName:@"HelveticaNeue" size:11];
        lblPrice.numberOfLines = 1;
        lblPrice.contentMode = UIViewContentModeTopLeft;
        lblPrice.lineBreakMode = NSLineBreakByTruncatingTail;
        lblPrice.textColor = [UIColor blackColor];
        lblPrice.tag = 50;
        
        [cell.contentView addSubview:imgViewProduct];
        [cell.contentView addSubview:lblName];
        [cell.contentView addSubview:lblTheraputicClass];
        [cell.contentView addSubview:lblIndication];
        [cell.contentView addSubview:lblPrice];
        
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    }
    else{
        
        imgViewProduct = (UIImageView *)[cell.contentView viewWithTag:10];
        lblName = (UILabel *)[cell.contentView viewWithTag:20];
        lblTheraputicClass = (UILabel *)[cell.contentView viewWithTag:30];
        lblIndication = (UILabel *)[cell.contentView viewWithTag:40];
        lblPrice = (UILabel *)[cell.contentView viewWithTag:50];
    }
    
    
    //now populate data for the views
    NSMutableDictionary *product = [_loadData objectAtIndex:indexPath.row];
    
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
    lblPrice.text = [[product valueForKey:KEY_PRODUCT_PRICE] description];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
}

@end
