//
//  SettingsViewController.m
//  TigglyStamp
//
//  Created by Swpnil j. on 26/07/13.
//  Copyright (c) 2013 cuelogic. All rights reserved.
//

#import "SettingsViewController.h"

@interface SettingsViewController ()

@end

@implementation SettingsViewController


@synthesize swtchArt,swtchHaveShapes,swtchLimitGallery,swtchMusic,swtchNoShapes;
@synthesize arrLanguage;
@synthesize lblLunguage;
@synthesize backgroundView;
@synthesize lblLunguageTest;
@synthesize lbl1,lbl2,lbl3,lbl4,lbl5,lbl6;

#pragma mark - Activity LifeCycle
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSString *lung = [[NSUserDefaults standardUserDefaults] valueForKey:LANGUAGE_SELECTED];
    if (lung.length==0) {
        lblLunguage.text = @"English";
    }else{
        lblLunguage.text = [[NSUserDefaults standardUserDefaults] valueForKey:LANGUAGE_SELECTED];
    }
    
    if ([[[NSUserDefaults standardUserDefaults] valueForKey:MUSIC] isEqualToString:@"yes"]) {
        [swtchMusic setOn:YES];
    }else{
        [swtchMusic setOn:NO];
    }
    
    if ([[[NSUserDefaults standardUserDefaults] valueForKey:SAVE_ART] isEqualToString:@"yes"]) {
        [swtchArt setOn:YES];
    }else{
        [swtchArt setOn:NO];
    }
    if ([[[NSUserDefaults standardUserDefaults] valueForKey:I_HAVE_SHAPE] isEqualToString:@"yes"]) {
        [swtchHaveShapes setOn:YES];
    }else{
        [swtchHaveShapes setOn:NO];
    }
    
    if ([[[NSUserDefaults standardUserDefaults] valueForKey:I_MISS_SHAPE] isEqualToString:@"yes"]) {
        [swtchNoShapes setOn:YES];
    }else{
        [swtchNoShapes setOn:NO];
    }
    
    if ([[[NSUserDefaults standardUserDefaults] valueForKey:LIMIT_GALLERY] isEqualToString:@"yes"]) {
        [swtchLimitGallery setOn:YES];
    }else{
        [swtchLimitGallery setOn:NO];
    }
    
}

#pragma mark - Button Action 
-(IBAction)actionSwitchValueChanged:(id)sender {
    DebugLog(@"");
    
    UISwitch *swtch = sender;
    
    switch (swtch.tag) {
        case TAG_SWITCH_MUSIC:
            if ([swtchMusic isOn] == YES) {
                [[NSUserDefaults standardUserDefaults] setValue:@"yes" forKey:MUSIC];
            }else{
                [[NSUserDefaults standardUserDefaults] setValue:@"no" forKey:MUSIC];
            }
            break;

        case TAG_SWITCH_ART:
            if ([swtchArt isOn] == YES) {
                [[NSUserDefaults standardUserDefaults] setValue:@"yes" forKey:SAVE_ART];
            }else{
                [[NSUserDefaults standardUserDefaults] setValue:@"no" forKey:SAVE_ART];
            }
            break;

        case TAG_SWITCH_HAVE_SHAPES:
            if ([swtchHaveShapes isOn] == YES) {
                [[NSUserDefaults standardUserDefaults] setValue:@"yes" forKey:I_HAVE_SHAPE];
                [[TigglyStampUtils sharedInstance] SetBooleanWithShape:YES];
            }else{
                [[NSUserDefaults standardUserDefaults] setValue:@"no" forKey:I_HAVE_SHAPE];
                [[TigglyStampUtils sharedInstance] SetBooleanWithShape:NO];
            }
            break;

            
        case TAG_SWITCH_MISS_SWITCH:
            if ([swtchNoShapes isOn] == YES) {
                [[NSUserDefaults standardUserDefaults] setValue:@"yes" forKey:I_MISS_SHAPE];
                [[TigglyStampUtils sharedInstance] SetBooleanWithShape:NO];

            }else{
                [[NSUserDefaults standardUserDefaults] setValue:@"no" forKey:I_MISS_SHAPE];
                [[TigglyStampUtils sharedInstance] SetBooleanWithShape:YES];
            }
            break;

            
        case TAG_SWITCH_LIMIT_GALLERY:
            if ([swtchLimitGallery isOn] == YES) {
                [[NSUserDefaults standardUserDefaults] setValue:@"yes" forKey:LIMIT_GALLERY];
            }else{
                [[NSUserDefaults standardUserDefaults] setValue:@"no" forKey:LIMIT_GALLERY];
            }
            break;

        default:
            break;
    }
    
}

