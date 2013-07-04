//
//  doctorViewController_iPad.m
//  salesmonitor
//
//  Created by goodcore2 on 6/12/13.
//  Copyright (c) 2013 GoodCore. All rights reserved.
//

#import "doctorViewController_iPad.h"

@interface doctorViewController_iPad ()

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
@property (nonatomic, strong) NSString *cacheImagePath;

@end

@implementation doctorViewController_iPad

@synthesize popoverController;

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
  salesMonitorDelegate:(AppDelegate *)salesMonitorDelegate{
    
    self = [self initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    
    if (self) {
        _salesMonitorDelegate   = salesMonitorDelegate;
        _isIphone   = YES;
    }
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self initializeData];
    [self initializeViews];
    [self showDoctorInAddMode];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// view related methods
// view related methods
- (void) initializeData {
    
    _isIphone = ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone);
    _doctorController = [[DoctorController alloc] init:_isIphone
                                            loadDoctor:[[_salesMonitorDelegate userData] valueForKey:KEY_DOCTORS]
                                  salesMonitorDelegate:_salesMonitorDelegate
                                        viewController:self];
}

- (void) initializeViews {
    
    [self customizeNavigationBar];
    [self initializeMainView];
    [self initializeDoctorListContainer ];
    [self initializeDoctorTable];
    [self initializeSeperatorView];
    [self initializeDoctorDetailContainer];
    [self initializeDoctorContactContainer];
}

