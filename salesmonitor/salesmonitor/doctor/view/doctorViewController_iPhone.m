//
//  doctorViewController_iPhone.m
//  salesmonitor
//
//  Created by goodcore2 on 6/6/13.
//  Copyright (c) 2013 GoodCore. All rights reserved.
//

#import "doctorViewController_iPhone.h"

@interface doctorViewController_iPhone ()

// nav bar item at right in previous view
@property (strong, nonatomic) UIView *navBarContainer;

@property (nonatomic) BOOL isIphone;
@property (nonatomic, strong) AppDelegate *salesMonitorDelegate;
@property (nonatomic, strong) UIView *listContainer;
@property (nonatomic, strong) UITableView *tblDoctor;
@property (nonatomic, strong) DoctorController *doctorController;
@property (nonatomic, strong) UIView *doctorDetailContainer;
@property (nonatomic, strong) UIView *doctorContactContainer;

@property (nonatomic) NSInteger selectedIndex;

@end

@implementation doctorViewController_iPhone

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (id) initWithNibName:(NSString *)nibNameOrNil
                bundle:(NSBundle *)nibBundleOrNil
  salesMonitorDelegate:(AppDelegate *)salesMonitorDelegate
       navBarContainer: (UIView *) navBarContainer{

    self = [self initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    
    if (self) {
        _salesMonitorDelegate   = salesMonitorDelegate;
        _isIphone   = YES;
        _navBarContainer = navBarContainer;
    }
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self initializeData];
    [self initializeViews];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// view related methods
- (void) initializeData {
    
    _isIphone = ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone);
    _doctorController = [[DoctorController alloc] init:_isIphone
                                            loadDoctor:[[_salesMonitorDelegate userData] valueForKey:KEY_DOCTORS]
                                        viewController:self];
}

- (void) initializeViews {
    [self customizeNavigationBar];
    [self initializeMainView];
    [self initializeListContainer ];
    [self initializeDoctorTable];
    [self initializeDoctorDetailContaiiner];
    [self initializeDoctorContactContainer];
}

- (void) customizeNavigationBar{
    [_navBarContainer setHidden:YES];
}

- (void) initializeMainView {
    
    [self.view setFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
}

- (void) initializeListContainer {
    
    _listContainer = [[UIView alloc] initWithFrame:CGRectMake(0
                                                              , 0
                                                              , [UIScreen mainScreen].bounds.size.width
                                                              , [UIScreen mainScreen].bounds.size.height - 45)];
    [_listContainer setBackgroundColor:[UIColor whiteColor]];
    [self.view addSubview:_listContainer];
}

- (void) initializeDoctorTable {

    _tblDoctor = [[UITableView alloc] initWithFrame:CGRectMake(0
                                                               , 0
                                                               , [UIScreen mainScreen].bounds.size.width
                                                               , [UIScreen mainScreen].bounds.size.height - 45)];
    
    _tblDoctor.delegate = _doctorController;
    _tblDoctor.dataSource = _doctorController;
    [_listContainer addSubview:_tblDoctor];
}

- (void) initializeDoctorDetailContaiiner{
    
    _doctorDetailContainer = [[UIView alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width
                                                              , 0
                                                              , [UIScreen mainScreen].bounds.size.width
                                                              , [UIScreen mainScreen].bounds.size.height - 115)];
    [self.view addSubview:_doctorDetailContainer];
}

- (void) initializeDoctorContactContainer{
    
    _doctorContactContainer = [[UIView alloc] initWithFrame:CGRectMake(0
                                                                      , [UIScreen mainScreen].bounds.size.height
                                                                      , [UIScreen mainScreen].bounds.size.width
                                                                      , 70)];
    [self.view addSubview:_doctorContactContainer];
}

// selectors
-(void)doctorEdit: (UIButton *) sender{
    
}

-(void)doctorDelete: (UIButton *) sender{
    
}

-(void)doctorView: (UIButton *) sender{
    
}

-(void) doctorMessage : (UIButton *) sender{
    
    if([MFMessageComposeViewController canSendText])
    {
        NSMutableDictionary *doctor = [[[_salesMonitorDelegate userData] valueForKey:KEY_DOCTORS] objectAtIndex:_selectedIndex];
        NSString *phoneNumber = [doctor valueForKey:KEY_DOCTORS_PHONE];
        NSString *cleanedString = [[phoneNumber componentsSeparatedByCharactersInSet:[[NSCharacterSet characterSetWithCharactersInString:@"0123456789-+()"] invertedSet]] componentsJoinedByString:@""];
        
        MFMessageComposeViewController *messenger = [[MFMessageComposeViewController alloc] init];
        
        //1(234)567-8910
        messenger.recipients = [NSArray arrayWithObjects:cleanedString, nil];
        messenger.messageComposeDelegate = self;
        [self presentViewController:messenger animated:YES completion:nil];
    }
}

-(void) doctorCall : (UIButton *) sender{

    NSMutableDictionary *doctor = [[[_salesMonitorDelegate userData] valueForKey:KEY_DOCTORS] objectAtIndex:_selectedIndex];
    NSString *phoneNumber = [doctor valueForKey:KEY_DOCTORS_PHONE];
    NSString *cleanedString = [[phoneNumber componentsSeparatedByCharactersInSet:[[NSCharacterSet characterSetWithCharactersInString:@"0123456789-+()"] invertedSet]] componentsJoinedByString:@""];
    
    UIApplication *myApp = [UIApplication sharedApplication];
    [myApp openURL:[NSURL URLWithString:[NSString stringWithFormat:@"telprompt://%@", cleanedString]]];
}

-(void) doctorMail : (UIButton *) sender{
    
    if ([MFMailComposeViewController canSendMail])
    {
        NSMutableDictionary *doctor = [[[_salesMonitorDelegate userData] valueForKey:KEY_DOCTORS] objectAtIndex:_selectedIndex];
        MFMailComposeViewController *mailer = [[MFMailComposeViewController alloc] init];
        [mailer setSubject:@" "];
        mailer.mailComposeDelegate = self;
        NSArray *toRecipients = [NSArray arrayWithObjects:[doctor valueForKey:KEY_DOCTORS_EMAIL], nil];
        [mailer setToRecipients:toRecipients];
        NSString *emailBody = @"";
        [mailer setMessageBody:emailBody isHTML:NO];
        mailer.navigationBar.titleTextAttributes = [NSDictionary dictionaryWithObjectsAndKeys:
                                                    [UIColor blackColor]
                                                    ,   UITextAttributeTextColor
                                                    ,   [UIColor clearColor]
                                                    ,   UITextAttributeTextShadowColor
                                                    ,   [NSValue valueWithUIOffset:UIOffsetMake(0, 0)]
                                                    ,   UITextAttributeTextShadowOffset
                                                    ,   [UIFont fontWithName:@"HelveticaNeue-Medium" size:20.0]
                                                    ,   UITextAttributeFont,
                                                    nil];
        
        [self presentViewController:mailer animated:YES completion:nil];
    }
    else
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Failure"
                                                        message:@"Your device doesn't support the composer sheet"
                                                       delegate:nil
                                              cancelButtonTitle:nil
                                              otherButtonTitles:nil];
        [alert show];
    }
}


// mail controller delegates
- (void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void) messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult)result{
    [self dismissViewControllerAnimated:YES completion:nil];
}


// protocols
-(void)doctorSelected:(NSInteger) selectedIndex{
    
    _selectedIndex = selectedIndex;
}

@end
