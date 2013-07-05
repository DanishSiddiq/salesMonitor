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


@synthesize selectedIndexPath;

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
        selectedIndexPath = nil;
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
    return _isIphone ? 70.0f : 77.0f;
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
        
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if([_viewController respondsToSelector:@selector(doctorSelected:)]){
        [_viewController doctorSelected:indexPath.row];
        selectedIndexPath = indexPath;
        [tableView reloadData];
    }
}

// for iphone
- (UITableViewCell *) createCellContentForIphone : (UITableView *) tableView branchCellIdentifier : (NSString *) branchCellIdentifier{
    
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:branchCellIdentifier];
    [cell setFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 70)];
    
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    
    UILabel *lblName = [[UILabel alloc] initWithFrame:CGRectMake(8, 6, [UIScreen mainScreen].bounds.size.width - 12, 16)];
    lblName.numberOfLines = 1;
    [lblName setBackgroundColor:[UIColor clearColor]];
    lblName.font = [UIFont fontWithName:@"Helvetica" size:15.0];
    [lblName setTextColor:[UIColor darkGrayColor]];
    [lblName setContentMode:UIViewContentModeTopLeft];
    [lblName setLineBreakMode:NSLineBreakByTruncatingTail];
    lblName.tag = 10;
    
    UILabel *lblSpeciality = [[UILabel alloc] initWithFrame:CGRectMake(8, 24, [UIScreen mainScreen].bounds.size.width -12, 15)];
    lblSpeciality.numberOfLines = 1;
    [lblSpeciality setBackgroundColor:[UIColor clearColor]];
    [lblSpeciality setFont:[UIFont fontWithName:@"HelveticaNeue" size:12]];
    [lblSpeciality setContentMode:UIViewContentModeTopLeft];
    [lblSpeciality setTextAlignment:NSTextAlignmentLeft];
    [lblSpeciality setLineBreakMode:NSLineBreakByTruncatingTail];
    [lblSpeciality setTextColor:[UIColor grayColor]];
    lblSpeciality.tag = 20;
    
    UILabel *lblAddress = [[UILabel alloc] initWithFrame: CGRectMake(8, 40, [UIScreen mainScreen].bounds.size.width -12, 28)];
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
    
    return cell;
    
}

- (void) populateCellContentForIphone : (UITableViewCell *) cell row: (NSInteger) row{
    
    UILabel *lblName         = (UILabel *)[cell.contentView viewWithTag:10];
    UILabel *lblSpeciality   = (UILabel *)[cell.contentView viewWithTag:20];
    UILabel *lblAddress      = (UILabel *)[cell.contentView viewWithTag:30];
    
    // populate data
    NSMutableDictionary *currDoctor = [_loadDoctor objectAtIndex:row];
    lblName.text        = [currDoctor valueForKey:KEY_DOCTORS_NAME];
    lblSpeciality.text  = [currDoctor valueForKey:KEY_DOCTORS_SPECIALITY];
    lblAddress.text     = [currDoctor valueForKey:KEY_DOCTORS_ADDRESS];
}