- (void) customizeNavigationBar{
    
    // icons in navigation bar
    _navBarContainer = [[UIView alloc] initWithFrame:CGRectMake(10, 10, [UIScreen mainScreen].bounds.size.width-10, 67)];
    [_navBarContainer setBackgroundColor:[UIColor clearColor]];
    
    UIImageView *imgViewBackGround = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 67)];
    [imgViewBackGround setContentMode:UIViewContentModeScaleAspectFill];
    [imgViewBackGround setClipsToBounds:YES];
    [imgViewBackGround setImage:[UIImage imageNamed:@"topBarBg"]];
    [imgViewBackGround setTag:10];
    
    UIImageView *imgViewLogo = [[UIImageView alloc] initWithFrame:CGRectMake(90, 0, 267, 63)];
    [imgViewLogo setContentMode:UIViewContentModeScaleAspectFill];
    [imgViewLogo setClipsToBounds:YES];
    [imgViewLogo setImage:[UIImage imageNamed:@"barLogo"]];
    [imgViewLogo setTag:20];
    
    UIButton *btnNavBarBack = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 84, 63)];
    [btnNavBarBack setImage:[UIImage imageNamed:@"backBtn"] forState:UIControlStateNormal];
    btnNavBarBack.imageView.contentMode = UIViewContentModeScaleToFill;
    [btnNavBarBack addTarget:self action:@selector(btnPressedNavBarBack:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *btnNavBarAdd = [[UIButton alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width - 92, 0, 82, 63)];
    [btnNavBarAdd setImage:[UIImage imageNamed:@"addBtn"] forState:UIControlStateNormal];
    btnNavBarAdd.imageView.contentMode = UIViewContentModeScaleToFill;
    [btnNavBarAdd addTarget:self action:@selector(btnPressedNavBarAdd:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btnNavBarAdd];
    
    
    [_navBarContainer addSubview:imgViewBackGround];
    [_navBarContainer addSubview:imgViewLogo];
    [_navBarContainer addSubview:btnNavBarBack];
    [_navBarContainer addSubview:btnNavBarAdd];
    [self.view addSubview:_navBarContainer];
}

- (void) initializeMainView {
    
    [self.view setFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
}

- (void) initializeDoctorListContainer {
    
    _doctorListContainer = [[UIView alloc] initWithFrame:CGRectMake(0
                                                                    , 77
                                                                    , 400
                                                                    , [UIScreen mainScreen].bounds.size.height - 107)];
    [_doctorListContainer setBackgroundColor:[UIColor clearColor]];
    [self.view addSubview:_doctorListContainer];
}

- (void) initializeDoctorTable {
    
    _tblDoctor = [[UITableView alloc] initWithFrame:CGRectMake(0
                                                               , 10
                                                               , 390
                                                               , [UIScreen mainScreen].bounds.size.height - 107)];
    
    _tblDoctor.delegate = _doctorController;
    _tblDoctor.dataSource = _doctorController;
    [_tblDoctor setBackgroundColor:[UIColor clearColor]];
    [_tblDoctor setSeparatorColor:[UIColor clearColor]];
    [_doctorListContainer addSubview:_tblDoctor];
}

-(void) initializeSeperatorView {
    
    UIView *vwSeperator = [[UIView alloc] initWithFrame:CGRectMake(400, 77, 2, [UIScreen mainScreen].bounds.size.height-77)];
    [vwSeperator setBackgroundColor:[UIColor darkGrayColor]];
    [self.view addSubview:vwSeperator];
    
}

- (void) initializeDoctorDetailContainer{
    
    _doctorDetailContainer = [[UIView alloc] initWithFrame:CGRectMake(402
                                                                      , 77
                                                                      , 366
                                                                      , [UIScreen mainScreen].bounds.size.height - 200)];
    
    _doctorDetailContainer.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"rightColBg"]];
    
    CustomImageView *imgViewDoctor = [[CustomImageView alloc] initWithFrame:CGRectMake(32, 50, 300, 193)];
    [imgViewDoctor setUserInteractionEnabled:YES];
    [imgViewDoctor setImage:[UIImage imageNamed:@"bigAvater"]];
    [imgViewDoctor.layer setBorderWidth:1.0];
    [imgViewDoctor setTag:200];
    
    UIButton *btnImage = [[UIButton alloc] initWithFrame:CGRectMake(32, 50, 300, 193)];
    [btnImage addTarget:self action:@selector(btnPressedImageDoctor:) forControlEvents:UIControlEventTouchUpInside];
    [btnImage setBackgroundColor:[UIColor clearColor]];
    [imgViewDoctor addSubview:btnImage];
    
    UILabel *lblDoctorName = [[UILabel alloc] initWithFrame:CGRectMake(32, 13, 300, 24)];
    [lblDoctorName setBackgroundColor:[UIColor clearColor]];
    lblDoctorName.font = [UIFont fontWithName:@"Helvetica" size:18.0];
    [lblDoctorName setNumberOfLines:2];
    [lblDoctorName setTextColor:[UIColor darkGrayColor]];
    lblDoctorName.contentMode = UIViewContentModeBottomLeft;
    //lblDoctorName.textAlignment = NSTextAlignmentCenter;
    [lblDoctorName adjustsFontSizeToFitWidth];
    [lblDoctorName setHidden:YES];
    [lblDoctorName setTag:10];
    [lblDoctorName setTextColor:[UIColor whiteColor]];
    
    UITextField *txtDoctorName = [[UITextField alloc] initWithFrame:CGRectMake(32, 13, 300, 24)];
    [txtDoctorName setPlaceholder:@"name"];
    [txtDoctorName setBackgroundColor:[UIColor clearColor]];
    txtDoctorName.font = [UIFont fontWithName:@"Helvetica" size:18.0];
    [txtDoctorName setTextColor:[UIColor darkGrayColor]];
    txtDoctorName.contentMode = UIViewContentModeBottomLeft;
    //txtDoctorName.textAlignment = NSTextAlignmentCenter;
    [txtDoctorName.layer setBorderColor:[UIColor colorWithWhite:0.70 alpha:0.8].CGColor];
    [txtDoctorName.layer setShadowColor:[UIColor colorWithWhite:0.7 alpha:1.0].CGColor];
    [txtDoctorName setBorderStyle:UITextBorderStyleRoundedRect];
    [txtDoctorName setAutocorrectionType:UITextAutocorrectionTypeNo];
    [txtDoctorName setHidden:YES];
    [txtDoctorName setDelegate:self];
    [txtDoctorName setTag:20];
    [txtDoctorName setTextColor:[UIColor whiteColor]];
    
    UILabel *lblDoctorSpeciality = [[UILabel alloc] initWithFrame:CGRectMake(32, 300, 300, 24)];
    [lblDoctorSpeciality setBackgroundColor:[UIColor clearColor]];
    lblDoctorSpeciality.font = [UIFont fontWithName:@"Helvetica" size:18.0];
    [lblDoctorSpeciality setNumberOfLines:2];
    [lblDoctorSpeciality setTextColor:[UIColor darkGrayColor]];
    lblDoctorSpeciality.contentMode = UIViewContentModeBottomLeft;
    lblDoctorSpeciality.textAlignment = NSTextAlignmentCenter;
    [lblDoctorSpeciality adjustsFontSizeToFitWidth];
    [lblDoctorSpeciality setHidden:NO];
    [lblDoctorSpeciality setTag:30];
    [lblDoctorSpeciality setTextColor:[UIColor whiteColor]];
    [lblDoctorSpeciality setText:@"Speciality :"];
    
    UITextField *txtDoctorSpeciality = [[UITextField alloc] initWithFrame:CGRectMake(32, 300, 300, 24)];
    [txtDoctorSpeciality setPlaceholder:@"speciality"];
    [txtDoctorSpeciality setBackgroundColor:[UIColor clearColor]];
    txtDoctorSpeciality.font = [UIFont fontWithName:@"Helvetica" size:18.0];
    [txtDoctorSpeciality setTextColor:[UIColor darkGrayColor]];
    txtDoctorSpeciality.contentMode = UIViewContentModeBottomLeft;
    txtDoctorSpeciality.textAlignment = NSTextAlignmentCenter;
    [txtDoctorSpeciality.layer setBorderColor:[UIColor colorWithWhite:0.70 alpha:0.8].CGColor];
    [txtDoctorSpeciality.layer setShadowColor:[UIColor colorWithWhite:0.7 alpha:1.0].CGColor];
    [txtDoctorSpeciality setBorderStyle:UITextBorderStyleRoundedRect];
    [txtDoctorSpeciality setAutocorrectionType:UITextAutocorrectionTypeNo];
    [txtDoctorSpeciality setDelegate:self];
    [txtDoctorSpeciality setHidden:NO];
    [txtDoctorSpeciality setTag:40];
    [txtDoctorSpeciality setTextColor:[UIColor whiteColor]];
    
    UIView *vwSeperator1 = [[UIView alloc] initWithFrame:CGRectMake(32, 334, 300, 1)];
    vwSeperator1.backgroundColor = [UIColor whiteColor];
    vwSeperator1.tag = 1000;
    
    UILabel *lblDoctorPhone = [[UILabel alloc] initWithFrame:CGRectMake(32, 345, 300, 24)];
    [lblDoctorPhone setBackgroundColor:[UIColor clearColor]];
    lblDoctorPhone.font = [UIFont fontWithName:@"Helvetica" size:18.0];
    [lblDoctorPhone setNumberOfLines:2];
    [lblDoctorPhone setTextColor:[UIColor darkGrayColor]];
    lblDoctorPhone.contentMode = UIViewContentModeBottomLeft;
    lblDoctorPhone.textAlignment = NSTextAlignmentCenter;
    [lblDoctorPhone adjustsFontSizeToFitWidth];
    [lblDoctorPhone setHidden:YES];
    [lblDoctorPhone setTag:50];
    [lblDoctorPhone setTextColor:[UIColor whiteColor]];
    
    UITextField *txtDoctorPhone = [[UITextField alloc] initWithFrame:CGRectMake(32, 345, 300, 24)];
    [txtDoctorPhone setPlaceholder:@"+14134562"];
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
    [txtDoctorPhone setDelegate:self];
    [txtDoctorPhone setHidden:YES];
    [txtDoctorPhone setTag:60];
    [txtDoctorPhone setTextColor:[UIColor whiteColor]];
    
    UIView *vwSeperator2 = [[UIView alloc] initWithFrame:CGRectMake(32, 379, 300, 1)];
    vwSeperator2.backgroundColor = [UIColor whiteColor];
    vwSeperator2.tag = 2000;
    
    UIBarButtonItem *barButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone
                                                                               target:self
                                                                               action:@selector(btnPressedNumericTextFieldResign:)];
    
    UIToolbar *toolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 44)];
    toolbar.tintColor = [UIColor blackColor];
    toolbar.items = [NSArray arrayWithObject:barButton];
    txtDoctorPhone.inputAccessoryView = toolbar;
    
    UILabel *lblDoctorEmail = [[UILabel alloc] initWithFrame:CGRectMake(32, 390, 300, 24)];
    [lblDoctorEmail setBackgroundColor:[UIColor clearColor]];
    lblDoctorEmail.font = [UIFont fontWithName:@"Helvetica" size:18.0];
    [lblDoctorEmail setNumberOfLines:1];
    [lblDoctorEmail setTextColor:[UIColor darkGrayColor]];
    lblDoctorEmail.contentMode = UIViewContentModeBottomLeft;
    lblDoctorEmail.textAlignment = NSTextAlignmentCenter;
    [lblDoctorEmail adjustsFontSizeToFitWidth];
    [lblDoctorEmail setHidden:YES];
    [lblDoctorEmail setTag:70];
    [lblDoctorEmail setTextColor:[UIColor whiteColor]];
    
    UITextField *txtDoctorEmail = [[UITextField alloc] initWithFrame:CGRectMake(32, 390, 300, 24)];
    [txtDoctorEmail setPlaceholder:@"name@mail.com"];
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
    [txtDoctorEmail setDelegate:self];
    [txtDoctorEmail setHidden:YES];
    [txtDoctorEmail setTag:80];
    [txtDoctorEmail setTextColor:[UIColor whiteColor]];
    
    UIView *vwSeperator3 = [[UIView alloc] initWithFrame:CGRectMake(32, 424, 300, 1)];
    vwSeperator3.backgroundColor = [UIColor whiteColor];
    vwSeperator3.tag = 3000;
    
    UILabel *lblDoctorAddress = [[UILabel alloc] initWithFrame:CGRectMake(32, 435, 300, 60)];
    [lblDoctorAddress setBackgroundColor:[UIColor clearColor]];
    lblDoctorAddress.font = [UIFont fontWithName:@"Helvetica" size:12.0];
    [lblDoctorAddress setNumberOfLines:4];
    [lblDoctorAddress setTextColor:[UIColor grayColor]];
    lblDoctorAddress.contentMode = UIViewContentModeTopLeft;
    [lblDoctorAddress adjustsFontSizeToFitWidth];
    [lblDoctorAddress setHidden:YES];
    lblDoctorAddress.textAlignment = NSTextAlignmentCenter;
    [lblDoctorAddress setTag:90];
    [lblDoctorAddress setTextColor:[UIColor whiteColor]];
    
    UITextView *txtDoctorAddress = [[UITextView alloc] initWithFrame:CGRectMake(32, 435, 300, 60)];
    [txtDoctorAddress setBackgroundColor:[UIColor clearColor]];
    txtDoctorAddress.font = [UIFont fontWithName:@"Helvetica" size:12.0];
    [txtDoctorAddress setTextColor:[UIColor grayColor]];
    txtDoctorAddress.contentMode = UIViewContentModeTopLeft;
    [txtDoctorAddress.layer setBorderColor:[UIColor colorWithWhite:0.70 alpha:0.8].CGColor];
    [txtDoctorAddress.layer setShadowColor:[UIColor colorWithWhite:0.7 alpha:1.0].CGColor];
    //[txtDoctorAddress.layer setCornerRadius:6];
    [txtDoctorAddress.layer setBorderWidth:1.0];
    [txtDoctorAddress setAutocorrectionType:UITextAutocorrectionTypeNo];
    [txtDoctorAddress setDelegate:self];
    [txtDoctorAddress setHidden:YES];
    txtDoctorAddress.textAlignment = NSTextAlignmentCenter;
    [txtDoctorAddress setTag:100];
    [txtDoctorAddress setTextColor:[UIColor whiteColor]];
    
    UIButton *btnAdd = [[UIButton alloc] initWithFrame:CGRectMake(32, 515, 300, 50)];
    [btnAdd setTitle:@"Add" forState:UIControlStateNormal & UIControlStateSelected];
    [btnAdd setBackgroundColor:[UIColor colorWithRed:154/255.f green:180/255.f blue:92/255.f alpha:1.0]];
    [[btnAdd titleLabel] setTextColor:[UIColor colorWithRed:218/255.f green:218/255.f blue:215/255.f alpha:1.0]];
    [btnAdd.layer setCornerRadius:4];
    [btnAdd addTarget:self action:@selector(btnPressedAdd:) forControlEvents:UIControlEventTouchUpInside];
    [btnAdd setTag:120];
    [btnAdd setHidden:YES];
    [btnAdd setImage:[UIImage imageNamed:@"addBtn"] forState:UIControlStateNormal];
    
    UIButton *btnEdit = [[UIButton alloc] initWithFrame:CGRectMake(32, 515, 302, 50)];
    [btnEdit setTitle:@"Edit" forState:UIControlStateNormal & UIControlStateSelected];
    [btnEdit setBackgroundColor:[UIColor colorWithRed:154/255.f green:180/255.f blue:92/255.f alpha:1.0]];
    [[btnEdit titleLabel] setTextColor:[UIColor colorWithRed:218/255.f green:218/255.f blue:215/255.f alpha:1.0]];
    [btnEdit.layer setCornerRadius:4];
    [btnEdit addTarget:self action:@selector(btnPressedEdit:) forControlEvents:UIControlEventTouchUpInside];
    [btnEdit setTag:130];
    [btnEdit setHidden:YES];
    [btnEdit setImage:[UIImage imageNamed:@"editBtn"] forState:UIControlStateNormal];
    
    UIButton *btnUpdate = [[UIButton alloc] initWithFrame:CGRectMake(32, 515, 300, 50)];
    [btnUpdate setTitle:@"Update" forState:UIControlStateNormal & UIControlStateSelected];
    [btnUpdate setBackgroundColor:[UIColor colorWithRed:154/255.f green:180/255.f blue:92/255.f alpha:1.0]];
    [[btnUpdate titleLabel] setTextColor:[UIColor colorWithRed:218/255.f green:218/255.f blue:215/255.f alpha:1.0]];
    [btnUpdate.layer setCornerRadius:4];
    [btnUpdate addTarget:self action:@selector(btnPressedUpdate:) forControlEvents:UIControlEventTouchUpInside];
    [btnUpdate setTag:140];
    [btnUpdate setHidden:YES];
    [btnUpdate setImage:[UIImage imageNamed:@"submitBtn"] forState:UIControlStateNormal];
    
    UIButton *btnDelete = [[UIButton alloc] initWithFrame:CGRectMake(32, 575, 300, 50)];
    [btnDelete setTitle:@"Delete" forState:UIControlStateNormal & UIControlStateSelected];
    [btnDelete setBackgroundColor:[UIColor colorWithRed:154/255.f green:180/255.f blue:92/255.f alpha:1.0]];
    [[btnDelete titleLabel] setTextColor:[UIColor colorWithRed:218/255.f green:218/255.f blue:215/255.f alpha:1.0]];
    [btnDelete.layer setCornerRadius:4];
    [btnDelete addTarget:self action:@selector(btnPressedDelete:) forControlEvents:UIControlEventTouchUpInside];
    [btnDelete setTag:150];
    [btnDelete setHidden:YES];
    [btnDelete setImage:[UIImage imageNamed:@"loginBtn"] forState:UIControlStateNormal];
    
    UIButton *btnCancel = [[UIButton alloc] initWithFrame:CGRectMake(32, 635, 300, 50)];
    [btnCancel setTitle:@"Cancel" forState:UIControlStateNormal & UIControlStateSelected];
    [btnCancel setBackgroundColor:[UIColor colorWithRed:154/255.f green:180/255.f blue:92/255.f alpha:1.0]];
    [[btnCancel titleLabel] setTextColor:[UIColor colorWithRed:218/255.f green:218/255.f blue:215/255.f alpha:1.0]];
    [btnCancel.layer setCornerRadius:4];
    [btnCancel addTarget:self action:@selector(btnPressedCancel:) forControlEvents:UIControlEventTouchUpInside];
    [btnCancel setTag:160];
    [btnCancel setHidden:YES];
    
    
    vwSeperator1.hidden = vwSeperator2.hidden = vwSeperator3.hidden = YES;
    
    [_doctorDetailContainer addSubview:imgViewDoctor];
    [_doctorDetailContainer addSubview:lblDoctorName];
    [_doctorDetailContainer addSubview:txtDoctorName];
    [_doctorDetailContainer addSubview:lblDoctorSpeciality];
    [_doctorDetailContainer addSubview:txtDoctorSpeciality];
    
    [_doctorDetailContainer addSubview:vwSeperator1];
    
    [_doctorDetailContainer addSubview:lblDoctorPhone];
    [_doctorDetailContainer addSubview:txtDoctorPhone];
    
    [_doctorDetailContainer addSubview:vwSeperator2];
    
    [_doctorDetailContainer addSubview:lblDoctorEmail];
    [_doctorDetailContainer addSubview:txtDoctorEmail];
    
    [_doctorDetailContainer addSubview:vwSeperator3];
    
    [_doctorDetailContainer addSubview:lblDoctorAddress];
    [_doctorDetailContainer addSubview:txtDoctorAddress];
    
    // edit/view switch supported methods
    [_doctorDetailContainer addSubview:btnAdd];
    [_doctorDetailContainer addSubview:btnEdit];
    [_doctorDetailContainer addSubview:btnUpdate];
    [_doctorDetailContainer addSubview:btnDelete];
    [_doctorDetailContainer addSubview:btnCancel];
    
    
    [self.view addSubview:_doctorDetailContainer];
}

