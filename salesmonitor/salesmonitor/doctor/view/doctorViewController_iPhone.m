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
@property (nonatomic, strong) UIView *doctorListContainer;
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
    [self initializeDoctorListContainer ];
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

- (void) initializeDoctorListContainer {
    
    _doctorListContainer = [[UIView alloc] initWithFrame:CGRectMake(0
                                                              , 0
                                                              , [UIScreen mainScreen].bounds.size.width
                                                              , [UIScreen mainScreen].bounds.size.height - 65)];
    [_doctorListContainer setBackgroundColor:[UIColor whiteColor]];
    [self.view addSubview:_doctorListContainer];
}

- (void) initializeDoctorTable {

    _tblDoctor = [[UITableView alloc] initWithFrame:CGRectMake(0
                                                               , 0
                                                               , [UIScreen mainScreen].bounds.size.width
                                                               , [UIScreen mainScreen].bounds.size.height - 65)];
    
    _tblDoctor.delegate = _doctorController;
    _tblDoctor.dataSource = _doctorController;
    [_doctorListContainer addSubview:_tblDoctor];
}

- (void) initializeDoctorDetailContaiiner{
    
    _doctorDetailContainer = [[UIView alloc] initWithFrame:CGRectMake(0
                                                              , 0
                                                              , [UIScreen mainScreen].bounds.size.width
                                                              , [UIScreen mainScreen].bounds.size.height - 80)];
    [_doctorDetailContainer setHidden:YES];
    
    UIButton *btnViewBack = [[UIButton alloc] initWithFrame:CGRectMake(275, 6, 36, 36)];
    [btnViewBack setBackgroundImage:[UIImage imageNamed:@"icon_back"] forState:UIControlStateNormal & UIControlStateSelected];
    [btnViewBack addTarget:self action:@selector(showDoctorList) forControlEvents:UIControlEventTouchUpInside];
    [btnViewBack setTag:110];
    [btnViewBack setHidden:YES];
    
    UILabel *lblDoctorName = [[UILabel alloc] initWithFrame:CGRectMake(8, 40, 304, 24)];
    [lblDoctorName setBackgroundColor:[UIColor clearColor]];
    lblDoctorName.font = [UIFont fontWithName:@"Helvetica" size:18.0];
    [lblDoctorName setNumberOfLines:2];
    [lblDoctorName setTextColor:[UIColor darkGrayColor]];
    lblDoctorName.contentMode = UIViewContentModeBottomLeft;
    lblDoctorName.textAlignment = NSTextAlignmentCenter;
    [lblDoctorName adjustsFontSizeToFitWidth];
    [lblDoctorName setHidden:YES];
    [lblDoctorName setTag:10];
    
    UITextField *txtDoctorName = [[UITextField alloc] initWithFrame:CGRectMake(8, 40, 304, 24)];
    [txtDoctorName setBackgroundColor:[UIColor clearColor]];
    txtDoctorName.font = [UIFont fontWithName:@"Helvetica" size:18.0];
    [txtDoctorName setTextColor:[UIColor darkGrayColor]];
    txtDoctorName.contentMode = UIViewContentModeBottomLeft;
    txtDoctorName.textAlignment = NSTextAlignmentCenter;
    [txtDoctorName.layer setBorderColor:[UIColor colorWithWhite:0.70 alpha:0.8].CGColor];
    [txtDoctorName.layer setShadowColor:[UIColor colorWithWhite:0.7 alpha:1.0].CGColor];
    [txtDoctorName setBorderStyle:UITextBorderStyleRoundedRect];
    [txtDoctorName setAutocorrectionType:UITextAutocorrectionTypeNo];
    [txtDoctorName setHidden:YES];
    [txtDoctorName setTag:20];
    
    UILabel *lblDoctorSpeciality = [[UILabel alloc] initWithFrame:CGRectMake(8, 65, 304, 24)];
    [lblDoctorSpeciality setBackgroundColor:[UIColor clearColor]];
    lblDoctorSpeciality.font = [UIFont fontWithName:@"Helvetica" size:18.0];
    [lblDoctorSpeciality setNumberOfLines:2];
    [lblDoctorSpeciality setTextColor:[UIColor darkGrayColor]];
    lblDoctorSpeciality.contentMode = UIViewContentModeBottomLeft;
    lblDoctorSpeciality.textAlignment = NSTextAlignmentCenter;
    [lblDoctorSpeciality adjustsFontSizeToFitWidth];
    [lblDoctorSpeciality setHidden:YES];
    [lblDoctorSpeciality setTag:30];
    
    UITextField *txtDoctorSpeciality = [[UITextField alloc] initWithFrame:CGRectMake(8, 65, 304, 24)];
    [txtDoctorSpeciality setBackgroundColor:[UIColor clearColor]];
    txtDoctorSpeciality.font = [UIFont fontWithName:@"Helvetica" size:18.0];
    [txtDoctorSpeciality setTextColor:[UIColor darkGrayColor]];
    txtDoctorSpeciality.contentMode = UIViewContentModeBottomLeft;
    txtDoctorSpeciality.textAlignment = NSTextAlignmentCenter;
    [txtDoctorSpeciality.layer setBorderColor:[UIColor colorWithWhite:0.70 alpha:0.8].CGColor];
    [txtDoctorSpeciality.layer setShadowColor:[UIColor colorWithWhite:0.7 alpha:1.0].CGColor];
    [txtDoctorSpeciality setBorderStyle:UITextBorderStyleRoundedRect];
    [txtDoctorSpeciality setAutocorrectionType:UITextAutocorrectionTypeNo];
    [txtDoctorSpeciality setHidden:YES];
    [txtDoctorSpeciality setTag:40];
    
    UILabel *lblDoctorPhone = [[UILabel alloc] initWithFrame:CGRectMake(8, 90, 304, 24)];
    [lblDoctorPhone setBackgroundColor:[UIColor clearColor]];
    lblDoctorPhone.font = [UIFont fontWithName:@"Helvetica" size:18.0];
    [lblDoctorPhone setNumberOfLines:2];
    [lblDoctorPhone setTextColor:[UIColor darkGrayColor]];
    lblDoctorPhone.contentMode = UIViewContentModeBottomLeft;
    lblDoctorPhone.textAlignment = NSTextAlignmentCenter;
    [lblDoctorPhone adjustsFontSizeToFitWidth];
    [lblDoctorPhone setHidden:YES];
    [lblDoctorPhone setTag:50];
    
    UITextField *txtDoctorPhone = [[UITextField alloc] initWithFrame:CGRectMake(8, 90, 304, 24)];
    [txtDoctorPhone setBackgroundColor:[UIColor clearColor]];
    txtDoctorPhone.font = [UIFont fontWithName:@"Helvetica" size:18.0];
    [txtDoctorPhone setTextColor:[UIColor darkGrayColor]];
    txtDoctorPhone.contentMode = UIViewContentModeBottomLeft;
    txtDoctorPhone.textAlignment = NSTextAlignmentCenter;
    [txtDoctorPhone.layer setBorderColor:[UIColor colorWithWhite:0.70 alpha:0.8].CGColor];
    [txtDoctorPhone.layer setShadowColor:[UIColor colorWithWhite:0.7 alpha:1.0].CGColor];
    [txtDoctorPhone setBorderStyle:UITextBorderStyleRoundedRect];
    [txtDoctorPhone setAutocorrectionType:UITextAutocorrectionTypeNo];
    [txtDoctorPhone setKeyboardType:UIKeyboardTypeDecimalPad];
    [txtDoctorPhone setHidden:YES];
    [txtDoctorPhone setTag:60];
    
    UILabel *lblDoctorEmail = [[UILabel alloc] initWithFrame:CGRectMake(8, 115, 304, 24)];
    [lblDoctorEmail setBackgroundColor:[UIColor clearColor]];
    lblDoctorEmail.font = [UIFont fontWithName:@"Helvetica" size:18.0];
    [lblDoctorEmail setNumberOfLines:1];
    [lblDoctorEmail setTextColor:[UIColor darkGrayColor]];
    lblDoctorEmail.contentMode = UIViewContentModeBottomLeft;
    lblDoctorEmail.textAlignment = NSTextAlignmentCenter;
    [lblDoctorEmail adjustsFontSizeToFitWidth];
    [lblDoctorEmail setHidden:YES];
    [lblDoctorEmail setTag:70];
    
    UITextField *txtDoctorEmail = [[UITextField alloc] initWithFrame:CGRectMake(8, 115, 304, 24)];
    [txtDoctorEmail setBackgroundColor:[UIColor clearColor]];
    txtDoctorEmail.font = [UIFont fontWithName:@"Helvetica" size:18.0];
    [txtDoctorEmail setTextColor:[UIColor darkGrayColor]];
    txtDoctorEmail.contentMode = UIViewContentModeBottomLeft;
    txtDoctorEmail.textAlignment = NSTextAlignmentCenter;
    [txtDoctorEmail.layer setBorderColor:[UIColor colorWithWhite:0.70 alpha:0.8].CGColor];
    [txtDoctorEmail.layer setShadowColor:[UIColor colorWithWhite:0.7 alpha:1.0].CGColor];
    [txtDoctorEmail setBorderStyle:UITextBorderStyleRoundedRect];
    [txtDoctorEmail setAutocorrectionType:UITextAutocorrectionTypeNo];
    [txtDoctorEmail setKeyboardType:UIKeyboardTypeEmailAddress];
    [txtDoctorEmail setHidden:YES];
    [txtDoctorEmail setTag:80];
    
    UILabel *lblDoctorAddress = [[UILabel alloc] initWithFrame:CGRectMake(8, 140, 304, 100)];
    [lblDoctorAddress setBackgroundColor:[UIColor clearColor]];
    lblDoctorAddress.font = [UIFont fontWithName:@"Helvetica" size:12.0];
    [lblDoctorAddress setNumberOfLines:5];
    [lblDoctorAddress setTextColor:[UIColor grayColor]];
    lblDoctorAddress.contentMode = UIViewContentModeTopLeft;
    [lblDoctorAddress adjustsFontSizeToFitWidth];
    [lblDoctorAddress setHidden:YES];
    lblDoctorAddress.textAlignment = NSTextAlignmentCenter;
    [lblDoctorAddress setTag:90];
    
    UITextView *txtDoctorAddress = [[UITextView alloc] initWithFrame:CGRectMake(8, 140, 304, 100)];
    [txtDoctorAddress setBackgroundColor:[UIColor clearColor]];
    txtDoctorAddress.font = [UIFont fontWithName:@"Helvetica" size:12.0];
    [txtDoctorAddress setTextColor:[UIColor grayColor]];
    txtDoctorAddress.contentMode = UIViewContentModeTopLeft;
    [txtDoctorAddress.layer setBorderColor:[UIColor colorWithWhite:0.70 alpha:0.8].CGColor];
    [txtDoctorAddress.layer setShadowColor:[UIColor colorWithWhite:0.7 alpha:1.0].CGColor];
    [txtDoctorAddress setAutocorrectionType:UITextAutocorrectionTypeNo];
    [txtDoctorAddress setHidden:YES];
    txtDoctorAddress.textAlignment = NSTextAlignmentCenter;
    [txtDoctorAddress setTag:100];
    
    UIButton *btnEdit = [[UIButton alloc] initWithFrame:CGRectMake(140, 260, 60, 30)];
    [btnEdit setTitle:@"Edit" forState:UIControlStateNormal & UIControlStateSelected];
    [[btnEdit titleLabel] setTextColor:[UIColor darkGrayColor]];
    [btnEdit addTarget:self action:@selector(btnPressedEdit:) forControlEvents:UIControlEventTouchUpInside];
    [btnEdit setTag:120];
    [btnEdit setHidden:YES];
    
    UIButton *btnUpdate = [[UIButton alloc] initWithFrame:CGRectMake(50, 260, 60, 30)];
    [btnUpdate setTitle:@"Update" forState:UIControlStateNormal & UIControlStateSelected];
    [[btnUpdate titleLabel] setTextColor:[UIColor darkGrayColor]];
    [btnUpdate addTarget:self action:@selector(btnPressedUpdate:) forControlEvents:UIControlEventTouchUpInside];
    [btnUpdate setTag:130];
    [btnUpdate setHidden:YES];
    
    UIButton *btnDelete = [[UIButton alloc] initWithFrame:CGRectMake(130, 260, 60, 30)];
    [btnDelete setTitle:@"Delete" forState:UIControlStateNormal & UIControlStateSelected];
    [[btnDelete titleLabel] setTextColor:[UIColor darkGrayColor]];
    [btnDelete addTarget:self action:@selector(btnPressedDelete:) forControlEvents:UIControlEventTouchUpInside];
    [btnDelete setTag:140];
    [btnDelete setHidden:YES];
    
    UIButton *btnCancel = [[UIButton alloc] initWithFrame:CGRectMake(220, 260, 60, 30)];
    [btnCancel setTitle:@"Cancel" forState:UIControlStateNormal & UIControlStateSelected];
    [[btnCancel titleLabel] setTextColor:[UIColor darkGrayColor]];
    [btnCancel addTarget:self action:@selector(btnPressedCancel:) forControlEvents:UIControlEventTouchUpInside];
    [btnCancel setTag:150];
    [btnCancel setHidden:YES];
    
    [_doctorDetailContainer addSubview:btnViewBack];
    [_doctorDetailContainer addSubview:lblDoctorName];
    [_doctorDetailContainer addSubview:txtDoctorName];
    [_doctorDetailContainer addSubview:lblDoctorSpeciality];
    [_doctorDetailContainer addSubview:txtDoctorSpeciality];
    [_doctorDetailContainer addSubview:lblDoctorPhone];
    [_doctorDetailContainer addSubview:txtDoctorPhone];
    [_doctorDetailContainer addSubview:lblDoctorEmail];
    [_doctorDetailContainer addSubview:txtDoctorEmail];
    [_doctorDetailContainer addSubview:lblDoctorAddress];
    [_doctorDetailContainer addSubview:txtDoctorAddress];
    
    // edit/view switch supported methods
    [_doctorDetailContainer addSubview:btnEdit];
    [_doctorDetailContainer addSubview:btnUpdate];
    [_doctorDetailContainer addSubview:btnDelete];
    [_doctorDetailContainer addSubview:btnCancel];
    
    [self.view addSubview:_doctorDetailContainer];
}

