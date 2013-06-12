//
//  DoctorController.m
//  salesmonitor
//
//  Created by goodcore2 on 6/7/13.
//  Copyright (c) 2013 GoodCore. All rights reserved.
//

#import "DoctorController.h"

@interface DoctorController ()

@property (nonatomic) BOOL isIphone;
@property (nonatomic, strong) NSMutableArray *loadDoctor;
@property (nonatomic, strong) id<DoctorControllerDelegate> viewController;
@property (strong, nonatomic) NSIndexPath *selectedIndexPath;

@end

@implementation DoctorController


- (id) init : (BOOL) isIphone loadDoctor :(NSMutableArray *) loadDoctor viewController : (id<DoctorControllerDelegate>)viewController{
    
    self = [super init];
    
    if(self){
        _loadDoctor = loadDoctor;
        _isIphone   = isIphone;
        _viewController    = viewController;
        _selectedIndexPath = [NSIndexPath indexPathForRow:-1 inSection:0];
     }
    
    return self;
    
}

// selectors and delegates
#pragma product table delegate
- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return  [_loadDoctor count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return _isIphone ? 70.0f : 70.0f;
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
    Custombutton *btnCall, *btnMessage, *btnMail;
    UILabel *lblName, *lblSpeciality, *lblAddress;
    
    cell = [tableView dequeueReusableCellWithIdentifier:branchCellIdentifier];
    
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:branchCellIdentifier];
        [cell setFrame:_isIphone ?  CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 70)
                      :   CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 70) ];
        
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        
        lblName = [[UILabel alloc] initWithFrame:CGRectMake(8, 6, [UIScreen mainScreen].bounds.size.width - 12, 16)];
        lblName.numberOfLines = 1;
        [lblName setBackgroundColor:[UIColor clearColor]];
        lblName.font = [UIFont fontWithName:@"Helvetica" size:15.0];
        [lblName setTextColor:[UIColor darkGrayColor]];
        [lblName setContentMode:UIViewContentModeTopLeft];
        [lblName setLineBreakMode:NSLineBreakByTruncatingTail];
        lblName.tag = 10;
        
        lblSpeciality = [[UILabel alloc] initWithFrame:CGRectMake(8, 24, [UIScreen mainScreen].bounds.size.width -12, 15)];
        lblSpeciality.numberOfLines = 1;
        [lblSpeciality setBackgroundColor:[UIColor clearColor]];
        [lblSpeciality setFont:[UIFont fontWithName:@"HelveticaNeue" size:12]];
        [lblSpeciality setContentMode:UIViewContentModeTopLeft];
        [lblSpeciality setTextAlignment:NSTextAlignmentLeft];
        [lblSpeciality setLineBreakMode:NSLineBreakByTruncatingTail];
        [lblSpeciality setTextColor:[UIColor grayColor]];
        lblSpeciality.tag = 20;
        
        lblAddress = [[UILabel alloc] initWithFrame:CGRectMake(8, 40, [UIScreen mainScreen].bounds.size.width -12, 28)];
        lblAddress.numberOfLines = 2;
        [lblAddress setBackgroundColor:[UIColor clearColor]];
        [lblAddress setFont:[UIFont fontWithName:@"HelveticaNeue" size:12]];
        [lblAddress setContentMode:UIViewContentModeTopLeft];
        [lblAddress setTextAlignment:NSTextAlignmentLeft];
        [lblAddress setLineBreakMode:NSLineBreakByTruncatingTail];
        [lblAddress setTextColor:[UIColor grayColor]];
        [lblAddress adjustsFontSizeToFitWidth];
        lblAddress.tag = 30;
        
        btnCall = [[Custombutton alloc] initWithFrame:_isIphone ? CGRectMake(70, 15, 40, 40) : CGRectMake(294, 15, 40, 40)];
        [btnCall addTarget:self action:@selector(btnPressedCall:) forControlEvents:UIControlEventTouchUpInside];
        [btnCall setBackgroundImage:[UIImage imageNamed:@"icon_contact" ] forState:UIControlStateNormal & UIControlStateSelected];
        [btnCall setUserInteractionEnabled:YES];
        btnCall.rowIndex = indexPath.row;
        [btnCall setHidden:YES];
        btnCall.tag = 40;
        
        btnMessage = [[Custombutton alloc] initWithFrame:_isIphone ? CGRectMake(140, 15, 40, 40) :  CGRectMake(364, 15, 40, 40)];
        [btnMessage addTarget:self action:@selector(btnPressedMessage:) forControlEvents:UIControlEventTouchUpInside];
        [btnMessage setBackgroundImage:[UIImage imageNamed:@"icon_sms" ] forState:UIControlStateNormal & UIControlStateSelected];
        [btnMessage setUserInteractionEnabled:YES];
        btnMessage.rowIndex = indexPath.row;
        [btnMessage setHidden:YES];
        btnMessage.tag = 50;
        
        btnMail = [[Custombutton alloc] initWithFrame:_isIphone ? CGRectMake(210, 15, 40, 40) : CGRectMake(434, 15, 40, 40)];
        [btnMail addTarget:self action:@selector(btnPressedMail:) forControlEvents:UIControlEventTouchUpInside];
        [btnMail setBackgroundImage:[UIImage imageNamed:@"icon_mail" ] forState:UIControlStateNormal & UIControlStateSelected];
        [btnMail setUserInteractionEnabled:YES];
        btnMail.rowIndex = indexPath.row;
        [btnMail setHidden:YES];
        btnMail.tag = 60;
        
        [cell.contentView addSubview:lblName];
        [cell.contentView addSubview:lblSpeciality];
        [cell.contentView addSubview:lblAddress];
        [cell.contentView addSubview:btnCall];
        [cell.contentView addSubview:btnMessage];
        [cell.contentView addSubview:btnMail];
        
    }
    else{
        
        lblName         = (UILabel *)[cell.contentView viewWithTag:10];
        lblSpeciality   = (UILabel *)[cell.contentView viewWithTag:20];
        lblAddress      = (UILabel *)[cell.contentView viewWithTag:30];
        btnCall         = (Custombutton *)[cell.contentView viewWithTag:40];
        btnMessage      = (Custombutton *)[cell.contentView viewWithTag:50];
        btnMail         = (Custombutton *)[cell.contentView viewWithTag:60];
    }
    
    // populate data
    NSMutableDictionary *currDoctor = [_loadDoctor objectAtIndex:indexPath.row];
    lblName.text        = [currDoctor valueForKey:KEY_DOCTORS_NAME];
    lblSpeciality.text  = [currDoctor valueForKey:KEY_DOCTORS_SPECIALITY];
    lblAddress.text     = [currDoctor valueForKey:KEY_DOCTORS_ADDRESS];
    btnCall.rowIndex    = indexPath.row;
    btnMessage.rowIndex = indexPath.row;
    btnMail.rowIndex    = indexPath.row;
    
    if ((_selectedIndexPath != nil) && (_selectedIndexPath.row == indexPath.row)){
        
        [lblName  setHidden:YES];
        [lblSpeciality  setHidden:YES];
        [lblAddress  setHidden:YES];
        
        [btnCall setHidden:NO];
        [btnMessage setHidden:NO];
        [btnMail setHidden:NO];
    }
    else{
        
        [lblName  setHidden:NO];
        [lblSpeciality  setHidden:NO];
        [lblAddress  setHidden:NO];
        
        [btnCall setHidden:YES];
        [btnMessage setHidden:YES];
        [btnMail setHidden:YES];
    }
    
    //now populate data for the views
    NSMutableDictionary *doctor = [_loadDoctor objectAtIndex:indexPath.row];
    NSLog(@"%@", doctor);
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (_selectedIndexPath != nil && _selectedIndexPath.row == indexPath.row) {
        
        _selectedIndexPath = nil;
        [tableView reloadData];
    } else {
        
        _selectedIndexPath = indexPath;
        [tableView reloadData];
        [tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
    
}

- (void) btnPressedCall : (Custombutton *) sender{
    
    if([_viewController respondsToSelector:@selector(doctorCall:)]){
        [_viewController doctorCall:[_loadDoctor objectAtIndex:[sender rowIndex]]];
    }
}

- (void) btnPressedMessage : (Custombutton *) sender{
    
    if([_viewController respondsToSelector:@selector(doctorMessage:)]){
        [_viewController doctorMessage:[_loadDoctor objectAtIndex:[sender rowIndex]]];
    }
}

- (void) btnPressedMail : (Custombutton *) sender{
    
    if([_viewController respondsToSelector:@selector(doctorMail:)]){
        [_viewController doctorMail:[_loadDoctor objectAtIndex:[sender rowIndex]]];
    }
}

@end
