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

@implementation IntroScreenViewController{
    GestureConfirmationView *gestureView;
}

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
    
    // Featch iPad mini device version array and save in user default
    [[ServerController sharedInstance] fetchiPadDeviceVersion:self];
    
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
        
    arrLanguage = [[NSMutableArray alloc] initWithObjects:@"English",@"Portuguese",@"Russian",@"Spanish",@"French",@"German",@"Italian",@"Chinese", nil];
    
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
    
    CGRect rect = RECT_IPAD;
    rect.origin.y = rect.size.height;
    viewForWeb.frame = rect;
    [self.view addSubview:viewForWeb];
    
    
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
//    lblWithShape.text = [[TigglyStampUtils sharedInstance] getLocalisedStringForKey:@"kUnlockwithTigglyshapes"];
//    lblWithoutShape.text = [[TigglyStampUtils sharedInstance] getLocalisedStringForKey:@"kTrymewithoutTigglyshapes"];
//    
    
//    NSString *lanstr = [[TigglyStampUtils sharedInstance] getLocalisedStringForKey:@"kTrymewithoutTigglyshapes"];
//    if([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"English"]){
//        lanstr =@"What are Tiggly Shapes?";
//    }
//    
//    lblWithoutShape.text = lanstr;
//    lblWithoutShape.adjustsFontSizeToFitWidth = true;
//    
//    lanstr = [[TigglyStampUtils sharedInstance] getLocalisedStringForKey:@"kUnlockwithTigglyshapes"];
//    if([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"English"]){
//        lanstr =@"I have Tiggly Shapes";
//    }
//    
//    lblWithShape.text =lanstr;
//    lblWithShape.adjustsFontSizeToFitWidth = true;
    [self setShapeButtonLabelTest];

    
    
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
//            lblWithShape.text = [[TigglyStampUtils sharedInstance] getLocalisedStringForKey:@"kUnlockwithTigglyshapes"];
//            lblWithoutShape.text = [[TigglyStampUtils sharedInstance] getLocalisedStringForKey:@"kTrymewithoutTigglyshapes"];
            [self setShapeButtonLabelTest];
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
//        [self playVideo];

        [self.view bringSubviewToFront:viewForWeb];
        
        NSString *fileNameBase = @"learnMore";
        NSString *fileName = @"learnMore";
        if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"English"]) {
            fileName   = [NSString stringWithFormat:@"%@",fileNameBase];
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"English UK"]){
            fileName   = [NSString stringWithFormat:@"%@",fileNameBase];
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"Portuguese"]){
            fileName   = [NSString stringWithFormat:@"%@_portuguese",fileNameBase];
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"Russian"]){
            fileName   = [NSString stringWithFormat:@"%@_russian",fileNameBase];
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"Spanish"]){
            fileName   = [NSString stringWithFormat:@"%@_spanish",fileNameBase];
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"French"]){
            fileName   = [NSString stringWithFormat:@"%@_french",fileNameBase];
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"German"]){
            fileName   = [NSString stringWithFormat:@"%@_German",fileNameBase];
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"Italian"]){
            fileName   = [NSString stringWithFormat:@"%@_italian",fileNameBase];
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"Chinese"]){
            fileName   = [NSString stringWithFormat:@"%@_chinese",fileNameBase];
        }
        
        NSString *htmlFile = [[NSBundle mainBundle] pathForResource:fileName ofType:@"html" inDirectory:nil];
        NSString* htmlString = [NSString stringWithContentsOfFile:htmlFile encoding:NSUTF8StringEncoding error:nil];
        webViewFirstLaunch.scrollView.bounces = NO;
        webViewFirstLaunch.delegate = self;
        [webViewFirstLaunch loadHTMLString:htmlString baseURL:[[NSBundle mainBundle] bundleURL]];
        [UIView animateWithDuration:0.5
                         animations:^(void){
                             viewForWeb.frame = RECT_IPAD ; //CGRectMake(0, 0, 1024, 768);
                         }
                         completion:^(BOOL finished){
                             
                         }];

        
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
-(IBAction)closeButtonWebClicked:(id)sender {
    DebugLog(@"");
    if (sender!=NULL) {
        [webViewFirstLaunch stopLoading];
        [webViewFirstLaunch loadHTMLString:@"" baseURL:[[NSBundle mainBundle] bundleURL]];
    }
    TSHomeViewController *homeViewController = [[TSHomeViewController alloc]initWithNibName:@"TSHomeViewController" bundle:nil];
    [self.navigationController pushViewController:homeViewController animated:NO];
    CGRect rect = RECT_IPAD;
    rect.origin.y = rect.size.height;
    [UIView animateWithDuration:0.5
                     animations:^(void){
                         viewForWeb.frame = rect;
                     }
                     completion:^(BOOL finished){
                         [self.view sendSubviewToBack:viewForWeb];
                         //                        TCHomeViewController *homeViewController = [[TCHomeViewController alloc]initWithNibName:@"TCHomeViewController" bundle:nil];
                         //                        [self.navigationController pushViewController:homeViewController animated:NO];
                         
                     }];
    
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
#pragma mark ==============================
#pragma mark WebView Delegate
#pragma mark ==============================


- (BOOL)webView:(UIWebView*)webView shouldStartLoadWithRequest:(NSURLRequest*)request navigationType:(UIWebViewNavigationType)navigationType {
    DebugLog(@"");
    
    NSURL *URL = [request URL];
    if ([[URL scheme] isEqualToString:@"callmycode"]) {
        NSString *urlString = [[request URL] absoluteString];
        NSArray *urlParts = [urlString componentsSeparatedByString:@":"];
        //check to see if we just got the scheme
        if ([urlParts count] > 1) {
            NSArray *parameters = [[urlParts objectAtIndex:1] componentsSeparatedByString:@"&"];
            NSString *methodName = [parameters objectAtIndex:0];
            
            if ([methodName isEqualToString:@"logoItem"] ) {
                // learnMore UI clicked
                [self showConfirmationView];
            }
            if ([methodName isEqualToString:@"playWihoutShp"] ) {
                DebugLog(@"playWihoutShp");
                    [webViewFirstLaunch stopLoading];
                    [webViewFirstLaunch loadHTMLString:@"" baseURL:[[NSBundle mainBundle] bundleURL]];
                [self closeButtonWebClicked:NULL];
            }
        }
    }
    return YES;
}

    
#pragma mark -
#pragma mark ==============================
#pragma mark touches handling
#pragma mark ==============================
-(void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    
    double delayInSeconds = 0.3;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        if (gestureView != NULL) {
            [gestureView removeFromSuperview];
            gestureView = NULL;
        }
    });
}
    
