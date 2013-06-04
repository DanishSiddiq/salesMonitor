//
//  productViewController_iPhone.m
//  salesmonitor
//
//  Created by goodcore2 on 6/4/13.
//  Copyright (c) 2013 GoodCore. All rights reserved.
//

#import "productViewController_iPhone.h"

@interface productViewController_iPhone ()

@end

@implementation productViewController_iPhone

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void) viewWillAppear:(BOOL)animated{
    
    [self.navigationController setNavigationBarHidden:YES ];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
