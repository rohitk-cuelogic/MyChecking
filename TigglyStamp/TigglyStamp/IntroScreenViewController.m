//
//  IntroScreenViewController.m
//  TigglyStamp
//
//  Created by cuelogic on 01/07/13.
//  Copyright (c) 2013 cuelogic. All rights reserved.
//

#import "IntroScreenViewController.h"
#import "AppDelegate.h"
#import "SeasonSelectionViewController.h"
#import "TigglyStampUtils.h"
#import "TSHomeViewController.h"
#import "TDSoundManager.h"
#import "UnlockScreenViewController.h"

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
@synthesize bkgImageView;
@synthesize bkgImageViewlang;
@synthesize tblView;
@synthesize gameTypeView;
@synthesize btnGoLanguage;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad {
    DebugLog(@"");
    [super viewDidLoad];
    
    self.gameTypeView.frame = CGRectMake(1024, 0, 1024, 768);
    
    isLanguageScreenDisplayed = NO;
    
    [[NSUserDefaults standardUserDefaults] setValue:@"yes" forKey:LIMIT_GALLERY];
    [[NSUserDefaults standardUserDefaults] setValue:@"yes" forKey:SAVE_ART];
    [[NSUserDefaults standardUserDefaults] setValue:@"yes" forKey:MUSIC];
    
    self.navigationController.navigationBar.hidden = YES;
    // Do any additional setup after loading the view from its nib.
    bkgImageViewlang.alpha = 0.0;
    bkgImageView.alpha = 0.0;
    CALayer * logo = [CALayer layer];
    [logo setAnchorPoint:CGPointMake(0.5, 0.5)];
    logo.frame = CGRectMake(self.view.center.x - 300,self.view.center.y - 300, 600, 600);
    logo.contents = (id) [UIImage imageNamed:@"logo.png"].CGImage;
    [self.view.layer addSublayer:logo];
    
    [[TDSoundManager sharedManager] playSound:@"tiggly_logo_audio" withFormat:@"mp3"];
    
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
    

    
    arrLanguage = [[NSMutableArray alloc] initWithObjects:@"English",@"Portuguese",@"Russian",@"Spanish",@"French",@"German",@"Italian", nil];
    
    tblView.layer.cornerRadius = 30;
    tblView.layer.masksToBounds = YES;
    
    
    NSString *str = [[TigglyStampUtils sharedInstance] getCurrentLanguage]; //[[NSUserDefaults standardUserDefaults] objectForKey:LANGUAGE_SELECTED];
//    lblLunguage.text = str;
    int count=0;
    for(int i=0; i< arrLanguage.count;i++){
        NSString *lang = [arrLanguage objectAtIndex:i];
        if([str isEqualToString:lang]) {
            count = i;
        }
    }
    
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:count inSection:0];
    [tblView selectRowAtIndexPath:indexPath animated:NO scrollPosition: UITableViewScrollPositionNone];
}

-(void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    // Language selection shows only onces when app launch first time
    if(![[NSUserDefaults standardUserDefaults] boolForKey:@"firstLaunch"]){
#ifdef GOOGLE_ANALYTICS_START
        NSMutableDictionary *event =
        [[GAIDictionaryBuilder createEventWithCategory:@"App Version"
                                                action:@"App Version"
                                                 label:@"Trial version"
                                                 value:nil] build];
        [[GAI sharedInstance].defaultTracker send:event];
        [[GAI sharedInstance] dispatch];
#else
        
#endif

        
        [UIView animateWithDuration:0.3 animations:^{
            bkgImageViewlang.alpha = 1.0;
            bkgImageView.alpha = 1.0;
            
//             [[NSUserDefaults standardUserDefaults] setValue:@"English" forKey:LANGUAGE_SELECTED];
            [[TigglyStampUtils sharedInstance] setCurrentLanguage:@"English"];
//            lblLunguage.text = @"English";
            [self displayLanguageSelectionView];
            [btnWithoutShape setHidden:false];
            [btnWithShape setHidden:false];
            
            double delayInSeconds = 0.2;
            dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
            dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
                 [self.view setBackgroundColor:[UIColor clearColor]];
            });
           
        }];
        
    }else{
        
#ifdef TEST_MODE
        [UIView animateWithDuration:0.3 animations:^{
            bkgImageViewlang.alpha = 1.0;
            bkgImageView.alpha = 1.0;
            [self displayLanguageSelectionView];
            [btnWithoutShape setHidden:false];
            [btnWithShape setHidden:false];
            [self.view setBackgroundColor:[UIColor clearColor]];
        }];
        return;
#endif
        TSHomeViewController *homeViewController = [[TSHomeViewController alloc]initWithNibName:@"TSHomeViewController" bundle:nil];
        [self.navigationController pushViewController:homeViewController animated:NO];
    }
    

    
}

