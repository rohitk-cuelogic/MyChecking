//
//  ParentScreenViewController.m
//  TigglyStamp
//
//  Created by Swpnil j. on 26/07/13.
//  Copyright (c) 2013 cuelogic. All rights reserved.
//

#import "ParentScreenViewController.h"
#import "SettingsViewController.h"
#import "UnlockScreenViewController.h"

#define TAG_SUBSCRIBE_BTN 1
#define TAG_SETTINGS_BTN 2
#define TAG_FACEBOOK_BTN 3
#define TAG_TWITTER_BTN 4
#define TAG_PATH_BTN 5
#define TAG_SKIP_BTN 6
#define TAG_SUBMIT_BTN 7
#define TAG_HOME_BTN 8
#define TAG_TIGGLY_NEWS_BTN 9
#define TAG_CLOSE_WEB_BTN 10
#define TAG_LETTER_TAB_BTN 11
#define TAG_PLAY_TAB_BTN 12
#define TAG_TIP_TAB_BTN 13
#define TAG_PHILOSOPHY_TAB_BTN 14
#define TAG_LETTER_MOTAR_BTN 15
#define TAG_LETTER_LANGUAGE_BTN 16
#define TAG_LETTER_SPATIAL_BTN 17
#define TAG_LETTER_TAB_POPUP_CLOSE_BTN 18

@interface ParentScreenViewController ()

@end

@implementation ParentScreenViewController

@synthesize subscribeBTN,settingsBTN,faceBookBTN,twitterBTN,pathBTN,childInfoView,confView,homeBTN,skipBTN,submitBTN;
@synthesize childInfoSubView;
@synthesize confSubView;
@synthesize emailidTextField;
@synthesize nameTextField;
@synthesize ageTextField;
@synthesize activeSession;
@synthesize userFieldsRequired;
@synthesize permissions;
@synthesize tabInforSCROLL;
@synthesize tabLetterBTN,tabLearningTipBTN,tabPlayBTN,tabLearPhilosophyBTN,tabTitleIMGVIEW,tabBody1TEXT,tabHeading1TEXT,tabBody2TEXT,tabHeading2TEXT,tabHeading3TEXT;
@synthesize lblLanguageTEXT,lblMotarTEXT,lblSpatialTEXT;
@synthesize tabLetterMotarBTN,tabLetterLanguageBTN,tabLetterSpatialBTN,lettertabBodyTEXT,lettertabCloseBTN,lettertabHeadingLBL,letterTabView;
@synthesize btnPrivacyPolicy;
@synthesize webViewTab;
@synthesize privacymainView;
@synthesize isConnection;
@synthesize clearView;

UIActivityIndicatorView *activityIndicator;

#pragma mark -
#pragma mark =======================================
#pragma mark Init
#pragma mark =======================================

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil withHomeView:(TSHomeViewController *) homeView
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        homeViewController = homeView;
    }
    return self;
}

#pragma mark -
#pragma mark =======================================
#pragma mark View LifeCycle
#pragma mark =======================================

- (BOOL)prefersStatusBarHidden {
    return YES;
}

- (void)viewDidLoad {
    DebugLog(@"");
    [super viewDidLoad];
    

    if ([self respondsToSelector:@selector(setNeedsStatusBarAppearanceUpdate)]) {
        // iOS 7
        [self prefersStatusBarHidden];
        [self performSelector:@selector(setNeedsStatusBarAppearanceUpdate)];
    } else {
        // iOS 6
        [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationSlide];
    }
    
    [subscribeBTN setTag:TAG_SUBSCRIBE_BTN];
    [settingsBTN setTag:TAG_SETTINGS_BTN];
    [faceBookBTN setTag:TAG_FACEBOOK_BTN];
    [twitterBTN setTag:TAG_TWITTER_BTN];
    [pathBTN setTag:TAG_PATH_BTN];
    [skipBTN setTag:TAG_SKIP_BTN];
    [submitBTN setTag:TAG_SUBMIT_BTN];
    [homeBTN setTag:TAG_HOME_BTN];
    [btnTigglyNews setTag:TAG_TIGGLY_NEWS_BTN];
    [btnClose setTag:TAG_CLOSE_WEB_BTN];
    [tabLetterBTN setTag:TAG_LETTER_TAB_BTN];
    [tabPlayBTN setTag:TAG_PLAY_TAB_BTN];
    [tabLearningTipBTN setTag:TAG_TIP_TAB_BTN];
    [tabLetterMotarBTN setTag:TAG_LETTER_MOTAR_BTN];
    [tabLetterLanguageBTN setTag:TAG_LETTER_LANGUAGE_BTN];
    [tabLetterSpatialBTN setTag:TAG_LETTER_SPATIAL_BTN];
    [lettertabCloseBTN setTag:TAG_LETTER_TAB_POPUP_CLOSE_BTN];
    
    emailidTextField.font =  [UIFont fontWithName:APP_FONT size:18.0f];
    
    [self setInfoForLetterTabWebView];

    childInfoSubView.layer.cornerRadius = 30.0f;
    childInfoSubView.layer.masksToBounds = YES;
    
    confSubView.layer.cornerRadius = 25.0f;
    confSubView.layer.masksToBounds = YES;
    confSubView.layer.borderColor =  [UIColor blueColor].CGColor;
    confSubView.layer.borderWidth = 1.5f;
    
    settingsBTN.layer.cornerRadius = 10.0f;
    settingsBTN.layer.masksToBounds = YES;
    
    subscribeBTN.layer.cornerRadius = 10.0f;
    subscribeBTN.layer.masksToBounds = YES;
    
    skipBTN.layer.cornerRadius = 10.0f;
    skipBTN.layer.masksToBounds = YES;
    
    viewForWeb.frame = CGRectMake(0, 768, 1024, 768);

    activityIndicator = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    activityIndicator.center = webView.center;
    [webView addSubview:activityIndicator];
    [webView bringSubviewToFront:activityIndicator];
    
    btnPrivacyPolicy.titleLabel.font = [UIFont fontWithName:APP_FONT size:16.0f];

}

-(void)viewDidAppear:(BOOL)animated{
    DebugLog(@"");
    
    //Manual
    // May return nil if a tracker has not already been initialized with a
    // property ID.
#ifdef GOOGLE_ANALYTICS_START
    id<GAITracker> tracker = [[GAI sharedInstance] defaultTracker];
    
    // This screen name value will remain set on the tracker and sent with
    // hits until it is set to a new value or to nil.
    [tracker set:kGAIScreenName
           value:@"Parent Control Screen"];
    
    [tracker send:[[GAIDictionaryBuilder createAppView] build]];
#else
#endif
    

    
}