- (void) initializeDoctorContactContainer{
    
    _doctorContactContainer = [[UIView alloc] initWithFrame:CGRectMake(0
                                                                      , [UIScreen mainScreen].bounds.size.height
                                                                      , [UIScreen mainScreen].bounds.size.width
                                                                      , 60)];
    [_doctorContactContainer setBackgroundColor:[UIColor colorWithRed:247/255.f green:247/255.f blue:247/255.f alpha:1.0]];
    
    UIButton *btnCall, *btnMessage, *btnMail;
    btnCall = [[Custombutton alloc] initWithFrame:CGRectMake(70, 10, 40, 40)];
    [btnCall addTarget:self action:@selector(btnPressedCall:) forControlEvents:UIControlEventTouchUpInside];
    [btnCall setBackgroundImage:[UIImage imageNamed:@"icon_contact" ] forState:UIControlStateNormal & UIControlStateSelected];
    btnCall.tag = 10;
    
    btnMessage = [[Custombutton alloc] initWithFrame:CGRectMake(140, 10, 40, 40)];
    [btnMessage addTarget:self action:@selector(btnPressedMessage:) forControlEvents:UIControlEventTouchUpInside];
    [btnMessage setBackgroundImage:[UIImage imageNamed:@"icon_sms" ] forState:UIControlStateNormal & UIControlStateSelected];
    btnMessage.tag = 20;
    
    btnMail = [[Custombutton alloc] initWithFrame:CGRectMake(210, 10, 40, 40)];
    [btnMail addTarget:self action:@selector(btnPressedMail:) forControlEvents:UIControlEventTouchUpInside];
    [btnMail setBackgroundImage:[UIImage imageNamed:@"icon_mail" ] forState:UIControlStateNormal & UIControlStateSelected];
    btnMail.tag = 30;
    
    
    [_doctorContactContainer addSubview:btnCall];
    [_doctorContactContainer addSubview:btnMessage];
    [_doctorContactContainer addSubview:btnMail];
    [self.view addSubview:_doctorContactContainer];
    
}

