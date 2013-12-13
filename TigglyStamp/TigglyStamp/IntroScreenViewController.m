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

#pragma mark -
#pragma mark =======================================
#pragma mark Init
#pragma mark =======================================

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        DebugLog(@"");
    }
    return self;
}

#pragma mark -
#pragma mark =======================================
#pragma mark Memory
#pragma mark =======================================

- (void)didReceiveMemoryWarning{
    DebugLog(@"");
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) removeAllObjectForIntroScreen {
    DebugLog(@"");
    
    if (arrLanguage!=NULL) {
        [arrLanguage removeAllObjects];
        arrLanguage = NULL;
    }
    btnGoLanguage = NULL;
    btnWithShape = NULL;
    btnWithoutShape = NULL;
    languageView = NULL;
    languageSubView = NULL;
    lblLunguage = NULL;
    lblLunguageTest = NULL;
    bkgImageView = NULL;
    bkgImageViewlang = NULL;
    tblView = NULL;
    gameTypeView = NULL;
}


#pragma mark -
#pragma mark =======================================
#pragma mark View Lifecycle
#pragma mark =======================================

- (void)viewDidLoad {
    DebugLog(@"");
    [super viewDidLoad];
    
    //Disable swiping of UINavigationController in ios7
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.enabled = NO;
    }
    
   //Hide status bar
    if ([self respondsToSelector:@selector(setNeedsStatusBarAppearanceUpdate)]) {
        // iOS 7
        [self prefersStatusBarHidden];
        [self performSelector:@selector(setNeedsStatusBarAppearanceUpdate)];
    } else {
        // iOS 6
        [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationSlide];
    }
    _isRemoveAllElement = NO;
    
    self.navigationController.navigationBar.hidden = YES;
    
    self.gameTypeView.frame = CGRectMake(1024, 0, 1024, 768);
    
    isLanguageScreenDisplayed = NO;
    
    [[NSUserDefaults standardUserDefaults] setValue:@"yes" forKey:LIMIT_GALLERY];
    [[NSUserDefaults standardUserDefaults] setValue:@"yes" forKey:SAVE_ART];
    [[NSUserDefaults standardUserDefaults] setValue:@"yes" forKey:MUSIC];
    
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
    
    
    NSString *str = [[TigglyStampUtils sharedInstance] getCurrentLanguage]; 
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


-(void) viewWillAppear:(BOOL)animated {
    DebugLog(@"");
    
    float fontSize = 0.0;
    if([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"English"]){
        fontSize = 45.0f;
    }else{
        fontSize = 28.0f;
    }
    lblWithoutShape.font = [UIFont fontWithName:APP_FONT_BOLD size:fontSize];
    lblWithShape.font = [UIFont fontWithName:APP_FONT_BOLD size:fontSize];
    lblWithShape.text = [[TigglyStampUtils sharedInstance] getLocalisedStringForKey:@"kUnlockwithTigglyshapes"];
    lblWithoutShape.text = [[TigglyStampUtils sharedInstance] getLocalisedStringForKey:@"kTrymewithoutTigglyshapes"];
    lblWithShape.minimumFontSize = 15.0f;
    lblWithoutShape.minimumFontSize = 15.0f;
}

-(void) viewDidDisappear:(BOOL)animated {
    DebugLog(@"");
    if (_isRemoveAllElement == YES) {
        [self removeAllObjectForIntroScreen];
        
    }
}
- (BOOL)prefersStatusBarHidden {
    return YES;
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

#pragma mark -
#pragma mark =======================================
#pragma mark Animation Delegates
#pragma mark =======================================


-(void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    DebugLog(@"");
    
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
            
            [[TigglyStampUtils sharedInstance] setCurrentLanguage:@"English"];

            [self displayLanguageSelectionView];
            [btnWithoutShape setHidden:false];
            [btnWithShape setHidden:false];
            
            double delayInSeconds = 0.2;
            dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
            dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
                 [self.view setBackgroundColor:[UIColor clearColor]];
            });
           
        }];
        
        [[ServerController sharedInstance] sendEvent:@"app_download" withEventValue:@"yes" withServiceName:SERVICE_URL_SET_DEVICEPROFILE];
        
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

#pragma mark -
#pragma mark =======================================
#pragma mark Helpers
#pragma mark =======================================