- (void) initializeDoctorContactContainer{
    
    _doctorContactContainer = [[UIView alloc] initWithFrame:CGRectMake(402
                                                                       , [UIScreen mainScreen].bounds.size.height
                                                                       , 366
                                                                       , 60)];
    [_doctorContactContainer setBackgroundColor:[UIColor colorWithRed:247/255.f green:247/255.f blue:247/255.f alpha:1.0]];
    
    UIButton *btnCall, *btnMessage, *btnMail;
    btnCall = [[Custombutton alloc] initWithFrame:CGRectMake(90, 10, 40, 40)];
    [btnCall addTarget:self action:@selector(btnPressedCall:) forControlEvents:UIControlEventTouchUpInside];
    [btnCall setBackgroundImage:[UIImage imageNamed:@"icon_contact" ] forState:UIControlStateNormal & UIControlStateSelected];
    btnCall.tag = 10;
    
    btnMessage = [[Custombutton alloc] initWithFrame:CGRectMake(164, 10, 40, 40)];
    [btnMessage addTarget:self action:@selector(btnPressedMessage:) forControlEvents:UIControlEventTouchUpInside];
    [btnMessage setBackgroundImage:[UIImage imageNamed:@"icon_sms" ] forState:UIControlStateNormal & UIControlStateSelected];
    btnMessage.tag = 20;
    
    btnMail = [[Custombutton alloc] initWithFrame:CGRectMake(230, 10, 40, 40)];
    [btnMail addTarget:self action:@selector(btnPressedMail:) forControlEvents:UIControlEventTouchUpInside];
    [btnMail setBackgroundImage:[UIImage imageNamed:@"icon_mail" ] forState:UIControlStateNormal & UIControlStateSelected];
    btnMail.tag = 30;
    
    
    [_doctorContactContainer addSubview:btnCall];
    [_doctorContactContainer addSubview:btnMessage];
    [_doctorContactContainer addSubview:btnMail];
    [self.view addSubview:_doctorContactContainer];
    
}

