//
//  TSHomeViewController.m
//  ivyApplication
//
//  Created by Dattatraya Anarase on 19/07/13.
//
//

#import "TSHomeViewController.h"
#import "TSThumbnailEditController.h"
#import "SeasonSelectionViewController.h"
#import "ParentScreenViewController.h"
#import "TDSoundManager.h"
#import "UnlockScreenViewController.h"
#import "TSTempData.h"

@interface TSHomeViewController ()

@end

@implementation TSHomeViewController
@synthesize imgScrollView;
@synthesize bkgImageView;
@synthesize containerView,learnMoreBtn;

BOOL readyToParentScreen, readyToNewsScreen,readyToDeleteThumbnail,readyToLearnMore;
NSArray *allImageFiles;

#pragma mark -
#pragma mark =======================================
#pragma mark Init
#pragma mark =======================================

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    DebugLog(@"");
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

#pragma mark -
#pragma mark =======================================
#pragma mark Memory Management
#pragma mark =======================================


- (void)didReceiveMemoryWarning {
    DebugLog(@"");
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) nullifyAllData{
    DebugLog(@"");
    
    if(diskImages != nil) {
        [diskImages removeAllObjects];
        diskImages = nil;
    }
    
    if(allThumbnails != nil) {
        [allThumbnails removeAllObjects];
        allThumbnails = nil;
    }
    
    if(playBtnTimer != nil){
        [playBtnTimer invalidate];
        playBtnTimer = nil;
    }
    
    if(bkgLayer != nil){
        [bkgLayer removeFromSuperlayer];
        bkgLayer = nil;
    }
    

}

#pragma mark-
#pragma mark======================
#pragma mark View Life Cycles
#pragma mark======================

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
    
    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"firstLaunch"];

    
    // Do any additional setup after loading the view from its nib.
    imgScrollView.frame = CGRectMake(0,768 - (RECT_THUMBNAIL_FRAME.size.height + 40), 1024, RECT_THUMBNAIL_FRAME.size.height + 40);
    
}

-(void) viewWillAppear:(BOOL)animated{
    DebugLog(@"");
    readyToParentScreen = NO;
    readyToNewsScreen = NO;
    confirmationView.hidden = YES;
    confirmationViewBKG.hidden = YES;
    
    allImageFiles = [[TigglyStampUtils sharedInstance] getAllImagesAndMovies];
    
    for(UIView *thumbnail in imgScrollView.subviews){
        [thumbnail removeFromSuperview];
    }
    
    lblUnlockWithShapes.hidden = YES;
    lblLearnMore.hidden = YES;
    
    newsBtn.hidden = YES;
    newsBtn.userInteractionEnabled = NO;
    
    learnMoreBtn.hidden = YES;
    learnMoreBtn.userInteractionEnabled = NO;
    
    
    if ([[TigglyStampUtils sharedInstance] isAppUnlockedForShapes]) {
    
        
    }else{
        float fontSize = 0.0;
        if([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"English"]){
            fontSize = 18.0f;
        }else  if([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"Russian"]){
            fontSize = 14.0f;
        }else{
            fontSize = 16.0f;
        }
        
        lblUnlockWithShapes.text =[[TigglyStampUtils sharedInstance] getLocalisedStringForKey:@"kUnlockwithTigglyshapes"];
        lblUnlockWithShapes.font = [UIFont fontWithName:APP_FONT_BOLD size:fontSize];
       
        if([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"Italian"]){
            fontSize = 10.0f;
        }
        lblLearnMore.text =[[TigglyStampUtils sharedInstance] getLocalisedStringForKey:@"kLearnmore"];
        lblLearnMore.font = [UIFont fontWithName:APP_FONT_BOLD size:fontSize];
    }
    
    float fontSize = 0.0;
    if([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"English"]){
        fontSize = 24.0f;
    }else{
        fontSize = 18.0f;
    }
    forParentsBtn.titleLabel.font = [UIFont fontWithName:APP_FONT_BOLD size:fontSize];
    [forParentsBtn setTitle:[[TigglyStampUtils sharedInstance] getLocalisedStringForKey:@"kForParents"] forState:UIControlStateNormal];
}