// selectors
-(void) btnPressedEdit: (UIButton *) sender{
    [self showDoctorInEditMode];
}

-(void) btnPressedUpdate: (UIButton *) sender{
    
}

-(void) btnPressedDelete: (UIButton *) sender{
    
}

- (void) btnPressedCancel : (UIButton *) sender {
    [self showDoctorInViewMode];
}

-(void) btnPressedMessage: (UIButton *) sender{
    
    if([MFMessageComposeViewController canSendText])
    {
        NSMutableDictionary *doctor = [[[_salesMonitorDelegate userData] valueForKey:KEY_DOCTORS] objectAtIndex:_selectedIndex];
        NSString *phoneNumber = [NSString stringWithFormat:@"%@", [doctor valueForKey:KEY_DOCTORS_PHONE]];
        NSString *cleanedString = [[phoneNumber componentsSeparatedByCharactersInSet:[[NSCharacterSet characterSetWithCharactersInString:@"0123456789-+()"] invertedSet]] componentsJoinedByString:@""];
        
        MFMessageComposeViewController *messenger = [[MFMessageComposeViewController alloc] init];
        
        //1(234)567-8910
        messenger.recipients = [NSArray arrayWithObjects:cleanedString, nil];
        messenger.messageComposeDelegate = self;
        [self presentViewController:messenger animated:YES completion:nil];
    }
}