// selectors
-(void) btnPressedNavBarAdd: (UIButton *) sender{
    
    [self showDoctorDetailSection:YES];
}

-(void) btnPressedNavBarBack: (UIButton *) sender{
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (void) btnPressedImageDoctor: (UIButton *) sender{
    
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
    imagePicker.delegate = self;
    
    BlockActionSheet *actionSheet = [BlockActionSheet sheetWithTitle:nil];
    // Should be able to view bot card for bot
    [actionSheet addButtonWithTitle:@"Use Image from library" block:^{
        imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        UIPopoverController *popover = [[UIPopoverController alloc] initWithContentViewController:imagePicker];
        self.popoverController = popover;
        popoverController.delegate = self;
        [popoverController presentPopoverFromRect:CGRectMake(100, 250, 564, 800)
                                           inView:self.view
                         permittedArrowDirections:UIPopoverArrowDirectionUp
                                         animated:YES];
    }];
    
    // Should be able to view bot card for bot
    [actionSheet addButtonWithTitle:@"Take picture from camera" block:^{
        imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
        [self presentViewController:imagePicker animated:YES completion:nil];
    }];
    
    // Should be able to view bot card for bot
    [actionSheet setDestructiveButtonWithTitle:@"Cancel" block:^{
    }];
    
    [actionSheet showInView:self.view];
}

-(void) btnPressedAdd: (UIButton *) sender{
    
    CustomImageView *imgViewDoctor = (CustomImageView *)[_doctorDetailContainer viewWithTag:200];
    UITextField *txtDoctorName      = (UITextField *)[_doctorDetailContainer viewWithTag:20];
    UITextField *txtDoctorSpeciality = (UITextField *)[_doctorDetailContainer viewWithTag:40];
    UITextField *txtDoctorPhone     = (UITextField *)[_doctorDetailContainer viewWithTag:60];
    UITextField *txtDoctorEmail     = (UITextField *)[_doctorDetailContainer viewWithTag:80];
    UITextView *txtDoctorAddress    = (UITextView *)[_doctorDetailContainer viewWithTag:100];
    
    NSMutableDictionary *doctor = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                                   imgViewDoctor.cacheImagePath , KEY_DOCTORS_IMAGE
                                   , txtDoctorName.text, KEY_DOCTORS_NAME
                                   , txtDoctorSpeciality.text , KEY_DOCTORS_SPECIALITY
                                   , [NSNumber numberWithLongLong:[txtDoctorPhone.text longLongValue]], KEY_DOCTORS_PHONE
                                   , txtDoctorEmail.text, KEY_DOCTORS_EMAIL
                                   , txtDoctorAddress.text, KEY_DOCTORS_ADDRESS
                                   , nil];
    
    NSMutableDictionary *doctorContainer = [[NSMutableDictionary alloc] initWithObjectsAndKeys:doctor, KEY_DOCTOR_ADD, nil];
    [_doctorController add:doctorContainer];
}