- (void)didReceiveMemoryWarning {
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

#pragma mark -
#pragma mark =======================================
#pragma mark Helpers
#pragma mark =======================================

-(void) launchSettingScreen {
    DebugLog(@"");
//    SettingsViewController *settingsView = [[SettingsViewController alloc] initWithNibName:@"SettingsViewController" bundle:nil];
//    settingsView.parentScreen = self;
//    settingsView.modalPresentationStyle = UIModalPresentationPageSheet;
//    
//    if([self respondsToSelector:@selector(presentModalViewController:animated:)])
//        [self presentModalViewController:settingsView animated:YES];
//    else
//        [self presentViewController:settingsView animated:YES completion:nil];
//    
//    [settingsView.view.superview setAutoresizingMask:(UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth)];
//    int height;
//    if([[TigglyStampUtils sharedInstance] isAppUnlockedForShapes])
//        height = 390;
//    else
//        height = 450;
//    
//    [settingsView.view.superview setFrame:CGRectMake(512-400, 384-(height/2), 800, height)]; //(128, 177, 768, 414)
//    settingsView.view.superview.layer.cornerRadius = 25.0f;
//    settingsView.view.superview.layer.masksToBounds = YES;
    
//    [self disableAllButtons];
    
    int height;
    if([[TigglyStampUtils sharedInstance] isAppUnlockedForShapes])
        height = 390;
    else
        height = 450;

    if(settingView != nil){
        [settingView removeFromSuperview];
        settingView = nil;
    }
    
    clearView = [[UIView alloc] initWithFrame:self.view.frame];
    clearView.backgroundColor = [UIColor blackColor];
    clearView.alpha = 0.5;
    [self.view addSubview:clearView];
    
    settingView = [[SettingsView alloc] initWithFrame:CGRectMake(512-400, 800, 800, height)];
    settingView.delegate = self;
    [UIView animateWithDuration:0.5 animations:^{
        settingView.frame = CGRectMake(512-400, 384-(height/2), 800, height);
        [self.view addSubview:settingView];
    } completion:^(BOOL finished){
        self.view.userInteractionEnabled = YES;
    }];

}

- (void)removeConfirmationDilog:(NSTimer*)timer {
    DebugLog(@"");
    [self.confView removeFromSuperview];
    emailidTextField.text = @"";

}

-(void) launchUnlockScreen {
    DebugLog(@"");
    
    UnlockScreenViewController *unlockScreen = [[UnlockScreenViewController alloc] initWithNibName:@"UnlockScreenViewController" bundle:nil entryFrom:kScreenEntryFromSettingView withHomeView:homeViewController];
    [self.navigationController pushViewController:unlockScreen animated:YES];
    
}

-(void) enableAllButtons{
    DebugLog(@"");
    
    webViewTab.scrollView.scrollEnabled  =YES;
    homeBTN.enabled = YES;
    subscribeBTN.enabled = YES;
    faceBookBTN.enabled = YES;
    twitterBTN.enabled = YES;
    pathBTN.enabled = YES;
    tabLetterBTN.enabled = YES;
    tabPlayBTN.enabled = YES;
    tabLearningTipBTN.enabled = YES;
    tabLearPhilosophyBTN.enabled = YES;
    settingsBTN.enabled = YES;
    btnPrivacyPolicy.enabled = YES;
}


-(void) disableAllButtons{
    DebugLog(@"");
    
    webViewTab.scrollView.scrollEnabled  =YES;
    settingsBTN.enabled = NO;
    homeBTN.enabled = NO;
    subscribeBTN.enabled =  NO;
    faceBookBTN.enabled =  NO;
    twitterBTN.enabled =  NO;
    pathBTN.enabled =  NO;
    tabLetterBTN.enabled =  NO;
    tabPlayBTN.enabled =  NO;
    tabLearningTipBTN.enabled =  NO;
    tabLearPhilosophyBTN.enabled =  NO;
    btnPrivacyPolicy.enabled = NO;
}


#pragma mark -
#pragma mark =======================================
#pragma mark Action Handling
#pragma mark =======================================

-(IBAction)actionReview:(id)sender{
    DebugLog(@"");
    
     [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://itunes.apple.com/us/app/tiggly-stamp/id716727860?ls=1&mt=8"]];
}

-(IBAction)actionClosePrivacyPolicy:(id)sender{
    DebugLog(@"");
    [privacymainView removeFromSuperview];
}

-(IBAction)actionPrivacyPolicy:(id)sender{
    DebugLog(@"");
    [self.view addSubview:privacymainView];
}

-(IBAction)onButtonClicked:(id)sender{
    DebugLog(@"");
    
    UIButton *btn = sender;
    if ([btn tag] == TAG_HOME_BTN) {
//        TSHomeViewController *tSHomeViewController = [[TSHomeViewController alloc] initWithNibName:@"TSHomeViewController" bundle:Nil];
        [self.navigationController popViewControllerAnimated:YES];
    }
    if ([btn tag] == TAG_SUBSCRIBE_BTN) {
        
#ifdef GOOGLE_ANALYTICS_START
        NSMutableDictionary *event =
        [[GAIDictionaryBuilder createEventWithCategory:@"Button Click"
                                                action:@"Button Clicked"
                                                 label:@"Subscribe_Button"
                                                 value:nil] build];
        [[GAI sharedInstance].defaultTracker send:event];
        [[GAI sharedInstance] dispatch];
#else
#endif
        

        
        if (emailidTextField.text.length != 0) {
            if ([self isValidEmailAddress:emailidTextField.text] == YES) {
   
#ifdef GOOGLE_ANALYTICS_START
//                NSMutableDictionary *event =
//                [[GAIDictionaryBuilder createEventWithCategory:@"Tiggly Subscription"
//                                                        action:@"Subscribe"
//                                                         label:emailidTextField.text
//                                                         value:nil] build];
//                [[GAI sharedInstance].defaultTracker send:event];
//                [[GAI sharedInstance] dispatch];
#else
#endif
                 [emailidTextField resignFirstResponder];
                [self.view addSubview:confView];
                [NSTimer scheduledTimerWithTimeInterval:4.0 target:self selector:@selector(removeConfirmationDilog:) userInfo:nil repeats:NO];
                
//                [self CheckNetworkConnection];
//                if( isConnection==YES)
//                {
//                    hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
//                    hud.labelText = NSLocalizedString(@"Loading ...", @"");
//                    hud.autoresizingMask = 0;
//                    // send user email addresses to subscription@tiggly.com
//                    NSString *msgBody = emailidTextField.text;
//                    [self sendMessageTo:SUBSCRIPTION_EMAIL_ID withMessagebody:msgBody];
//                    
//                }
//                [emailidTextField resignFirstResponder];
//
//                [self sendEmail];
                
            }else{
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Tiggly" message:@"Please enter valid email address" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
                [alert show];
            }
        }else{
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Tiggly" message:@"Please enter email address" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
            [alert show];
        }
    }
    if ([btn tag] == TAG_SETTINGS_BTN) {
        [self launchSettingScreen];
    }
    if ([btn tag] == TAG_FACEBOOK_BTN) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://www.facebook.com/Tiggly"]];

//        NSMutableDictionary *event =
//        [[GAIDictionaryBuilder createEventWithCategory:@"UI"
//                                                action:@"buttonPress"
//                                                 label:@"FB_Button"
//                                                 value:nil] build];
//        [[GAI sharedInstance].defaultTracker send:event];
//        [[GAI sharedInstance] dispatch];
//        
//        [self signInWithFacebook:sender];
    }
    if ([btn tag] == TAG_TWITTER_BTN) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://twitter.com/TigglyKids"]];

//        NSMutableDictionary *event =
//        [[GAIDictionaryBuilder createEventWithCategory:@"UI"
//                                                action:@"buttonPress"
//                                                 label:@"Twitter_Button"
//                                                 value:nil] build];
//        [[GAI sharedInstance].defaultTracker send:event];
//        [[GAI sharedInstance] dispatch];
//        [self signInWithTwitter:sender];
    }
    if ([btn tag] == TAG_PATH_BTN) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://www.pinterest.com/tigglykids/"]];

        
//        NSMutableDictionary *event =
//        [[GAIDictionaryBuilder createEventWithCategory:@"UI"
//                                                action:@"buttonPress"
//                                                 label:@"Pinterest_Button"
//                                                 value:nil] build];
//        [[GAI sharedInstance].defaultTracker send:event];
//        [[GAI sharedInstance] dispatch];
//        [self signInWithPinterest:sender];
    }
    if ([btn tag] == TAG_SKIP_BTN) {
        [self.childInfoView removeFromSuperview];
    }
    if ([btn tag] == TAG_SUBMIT_BTN) {
        if ([self validateData] == YES) {
            [self.childInfoView removeFromSuperview];
            [self.view addSubview:confView];
            nameTextField.text = @"";
            ageTextField.text = @"";
            [NSTimer scheduledTimerWithTimeInterval:4.0 target:self selector:@selector(removeConfirmationDilog:) userInfo:nil repeats:NO];
            
        }
    }
    if([btn tag] == TAG_TIGGLY_NEWS_BTN){
#ifdef GOOGLE_ANALYTICS_START
        NSMutableDictionary *event =
        [[GAIDictionaryBuilder createEventWithCategory:@"Button Click"
                                                action:@"Button Clicked"
                                                 label:@"Tiggly_news_Button"
                                                 value:nil] build];
        [[GAI sharedInstance].defaultTracker send:event];
        [[GAI sharedInstance] dispatch];
#else
#endif

        [self.view bringSubviewToFront:viewForWeb];
        NSString *urlString = @"http://tiggly.com/";
        //Create a URL object.
        NSURL *url = [NSURL URLWithString:urlString];
        //URL Requst Object
        NSURLRequest *requestObj = [NSURLRequest requestWithURL:url];
        
        [webView loadRequest:requestObj];
        
        [UIView animateWithDuration:0.5
                         animations:^(void){
                             viewForWeb.frame = CGRectMake(0, 0, 1024, 768);
                         }
                         completion:^(BOOL finished){
                             
                         }];

    }
    if([btn tag] == TAG_CLOSE_WEB_BTN){
        [UIView animateWithDuration:0.5
                         animations:^(void){
                             viewForWeb.frame = CGRectMake(0, 768, 1024, 768);
                         }
                         completion:^(BOOL finished){
                             [self.view sendSubviewToBack:viewForWeb];
                         }];
    }
    if([btn tag] == TAG_LETTER_TAB_BTN){
        [self setInfoForLetterTabWebView];
    }
    if([btn tag] == TAG_PLAY_TAB_BTN){
        [self setInfoForPlayTabWebView];
    }
    if([btn tag] == TAG_TIP_TAB_BTN){
        [self setInfoForTipTabWebView];
    }
    if([btn tag] == TAG_PHILOSOPHY_TAB_BTN){
        [self setInfoForPhilosophyTabWebView];
    }
    if([btn tag] == TAG_LETTER_MOTAR_BTN){
        [self showValidationError:@"Grabbing and holding the shapes, moving them, and placing them on the screen help your child enhance their fine motor skills. " title:@"Motor skills"];
    }
    if([btn tag] == TAG_LETTER_LANGUAGE_BTN){
        [self showValidationError:@"Children will hear the names of animals, fruits, and objects as they appear on screen and greet your child. They will also practice storytelling and producing language as part of their play" title:@"Language Development"];

    }
    if([btn tag] == TAG_LETTER_SPATIAL_BTN){
        [self showValidationError:@"Tiggly Safari encourages children to recognize and match basic shapes— circles, squares, triangles, and stars in various orientations. By manipulating real shapes, and grabbing, rotating, moving, and placing them on a target, children learn about spatial relations and transformations. Finally, by turning simple shapes into animals, they practice their ability to create complex images" title:@"Spatial Thinking"];
    }

    if([btn tag] == TAG_LETTER_TAB_POPUP_CLOSE_BTN){
        [letterTabView removeFromSuperview];
        
    }
}

