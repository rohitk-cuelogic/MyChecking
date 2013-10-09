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
#import "MovingView.h"
#import "TDSoundManager.h"
#import "UnlockScreenViewController.h"
#import "TSTempData.h"

@interface TSHomeViewController ()

@end

@implementation TSHomeViewController
@synthesize imgScrollView;
@synthesize bkgImageView;
@synthesize containerView,learnMoreBtn;

UISwipeGestureRecognizer *hmSwpeRecognizer;
BOOL readyToParentScreen, readyToNewsScreen,readyToDeleteThumbnail,readyToLearnMore;
NSMutableArray *swipeTxtArray;
int swipeTxtCnt;

#pragma mark-
#pragma mark======================
#pragma mark View Life Cycles
#pragma mark======================
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    DebugLog(@"");
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

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
    
    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"firstLaunch"];

    
    // Do any additional setup after loading the view from its nib.
    imgScrollView.frame = CGRectMake(0,768 - (RECT_THUMBNAIL_FRAME.size.height + 40), 1024, RECT_THUMBNAIL_FRAME.size.height + 40);
    
    confirmationView.layer.cornerRadius = 20.0f;
    confirmationView.layer.masksToBounds = YES;
    
//    newsBtn.layer.cornerRadius = 20.0f;
//    newsBtn.layer.masksToBounds = YES;
    

    
}

-(void) viewWillAppear:(BOOL)animated{
    DebugLog(@"");
    readyToParentScreen = NO;
    readyToNewsScreen = NO;
    confirmationView.hidden = YES;
    confirmationViewBKG.hidden = YES;
    for(UIView *thumbnail in imgScrollView.subviews){
        [thumbnail removeFromSuperview];
    }
    

    
    if ([[TigglyStampUtils sharedInstance] isAppUnlockedForShapes]) {
        
        newsBtn.hidden = YES;
        newsBtn.userInteractionEnabled = NO;
        
        learnMoreBtn.hidden = YES;
        learnMoreBtn.userInteractionEnabled = NO;
    }
    
    
    forParentsBtn.titleLabel.font = [UIFont fontWithName:APP_FONT_BOLD size:22.0f];
    

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
    
    swipeTxtArray = [[NSMutableArray alloc] initWithObjects:@"RIGHT\nwith 2", @"RIGHT\nwith 2", @"LEFT\nwith 2", @"LEFT\nwith 2", @"UP\nwith 2", @"UP\nwith 2", @"DOWN\nwith 2", @"DOWN\nwith 2", nil];
    
    hmSwpeRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swippedforConfirmation)];
    [self.view addGestureRecognizer:hmSwpeRecognizer];
    

    NSArray *arr2 = [[TigglyStampUtils sharedInstance] getAllTempDataFromFolder:FOLDER_SUBSCRIPTION_DATA];
    for(TSTempData *td in arr2){
        DebugLog(@"Email : %@",td.subscriptionEmailId);
    }

}

-(void) viewDidDisappear:(BOOL)animated{
    DebugLog(@"");
    
    [self.view removeGestureRecognizer:hmSwpeRecognizer];
}


- (void)didReceiveMemoryWarning {
    DebugLog(@"");
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

-(void) addRipples {
    
}


-(void) animationDidStart:(CAAnimation *)anim {
    DebugLog(@"");
    
}

-(void) animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    DebugLog(@"");
 
}



-(void) addMovingObjects{
    DebugLog(@"");
    arrMovingObj = [[NSMutableArray alloc] initWithCapacity:1];
    NSString *strImgName;
    CGRect rect;
    for(int i =0; i<4;i++) {
        switch (i) {
            case 0:
                strImgName = @"circle_shape";
                rect = CGRectMake(70, 70, 200, 200);
                break;
                
            case 1:
                strImgName = @"triangle_shape";
                rect = CGRectMake(800, 250, 200, 200);
                break;
                
            case 2:
                strImgName = @"square_shape";
                rect = CGRectMake(512, 90, 200, 200);
                break;
                
            case 3:
                strImgName = @"star_shape";
                rect = CGRectMake(200, 300, 200, 200);
                break;
                
            default:
                break;
        }
      
        MovingView *movingView = [[MovingView alloc] initWithFrame:rect withImageName:strImgName];
        [self.containerView addSubview:movingView];
        [arrMovingObj addObject:movingView];
        
    }
        
}

-(void) moveObjects : (NSTimer*)theTimer {
    DebugLog(@"");

}

#pragma mark-
#pragma mark======================
#pragma mark Game Handlers
#pragma mark======================