- (void)viewDidAppear:(BOOL)animated {
    DebugLog(@"");
    
    isThumbnailLongPressed = NO;
    allThumbnails = [[NSMutableArray alloc] initWithCapacity:1];

    [self loadThumbnails];

    bkgLayer=[CALayer layer];
    bkgLayer.name = @"btnLayer";
    bkgLayer.frame = CGRectMake(360,210, 300, 300);
    bkgLayer.opacity = 1.0;
    [self.view.layer addSublayer:bkgLayer];
    
    isFirstTimePlay = YES;
    playBtnTimer = [NSTimer scheduledTimerWithTimeInterval:2.0 target:self selector:@selector(animatePlayButton) userInfo:nil repeats:YES];
    

    
    NSArray *arr2 = [[TigglyStampUtils sharedInstance] getAllTempDataFromFolder:FOLDER_SUBSCRIPTION_DATA];
    for(TSTempData *td in arr2){
        DebugLog(@"Email : %@",td.subscriptionEmailId);
    }

    if([[TigglyStampUtils sharedInstance] isNetworkAvailable])
    {
        [[ServerController sharedInstance] fetchNewsFeedCountWithService:self];
        
    }
}

-(void) viewDidDisappear:(BOOL)animated{
    DebugLog(@"");

}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return UIInterfaceOrientationIsLandscape(interfaceOrientation);
}

-(BOOL)shouldAutorotate {
    DebugLog(@"");
    return YES;
}

-(NSUInteger)supportedInterfaceOrientations {
    DebugLog(@"");
    return UIInterfaceOrientationMaskLandscape;
}

-(void)initializeLabels{
     DebugLog(@"");
    float fontSize = 0.0;
    if([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"English"]){
        fontSize = 18.0f;
    }else  if([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"Russian"]){
        fontSize = 14.0f;
    }else{
        fontSize = 16.0f;
    }
    
    lblUnlockWithShapes.text =[[TigglyStampUtils sharedInstance] getLocalisedStringForKey:@"kUnlockwithTigglyshapes"];
    lblUnlockWithShapes.font = [UIFont fontWithName:APP_FONT_BOLD size:fontSize];
    
    if([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"Italian"]){
        fontSize = 10.0f;
    }
    lblLearnMore.text =[[TigglyStampUtils sharedInstance] getLocalisedStringForKey:@"kLearnmore"];
    lblLearnMore.font = [UIFont fontWithName:APP_FONT_BOLD size:fontSize];
    
    if([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"English"]){
        fontSize = 24.0f;
    }else{
        fontSize = 18.0f;
    }
    forParentsBtn.titleLabel.font = [UIFont fontWithName:APP_FONT_BOLD size:fontSize];
    [forParentsBtn setTitle:[[TigglyStampUtils sharedInstance] getLocalisedStringForKey:@"kForParents"] forState:UIControlStateNormal];
}
#pragma mark -
#pragma mark =======================================
#pragma mark Animation
#pragma mark =======================================

-(void) animatePlayButton {
    DebugLog(@"");

    
    CABasicAnimation *animation4a = nil;
    animation4a = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    [animation4a setToValue:[NSNumber numberWithDouble:0.8]];
    [animation4a setFromValue:[NSNumber numberWithDouble:1]];
    [animation4a setAutoreverses:YES];
    [animation4a setDuration:1.0f];
    [animation4a setBeginTime:0.0f];
    [animation4a setRepeatCount:1.0];
    animation4a.delegate = self;
    [playBtn.layer addAnimation:animation4a forKey:@"transform.scale"];
    

    double delayInSeconds = 1.2;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        
        NSMutableArray *arr = [[NSMutableArray alloc] initWithCapacity:1];
        
        for(int i = 2 ; i <= 5 ; i++ ) {
            NSString *imgName = [NSString stringWithFormat:@"play_btn_circle_%d.png",i];
            DebugLog(@"Img Name : %@",imgName);
            UIImage *img =  [UIImage imageNamed:imgName];
            [arr addObject:(id) img.CGImage];
            
        }
        
        CAKeyframeAnimation *animation2 = [CAKeyframeAnimation animationWithKeyPath: @"contents"];
        animation2.calculationMode = kCAAnimationDiscrete;
        animation2.beginTime = 0.0;
        animation2.duration =1.0;
        animation2.repeatCount = 1.0;
        animation2.values = arr;
        animation2.removedOnCompletion = YES;
        [bkgLayer addAnimation: animation2 forKey: @"contents"];
    });
    
}

-(void) animationDidStart:(CAAnimation *)anim {
    DebugLog(@"");
    
}

-(void) animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    DebugLog(@"");
 
}

#pragma mark-
#pragma mark======================
#pragma mark Game Handlers
#pragma mark======================