-(void) btnPressedCall : (UIButton *) sender{

    NSMutableDictionary *doctor = [[[_salesMonitorDelegate userData] valueForKey:KEY_DOCTORS] objectAtIndex:_selectedIndex];
    NSString *phoneNumber = [NSString stringWithFormat:@"%@", [doctor valueForKey:KEY_DOCTORS_PHONE]];
    NSString *cleanedString = [[phoneNumber componentsSeparatedByCharactersInSet:[[NSCharacterSet characterSetWithCharactersInString:@"0123456789-+()"] invertedSet]] componentsJoinedByString:@""];
    
    UIApplication *myApp = [UIApplication sharedApplication];
    [myApp openURL:[NSURL URLWithString:[NSString stringWithFormat:@"telprompt://%@", cleanedString]]];
}

-(void) btnPressedMail  : (UIButton *) sender{
    
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
    [self showDoctorDetailSection];
}


- (void) showDoctorDetailSection {
    
    NSMutableDictionary *selectedDoctor = [[[_salesMonitorDelegate userData] valueForKey:KEY_DOCTORS] objectAtIndex:_selectedIndex];
    
    // branch details
    UILabel *lblDoctorName          = (UILabel *)[_doctorDetailContainer viewWithTag:10];
    UITextField *txtDoctorName      = (UITextField *)[_doctorDetailContainer viewWithTag:20];
    UILabel *lblDoctorSpeciality    = (UILabel *)[_doctorDetailContainer viewWithTag:30];
    UITextField *txtDoctorSpeciality = (UITextField *)[_doctorDetailContainer viewWithTag:40];
    UILabel *lblDoctorPhone         = (UILabel *)[_doctorDetailContainer viewWithTag:50];
    UITextField *txtDoctorPhone     = (UITextField *)[_doctorDetailContainer viewWithTag:60];
    UILabel *lblDoctorEmail         = (UILabel *)[_doctorDetailContainer viewWithTag:70];
    UITextField *txtDoctorEmail     = (UITextField *)[_doctorDetailContainer viewWithTag:80];
    UILabel *lblDoctorAddress       = (UILabel *)[_doctorDetailContainer viewWithTag:90];
    UITextView *txtDoctorAddress    = (UITextView *)[_doctorDetailContainer viewWithTag:100];
    
    
    [lblDoctorName setText:[selectedDoctor valueForKey:KEY_DOCTORS_NAME]];
    [txtDoctorName setText:[selectedDoctor valueForKey:KEY_DOCTORS_NAME]];
    [lblDoctorSpeciality setText:[selectedDoctor valueForKey:KEY_DOCTORS_SPECIALITY]];
    [txtDoctorSpeciality setText:[selectedDoctor valueForKey:KEY_DOCTORS_SPECIALITY]];
    [lblDoctorPhone setText:[NSString stringWithFormat:@"%@", [selectedDoctor valueForKey:KEY_DOCTORS_PHONE]]];
    [txtDoctorPhone setText:[NSString stringWithFormat:@"%@", [selectedDoctor valueForKey:KEY_DOCTORS_PHONE]]];
    [lblDoctorEmail setText:[selectedDoctor valueForKey:KEY_DOCTORS_EMAIL]];
    [txtDoctorEmail setText:[selectedDoctor valueForKey:KEY_DOCTORS_EMAIL]];
    [lblDoctorAddress setText:[selectedDoctor valueForKey:KEY_DOCTORS_ADDRESS]];
    [txtDoctorAddress setText:[selectedDoctor valueForKey:KEY_DOCTORS_ADDRESS]];    
    
    // showing back button at top
    UIButton *btnViewback   = (UIButton *)[_doctorDetailContainer viewWithTag:110];
    [btnViewback setHidden:NO];
    [btnViewback setAlpha:0.0];
    
    [UIView animateWithDuration:2.0
                          delay:0.0
                        options:UIViewAnimationOptionTransitionNone
                     animations:^{
                         [btnViewback setAlpha:1.0];
                     }
                     completion:^(BOOL finished) {
                         
                     }];
    
    
    // now showing content realted to only view mode means only label fields not text fields
    [self showDoctorInViewMode];

    // now the whole transition taking place for the parent containers
    [UIView transitionFromView:_doctorListContainer
                        toView:_doctorDetailContainer
                      duration:0.5
                       options:UIViewAnimationOptionTransitionCrossDissolve | UIViewAnimationOptionShowHideTransitionViews
                    completion:^(BOOL finished) {
                            [[self navigationController] setNavigationBarHidden:YES animated:YES];
                    } ];
    
    
    CGRect toFrame = CGRectMake(0
                                , [UIScreen mainScreen].bounds.size.height - 80
                                , [UIScreen mainScreen].bounds.size.width
                                , 60);
    
    [UIView animateWithDuration:2.0 animations:^{
        [_doctorContactContainer setFrame:toFrame];
        
        }];
    
}