-(void) loadAllThumbnailsData {
    DebugLog(@"");
    //loads all the saved images into the scroll view
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *path = [[TigglyStampUtils sharedInstance]getDocumentDirPath];
    NSArray *directoryContents = [fileManager contentsOfDirectoryAtPath:path error:NULL];
    
    //revers the array
    directoryContents = [[directoryContents reverseObjectEnumerator] allObjects];
    int xPos = 10;
    for (NSString *file in directoryContents) {
        if([file hasPrefix:@"TigglyStamp"] && [[[file lastPathComponent] pathExtension] isEqualToString:@"png"]){
            DebugLog(@"Image Name : %@",[path stringByAppendingPathComponent:file]);
            UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfFile:[path stringByAppendingPathComponent:file]]];
            
            UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(xPos, 0, RECT_THUMBNAIL_FRAME.size.width, RECT_THUMBNAIL_FRAME.size.height)];
            imgView.image = [UIImage imageNamed:@"frame.png"];
            [imgScrollView addSubview:imgView];
            
            TDThumbnailView *actualImage = [[TDThumbnailView alloc] initWithFrame:CGRectMake(xPos + 10, 30, RECT_ACTUAL_THUMBNAIL_IMAGE_FRAME.size.width, RECT_ACTUAL_THUMBNAIL_IMAGE_FRAME.size.height) withImage:image imageName:file];
            //actualImage.delegate = self;
            [imgScrollView addSubview:actualImage];
            
            xPos = xPos + RECT_THUMBNAIL_FRAME.size.width + 60;
            [imgScrollView setContentSize:CGSizeMake(xPos, 0)];
            
        }
    }
    
}

-(void) loadThumbnails {
    DebugLog(@"");
  
    NSArray *allImageFiles = [[TigglyStampUtils sharedInstance] getAllImagesAndMovies];
    NSMutableArray *imageFiles = [[NSMutableArray alloc] initWithCapacity:1];
    
    for(NSString *file in allImageFiles){
        if(![file hasSuffix:[NSString stringWithFormat:@"%@.png",STR_WITH_BORDER]]){
            [imageFiles addObject:file];
        }
    }
    
    NSArray *allFiles = [NSArray arrayWithArray:imageFiles];
    allFiles = [[allFiles reverseObjectEnumerator] allObjects];
   
    int xPos = 20;
    for (NSString *file in allFiles) {
            
        ThumbnailView *thumbnail = [[ThumbnailView alloc] initWithFrame:CGRectMake(xPos,10, RECT_THUMBNAIL_FRAME.size.width, RECT_THUMBNAIL_FRAME.size.height) withThumbnailImagePath:file];
        thumbnail.delegate = self;
        [imgScrollView addSubview:thumbnail];
        [allThumbnails addObject:thumbnail];
        
        xPos = xPos + RECT_THUMBNAIL_FRAME.size.width + 60;
        [imgScrollView setContentSize:CGSizeMake(xPos, 0)];
    }
}

-(void) reloadThumbnails {
    DebugLog(@"");

    int xPos = 20;
    for (ThumbnailView *thumbnail in allThumbnails) {
        
        thumbnail.frame =  CGRectMake(xPos,10, RECT_THUMBNAIL_FRAME.size.width, RECT_THUMBNAIL_FRAME.size.height);
        [imgScrollView addSubview:thumbnail];
        
        xPos = xPos + RECT_THUMBNAIL_FRAME.size.width + 60;
        [imgScrollView setContentSize:CGSizeMake(xPos, 0)];
    }
}

