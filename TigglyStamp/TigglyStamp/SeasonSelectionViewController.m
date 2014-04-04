//
//  SeassonSelectionViewController.m
//  TigglyStamp
//
//  Created by Sagar Kudale on 25/07/13.
//  Copyright (c) 2013 cuelogic. All rights reserved.
//

#import "SeasonSelectionViewController.h"


#define TAG_FALL_BTN 1
#define TAG_WINTER_BTN 2
#define TAG_SUMMER_BTN 3
#define TAG_SPRING_BTN 4

@interface SeasonSelectionViewController ()

@end
//============================================================================================
@implementation SeasonSelectionViewController
UISwipeGestureRecognizer *mSwpeRecognizer;
NSMutableArray *swipeTxtArray;
int swipeTxtCnt;
@synthesize winterSeasonBtn,SummerSeasonBtn,SpringSeasonBtn,fallSeasonBtn,lockWinter,homeBtn,learnMoreBtn;

//============================================================================================

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil withHomeView:(TSHomeViewController *) homeView{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        homeViewController = homeView;
    }
    return self;
}

- (BOOL)prefersStatusBarHidden {
    return YES;
}

- (void)viewDidLoad {
    DebugLog(@"");
    [super viewDidLoad];
    
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.enabled = NO;
    }
    
    if ([self respondsToSelector:@selector(setNeedsStatusBarAppearanceUpdate)]) {
        // iOS 7
        [self prefersStatusBarHidden];
        [self performSelector:@selector(setNeedsStatusBarAppearanceUpdate)];
    } else {
        // iOS 6
        [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationSlide];
    }
  
    if(![[TigglyStampUtils sharedInstance] isAppUnlockedForShapes]){
        float fontSize = 0.0;
        if([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"English"]){
            fontSize = 22.0f;
        }else  if([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"Russian"]){
            fontSize = 18.0f;
        }else{
            fontSize = 20.0f;
        }
        
        if([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"Italian"]){
            fontSize = 16.0f;
        }
        lblLearnmore.text =[[TigglyStampUtils sharedInstance] getLocalisedStringForKey:@"kLearnmore"];
        lblLearnmore.font = [UIFont fontWithName:APP_FONT_BOLD size:fontSize];
        [lockWinter setHidden:FALSE];
        [learnMoreBtn setHidden:FALSE];
        [winterSeasonBtn setAlpha:0.5f];
       // [winterSeasonBtn  setBackgroundImage:[UIImage imageNamed:@"btnLock.png"] forState:UIControlStateNormal];
        winterSeasonBtn.userInteractionEnabled = NO;
    }else{
        lblLearnmore.hidden = YES;
        [lockWinter setHidden:TRUE];
        [learnMoreBtn setHidden:TRUE];
        //[winterSeasonBtn  setBackgroundImage:[UIImage imageNamed:@"winter_btn.png"] forState:UIControlStateNormal];
        winterSeasonBtn.userInteractionEnabled = YES;
        [winterSeasonBtn setAlpha:1.0f];
    }
    
    confirmationViewBKG.hidden = YES;
    
    CGRect rect = RECT_IPAD;
    rect.origin.y = rect.size.height;
    viewForWeb.frame = rect;
    [self.view addSubview:viewForWeb];

}

-(void) viewDidAppear:(BOOL)animated{
    DebugLog(@"");
    
    swipeTxtArray = [[NSMutableArray alloc] initWithObjects:@"RIGHT\nwith 2", @"RIGHT\nwith 2", @"LEFT\nwith 2", @"LEFT\nwith 2", @"UP\nwith 2", @"UP\nwith 2", @"DOWN\nwith 2", @"DOWN\nwith 2", nil];
    
    mSwpeRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swippedforConfirmation)];
    [mSwpeRecognizer setNumberOfTouchesRequired:2];
    [self.view addGestureRecognizer:mSwpeRecognizer];
    
#ifdef GOOGLE_ANALYTICS_START
    id<GAITracker> tracker = [[GAI sharedInstance] defaultTracker];
    [tracker set:kGAIScreenName value:@"Scene Selection Screen"];
#endif
}

