//
//  StampViewController.m
//  TigglyStamp
//
//  Created by Sachin Patil on 10/09/13.
//  Copyright (c) 2013 cuelogic. All rights reserved.
//

#import "StampViewController.h"
#import "TSHomeViewController.h"


#define TAG_RIGHT_TICK_BTN 1
#define TAG_CURL_BTN 2
#define TAG_CURL_CONFIRMED_BTN 3


@interface StampViewController (){
    AVAudioRecorder *recorder;
}
@end

@implementation StampViewController{
    NSString *currentImagePath;
    BOOL isSharingViewDisplayed;
}

@synthesize facebook;
@synthesize permissions;

int min = 0;
int sec= 0;

#pragma mark -
#pragma mark =======================================
#pragma mark Synthesize
#pragma mark =======================================

@synthesize rainbowAnimationView;
@synthesize shapes;
@synthesize fruitObjectArray;
@synthesize pointComparison;
@synthesize multiTouchForFruitObject;
@synthesize multiTouchForTouchView;
@synthesize garbageCan;
@synthesize cameraButton;
@synthesize videoButton,curlConfirmedButton;
@synthesize isWithShape,introView,RigthTickButton,curlButton,mainView,backView, viewForCurl;
@synthesize screenCapture;
@synthesize isCameraClick;
@synthesize homeButton;
@synthesize curlViewImage,backViewImage;
@synthesize btnView,lblTimer;

#pragma mark -
#pragma mark =======================================
#pragma mark Private Variables
#pragma mark =======================================

NSString *shapeToDraw;
NSString * prevShape;
bool shouldShapeDetected = YES;
float centerX,centerY;
int numOfTouchPts;
UITouchVerificationView * touchView;
int movedObjectAtTime;
NSTimer *showSeasonsTimer;
NSTimer *unCurlTimer;
NSTimer *tickBtnTimer;
NSString *shapeSoundToPlay;
NSTimer *shapeSoundTimer;
int countShapeSound;
UIImageView *tempImgView;
NSMutableArray   *arrPhysicalShapes;
NSTimer *videoTimer;

XBPageCurlView *pageCurlView;
XBSnappingPoint *bottomSnappingPoint;
BOOL boolIsPageCurled, boolIsTouchMoved;

#pragma mark -
#pragma mark =======================================
#pragma mark Init
#pragma mark =======================================


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil withSceneType:(SceneType) scene withHomeView:(TSHomeViewController *) homeView{
    DebugLog(@"");
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        sceneType = scene;
        homeViewController = homeView;
    }
    return self;
}

#pragma mark -
#pragma mark =======================================
#pragma mark Memory
#pragma mark =======================================

- (void)didReceiveMemoryWarning {
    DebugLog(@"");
    [super didReceiveMemoryWarning];
}

-(void) nullifyAllData{
    DebugLog(@"");
    
    if(winterSceneObject != nil) {
        winterSceneObject = nil;
    }
    
    if(fallSceneObject != nil) {
        fallSceneObject = nil;
    }
    
    if(introView != nil) {
        introView = nil;
    }
    
    if(screenCapture != nil) {
        screenCapture = nil;
    }
    
    if(homeViewController != nil) {
        homeViewController = nil;
    }
    
    if(rainbowAnimationView != nil) {
        rainbowAnimationView = nil;
    }
    
    if(mplayer != nil) {
        mplayer = nil;
    }
    
    if(moviePlayer != nil) {
        moviePlayer = nil;
    }
    
    if(continuityTimer != nil) {
        continuityTimer = nil;
    }
    
    if(videoPlayTimer != nil) {
        videoPlayTimer = nil;
    }
    
    if(fruitObjectArray != nil) {
        [fruitObjectArray removeAllObjects];
        fruitObjectArray = nil;
    }
    
    if(pointComparison != nil) {
        pointComparison = nil;
    }
    
    if(multiTouchForFruitObject != nil) {
        [multiTouchForFruitObject removeAllObjects];
        multiTouchForFruitObject = nil;
    }
    
    if(multiTouchForTouchView != nil) {
        [multiTouchForTouchView removeAllObjects];
        multiTouchForTouchView = nil;
    }
    
}

#pragma mark-
#pragma mark======================
#pragma mark View Life Cycles
#pragma mark======================


- (void)viewDidAppear:(BOOL)animated{
    DebugLog(@"");
    [super viewDidAppear:YES];
    
    isWithShape = [[TigglyStampUtils sharedInstance] getShapeMode];
    
    isGreetingSoundPlaying = NO;
    
    if (isWithShape) {
        [self playShapeinstructionSounds];
    }else{
        [self playFingerInstructionSound];
    }
    
    
    if(!isWithShape){
        if(viewShapesTray.hidden){
            viewShapesTray.hidden = NO;
            for(PhysicalShapesView *pv in arrPhysicalShapes) {
                pv.hidden = NO;
            }
        }
    }else{
        viewShapesTray.hidden = YES;
        for(PhysicalShapesView *pv in arrPhysicalShapes) {
            pv.hidden = YES;
        }
    }

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
    
   
    isWithShape = [[TigglyStampUtils sharedInstance] getShapeMode];
    
    touchView = [[UITouchVerificationView alloc]initWithFrame:CGRectMake(0, 0, 1024, 768)];
    touchView.isWithShape = [self isWithShape];

    isBtnViewHidden = YES;
    videoButton.hidden = YES;
    cameraButton.hidden = YES;
    btnView.frame = CGRectMake(-512, 0, 512, 90);
    
    isRecording = NO;
    countShapeSound = 1;
    isMoveObject = YES;
    
    [self.mainView addSubview:touchView];
    [self.mainView bringSubviewToFront:touchView];
    [self.mainView bringSubviewToFront:cameraButton];
    [self.mainView bringSubviewToFront:videoButton];
    [self.mainView bringSubviewToFront:RigthTickButton];
    [self.mainView bringSubviewToFront:videoButton];
    [self.mainView bringSubviewToFront:cameraButton];
    
    homeButton.hidden = YES;

    [RigthTickButton setTag:TAG_RIGHT_TICK_BTN];

    self.mainView.backgroundColor = [UIColor clearColor];
    
    [touchView configure];
    [touchView.layer setZPosition:1];
    
    [self.view bringSubviewToFront:self.mainView];
    
   
    UITouchShapeRecognizer* triangle1Dist = [[UITouchShapeRecognizer alloc]initWithPlistfile:@"Dist1triangle"];
    [triangle1Dist setLabel:@"triangle"];
    UITouchShapeRecognizer* circle1Dist = [[UITouchShapeRecognizer alloc]initWithPlistfile:@"Dist1circle"];
    [circle1Dist setLabel:@"circle"];
    UITouchShapeRecognizer* square1Dist = [[UITouchShapeRecognizer alloc]initWithPlistfile:@"Dist1square"];
    [square1Dist setLabel:@"square"];
    UITouchShapeRecognizer* star1Dist = [[UITouchShapeRecognizer alloc]initWithPlistfile:@"Dist1star"];
    [star1Dist setLabel:@"star"];
    
    [touchView loadShape:triangle1Dist];
    [touchView loadShape:circle1Dist];
    [touchView loadShape:square1Dist];
    [touchView loadShape:star1Dist];
    
    
    [touchView setDelegate:self];
    if(sceneType == kSceneWinter) {
        winterSceneObject = [[WinterScene alloc]init];
        winterSceneObject.delegate = self;
        backViewImage.image =[UIImage imageNamed:@"Tiggly_stamp_Winter_BG" ];
        curlViewImage.image = [UIImage imageNamed:@"Tiggly_stamp_Winter_BG" ];
    }else if (sceneType == kSceneFall){
        fallSceneObject = [[FallScene alloc]init];
        fallSceneObject.delegate = self;
        backViewImage.image =[UIImage imageNamed:@"fallView" ];
        curlViewImage.image = [UIImage imageNamed:@"fallView" ];
    }
    
    fruitObjectArray = [[NSMutableArray alloc]initWithCapacity:1];
    garbageCan.frame = CGRectMake(924,644,100,100);
    [self.mainView bringSubviewToFront:garbageCan];

    multiTouchForFruitObject = [[NSMutableArray alloc]init];
    multiTouchForTouchView = [[NSMutableArray alloc]init];

    UITapGestureRecognizer *doubleFingerTapOnGarbage =
    [[UITapGestureRecognizer alloc] initWithTarget:self  action:@selector(clearScreen:)];
    doubleFingerTapOnGarbage.numberOfTapsRequired = 2;
    [self.garbageCan addGestureRecognizer:doubleFingerTapOnGarbage];
    
   
    if(!isWithShape)
        [self initShapesTray];
    
    
    if ([[TigglyStampUtils sharedInstance] isAppUnlockedForShapes] && !isWithShape) {
        
#ifdef GOOGLE_ANALYTICS_START
        NSMutableDictionary *event =
        [[GAIDictionaryBuilder createEventWithCategory:@"App Version"
                                                action:@"Full version with no shape"
                                                 label:@"Full version with no shape"
                                                 value:nil] build];
        [[GAI sharedInstance].defaultTracker send:event];
        [[GAI sharedInstance] dispatch];
        
#else
        
#endif
        

    }
    
    arrRainbowImages = [[NSMutableArray alloc] initWithCapacity:1];
    
    for(int i =1 ; i <= 23 ; i++ ) {
        NSString *imgName = [NSString stringWithFormat:@"r%d.png",i];
        DebugLog(@"Img Name : %@",imgName);
        UIImage *img =  [UIImage imageNamed:imgName];
        [arrRainbowImages addObject:(id) img.CGImage];
    }
    
    
    permissions = [NSArray arrayWithObjects:@"read_stream", @"publish_stream", nil] ;
    
    // Set the Facebook object we declared. We’ll use the declared object from the application
    // delegate.
    facebook = [[Facebook alloc] initWithAppId:FACEBOOK_APP_KEY andDelegate:self];
    
}



#pragma mark-
#pragma mark======================
#pragma mark View Orientation
#pragma mark======================

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
#pragma mark Game Animation
#pragma mark =======================================

-(void) animationDidStart:(CAAnimation *)anim{
    DebugLog(@"");
}

-(void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    DebugLog(@"");
    
    if(rainBowLayer != nil){
        [rainBowLayer removeFromSuperlayer];
        [rainBowLayer removeAllAnimations];
        [rainBowLayer removeAnimationForKey:@"contents"];
        rainBowLayer = nil;
    }
    
    if(rainBowBtnLayer != nil){
        [rainBowBtnLayer removeFromSuperlayer];
        [rainBowBtnLayer removeAllAnimations];
        [rainBowBtnLayer removeAnimationForKey:@"contents"];
        rainBowBtnLayer = nil;
    }
    
    isRainbowMusicStarted = NO;
    
    //[RigthTickButton.layer removeFromSuperlayer];
}

-(void) addRainbowEffectAnimation {
    DebugLog(@"");
    
    
  
//    rainBowLayer = [CAShapeLayer layer];
//    rainBowLayer.frame = CGRectMake(0,0, 1024, 768);
//    rainBowLayer.name=@"rainBowLayer";
//    [self.view.layer addSublayer:rainBowLayer];
//
//    rainBowBtnLayer = [CAShapeLayer layer];
//    rainBowBtnLayer.contents = (id)[UIImage imageNamed:@"star_btn_1.png"].CGImage;
//    rainBowBtnLayer.frame = CGRectMake(20,15, 100, 100);
//    rainBowBtnLayer.name=@"rainBowBtnLayer";
//    [self.view.layer addSublayer:rainBowBtnLayer];
//
//
//    rainBowLayer.zPosition = 1000;
//    rainBowBtnLayer.zPosition = 1200;
//    
//    DebugLog(@"Animation Code Started");
//    CAKeyframeAnimation *animation3 = [CAKeyframeAnimation animationWithKeyPath:@"contents"];
//    animation3.calculationMode = kCAAnimationDiscrete;
//    animation3.removedOnCompletion = YES;
//    animation3.duration =2.0;
//    animation3.repeatCount =1;
//    animation3.delegate = self;
//    animation3.values = arrRainbowImages;
//    [animation3 setValue:@"spinAnim" forKey:@"contents"];
//    [rainBowLayer addAnimation: animation3 forKey: @"contents"];
    
    RigthTickButton.hidden = YES;
    
    rainbowAnimationView = [ImageAnimatorView ImageAnimatorView];
    
    NSArray *names1 = [ImageAnimatorView arrayWithNumberedNames:@"r"
                                                               rangeStart:1
                                                                 rangeEnd:23
                                                             suffixFormat:@"%i.png"];
    
	NSArray *bURLs = [ImageAnimatorView arrayWithResourcePrefixedURLs:names1];
    
	rainbowAnimationView.animationOrientation = UIImageOrientationUp; // Rotate 90 deg CCW
	rainbowAnimationView.animationFrameDuration = ImageAnimator15FPS;
	rainbowAnimationView.animationURLs = bURLs;
	rainbowAnimationView.animationRepeatCount = 0;
    
	// Show animator before starting animation
    rainbowAnimationView.frame = CGRectMake(0,0,1024,768);
    [rainbowAnimationView LoadAnimationData];
    [rainbowAnimationView loadView];
	[self.view addSubview:rainbowAnimationView];
    [rainbowAnimationView startAnimating];
    
    rainBowBtnLayer = [CAShapeLayer layer];
    rainBowBtnLayer.contents = (id)[UIImage imageNamed:@"star_btn_1.png"].CGImage;
    rainBowBtnLayer.frame = CGRectMake(20,15, 100, 100);
    rainBowBtnLayer.name=@"rainBowBtnLayer";
    [self.view.layer addSublayer:rainBowBtnLayer];
    
    rainbowAnimationView.layer.zPosition = 1000;
    rainBowBtnLayer.zPosition = 1200;
    
    [[NSNotificationCenter defaultCenter] addObserver:self
											 selector:@selector(animationDidStartNotification:)
												 name:ImageAnimatorDidStartNotification
											   object:rainbowAnimationView];
    
	[[NSNotificationCenter defaultCenter] addObserver:self
											 selector:@selector(animationDidStopNotification:)
												 name:ImageAnimatorDidStopNotification
											   object:rainbowAnimationView];

}