- (void) showDoctorList {
    
    [[_doctorDetailContainer viewWithTag:10] setHidden:YES];
    [[_doctorDetailContainer viewWithTag:20] setHidden:YES];
    [[_doctorDetailContainer viewWithTag:30] setHidden:YES];
    [[_doctorDetailContainer viewWithTag:40] setHidden:YES];
    [[_doctorDetailContainer viewWithTag:50] setHidden:YES];
    [[_doctorDetailContainer viewWithTag:60] setHidden:YES];
    [[_doctorDetailContainer viewWithTag:70] setHidden:YES];
    [[_doctorDetailContainer viewWithTag:80] setHidden:YES];
    [[_doctorDetailContainer viewWithTag:90] setHidden:YES];
    [[_doctorDetailContainer viewWithTag:100] setHidden:YES];
    
    
    [UIView transitionFromView:_doctorDetailContainer
                        toView:_doctorListContainer
                      duration:0.6f
                       options:UIViewAnimationOptionTransitionCrossDissolve | UIViewAnimationOptionShowHideTransitionViews
                    completion:^(BOOL finished) {
                        
                        [UIView animateWithDuration:1.0 animations:^{
                            
                            CGRect toFrame = CGRectMake(0
                                                        , [UIScreen mainScreen].bounds.size.height
                                                        , [UIScreen mainScreen].bounds.size.width
                                                        , 60);
                            [_doctorContactContainer setFrame:toFrame];
                            
                        } completion:^(BOOL finished) {
                            
                            [[self navigationController] setNavigationBarHidden:NO animated:YES];
                        }];
                    } ];
    
}



