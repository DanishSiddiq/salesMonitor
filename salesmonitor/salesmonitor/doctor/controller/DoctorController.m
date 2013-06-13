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
@property (nonatomic, strong) AppDelegate *salesMonitorDelegate;
@property (nonatomic, strong) id<DoctorControllerDelegate> viewController;

@end

@implementation DoctorController


- (id)          init : (BOOL) isIphone
          loadDoctor :(NSMutableArray *) loadDoctor
salesMonitorDelegate : (AppDelegate *)salesMonitorDelegate
      viewController : (id<DoctorControllerDelegate>)viewController{
    
    self = [super init];
    
    if(self){
        
        _loadDoctor = loadDoctor;
        _isIphone   = isIphone;
        _salesMonitorDelegate = salesMonitorDelegate;
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
        
        [cell.contentView addSubview:lblName];
        [cell.contentView addSubview:lblSpeciality];
        [cell.contentView addSubview:lblAddress];
        
    }
    else{
        
        lblName         = (UILabel *)[cell.contentView viewWithTag:10];
        lblSpeciality   = (UILabel *)[cell.contentView viewWithTag:20];
        lblAddress      = (UILabel *)[cell.contentView viewWithTag:30];
    }
    
    // populate data
    NSMutableDictionary *currDoctor = [_loadDoctor objectAtIndex:indexPath.row];
    lblName.text        = [currDoctor valueForKey:KEY_DOCTORS_NAME];
    lblSpeciality.text  = [currDoctor valueForKey:KEY_DOCTORS_SPECIALITY];
    lblAddress.text     = [currDoctor valueForKey:KEY_DOCTORS_ADDRESS];
        
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if([_viewController respondsToSelector:@selector(doctorSelected:)]){
        [_viewController doctorSelected:indexPath.row];
    }
}


- (void) add : (NSMutableDictionary *) doctor {
    
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
        
        NSString *urlString = [NSString stringWithFormat:KEY_SERVER_URL_LOGIN];
        NSURL *url = [NSURL URLWithString:urlString];
        
        AFHTTPClient *httpClient = [[AFHTTPClient alloc] initWithBaseURL:url];
        httpClient.parameterEncoding = AFJSONParameterEncoding;
        NSMutableURLRequest *request = [httpClient requestWithMethod:@"POST" path:@"" parameters:doctor];
        
        AFJSONRequestOperation *operation = [[AFJSONRequestOperation alloc] initWithRequest:request];
        
        [operation setUploadProgressBlock:^(NSUInteger bytesWritten, long long totalBytesWritten, long long totalBytesExpectedToWrite) {
            NSLog(@"login call start, %lld, %lld",totalBytesWritten, totalBytesExpectedToWrite);
        }];
        
        [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id JSON) {
            [SVProgressHUD dismiss];
            
            if([_viewController respondsToSelector:@selector(doctorAdd:msg:)]){
                [_viewController doctorAdd:YES msg:@"Added Successfully"];
            }
        }
                                         failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                             
                                             [SVProgressHUD dismiss];
                                             NSLog(@"ERROR saving publish message to server: %@", error);
                                             
                                             if([_viewController respondsToSelector:@selector(doctorAdd:msg:)]){
                                                 [_viewController doctorAdd:YES msg:@"Custm message from server"];
                                             }
                                         }];
        
        operation.JSONReadingOptions = NSJSONReadingMutableContainers | NSJSONReadingMutableLeaves;
        [operation start];
        [SVProgressHUD showWithStatus:@"Adding" maskType:SVProgressHUDMaskTypeClear];
    }
}

// adding doctor in list
- (void) addDoctorInMemory : (NSMutableDictionary *) doctor {
    [[[_salesMonitorDelegate userData] valueForKey:KEY_DOCTORS] addObject:doctor];
}

@end