-(void) btnPressedEdit: (UIButton *) sender{
    [self showDoctorInEditMode];
}

-(void) btnPressedUpdate: (UIButton *) sender{
    
    CustomImageView *imgViewDoctor = (CustomImageView *)[_doctorDetailContainer viewWithTag:200];
    UITextField *txtDoctorName      = (UITextField *)[_doctorDetailContainer viewWithTag:20];
    UITextField *txtDoctorSpeciality = (UITextField *)[_doctorDetailContainer viewWithTag:40];
    UITextField *txtDoctorPhone     = (UITextField *)[_doctorDetailContainer viewWithTag:60];
    UITextField *txtDoctorEmail     = (UITextField *)[_doctorDetailContainer viewWithTag:80];
    UITextView *txtDoctorAddress    = (UITextView *)[_doctorDetailContainer viewWithTag:100];
    
    NSMutableDictionary *doctor = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                                   imgViewDoctor.cacheImagePath , KEY_DOCTORS_IMAGE
                                   , txtDoctorName.text, KEY_DOCTORS_NAME
                                   , txtDoctorSpeciality.text , KEY_DOCTORS_SPECIALITY
                                   , [NSNumber numberWithLongLong:[txtDoctorPhone.text longLongValue]], KEY_DOCTORS_PHONE
                                   , txtDoctorEmail.text, KEY_DOCTORS_EMAIL
                                   , txtDoctorAddress.text, KEY_DOCTORS_ADDRESS
                                   , nil];
    
    NSMutableDictionary *selectedDoctor = [[[_salesMonitorDelegate userData] valueForKey:KEY_DOCTORS] objectAtIndex:_selectedIndex];
    NSMutableDictionary *doctorContainer = [[NSMutableDictionary alloc] initWithObjectsAndKeys:doctor, KEY_DOCTOR_ADD, nil];
    [_doctorController update:doctorContainer _id:[selectedDoctor valueForKey:KEY_DOCTORS_ID]];
}

-(void) btnPressedDelete: (UIButton *) sender{
    
    NSMutableDictionary *selectedDoctor = [[[_salesMonitorDelegate userData] valueForKey:KEY_DOCTORS] objectAtIndex:_selectedIndex];
    [_doctorController delete:selectedDoctor];
}

- (void) btnPressedCancel : (UIButton *) sender {
    
    [self.view endEditing:YES];
    [self showDoctorDetailSection:NO];
}

-(void) btnPressedNumericTextFieldResign: (UIButton *) sender{
    
    [self.view endEditing:YES];
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
        
        SIAlertView *alertView = [[SIAlertView alloc] initWithTitle:@"Failure" andMessage:@"Your device doesn't support the composer sheet"];
        [alertView addButtonWithTitle:@"Ok"
                                 type:SIAlertViewButtonTypeDestructive
                              handler:^(SIAlertView *alertView) {
                              }];
        alertView.transitionStyle = SIAlertViewTransitionStyleSlideFromTop;
        [alertView show];
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
    [self showDoctorDetailSection: NO];
}

-(void)doctorAdd : (BOOL) isSuccess msg : (NSString *)msg{
    
    [self.view endEditing:YES];
    
    if(isSuccess){
        
        [self updateViewAfterChangeInCoreData:add];
        [SVProgressHUD showSuccessWithStatus:msg duration:0.5];
    }
    else{
        
        SIAlertView *alertView = [[SIAlertView alloc] initWithTitle:@"Failure" andMessage:msg];
        [alertView addButtonWithTitle:@"Ok"
                                 type:SIAlertViewButtonTypeDestructive
                              handler:^(SIAlertView *alertView) {
                              }];
        alertView.transitionStyle = SIAlertViewTransitionStyleSlideFromTop;
        [alertView show];
    }
}

-(void)doctorUpdate : (BOOL) isSuccess msg : (NSString *)msg{
    
    [self.view endEditing:YES];
    
    if(isSuccess){
        
        [self updateViewAfterChangeInCoreData:update];
        [SVProgressHUD showSuccessWithStatus:msg duration:0.5];
    }
    else{
        
        SIAlertView *alertView = [[SIAlertView alloc] initWithTitle:@"Failure" andMessage:msg];
        [alertView addButtonWithTitle:@"Ok"
                                 type:SIAlertViewButtonTypeDestructive
                              handler:^(SIAlertView *alertView) {
                              }];
        alertView.transitionStyle = SIAlertViewTransitionStyleSlideFromTop;
        [alertView show];
    }
}