-(void) loadThumbnails {
    DebugLog(@"");
  
    DebugLog(@"allImageFiles : %@",allImageFiles);
    NSArray *allFiles = [NSArray arrayWithArray:allImageFiles];
    allFiles = [[allFiles reverseObjectEnumerator] allObjects];
    
    int xPos = 30;
    for (NSString *file in allFiles) {
            
        ThumbnailView *thumbnail = [[ThumbnailView alloc] initWithFrame:CGRectMake(xPos,20, RECT_THUMBNAIL_FRAME.size.width, RECT_THUMBNAIL_FRAME.size.height) withThumbnailImagePath:file];
        thumbnail.delegate = self;
        [imgScrollView addSubview:thumbnail];
        [allThumbnails addObject:thumbnail];
        
        xPos = xPos + RECT_THUMBNAIL_FRAME.size.width + 20;
        [imgScrollView setContentSize:CGSizeMake(xPos, 0)];
        
    }
    
}


-(void) reloadThumbnails {
    DebugLog(@"");

    int xPos = 30;
    for (ThumbnailView *thumbnail in allThumbnails) {
        
        thumbnail.frame =  CGRectMake(xPos,20, RECT_THUMBNAIL_FRAME.size.width, RECT_THUMBNAIL_FRAME.size.height);
        [imgScrollView addSubview:thumbnail];
        
        xPos = xPos + RECT_THUMBNAIL_FRAME.size.width + 20;
        [imgScrollView setContentSize:CGSizeMake(xPos, 0)];
    }
}