-(void)setInfoForLetterTabWebView {
    tabTitleIMGVIEW.image = [UIImage imageNamed:@"tab_letter.png"];
    
    NSString *htmlFile = [[NSBundle mainBundle] pathForResource:@"tiggly" ofType:@"html" inDirectory:nil];
    NSString* htmlString = [NSString stringWithContentsOfFile:htmlFile encoding:NSUTF8StringEncoding error:nil];
    
    self.webViewTab.delegate = self;
    [self.webViewTab loadHTMLString:htmlString baseURL:[[NSBundle mainBundle] bundleURL]];
    
}

-(void)setInfoForPlayTabWebView {
    tabTitleIMGVIEW.image = [UIImage imageNamed:@"tab_play.png"];
    
    NSString *htmlFile = [[NSBundle mainBundle] pathForResource:@"play" ofType:@"html" inDirectory:nil];
    NSString* htmlString = [NSString stringWithContentsOfFile:htmlFile encoding:NSUTF8StringEncoding error:nil];
    
    self.webViewTab.delegate = self;
    [self.webViewTab loadHTMLString:htmlString baseURL:[[NSBundle mainBundle] bundleURL]];
    
}
-(void)setInfoForTipTabWebView {
    tabTitleIMGVIEW.image = [UIImage imageNamed:@"tab_learning.png"];
    
    NSString *htmlFile = [[NSBundle mainBundle] pathForResource:@"learning" ofType:@"html" inDirectory:nil];
    NSString* htmlString = [NSString stringWithContentsOfFile:htmlFile encoding:NSUTF8StringEncoding error:nil];
    
    self.webViewTab.delegate = self;
    [self.webViewTab loadHTMLString:htmlString baseURL:[[NSBundle mainBundle] bundleURL]];
    
}

-(void)setInfoForPhilosophyTabWebView {
    DebugLog(@"");
    tabTitleIMGVIEW.image = [UIImage imageNamed:@"tab_learning_philosophy.png"];
    
    NSString *htmlFile = [[NSBundle mainBundle] pathForResource:@"learning_philoshophy" ofType:@"html" inDirectory:nil];
    NSString* htmlString = [NSString stringWithContentsOfFile:htmlFile encoding:NSUTF8StringEncoding error:nil];
    
    self.webViewTab.delegate = self;
    [self.webViewTab loadHTMLString:htmlString baseURL:[[NSBundle mainBundle] bundleURL]];
    
}