-(void) viewDidDisappear:(BOOL)animated{
    DebugLog(@"");
    
    [self.view removeGestureRecognizer:mSwpeRecognizer];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return UIInterfaceOrientationIsLandscape(interfaceOrientation);
}

-(BOOL)shouldAutorotate {
    return YES;
}

-(NSUInteger)supportedInterfaceOrientations {
    DebugLog(@"");
    return UIInterfaceOrientationMaskLandscape;
}

//============================================================================================
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//============================================================================================

#pragma mark -
#pragma mark =======================================
#pragma mark Action Handling
#pragma mark =======================================

//============================================================================================

-(IBAction)actionHomeButtonClicked:(id)sender{
    [self.navigationController popViewControllerAnimated:NO];
    homeViewController = nil;
}
//============================================================================================

-(IBAction)actionLearnMore:(id)sender{
    learnMoreBtn.enabled = NO;
    fallSeasonBtn.enabled = NO;
    winterSeasonBtn.enabled = NO;
    homeBtn.enabled = NO;
    [self showConfirmationView];
}
//============================================================================================

-(IBAction) onButtonTouched:(id)sender{
    DebugLog(@"");
    UIButton *btn = (UIButton *) sender;
    DebugLog(@"Btn Tag : %d",btn.tag);
    
    StampViewController *stampViewController = nil;
    
    if (btn.tag == TAG_FALL_BTN) {

        
#ifdef GOOGLE_ANALYTICS_START
        NSMutableDictionary *event =
        [[GAIDictionaryBuilder createEventWithCategory:@"Game Scene"
                                                action:@"Scene selected"
                                                 label:@"Fall scene"
                                                 value:nil] build];
        [[GAI sharedInstance].defaultTracker send:event];
        [[GAI sharedInstance] dispatch];
        
        NSString *strLockStatus = nil;
        if([[TigglyStampUtils sharedInstance] isAppUnlockedForShapes]){
            
            strLockStatus = @"Unlocked";
            
        }else{
            
            strLockStatus = @"Locked";
            
        }
        NSMutableDictionary *event1 =
        [[GAIDictionaryBuilder createEventWithCategory:@"App Status"
                                                action:@"Lock Status"
                                                 label:strLockStatus
                                                 value:nil] build];
        [[GAI sharedInstance].defaultTracker send:event1];
        [[GAI sharedInstance] dispatch];
#else
        
#endif

        
        
        stampViewController = [[StampViewController alloc] initWithNibName:@"StampViewController" bundle:nil withSceneType:kSceneFall withHomeView:homeViewController];
        [self.navigationController pushViewController:stampViewController animated:NO];
        
    }else if (btn.tag == TAG_WINTER_BTN){
        if(![[TigglyStampUtils sharedInstance] isAppUnlockedForShapes]){
            return;
        }
#ifdef GOOGLE_ANALYTICS_START
        NSMutableDictionary *event =
        [[GAIDictionaryBuilder createEventWithCategory:@"Game Scene"
                                                action:@"Scene selected"
                                                 label:@"Winter scene"
                                                 value:nil] build];
        [[GAI sharedInstance].defaultTracker send:event];
        [[GAI sharedInstance] dispatch];
        
        NSString *strLockStatus = nil;
        if([[TigglyStampUtils sharedInstance] isAppUnlockedForShapes]){
            
            strLockStatus = @"Unlocked";
            
        }else{
            
            strLockStatus = @"Locked";
            
        }
        NSMutableDictionary *event2 =
        [[GAIDictionaryBuilder createEventWithCategory:@"App Status"
                                                action:@"Lock Status"
                                                 label:strLockStatus
                                                 value:nil] build];
        [[GAI sharedInstance].defaultTracker send:event2];
        [[GAI sharedInstance] dispatch];
#else
        
#endif

        
        
        stampViewController = [[StampViewController alloc] initWithNibName:@"StampViewController" bundle:nil withSceneType:kSceneWinter withHomeView:homeViewController];
        [self.navigationController pushViewController:stampViewController animated:NO];
    }
    
    
    

}

-(void) showConfirmationView{
    DebugLog(@"");
    
    gestureView = [[GestureConfirmationView alloc] initWithFrame:CGRectMake(0, 0, 1024, 768)];
    gestureView.delegate = self;
    gestureView.layer.zPosition = 1500;
    [self.view addSubview:gestureView];
}