-(void)doctorDelete : (BOOL) isSuccess msg : (NSString *)msg{
    
    [self.view endEditing:YES];
    
    if(isSuccess){
        
        [self updateViewAfterChangeInCoreData:delete];
        [self deleteImagesCreatedByApplicationAtDevice];
        [SVProgressHUD showSuccessWithStatus:msg duration:0.5];
    }
    else{
        
        SIAlertView *alertView = [[SIAlertView alloc] initWithTitle:@"Failure" andMessage:msg];
        [alertView addButtonWithTitle:@"Ok"
                                 type:SIAlertViewButtonTypeDestructive
                              handler:^(SIAlertView *alertView) {
                              }];
        alertView.transitionStyle = SIAlertViewTransitionStyleSlideFromTop;
        [alertView show];
    }
}

-(void) deleteImagesCreatedByApplicationAtDevice{
    
    NSString *tempPath = NSTemporaryDirectory();
    NSError *dataError = nil;
    NSArray *dirContents = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:tempPath error:&dataError];
    NSArray *onlyJPGs = [dirContents filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"self CONTAINS 'cache_salesmonitor_'"]];
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if (onlyJPGs) {
        for (int i = 0; i < [onlyJPGs count]; i++) {
            NSString *contentsOnly = [NSString stringWithFormat:@"%@%@", tempPath, [onlyJPGs objectAtIndex:i]];
            [fileManager removeItemAtPath:contentsOnly error:nil];
        }
    }
}

- (void) showDoctorDetailSection : (BOOL) isAddMode{
    
    // populate labels and text fields as per mode
    [self populateDoctorDetailData:isAddMode];
    
    if(isAddMode){
        
        [self showDoctorInAddMode];
    }
    else{
        // now showing content realted to only view mode means only label fields not text fields
        [self showDoctorInViewMode];
        
        
        // showing lower icon bar for call, message and mail
        CGRect toFrame = CGRectMake(402
                                    , [UIScreen mainScreen].bounds.size.height - 125
                                    , 366
                                    , 60);
        [UIView animateWithDuration:2.0 animations:^{
            [_doctorContactContainer setFrame:toFrame];
            
        }];
    }
}

- (void) populateDoctorDetailData : (BOOL) isAddMode{
    
    NSMutableDictionary *selectedDoctor =
    isAddMode ? nil : [[[_salesMonitorDelegate userData] valueForKey:KEY_DOCTORS] objectAtIndex:_selectedIndex];
    
    // branch details
    CustomImageView *imgViewDoctor = (CustomImageView *)[_doctorDetailContainer viewWithTag:200];
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
    
    [lblDoctorName setText: isAddMode ? @"" : [selectedDoctor valueForKey:KEY_DOCTORS_NAME]];
    [txtDoctorName setText:isAddMode ? @"" : [selectedDoctor valueForKey:KEY_DOCTORS_NAME]];
    [lblDoctorSpeciality setText:isAddMode ? @"" :[selectedDoctor valueForKey:KEY_DOCTORS_SPECIALITY]];
    [txtDoctorSpeciality setText:isAddMode ? @"" :[selectedDoctor valueForKey:KEY_DOCTORS_SPECIALITY]];
    [lblDoctorPhone setText:isAddMode ? @"" : [NSString stringWithFormat:@"%@", [selectedDoctor valueForKey:KEY_DOCTORS_PHONE]]];
    [txtDoctorPhone setText:isAddMode ? @"" : [NSString stringWithFormat:@"%@", [selectedDoctor valueForKey:KEY_DOCTORS_PHONE]]];
    [lblDoctorEmail setText:isAddMode ? @"" : [selectedDoctor valueForKey:KEY_DOCTORS_EMAIL]];
    [txtDoctorEmail setText:isAddMode ? @"" : [selectedDoctor valueForKey:KEY_DOCTORS_EMAIL]];
    [lblDoctorAddress setText:isAddMode ? @"" : [selectedDoctor valueForKey:KEY_DOCTORS_ADDRESS]];
    [txtDoctorAddress setText:isAddMode ? @"" : [selectedDoctor valueForKey:KEY_DOCTORS_ADDRESS]];
    [imgViewDoctor setImage:[UIImage imageNamed:@"bigAvater"]];
    
    if(isAddMode){
        [imgViewDoctor setImage:nil];
        [imgViewDoctor.cacheImagePath setString:@""];
    }
    else{
        // check to see image exists or not
        if([selectedDoctor valueForKey:KEY_DOCTORS_IMAGE] != nil && [UIImage imageWithContentsOfFile:[selectedDoctor valueForKey:KEY_DOCTORS_IMAGE]] != nil){
            [imgViewDoctor setImage:[UIImage imageWithContentsOfFile:[selectedDoctor valueForKey:KEY_DOCTORS_IMAGE]]];
        }else{
            [imgViewDoctor setImage:[UIImage imageNamed:@"bigAvater"]];
        }
    }
    
}