-(void) launchTigglyNews {
    DebugLog(@"");
#ifdef GOOGLE_ANALYTICS_START
    NSMutableDictionary *event =
    [[GAIDictionaryBuilder createEventWithCategory:@"Parent Control"
                                            action:@"buttonPress"
                                             label:@"Tiggly_news_Button"
                                             value:nil] build];
    [[GAI sharedInstance].defaultTracker send:event];
    [[GAI sharedInstance] dispatch];
#else
#endif

    [self.view bringSubviewToFront:viewForWeb];
    NSString *urlString = @"http://tiggly.com/";
    //Create a URL object.
    NSURL *url = [NSURL URLWithString:urlString];
    //URL Requst Object
    NSURLRequest *requestObj = [NSURLRequest requestWithURL:url];
    
    [webView loadRequest:requestObj];
    
    [UIView animateWithDuration:0.5
                     animations:^(void){
                         viewForWeb.frame = CGRectMake(0, 0, 1024, 768);
                     }
                     completion:^(BOOL finished){
                         
                     }];
}

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
                // tiggly logo clicked
                [self launchTigglyNews];
            }
            if ([methodName isEqualToString:@"MotarSkill"] ) {
                [letterTabView removeFromSuperview];
                
                // MotarSkill clicked
                //                [self showValidationError:@"Grabbing and holding the shapes, moving them, and placing them on the screen help your child enhance their fine motor skills. " title:@"Motor skills"];
                 lettertabHeadingLBL.font = [UIFont fontWithName:APP_FONT_BOLD size:24.0f];
                 lettertabBodyTEXT.font = [UIFont fontWithName:APP_FONT size:16.0f];
                
                lettertabHeadingLBL.text = @"Motor skills";
                lettertabBodyTEXT.text =[NSString stringWithFormat:@"Grabbing and holding the shapes, moving them, and placing them on the screen help your child enhance their fine motor skills."];
                [self.view addSubview:letterTabView];
                
            }
            if ([methodName isEqualToString:@"LanguageDevelopment"] ) {
                [letterTabView removeFromSuperview];
                
                // language clicked
                //                [self showValidationError:@"Children will hear the names of animals, fruits, and objects as they appear on screen and greet your child. They will also practice storytelling and producing language as part of their play" title:@"Language Development"];
                
                lettertabHeadingLBL.font = [UIFont fontWithName:APP_FONT_BOLD size:24.0f];
                lettertabBodyTEXT.font = [UIFont fontWithName:APP_FONT size:16.0f];
                
                lettertabHeadingLBL.text = @"Language Development";
                lettertabBodyTEXT.text =[NSString stringWithFormat:@"Children will hear the names of animals, fruits, and objects as they appear on screen and greet your child. They will also practice storytelling and producing language as part of their play"];
                [self.view addSubview:letterTabView];
                
            }
            if ([methodName isEqualToString:@"SpatialThinking"] ) {
                [letterTabView removeFromSuperview];
                
                // spatialThinking clicked
                //                [self showValidationError:@"Tiggly Safari encourages children to recognize and match basic shapes— circles, squares, triangles, and stars in various orientations. By manipulating real shapes, and grabbing, rotating, moving, and placing them on a target, children learn about spatial relations and transformations. Finally, by turning simple shapes into animals, they practice their ability to create complex images" title:@"Spatial Thinking"];
                
                lettertabHeadingLBL.font = [UIFont fontWithName:APP_FONT_BOLD size:24.0f];
                lettertabBodyTEXT.font = [UIFont fontWithName:APP_FONT size:16.0f];
                
                lettertabHeadingLBL.text = @"Spatial Thinking";
                lettertabBodyTEXT.text =[NSString stringWithFormat:@"Tiggly Safari encourages children to recognize and match basic shapes— circles, squares, triangles, and stars in various orientations. By manipulating real shapes, and grabbing, rotating, moving, and placing them on a target, children learn about spatial relations and transformations. Finally, by turning simple shapes into animals, they practice their ability to create complex images"];
                [self.view addSubview:letterTabView];
                
            }
        }
    }
    return YES;
}