// for ipad
- (UITableViewCell *) createCellContentForIpad : (UITableView *) tableView branchCellIdentifier : (NSString *) branchCellIdentifier{
    
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:branchCellIdentifier];
    [cell setFrame:CGRectMake(0, 0, 345, 77) ];
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    
    UIImageView *imgViewBg = [[UIImageView alloc] initWithFrame:CGRectMake(5, 5, 335, 67)];
    [imgViewBg setTag:10];
    
    UILabel *lblIndex = [[UILabel alloc] initWithFrame:CGRectMake(8, 8, 30, 28)];
    lblIndex.numberOfLines = 1;
    [lblIndex setBackgroundColor:[UIColor clearColor]];
    lblIndex.font = [UIFont fontWithName:@"Helvetica" size:14.0];
    [lblIndex setTextColor:[UIColor colorWithRed:82/255.0f green:82/255.0f blue:82/255.0f alpha:1.0]];
    [lblIndex setContentMode:UIViewContentModeTopLeft];
    [lblIndex setTextAlignment:NSTextAlignmentCenter];
    [lblIndex setLineBreakMode:NSLineBreakByTruncatingTail];
    [lblIndex setTag:20];
    
    UILabel *lblName = [[UILabel alloc] initWithFrame:CGRectMake(45, 8, 280, 28)];
    lblName.numberOfLines = 1;
    [lblName setBackgroundColor:[UIColor clearColor]];
    lblName.font = [UIFont fontWithName:@"Helvetica" size:18.0];
    [lblName setTextColor:[UIColor colorWithRed:82/255.0f green:82/255.0f blue:82/255.0f alpha:1.0]];
    [lblName setContentMode:UIViewContentModeTopLeft];
    [lblName setLineBreakMode:NSLineBreakByTruncatingTail];
    [lblName setTag:30];
    
    UILabel *lblSpeciality = [[UILabel alloc] initWithFrame:CGRectMake(15, 39, 170, 28)];
    lblSpeciality.numberOfLines = 1;
    [lblSpeciality setBackgroundColor:[UIColor clearColor]];
    [lblSpeciality setFont:[UIFont fontWithName:@"HelveticaNeue" size:14]];
    [lblSpeciality setContentMode:UIViewContentModeTopLeft];
    [lblSpeciality setTextAlignment:NSTextAlignmentLeft];
    [lblSpeciality setLineBreakMode:NSLineBreakByTruncatingTail];
    [lblSpeciality setTextColor:[UIColor colorWithRed:243/255.0f green:243/255.0f blue:243/255.0f alpha:1.0]];
    [lblSpeciality setTag:40];
    
    UIImageView *imgViewCallIcon = [[UIImageView alloc] initWithFrame:CGRectMake(190, 38, 25, 25)];
    [imgViewCallIcon setImage:[UIImage imageNamed:@"callIcon"]];
    
    UILabel *lblContactNo = [[UILabel alloc] initWithFrame:CGRectMake(220, 40, 110, 28)];
    lblContactNo.numberOfLines = 1;
    [lblContactNo setBackgroundColor:[UIColor clearColor]];
    [lblContactNo setFont:[UIFont fontWithName:@"HelveticaNeue" size:16]];
    [lblContactNo setContentMode:UIViewContentModeTopLeft];
    [lblContactNo setTextAlignment:NSTextAlignmentLeft];
    [lblContactNo setLineBreakMode:NSLineBreakByTruncatingTail];
    [lblContactNo setTextColor:[UIColor colorWithRed:243/255.0f green:243/255.0f blue:243/255.0f alpha:1.0]];
    [lblContactNo adjustsFontSizeToFitWidth];
    [lblContactNo setTag:50];
    
    [cell.contentView addSubview:imgViewBg];
    [cell.contentView addSubview:lblIndex];
    [cell.contentView addSubview:lblName];
    [cell.contentView addSubview:lblSpeciality];
    [cell.contentView addSubview:imgViewCallIcon];
    [cell.contentView addSubview:lblContactNo];
    
    return cell;
    
}