- (void)animationDidStartNotification:(NSNotification*)notification {
	DebugLog(@"");
    
}


- (void)animationDidStopNotification:(NSNotification*)notification {
	DebugLog(@"");

    [rainbowAnimationView removeFromSuperview];
    rainbowAnimationView = nil;
    
    [rainBowBtnLayer removeFromSuperlayer];
    rainBowBtnLayer = nil;
}

- (void) addFlippedPageAnimation {
    DebugLog(@"");
    
    CATransition *animation = [CATransition animation];
    [animation setDuration:HUGE_VAL];
    animation.type = @"pageUnCurl";
    animation.subtype = kCATransitionFromRight;
    animation.fillMode = kCAFillModeBackwards;
    animation.startProgress = 0.88;
    [animation setRemovedOnCompletion:NO];
    [[[self view] layer] addAnimation:animation forKey:@"pageUnCurl"];
    
}



- (void) addCurlAnimation {
    DebugLog(@"");
    
    //to add flipped page eefect at corner
    CGRect r = self.viewForCurl.frame;
    
    if(self.curlView == nil){
        self.curlView = [[XBCurlView alloc] initWithFrame:r];
    }
    
    [self.curlView setUserInteractionEnabled:YES];
    self.curlView.opaque = NO;
    self.curlView.pageOpaque = YES;
    self.curlView.cylinderPosition = CGPointMake(self.viewForCurl.bounds.size.width, self.viewForCurl.bounds.size.height);
    [self.curlView curlView:self.viewForCurl cylinderPosition:CGPointMake(970,740) cylinderAngle:3*M_PI_4 cylinderRadius:UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad? 10: 30 animatedWithDuration:0.0];
    
}

#pragma mark-
#pragma mark======================
#pragma mark Helpers
#pragma mark======================


-(void)configureViewForCurl{
    DebugLog(@"");
    
    boolIsPageCurled = NO;
    pageCurlView = [[XBPageCurlView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)] ;
    [self.view addSubview:pageCurlView];
    pageCurlView.delegate = self;
    pageCurlView.hidden = YES;
    pageCurlView.pageOpaque = YES;
    pageCurlView.opaque = NO;
    pageCurlView.snappingEnabled = YES;
    
    XBSnappingPoint *point = [[XBSnappingPoint alloc] init];
    point.position = CGPointMake(850,712);
    point.angle = 3 * M_PI_4;
    point.radius = 30;
    [pageCurlView.snappingPoints addObject:point];
    bottomSnappingPoint = point;
    
    //    point = [[XBSnappingPoint alloc] init];
    //    point.position = CGPointMake(160, 280);
    //    point.angle = M_PI/8;
    //    point.radius = 80;
    //    [pageCurlView.snappingPoints addObject:point];
}


-(void) playGreetingSoundForObject:(NSTimer *) timer {
    DebugLog(@"");

    NSString *str = (NSString *)[timer userInfo];
    if(sceneType == kSceneWinter) {
        if(isRecording){
            isGreetingSoundPlaying = NO;
            return;
        }

        if(!isRainbowMusicStarted) {
            [[TDSoundManager sharedManager] playSound:[winterSceneObject getAnimalNameSoundForObject:str] withFormat:@"mp3"];
        }
    }else if (sceneType == kSceneFall){
        
        if(isRecording){
            isGreetingSoundPlaying = NO;
            return;
        }
        if(!isRainbowMusicStarted) {
            [[TDSoundManager sharedManager] playSound:[fallSceneObject getAnimalNameSoundForObject:str] withFormat:@"mp3"];
        }
    }
    
    double delayInSeconds = [[TDSoundManager sharedManager] getSoundDuration] + 0.3;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        isGreetingSoundPlaying = NO;
    });
    
}

/*
 This method is called when user is idle for more than 3 seconds.
 */
-(void)needToShowRightTickButton {
    DebugLog(@"");
    if ([fruitObjectArray count] > 0 && [videoButton isHidden]) {
        [RigthTickButton setHidden:NO];
        
    }
}

-(void) startScreenRecording{
    DebugLog(@"");
    
    videoButton.userInteractionEnabled = YES;

    screenCapture.delegate = self;
    [screenCapture startRecording];
    [screenCapture setNeedsDisplay];

    min = 0;
    sec= 0;
    
    if(videoPlayTimer != nil)
        [videoPlayTimer invalidate];
    
    videoPlayTimer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(updateTime) userInfo:nil repeats:YES];
    
     lblTimer.textColor = [UIColor blueColor];
    
    [videoTimer invalidate];
    videoTimer = [NSTimer scheduledTimerWithTimeInterval:180.0 target:self selector:@selector(actionRecording:) userInfo:nil repeats:NO];
    
}



-(void) unCurl{
    DebugLog(@"");
    CGPoint p =CGPointMake(INT_X_LIMIT_TO_FULL_CURL + 10, INT_Y_LIMIT_TO_FULL_CURL - 10);
    pageCurlView.boolIsPageDragEnabled = NO;
    
    [pageCurlView touchEndedAtPoint:p];
    
    [tempImgView removeFromSuperview];
    
    double delayInSeconds = FLOAT_CURL_TIME + 0.2;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        
        pageCurlView.hidden = YES;
        [pageCurlView removeFromSuperview];
        pageCurlView = nil;
        [self configureViewForCurl];
        
        self.viewForCurl.hidden = NO;
        [self.view bringSubviewToFront:self.viewForCurl];
        self.mainView.hidden = NO;
        [self.view bringSubviewToFront:self.mainView];

        [self addFlippedPageAnimation];
    });
}

- (void)clearScreen:(UITapGestureRecognizer *)sender {
    DebugLog(@"");
    [[TDSoundManager sharedManager] playSound:@"trashsweep" withFormat:@"mp3"];
    
    if (sender.state == UIGestureRecognizerStateRecognized) {
        for(FruitView *f in fruitObjectArray){
            [f removeFromSuperview];
        }
        fruitObjectArray = [[NSMutableArray alloc]initWithCapacity:1];
        homeButton.hidden = YES;
        cameraButton.hidden = YES;
        videoButton.hidden = YES;
        [self hideVideoCameraButtons];
        [RigthTickButton.layer removeAnimationForKey:@"transform.scale"];
        RigthTickButton.hidden = NO;
       
        
        UIImageView *tempImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 1024, 768)];
        if (sceneType == kSceneWinter) {
            tempImgView.image = [UIImage imageNamed:@"Tiggly_stamp_Winter_BG.png"];
        }else if (sceneType == kSceneFall){
             tempImgView.image = [UIImage imageNamed:@"fallView.png"];
        }
        
        [self.mainView addSubview:tempImgView];
        
        [tempImgView genieInTransitionWithDuration:1.0
                                   destinationRect:CGRectMake(970, 660, 10, 10)
                                   destinationEdge:BCRectEdgeTop
                                        completion:^{
                                            [tempImgView removeFromSuperview];
                                        }];
        
        if(!isWithShape){
            [self initShapesTray];
        }
    }
    else{
        
    }
}


-(void) removeCurl{
    DebugLog(@"");
    [self.curlView removeFromSuperview];
    [self.view bringSubviewToFront:mainView];
}

-(void) hideButtons{
    DebugLog(@"");
    
    [self.view.layer removeAnimationForKey:@"pageUnCurl"];
    [self.view.layer removeAllAnimations];
    
     [videoButton.layer removeAllAnimations];
    [videoButton.layer removeAnimationForKey:@"transform.scale"];
   
//    
//    if(!isWithShape){
//        if(!viewShapesTray.hidden){
//            viewShapesTray.hidden = YES;
//            for(PhysicalShapesView *pv in arrPhysicalShapes) {
//                pv.hidden = YES;
//            }
//        }
//    }
    
    cameraButton.hidden = YES;
    RigthTickButton.hidden = YES;
    [homeButton setHidden:YES];
    garbageCan.hidden = YES;
//    curlButton.hidden = YES;
    cameraButton.hidden = YES;
    
}

-(void) removeShapesTray {
    DebugLog(@"");
    
    if(viewShapesTray!= nil){
        for(PhysicalShapesView *shape in arrPhysicalShapes) {
            [shape removeFromSuperview];
        }
        [arrPhysicalShapes removeAllObjects];
        arrPhysicalShapes = nil;
        
        [viewShapesTray removeFromSuperview];
        viewShapesTray = nil;
        
        [btnShapesTray removeFromSuperview];
        btnShapesTray = nil;
    }
}

-(void) initShapesTray{
    DebugLog(@"");
    
    isShapesTrayHidden = NO;
    
    [self removeShapesTray];
    
    viewShapesTray= [[UIImageView alloc]initWithFrame:CGRectMake(0,150, 200, 550)];
    viewShapesTray.image = [UIImage imageNamed:@"new_try_out_2.png"];
    viewShapesTray.userInteractionEnabled = YES;
    [self.mainView addSubview:viewShapesTray];
    [self.mainView bringSubviewToFront:viewShapesTray];
    
    
    btnShapesTray = [UIButton buttonWithType:UIButtonTypeCustom];
    [btnShapesTray setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
    [btnShapesTray setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateSelected];
    [btnShapesTray addTarget:self action:@selector(actionBtnShapesTray)forControlEvents:UIControlEventTouchUpInside];
    btnShapesTray.frame = CGRectMake(140, 150,55, 80);
    [self.mainView addSubview:btnShapesTray];
    
    NSString *shapeName = nil;
    int yPos = 30;
    arrPhysicalShapes = [[NSMutableArray alloc] initWithCapacity:1];
    for(int i=0; i< 4; i++) {
        if(i == 0)
            shapeName = @"circle";
        else if (i ==1)
            shapeName = @"square";
        else if (i ==2)
            shapeName = @"triangle";
        else if (i ==3)
            shapeName = @"star";
        
        
        PhysicalShapesView *shape = [[PhysicalShapesView alloc] initWithFrame:CGRectMake(20, yPos, 100, 100)withShapeName:shapeName];
        shape.delagate = self;
        shape.layer.zPosition = 1000;
        yPos = yPos + 100 + 30;
        [viewShapesTray addSubview:shape];
        [viewShapesTray bringSubviewToFront:shape];
        [self.mainView bringSubviewToFront:shape];
        [arrPhysicalShapes addObject:shape];
    }
    
}

-(void) displayShapesTray {
    DebugLog(@"");
        
    isShapesTrayHidden = NO;    
    [UIView animateWithDuration:0.2
                     animations:^{
                         viewShapesTray.frame = CGRectMake(0,150, 200, 550);
                         btnShapesTray.frame = CGRectMake(140, 150,55, 80);
                         viewShapesTray.image = [UIImage imageNamed:@"new_try_out_2.png"];
                         for(PhysicalShapesView *shape in arrPhysicalShapes) {
                             shape.frame = CGRectMake(20, shape.frame.origin.y, shape.frame.size.width, shape.frame.size.height);                             
                         }                         
                     } completion:^(BOOL finished){
  
        }];
    
    
}

-(void) hideShapesTray {
    DebugLog(@"");
    isShapesTrayHidden = YES;
    [UIView animateWithDuration:0.2
                     animations:^{
                         viewShapesTray.frame = CGRectMake(-145,150, 200, 550);
                         btnShapesTray.frame = CGRectMake(0, 150,55,80);
                         viewShapesTray.image = [UIImage imageNamed:@"new_try_out.png"];
                         for(PhysicalShapesView *shape in arrPhysicalShapes) {
                             shape.frame = CGRectMake(-140, shape.frame.origin.y, shape.frame.size.width, shape.frame.size.height);
                             
                         }
                     }
                     completion:^(BOOL finished){

                     }];
}


-(void) displaySharingButtons{
    DebugLog(@"");
    isSharingViewDisplayed = YES;

    
    viewSharingButtons.backgroundColor = [UIColor clearColor];
    [self.view addSubview:viewSharingButtons];
    [self.view bringSubviewToFront:viewSharingButtons];
    
    
    NSArray *arrPlatform = [NSArray arrayWithObjects:@"iPad3,4",@"iPad2,5",@"iPad4,1",@"iPad4,2",@"iPad4,4",@"iPad4,5",@"iPhone5,1",@"iPhone5,2",@"iPhone5,3",@"iPhone5,4",@"iPhone6,1",@"iPhone6,2",nil];
    BOOL isSupported = NO;
    
    for(NSString *strPlatform in arrPlatform){
        if([[[TigglyStampUtils sharedInstance] platformString] isEqualToString:strPlatform]){
            isSupported = YES;
            break;
        }
    }
    
    
    //        viewSharingButtons.frame = CGRectMake(self.view.bounds.size.width/2 - 250/2, self.view.bounds.size.height/2 - 425/2, 250, 425);
    
    if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"7.0") && isSupported) {
        DebugLog(@"iOS version 7.0");
        btnAirdrop.enabled = YES;
        
    }else{
        btnAirdrop.enabled = NO;
        btnAirdrop.hidden = YES;
        
        btnSave.frame =CGRectMake(btnTwitter.frame.origin.x,378,btnSave.frame.size.width,btnSave.frame.size.height);
        btnMail.frame =CGRectMake(btnFacebook.frame.origin.x , btnMail.frame.origin.y,btnMail.frame.size.width,btnMail.frame.size.height);
        
    }
    
    if ([[[NSUserDefaults standardUserDefaults] valueForKey:SAVE_ART] isEqualToString:@"yes"]) {
        btnSave.hidden = NO;
    }else{
        btnSave.hidden = YES;
    }
    
}