-(void)setInfoForLetterTab {
    DebugLog(@"");

    tabHeading1TEXT.font = [UIFont fontWithName:APP_FONT size:14];
    tabHeading2TEXT.font = [UIFont fontWithName:APP_FONT size:14];
    tabHeading3TEXT.font = [UIFont fontWithName:APP_FONT size:14];
    tabBody1TEXT.font = [UIFont fontWithName:APP_FONT size:14];
    tabBody2TEXT.font = [UIFont fontWithName:APP_FONT size:14];
    
    tabHeading1TEXT.hidden = YES;
    tabInforSCROLL.contentSize = CGSizeMake(tabInforSCROLL.contentSize.width, 970);
    tabInforSCROLL.contentOffset = CGPointMake(0, 0);
    tabTitleIMGVIEW.image = [UIImage imageNamed:@"tab_letter.png"];
    tabHeading3TEXT.frame =CGRectMake(tabHeading3TEXT.frame.origin.x, 70, tabHeading3TEXT.frame.size.width, 150);
    tabHeading3TEXT.text = @"Dear Parent,\n\nSo glad you found us! At Tiggly, we respect the challenges of modern-day parenthood. It is a tough job! We founded Tiggly because we wanted to help parents introduce their children to the digital world in an easy yet educational way. Just like you, we are deeply invested in your child’s early development, and we believe we can create the best learning experiences for them by combining physical and digital play. Read more about our learning philosophy";
    tabHeading3TEXT.hidden = NO;
    
    tabHeading2TEXT.frame =CGRectMake(tabHeading2TEXT.frame.origin.x, tabHeading3TEXT.frame.origin.y +160, tabHeading2TEXT.frame.size.width, 50);
    tabHeading2TEXT.text = @"About Tiggly Safari:";
    tabHeading2TEXT.hidden = NO;
    tabHeading2TEXT.font = [UIFont fontWithName:APP_FONT_BOLD_ITALIC size:14];

    
    
    tabBody1TEXT.frame =CGRectMake(tabBody1TEXT.frame.origin.x, tabHeading2TEXT.frame.origin.y +30, tabBody1TEXT.frame.size.width, 350);
    tabBody1TEXT.text = @"I remember the first time I visited the zoo as a little girl and my sense of awe and wonder as I saw exotic animals from each corner of the globe, ones that I never even knew existed. When we were developing our first app to work with Tiggly Shapes, I knew there was no better place to start than by trying to capture the sense of wonder that the animal kingdom holds for children. Inspired by the artwork of Chaley Harper and Ed Emberley, we envisioned a farm, a jungle, and an ocean full of animals – all made from simple shapes awaiting your child as they enter the world of Tiggly!\n\nIn Tiggly Safari, your children use Tiggly Shapes to construct a series of fun and friendly animals – cows, turkeys, lions, owls, crabs, and many more! We designed each level in the game based on what we know about children’s spatial cognition development.\n\nIn the first level, children simply match shapes with what they see on the screen and create simple animals out of single shapes. As the levels proceed, children are challenged to create more complex animals with combination of shapes, recognize and match basic shapes in various orientations, and practice their hand-eye coordination by catching moving objects— all while being amazed by the cute animals of their creation!";
    
    tabLetterMotarBTN.frame =CGRectMake(tabLetterMotarBTN.frame.origin.x,tabBody1TEXT.frame.origin.y+ 350, tabLetterMotarBTN.frame.size.width, tabLetterMotarBTN.frame.size.height);
    tabLetterLanguageBTN.frame =CGRectMake(tabLetterLanguageBTN.frame.origin.x, tabBody1TEXT.frame.origin.y+ 350, tabLetterLanguageBTN.frame.size.width, tabLetterLanguageBTN.frame.size.height);
    tabLetterSpatialBTN.frame =CGRectMake(tabLetterSpatialBTN.frame.origin.x, tabBody1TEXT.frame.origin.y+ 350, tabLetterSpatialBTN.frame.size.width, tabLetterSpatialBTN.frame.size.height);
    
    lblLanguageTEXT.hidden =NO;
    lblMotarTEXT.hidden =NO;
    lblSpatialTEXT.hidden =NO;
    lblLanguageTEXT.frame =CGRectMake(lblLanguageTEXT.frame.origin.x,tabLetterMotarBTN.frame.origin.y+130, lblLanguageTEXT.frame.size.width, lblLanguageTEXT.frame.size.height);
    
    lblMotarTEXT.frame =CGRectMake(lblMotarTEXT.frame.origin.x,tabLetterMotarBTN.frame.origin.y+130, lblMotarTEXT.frame.size.width, lblMotarTEXT.frame.size.height);

    lblSpatialTEXT.frame =CGRectMake(lblSpatialTEXT.frame.origin.x,tabLetterMotarBTN.frame.origin.y+130, lblSpatialTEXT.frame.size.width, lblSpatialTEXT.frame.size.height);
    lblLanguageTEXT.font = [UIFont fontWithName:APP_FONT size:14];
    lblMotarTEXT.font = [UIFont fontWithName:APP_FONT size:14];
    lblSpatialTEXT.font = [UIFont fontWithName:APP_FONT size:14];

    tabLetterMotarBTN.hidden =NO;
    tabLetterLanguageBTN.hidden =NO;
    tabLetterSpatialBTN.hidden =NO;
    
    tabBody2TEXT.hidden = NO;
    tabBody2TEXT.frame =CGRectMake(tabBody2TEXT.frame.origin.x, tabLetterMotarBTN.frame.origin.y +tabLetterMotarBTN.frame.size.height+ 20, tabBody2TEXT.frame.size.width, 200);
    tabBody2TEXT.text = @"\nOur goal is to produce learning toys and apps that you love to share with your children, and we hope that this is the start of a long relationship.\n\nWarm regards,\n\nAzadeh Jamalian\nChief Learning Officer\nTiggly\n";
//    tabBody2TEXT.font = [UIFont fontWithName:@"Rockwell-Bold" size:14];
//    Rockwell-BoldItalic

}
-(void)setInfoForPlayTab {
    tabHeading1TEXT.font = [UIFont fontWithName:APP_FONT size:14];
    tabHeading2TEXT.font = [UIFont fontWithName:APP_FONT size:14];
    tabHeading3TEXT.font = [UIFont fontWithName:APP_FONT size:14];
    tabBody1TEXT.font = [UIFont fontWithName:APP_FONT size:14];
    tabBody2TEXT.font = [UIFont fontWithName:APP_FONT size:14];

    lblLanguageTEXT.hidden =YES;
    lblMotarTEXT.hidden =YES;
    lblSpatialTEXT.hidden =YES;
    tabInforSCROLL.contentSize = CGSizeMake(tabInforSCROLL.contentSize.width, 500);
    tabInforSCROLL.contentOffset = CGPointMake(0, 0);
    for (NSString *familyName in [UIFont familyNames]) {
        for (NSString *fontName in [UIFont fontNamesForFamilyName:familyName]) {
            NSLog(@"%@", fontName);
        }
    }
    tabLetterMotarBTN.hidden =YES;
    tabLetterLanguageBTN.hidden =YES;
    tabLetterSpatialBTN.hidden =YES;
    tabTitleIMGVIEW.image = [UIImage imageNamed:@"tab_play.png"];
    tabHeading1TEXT.hidden = NO;
    tabHeading1TEXT.frame =CGRectMake(tabHeading1TEXT.frame.origin.x, 70, tabHeading1TEXT.frame.size.width, 50);
    tabHeading1TEXT.text = @"HOW TO PLAY:";
    tabHeading1TEXT.font = [UIFont fontWithName:APP_FONT_BOLD size:14];


    tabHeading2TEXT.frame =CGRectMake(tabHeading2TEXT.frame.origin.x, tabHeading1TEXT.frame.origin.y+40, tabHeading2TEXT.frame.size.width, 50);
    tabHeading2TEXT.text = @"Play with shapes:";
    tabHeading2TEXT.font = [UIFont fontWithName:APP_FONT_BOLD_ITALIC size:14];


    tabBody1TEXT.frame =CGRectMake(tabBody1TEXT.frame.origin.x, tabHeading2TEXT.frame.origin.y+20, tabBody1TEXT.frame.size.width, 100);
    tabBody1TEXT.text = @"	•	It’s simple! Match your Tiggly Shape with what you see on the screen. See a circle? Tap the screen with your circle.\n	•	Take the shape off the screen to see what happens next.";
    tabBody1TEXT.font = [UIFont fontWithName:APP_FONT size:14];

    [tabInforSCROLL bringSubviewToFront:tabBody1TEXT];

    tabHeading3TEXT.frame =CGRectMake(tabHeading3TEXT.frame.origin.x, tabBody1TEXT.frame.origin.y+70, tabHeading3TEXT.frame.size.width, 50);
    tabHeading3TEXT.text = @"Play without shapes:";
    tabHeading3TEXT.font = [UIFont fontWithName:APP_FONT_BOLD_ITALIC size:14];

    [tabInforSCROLL bringSubviewToFront:tabHeading3TEXT];
    tabBody2TEXT.frame =CGRectMake(tabBody2TEXT.frame.origin.x, tabHeading3TEXT.frame.origin.y+20, tabBody2TEXT.frame.size.width, 50);
    tabBody2TEXT.text = @"	•	Drag shapes from the tray and watch what happens.";
    tabBody2TEXT.font = [UIFont fontWithName:APP_FONT size:14];

    [tabInforSCROLL bringSubviewToFront:tabBody2TEXT];

    tabHeading2TEXT.hidden = NO;
    tabBody2TEXT.hidden = NO;
    tabHeading3TEXT.hidden = NO;

}
-(void)setInfoForTipTab {
    tabHeading1TEXT.font = [UIFont fontWithName:APP_FONT size:14];
    tabHeading2TEXT.font = [UIFont fontWithName:APP_FONT size:14];
    tabHeading3TEXT.font = [UIFont fontWithName:APP_FONT size:14];
    tabBody1TEXT.font = [UIFont fontWithName:APP_FONT size:14];
    tabBody2TEXT.font = [UIFont fontWithName:APP_FONT size:14];
    lblLanguageTEXT.hidden =YES;
    lblMotarTEXT.hidden =YES;
    lblSpatialTEXT.hidden =YES;
    tabHeading3TEXT.hidden = YES;
    tabInforSCROLL.contentSize = CGSizeMake(tabInforSCROLL.contentSize.width, 630);
    tabInforSCROLL.contentOffset = CGPointMake(0, 0);
    tabLetterMotarBTN.hidden =YES;
    tabLetterLanguageBTN.hidden =YES;
    tabLetterSpatialBTN.hidden =YES;
    tabTitleIMGVIEW.image = [UIImage imageNamed:@"tab_learning.png"];
    tabHeading1TEXT.hidden = NO;
    tabHeading1TEXT.frame =CGRectMake(tabHeading1TEXT.frame.origin.x, 70, tabHeading1TEXT.frame.size.width, 50);
    tabHeading1TEXT.text = @"Tips to enhance your child’s play experience";
    tabHeading1TEXT.font = [UIFont fontWithName:@"Rockwell-BoldItalic" size:14];

    tabBody1TEXT.frame =CGRectMake(tabBody1TEXT.frame.origin.x, tabHeading1TEXT.frame.origin.y+30, tabBody1TEXT.frame.size.width, 110);
    tabBody1TEXT.text = @"Here are few tips for you to support your child’s learning from the app:\n	•	Encourage them to repeat after the narrator as it names the objects and animals.\n	•	Challenge them by asking to guess what animal they are constructing.\n	•	Have two kids at home? Encourage them to share the shapes and collaborate on their creations!";
    
    tabHeading2TEXT.frame =CGRectMake(tabHeading2TEXT.frame.origin.x, tabBody1TEXT.frame.origin.y+ 120, tabHeading2TEXT.frame.size.width, tabHeading2TEXT.frame.size.height);
    tabBody2TEXT.frame =CGRectMake(tabBody2TEXT.frame.origin.x, tabHeading2TEXT.frame.origin.y+ 30, tabBody2TEXT.frame.size.width, 500);
    
    tabHeading2TEXT.hidden = NO;
    tabBody2TEXT.hidden = NO;
    tabHeading2TEXT.text = @"Tips to enhance your child’s learning experience outside the app";
    tabHeading2TEXT.font = [UIFont fontWithName:@"Rockwell-BoldItalic" size:14];
    [tabInforSCROLL bringSubviewToFront:tabBody2TEXT];
    tabBody2TEXT.text = @"Your child’s education does not begin and end in one setting. Learning is fluid; the most effective learning experiences are the ones that transfer from one setting to another. Here is a list of suggested activities for you to help your little ones develop their spatial thinking and language skills outside the app. You will help them take what they learn in the app and apply the lessons to the outside world!\n\n	•	Talk with your child about shapes, spatial relations, and spatial transformations. Research shows that parents who use spatial words in their vocabulary have children with better spatial skills. Include words such as name of shapes (square, circle, triangle, star, rectangle, trapezoid, etc.), relational words (up, down, below, above, left, right, beside), and spatial-transformation verbs (rotate, flip, slide) when talking to your child.\n	•	Encourage your child to see shapes around them. When you notice a circular object around your home or a triangle in a book, point that out to your child.\n	•	Help your child construct complex objects using simple shapes. Why not make paper cutouts of shapes and encourage your child to create their own animals or objects? Send us pictures, we’d love to include them in our next Safari update!\n	•	Solve puzzles together.\n	•	Have fun with the shapes beyond the tablet… We’ve seen many kids building towers with them or wear them as bracelets! \n";
    
}
-(void)setInfoForPhilosophyTab {
    tabHeading1TEXT.font = [UIFont fontWithName:APP_FONT size:14];
    tabHeading2TEXT.font = [UIFont fontWithName:APP_FONT size:14];
    tabHeading3TEXT.font = [UIFont fontWithName:APP_FONT size:14];
    tabBody1TEXT.font = [UIFont fontWithName:APP_FONT size:14];
    tabBody2TEXT.font = [UIFont fontWithName:APP_FONT size:14];
    lblLanguageTEXT.hidden =YES;
    lblMotarTEXT.hidden =YES;
    lblSpatialTEXT.hidden =YES;
    tabHeading3TEXT.hidden = YES;
    tabInforSCROLL.contentSize = CGSizeMake(tabInforSCROLL.contentSize.width, 1180);
    tabInforSCROLL.contentOffset = CGPointMake(0, 0);
    tabLetterMotarBTN.hidden =YES;
    tabLetterLanguageBTN.hidden =YES;
    tabLetterSpatialBTN.hidden =YES;
    tabTitleIMGVIEW.image = [UIImage imageNamed:@"tab_learning_philosophy.png"];
    tabHeading1TEXT.hidden = NO;
    tabHeading1TEXT.frame =CGRectMake(tabHeading1TEXT.frame.origin.x, 70, tabHeading1TEXT.frame.size.width, 50);
    tabHeading1TEXT.text = @"Tiggly’s Learning Philosophy:";
    tabHeading1TEXT.font = [UIFont fontWithName:APP_FONT_BOLD size:14];
    tabBody1TEXT.frame =CGRectMake(tabBody1TEXT.frame.origin.x, tabHeading1TEXT.frame.origin.y+30, tabBody1TEXT.frame.size.width, 1200);
    tabBody1TEXT.text = @"At Tiggly, we design toys that interact with learning apps because we believe there is a powerful learning opportunity in the combination of physical and digital play.\n\nDigital play alone has many benefits on its own right: a digital platform can adapt to a child’s skills and knowledge; it can provide feedback, guidance, and structure targeted to the child’s needs; it can track a child’s performance and assess his or her development by providing instant reports of a child’s learning progression to their parents and teachers; and it can be sometimes even more fun to play with than a toy car or a teddy bear!\n\nHowever, what’s missing in a digital setting is the valuable interaction that comes with playing with real objects: grabbing objects in hand, holding them, placing them on a target, and otherwise manipulating them. Seventy years of research on children’s development -- from 20th century education and psychology revolutionaries like Maria Montessori and Jean Piaget to today’s cognitive scientists -- tells us that physical play is extremely important for proper childhood development. What’s obvious is that playing with objects aids the development of motor skills and improves hand-eye coordination. What’s not as obvious is that physical play also helps cognition and memory.\n\nHolding an object in hand stabilizes your child’s head and focuses his attention while he visually and manually explores the object. Have you ever noticed that a 2-year-old constantly looks all around , moving his head in all directions? But as soon as he’s engaged with a toy, all his attention is focused on that toy. Attention to objects is a positive thing, because when children focus on something, there is a better chance for them to learn its name and develop their language skills. But it’s not just about learning names — it’s about learning a whole lot about the world around them. Attending to objects, visually and manually exploring them, acting on them, and inspecting the results of our actions around us is the basis of all learning.\n\nWhat’s important in learning is to engage all our senses. Take a circle as an example. When your child looks at a circle on a screen, she can see the shape. But when she grabs and holds a circular toy in hand, she also touches and feels the roundness of it. She notices that she can roll her circular toy but not her triangular one. She discovers that the circle looks the same when she spins it, but her triangle looks different as she rotates it. Manual interaction with physical blocks helps her understand that not only do a circle and triangle look different but they also have different properties and can be manipulated in different ways. It’s an early “aha moment”: “So that’s why wheels are round and not triangular!”\n\nHowever, as great as a triangle or a circle block is, it can never speak to your child. Your child can play with a block for hours and hours, explore it in all directions and manipulate it in many ways, but may never know the name of its shape. It may take even longer for him to realize if he puts together two triangles he can make a square, or that he can draw a cow with two squares!\n\n            That’s where Tiggly’s educator-designed apps come in.\n\nIn our digital world, the sky is the limit for imagination. A child can catch stars or stamp circles in an ocean to make a seahorse or a dolphin. She can put together a circle and two squares to draw an elephant in a mysterious jungle. The triangle on the screen may jokingly say to her, “I’m a triangle! I bet you’re not!”\n\nAnd that’s why we think there is an immense educational opportunity when physical play and digital play come together. Your child gets all the benefits of interacting with real objects while their imagination is stimulated in a digital context. They receive appropriate guidance in their learning and are given new challenges as their understanding advances. In this way, Tiggly is reimagining play— by bridging the gap between established educational standards and the new digital frontier.";
    tabHeading2TEXT.text = @"";
    tabBody2TEXT.text = @"";
    tabHeading2TEXT.hidden = YES;
    tabBody2TEXT.hidden = YES;
    
    
}