#pragma mark -
#pragma mark ==============================
#pragma mark GestureConfirmationView delegates
#pragma mark ==============================
    
-(void) showConfirmationView{
    DebugLog(@"");
    
    
    gestureView = [[GestureConfirmationView alloc] initWithFrame:CGRectMake(0, 0, 1024, 768)];
    gestureView.delegate = self;
    [self.view addSubview:gestureView];
    [self.view bringSubviewToFront:gestureView];
}
    
-(void) gestureViewOnGestureConfirmed:(GestureConfirmationView *) gView{
    DebugLog(@"");
    if (gestureView != NULL) {
        [gestureView removeFromSuperview];
        gestureView = NULL;
    }
    [webViewFirstLaunch stopLoading];
    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"firstLaunch"];
    [self closeButtonWebClicked:NULL];
    NSString* launchUrl = @"http://tiggly.com/shop";
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString: launchUrl]];
    
}
    
-(void) gestureViewOnCancel:(GestureConfirmationView *) gView{
    DebugLog(@"");
    if (gestureView != NULL) {
        [gestureView removeFromSuperview];
        gestureView = NULL;
    }
}
    
    
-(void) gestureViewOnChangeLanguage {
    DebugLog(@"");
    if (gestureView != NULL) {
        [gestureView removeFromSuperview];
        gestureView = NULL;
    }
    
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
    
    UIButton *btClose = [UIButton buttonWithType:UIButtonTypeCustom];
    [btClose setBackgroundImage:[UIImage imageNamed:@"cross.png"] forState:UIControlStateNormal];
    [btClose setBackgroundImage:[UIImage imageNamed:@"cross.png"] forState:UIControlStateSelected];
    [btClose addTarget:self action:@selector(actionCloseViewForVideo)forControlEvents:UIControlEventTouchUpInside];
    btClose.frame = CGRectMake(0, 0, 70, 70);
    btClose.center = CGPointMake(moviePlayer.view.frame.origin.x + moviePlayer.view.frame.size.width, moviePlayer.view.frame.origin.y);
    btClose.alpha = 0;
    [viewForVideo addSubview:btClose];
    
    [UIView animateWithDuration:1
                     animations:^{
                         
                         btClose.alpha = 1;
                         
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


-(void) setShapeButtonLabelTest {
    DebugLog(@"");
    NSString *lanstr = [[TigglyStampUtils sharedInstance] getLocalisedStringForKey:@"kTrymewithoutTigglyshapes"];
    if([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"English"]){
        lanstr =@"What are Tiggly Shapes?";
    }
    
    lblWithoutShape.text = lanstr;
    lblWithoutShape.adjustsFontSizeToFitWidth = true;
    
    lanstr = [[TigglyStampUtils sharedInstance] getLocalisedStringForKey:@"kUnlockwithTigglyshapes"];
    if([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"English"]){
        lanstr =@"I have Tiggly Shapes";
    }
    lblWithShape.text =lanstr;
    lblWithShape.adjustsFontSizeToFitWidth = true;
    
    
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
//    lblWithShape.text = [[TigglyStampUtils sharedInstance] getLocalisedStringForKey:@"kUnlockwithTigglyshapes"];
//    lblWithoutShape.text = [[TigglyStampUtils sharedInstance] getLocalisedStringForKey:@"kTrymewithoutTigglyshapes"];
    [self setShapeButtonLabelTest];
    
    
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