#pragma mark- ===============================
#pragma mark- Action Handling
#pragma mark- ===============================

-(void)actionBtnShapesTray{
    DebugLog(@"");
    if(isShapesTrayHidden)
        [self displayShapesTray];
    else
        [self hideShapesTray];
}

-(IBAction)screenShot:(id)sender {
    DebugLog(@"");
    
    if(![[TigglyStampUtils sharedInstance] isItemCountBelowTheLimit]){
        NSString *alertTitle = @"Gallery Limit Reached!";
        NSString *alertMsg = @"You have reached the maximum gallery limit. Please delete few items to continue ";
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:alertTitle message:alertMsg
                                                       delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil,nil];
        [alert show];
        return;
    }
    
    if(![[TigglyStampUtils sharedInstance] isSpaceAvailableOnDisk]){
        NSString *alertTitle = @"Low memory";
        NSString *alertMsg = @"You dont have enough memory on disk. Please free some memory to continue.";
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:alertTitle message:alertMsg
                                                       delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil,nil];
        [alert show];
        return;
    }
    
    [[TDSoundManager sharedManager] stopMusic];
    
    [self.view.layer removeAnimationForKey:@"pageUnCurl"];
    [self.view.layer removeAllAnimations];
    
    [self hideVideoCameraButtons];
    
    isCameraClick = YES;
    
    UIButton *btn = sender;
    
    if ([btn isHidden]) {
        return;
    }
    
    if(!isWithShape){
        if(!viewShapesTray.hidden){
            viewShapesTray.hidden = YES;
            btnShapesTray.hidden = YES;
            for(PhysicalShapesView *pv in arrPhysicalShapes) {
                pv.hidden = YES;
            }
        }
    }
    
    [homeButton setHidden:YES];
    [RigthTickButton setHidden:YES];
    [cameraButton setHidden:YES];
    [videoButton setHidden:YES];
    [garbageCan setHidden:YES];
    
//    UIGraphicsBeginImageContext(CGSizeMake(1024, 768));
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(1024, 768), NO, 0.0);
    [[UIColor clearColor] set];
    UIRectFill(CGRectMake(0.0, 0.0,1024,768));
    [self.view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    [cameraButton setHidden:NO];
    [videoButton setHidden:NO];
    [garbageCan setHidden:NO];

    
#ifdef GOOGLE_ANALYTICS_START
    NSMutableDictionary *event =
    [[GAIDictionaryBuilder createEventWithCategory:@"Gallery"
                                            action:@"Picture captured"
                                             label:@"Picture"
                                             value:nil] build];
    [[GAI sharedInstance].defaultTracker send:event];
    [[GAI sharedInstance] dispatch];
#endif

    for(FruitView *f in fruitObjectArray){
        [f removeFromSuperview];
    }
    homeButton.hidden = YES;
    cameraButton.hidden = YES;
    videoButton.hidden = YES;
    [self hideVideoCameraButtons];
    [RigthTickButton.layer removeAnimationForKey:@"transform.scale"];
    RigthTickButton.hidden = NO;
    
    UIView *flashView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 1024, 768)];
    flashView.backgroundColor = [UIColor whiteColor];
    flashView.alpha = 0;
    [self.view addSubview:flashView];

    
    [[TDSoundManager sharedManager] playSound:@"Tiggly_SFX_CAMERA" withFormat:@"mp3"];
    
    
    [UIView animateWithDuration:0.1
                     animations:^{
                         flashView.alpha = 1;
                     }
                     completion:^(BOOL finished){
                         [UIView animateWithDuration:0.2
                                          animations:^{
                                              flashView.alpha = 0;
                                          }
                                          completion:^(BOOL finished){
                                              [flashView removeFromSuperview];
                                              // [self playRandomPraiseSound];
                                              
                                              double delayInSeconds = 0.8;
                                              dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
                                              dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
                                                  [self playSlidingSounds];
                                              });
                                              
                                              CapturedImageView *cImageView = [[CapturedImageView alloc] initWithFrame:CGRectMake(0, 0, 1024, 768) withImage:image isVideo:NO];
                                              cImageView.delegate = self;
                                              [self.mainView addSubview:cImageView];
                                              [self.mainView bringSubviewToFront:cImageView];
                                              
                                          }];
                     }];
    
}



-(IBAction)onHomeButton:(id)sender{
    DebugLog(@"");
    [[TDSoundManager sharedManager] stopSound];
    [[TDSoundManager sharedManager] stopMusic];
    [self.navigationController popToViewController:homeViewController animated:NO];
    homeViewController = nil;
    [self nullifyAllData];
}


-(IBAction)onButtonClicked:(id)sender{
    DebugLog(@"");
    UIButton *btn = sender;
    if ([btn tag] == TAG_RIGHT_TICK_BTN) {
        
        if(rainBowLayer != nil){
            [rainBowLayer removeFromSuperlayer];
            [rainBowLayer removeAllAnimations];
            [rainBowLayer removeAnimationForKey:@"contents"];
            rainBowLayer = nil;
        }
        
        [self removeShapesTray];

       [[TDSoundManager sharedManager] playSound:@"Tiggly_SFX_MAGIC_19" withFormat:@"mp3"];
        isRainbowMusicStarted = YES;
        
        [tickBtnTimer invalidate];
        [RigthTickButton.layer removeAnimationForKey:@"transform.scale"];

        if(!isWithShape)
            [self hideShapesTray];
        
        [self addRainbowEffectAnimation];
        
        [self.mainView bringSubviewToFront:RigthTickButton];
        
        videoButton.hidden = YES;
        cameraButton.hidden = YES;
        
        btnView.frame = CGRectMake(256, 384, 512, 90);
        cameraButton.frame = CGRectMake(cameraButton.frame.origin.x + 100, cameraButton.frame.origin.y, cameraButton.frame.size.width, cameraButton.frame.size.height);
        videoButton.frame = CGRectMake(videoButton.frame.origin.x - 100, videoButton.frame.origin.y, videoButton.frame.size.width, videoButton.frame.size.height);
        [cameraButton.layer setTransform:CATransform3DMakeScale(2.5, 2.5, 1.0)];
        [videoButton.layer setTransform:CATransform3DMakeScale(2.5, 2.5, 1.0)];
        
        double delayInSeconds = 1.8;
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){

            [self hideShapesTray];
            
            [self showVideoCameraButtons];

        
        });
        
        
//        [[TDSoundManager sharedManager] playSound:@"Blop_Sound_effect" withFormat:@"mp3"];
//        
//        [homeButton setHidden:false];
//        RigthTickButton.hidden = YES;
//        [self.mainView bringSubviewToFront:homeButton];
//        
//        [NSTimer scheduledTimerWithTimeInterval:0.29 + 0.1 target:self selector:@selector(playDragSound) userInfo:nil repeats:NO];
//        
//        [self sendEmail];
//        
//        [self showVideoCameraButtons];
//        
//        [tickBtnTimer invalidate];
//        [RigthTickButton.layer removeAnimationForKey:@"transform.scale"];
//        
//        if(!isWithShape)
//            [self removeShapesTray];
        
    }
    
    if ([btn tag] == TAG_CURL_BTN) {
                
    }
    
    if ([btn tag] == TAG_CURL_CONFIRMED_BTN) {
        curlConfirmedButton.hidden = YES;
        pageCurlView.boolIsPageDragEnabled = NO;
        [unCurlTimer invalidate];
        
        homeButton.hidden = YES;
        [self hideVideoCameraButtons];
        
        CGPoint p =CGPointMake(INT_X_LIMIT_TO_FULL_CURL - 10, INT_Y_LIMIT_TO_FULL_CURL + 10);
        [pageCurlView touchEndedAtPoint:p];
        
        for(FruitView *fruit in fruitObjectArray){
            [fruit removeFromSuperview];
        }
        
       
        
        fruitObjectArray = [[NSMutableArray alloc]initWithCapacity:1];
        
        [tempImgView removeFromSuperview];
        
        double delayInSeconds = FLOAT_FULL_CURL_TIME + 0.2;
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
            
            pageCurlView.hidden = YES;
            [pageCurlView removeFromSuperview];
            pageCurlView = nil;
            [self configureViewForCurl];
            
            self.viewForCurl.hidden = NO;
            [self.view bringSubviewToFront:self.viewForCurl];
            self.mainView.hidden = NO;
            [self.view bringSubviewToFront:self.mainView];
            
            [self addFlippedPageAnimation];
        });
        
    }
}



-(IBAction)actionRecording:(id)sender {
    DebugLog(@"");
    
    if(![[TigglyStampUtils sharedInstance] isItemCountBelowTheLimit]){
        NSString *alertTitle = @"Gallery Limit Reached!";
        NSString *alertMsg = @"You have reached the maximum gallery limit. Please delete few items to continue.";
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:alertTitle message:alertMsg
                                                       delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil,nil];
        [alert show];
        return;
    }
    
    if(![[TigglyStampUtils sharedInstance] isSpaceAvailableOnDisk]){
        NSString *alertTitle = @"Low memory";
        NSString *alertMsg = @"You dont have enough memory on disk. Please free some memory to continue.";
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:alertTitle message:alertMsg
                                                       delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil,nil];
        [alert show];
        return;
    }
    
    if(isRecording) {
        
        [videoTimer invalidate];
        
        [videoPlayTimer invalidate];
        lblTimer.text = @"";
        
        isRecording = NO;
        [videoButton setBackgroundImage:[UIImage imageNamed:@"record_icon_ record"] forState:UIControlStateNormal];
        cameraButton.hidden = NO;
        [screenCapture stopRecording];
        [self screenVideoShotStop];
        
        garbageCan.hidden = NO;
        
        [videoButton.layer removeAnimationForKey:@"opacity"];
        [videoButton.layer removeAllAnimations];
        
        [self hideVideoCameraButtons];
        
    }else{
        
        isRecording = YES;
        
        videoButton.userInteractionEnabled = NO;
        
        [[TDSoundManager sharedManager] stopMusic];
        
        [NSThread detachNewThreadSelector:@selector(hideButtons) toTarget:self withObject:nil];
        
         [self playTellUsStorySound];
        
        videoButton.alpha = 0.0;
        
//        UIGraphicsBeginImageContext(CGSizeMake(1024, 768));
        UIGraphicsBeginImageContextWithOptions(CGSizeMake(1024, 768), NO, 0.0);
        [[UIColor whiteColor] set];
        UIRectFill(CGRectMake(0.0, 0.0,1024,768));
        [self.view.layer renderInContext:UIGraphicsGetCurrentContext()];
        
        UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
        videoButton.alpha = 1.0;
        
        NSDate* currentDate = [NSDate date];
        NSDateFormatter *dateFormat = [[NSDateFormatter alloc]init];
        [dateFormat setDateFormat:@"MM-dd-yyyy_HH:mm:ss"];
        NSString *movieDateString = [dateFormat stringFromDate:currentDate];
        NSString *imgName = [NSString stringWithFormat:@"TigglyStamp_%@.png",movieDateString];
        DebugLog(@"Image Name : %@",imgName);
        
        movieScreenshotImage = image;
        movieScreenshotName = imgName;
        
        screenCapture.movieString = movieDateString;
                
        [videoButton setBackgroundImage:[UIImage imageNamed:@"record_icon_stop_2"] forState:UIControlStateNormal];
        
        
        [videoButton.layer removeAllAnimations];
        [videoButton.layer removeAnimationForKey:@"transform.scale"];
        
        [cameraButton.layer removeAllAnimations];
        [cameraButton.layer removeAnimationForKey:@"transform.scale"];
        
    }
}



-(IBAction)actionFacebook:(id)sender{
    DebugLog(@"");
    if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"6.0")) {
        
        SLComposeViewController *mySLComposerSheet = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeFacebook];
        
        [mySLComposerSheet setInitialText:@"My kid is loving #TigglyDraw. Check their master piece @Tiggly: the first iPad toy for toddlers"];
        
        UIImage *originalImage = [UIImage imageWithContentsOfFile:currentImagePath];
        
        [mySLComposerSheet addImage:originalImage];
        
        [mySLComposerSheet setCompletionHandler:^(SLComposeViewControllerResult result) {
            
            switch (result) {
                case SLComposeViewControllerResultCancelled:
                    NSLog(@"Post Canceled");
                    break;
                case SLComposeViewControllerResultDone:
                    NSLog(@"Post Sucessful");
                    break;
                    
                default:
                    break;
            }
        }];
        
        [self presentViewController:mySLComposerSheet animated:YES completion:nil];
        
    }else{
        [self fbSessionLogout];
        [facebook authorize:permissions];
    }
}

-(IBAction)actionTwitter:(id)sender
{
    DebugLog(@"");
    
    UIImage *originalImage = [UIImage imageWithContentsOfFile:currentImagePath];
    
    TWTweetComposeViewController *twitter = [[TWTweetComposeViewController alloc] init];
    
    [twitter setInitialText:@"My kid is loving #TigglyDraw. Check their master piece @TigglyKids"];
    [twitter addImage:originalImage];
    
    [self presentViewController:twitter animated:YES completion:nil];
    
    twitter.completionHandler = ^(TWTweetComposeViewControllerResult res) {
        
        if(res == TWTweetComposeViewControllerResultDone) {
            
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Success" message:@"The Tweet has been posted successfully." delegate:self cancelButtonTitle:@"Dismiss" otherButtonTitles: nil];
            
            [alert show];
            
        }
        
        [self dismissModalViewControllerAnimated:YES];
        
    };
    
}