//#pragma mark- Facebook Integration
//-(void)signInWithFacebook:(id)sender
//{
//    [self facebookLogout];
//    [self facebookAuthentication];
//}
//
//- (void) facebookLogout
//{
//    [FBSession.activeSession closeAndClearTokenInformation];
//    [FBSession.activeSession close];
//    [FBSession setActiveSession:nil];
//    NSHTTPCookie *cookie;
//    NSHTTPCookieStorage *storage = [NSHTTPCookieStorage sharedHTTPCookieStorage];
//    for (cookie in [storage cookies])
//    {
//        NSString *domainName = [cookie domain];
//        NSRange domainRange = [domainName rangeOfString:@"facebook"];
//        if(domainRange.length > 0)
//        {
//            [storage deleteCookie:cookie];
//        }
//    }
//    //    activeSession = [[FBSession alloc] initWithPermissions:permissions];
//}
//
//
//
//- (void) facebookAuthentication
//{
//    // FBSample logic
//    // Check to see whether we have already opened a session.
//    
//    userFieldsRequired = @"id,name,first_name, last_name, gender,birthday,email,username, work";
//    permissions = [[NSArray alloc] initWithObjects:
//                   @"email" , @"user_about_me",@"user_birthday", @"user_work_history",@"user_interests", @"user_activities",@"user_status",@"user_photos",@"user_likes",
//                   nil];
//    
//    if (!FBSession.activeSession.isOpen)
//    {
//        activeSession = [[FBSession alloc] initWithPermissions:permissions];
//        
//        [activeSession openWithBehavior:FBSessionLoginBehaviorForcingWebView
//                      completionHandler:^(FBSession *session,
//                                          FBSessionState status,
//                                          NSError *error) {
//                          // if login fails for any reason, we alert
//                          if (error) {
//
////                            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Tiggly" message:@"Do you want to try again?" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
////                              
//                              // if otherwise we check to see if the session is open, an alternative to
//                              // to the FB_ISSESSIONOPENWITHSTATE helper-macro would be to check the isOpen
//                              // property of the session object; the macros are useful, however, for more
//                              // detailed state checking for FBSession objects
//                          } else if (FB_ISSESSIONOPENWITHSTATE(session.state)) {
//                              // send our requests if we successfully logged in
//                              [self sendRequests:[NSString stringWithFormat:@"me?access_token=%@",activeSession.accessToken] params:[NSDictionary dictionaryWithObject:userFieldsRequired forKey:@"fields"]];
//                          }
//                          else
//                          {
//                              [activeSession closeAndClearTokenInformation];
//                          }
//                      }];
//        
//    }else
//    {
//        [self sendRequests:[NSString stringWithFormat:@"me?access_token=%@",activeSession.accessToken] params:[NSDictionary dictionaryWithObject:userFieldsRequired forKey:@"fields"]];
//    }
//    
//}
//
//-(void) sendRequests:(NSString *) fbid
//{
//    [self sendRequests:fbid params:NULL];
//}
//
//-(void) sendRequests:(NSString *) fbid params:(NSDictionary *) params
//{
//    // create the connection object
//    FBRequestConnection *newConnection = [[FBRequestConnection alloc] init];
//    
//    // create a handler block to handle the results of the request for fbid's profile
//    FBRequestHandler handler =
//    ^(FBRequestConnection *connection, id result, NSError *error) {
//        // output the results of the request
//        [self requestCompleted:connection forFbID:fbid result:result error:error];
//    };
//    
//    // create the request object, using the fbid as the graph path
//    // as an alternative the request* static methods of the FBRequest class could
//    // be used to fetch common requests, such as /me and /me/friends
//    FBRequest *request = NULL;
//    if(params != NULL)
//    {
//        request = [[FBRequest alloc] initWithSession:activeSession
//                                           graphPath:fbid parameters:params HTTPMethod:@"GET"] ;
//    }
//    else
//    {
//        request = [[FBRequest alloc] initWithSession:activeSession
//                                           graphPath:fbid];
//    }
//    
//    // add the request to the connection object, if more than one request is added
//    // the connection object will compose the requests as a batch request; whether or
//    // not the request is a batch or a singleton, the handler behavior is the same,
//    // allowing the application to be dynamic in regards to whether a single or multiple
//    // requests are occuring
//    [newConnection addRequest:request completionHandler:handler];
//    
//    
//    // if there's an outstanding connection, just cancel
//    //    [self.requestConnection cancel];
//    //
//    //    // keep track of our connection, and start it
//    //    self.requestConnection = newConnection;
//    [newConnection start];
//}
//
//
//// FBSample logic
//// Report any results.  Invoked once for each request we make.
//- (void)requestCompleted:(FBRequestConnection *)connection
//                 forFbID:fbID
//                  result:(id)result
//                   error:(NSError *)error
//{
//    
//}
//
//#pragma mark- Twitter Integration
//-(void)signInWithTwitter:(id)sender
//{
//    [[FHSTwitterEngine sharedEngine]permanentlySetConsumerKey:kOAuthConsumerKey andSecret:kOAuthConsumerSecret];
//    [[FHSTwitterEngine sharedEngine]setDelegate:self];
//    
//    [[FHSTwitterEngine sharedEngine]showOAuthLoginControllerFromViewController:self withCompletion:^(BOOL success) {
//        NSLog(success?@"L0L success":@"O noes!!! Loggen faylur!!!");
//        NSDictionary *twitterDict =  [[FHSTwitterEngine sharedEngine] getTwitterAccountDetails:[[FHSTwitterEngine sharedEngine]loggedInUsername]];
//        NSLog(@"USER DICT _ %@",twitterDict);
//    }];
//}
//
//#pragma mark- Pinterest Integration
//-(void)signInWithPinterest:(id)sender
//{
//    _pinterest = [[Pinterest alloc] initWithClientId:@"1432658"];
//    
//    [_pinterest createPinWithImageURL:[NSURL URLWithString:@"http://placekitten.com/500/400"]
//                            sourceURL:[NSURL URLWithString:@"http://placekitten.com"]
//                          description:@"Pinning from Tiggly Application"];
//
//}