-(void) viewWillAppear:(BOOL)animated {
    DebugLog(@"");

}


- (void) displayLanguageSelectionView {
    DebugLog(@"");
    isLanguageScreenDisplayed = YES;
    self.languageSubView.layer.cornerRadius = 30.0f;
    self.languageSubView.layer.masksToBounds = YES;
    [self.view addSubview:self.languageView];
    lblLunguage.font = [UIFont fontWithName:APP_FONT_BOLD size:26.0f];
    
    UISwipeGestureRecognizer *swipeGesture = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipedScreen:)];
    swipeGesture.direction = UISwipeGestureRecognizerDirectionLeft;
    [self.view addGestureRecognizer:swipeGesture];
}

- (void)swipedScreen:(UISwipeGestureRecognizer*)gesture {
    DebugLog(@"");
    if(isLanguageScreenDisplayed) {
//        [UIView transitionFromView:self.languageSubView  toView:self.gameTypeView duration:1.0 options: UIViewAnimationOptionTransitionFlipFromRight
//                        completion: ^(BOOL inFinished) {
//                            isLanguageScreenDisplayed = NO;
//                            [[NSUserDefaults standardUserDefaults] setValue:lblLunguage.text forKey:LANGUAGE_SELECTED];
////                            [self.languageView removeFromSuperview];
//                        }];
        [self.view bringSubviewToFront:self.gameTypeView];
        [UIView animateWithDuration:0.4 animations:^{
            self.gameTypeView.frame = CGRectMake(0, 0, 1024, 768);
        } completion:^(BOOL finished) {
            isLanguageScreenDisplayed = NO;
//            [[NSUserDefaults standardUserDefaults] setValue:lblLunguage.text forKey:LANGUAGE_SELECTED];
             [[TigglyStampUtils sharedInstance] setCurrentLanguage: [[TigglyStampUtils sharedInstance] getCurrentLanguage]];
//            [self.languageView removeFromSuperview];
        }];
    }
}

- (void)didReceiveMemoryWarning{
    DebugLog(@"");
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

 [[TDSoundManager sharedManager] playSound:@"Blop_Sound_effect" withFormat:@"mp3"];
    
    UIButton *btn = (UIButton *) sender;
    TSHomeViewController *homeViewController = [[TSHomeViewController alloc]initWithNibName:@"TSHomeViewController" bundle:nil];
    
    
    if (btn.tag == TAG_BTN_WITHSHAPE) {     
        if(![[TigglyStampUtils sharedInstance] isAppUnlockedForShapes]) {
            UnlockScreenViewController *unlockScreen = [[UnlockScreenViewController alloc] initWithNibName:@"UnlockScreenViewController" bundle:nil];
            [self.navigationController pushViewController:unlockScreen animated:YES];
        }else{
            [[TigglyStampUtils sharedInstance] setShapeMode:YES];
            [self.navigationController pushViewController:homeViewController animated:YES];
        }
    }else if (btn.tag == TAG_BTN_WITHOUTSHAPE){
        [[TigglyStampUtils sharedInstance] setShapeMode:NO];
         [self.navigationController pushViewController:homeViewController animated:YES];
    }
    
   

}