-(IBAction)actionPinterest:(id)sender{
    DebugLog(@"");
    
}

-(IBAction)actionAirdrop:(id)sender{
    DebugLog(@"");
    
    NSURL *imageurl=[NSURL fileURLWithPath:currentImagePath];
    NSArray *objectsToShare = @[imageurl];
    
    UIActivityViewController *controller = [[UIActivityViewController alloc] initWithActivityItems:objectsToShare applicationActivities:nil];
    
    
    NSArray *excludedActivities = @[UIActivityTypePostToTwitter, UIActivityTypePostToFacebook,
                                    UIActivityTypePostToWeibo,
                                    UIActivityTypeMessage, UIActivityTypeMail,
                                    UIActivityTypePrint, UIActivityTypeCopyToPasteboard,
                                    UIActivityTypeAssignToContact, UIActivityTypeSaveToCameraRoll,
                                    UIActivityTypeAddToReadingList, UIActivityTypePostToFlickr,
                                    UIActivityTypePostToVimeo, UIActivityTypePostToTencentWeibo];
    controller.excludedActivityTypes = excludedActivities;
    
    
    [self presentViewController:controller animated:YES completion:nil];
    
    
}

-(IBAction)actionSaveToGallery:(id)sender{
    DebugLog(@"");
    UIImage *originalImage = [UIImage imageWithContentsOfFile:currentImagePath];
    
    [[ServerController sharedInstance] sendEvent:@"tab_saveto_gallery" withEventValue:@"yes" withServiceName:SERVICE_URL_SET_BEHAVIOURCOUNT];
    
    UIImageWriteToSavedPhotosAlbum(originalImage, nil, nil, nil);
    UIAlertView *mailAlertV=[[UIAlertView alloc]initWithTitle:@"Image Saved" message:@"Image saved successfully to photo album!!!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [mailAlertV show];
}

-(IBAction)actionSendMail:(id)sender
{
    DebugLog(@"");
    
    UIImage *originalImage = [UIImage imageWithContentsOfFile:currentImagePath];
    if ([MFMailComposeViewController canSendMail]){
        // Create and show composer
        mailsend = [[MFMailComposeViewController alloc] init];
        mailsend.mailComposeDelegate = self;
        [mailsend setSubject: @"My masterpiece" ];//@" Exciting App \"Tiggly Christmas \""];
        
        // Attach an image to the email
        NSString *fileName = @"Tiggly Draw artwork";
        fileName = [fileName stringByAppendingPathExtension:@"jpg"];
        
        NSData *myData = UIImageJPEGRepresentation(originalImage, 1.0);
        
        [mailsend addAttachmentData:myData mimeType:@"image/jpeg" fileName:fileName];
        
        // Fill out the email body text
        NSString *emailBody = [NSString stringWithFormat:@"%@ %@ %@",@"I created this masterpiece with Tiggly Draw.",@"Check it out at",@"www.tiggly.com"];
        [mailsend setMessageBody:emailBody isHTML:NO];
        [self presentModalViewController:mailsend animated:YES];
    }
    else
    {
        // Show some error message here
        NSLog(@"Mail Setup Error...");
        UIAlertView *anAlert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"No mail account setup on device" delegate:self cancelButtonTitle:nil otherButtonTitles:nil];
        [anAlert addButtonWithTitle:@"Ok"];
        [anAlert show];
        
        
    }
    
}

-(IBAction)actionClose:(id)sender {
    DebugLog(@"");
    isSharingViewDisplayed = NO;
    [viewSharingButtons removeFromSuperview];
    [self removeImage];
}

-(void)removeImage{
    DebugLog(@"");
    NSFileManager *fileManager = [NSFileManager defaultManager];
    [fileManager removeItemAtPath:currentImagePath error:nil];
}
#pragma mark -
#pragma mark =======================================
#pragma mark Facebook Delegates
#pragma mark =======================================
-(void)request:(FBRequest *)request didReceiveResponse:(NSURLResponse *)response {
    NSLog(@"received response:%@",response);
    //    NSString *requestType =[request.url stringByReplacingOccurrencesOfString:@"https://graph.facebook.com/" withString:@""];
    //
    //    if ([requestType isEqualToString:@"me"])
    //    {
    //
    //    }
    //    else {
    //        UIAlertView *al = [[UIAlertView alloc] initWithTitle:APPLICATION_NAME message:@"Your message has been posted on your wall!" delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
    //        [al show];
    //    }
}