-(void)swippedforConfirmation{
    
    //[self noConfirmation:NULL];
#ifdef GOOGLE_ANALYTICS_START
    NSMutableDictionary *event =
    [[GAIDictionaryBuilder createEventWithCategory:@"About tiggly"
                                            action:@"Learn more"
                                             label:@"Learn more"
                                             value:nil] build];
    [[GAI sharedInstance].defaultTracker send:event];
    [[GAI sharedInstance] dispatch];
    
#else
    
#endif


    
//    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://tiggly.myshopify.com/products/tiggly-shapes"]];
    //[[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://tiggly.com/shop"]];
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

-(IBAction)noConfirmation:(id)sender{
    DebugLog(@"");

    confirmationViewBKG.hidden = YES;
    
    fallSeasonBtn.enabled = YES;
    winterSeasonBtn.enabled = YES;
     homeBtn.enabled = YES;
    learnMoreBtn.enabled = YES;
    
    if(gestureView != nil){
        [gestureView removeFromSuperview];
        gestureView = nil;
    }
    
}

-(void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    
    double delayInSeconds = 0.3;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        [self noConfirmation:nil];
    });
}
#pragma mark-
#pragma mark======================
#pragma mark IBActions
#pragma mark======================

- (void) launchHomeViewController {
    DebugLog(@"");
    
    NSArray* runningVCA = [self.navigationController viewControllers];
    NSMutableArray *removableVCA = [[NSMutableArray alloc]initWithCapacity:1];
    for(UIViewController *runningVC in runningVCA)
    {
        if([runningVC isKindOfClass:[TSHomeViewController class]])
        {
            [removableVCA addObject:runningVC];
        }
    }
    DebugLog(@"Removing view controller :%d",[removableVCA count]);
    if ([removableVCA count]>=1) {
        DebugLog(@"Pop to home VC");
        [self.navigationController popToViewController:[removableVCA objectAtIndex:0] animated:YES];
    }else {
        DebugLog(@"Pop to new home VC");
        TSHomeViewController *tSHomeViewController = [[TSHomeViewController alloc] initWithNibName:@"TSHomeViewController" bundle:Nil];
        [self.navigationController pushViewController:tSHomeViewController animated:YES];
    }
    [removableVCA removeAllObjects];
    removableVCA = NULL;
}
#pragma mark -
#pragma mark =======================================
#pragma mark gestureView Protocol
#pragma mark =======================================

-(void) gestureViewOnGestureConfirmed:(GestureConfirmationView *)gView {
    DebugLog(@"");
    
    [self swippedforConfirmation];
    [gestureView removeFromSuperview];
    gestureView = nil;
    
}

-(void) gestureViewOnCancel:(GestureConfirmationView *) gView{
    DebugLog(@"");
    
     [self noConfirmation:nil];
}
-(IBAction)closeButtonWebClicked:(id)sender {
    DebugLog(@"");
    
    if (sender!=NULL) {
        [webViewFirstLaunch stopLoading];
        [webViewFirstLaunch loadHTMLString:@"" baseURL:[[NSBundle mainBundle] bundleURL]];
    }
    CGRect rect = RECT_IPAD;
    rect.origin.y = rect.size.height;
    [UIView animateWithDuration:0.5
                     animations:^(void){
                         viewForWeb.frame = rect;
                     }
                     completion:^(BOOL finished){
                         [self.view sendSubviewToBack:viewForWeb];
                         
                         
                     }];
    
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
                [webViewFirstLaunch stopLoading];
                [self closeButtonWebClicked:NULL];
                NSString* launchUrl = @"http://tiggly.com/shop";
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString: launchUrl]];
            }
            if ([methodName isEqualToString:@"playWihoutShp"] ) {
                DebugLog(@"playWihoutShp");
                    [webViewFirstLaunch stopLoading];
                    [webViewFirstLaunch loadHTMLString:@"" baseURL:[[NSBundle mainBundle] bundleURL]];
                [self launchHomeViewController];
            }
        }
    }
    return YES;
}
@end