- (void) showDoctorInAddMode {
    
    CustomImageView *imgViewDoctor  = (CustomImageView *)[_doctorDetailContainer viewWithTag:200];
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
    
    UIButton *btnAdd   = (UIButton *)[_doctorDetailContainer viewWithTag:120];
    UIButton *btnEdit   = (UIButton *)[_doctorDetailContainer viewWithTag:130];
    UIButton *btnUpdate = (UIButton *)[_doctorDetailContainer viewWithTag:140];
    UIButton *btnDelete = (UIButton *)[_doctorDetailContainer viewWithTag:150];
    UIButton *btnCancel = (UIButton *)[_doctorDetailContainer viewWithTag:160];
    
    UIView *vwSeparator1, *vwSeparator2, *vwSeparator3;
    vwSeparator1 = (UIView *)[_doctorDetailContainer viewWithTag:1000];
    vwSeparator2 = (UIView *)[_doctorDetailContainer viewWithTag:2000];
    vwSeparator3 = (UIView *)[_doctorDetailContainer viewWithTag:3000];
    
    // showing view fields
    // labels
    [txtDoctorName setHidden:NO];
    [txtDoctorSpeciality setHidden:NO];
    [txtDoctorPhone setHidden:NO];
    [txtDoctorEmail setHidden:NO];
    [txtDoctorAddress setHidden:NO];
    
    // buttons
    [btnAdd setHidden:NO];
    
    // seting alpha for transition effect
    [imgViewDoctor setAlpha:0.0];
    [imgViewDoctor setUserInteractionEnabled:YES];
    
    [txtDoctorName setAlpha:0.0];
    [txtDoctorSpeciality setAlpha:0.0];
    [txtDoctorPhone setAlpha:0.0];
    [txtDoctorEmail setAlpha:0.0];
    [txtDoctorAddress setAlpha:0.0];
    [btnAdd setAlpha:0.0];
    
    [UIView animateWithDuration:1.0
                          delay:0.0
                        options:UIViewAnimationOptionTransitionNone
                     animations:^{
                         
                         // showing transition
                         [imgViewDoctor setAlpha:1.0];
                         [txtDoctorName setAlpha:1.0];
                         [txtDoctorSpeciality setAlpha:1.0];
                         [txtDoctorPhone setAlpha:1.0];
                         [txtDoctorEmail setAlpha:1.0];
                         [txtDoctorAddress setAlpha:1.0];
                         
                         [btnAdd setAlpha:1.0];
                         
                         // hiding transition
                         [lblDoctorName setAlpha:0.0];
                         [lblDoctorSpeciality setAlpha:0.0];
                         [lblDoctorPhone setAlpha:0.0];
                         [lblDoctorEmail setAlpha:0.0];
                         [lblDoctorAddress setAlpha:0.0];
                         
                         vwSeparator1.alpha =
                         vwSeparator2.alpha =
                         vwSeparator3.alpha = 0.0;
                         
                         [btnEdit setAlpha:0.0];
                         [btnUpdate setAlpha:0.0];
                         [btnDelete setAlpha:0.0];
                         [btnCancel setAlpha:0.0];
                         
                     }
                     completion:^(BOOL finished) {
                         
                         // hinding edit fields
                         [lblDoctorName setHidden:YES];
                         [lblDoctorSpeciality setHidden:YES];
                         [lblDoctorPhone setHidden:YES];
                         [lblDoctorEmail setHidden:YES];
                         [lblDoctorAddress setHidden:YES];
                         
                         vwSeparator1.hidden =
                         vwSeparator2.hidden =
                         vwSeparator3.hidden = YES;
                         
                         [btnEdit setHidden:YES];
                         [btnUpdate setHidden:YES];
                         [btnDelete setHidden:YES];
                         [btnCancel setHidden:YES];
                         
                     }];
    
    
    CGRect toFrame = CGRectMake(402
                                , [UIScreen mainScreen].bounds.size.height
                                , 366
                                , 60);
    [UIView animateWithDuration:2.0 animations:^{
        [_doctorContactContainer setFrame:toFrame];
        
    }];
    
}

- (void) showDoctorInViewMode {
    
    CustomImageView *imgViewDoctor  = (CustomImageView *)[_doctorDetailContainer viewWithTag:200];
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
    
    UIButton *btnAdd   = (UIButton *)[_doctorDetailContainer viewWithTag:120];
    UIButton *btnEdit   = (UIButton *)[_doctorDetailContainer viewWithTag:130];
    UIButton *btnUpdate = (UIButton *)[_doctorDetailContainer viewWithTag:140];
    UIButton *btnDelete = (UIButton *)[_doctorDetailContainer viewWithTag:150];
    UIButton *btnCancel = (UIButton *)[_doctorDetailContainer viewWithTag:160];
    
    UIView *vwSeparator1, *vwSeparator2, *vwSeparator3;
    vwSeparator1 = (UIView *)[_doctorDetailContainer viewWithTag:1000];
    vwSeparator2 = (UIView *)[_doctorDetailContainer viewWithTag:2000];
    vwSeparator3 = (UIView *)[_doctorDetailContainer viewWithTag:3000];
    
    // showing view fields
    // labels
    [lblDoctorName setHidden:NO];
    [lblDoctorSpeciality setHidden:NO];
    [lblDoctorPhone setHidden:NO];
    [lblDoctorEmail setHidden:NO];
    [lblDoctorAddress setHidden:NO];
    vwSeparator1.hidden =
    vwSeparator2.hidden =
    vwSeparator3.hidden = NO;
    
    // buttons
    [btnEdit setHidden:NO];
    
    // seting alpha for transition effect
    [imgViewDoctor setAlpha:0.0];
    [imgViewDoctor setUserInteractionEnabled:NO];
    
    [lblDoctorName setAlpha:0.0];
    [lblDoctorSpeciality setAlpha:0.0];
    [lblDoctorPhone setAlpha:0.0];
    [lblDoctorEmail setAlpha:0.0];
    [lblDoctorAddress setAlpha:0.0];
    [btnEdit setAlpha:0.0];
    
    vwSeparator1.alpha =
    vwSeparator2.alpha =
    vwSeparator3.alpha = 0.0;
    
    [UIView animateWithDuration:1.0
                          delay:0.0
                        options:UIViewAnimationOptionTransitionNone
                     animations:^{
                         
                         // showing transition
                         [imgViewDoctor setAlpha:1.0];
                         [lblDoctorName setAlpha:1.0];
                         [lblDoctorSpeciality setAlpha:1.0];
                         [lblDoctorPhone setAlpha:1.0];
                         [lblDoctorEmail setAlpha:1.0];
                         [lblDoctorAddress setAlpha:1.0];
                         
                         vwSeparator1.alpha =
                         vwSeparator2.alpha =
                         vwSeparator3.alpha = 1.0;
                         
                         [btnEdit setAlpha:1.0];
                         
                         // hiding transition
                         [txtDoctorName setAlpha:0.0];
                         [txtDoctorSpeciality setAlpha:0.0];
                         [txtDoctorPhone setAlpha:0.0];
                         [txtDoctorEmail setAlpha:0.0];
                         [txtDoctorAddress setAlpha:0.0];
                         
                         [btnAdd setAlpha:0.0];
                         [btnUpdate setAlpha:0.0];
                         [btnDelete setAlpha:0.0];
                         [btnCancel setAlpha:0.0];
                         
                     }
                     completion:^(BOOL finished) {
                         
                         // hinding edit fields
                         [txtDoctorName setHidden:YES];
                         [txtDoctorSpeciality setHidden:YES];
                         [txtDoctorPhone setHidden:YES];
                         [txtDoctorEmail setHidden:YES];
                         [txtDoctorAddress setHidden:YES];
                         
                         [btnAdd setHidden:YES];
                         [btnUpdate setHidden:YES];
                         [btnDelete setHidden:YES];
                         [btnCancel setHidden:YES];
                         
                     }];
}