- (void) populateCellContentForIpad : (UITableViewCell *) cell row : (NSInteger) row{
    
    UIImageView *imgViewBg   = (UIImageView *)[cell.contentView viewWithTag:10];
    UILabel *lblIndex         = (UILabel *)[cell.contentView viewWithTag:20];
    UILabel *lblName         = (UILabel *)[cell.contentView viewWithTag:30];
    UILabel *lblSpeciality   = (UILabel *)[cell.contentView viewWithTag:40];
    UILabel *lblAddress      = (UILabel *)[cell.contentView viewWithTag:50];
    
    if(selectedIndexPath != nil && selectedIndexPath.row == row){
        
        [imgViewBg setImage:[UIImage imageNamed:@"medDataBgHover"]];
        [lblIndex setTextColor:[UIColor colorWithRed:243/255.0f green:243/255.0f blue:243/255.0f alpha:1.0]];
        [lblName setTextColor:[UIColor colorWithRed:243/255.0f green:243/255.0f blue:243/255.0f alpha:1.0]];
    }
    else{
        
        [imgViewBg setImage:[UIImage imageNamed:@"medDataBg"]];
        [lblIndex setTextColor:[UIColor colorWithRed:82/255.0f green:82/255.0f blue:82/255.0f alpha:1.0]];
        [lblName setTextColor:[UIColor colorWithRed:82/255.0f green:82/255.0f blue:82/255.0f alpha:1.0]];
    }
    
    // populate data
    NSMutableDictionary *currDoctor = [_loadDoctor objectAtIndex:row];
    lblIndex.text       = [NSString stringWithFormat: (row + 1) > 9 ? @"%d" : @"0%d" , (row + 1)];
    lblName.text        = [currDoctor valueForKey:KEY_DOCTORS_NAME];
    lblSpeciality.text  = [currDoctor valueForKey:KEY_DOCTORS_SPECIALITY];
    lblAddress.text     = [[currDoctor valueForKey:KEY_DOCTORS_PHONE] description];

}


- (void) add : (NSMutableDictionary *) doctorContainer {
    
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
        
        NSString *urlString = [NSString stringWithFormat:KEY_SERVER_URL_DOCTOR_ADD, [[_salesMonitorDelegate userData] valueForKey:KEY_USER_ID]];
        NSURL *url = [NSURL URLWithString:urlString];
        
        AFHTTPClient *httpClient = [[AFHTTPClient alloc] initWithBaseURL:url];
        httpClient.parameterEncoding = AFJSONParameterEncoding;
        NSMutableURLRequest *request = [httpClient requestWithMethod:@"POST" path:@"" parameters:doctorContainer];
        AFJSONRequestOperation *operation = [AFJSONRequestOperation
                                             JSONRequestOperationWithRequest:request
                                             success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
                                                 
                                                 [SVProgressHUD dismiss];
                                                 
                                                 if([_viewController respondsToSelector:@selector(doctorAdd:msg:)]){
                                                     [self addDoctorInMemory:JSON];
                                                     [_viewController doctorAdd:YES msg:@"Added Successfully"];
                                                 }
                                             }
                                             failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
                                                 
                                                 [SVProgressHUD dismiss];
                                                 
                                                 if([_viewController respondsToSelector:@selector(doctorAdd:msg:)]){
                                                     [_viewController doctorAdd:NO msg:[JSON valueForKey:KEY_ERROR]];
                                                 }
                                             }];
        operation.JSONReadingOptions = NSJSONReadingMutableContainers | NSJSONReadingMutableLeaves;
        [operation start];
        
        [SVProgressHUD showWithStatus:@"Adding" maskType:SVProgressHUDMaskTypeClear];
    }
}

- (void) update : (NSMutableDictionary *) doctorContainer _id: (NSString *) _id{
    
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
        
        NSString *urlString = [NSString stringWithFormat:KEY_SERVER_URL_DOCTOR_UPDATE, _id];
        NSURL *url = [NSURL URLWithString:urlString];
        
        AFHTTPClient *httpClient = [[AFHTTPClient alloc] initWithBaseURL:url];
        httpClient.parameterEncoding = AFJSONParameterEncoding;
        NSMutableURLRequest *request = [httpClient requestWithMethod:@"PUT" path:@"" parameters:doctorContainer];        
        AFJSONRequestOperation *operation = [AFJSONRequestOperation
                                             JSONRequestOperationWithRequest:request
                                             success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
                                                 
                                                 [SVProgressHUD dismiss];
                                                 
                                                 if([_viewController respondsToSelector:@selector(doctorUpdate:msg:)]){                                                     

                                                     [self updateDoctorInMemory:JSON _id:_id];
                                                     [_viewController doctorUpdate:YES msg:@"Updated Successfully"];
                                                 }
                                             }
                                             failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
                                                 
                                                 [SVProgressHUD dismiss];                                                  
                                                  if([_viewController respondsToSelector:@selector(doctorUpdate:msg:)]){
                                                      [_viewController doctorUpdate:NO msg:[JSON valueForKey:@"error"]];
                                                  }
                                             }];
        operation.JSONReadingOptions = NSJSONReadingMutableContainers | NSJSONReadingMutableLeaves;
        [operation start];
        
        [SVProgressHUD showWithStatus:@"Updating" maskType:SVProgressHUDMaskTypeClear];
    }    
}