-(void)swippedforConfirmation{
    DebugLog(@"");
    
    if(readyToParentScreen){
        readyToParentScreen = NO;
        [playBtnTimer invalidate];
        ParentScreenViewController *parentViewCOntroller = [[ParentScreenViewController alloc] initWithNibName:@"ParentScreenViewController" bundle:nil withHomeView:self];
        [self.navigationController pushViewController:parentViewCOntroller animated:NO];
        [self nullifyAllData];
        
    }
    
    if(readyToNewsScreen){
        DebugLog(@"");
        readyToNewsScreen = NO;
        
#ifdef GOOGLE_ANALYTICS_START
        NSMutableDictionary *event =
        [[GAIDictionaryBuilder createEventWithCategory:@"Button Click"
                                                action:@"Button Clicked"
                                                 label:@"Unlock for shapes"
                                                 value:nil] build];
        [[GAI sharedInstance].defaultTracker send:event];
        [[GAI sharedInstance] dispatch];
#endif

        
        [playBtnTimer invalidate];
        UnlockScreenViewController *unlockScreen = [[UnlockScreenViewController alloc] initWithNibName:@"UnlockScreenViewController" bundle:nil entryFrom:kScreenEntryFromHomeView withHomeView:self];
         [self.navigationController pushViewController:unlockScreen animated:NO];
         [self nullifyAllData];
        
    }
    
    if(readyToDeleteThumbnail) {
        readyToDeleteThumbnail = NO;
        for(ThumbnailView *thumbnail in allThumbnails) {
            [thumbnail startAnimation];
        }
    }
    
    if(readyToLearnMore) {
        readyToLearnMore = NO;
        
#ifdef GOOGLE_ANALYTICS_START
        NSMutableDictionary *event =
        [[GAIDictionaryBuilder createEventWithCategory:@"About tiggly"
                                                action:@"Learn more"
                                                 label:@"Learn more"
                                                 value:nil] build];
        [[GAI sharedInstance].defaultTracker send:event];
        [[GAI sharedInstance] dispatch];
#endif

        
//        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://tiggly.myshopify.com/products/tiggly-shapes"]];
         [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://tiggly.com/shop"]];
    }
}

-(void) showConfirmationView{
    DebugLog(@"");
   
    gestureView = [[GestureConfirmationView alloc] initWithFrame:CGRectMake(0, 0, 1024, 768)];
    gestureView.delegate = self;
    gestureView.layer.zPosition = 1500;
    [self.view addSubview:gestureView];

}

-(void) showConfirmationViewWithLangSelOption{
    DebugLog(@"");
    
    gestureView = [[GestureConfirmationView alloc] initLoadLanguageOptionWithFrame:CGRectMake(0, 0, 1024, 768)];
    gestureView.delegate = self;
    [self.view addSubview:gestureView];
    [self.view bringSubviewToFront:gestureView];
    
}

#pragma mark -
#pragma mark =======================================
#pragma mark Service Controller Delegate Method
#pragma mark =======================================
- (void) newsCountDataRetrived:(NSDictionary *) dict
{
    if (dict!=nil) {
        
        //        int newsCount = [[dict objectForKey:@"unread_news_count"] integerValue];
        //        if (newsCount!=0) {
        //            [[TDGameUtils sharedManager] setNewsCount:newsCount];
        //        }
        //
        //        if ([[TDGameUtils sharedManager] getNewsCount]!=0) {
        //        }else{
        //
        //            [[TDGameUtils sharedManager] setNewsCount:0];
        //
        //        }
        NSDictionary *storedDict=[self readJsonDictFromDocumentDirectoryWithFileName:JSON_RESPONSE];
        
        if (![[dict objectForKey:@"unread_news_count"] isEqualToString:[storedDict objectForKey:@"unread_news_count"]])
        {
            [self writeJsonInDocumentDirectory:dict saveFileWithName:JSON_RESPONSE];
            
            [[ServerController sharedInstance] downloadHTMLFileAtPath:[dict objectForKey:@"zip_path"] service:self];
        }
        else
        {
            
            NSArray *arrData=[[dict objectForKey:@"last_news_icon"] componentsSeparatedByString:@"/"];
            NSString *filePth =[[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:[NSString stringWithFormat:@"usercontent/%@",[arrData objectAtIndex:[arrData count] -1]]];//@"usercontent/index.html"
            
            btnNews.hidden = NO;
            NSData *data = [NSData dataWithContentsOfFile:filePth];
            UIImage *image = [UIImage imageWithData:data];
            [btnNews setImage:image forState:UIControlStateNormal];
            //[self performBtnNewsAnimation];
            
        }
        
        
    }else{
        
        //        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:APPLICATION_NAME message:@"News count are not available" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        //        [alert show];
    }
}
#pragma mark-
#pragma mark======================
#pragma mark IBActions
#pragma mark======================

-(void)playGame:(id)sender{
    DebugLog(@"");
    
    [[TDSoundManager sharedManager] playSound:@"Blop_Sound_effect" withFormat:@"mp3"];
    [playBtnTimer invalidate];
    SeasonSelectionViewController *hmView = [[SeasonSelectionViewController alloc]initWithNibName:@"SeasonSelectionViewController" bundle:nil withHomeView:self];
    [self.navigationController pushViewController:hmView animated:NO];
    [self nullifyAllData];
}

-(IBAction)goToParentsScreen:(id)sender{
    DebugLog(@"");
    readyToParentScreen = YES;
    [self showConfirmationViewWithLangSelOption];
}

-(IBAction)actionLearnMore {
    DebugLog(@"");
    readyToLearnMore = YES;
    [self showConfirmationView];
    
}

-(IBAction)goToNewsScreen:(id)sender{
    DebugLog(@"");
    readyToNewsScreen = YES;
    [self showConfirmationView];
}

-(IBAction)actionForNews:(id)sender
{

}

#pragma mark -
#pragma mark =======================================
#pragma mark Touch Hnadling
#pragma mark =======================================

-(void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    DebugLog(@"");
    
    for(ThumbnailView *thumbnail in allThumbnails) {
        [thumbnail stopAnimation];
    }
    isThumbnailLongPressed = NO;
    
    double delayInSeconds = 0.3;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        [gestureView removeFromSuperview];
        gestureView = nil;
        
        if(isThumbnailLongPressed){
            isThumbnailLongPressed = NO;
        }
        
        if(readyToLearnMore){
            readyToLearnMore = NO;
        }
        
        if(readyToNewsScreen){
            readyToNewsScreen = NO;
        }
        
        if(readyToParentScreen){
            readyToParentScreen = NO;
        }
    });
}

#pragma mark-
#pragma mark======================
#pragma mark thumbnailView Delegates
#pragma mark======================

-(void) thumbnailViewCloseBtnClicked:(ThumbnailView *)thumbnail {
    DebugLog(@"");
    DebugLog(@"ImageName : %@",thumbnail.imageName);
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    [fileManager removeItemAtPath:thumbnail.imageName error:nil];
    [fileManager removeItemAtPath:[[TigglyStampUtils sharedInstance] getMovieImagePathForMovieName:thumbnail.imageName] error:nil];
    thumbnail.transform = CGAffineTransformIdentity;
    [UIView animateWithDuration:0.2 animations:^{
        thumbnail.alpha = 0;
    
    } completion:^(BOOL finished) {
        
        [thumbnail removeFromSuperview];
         [allThumbnails removeObject:thumbnail];
        
        
        for(ThumbnailView *thumbnail in allThumbnails) {
            [thumbnail removeFromSuperview];
        }
        
        [self reloadThumbnails];
    }];
    

}