-(void)request:(FBRequest *)request didLoad:(id)result{
    // With this method we’ll get any Facebook response in the form of an array.
    // In this example the method will be used twice. Once to get the user’s name to
    // when showing the welcome message and next to get the ID of the published post.
    // Inside the result array there the data is stored as a NSDictionary.
    if ([result isKindOfClass:[NSArray class]]) {
        // The first object in the result is the data dictionary.
        result = [result objectAtIndex:0];
    }
    
    // Check it the “first_name” is contained into the returned data.
    if ([result objectForKey:@"first_name"]) {
        // If the current result contains the "first_name" key then it's the user's data that have been returned.
        // Change the lblUser label's text.
        // Show the publish button.
    }
    else if ([result objectForKey:@"id"]) {
        // Stop showing the activity view.
        
        // If the result contains the "id" key then the data have been posted and the id of the published post have been returned.
        UIAlertView *al = [[UIAlertView alloc] initWithTitle:APPLICATION_NAME message:@"Your message has been posted on your wall!" delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
        [al show];
    }
}

/**
 * Called when an error prevents the request from completing successfully.
 */

- (void)request:(FBRequest *)request didFailWithError:(NSError *)error {
    NSLog(@"Request failed with error");
    NSLog(@"%@",[error localizedDescription]);
    NSLog(@"Err details: %@", [error description]);
    NSLog(@"Err details: %@",    [error userInfo]);
    NSDictionary * codes=[error userInfo];
    NSLog(@"codes is :%@",codes);
    NSString * messages = [[codes valueForKey:@"error"]valueForKey:@"message"];
    
    NSLog(@"message is :%@",messages);
    NSString * erro=@"";
    if(![messages rangeOfString:@")"].location ==NSNotFound){
        erro=[messages substringFromIndex:[messages rangeOfString:@")"].location];
    }
    
    NSLog(@"FBRequest failed:request  %@ :error  %@",request.url, [error localizedRecoverySuggestion]);
}

-(void)fbDidLogin{
    // Save the access token key info.
    //[self saveAccessTokenKeyInfo];
    [facebook requestWithGraphPath:@"me" andDelegate:self];
    
    UIImage *originalImage = [UIImage imageWithContentsOfFile:currentImagePath];
    NSMutableDictionary *params1 = [[NSMutableDictionary alloc]init];
    NSData *imageDate = UIImagePNGRepresentation(originalImage);
    
    [params1 setObject:imageDate forKey:@"source"];
    [params1 setObject:@"post from Tiggly Application" forKey:@"message"];
    [params1 setObject:@"Tiggly Draw" forKey:@"name"];
    
    NSString *post=@"/me/photos";
    [facebook requestWithGraphPath:post andParams:params1 andHttpMethod:@"POST" andDelegate:self];
}


-(void)fbDidNotLogin:(BOOL)cancelled{
    // Keep this for testing purposes.
    //NSLog(@"Did not login");
    
    UIAlertView *al = [[UIAlertView alloc] initWithTitle:APPLICATION_NAME message:@"Login cancelled." delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
    [al show];
}
-(void)fbSessionLogout
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if ([defaults objectForKey:@"FBAccessTokenKey"])
    {
        [defaults removeObjectForKey:@"FBAccessTokenKey"];
        [defaults removeObjectForKey:@"FBExpirationDateKey"];
        [defaults synchronize];
    }
    
    // Hide the publish button.
    
    NSHTTPCookie *cookie;
    NSHTTPCookieStorage *storage = [NSHTTPCookieStorage sharedHTTPCookieStorage];
    for (cookie in [storage cookies])
    {
        NSString* domainName = [cookie domain];
        NSRange domainRange = [domainName rangeOfString:@"facebook"];
        if(domainRange.length > 0)
        {
            [storage deleteCookie:cookie];
        }
    }
}



-(void) fbDidLogout{
    DebugLog(@"");
}

-(void) fbSessionInvalidated{
    DebugLog(@"");
}

-(void)fbDidExtendToken:(NSString *)accessToken expiresAt:(NSDate *)expiresAt {
    DebugLog(@"");
}

#pragma mark MFMailComposeViewControllerDelegate...

- (void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error
{
	NSLog(@"Mail delegate...");
	[self dismissModalViewControllerAnimated:YES];
	
	if(result==MFMailComposeResultSent)
	{
		UIAlertView *mailAlertV=[[UIAlertView alloc]initWithTitle:@"E-Mail Sent" message:@"Your mail has been sent successfully!!!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
		[mailAlertV show];
	}
}


#pragma mark-
#pragma mark======================
#pragma mark FalScene Delegate
#pragma mark======================

-(void)fallSceneDrawObjectForObjectName:(NSString *)objectName{
    DebugLog(@"");
    shapeToDraw = objectName;
    prevShape = objectName;
}

#pragma mark-
#pragma mark======================
#pragma mark WinterScene Delegate
#pragma mark======================

-(void)drawObjectForObjectName:(NSString *)objectName {
    shapeToDraw = objectName;
    prevShape = objectName;
}

#pragma mark -
#pragma mark =======================================
#pragma mark Shape Detection Handling
#pragma mark =======================================

-(void)buildShape:(NSString *)shape{
    DebugLog(@"");
    if(!isRecording ) {
        RigthTickButton.hidden = NO;
//        videoButton.hidden = NO;
//        cameraButton.hidden = NO;
        
        if (!homeButton.hidden) {
            homeButton.hidden = YES;
        }
    }
    
    if(!isBtnViewHidden) {
        [self hideVideoCameraButtons];
    }
    
    [self reorientationOfShape:(NSString *)shape];
}

-(UIImage *) changeImageColor:(UIImage *) image withColor:(UIColor *) color {
    DebugLog(@"");
    
    CGRect rect = CGRectMake(0, 0, image.size.width, image.size.height);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextClipToMask(context, rect, image.CGImage);
    CGContextSetFillColorWithColor(context,color.CGColor);
    CGContextFillRect(context, rect);
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    UIImage *flippedImage = [UIImage imageWithCGImage:img.CGImage
                                                scale:1.0 orientation: UIImageOrientationDown];
    return flippedImage;
}


/*
 Once the shape is get detected we create a shape in exact orientation as
 it was placed.
 We calculate angle in which we want to show the basic shape.
 Then we show a basic shape in that perticular angle & rotate it to required angle.
 After sometime, we display actual shape on screen.
 */
-(void)reorientationOfShape:(NSString *)shape {
    DebugLog(@"");
    
    NSString *shapeImage = shapeToDraw;
    
    double angleDiff = 0.0;
    CGPoint midPoint;
    if (isWithShape) {
        midPoint = CGPointMake(((centerX/numOfTouchPts)),((centerY/numOfTouchPts)));        
    }else{
        angleDiff = 0;
        midPoint = CGPointMake(((centerX)),((centerY)));
    }
    
    //Common code to all shapes
    CALayer * layer = [CALayer layer];
    layer.position = midPoint;
    UIColor *color = [[TigglyStampUtils sharedInstance]getRGBValueForShape:shapeImage withBasicShape:shape];
    UIImage *img= [UIImage imageNamed:[NSString stringWithFormat:@"%@.png",shape]];
    if([shape isEqualToString:@"square"]){
        layer.frame = CGRectMake(((centerX/2) - (img.size.width/4)),((centerY/2) - (img.size.height/4)), img.size.width/2.8, img.size.height/2.8);
    }else{
        layer.frame = CGRectMake(((centerX/numOfTouchPts) - (img.size.width/4)),((centerY/numOfTouchPts) - (img.size.height/4)), img.size.width/2, img.size.height/2);
        
    }
    UIImage *newImg = [self changeImageColor:img withColor:color];
    img = [self changeImageColor:newImg withColor:color];
    layer.contents = (id) img.CGImage;
    if (!isWithShape) {
        
        if(midPoint.x < img.size.width/4)
            midPoint = CGPointMake(img.size.width/4,midPoint.y);
        
        if (midPoint.x > 1024-img.size.width/4)
            midPoint = CGPointMake(1024-img.size.width/4,midPoint.y);
        
        if (midPoint.y> 768-img.size.height/4)
            midPoint = CGPointMake(midPoint.x,768-img.size.height/4);
        
        if (midPoint.y< img.size.height/4)
            midPoint = CGPointMake(midPoint.x,img.size.height/4);
        
        layer.position = midPoint;
        
    }
    [self.view.layer addSublayer:layer];
    
    [layer setValue:[NSNumber numberWithFloat:angleDiff] forKeyPath:@"transform.rotation.z"];
    
    //To animate the triangle to original position as depending on shape
    if([ shape isEqualToString:@"triangle"]){
        int64_t delayInSecondsTodetect = 1.0;
        dispatch_time_t popTimetoDetect = dispatch_time(DISPATCH_TIME_NOW, delayInSecondsTodetect * NSEC_PER_SEC);
        dispatch_after(popTimetoDetect, dispatch_get_main_queue(), ^(void){
            if([shapeImage isEqualToString:@"deer_2"]||[shapeImage isEqualToString:@"hot_choclate"]||
               [shapeImage isEqualToString:@"lightbulb"] || [shapeImage isEqualToString:@"horse"]||[shapeImage isEqualToString:@"leaves"]||
               [shapeImage isEqualToString:@"zebra_2"])
                [layer setValue:[NSNumber numberWithFloat:M_PI] forKeyPath:@"transform.rotation.z"];
            else
                [layer setValue:[NSNumber numberWithFloat:0] forKeyPath:@"transform.rotation.z"];
        });
    }
    
    //To animate the square to original position as depending on shape
    if([ shape isEqualToString:@"square"]){
        int64_t delayInSecondsTodetect = 1.0;
        dispatch_time_t popTimetoDetect = dispatch_time(DISPATCH_TIME_NOW, delayInSecondsTodetect * NSEC_PER_SEC);
        dispatch_after(popTimetoDetect, dispatch_get_main_queue(), ^(void){
            [layer setValue:[NSNumber numberWithFloat:0] forKeyPath:@"transform.rotation.z"];
        });
    }
    
    //To build the actual shape
    int64_t delayInSeconds = 0.5;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        int64_t d = 1.0;
        dispatch_time_t p = dispatch_time(DISPATCH_TIME_NOW, d * NSEC_PER_SEC);
        dispatch_after(p, dispatch_get_main_queue(), ^(void){
            [layer removeFromSuperlayer];
            UIImage *imgOfShape= [UIImage imageNamed:[NSString stringWithFormat:@"%@.png",shapeImage]];
            DebugLog(@"FruitSize : %@",NSStringFromCGSize(imgOfShape.size));
            FruitView *fruit;
            if([shape isEqualToString:@"square"]){
                fruit = [[FruitView alloc] initWithFrame:CGRectMake(0,0, imgOfShape.size.width, imgOfShape.size.height) withShape:shapeImage];
                fruit.layer.position = midPoint;
            }else{
                fruit = [[FruitView alloc] initWithFrame:CGRectMake(0,0, imgOfShape.size.width, imgOfShape.size.height) withShape:shapeImage];
                fruit.layer.position = midPoint;
            }
            fruit.delegate = self;
            [self.mainView addSubview:fruit];
            
            DebugLog(@"FruitFinalSize : %@",NSStringFromCGRect(fruit.frame));

            [fruitObjectArray addObject:fruit];            
            
            NSString *objName = shapeImage;
            DebugLog(@"Object Name : %@", objName);
            
            [RigthTickButton.layer removeAnimationForKey:@"transform.scale"];
            [tickBtnTimer invalidate];
            tickBtnTimer = [NSTimer scheduledTimerWithTimeInterval:3.0 target:self selector:@selector(pulseTickButton) userInfo:nil repeats:NO];
            
            [continuityTimer invalidate];
            continuityTimer = [NSTimer scheduledTimerWithTimeInterval:0.8 target:self selector:@selector(playGreetingSoundForObject:) userInfo:objName repeats:NO];
            isGreetingSoundPlaying = YES;
            
//            [self.mainView bringSubviewToFront:fruit];
            [self.mainView bringSubviewToFront:RigthTickButton];
            [self.mainView bringSubviewToFront:homeButton];
            [self.mainView bringSubviewToFront:videoButton];
            [self.mainView bringSubviewToFront:cameraButton];
            
            centerX = 0;
            centerY = 0;
            
            if(sceneType == kSceneWinter) {
                [winterSceneObject removeDrawnShapeObject:shape objectToRemove:shapeImage];
            }else if (sceneType == kSceneFall){
                [fallSceneObject removeDrawnShapeObject:shape objectToRemove:shapeImage];
            }
           
        //            //Sachin
        //            double delayInSeconds = [[TDSoundManager sharedManager] getSoundDuration];;
        //            dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
        //            dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        //
        //                [fruit removeFromSuperview];
        //                [fruitObjectArray removeObject:fruit];
        //            });
        //            //Sachin

        
        });
        
    });
    
    
    
}

#pragma mark-
#pragma mark======================
#pragma mark UITouchVerification TouchDelegate
#pragma mark======================

-(void)shapeDetected:(UITouchShapeRecognizer *)UIT inView:(UITouchVerificationView*)view{
    DebugLog(@"");
    
    if(!isWithShape)
        return;
    
    if(!shouldShapeDetected){
        return;
    }
    
    if(!isBtnViewHidden){
        return;
    }
    
    
    shapeToDraw = nil;
    if(sceneType == kSceneWinter) {
        self.shapes = [[NSMutableArray alloc]initWithArray:[winterSceneObject shapeForObject:UIT.label]];
    }else if (sceneType == kSceneFall){
         self.shapes = [[NSMutableArray alloc]initWithArray:[fallSceneObject shapeForObject:UIT.label]];
    }
    
    centerX = 0;
    centerY = 0;
    pointComparison = [[NSArray alloc]initWithArray:view.detectedPoints];
    numOfTouchPts = pointComparison.count;
    
    for(UITouch *touch in view.detectedPoints){
        CGPoint tochLocation = [touch locationInView:touchView];
        centerX = centerX + tochLocation.x;
        centerY = centerY + tochLocation.y;
    }
    if(shouldShapeDetected){
        shouldShapeDetected = NO;
        
        if((sceneType == kSceneFall && isRecording) ||(sceneType == kSceneWinter && isRecording) ) {
        }else{
            [self playShapeDetectedSound];
        }
        
        
        shapeSoundToPlay = UIT.label;
        if ([shapeSoundTimer isValid]) {
            [shapeSoundTimer invalidate];
        }
        shapeSoundTimer = [NSTimer scheduledTimerWithTimeInterval:1.5f target:self selector:@selector(playSoundForShape) userInfo:nil repeats:NO];
        
        [[ServerController sharedInstance] drawShapeWithIsVirtualShape:@"no" withShapeType:UIT.label withShapeCorrect:@"yes"];

        [self buildShape:UIT.label];
    }
    int64_t delayInSecondsTodetect = 0.0f;
    dispatch_time_t popTimetoDetect = dispatch_time(DISPATCH_TIME_NOW, delayInSecondsTodetect * NSEC_PER_SEC);
    dispatch_after(popTimetoDetect, dispatch_get_main_queue(), ^(void){
        shouldShapeDetected = YES;
    });
    

}



-(void)touchVerificationViewTouchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
//    
    DebugLog(@"TouchBegan");
    
    DebugLog(@"TouchBegan");
    CGPoint p = [[touches anyObject] locationInView:touchView];
    if(p.x > 950 && p.y < 75){
//        boolIsPageCurled = YES;
//        
//        [self.view.layer removeAllAnimations];
//        
//        UIGraphicsBeginImageContext(CGSizeMake(1024, 768));
//        [[UIColor whiteColor] set];
//        UIRectFill(CGRectMake(0.0, 0.0,1024,768));
//        [self.view.layer renderInContext:UIGraphicsGetCurrentContext()];
//        
//        UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
//        UIGraphicsEndImageContext();
//        self.mainView.hidden = YES;
//        
//        tempImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 1024, 768)];
//        tempImgView.image = image;
//        [self.viewForCurl addSubview:tempImgView];
//        [self.view bringSubviewToFront:self.viewForCurl];
//        
//        boolIsTouchMoved = NO;
//        
//        
//        
//        return;
    }

//
//    if (event != nil) {
//        // if touch count is greater than 1
//        if ([touches count]>0) {
//            DebugLog(@"touche count is greater than 1");
//            isTouchesOnTouchLayer = YES;
//        }
//        
//    }
//    
//    if (!isWithShape) {
//        int randomNo = arc4random() % 4;
//        NSString *shape;
//        if (randomNo == 1) {
//            shape = @"triangle";
//        }else if (randomNo == 2){
//            shape = @"square";
//        }else if (randomNo == 3){
//            shape = @"star";
//        }else{
//            shape = @"circle";
//        }
//        shapeSoundToPlay = shape;
//        
//        shapeToDraw = nil;
//       
//        if(sceneType == kSceneWinter) {
//            self.shapes = [[NSMutableArray alloc]initWithArray:[winterSceneObject shapeForObject:shape]];
//        }else if (sceneType == kSceneFall){
//            self.shapes = [[NSMutableArray alloc]initWithArray:[fallSceneObject shapeForObject:shape]];
//        }
//        
//        centerX = 0;
//        centerY = 0;
//        CGPoint point = [[touches anyObject] locationInView:touchView];
//        centerX = point.x;
//        centerY =  point.y;
//        if(shouldShapeDetected){
//            shouldShapeDetected = NO;
//            
//            [self buildShape:shape];
//            
//            if(sceneType == kSceneFall && isRecording) {
//                
//            }else{
//                [self playShapeDetectedSound];
//            }
//        }
//        
//        shouldShapeDetected = YES;
//        
//        
//    }else{
//        
//    }
}

-(void) touchVerificationViewTouchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
    DebugLog(@"The layer to move %@",[currentLayer name]);
//    CGPoint p = [[touches anyObject] locationInView:touchView];
//    if(boolIsPageCurled){
//        if(!boolIsTouchMoved){
//            boolIsTouchMoved = YES;
//            
//            [pageCurlView drawViewOnFrontOfPage:self.viewForCurl];
//            //            pageCurlView.cylinderPosition =bottomSnappingPoint.position;
//            //            pageCurlView.cylinderAngle = bottomSnappingPoint.angle;
//            //            pageCurlView.cylinderRadius = bottomSnappingPoint.radius;
//            
//            pageCurlView.hidden = NO;
//            self.viewForCurl.hidden = YES;
//            [pageCurlView startAnimating];
//            
//            [pageCurlView touchBeganAtPoint:p];
//            
//            curlConfirmedButton.hidden = YES;
//            
//        }else{
//            [pageCurlView touchMovedToPoint:p];
//        }
//        return;
//    }

}

-(void)touchVerificationViewTouchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    DebugLog(@"");
////    isTouchesOnTouchLayer = NO;
//    CGPoint p = [[touches anyObject] locationInView:touchView];
//    if(boolIsPageCurled){
//        boolIsPageCurled = NO;
//        
//        if(boolIsTouchMoved){
//            
//            [pageCurlView touchEndedAtPoint:p];
//            
//            float time = FLOAT_CURL_TIME;
//            
//            if(p.x < INT_X_LIMIT_TO_FULL_CURL && p.y > INT_Y_LIMIT_TO_FULL_CURL){
//                
//                time = FLOAT_FULL_CURL_TIME;
//                for(FruitView *fruit in fruitObjectArray){
//                    [fruit removeFromSuperview];
//                }
//                
//                homeButton.hidden = YES;
//                [self hideVideoCameraButtons];
//                
//                fruitObjectArray = [[NSMutableArray alloc]initWithCapacity:1];
//            }
//            
//            [tempImgView removeFromSuperview];
//            
//            double delayInSeconds = time + 0.2;
//            dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
//            dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
//                
//                pageCurlView.hidden = YES;
//                [pageCurlView removeFromSuperview];
//                pageCurlView = nil;
//                [self configureViewForCurl];
//                
//                self.viewForCurl.hidden = NO;
//                [self.view bringSubviewToFront:self.viewForCurl];
//                self.mainView.hidden = NO;
//                [self.view bringSubviewToFront:self.mainView];
//                
//                [self addFlippedPageAnimation];
//                
//                curlConfirmedButton.hidden = NO;
//                
//            });
//            
//        }else{
//            //flip the page corner and wait for 3 seconds for user action
//            
//            [pageCurlView drawViewOnFrontOfPage:self.viewForCurl];
//            pageCurlView.cylinderPosition =bottomSnappingPoint.position;
//            pageCurlView.cylinderAngle = bottomSnappingPoint.angle;
//            pageCurlView.cylinderRadius = bottomSnappingPoint.radius;
//            
//            pageCurlView.hidden = NO;
//            self.viewForCurl.hidden = YES;
//            [pageCurlView startAnimating];
//            pageCurlView.boolIsPageDragEnabled = YES;
//            
//            [unCurlTimer invalidate];
//            unCurlTimer = [NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(unCurl) userInfo:nil repeats:NO];
//            
//            curlConfirmedButton.hidden = NO;
//        }
//        return;
//    }
//    
    isTouchesOnTouchLayer = NO;

}


#pragma mark-
#pragma mark======================
#pragma mark WinterSceneViewController Touch Events
#pragma mark======================
-(void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    DebugLog(@"");
    
}

-(void) touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    DebugLog(@"");
    
}

#pragma mark-
#pragma mark======================
#pragma mark FruitView Touch Delegates
#pragma mark======================

-(void) onFruitView:(FruitView *)fruit touchesBegan:(NSSet *)touches {
    DebugLog(@"");
    
    if (isWithShape) {
        [touchView touchesBegan:touches withEvent:nil];
    }
    
    [tickBtnTimer invalidate];
    [RigthTickButton.layer removeAnimationForKey:@"transform.scale"];
    
}