- (void) displayLanguageSelectionView {
    DebugLog(@"");
    isLanguageScreenDisplayed = YES;
    self.languageSubView.layer.cornerRadius = 30.0f;
    self.languageSubView.layer.masksToBounds = YES;
    lblLunguage.font = [UIFont fontWithName:APP_FONT_BOLD size:26.0f];
    lblLunguage.text = [[TigglyStampUtils sharedInstance] getLocalisedStringForKey:@"kLanguage"];
    [self.view addSubview:self.languageView];
    
    
    UISwipeGestureRecognizer *swipeGesture = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipedScreen:)];
    swipeGesture.direction = UISwipeGestureRecognizerDirectionLeft;
    [self.view addGestureRecognizer:swipeGesture];
}

- (void)swipedScreen:(UISwipeGestureRecognizer*)gesture {
    DebugLog(@"");
    if(isLanguageScreenDisplayed) {

        [self.view bringSubviewToFront:self.gameTypeView];
        [UIView animateWithDuration:0.4 animations:^{
            self.gameTypeView.frame = CGRectMake(0, 0, 1024, 768);
            
            float fontSize = 0.0;
            if([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"English"]){
                fontSize = 45.0f;
            }else{
                fontSize = 28.0f;
            }
            lblWithoutShape.font = [UIFont fontWithName:APP_FONT_BOLD size:fontSize];
            lblWithShape.font = [UIFont fontWithName:APP_FONT_BOLD size:fontSize];
            lblWithShape.text = [[TigglyStampUtils sharedInstance] getLocalisedStringForKey:@"kUnlockwithTigglyshapes"];
            lblWithoutShape.text = [[TigglyStampUtils sharedInstance] getLocalisedStringForKey:@"kTrymewithoutTigglyshapes"];
            lblWithShape.minimumFontSize = 15.0f;
            lblWithoutShape.minimumFontSize = 15.0f;
            
        } completion:^(BOOL finished) {
             isLanguageScreenDisplayed = NO;
             [[TigglyStampUtils sharedInstance] setCurrentLanguage: [[TigglyStampUtils sharedInstance] getCurrentLanguage]];
        }];
    }
}

#pragma mark -
#pragma mark =======================================
#pragma mark IBAction
#pragma mark =======================================


-(IBAction) onButtonTouched:(id)sender{
    DebugLog(@"");
    [[TDSoundManager sharedManager] playSound:@"Blop_Sound_effect" withFormat:@"mp3"];
    
    UIButton *btn = (UIButton *) sender;
    
    if (btn.tag == TAG_BTN_WITHSHAPE) {     
        if(![[TigglyStampUtils sharedInstance] isAppUnlockedForShapes]) {
            UnlockScreenViewController *unlockScreen = [[UnlockScreenViewController alloc] initWithNibName:@"UnlockScreenViewController" bundle:nil entryFrom:kScreenEntryFromIntroView withHomeView:nil];
            [self.navigationController pushViewController:unlockScreen animated:NO];
        }else{
            [[TigglyStampUtils sharedInstance] setShapeMode:YES];
            TSHomeViewController *homeViewController = [[TSHomeViewController alloc]initWithNibName:@"TSHomeViewController" bundle:nil];            
            [self.navigationController pushViewController:homeViewController animated:NO];
        }
    }else if (btn.tag == TAG_BTN_WITHOUTSHAPE){
        [self playVideo];
//        [[TigglyStampUtils sharedInstance] setShapeMode:NO];
//        TSHomeViewController *homeViewController = [[TSHomeViewController alloc]initWithNibName:@"TSHomeViewController" bundle:nil];        
//         [self.navigationController pushViewController:homeViewController animated:NO];
    }
    
}

-(IBAction)actionGoBackToLanguage {
    DebugLog(@"");
    
    [UIView animateWithDuration:0.3 animations:^{
        self.gameTypeView.frame = CGRectMake(1024, 0, 1024, 768);
    } completion:^(BOOL finished) {
        isLanguageScreenDisplayed = YES;
    }];
    
}