- (void) showDoctorInEditMode {
    
    CustomImageView *imgViewDoctor  = (CustomImageView *)[_doctorDetailContainer viewWithTag:200];
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
    
    UIButton *btnAdd   = (UIButton *)[_doctorDetailContainer viewWithTag:120];
    UIButton *btnEdit   = (UIButton *)[_doctorDetailContainer viewWithTag:130];
    UIButton *btnUpdate = (UIButton *)[_doctorDetailContainer viewWithTag:140];
    UIButton *btnDelete = (UIButton *)[_doctorDetailContainer viewWithTag:150];
    UIButton *btnCancel = (UIButton *)[_doctorDetailContainer viewWithTag:160];
    
    UIView *vwSeparator1, *vwSeparator2, *vwSeparator3;
    vwSeparator1 = (UIView *)[_doctorDetailContainer viewWithTag:1000];
    vwSeparator2 = (UIView *)[_doctorDetailContainer viewWithTag:2000];
    vwSeparator3 = (UIView *)[_doctorDetailContainer viewWithTag:3000];
    
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
    [imgViewDoctor setAlpha:0.0];
    [imgViewDoctor setUserInteractionEnabled:YES];
    
    [txtDoctorName setAlpha:0.0];
    [txtDoctorSpeciality setAlpha:0.0];
    [txtDoctorPhone setAlpha:0.0];
    [txtDoctorEmail setAlpha:0.0];
    [txtDoctorAddress setAlpha:0.0];
    
    [btnUpdate setAlpha:0.0];
    [btnDelete setAlpha:0.0];
    [btnCancel setAlpha:0.0];
    
    [UIView animateWithDuration:1.0
                          delay:0.0
                        options:UIViewAnimationOptionTransitionNone
                     animations:^{
                         
                         // showing edit fields
                         [imgViewDoctor setAlpha:1.0];
                         [txtDoctorName setAlpha:1.0];
                         [txtDoctorSpeciality setAlpha:1.0];
                         [txtDoctorPhone setAlpha:1.0];
                         [txtDoctorEmail setAlpha:1.0];
                         [txtDoctorAddress setAlpha:1.0];
                         
                         [btnUpdate setAlpha:1.0];
                         [btnDelete setAlpha:1.0];
                         [btnCancel setAlpha:1.0];
                         
                         [lblDoctorName setAlpha:0.0];
                         [lblDoctorSpeciality setAlpha:0.0];
                         [lblDoctorPhone setAlpha:0.0];
                         [lblDoctorEmail setAlpha:0.0];
                         [lblDoctorAddress setAlpha:0.0];
                         
                         vwSeparator1.alpha =
                         vwSeparator2.alpha =
                         vwSeparator3.alpha = 0.0;
                         
                         [btnAdd setAlpha:0.0];
                         [btnEdit setAlpha:0.0];
                     }
                     completion:^(BOOL finished) {
                         
                         [lblDoctorName setHidden:YES];
                         [lblDoctorSpeciality setHidden:YES];
                         [lblDoctorPhone setHidden:YES];
                         [lblDoctorEmail setHidden:YES];
                         [lblDoctorAddress setHidden:YES];
                         
                         vwSeparator1.hidden =
                         vwSeparator2.hidden =
                         vwSeparator3.hidden = NO;
                         
                         [btnEdit setHidden:YES];
                         [btnAdd setHidden:YES];
                     }];
}

- (void) updateViewAfterChangeInCoreData : (dataOperation) operationType{
    
    switch (operationType) {
        case add:
            _selectedIndex = [[[_salesMonitorDelegate userData] valueForKey:KEY_DOCTORS] count] - 1;
            [_tblDoctor reloadData];
            [self showDoctorDetailSection:NO];
            break;
        case update:
            [_tblDoctor reloadData];
            [self showDoctorDetailSection:NO];
            break;
        case delete:
            [_tblDoctor reloadData];
            [self showDoctorDetailSection:YES];
            break;
        default:
            break;
    }
    
    
}

// text field delegate
-(BOOL) textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}

// text view delegate
- (BOOL) textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    
    
    if([text isEqualToString:@"\n"]){
        [textView resignFirstResponder];
        return NO;
    }
    else{
        return YES;
    }
    
}

// image delegate

- (NSString *)generateUUIDStringAtDevice {
    
    CFUUIDRef uuid = CFUUIDCreate(kCFAllocatorDefault);
    NSString *uuidStr = (__bridge_transfer NSString *)CFUUIDCreateString(kCFAllocatorDefault, uuid);
    uuidStr = [uuidStr stringByReplacingOccurrencesOfString:@"-" withString:@""];
    CFRelease(uuid);
    
    return uuidStr;
}

-(void)imagePickerController: (UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    CustomImageView *imgViewDoctor =  (CustomImageView *)[_doctorDetailContainer viewWithTag:200];
    
    UIImage *myImage =  [info objectForKey:UIImagePickerControllerOriginalImage];
    NSString *imageIDString = [self generateUUIDStringAtDevice];
    
    // if not from camera then from libraray
    CGSize cacheImageSize = CGSizeMake(300,300);
    UIGraphicsBeginImageContext(cacheImageSize);
    [myImage drawInRect:CGRectMake(0,0,cacheImageSize.width, cacheImageSize.height)];
    UIImage *cacheImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    // write image to iOS tmp directory
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    [imgViewDoctor.cacheImagePath setString:[documentsDirectory stringByAppendingPathComponent:
                                             [NSString stringWithFormat:@"%@%@%@",@"cache_salesmonitor_",imageIDString,@".jpg"]]];
    [UIImageJPEGRepresentation(cacheImage, 0.8) writeToFile:imgViewDoctor.cacheImagePath atomically:YES];
    [imgViewDoctor setImage:[UIImage imageWithContentsOfFile:imgViewDoctor.cacheImagePath]];
    
    [self.popoverController dismissPopoverAnimated:YES];
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)imagePickerControllerDidCancel: (UIImagePickerController *)picker
{
    [self dismissViewControllerAnimated:YES completion:nil];
}


@end