-(void) onFruitView:(FruitView *)fruit touchesMoved:(NSSet *)touches {
    DebugLog(@"");
    
    if (isTouchesOnTouchLayer) {
        isMoveObject = NO;
    }
    
    
    if (isMoveObject) {
        
        if (isWithShape) {
            [touchView touchesMoved:touches withEvent:nil];
        }else{
            if(!viewShapesTray.hidden){
                [self.mainView bringSubviewToFront:viewShapesTray];
                [self.mainView bringSubviewToFront:btnShapesTray];
                for(PhysicalShapesView *pv in arrPhysicalShapes) {
                    [self.mainView bringSubviewToFront:pv];
                }
            }
        }
        
        CGPoint point = [[touches anyObject] locationInView:touchView];
        [self.mainView bringSubviewToFront:fruit];
        
#ifdef GOOGLE_ANALYTICS_START
        NSMutableDictionary *event =
        [[GAIDictionaryBuilder createEventWithCategory:@"Game Play"
                                                action:@"Object moved"
                                                 label:@"Drag things on screen"
                                                 value:nil] build];
        [[GAI sharedInstance].defaultTracker send:event];
        [[GAI sharedInstance] dispatch];
#else
        
#endif
        

        
        [fruit moveObject:touches point:point isRecording:isRecording];
    }
    
    
    
    
    [tickBtnTimer invalidate];
    [RigthTickButton.layer removeAnimationForKey:@"transform.scale"];
    
    [self.mainView bringSubviewToFront:RigthTickButton];
    [self.mainView bringSubviewToFront:homeButton];
     [self.mainView bringSubviewToFront:btnView];
    [self.mainView bringSubviewToFront:videoButton];
    [self.mainView bringSubviewToFront:cameraButton];
    
    for(PhysicalShapesView *psv in arrPhysicalShapes) {
        [self.mainView bringSubviewToFront:psv];
    }
}


-(void) onFruitView:(FruitView *)fruit touchesEnded:(NSSet *)touches {
    DebugLog(@"");
    isMoveObject = YES;
    [multiTouchForFruitObject removeAllObjects];
    
    
    if (isWithShape) {
        [touchView touchesEnded:touches withEvent:nil];
    }
    
    
    [showSeasonsTimer invalidate];
    showSeasonsTimer = [NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(needToShowRightTickButton) userInfo:nil repeats:NO];
    
    [RigthTickButton.layer removeAnimationForKey:@"transform.scale"];
    [tickBtnTimer invalidate];
    tickBtnTimer = [NSTimer scheduledTimerWithTimeInterval:3.0 target:self selector:@selector(pulseTickButton) userInfo:nil repeats:NO];
    
    if(!isRecording){
        if(CGRectIntersectsRect(fruit.frame, garbageCan.frame)){
            DebugLog(@"Delete Object");
#ifdef GOOGLE_ANALYTICS_START
            NSMutableDictionary *event =
            [[GAIDictionaryBuilder createEventWithCategory:@"Game Play"
                                                    action:@"Object Deleted"
                                                     label:@"Delete Object"
                                                     value:nil] build];
            [[GAI sharedInstance].defaultTracker send:event];
            [[GAI sharedInstance] dispatch];
            
#else
            
#endif
 
            
            fruit.layer.position = CGPointMake(1024 - garbageCan.frame.size.width/2, 768 - garbageCan.frame.size.height/2);
            DebugLog(@"Frame is %@",NSStringFromCGRect(fruit.frame));
            dispatch_time_t playAudioIn = dispatch_time(DISPATCH_TIME_NOW, 0.05* NSEC_PER_SEC);
            dispatch_after(playAudioIn, dispatch_get_main_queue(), ^(void){
                // if (!isRecording){
                [[TDSoundManager sharedManager] playSound:@"Tiggly_SFX_DELETE_01" withFormat:@"mp3"];
                // }
            });
            fruit.userInteractionEnabled = NO;
            CABasicAnimation *animation4a = nil;
            animation4a = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
            [animation4a setToValue:[NSNumber numberWithDouble:0]];
            [animation4a setFromValue:[NSNumber numberWithDouble:1]];
            [animation4a setAutoreverses:NO];
            [animation4a setDuration:1.5f];
            [animation4a setBeginTime:0.0f];
            [fruit.layer addAnimation:animation4a forKey:@"t ransform.scale"];
            
            dispatch_time_t popTimetoDetect = dispatch_time(DISPATCH_TIME_NOW, 1 * NSEC_PER_SEC);
            dispatch_after(popTimetoDetect, dispatch_get_main_queue(), ^(void){
                [fruit removeFromSuperview];
            });
            
            [RigthTickButton.layer removeAnimationForKey:@"transform.scale"];
            [tickBtnTimer invalidate];
            tickBtnTimer = [NSTimer scheduledTimerWithTimeInterval:3.0 target:self selector:@selector(pulseTickButton) userInfo:nil repeats:NO];
            
            return;
        }
    }
    
    if(fruit.isFruitMovedSufficiently && !isGreetingSoundPlaying){// && !isRecording
        if(sceneType == kSceneWinter) {
            if(isRecording){
                return;
            }
            
            if(!isRainbowMusicStarted) {
                NSString *sound = [winterSceneObject getAnimalDropSoundForObject:fruit.objectName];
                [[TDSoundManager sharedManager] playSound:sound withFormat:@"mp3"];
            }
        }else if (sceneType == kSceneFall) {
            if(isRecording){
                return;
            }
             if(!isRainbowMusicStarted) {
                 NSString *sound = [fallSceneObject getAnimalDropSoundForObject:fruit.objectName];
                 [[TDSoundManager sharedManager] playSound:sound withFormat:@"mp3"];
             }
        }
    }
    
}


-(void) onFruitViewSwipeLeft:(FruitView *) fruit {
    DebugLog(@"");
    if(fruit.frame.origin.x  > 1){
        [UIView animateWithDuration:5.0
                         animations:^{
                             fruit.frame = CGRectMake(0, fruit.frame.origin.y+(fruit.frame.size.height/2), fruit.frame.size.width, fruit.frame.size.height);
                         }
                         completion:^(BOOL finished){}];
    }
}

-(void) onFruitViewSwipeRight:(FruitView *) fruit{
    DebugLog(@"");
    if(fruit.frame.origin.x + fruit.frame.size.width < 1024){
        [UIView animateWithDuration:5.0
                         animations:^{
                             fruit.frame = CGRectMake(1024 - fruit.frame.size.width, fruit.frame.origin.y+(fruit.frame.size.height/2), fruit.frame.size.width, fruit.frame.size.height);
                             
                         }
                         completion:^(BOOL finished){}];
    }
}

#pragma mark -
#pragma mark =======================================
#pragma mark Physical Shape View Protocols
#pragma mark =======================================

-(void) physicalShapeViewOnTouchesBegan:(PhysicalShapesView *) phyShapeView{
    DebugLog(@"");
    
    [self.mainView bringSubviewToFront:phyShapeView];
    
    phyShapeView.imgView.transform = CGAffineTransformMakeScale(4.0, 4.0);
    phyShapeView.imgView.alpha = 0.8;
    
    [RigthTickButton.layer removeAnimationForKey:@"transform.scale"];

}

-(void) physicalShapeViewOnTouchesMoved:(PhysicalShapesView *) phyShapeView {
    DebugLog(@"");

    
    [self.mainView bringSubviewToFront:phyShapeView];
    [self.backView bringSubviewToFront:phyShapeView];
    [self.view bringSubviewToFront:phyShapeView];
}


-(void) physicalShapeViewOnTouchesEnded:(NSSet *)touches withEvent:(UIEvent *)event forView:(PhysicalShapesView *)phyShapeView{
    DebugLog(@"");
    
        
        [UIView animateWithDuration:0.4 animations:^{
            phyShapeView.imgView.transform = CGAffineTransformMakeScale(1.0, 1.0);
            phyShapeView.imgView.alpha = 0.0;
        } completion:^(BOOL  finished ){
            phyShapeView.frame = phyShapeView.initialFrame;
            phyShapeView.imgView.alpha = 1.0;
        }];
    
        centerX = 0;
        centerY = 0;
        CGPoint point = [[touches anyObject] locationInView:touchView];
        centerX = point.x;
        centerY =  point.y;
    
        if(centerX < 175)
            return;
    
        shapeToDraw = nil;

        if(sceneType == kSceneWinter) {
            self.shapes = [[NSMutableArray alloc]initWithArray:[winterSceneObject shapeForObject:phyShapeView.shapeName]];
        }else if (sceneType == kSceneFall){
            self.shapes = [[NSMutableArray alloc]initWithArray:[fallSceneObject shapeForObject:phyShapeView.shapeName]];
        }

        [tickBtnTimer invalidate];
        tickBtnTimer = [NSTimer scheduledTimerWithTimeInterval:3.0 target:self selector:@selector(pulseTickButton) userInfo:nil repeats:NO];

        if(shouldShapeDetected){
            shouldShapeDetected = NO;

            [[ServerController sharedInstance] drawShapeWithIsVirtualShape:@"yes" withShapeType:phyShapeView.shapeName withShapeCorrect:@"yes"];

            
            [self buildShape:phyShapeView.shapeName];

            if((sceneType == kSceneFall && isRecording) || (sceneType == kSceneWinter && isRecording)) {
            
            }else{
                [self playShapeDetectedSound];
            }
        }
        
        shouldShapeDetected = YES;
   // }];
}


#pragma mark -
#pragma mark =======================================
#pragma mark Video and Camera Buttons Handling
#pragma mark =======================================

-(void) showVideoCameraButtons {
    DebugLog(@"");

    isBtnViewHidden = NO;
    videoButton.hidden = NO;
    cameraButton.hidden = NO;

    [self.mainView bringSubviewToFront:btnView];
    

    [UIView animateWithDuration:0.8 animations:^{
        btnView.frame = CGRectMake(256, 0, 512, 90);
        [cameraButton.layer setTransform:CATransform3DMakeScale(1.0, 1.0, 1.0)];
        [videoButton.layer setTransform:CATransform3DMakeScale(1.0, 1.0, 1.0)];
        cameraButton.frame = CGRectMake(cameraButton.frame.origin.x - 100, cameraButton.frame.origin.y, cameraButton.frame.size.width, cameraButton.frame.size.height);
        videoButton.frame = CGRectMake(videoButton.frame.origin.x + 100, videoButton.frame.origin.y, videoButton.frame.size.width, videoButton.frame.size.height);
    }completion:^(BOOL finished) {
        
        [self.mainView bringSubviewToFront:homeButton];
        [homeButton setHidden:NO];
        RigthTickButton.hidden = YES;

        
        double delayInSeconds = 2.0;
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
            CABasicAnimation *animation4a = nil;
            animation4a = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
            [animation4a setToValue:[NSNumber numberWithDouble:1.5]];
            [animation4a setFromValue:[NSNumber numberWithDouble:1]];
            [animation4a setAutoreverses:YES];
            [animation4a setDuration:1.5f];
            [animation4a setBeginTime:0.0f];
            [animation4a setRepeatCount:HUGE_VAL];
            [videoButton.layer addAnimation:animation4a forKey:@"transform.scale"];

            CABasicAnimation *animation4a2 = nil;
            animation4a2 = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
            [animation4a2 setToValue:[NSNumber numberWithDouble:1.5]];
            [animation4a2 setFromValue:[NSNumber numberWithDouble:1]];
            [animation4a2 setAutoreverses:YES];
            [animation4a2 setDuration:1.5f];
            [animation4a2 setBeginTime:0.0f];
            [animation4a2 setRepeatCount:HUGE_VAL];
            [cameraButton.layer addAnimation:animation4a2 forKey:@"transform.scale"];
        });
    }];

//    isBtnViewHidden = NO;
//    videoButton.hidden = NO;
//    cameraButton.hidden = NO;
//    RigthTickButton.hidden = YES;
//    
//    [self.mainView bringSubviewToFront:btnView];
//    
//    [UIView animateWithDuration:0.8 animations:^{
//        btnView.frame = CGRectMake(256, 0, 512, 90);
//    }completion:^(BOOL finished) {
//        double delayInSeconds = 2.0;
//        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
//        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
//            CABasicAnimation *animation4a = nil;
//            animation4a = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
//            [animation4a setToValue:[NSNumber numberWithDouble:1.5]];
//            [animation4a setFromValue:[NSNumber numberWithDouble:1]];
//            [animation4a setAutoreverses:YES];
//            [animation4a setDuration:1.5f];
//            [animation4a setBeginTime:0.0f];
//            [animation4a setRepeatCount:HUGE_VAL];
//            [videoButton.layer addAnimation:animation4a forKey:@"transform.scale"];
//            
//            CABasicAnimation *animation4a2 = nil;
//            animation4a2 = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
//            [animation4a2 setToValue:[NSNumber numberWithDouble:1.5]];
//            [animation4a2 setFromValue:[NSNumber numberWithDouble:1]];
//            [animation4a2 setAutoreverses:YES];
//            [animation4a2 setDuration:1.5f];
//            [animation4a2 setBeginTime:0.0f];
//            [animation4a2 setRepeatCount:HUGE_VAL];
//            [cameraButton.layer addAnimation:animation4a2 forKey:@"transform.scale"];
//        });
//    }];
    
    
    
}

-(void) hideVideoCameraButtons {
    DebugLog(@"");
    

    if(!isRecording) {
        RigthTickButton.hidden = NO;

        [cameraButton.layer removeAnimationForKey:@"transform.scale"];
        [cameraButton.layer removeAllAnimations];
        
        [videoButton.layer removeAnimationForKey:@"transform.scale"];
        [videoButton.layer removeAllAnimations];
       
        isBtnViewHidden = YES;
        [UIView animateWithDuration:0.3 animations:^{
            btnView.frame = CGRectMake(256,-150, 512,90);

        }completion:^(BOOL finished) {
            videoButton.hidden = YES;
            cameraButton.hidden = YES;
//            btnView.frame = CGRectMake(256,-100, 512,90);
        }];
    }

//    if(!isRecording) {
//        RigthTickButton.hidden = NO;
//        
//        [cameraButton.layer removeAnimationForKey:@"transform.scale"];
//        [cameraButton.layer removeAllAnimations];
//        
//        [videoButton.layer removeAnimationForKey:@"transform.scale"];
//        [videoButton.layer removeAllAnimations];
//        
//        isBtnViewHidden = YES;
//        [UIView animateWithDuration:0.3 animations:^{
//            btnView.frame = CGRectMake(256,-90, 512,90);
//        }completion:^(BOOL finished) {
//            videoButton.hidden = YES;
//            cameraButton.hidden = YES;
//            btnView.frame = CGRectMake(-512, 0, 512,90);
//        }];
//    }

    
}