-(void)swippedforConfirmation{
    if(readyToParentScreen){
        DebugLog(@"");
        confirmationView.hidden = YES;
        confirmationViewBKG.hidden = YES;
        forParentsBtn.alpha = 1;
        newsBtn.alpha = 1;
        playBtn.alpha = 1;
        imgScrollView.alpha = 1;
        
        forParentsBtn.enabled = YES;
        newsBtn.enabled = YES;
        playBtn.enabled = YES;
        learnMoreBtn.enabled = YES;
        [imgScrollView setUserInteractionEnabled:YES];
        readyToParentScreen = NO;
        
        [playBtnTimer invalidate];
        ParentScreenViewController *parentViewCOntroller = [[ParentScreenViewController alloc] initWithNibName:@"ParentScreenViewController" bundle:nil withHomeView:self];
        [self.navigationController pushViewController:parentViewCOntroller animated:YES];
    }
    
    if(readyToNewsScreen){
        DebugLog(@"");
        confirmationView.hidden = YES;
        confirmationViewBKG.hidden = YES;
        forParentsBtn.alpha = 1;
        newsBtn.alpha = 1;
        playBtn.alpha = 1;
        imgScrollView.alpha = 1;
        
        forParentsBtn.enabled = YES;
        playBtn.enabled = YES;
        newsBtn.enabled = YES;
        learnMoreBtn.enabled = YES;
        [imgScrollView setUserInteractionEnabled:YES];        
        readyToNewsScreen = NO;
        
#ifdef GOOGLE_ANALYTICS_START
        NSMutableDictionary *event =
        [[GAIDictionaryBuilder createEventWithCategory:@"Button Click"
                                                action:@"Button Clicked"
                                                 label:@"Unlock for shapes"
                                                 value:nil] build];
        [[GAI sharedInstance].defaultTracker send:event];
        [[GAI sharedInstance] dispatch];
        
#else
        
#endif

        
        [playBtnTimer invalidate];
        UnlockScreenViewController *unlockScreen = [[UnlockScreenViewController alloc] initWithNibName:@"UnlockScreenViewController" bundle:nil entryFrom:kScreenEntryFromHomeView withHomeView:self];
         [self.navigationController pushViewController:unlockScreen animated:YES];
    }
    
    if(readyToDeleteThumbnail) {
        readyToDeleteThumbnail = NO;
        for(ThumbnailView *thumbnail in allThumbnails) {
            [thumbnail startAnimation];
        }
        
        confirmationView.hidden = YES;
        confirmationViewBKG.hidden = YES;
        forParentsBtn.alpha = 1;
        newsBtn.alpha = 1;
        playBtn.alpha = 1;
        imgScrollView.alpha = 1;
        bkgLayer.opacity  =1.0;
        
        forParentsBtn.enabled = YES;
        playBtn.enabled = YES;
        newsBtn.enabled = YES;
         learnMoreBtn.enabled = YES;
        [imgScrollView setUserInteractionEnabled:YES];

    }
    
    if(readyToLearnMore) {
        confirmationView.hidden = YES;
        confirmationViewBKG.hidden = YES;
        forParentsBtn.alpha = 1;
        newsBtn.alpha = 1;
        playBtn.alpha = 1;
        imgScrollView.alpha = 1;
        
        forParentsBtn.enabled = YES;
        playBtn.enabled = YES;
        newsBtn.enabled = YES;
        learnMoreBtn.enabled = YES;
        [imgScrollView setUserInteractionEnabled:YES];
        readyToLearnMore = NO;
        
        
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

        
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://tiggly.myshopify.com/products/tiggly-shapes"]];
    }
}

-(void) showConfirmationView{
    DebugLog(@"");
    bkgLayer.opacity = 0.0;
    swipeTxtCnt = arc4random()%7;
    
    [txtView setText:[NSString stringWithFormat:@"To continue,\nswipe %@ fingers.", [swipeTxtArray objectAtIndex:swipeTxtCnt]]];
    txtView.font = [UIFont fontWithName:APP_FONT_BOLD size:35.0f];
    txtView.textColor = [UIColor whiteColor];
    
    switch (swipeTxtCnt) {
        case 0:
            [hmSwpeRecognizer setDirection: UISwipeGestureRecognizerDirectionRight];
            [hmSwpeRecognizer setNumberOfTouchesRequired: 2];
            break;
        case 1:
            [hmSwpeRecognizer setDirection: UISwipeGestureRecognizerDirectionRight];
            [hmSwpeRecognizer setNumberOfTouchesRequired: 2];
            break;
        case 2:
            [hmSwpeRecognizer setDirection: UISwipeGestureRecognizerDirectionLeft];
            [hmSwpeRecognizer setNumberOfTouchesRequired: 2];
            break;
        case 3:
            [hmSwpeRecognizer setDirection: UISwipeGestureRecognizerDirectionLeft];
            [hmSwpeRecognizer setNumberOfTouchesRequired: 2];
            break;
        case 4:
            [hmSwpeRecognizer setDirection: UISwipeGestureRecognizerDirectionUp];
            [hmSwpeRecognizer setNumberOfTouchesRequired: 2];
            break;
        case 5:
            [hmSwpeRecognizer setDirection: UISwipeGestureRecognizerDirectionUp];
            [hmSwpeRecognizer setNumberOfTouchesRequired: 2];
            break;
        case 6:
            [hmSwpeRecognizer setDirection: UISwipeGestureRecognizerDirectionDown];
            [hmSwpeRecognizer setNumberOfTouchesRequired: 2];
            break;
        case 7:
            [hmSwpeRecognizer setDirection: UISwipeGestureRecognizerDirectionDown];
            [hmSwpeRecognizer setNumberOfTouchesRequired: 2];
            break;
        default:
            break;
    }
    
    confirmationView.hidden = NO;
    confirmationViewBKG.hidden = NO;
    [self.view bringSubviewToFront:confirmationViewBKG];
    [self.view bringSubviewToFront:confirmationView];
    [confirmationView  bringSubviewToFront:notConfirm];
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
    [self.navigationController pushViewController:hmView animated:YES];
}