#pragma mark- UITextField Delegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField == nameTextField) {
        [ageTextField becomeFirstResponder];
    }else{
        [textField resignFirstResponder];
    }
    return YES;
}

#pragma mark - Data Validation
- (BOOL)isValidEmailAddress:(NSString*)emailAddress
{
	if (emailAddress.length > 160)
		return NO;
    
	NSString* pattern = @"[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\\.[a-zA-Z]{2,4}";
	NSPredicate* predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
	return [predicate evaluateWithObject:emailAddress];
}

- (void)showValidationError:(NSString*)message
{
	[self showValidationError:message title:NSLocalizedString(@"Tiggly", @"")];
}

- (void)showValidationError:(NSString*)message title:(NSString*)theTitle
{
	UIAlertView *alertView = [[UIAlertView alloc]
                              initWithTitle:theTitle
                              message:message
                              delegate:nil
                              cancelButtonTitle:NSLocalizedString(@"Ok", nil)
                              otherButtonTitles:nil] ;
    
	[alertView show];
}

- (BOOL)requiredField:(NSString*)fieldValue named:(NSString*)fieldName
{
	if (fieldValue.length == 0)
	{
		[self showValidationError:[NSString stringWithFormat:NSLocalizedString(@"Please enter %@", nil), fieldName]];
		return NO;
	}
	return YES;
}

- (BOOL)validateData
{
	if (![self requiredField:nameTextField.text named:NSLocalizedString(@"child's name", nil)])
		return NO;
    if (![self requiredField:ageTextField.text named:NSLocalizedString(@"child's age", nil)])
		return NO;
    
   	return YES;
}