-(void) pulseTickButton {
    DebugLog(@"");
    
    CABasicAnimation *animation4a = nil;
    animation4a = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    [animation4a setToValue:[NSNumber numberWithDouble:1.5]];
    [animation4a setFromValue:[NSNumber numberWithDouble:1]];
    [animation4a setAutoreverses:YES];
    [animation4a setDuration:1.5f];
    [animation4a setBeginTime:0.0f];
    [animation4a setRepeatCount:HUGE_VAL];
    [RigthTickButton.layer addAnimation:animation4a forKey:@"transform.scale"];

}



#pragma mark- ===============================
#pragma mark- CapturedImageView Delegates
#pragma mark- ===============================


-(void) onImageClicked:(CapturedImageView *)cImageView{
    DebugLog(@"");
    
    
    DebugLog(@"");
    [cImageView removeFromSuperview];
    for(FruitView *fruit in fruitObjectArray){
        [fruit removeFromSuperview];
    }
    fruitObjectArray = [[NSMutableArray alloc]initWithCapacity:1];
    [cameraButton setHidden:YES];
    [videoButton setHidden:YES];
    [RigthTickButton setHidden:YES];
    
}


-(void) onNextButtonClicked:(CapturedImageView *)cImageView{
    DebugLog(@"");
    
    [[TDSoundManager sharedManager] stopMusic];
    
    [[TDSoundManager sharedManager] playSound:@"Blop_Sound_effect" withFormat:@"mp3"];
    
    [moviePlayer stop];
    
    [self.navigationController popViewControllerAnimated:NO];
    [cImageView removeFromSuperview];
    [self nullifyAllData];
}


-(void) onHomeButtonClicked:(CapturedImageView *)cImageView{
    DebugLog(@"");
    [[TDSoundManager sharedManager] playSound:@"Blop_Sound_effect" withFormat:@"mp3"];
    
    [[TDSoundManager sharedManager] stopMusic];
#ifdef GOOGLE_ANALYTICS_START
    NSMutableDictionary *event =
    [[GAIDictionaryBuilder createEventWithCategory:@"Home Button"
                                            action:@"Home button Clicked"
                                             label:@"Home From canvas"
                                             value:nil] build];
    [[GAI sharedInstance].defaultTracker send:event];
    [[GAI sharedInstance] dispatch];
    
#else
    
#endif

    
    [moviePlayer stop];
    
    [cImageView removeFromSuperview];
    
    [self.navigationController popToViewController:homeViewController animated:NO];
    homeViewController = nil;
    
    [self nullifyAllData];
}

-(void) onPlayButtonClicked:(CapturedImageView *)cImageView {
    DebugLog(@"");
    [self playVideo];
    
}

-(void)onSendButton:(CapturedImageView *)cImageView withImageName:(NSString *)imgName{
    DebugLog(@"");
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    currentImagePath = [path stringByAppendingPathComponent:imgName];
 
    [self displaySharingButtons];
}


#pragma mark- ===============================
#pragma mark- Video Handling
#pragma mark- ===============================

-(void)screenVideoShotStop {
    DebugLog(@"");
    
    for(FruitView *f in fruitObjectArray){
        [f removeFromSuperview];
    }
    homeButton.hidden = YES;
    cameraButton.hidden = YES;
    videoButton.hidden = YES;
    [self hideVideoCameraButtons];
    [RigthTickButton.layer removeAnimationForKey:@"transform.scale"];
    RigthTickButton.hidden = NO;
    
    ccImageView = [[CapturedImageView alloc] initWithFrame:CGRectMake(0, 0, 1024, 768) withImage:movieScreenshotImage isVideo:YES];
    ccImageView.delegate = self;
    ccImageView.moviePngName = movieScreenshotName;
    [self.mainView addSubview:ccImageView];
    [self.mainView bringSubviewToFront:ccImageView];
    
    //Create and add the Activity Indicator to splashView
    activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    activityIndicator.alpha = 0.0;
    activityIndicator.color = [UIColor blackColor];
    activityIndicator.center = self.view.center;
    activityIndicator.hidesWhenStopped = NO;
    [self.mainView addSubview:activityIndicator];
//    [activityIndicator startAnimating];
    
}

- (void) recordingFinished:(NSString*)outputPathOrNil{
    DebugLog(@"");
   
    
#ifdef GOOGLE_ANALYTICS_START
    NSMutableDictionary *event =
    [[GAIDictionaryBuilder createEventWithCategory:@"Gallery"
                                            action:@"Video Recording"
                                             label:@"Video"
                                             value:nil] build];
    [[GAI sharedInstance].defaultTracker send:event];
    [[GAI sharedInstance] dispatch];
#endif

    
    double delayInSeconds = 1.0;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        [self playSlidingSounds];
    });
    
    [activityIndicator removeFromSuperview];
    ccImageView.btnPlay.hidden = NO;
    [self playSlidingSounds];
    
    
}

-(void)playVideo {
    DebugLog(@"");
    NSString *editImgName = [NSString stringWithFormat:@"%@",screenCapture.exportUrl];
    if([[[editImgName lastPathComponent] pathExtension]isEqualToString:@"mov"]) {
        [self playVideoWithURL:screenCapture.exportUrl];
    }
}

-(void) playVideoWithURL:(NSURL *) videoUrl{
    DebugLog(@"");
    
    moviePlayer = [[MPMoviePlayerController alloc]
                   initWithContentURL:videoUrl];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(moviePlayBackDidFinish:)
                                                 name:MPMoviePlayerPlaybackDidFinishNotification
                                               object:moviePlayer];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(didExitFullScreen:)
                                                 name:MPMoviePlayerDidExitFullscreenNotification
                                               object:nil];
    [moviePlayer.view setFrame:CGRectMake(180, 130,650,488)];
    moviePlayer.controlStyle = MPMovieControlStyleDefault;
    moviePlayer.shouldAutoplay = YES;
    [self.view addSubview:moviePlayer.view];
    [moviePlayer prepareToPlay];
    [moviePlayer play];
    
}

- (void) moviePlayBackDidFinish:(NSNotification*)notification {
    DebugLog(@"");
    
    moviePlayer = [notification object];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:MPMoviePlayerPlaybackDidFinishNotification
                                                  object:moviePlayer];
    
    if ([moviePlayer    respondsToSelector:@selector(setFullscreen:animated:)])
    {
        
        [moviePlayer.view removeFromSuperview];
    }
    
}

-(void)didExitFullScreen:(id)sender{
    DebugLog(@"");
    
}

#pragma mark- ===============================
#pragma mark- Sound Handling
#pragma mark- ===============================

-(void) playSlidingSounds{
    DebugLog(@"");
    int ranNo = arc4random() % 3;
    
    switch (ranNo) {
        case 0:
            [[TDSoundManager sharedManager] playSound:@"Tiggly_SFX_MAGIC_12" withFormat:@"mp3"];
            break;
        case 1:
            [[TDSoundManager sharedManager] playSound:@"Tiggly_SFX_MAGIC_13" withFormat:@"mp3"];
            break;
        case 2:
            [[TDSoundManager sharedManager] playSound:@"Tiggly_SFX_MAGIC_14" withFormat:@"mp3"];
            break;
            
        default:
            break;
    }
    
    
}

-(void) playRandomPraiseSound{
    DebugLog(@"");
    // playing sound praise sound randomly
    int ranNo = arc4random() % 9;
    switch (ranNo) {
        case 0:
            [[TDSoundManager sharedManager] playSound:@"Tiggly_Word_GaspGenius_01" withFormat:@"mp3"];
            break;
        case 1:
            [[TDSoundManager sharedManager] playSound:@"Tiggly_Word_Masterpiece_01" withFormat:@"mp3"];
            break;
        case 2:
            [[TDSoundManager sharedManager] playSound:@"Tiggly_Word_OhThatsSoPretty_01" withFormat:@"mp3"];
            break;
        case 3:
            [[TDSoundManager sharedManager] playSound:@"Tiggly_Word_OhWowThatsWonderful_01" withFormat:@"mp3"];
            break;
        case 4:
            [[TDSoundManager sharedManager] playSound:@"Tiggly_Word_RembrandtSchmembrandtLookAtYou_01" withFormat:@"mp3"];
            break;
        case 5:
            [[TDSoundManager sharedManager] playSound:@"Tiggly_Word_WorthyOfAMuseum_01" withFormat:@"mp3"];
            break;
        case 6:
            [[TDSoundManager sharedManager] playSound:@"Tiggly_Word_Wow_01" withFormat:@"mp3"];
            break;
        case 7:
            [[TDSoundManager sharedManager] playSound:@"Tiggly_Word_Wow_02" withFormat:@"mp3"];
            break;
        case 8:
            [[TDSoundManager sharedManager] playSound:@"Tiggly_Word_YoureAProdigy_01" withFormat:@"mp3"];
            break;
            
        default:
            break;
    }
}


-(void) playTellUsStorySound{
    DebugLog(@"");
    float timeToPlayGettingReadySound = 0.0f;
    
    
    if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"English"]) {
        
        int ranNo = arc4random() % 15;
        
        
        switch (ranNo) {
            case 0:
                timeToPlayGettingReadySound = 1.70f;
                [[TDSoundManager sharedManager] playSound:@"Tiggly_Word_TellUsAStory_01" withFormat:@"mp3"];
                break;
            case 1:
                timeToPlayGettingReadySound = 1.65f;
                [[TDSoundManager sharedManager] playSound:@"Tiggly_Word_TellUsAStory_HaveYouGotAStoryForMe_01" withFormat:@"mp3"];
                break;
            case 2:
                timeToPlayGettingReadySound = 1.67f;
                [[TDSoundManager sharedManager] playSound:@"Tiggly_Word_TellUsAStory_HaveYouGotAStoryToTell_01" withFormat:@"mp3"];
                break;
            case 3:
                timeToPlayGettingReadySound = 2.30f;
                [[TDSoundManager sharedManager] playSound:@"Tiggly_Word_TellUsAStory_IBetYouGotAGreatStory_01" withFormat:@"mp3"];
                break;
            case 4:
                timeToPlayGettingReadySound = 2.12f;
                [[TDSoundManager sharedManager] playSound:@"Tiggly_Word_TellUsAStory_IBetYouveGotAStoryToTell_01" withFormat:@"mp3"];
                break;
            case 5:
                timeToPlayGettingReadySound = 1.46f;
                [[TDSoundManager sharedManager] playSound:@"Tiggly_Word_TellUsAStory_MakeUp_02" withFormat:@"mp3"];
                break;
            case 6:
                timeToPlayGettingReadySound = 1.56f;
                [[TDSoundManager sharedManager] playSound:@"Tiggly_Word_TellUsAStory_Me_01" withFormat:@"mp3"];
                break;
            case 7:
                timeToPlayGettingReadySound = 1.57f;
                [[TDSoundManager sharedManager] playSound:@"Tiggly_Word_TellUsAStory_Me_02" withFormat:@"mp3"];
                break;
            case 8:
                timeToPlayGettingReadySound = 1.54f;
                [[TDSoundManager sharedManager] playSound:@"Tiggly_Word_TellUsAStory_MeYour_01" withFormat:@"mp3"];
                break;
            case 9:
                timeToPlayGettingReadySound = 1.46f;
                [[TDSoundManager sharedManager] playSound:@"Tiggly_Word_TellUsAStory_MeYour_02" withFormat:@"mp3"];
                break;
            case 10:
                timeToPlayGettingReadySound = 1.99f;
                [[TDSoundManager sharedManager] playSound:@"Tiggly_Word_TellUsAStory_NowMakeUp_01" withFormat:@"mp3"];
                break;
            case 11:
                timeToPlayGettingReadySound = 1.80f;
                [[TDSoundManager sharedManager] playSound:@"Tiggly_Word_TellUsAStory_NowMakeUp_02" withFormat:@"mp3"];
                break;
            case 12:
                timeToPlayGettingReadySound = 1.78f;
                [[TDSoundManager sharedManager] playSound:@"Tiggly_Word_TellUsAStory_NowMakeUp_03" withFormat:@"mp3"];
                break;
            case 13:
                timeToPlayGettingReadySound = 1.88f;
                [[TDSoundManager sharedManager] playSound:@"Tiggly_Word_TellUsAStory_NowMakeUpYour_01" withFormat:@"mp3"];
                break;
            case 14:
                timeToPlayGettingReadySound = 1.38f;
                [[TDSoundManager sharedManager] playSound:@"Tiggly_Word_TellUsAStory_Your_01" withFormat:@"mp3"];
                break;
                
            default:
                break;
        }
        
        
    }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"English UK"]){
        timeToPlayGettingReadySound = 1.42f;
        [[TDSoundManager sharedManager] playSound:@"Tell_us_a_story!_breng" withFormat:@"mp3"];
    }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"Portuguese"]){
        timeToPlayGettingReadySound = 1.61f;
        [[TDSoundManager sharedManager] playSound:@"Tell_us_a_story!_prtgs" withFormat:@"mp3"];
    }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"Russian"]){
        timeToPlayGettingReadySound = 1.46f;
        [[TDSoundManager sharedManager] playSound:@"Tell_us_a_story!_ru" withFormat:@"mp3"];
    }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"Spanish"]){
        timeToPlayGettingReadySound = 1.51f;
        [[TDSoundManager sharedManager] playSound:@"Tell us a story!_sp" withFormat:@"mp3"];
    }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"French"]){
        timeToPlayGettingReadySound = 1.51f;
        [[TDSoundManager sharedManager] playSound:@"TellusaStory_fr" withFormat:@"mp3"];
    }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"German"]){
        timeToPlayGettingReadySound = 1.51f;
        [[TDSoundManager sharedManager] playSound:@"Tell_us_a_story_gr" withFormat:@"mp3"];
    }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"Italian"]){
        timeToPlayGettingReadySound = 1.51f;
        [[TDSoundManager sharedManager] playSound:@"Tell_us_a_story!_ita" withFormat:@"mp3"];
    }
    
    [NSTimer scheduledTimerWithTimeInterval:timeToPlayGettingReadySound + 0.2f target:self selector:@selector(startScreenRecording) userInfo:nil repeats:NO];
    
    
    // schedule playGettingReadyTotellStorySound method after timeToPlayGettingReadySound sec
    
    //    [NSTimer scheduledTimerWithTimeInterval:timeToPlayGettingReadySound + 0.4 target:self selector:@selector(playGettingReadyTotellStorySound) userInfo:nil repeats:NO];
}