- (void) showDoctorInViewMode {
    
    UILabel *lblDoctorName          = (UILabel *)[_doctorDetailContainer viewWithTag:10];
    UITextField *txtDoctorName      = (UITextField *)[_doctorDetailContainer viewWithTag:20];
    UILabel *lblDoctorSpeciality    = (UILabel *)[_doctorDetailContainer viewWithTag:30];
    UITextField *txtDoctorSpeciality = (UITextField *)[_doctorDetailContainer viewWithTag:40];
    UILabel *lblDoctorPhone         = (UILabel *)[_doctorDetailContainer viewWithTag:50];
    UITextField *txtDoctorPhone     = (UITextField *)[_doctorDetailContainer viewWithTag:60];
    UILabel *lblDoctorEmail         = (UILabel *)[_doctorDetailContainer viewWithTag:70];
    UITextField *txtDoctorEmail     = (UITextField *)[_doctorDetailContainer viewWithTag:80];
    UILabel *lblDoctorAddress       = (UILabel *)[_doctorDetailContainer viewWithTag:90];
    UITextView *txtDoctorAddress    = (UITextView *)[_doctorDetailContainer viewWithTag:100];
    
    UIButton *btnEdit   = (UIButton *)[_doctorDetailContainer viewWithTag:120];
    UIButton *btnUpdate = (UIButton *)[_doctorDetailContainer viewWithTag:130];
    UIButton *btnDelete = (UIButton *)[_doctorDetailContainer viewWithTag:140];
    UIButton *btnCancel = (UIButton *)[_doctorDetailContainer viewWithTag:150];
    
    // showing view fields
    // labels
    [lblDoctorName setHidden:NO];
    [lblDoctorSpeciality setHidden:NO];
    [lblDoctorPhone setHidden:NO];
    [lblDoctorEmail setHidden:NO];
    [lblDoctorAddress setHidden:NO];

    // buttons
    [btnEdit setHidden:NO];
    
    // seting alpha for transition effect
    [lblDoctorName setAlpha:0.0];
    [lblDoctorSpeciality setAlpha:0.0];
    [lblDoctorPhone setAlpha:0.0];
    [lblDoctorEmail setAlpha:0.0];
    [lblDoctorAddress setAlpha:0.0];
    [btnEdit setAlpha:0.0];
    
    [UIView animateWithDuration:2.0
                          delay:0.0
                        options:UIViewAnimationOptionTransitionNone
                     animations:^{
                        
                         [lblDoctorName setAlpha:1.0];
                         [lblDoctorSpeciality setAlpha:1.0];
                         [lblDoctorPhone setAlpha:1.0];
                         [lblDoctorEmail setAlpha:1.0];
                         [lblDoctorAddress setAlpha:1.0];
            
                         [btnEdit setAlpha:1.0];
                     }
                     completion:^(BOOL finished) {
                         
                         // hinding edit fields
                         [txtDoctorName setHidden:YES];
                         [txtDoctorSpeciality setHidden:YES];
                         [txtDoctorPhone setHidden:YES];
                         [txtDoctorEmail setHidden:YES];
                         [txtDoctorAddress setHidden:YES];
                         
                         [btnUpdate setHidden:YES];
                         [btnDelete setHidden:YES];
                         [btnCancel setHidden:YES];
                         
                     }];
}