#pragma mark -
#pragma mark =======================================
#pragma mark Webview Delegates
#pragma mark =======================================

-(void)webViewDidStartLoad:(UIWebView *)webView
{
    [activityIndicator startAnimating];
}
-(void)webViewDidFinishLoad:(UIWebView *)webView
{
    [activityIndicator stopAnimating];
}
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    [activityIndicator stopAnimating];
}

#pragma mark -
#pragma mark =======================================
#pragma mark SettingView Protocol
#pragma mark =======================================

-(void) settingViewOnCloseButtonClick:(SettingsView *)sView {
    DebugLog(@"");
  
//    [self enableAllButtons];
    
    [clearView removeFromSuperview];
    
    int height;
    if([[TigglyStampUtils sharedInstance] isAppUnlockedForShapes])
        height = 390;
    else
        height = 450;
    [UIView animateWithDuration:0.5 animations:^{
        settingView.frame = CGRectMake(512-400,800, 800, height);
    } completion:^(BOOL finished){
        self.view.userInteractionEnabled = YES;
        [settingView removeFromSuperview];
        settingView = nil;
    }];
}

-(void) settingViewOnShapeSwitchClick:(SettingsView *) sView{
    DebugLog(@"");
    
//     [self enableAllButtons];
    [clearView removeFromSuperview];
    
    [self launchUnlockScreen];
}

#pragma mark- Mail
- (void)sendMessageTo:(NSString *)reciverEmail withMessagebody:(NSString *)messageBody
{
    NSLog(@"Start Sending");
    SKPSMTPMessage *emailMessage = [[SKPSMTPMessage alloc] init];
    emailMessage.fromEmail = SENDER_EMAIL_ID; //sender email address
    emailMessage.toEmail = reciverEmail;  //receiver email address
    emailMessage.relayHost = @"smtp.gmail.com";
    //emailMessage.ccEmail =@"your cc address";
    //emailMessage.bccEmail =@"your bcc address";
    emailMessage.requiresAuth = YES;
    emailMessage.login = SENDER_EMAIL_ID; //sender email address
    emailMessage.pass = SENDER_EMAIL_ID_PASSWORD; //sender email password
    emailMessage.subject =@"Tiggly Subscription";
    emailMessage.wantsSecure = YES;
    emailMessage.delegate = self; // you must include <SKPSMTPMessageDelegate> to your class
    
    //for example :   NSString *messageBody = [NSString stringWithFormat:@"Tour Name: %@\nName: %@\nEmail: %@\nContact No: %@\nAddress: %@\nNote: %@",selectedTour,nameField.text,emailField.text,foneField.text,addField.text,txtView.text];
    // Now creating plain text email message
    NSDictionary *plainMsg = [NSDictionary
                              dictionaryWithObjectsAndKeys:@"text/plain",kSKPSMTPPartContentTypeKey,
                              messageBody,kSKPSMTPPartMessageKey,@"8bit",kSKPSMTPPartContentTransferEncodingKey,nil];
    emailMessage.parts = [NSArray arrayWithObjects:plainMsg,nil];
    //in addition : Logic for attaching file with email message.
    /*
     NSString *filePath = [[NSBundle mainBundle] pathForResource:@"filename" ofType:@"JPG"];
     NSData *fileData = [NSData dataWithContentsOfFile:filePath];
     NSDictionary *fileMsg = [NSDictionary dictionaryWithObjectsAndKeys:@"text/directory;\r\n\tx-
     unix-mode=0644;\r\n\tname=\"filename.JPG\"",kSKPSMTPPartContentTypeKey,@"attachment;\r\n\tfilename=\"filename.JPG\"",kSKPSMTPPartContentDispositionKey,[fileData encodeBase64ForData],kSKPSMTPPartMessageKey,@"base64",kSKPSMTPPartContentTransferEncodingKey,nil];
     emailMessage.parts = [NSArray arrayWithObjects:plainMsg,fileMsg,nil]; //including plain msg and attached file msg
     */
    [emailMessage send];
    // sending email- will take little time to send so its better to use indicator with message showing sending...
}


-(void)messageSent:(SKPSMTPMessage *)message{
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    [self.view addSubview:confView];
    [NSTimer scheduledTimerWithTimeInterval:4.0 target:self selector:@selector(removeConfirmationDilog:) userInfo:nil repeats:NO];
}

-(void)messageFailed:(SKPSMTPMessage *)message error:(NSError *)error{
    // open an alert with just an OK button
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error!" message:[error localizedDescription] delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles: nil];
    [alert show];
}
#pragma mark - Network Connection
-(void)CheckNetworkConnection
{
    UIAlertView *errorView;
    NetworkStatus internetStatus = [[Reachability reachabilityForInternetConnection] currentReachabilityStatus];
    
    if(internetStatus== NotReachable){
        
        errorView = [[UIAlertView alloc]
                     initWithTitle: @"Tiggly"
                     message: @"It seems that your internet connection is not working. Please check your internet connection."
                     delegate: nil
                     cancelButtonTitle: @"Ok" otherButtonTitles: nil];
        [errorView show];
        isConnection=NO;
    }
    else
        isConnection=YES;
}

#pragma mark -
#pragma mark =======================================
#pragma mark Mail
#pragma mark =======================================

-(void) sendEmail {
    DebugLog(@"");

    if([[TigglyStampUtils sharedInstance] isMailSupported] == YES) {
    
        //Shows the email composer view
        MFMailComposeViewController *picker = [[MFMailComposeViewController alloc] init];
        picker.mailComposeDelegate = self;
        [picker setToRecipients:[[NSArray alloc]initWithObjects:@"sachin.patil@cuelogic.co.in", nil]]; //SUBSCRIPTION_EMAIL_ID

        NSString *sub;
        NSString *body;
   
        sub = [NSString stringWithFormat:@"Subscribe to Tiggly"];
        body =  emailidTextField.text;
        
        DebugLog(@"Email Subject: %@",sub);
        DebugLog(@"Email Body: %@",body);
        
        [picker setSubject:sub];    
        [picker setMessageBody:body isHTML:NO];
        
        [self presentModalViewController:picker animated:YES];
        
    }else if([[TigglyStampUtils sharedInstance] isMailSupported] == NO){
        
        NSString *alertTitle = @"Email Error!";
        NSString *alertMsg = @"Configure the Mail Account on your device to send email";
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:alertTitle message:alertMsg
                                                       delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil,nil];
        [alert show];
        
    }
}

- (void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error {
	// Notifies users about errors associated with the interface
    [emailidTextField resignFirstResponder];
    
	switch (result)
	{
		case MFMailComposeResultCancelled:
			break;
		case MFMailComposeResultSaved:
			break;
		case MFMailComposeResultSent:
        {
            [self.view addSubview:confView];
            [NSTimer scheduledTimerWithTimeInterval:6.0 target:self selector:@selector(removeConfirmationDilog:) userInfo:nil repeats:NO];
        }
            break;
		case MFMailComposeResultFailed:
        {
            NSString *alertTitle = @"Email Sending Failed";
            NSString *alertMsg = @"Email sending failed, please try again";
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:alertTitle message:alertMsg
                                                           delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil,nil];
            [alert show];
        }
			break;
		default:
			break;
	}
	[self dismissModalViewControllerAnimated:YES];
}


@end