-(void) playGettingReadyTotellStorySound{
    DebugLog(@"");
    float timeToStartVideoRecording = 0.0f;
    if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"English"]) {
        
        int ranNo = arc4random() % 6;
        
        
        switch (ranNo) {
            case 0:
                timeToStartVideoRecording = 4.30f;
                [[TDSoundManager sharedManager] playSound:@"Tiggly_Word_321GO_01" withFormat:@"mp3"];
                break;
            case 1:
                timeToStartVideoRecording = 5.88f;
                [[TDSoundManager sharedManager] playSound:@"Tiggly_Word_321GO_02" withFormat:@"mp3"];
                break;
            case 2:
                timeToStartVideoRecording = 4.41f;
                [[TDSoundManager sharedManager] playSound:@"Tiggly_Word_321GO_OnYourMarkGetSet_01" withFormat:@"mp3"];
                break;
            case 3:
                timeToStartVideoRecording = 4.41f;
                [[TDSoundManager sharedManager] playSound:@"Tiggly_Word_321GO_ReadySet_01" withFormat:@"mp3"];
                break;
            case 4:
                timeToStartVideoRecording = 2.87f;
                [[TDSoundManager sharedManager] playSound:@"Tiggly_Word_OneTwoThree_01" withFormat:@"mp3"];
                break;
            case 5:
                timeToStartVideoRecording = 3.06f;
                [[TDSoundManager sharedManager] playSound:@"Tiggly_Word_TellUsAStory_Your_01" withFormat:@"mp3"];
                break;
                
                
            default:
                break;
        }
    }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"English UK"]){
        [[TDSoundManager sharedManager] playSound:@"321GO!_breng" withFormat:@"mp3"];
        timeToStartVideoRecording = [[TDSoundManager sharedManager] getSoundDuration];
    }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"Portuguese"]){
        [[TDSoundManager sharedManager] playSound:@"321GO!_prtgs" withFormat:@"mp3"];
        timeToStartVideoRecording = [[TDSoundManager sharedManager] getSoundDuration];
    }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"Russian"]){
        [[TDSoundManager sharedManager] playSound:@"321GO!_ru" withFormat:@"mp3"];
        timeToStartVideoRecording = [[TDSoundManager sharedManager] getSoundDuration];
    }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"Spanish"]){
        [[TDSoundManager sharedManager] playSound:@"321GO!_sp" withFormat:@"mp3"];
        timeToStartVideoRecording = [[TDSoundManager sharedManager] getSoundDuration];
    }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"French"]){        
        [[TDSoundManager sharedManager] playSound:@"3_2_1_GO_fr" withFormat:@"mp3"];
        timeToStartVideoRecording = [[TDSoundManager sharedManager] getSoundDuration];
    }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"German"]){
        [[TDSoundManager sharedManager] playSound:@"3_2_1_GO_gr" withFormat:@"mp3"];
        timeToStartVideoRecording = [[TDSoundManager sharedManager] getSoundDuration];
    }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"Italian"]){
        [[TDSoundManager sharedManager] playSound:@"3_2_1_GO_ita" withFormat:@"mp3"];
        timeToStartVideoRecording = [[TDSoundManager sharedManager] getSoundDuration];
    }
    
    
    [NSTimer scheduledTimerWithTimeInterval:timeToStartVideoRecording + 0.2f target:self selector:@selector(startScreenRecording) userInfo:nil repeats:NO];
}


-(void) playShapeinstructionSounds{
    DebugLog(@"");
    
        if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"English UK"] ||
            [[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"English"]){
                    int ranNo = arc4random() % 5;
                    
                    switch (ranNo) {
                        case 0:
                            [[TDSoundManager sharedManager] playSound:@"Tiggly_Word_TapOnTheScreen_WithAShape_01" withFormat:@"mp3"];
                            break;
                        case 1:
                            [[TDSoundManager sharedManager] playSound:@"Tiggly_Word_TapOnTheScreen_WithYourShape_01" withFormat:@"mp3"];
                            break;
                        case 2:
                            [[TDSoundManager sharedManager] playSound:@"Tiggly_Word_TapOnTheScreen_WithYourShape_02" withFormat:@"mp3"];
                            break;
                        case 3:
                            [[TDSoundManager sharedManager] playSound:@"Tiggly_Word_UseTheShapesToMakeAPicture_01" withFormat:@"mp3"];
                            break;
                        case 4:
                            [[TDSoundManager sharedManager] playSound:@"Tiggly_Word_UseYourShapesToMakeAPicture_01" withFormat:@"mp3"];
                            break;
                            
                        default:
                            break;
                    }
        }
}

-(void) playFingerInstructionSound{
    DebugLog(@"");
    
    if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"English UK"] ||
        [[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"English"]){
        
        int ranNo = arc4random() % 2;
            
            switch (ranNo) {
                case 0:
                    [[TDSoundManager sharedManager] playSound:@"Tiggly_Instructions_Dragashapetomakeapicture_01" withFormat:@"mp3"];
                    break;
                case 1:
                    [[TDSoundManager sharedManager] playSound:@"Tiggly_Instructions_Dragashapetomakeapicture_02" withFormat:@"mp3"];
                    break;
                    
                default:
                    break;
            }
    }
    
}


-(void) playDragSound{
    DebugLog(@"");
    [[TDSoundManager sharedManager] playSound:@"Tiggly_SFX_DragNDrop_DRAG_04" withFormat:@"mp3"];
}

-(void) playShapeDetectedSound{
    DebugLog(@"");
    
    NSString *soundName = [NSString stringWithFormat:@"CakeCandle%d",countShapeSound];
    [[TDSoundManager sharedManager] playSound:soundName withFormat:@"mp3"];
    
    countShapeSound ++;
    if (countShapeSound == 10) {
        countShapeSound = 1;
    }
    
}

-(void) playSoundForShape{
    DebugLog(@"");
    
    //    [[TDSoundManager sharedManager] playSound:shapeSoundToPlay withFormat:@"mp3"];
}

#pragma mark-
#pragma mark======================
#pragma mark XBPageCurlView Delegates
#pragma mark======================

-(void) pageCurlViewTouchBeganAtPoint:(CGPoint)p{
    DebugLog(@"");
    [unCurlTimer invalidate];
    curlConfirmedButton.hidden = YES;
    
}

-(void) pageCurlViewTouchMovedToPoint:(CGPoint)p{
    DebugLog(@"");
    
}

-(void) pageCurlViewTouchEndedAtPoint:(CGPoint)p{
    DebugLog(@"");
    float time = FLOAT_CURL_TIME;
    
    if(p.x < INT_X_LIMIT_TO_FULL_CURL && p.y > INT_Y_LIMIT_TO_FULL_CURL){
        NSLog(@"Not OK");
        [pageCurlView touchEndedAtPoint:p];
        
        time = FLOAT_FULL_CURL_TIME;
        for(FruitView *fruit in fruitObjectArray){
            [fruit removeFromSuperview];
        }
        fruitObjectArray = [[NSMutableArray alloc]initWithCapacity:1];
        
        [tempImgView removeFromSuperview];
        
        homeButton.hidden = YES;
        [self hideVideoCameraButtons];
        
        double delayInSeconds = time + 0.2;
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
            
            pageCurlView.hidden = YES;
            [pageCurlView removeFromSuperview];
            pageCurlView = nil;
            [self configureViewForCurl];
            
            self.viewForCurl.hidden = NO;
            [self.view bringSubviewToFront:self.viewForCurl];
            self.mainView.hidden = NO;
            [self.view bringSubviewToFront:self.mainView];
            
            [self addFlippedPageAnimation];
            
            curlConfirmedButton.hidden = NO;
            
        });
        
    }else{
        //flip the page corner and wait for 3 seconds for user action
        NSLog(@"OK");
        
        pageCurlView.cylinderPosition =bottomSnappingPoint.position;
        pageCurlView.cylinderAngle = bottomSnappingPoint.angle;
        pageCurlView.cylinderRadius = bottomSnappingPoint.radius;
        
        [pageCurlView startAnimating];
        
        [unCurlTimer invalidate];
        unCurlTimer = [NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(unCurl) userInfo:nil repeats:NO];
        
        curlConfirmedButton.hidden = NO;
    }
    
}


-(void)updateTime{
    DebugLog(@"");
    
    sec++;
    if(sec == 60){
        sec = 0;
        min++;
    }
    
    NSString *secTemp;
    if(sec < 10){
        secTemp = [NSString stringWithFormat:@"0%d",sec];
    }else{
        secTemp = [NSString stringWithFormat:@"%d",sec];
    }
    
    NSString *time = [NSString stringWithFormat:@"0%d:%@",min,secTemp];
    lblTimer.text = time;
    
    if (min == 2 && sec == 50) {
        lblTimer.textColor = [UIColor redColor];
        // start animation
        
        
        double delayInSeconds = 1.0;
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
            CABasicAnimation *theAnimation;
            theAnimation=[CABasicAnimation animationWithKeyPath:@"transform.scale"];
            theAnimation.duration=0.7;
            theAnimation.repeatCount=HUGE_VALF;
            theAnimation.autoreverses=YES;
            theAnimation.fromValue=[NSNumber numberWithFloat:1.0];
            theAnimation.toValue=[NSNumber numberWithFloat:1.3];
            [lblTimer.layer addAnimation:theAnimation forKey:@"transform.scale"]; //animateOpacity
        });
        
    }
    
    
    lblTimer.font = [UIFont fontWithName:APP_FONT_BOLD size:26.0f];

}

#pragma mark -
#pragma mark =======================================
#pragma mark Mail Handling
#pragma mark =======================================

-(void) sendEmail {
    DebugLog(@"");
    if ([[TigglyStampUtils sharedInstance]getSendMailOn]==NO) {
        DebugLog(@"getSendMailOn mode is Off");
        return;
    }
    if ([[TigglyStampUtils sharedInstance]getDebugModeForWriteKeyInCsvOn]==NO) {
        DebugLog(@"getDebugModeForWriteKeyInCsvOn mode is Off");
        return;
    }
    if([[TigglyStampUtils sharedInstance] isMailSupported] == YES) {
        [self dismissModalViewControllerAnimated:NO];
        
        //Shows the email composer view
        MFMailComposeViewController *picker = [[MFMailComposeViewController alloc] init];
        picker.mailComposeDelegate = self;
        [picker setToRecipients:[[NSArray alloc]initWithObjects:@"rohit.kale@cuelogic.co.in",@"amarsinh.asagekar@cuelogic.co.in",@"phyl@tiggly.com", nil]];
        //        [picker setToRecipients:[[NSArray alloc]initWithObjects:@"ninad@cuelogic.co.in",@"amarsinh.asagekar@cuelogic.co.in",@"azi@tiggly.com",@"phyl@tiggly.com", nil]];
        //        [picker setToRecipients:[[NSArray alloc]initWithObjects:@"rohit.kale@cuelogic.co.in", nil]];
        
        NSString *sub;
        NSString *body;
        NSString *filename = NULL;
        
        filename = [NSString stringWithFormat:@"ShapeTouchPoints.csv"];
        sub = [NSString stringWithFormat:@"[Tiggly]: Touch points in debug mode"];
        body =  [NSString stringWithFormat:@"Please find the attachment for the file containing points of shape detection algorithm"];
        
        DebugLog(@"Email Subject: %@",sub);
        DebugLog(@"Email Body: %@",body);
        
        [picker setSubject:sub];
        
        
        [picker addAttachmentData: [[[TigglyStampUtils sharedInstance]getCsvKeys] dataUsingEncoding: NSUTF8StringEncoding]
                         mimeType:@"text/csv" fileName:filename];
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
/*
- (void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error {
	// Notifies users about errors associated with the interface
	switch (result)
	{
		case MFMailComposeResultCancelled:
			break;
		case MFMailComposeResultSaved:
			break;
		case MFMailComposeResultSent:
        {
            NSString *alertTitle = @"Email Sent";
            NSString *alertMsg = @"Report has been mailed successfully";
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:alertTitle message:alertMsg
                                                           delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil,nil];
            [alert show];
			
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
*/

@end