-(IBAction)goToParentsScreen:(id)sender{
    DebugLog(@"");
    readyToParentScreen = YES;
    
    forParentsBtn.alpha = 0.3;
    newsBtn.alpha = 0.3;
    playBtn.alpha = 0.3;
    imgScrollView.alpha = 0.3;
    bkgLayer.opacity = 0.0;
    
    forParentsBtn.enabled = NO;
    newsBtn.enabled = NO;
    playBtn.enabled = NO;
    learnMoreBtn.enabled = NO;
    [imgScrollView setUserInteractionEnabled:NO];
    
    [self showConfirmationView];
}

-(IBAction)goToNewsScreen:(id)sender{
    DebugLog(@"");
    readyToNewsScreen = YES;
    
    forParentsBtn.alpha = 0.3;
    newsBtn.alpha = 0.3;
    playBtn.alpha = 0.3;
    imgScrollView.alpha = 0.3;
    bkgLayer.opacity = 0.0;
    
    forParentsBtn.enabled = NO;
    playBtn.enabled = NO;
    newsBtn.enabled = NO;
    learnMoreBtn.enabled = NO;
    [imgScrollView setUserInteractionEnabled:NO];
    
    [self showConfirmationView];
}

-(IBAction)noConfirmation:(id)sender{
    DebugLog(@"");
    readyToParentScreen = NO;
    readyToNewsScreen = NO;
    readyToDeleteThumbnail = NO;
    readyToLearnMore = NO;
    
    isThumbnailLongPressed = NO;
    
    confirmationView.hidden = YES;
    confirmationViewBKG.hidden = YES;
    forParentsBtn.alpha = 1;
    newsBtn.alpha = 1;
    playBtn.alpha = 1;
    imgScrollView.alpha = 1;
    bkgLayer.opacity = 1.0;
    
    forParentsBtn.enabled = YES;
    newsBtn.enabled = YES;
    playBtn.enabled = YES;
    learnMoreBtn.enabled = YES;
    [imgScrollView setUserInteractionEnabled:YES];
}

-(IBAction)actionLearnMore {
    DebugLog(@"");
    
    readyToLearnMore = YES;;
    
    forParentsBtn.alpha = 0.3;
    newsBtn.alpha = 0.3;
    playBtn.alpha = 0.3;
    imgScrollView.alpha = 0.3;
    bkgLayer.opacity = 0.0;
    
    forParentsBtn.enabled = NO;
    playBtn.enabled = NO;
    newsBtn.enabled = NO;
    learnMoreBtn.enabled = NO;
    [imgScrollView setUserInteractionEnabled:NO];
    
    [self showConfirmationView];

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
        [self noConfirmation:nil];
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
    thumbnail.transform = CGAffineTransformIdentity;
    [UIView animateWithDuration:0.2 animations:^{
        thumbnail.alpha = 0;
    
    } completion:^(BOOL finished) {
        
        [thumbnail removeFromSuperview];
         [allThumbnails removeObject:thumbnail];
        
        
        for(ThumbnailView *thumbnail in allThumbnails) {
            [thumbnail removeFromSuperview];
        }
        
//        [[TDSoundManager sharedManager] playSound:@"trashsweep" withFormat:@"mp3"];
        
        [self reloadThumbnails];
    }];
    

}


-(void) thumbnailViewTapped:(ThumbnailView *)thumbnail{
    DebugLog(@"");
    
    [playBtnTimer invalidate];
    
    DebugLog(@"Tapped Thumbnail Name: %@",thumbnail.imageName);
    
    NSString *iName = @"";
    
    if([[thumbnail.imageName pathExtension] isEqualToString:@"mov"]){
        iName = thumbnail.imageName;
    }else{
        iName = thumbnail.imageNameWithBorder;
    }
    
    TSThumbnailEditController *thumbnailEditor = [[TSThumbnailEditController alloc] initWithNibName:@"TSThumbnailEditController" bundle:nil withImage:thumbnail.actulaImage imageName:iName withHomeView:self];
    [self.navigationController pushViewController:thumbnailEditor animated:YES];
    
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

@end