-(IBAction)onButtonClicked:(id)sender {
    DebugLog(@"");
    
    UIButton *btn = sender;
    
    switch (btn.tag) {
        case TAG_BUTTON_CLOSE:
            [self dismissModalViewControllerAnimated:YES];
            break;
            
        default:
            break;
    }
}

-(IBAction)buyShapesButtonClicked:(id)sender
{
    // Redirect to the tiggly myshopify page in browser window.
    NSString* launchUrl = @"http://tiggly.myshopify.com";
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString: launchUrl]];
}

-(IBAction)languageButtonClicked:(id)sender
{
    // Shows the drop down menu for language
    arrLanguage = [[NSMutableArray alloc] initWithObjects:@"English",@"Spanish",@"Italian",@"Portuguese",@"Russian",@"French",@"German", nil];
    [self popOverUIPicker:sender];
    
}

#pragma mark- PickerView delegate
-(void) popOverUIPicker:(id)sender
{    
    UIViewController* popoverContent = [[UIViewController alloc] init]; //ViewController
    
    UIView *popoverView = [[UIView alloc] init]; //view
    popoverView.backgroundColor = [UIColor clearColor];
    
    pickerView=[[UIPickerView alloc]init];// UIPicker
    pickerView.frame=CGRectMake(0,44,320, 216);
    pickerView.showsSelectionIndicator = YES;
    pickerView.delegate = self;
    [popoverView addSubview:pickerView];
    popoverContent.view = popoverView;
    
    UIToolbar *toolbar = [[UIToolbar alloc] init];
    toolbar.barStyle = UIBarStyleBlack;
    toolbar.frame = CGRectMake(0.0, 0.0, 320.0, 44.0);
    
    // set toolbar title
    UILabel *lbl=[[UILabel alloc]initWithFrame:CGRectMake(5,7,310,30)];
    [lbl setBackgroundColor:[UIColor clearColor]];
    [lbl setTextColor:[UIColor whiteColor]];
    [lbl setTextAlignment:UITextAlignmentCenter];
    [lbl setFont:[UIFont boldSystemFontOfSize:18.0f]];
    [lbl setText:@"Language"];

    //Set the toolbar to fit the width of the app.
    [toolbar addSubview:lbl];
    [popoverContent.view addSubview:toolbar];
    
    popoverController = [[UIPopoverController alloc] initWithContentViewController:popoverContent] ;
    popoverController.popoverContentSize = CGSizeMake(320, 264);
    
    //present the popover view
    UIButton* senderButton = (UIButton*)sender;
    [popoverController presentPopoverFromRect:senderButton.frame inView:self.view permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return [self.arrLanguage count];
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    NSString *titleString = [self.arrLanguage objectAtIndex:row];
    return titleString;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    lblLunguage.text = [self.arrLanguage objectAtIndex:row];
    [[NSUserDefaults standardUserDefaults] setValue:lblLunguage.text forKey:LANGUAGE_SELECTED];
    if ([lblLunguage.text isEqualToString:@"English"]) {
        lblLunguageTest.text=[self languageSelectedStringForKey:@"Welcome to Advance Localization" withSelectedLanguage:[self.arrLanguage objectAtIndex:row]];
    }else if ([lblLunguage.text isEqualToString:@"French"]){
        lblLunguageTest.text=[self languageSelectedStringForKey:@"Welcome to Advance Localization" withSelectedLanguage:[self.arrLanguage objectAtIndex:row]];
    }else if ([lblLunguage.text isEqualToString:@"Italian"]){
        lblLunguageTest.text=[self languageSelectedStringForKey:@"Welcome to Advance Localization" withSelectedLanguage:[self.arrLanguage objectAtIndex:row]];
    }
    
}

-(NSString*) languageSelectedStringForKey:(NSString*) key withSelectedLanguage:(NSString*)selectedLanguage
{
	NSString *path;
	if([selectedLanguage isEqualToString:@"English"])
		path = [[NSBundle mainBundle] pathForResource:@"en" ofType:@"lproj"];
	else if([selectedLanguage isEqualToString:@"Italian"])
		path = [[NSBundle mainBundle] pathForResource:@"zh" ofType:@"lproj"];
	else if([selectedLanguage isEqualToString:@"French"])
		path = [[NSBundle mainBundle] pathForResource:@"fr" ofType:@"lproj"];
	
	NSBundle* languageBundle = [NSBundle bundleWithPath:path];
	NSString* str=[languageBundle localizedStringForKey:key value:@"" table:nil];
	return str;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)orientation
{
    return  (orientation == UIInterfaceOrientationLandscapeRight);
}
-(BOOL)shouldAutorotate
{
    return YES;
}

-(NSUInteger)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskLandscape;
}

#pragma mark - Memory Managment
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