-(IBAction)closeButtonClicked:(id)sender {
    DebugLog(@"");    
    [self.view bringSubviewToFront:self.gameTypeView];
    [UIView animateWithDuration:0.4 animations:^{
        self.gameTypeView.frame = CGRectMake(0, 0, 1024, 768);
    } completion:^(BOOL finished) {        
        isLanguageScreenDisplayed = NO;
        [[TDSoundManager sharedManager] playSound:@"Blop_Sound_effect" withFormat:@"mp3"];
       
    }];

         [[TigglyStampUtils sharedInstance] setCurrentLanguage:lblLunguage.text];
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


#pragma mark-
#pragma mark======================
#pragma mark Video Player
#pragma mark======================

-(void) playVideo{
    DebugLog(@"");
    
    //    moviePlayer = [[MPMoviePlayerController alloc] initWithContentURL:videoUrl];
    viewForVideo = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 1024, 768)];
    viewForVideo.backgroundColor = [UIColor clearColor];
    [self.view addSubview:viewForVideo];
    
    
    NSBundle *bundle = [NSBundle mainBundle];
    NSString *moviePath = [bundle pathForResource:@"tiggly" ofType:@"mov"];
    NSURL *movieURL = [NSURL fileURLWithPath:moviePath];
    
    moviePlayer = [[MPMoviePlayerController alloc] initWithContentURL:movieURL];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(moviePlayBackDidFinish:)
                                                 name:MPMoviePlayerPlaybackDidFinishNotification
                                               object:moviePlayer];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(didExitFullScreen:)
                                                 name:MPMoviePlayerDidExitFullscreenNotification
                                               object:nil];
    
    //    [[NSNotificationCenter defaultCenter] addObserver:self
    //                                             selector:@selector(didExitFullScreen:)
    //                                                 name:MPMoviePlayer
    //                                               object:nil];
    
    [moviePlayer.view setFrame:CGRectMake(0, 0, 825, 610)];
    moviePlayer.view.center = CGPointMake(512, 384);
    moviePlayer.shouldAutoplay = YES;
    [viewForVideo addSubview:moviePlayer.view];
    [moviePlayer prepareToPlay];
    [moviePlayer play];
    
    tmrCloseBtn = [NSTimer scheduledTimerWithTimeInterval:15
                                                   target:self
                                                 selector:@selector(showCloseBtn)
                                                 userInfo:nil
                                                  repeats:NO];
    
    
    
}

-(void)didExitFullScreen:(id)sender{
    DebugLog(@"");
    
}

- (void) moviePlayBackDidFinish:(NSNotification*)notification {
    DebugLog(@"");
    
}

-(void)showCloseBtn{
    DebugLog(@"");
    
    UIButton *btnClose = [UIButton buttonWithType:UIButtonTypeCustom];
    [btnClose setBackgroundImage:[UIImage imageNamed:@"cross.png"] forState:UIControlStateNormal];
    [btnClose setBackgroundImage:[UIImage imageNamed:@"cross.png"] forState:UIControlStateSelected];
    [btnClose addTarget:self action:@selector(actionCloseViewForVideo)forControlEvents:UIControlEventTouchUpInside];
    btnClose.frame = CGRectMake(0, 0, 70, 70);
    btnClose.center = CGPointMake(moviePlayer.view.frame.origin.x + moviePlayer.view.frame.size.width, moviePlayer.view.frame.origin.y);
    btnClose.alpha = 0;
    [viewForVideo addSubview:btnClose];
    
    [UIView animateWithDuration:1
                     animations:^{
                         
                         btnClose.alpha = 1;
                         
                     }];
    
    
}

-(void)actionCloseViewForVideo{
    DebugLog(@"");
    
    [moviePlayer stop];
    moviePlayer = nil;
    [viewForVideo removeFromSuperview];
    viewForVideo = nil;
    
    [[TigglyStampUtils sharedInstance] setShapeMode:NO];
    _isRemoveAllElement = YES;
    TSHomeViewController *homeViewController = [[TSHomeViewController alloc]initWithNibName:@"TSHomeViewController" bundle:nil];
    [self.navigationController pushViewController:homeViewController animated:NO];
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
    
    
    [[TigglyStampUtils sharedInstance] setCurrentLanguage:[self.arrLanguage objectAtIndex:indexPath.row]];
    
    lblLunguage.text = [[TigglyStampUtils sharedInstance] getLocalisedStringForKey:@"kLanguage"];
    
    float fontSize = 0.0;
    if([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"English"]){
        fontSize = 45.0f;
    }else{
        fontSize = 28.0f;
    }
    lblWithoutShape.font = [UIFont fontWithName:APP_FONT_BOLD size:fontSize];
    lblWithShape.font = [UIFont fontWithName:APP_FONT_BOLD size:fontSize];
    lblWithShape.text = [[TigglyStampUtils sharedInstance] getLocalisedStringForKey:@"kUnlockwithTigglyshapes"];
    lblWithoutShape.text = [[TigglyStampUtils sharedInstance] getLocalisedStringForKey:@"kTrymewithoutTigglyshapes"];
    lblWithShape.minimumFontSize = 15.0f;
    lblWithoutShape.minimumFontSize = 15.0f;

    
    [self.view bringSubviewToFront:self.gameTypeView];
    
    [UIView animateWithDuration:0.4 animations:^{
        self.gameTypeView.frame = CGRectMake(0, 0, 1024, 768);
        
    } completion:^(BOOL finished) {
        isLanguageScreenDisplayed = NO;
        [[TDSoundManager sharedManager] playSound:@"Blop_Sound_effect" withFormat:@"mp3"];
        
    }];

}

@end
