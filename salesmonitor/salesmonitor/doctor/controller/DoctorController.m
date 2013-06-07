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
    return _isIphone ? 100.0f : 150.0f;
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
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:branchCellIdentifier];
        [cell setFrame:_isIphone ?  CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 100)
                      :   CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 150) ];
        
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    }
    else{
    }
    
    if ((_selectedIndexPath != nil) && (_selectedIndexPath.row == indexPath.row)){
    }
    else{
        
    }
    
    //now populate data for the views
    NSMutableDictionary *doctor = [_loadDoctor objectAtIndex:indexPath.row];
    NSLog(@"%@", doctor);
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (_selectedIndexPath.row == indexPath.row) {
        
        _selectedIndexPath = nil;
        [tableView reloadData];
    } else {
        
        _selectedIndexPath = indexPath;
        [tableView reloadData];
        [tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
    
}




@end