-(void) thumbnailViewTapped:(ThumbnailView *)thumbnail{
    DebugLog(@"");
    
    [playBtnTimer invalidate];
    
    [[ServerController sharedInstance] sendEvent:@"tab_goto_gallery" withEventValue:@"yes" withServiceName:SERVICE_URL_SET_BEHAVIOURCOUNT];

    
    TSThumbnailEditController *thumbnailEditor = [[TSThumbnailEditController alloc] initWithNibName:@"TSThumbnailEditController" bundle:nil withImage:thumbnail.actulaImage imageName:thumbnail.imageName withHomeView:self];
    [self.navigationController pushViewController:thumbnailEditor animated:NO];
    [self nullifyAllData];
    
}

-(void) thumbnailViewLongPressed {
    DebugLog(@"");
    DebugLog(@"All Thumbnail View Count : %d",allThumbnails.count);
    if(!isThumbnailLongPressed) {
        isThumbnailLongPressed = YES;
       
        readyToDeleteThumbnail = YES;
        [self showConfirmationView];
        
    }
    
}

#pragma mark -
#pragma mark =======================================
#pragma mark gestureView Protocol
#pragma mark =======================================

-(void) gestureViewOnGestureConfirmed:(GestureConfirmationView *)gView {
    DebugLog(@"");
    
    [self swippedforConfirmation];
    if(gestureView != nil) {
        [gestureView removeFromSuperview];
        gestureView = nil;
    }
}

-(void) gestureViewOnCancel:(GestureConfirmationView *)gView {
    DebugLog(@"");
    
    if(isThumbnailLongPressed){
        isThumbnailLongPressed = NO;
    }
    
    if(readyToLearnMore){
        readyToLearnMore = NO;
    }
    
    if(readyToNewsScreen){
        readyToNewsScreen = NO;
    }
    
    if(readyToParentScreen){
        readyToParentScreen = NO;
    }
}

-(void) gestureViewOnChangeLanguage {
    DebugLog(@"");
    [self initializeLabels];
}

-(void) writeJsonInDocumentDirectory:(NSDictionary *)dict saveFileWithName:(NSString *)name
{
    // Get path to documents directory
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
                                                         NSUserDomainMask, YES);
    if ([paths count] > 0)
    {
        // Path to save dictionary
        NSString  *dictPath = [[paths objectAtIndex:0]
                               stringByAppendingPathComponent:name];
        // Write dictionary
        [dict writeToFile:dictPath atomically:YES];
    }
    
}
-(NSDictionary *) readJsonDictFromDocumentDirectoryWithFileName:(NSString *)name
{
    // Get path to documents directory
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
                                                         NSUserDomainMask, YES);
    if ([paths count] > 0)
    {
        // Path to save dictionary
        NSString  *dictPath = [[paths objectAtIndex:0]
                               stringByAppendingPathComponent:name];
        
        // Read both back in new collections
        NSDictionary *dictFromFile = [NSDictionary dictionaryWithContentsOfFile:dictPath];
        return dictFromFile;
    }
    return nil;
}
-(void)loadHTMLWebView
{
    NSString *filePth =[[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:@"usercontent/index.html"];
    NSString* htmlString = [NSString stringWithContentsOfFile:filePth encoding:NSUTF8StringEncoding error:nil];
    [_webView loadHTMLString:htmlString baseURL:[NSURL fileURLWithPath:filePth]];
}
-(void)performBtnNewsAnimation
{
    
    [UIView animateWithDuration:0.2
                     animations:^(void){
                         btnNews.frame = CGRectMake(890, 0, 120, 120);
                     }
                     completion:^(BOOL finished){
                         
                     }];
    
    CABasicAnimation *bounceAnimation =
    [CABasicAnimation animationWithKeyPath:@"position.y"];
    bounceAnimation.duration = 0.2;
    bounceAnimation.fromValue = [NSNumber numberWithInt:0];
    bounceAnimation.toValue = [NSNumber numberWithInt:40];
    bounceAnimation.repeatCount = 2;
    bounceAnimation.autoreverses = YES;
    bounceAnimation.fillMode = kCAFillModeForwards;
    bounceAnimation.removedOnCompletion = NO;
    bounceAnimation.additive = YES;
    [btnNews.layer addAnimation:bounceAnimation forKey:@"bounceAnimation"];
}
@end