- (void) delete : (NSMutableDictionary *) doctor{
    
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
        
        NSString *urlString = [NSString stringWithFormat:KEY_SERVER_URL_DOCTOR_DELETE, [doctor valueForKey:KEY_DOCTORS_ID]];
        NSURL *url = [NSURL URLWithString:urlString];
        
        AFHTTPClient *httpClient = [[AFHTTPClient alloc] initWithBaseURL:url];
        httpClient.parameterEncoding = AFJSONParameterEncoding;
        NSMutableURLRequest *request = [httpClient requestWithMethod:@"DELETE" path:@"" parameters:nil];
        
        AFJSONRequestOperation *operation = [AFJSONRequestOperation
                                             JSONRequestOperationWithRequest:request
                                             success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
                                                 [SVProgressHUD dismiss];
                                                 
                                                 if([_viewController respondsToSelector:@selector(doctorDelete:msg:)]){
                                                     [self deleteDoctor:doctor];
                                                     [_viewController doctorDelete:YES msg:@"Deleted Successfully"];
                                                 }
                                             }
                                             failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
                                                 
                                                 [SVProgressHUD dismiss];
                                                 NSLog(@"ERROR saving publish message to server: %@", error);
                                                 
                                                 if([_viewController respondsToSelector:@selector(doctorDelete:msg:)]){
                                                     [_viewController doctorDelete:NO msg:[JSON valueForKey:@"error"]];
                                                 }
                                             }];
        operation.JSONReadingOptions = NSJSONReadingMutableContainers | NSJSONReadingMutableLeaves;
        [operation start];
        
        [SVProgressHUD showWithStatus:@"Deleting" maskType:SVProgressHUDMaskTypeClear];
    }
}

// adding doctor in list(memory)
- (void) addDoctorInMemory : (NSMutableDictionary *) doctor {
    [[[_salesMonitorDelegate userData] valueForKey:KEY_DOCTORS] addObject:doctor];
}

// updating doctor in list(memory)
- (void) updateDoctorInMemory : (NSMutableDictionary *) doctor _id: (NSString *) _id{

    NSMutableDictionary *oldDoctorDefinition = [self searchDoctorByKeyValue:KEY_DOCTORS_ID
                                                                      value:_id];
    [oldDoctorDefinition removeAllObjects];
    [oldDoctorDefinition addEntriesFromDictionary:doctor];
}

// delete doctor in list(memory)
-(void) deleteDoctor : (NSMutableDictionary *) doctor {
    
    [[[_salesMonitorDelegate userData] valueForKey:KEY_DOCTORS] removeObject:doctor];
}


- (NSMutableDictionary *) searchDoctorByKeyValue : (NSString *) key  value :(NSString *) value{
    NSInteger index = -1;
    index = [[[_salesMonitorDelegate userData]valueForKey:KEY_DOCTORS] indexOfObjectPassingTest:^BOOL(NSDictionary *obj, NSUInteger idx, BOOL *stop) {
        return ([[obj valueForKey:key] isEqualToString:value]);
    }];
    
    return (index != (NSNotFound) && index != -1) ? [[[_salesMonitorDelegate userData] valueForKey:KEY_DOCTORS] objectAtIndex:index] : nil;
}

@end