-(IBAction)actionGoLanguage {
    DebugLog(@"");
    //    [self displayLanguageSelectionView];
    
    [UIView animateWithDuration:0.3 animations:^{
        self.gameTypeView.frame = CGRectMake(1024, 0, 1024, 768);
    } completion:^(BOOL finished) {
        isLanguageScreenDisplayed = YES;
        //self.gameTypeView.frame = CGRectMake(1024, 0, 1024, 768);
    }];
    
}

-(IBAction)closeButtonClicked:(id)sender {
    DebugLog(@"");    
    [self.view bringSubviewToFront:self.gameTypeView];
    [UIView animateWithDuration:0.4 animations:^{
        self.gameTypeView.frame = CGRectMake(0, 0, 1024, 768);
    } completion:^(BOOL finished) {        
        isLanguageScreenDisplayed = NO;
//         [self.languageView removeFromSuperview];
        [[TDSoundManager sharedManager] playSound:@"Blop_Sound_effect" withFormat:@"mp3"];
        
//        [[NSUserDefaults standardUserDefaults] setValue:lblLunguage.text forKey:LANGUAGE_SELECTED];
       
    }];

         [[TigglyStampUtils sharedInstance] setCurrentLanguage:lblLunguage.text];
       // [[NSUserDefaults standardUserDefaults] setValue:lblLunguage.text forKey:LANGUAGE_SELECTED];
        
}

-(IBAction)languageButtonClicked:(id)sender
{
    // Shows the drop down menu for language
    [self popOverUIPicker:sender];
}

#pragma mark- PickerView delegate
-(void) popOverUIPicker:(id)sender
{
    UIViewController* popoverContent = [[UIViewController alloc] init]; //ViewController
    
    UIView *popoverView = [[UIView alloc] init]; //view
    popoverView.backgroundColor = [UIColor clearColor];

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

-(NSString*) languageSelectedStringForKey:(NSString*) key withSelectedLanguage:(NSString*)selectedLanguage{
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

#pragma mark -
#pragma mark =======================================
#pragma mark TableView Delegates
#pragma mark =======================================

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    DebugLog(@"");
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    DebugLog(@"");
    
    return [self.arrLanguage count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 60.0f;
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    //DebugLog(@"");
    NSString *reuseIdentifier = @"cell";
    UITableViewCell *cell;
   
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle: UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
    }
    
    cell.textLabel.text = [self.arrLanguage objectAtIndex:indexPath.row];
    cell.textLabel.textAlignment = UITextAlignmentCenter;
    cell.textLabel.font = [UIFont fontWithName:APP_FONT_BOLD size:22.0f];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    DebugLog(@"");
    
//    lblLunguage.text = [self.arrLanguage objectAtIndex:indexPath.row];
    
#ifdef GOOGLE_ANALYTICS_START
    NSMutableDictionary *event =
    [[GAIDictionaryBuilder createEventWithCategory:@"Language"
                                            action:@"Language Selected"
                                             label:[self.arrLanguage objectAtIndex:indexPath.row]
                                             value:nil] build];
    [[GAI sharedInstance].defaultTracker send:event];
    [[GAI sharedInstance] dispatch];
#else
    
#endif

    
    
    [self.view bringSubviewToFront:self.gameTypeView];
    [UIView animateWithDuration:0.4 animations:^{
        self.gameTypeView.frame = CGRectMake(0, 0, 1024, 768);
    } completion:^(BOOL finished) {
        isLanguageScreenDisplayed = NO;
        //         [self.languageView removeFromSuperview];
        [[TDSoundManager sharedManager] playSound:@"Blop_Sound_effect" withFormat:@"mp3"];
        
        //        [[NSUserDefaults standardUserDefaults] setValue:lblLunguage.text forKey:LANGUAGE_SELECTED];
        
    }];
    
    [[TigglyStampUtils sharedInstance] setCurrentLanguage:[self.arrLanguage objectAtIndex:indexPath.row]];
    
}

@end