- (void) showDoctorInEditMode {
    
    
    UILabel *lblDoctorName          = (UILabel *)[_doctorDetailContainer viewWithTag:10];
    UITextField *txtDoctorName      = (UITextField *)[_doctorDetailContainer viewWithTag:20];
    UILabel *lblDoctorSpeciality    = (UILabel *)[_doctorDetailContainer viewWithTag:30];
    UITextField *txtDoctorSpeciality = (UITextField *)[_doctorDetailContainer viewWithTag:40];
    UILabel *lblDoctorPhone         = (UILabel *)[_doctorDetailContainer viewWithTag:50];
    UITextField *txtDoctorPhone     = (UITextField *)[_doctorDetailContainer viewWithTag:60];
    UILabel *lblDoctorEmail         = (UILabel *)[_doctorDetailContainer viewWithTag:70];
    UITextField *txtDoctorEmail     = (UITextField *)[_doctorDetailContainer viewWithTag:80];
    UILabel *lblDoctorAddress       = (UILabel *)[_doctorDetailContainer viewWithTag:90];
    UITextView *txtDoctorAddress    = (UITextView *)[_doctorDetailContainer viewWithTag:100];
    
    UIButton *btnEdit   = (UIButton *)[_doctorDetailContainer viewWithTag:120];
    UIButton *btnUpdate = (UIButton *)[_doctorDetailContainer viewWithTag:130];
    UIButton *btnDelete = (UIButton *)[_doctorDetailContainer viewWithTag:140];
    UIButton *btnCancel = (UIButton *)[_doctorDetailContainer viewWithTag:150];
    
    // showing view fields
    // text fields
    [txtDoctorName setHidden:NO];
    [txtDoctorSpeciality setHidden:NO];
    [txtDoctorPhone setHidden:NO];
    [txtDoctorEmail setHidden:NO];
    [txtDoctorAddress setHidden:NO];

    // button fields
    [btnUpdate setHidden:NO];
    [btnDelete setHidden:NO];
    [btnCancel setHidden:NO];
    
    // setting alpha for transition
    [txtDoctorName setAlpha:0.0];
    [txtDoctorSpeciality setAlpha:0.0];
    [txtDoctorPhone setAlpha:0.0];
    [txtDoctorEmail setAlpha:0.0];
    [txtDoctorAddress setAlpha:0.0];
    
    [UIView animateWithDuration:2.0
                          delay:0.0
                        options:UIViewAnimationOptionTransitionNone
                     animations:^{
                         
                         // hinding edit fields
                         [txtDoctorName setAlpha:1.0];
                         [txtDoctorSpeciality setAlpha:1.0];
                         [txtDoctorPhone setAlpha:1.0];
                         [txtDoctorEmail setAlpha:1.0];
                         [txtDoctorAddress setAlpha:1.0];
                         
                     }
                     completion:^(BOOL finished) {
                         
                         [lblDoctorName setHidden:YES];
                         [lblDoctorSpeciality setHidden:YES];
                         [lblDoctorPhone setHidden:YES];
                         [lblDoctorEmail setHidden:YES];
                         [lblDoctorAddress setHidden:YES];
                         
                         [btnEdit setHidden:YES];
                     }];
}

@end
