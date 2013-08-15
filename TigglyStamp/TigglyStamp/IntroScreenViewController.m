//
//  IntroScreenViewController.m
//  TigglyStamp
//
//  Created by cuelogic on 01/07/13.
//  Copyright (c) 2013 cuelogic. All rights reserved.
//

#import "IntroScreenViewController.h"
#import "AppDelegate.h"
#import "WinterSceneViewController.h"
#import "SeasonSelectionViewController.h"
#import "TigglyStampUtils.h"
#import "TSHomeViewController.h"

#define TAG_BTN_WITHSHAPE 1
#define TAG_BTN_WITHOUTSHAPE 2

@interface IntroScreenViewController ()

@end



@implementation IntroScreenViewController

@synthesize btnWithoutShape,btnWithShape,isShowLogo;
@synthesize languageView;
@synthesize languageSubView;
@synthesize arrLanguage;
@synthesize lblLunguage;
@synthesize lblLunguageTest;

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
    self.navigationController.navigationBar.hidden = YES;
    // Do any additional setup after loading the view from its nib.
    CALayer * logo = [CALayer layer];
    [logo setAnchorPoint:CGPointMake(0.5, 0.5)];
    logo.frame = CGRectMake(self.view.center.x - 300,self.view.center.y - 300, 600, 600);
    logo.contents = (id) [UIImage imageNamed:@"logo.png"].CGImage;
    [self.view.layer addSublayer:logo];
    CABasicAnimation *animation3 = nil;
    animation3 = [CABasicAnimation animationWithKeyPath:@"opacity"];
    [animation3 setToValue:[NSNumber numberWithDouble:1]];
    [animation3 setFromValue:[NSNumber numberWithDouble:0]];
    [animation3 setAutoreverses:YES];
    [animation3 setDuration:3.0f];
    [animation3 setBeginTime:0.0f];
    [animation3 setTimingFunction:[CAMediaTimingFunction functionWithControlPoints:0.25f :0.1f :0.25f :1.0f]];
    animation3.delegate=self;
    [logo addAnimation:animation3 forKey:@"become visible"];
    [logo animationForKey:@"become visible"];
     logo.opacity = 0;
    
    [btnWithShape setTag:TAG_BTN_WITHSHAPE];
    [btnWithoutShape setTag:TAG_BTN_WITHOUTSHAPE];
   
    btnWithoutShape.layer.cornerRadius = 5.0f;
    btnWithoutShape.layer.masksToBounds = YES;

    btnWithShape.layer.cornerRadius = 5.0f;
    btnWithShape.layer.masksToBounds = YES;
    
    [btnWithoutShape setHidden:true];
    [btnWithShape setHidden:true];
    
//    [btnWithoutShape setBackgroundColor:[UIColor colorWithRed:150 green:186 blue:242 alpha:1]];
//    [btnWithShape setBackgroundColor:[UIColor colorWithRed:150 green:186 blue:242 alpha:1]];
    
    [[NSUserDefaults standardUserDefaults] setValue:@"yes" forKey:LIMIT_GALLERY];
    [[NSUserDefaults standardUserDefaults] setValue:@"yes" forKey:SAVE_ART];
    
}

-(void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
//    [btnWithoutShape setHidden:false];
//    [btnWithShape setHidden:false];
    
//    [self displayLanguageSelectionView];

    
//    // Language selection shows only onces when app launch first time
//    if(![[NSUserDefaults standardUserDefaults] boolForKey:@"firstLaunch"]){
//        [self displayLanguageSelectionView];
//        
//    }
    
    
    // Language selection shows only onces when app launch first time
    if(![[NSUserDefaults standardUserDefaults] boolForKey:@"firstLaunch"]){
        
        [self displayLanguageSelectionView];
        
        [btnWithoutShape setHidden:false];
        [btnWithShape setHidden:false];
                
    }else{
        TSHomeViewController *homeViewController = [[TSHomeViewController alloc]initWithNibName:@"TSHomeViewController" bundle:nil];
        [self.navigationController pushViewController:homeViewController animated:YES];
    }
    
}


- (void) displayLanguageSelectionView
{
    self.languageSubView.layer.cornerRadius = 30.0f;
    self.languageSubView.layer.masksToBounds = YES;
    [self.view addSubview:self.languageView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return UIInterfaceOrientationIsLandscape(interfaceOrientation);
}
-(BOOL)shouldAutorotate{
    return YES;
}

-(NSUInteger)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskLandscape;
}

-(IBAction) onButtonTouched:(id)sender{

    UIButton *btn = (UIButton *) sender;
    TSHomeViewController *homeViewController = [[TSHomeViewController alloc]initWithNibName:@"TSHomeViewController" bundle:nil];
    
    
    if (btn.tag == TAG_BTN_WITHSHAPE) {
        [[NSUserDefaults standardUserDefaults] setValue:@"yes" forKey:I_HAVE_SHAPE];
        [[TigglyStampUtils sharedInstance] SetBooleanWithShape:YES];
    }else if (btn.tag == TAG_BTN_WITHOUTSHAPE){
        [[NSUserDefaults standardUserDefaults] setValue:@"yes" forKey:I_MISS_SHAPE];
        [[TigglyStampUtils sharedInstance] SetBooleanWithShape:NO];
    }
    
    [self.navigationController pushViewController:homeViewController animated:YES];
//    [del.window setRootViewController:winterViewController];
    
}

-(IBAction)closeButtonClicked:(id)sender
{
    [self.languageView removeFromSuperview];
    
//    // Language selection shows only onces when app launch first time
//    if(![[NSUserDefaults standardUserDefaults] boolForKey:@"firstLaunch"]){
//        [btnWithoutShape setHidden:false];
//        [btnWithShape setHidden:false];
//                
//        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"firstLaunch"];
//
//    }else{
//        TSHomeViewController *homeViewController = [[TSHomeViewController alloc]initWithNibName:@"TSHomeViewController" bundle:nil];
//        [self.navigationController pushViewController:homeViewController animated:YES];
//    }
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
    [popoverController presentPopoverFromRect:senderButton.frame inView:self.languageSubView permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];
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


//-(IBAction)winterScene:(id)sender
//{
//    DebugLog(@"Winter scene background");
//    AppDelegate * del = [self appDelegate];
//    [del.window setRootViewController:[[WinterSceneViewController alloc]initWithNibName:@"WinterSceneViewController" bundle:nil]];
//    
//}
//-(IBAction)springScene:(id)sender
//{
//    DebugLog(@"Spring scene background");
//}
//-(IBAction)summerScene:(id)sender
//{
//    DebugLog(@"Summer scene background");
//}
//-(IBAction)fallScene:(id)sender
//{
//    DebugLog(@"Fall scene background");
//}



@end
