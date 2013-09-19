//
//  StampViewController.m
//  TigglyStamp
//
//  Created by Sachin Patil on 10/09/13.
//  Copyright (c) 2013 cuelogic. All rights reserved.
//

#import "StampViewController.h"



#define TAG_RIGHT_TICK_BTN 1
#define TAG_CURL_BTN 2
#define TAG_CURL_CONFIRMED_BTN 3

@interface StampViewController (){
    AVAudioRecorder *recorder;
}
@end

@implementation StampViewController

#pragma mark -
#pragma mark =======================================
#pragma mark Synthesize
#pragma mark =======================================

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
@synthesize btnView;

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


XBPageCurlView *pageCurlView;
XBSnappingPoint *bottomSnappingPoint;
BOOL boolIsPageCurled, boolIsTouchMoved;

#pragma mark -
#pragma mark =======================================
#pragma mark Init
#pragma mark =======================================


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil withSceneType:(SceneType) scene{
    DebugLog(@"");
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        sceneType = scene;
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
//    [self addFlippedPageAnimation];

}


- (void)viewDidLoad {
    DebugLog(@"");
    [super viewDidLoad];
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
//    [self.mainView bringSubviewToFront:curlButton];

    
    homeButton.hidden = YES;

//    [curlButton setTag:TAG_CURL_BTN];
    [RigthTickButton setTag:TAG_RIGHT_TICK_BTN];
//    [curlConfirmedButton setTag:TAG_CURL_CONFIRMED_BTN];
    
//    [self configureViewForCurl];
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

    UITapGestureRecognizer *doubleFingerTap =
    [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleDoubleTap:)];
    doubleFingerTap.numberOfTapsRequired = 2;
    [self.videoButton addGestureRecognizer:doubleFingerTap];
    
    UITapGestureRecognizer *doubleFingerTapOnGarbage =
    [[UITapGestureRecognizer alloc] initWithTarget:self  action:@selector(clearScreen:)];
    doubleFingerTapOnGarbage.numberOfTapsRequired = 2;
    [self.garbageCan addGestureRecognizer:doubleFingerTapOnGarbage];
    
    isWithShape = [[TigglyStampUtils sharedInstance] getShapeMode];
    if(!isWithShape) {
        [self displayShapesTray];
//        homeButton.frame = CGRectMake(160, 15, 70, 70);
//        RigthTickButton.frame = CGRectMake(160, 15, 70, 70);
    }else{
//        homeButton.frame = CGRectMake(40, 15, 70, 70);
//        RigthTickButton.frame = CGRectMake(40, 15, 70, 70);
    }
    
}



#pragma mark-
#pragma mark======================
#pragma mark View Orientation
#pragma mark======================

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return UIInterfaceOrientationIsLandscape(interfaceOrientation);
}

-(BOOL)shouldAutorotate{
    return YES;
}

-(NSUInteger)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskLandscape;
}

#pragma mark-
#pragma mark======================
#pragma mark Helpers
#pragma mark======================

- (void) addFlippedPageAnimation
{
    DebugLog(@"");
    
    //to add flipped page eefect at corner
    //    CGRect r = self.viewForCurl.frame;
    //
    //    if(self.curlView == nil){
    //        self.curlView = [[XBCurlView alloc] initWithFrame:r];
    //    }
    //
    //    [self.curlView setUserInteractionEnabled:YES];
    //    self.curlView.opaque = NO;
    //    self.curlView.pageOpaque = YES;
    //    self.curlView.cylinderPosition = CGPointMake(self.viewForCurl.bounds.size.width, self.viewForCurl.bounds.size.height);
    //    [self.curlView curlView:self.viewForCurl cylinderPosition:CGPointMake(970,740) cylinderAngle:3*M_PI_4 cylinderRadius:UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad? 10: 30 animatedWithDuration:0.0];
    
    CATransition *animation = [CATransition animation];
    [animation setDuration:HUGE_VAL];
    animation.type = @"pageUnCurl";
    animation.subtype = kCATransitionFromRight;
    animation.fillMode = kCAFillModeBackwards;
    animation.startProgress = 0.88;
    [animation setRemovedOnCompletion:NO];
    [[[self view] layer] addAnimation:animation forKey:@"pageUnCurl"];
    
}

-(void) displayShapesTray {
    DebugLog(@"");
        
    viewShapesTray= [[UIImageView alloc]initWithFrame:CGRectMake(0,150, 140, 550)];
    viewShapesTray.image = [UIImage imageNamed:@"shape_3.png"];
    viewShapesTray.userInteractionEnabled = YES;
    [self.mainView addSubview:viewShapesTray];
    [self.mainView bringSubviewToFront:viewShapesTray];


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
        [[TDSoundManager sharedManager] playSound:[winterSceneObject getAnimalNameSoundForObject:str] withFormat:@"mp3"];
    }else if (sceneType == kSceneFall){
        
        if(isRecording){
            isGreetingSoundPlaying = NO;
            return;
        }
        
        [[TDSoundManager sharedManager] playSound:[fallSceneObject getAnimalNameSoundForObject:str] withFormat:@"mp3"];
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
    
    [videoButton setBackgroundImage:[UIImage imageNamed:@"record_icon_stop_2"] forState:UIControlStateNormal];
    
    isRecording = YES;
    
    screenCapture.delegate = self;
    [screenCapture startRecording];
    [screenCapture setNeedsDisplay];
    
    [videoButton.layer removeAnimationForKey:@"transform.scale"];
    [videoButton.layer removeAllAnimations];
    
    double delayInSeconds = 0.0;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        CABasicAnimation *theAnimation;
        theAnimation=[CABasicAnimation animationWithKeyPath:@"opacity"];
        theAnimation.duration=1.0;
        theAnimation.repeatCount=HUGE_VALF;
        theAnimation.autoreverses=NO;
        theAnimation.fromValue=[NSNumber numberWithFloat:1.0];
        theAnimation.toValue=[NSNumber numberWithFloat:0.5];
        [videoButton.layer addAnimation:theAnimation forKey:@"opacity"]; //animateOpacity
    });
    
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
        [self hideVideoCameraButtons];
        [RigthTickButton.layer removeAnimationForKey:@"transform.scale"];
        RigthTickButton.hidden = NO;
        cameraButton.hidden = NO;
        videoButton.hidden = NO;
        
        
        UIImageView *tempImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 1024, 768)];
        tempImgView.image = [UIImage imageNamed:@"Tiggly_stamp_Winter_BG.png"];
        [self.mainView addSubview:tempImgView];
        
        [tempImgView genieInTransitionWithDuration:1.0
                                   destinationRect:CGRectMake(970, 660, 10, 10)
                                   destinationEdge:BCRectEdgeTop
                                        completion:^{
                                            [tempImgView removeFromSuperview];
                                        }];
        
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

#pragma mark- ===============================
#pragma mark- Action Handling
#pragma mark- ===============================

-(IBAction)screenShot:(id)sender {
    DebugLog(@"");
    
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
//    [curlButton setHidden:YES];
    
    UIGraphicsBeginImageContext(CGSizeMake(1024, 768));
    [[UIColor whiteColor] set];
    UIRectFill(CGRectMake(0.0, 0.0,1024,768));
    [self.view.layer renderInContext:UIGraphicsGetCurrentContext()];
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    NSDate* currentDate = [NSDate date];
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc]init];
    [dateFormat setDateFormat:@"MM-dd-yyyy_HH:mm:ss"];
    // convert it to a string
    NSString *dateString = [dateFormat stringFromDate:currentDate];
    NSString *imgName = [NSString stringWithFormat:@"TigglyStamp_%@.png",dateString];
    DebugLog(@"Image Name : %@",imgName);
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *savedImagePath = [documentsDirectory stringByAppendingPathComponent:imgName];
    DebugLog(@"Image Path: %@",savedImagePath);
    NSData *imageData = UIImagePNGRepresentation(image);
    BOOL isSuccess = [imageData writeToFile:savedImagePath atomically:YES];
    if(isSuccess)
        DebugLog(@"Imaged saved successfully");
    else
        DebugLog(@"Failed to save the image");
    
    [cameraButton setHidden:NO];
    [videoButton setHidden:NO];
    [garbageCan setHidden:NO];
//    [curlButton setHidden:NO];
    
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
                                              
                                              CapturedImageView *cImageView = [[CapturedImageView alloc] initWithFrame:CGRectMake(0, 0, 1024, 768) ImageName:imgName];
                                              cImageView.delegate = self;
                                              [self.mainView addSubview:cImageView];
                                              [self.mainView bringSubviewToFront:cImageView];
                                              
                                          }];
                     }];
    
}



-(IBAction)onHomeButton:(id)sender{
    [[TDSoundManager sharedManager] stopSound];
    [[TDSoundManager sharedManager] stopMusic];
    [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:1] animated:YES];
}


-(IBAction)onButtonClicked:(id)sender{
    DebugLog(@"");
    UIButton *btn = sender;
    if ([btn tag] == TAG_RIGHT_TICK_BTN) {
        
        [[TDSoundManager sharedManager] playSound:@"Blop_Sound_effect" withFormat:@"mp3"];
        
        [homeButton setHidden:false];
        RigthTickButton.hidden = YES;
        [self.mainView bringSubviewToFront:homeButton];
        
        [NSTimer scheduledTimerWithTimeInterval:0.29 + 0.1 target:self selector:@selector(playDragSound) userInfo:nil repeats:NO];
        
        [self sendEmail];

        [self showVideoCameraButtons];
        
        [tickBtnTimer invalidate];
        [RigthTickButton.layer removeAnimationForKey:@"transform.scale"];
        
        
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
    
    if(isRecording) {
        
        isRecording = NO;
        [videoButton setBackgroundImage:[UIImage imageNamed:@"record_icon_ record"] forState:UIControlStateNormal];
        cameraButton.hidden = NO;
        [screenCapture stopRecording];
        [self screenVideoShotStop];
        
        garbageCan.hidden = NO;
//        curlButton.hidden = NO;
        
        [videoButton.layer removeAnimationForKey:@"opacity"];
        [videoButton.layer removeAllAnimations];
        
        [self hideVideoCameraButtons];
        
    }else{
        
        isRecording = YES;
        
        [[TDSoundManager sharedManager] stopMusic];
        
        [NSThread detachNewThreadSelector:@selector(hideButtons) toTarget:self withObject:nil];
        
        [self playTellUsStorySound];
        
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
        videoButton.hidden = NO;
        cameraButton.hidden = NO;
        
        if (!homeButton.hidden) {
            homeButton.hidden = YES;
        }
    }
    [RigthTickButton.layer removeAnimationForKey:@"transform.scale"];
    [tickBtnTimer invalidate];
    tickBtnTimer = [NSTimer scheduledTimerWithTimeInterval:3.0 target:self selector:@selector(pulseTickButton) userInfo:nil repeats:NO];
    
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
            //[self.view insertSubview:fruit atIndex:1];
            [fruitObjectArray addObject:fruit];
            
            
            NSString *objName = shapeImage;
            DebugLog(@"Object Name : %@", objName);
            
            [continuityTimer invalidate];
            continuityTimer = [NSTimer scheduledTimerWithTimeInterval:0.8 target:self selector:@selector(playGreetingSoundForObject:) userInfo:objName repeats:NO];
            isGreetingSoundPlaying = YES;
            
            [self.mainView bringSubviewToFront:fruit];
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
    
    if(!shouldShapeDetected){
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
        
        if(sceneType == kSceneFall && isRecording) {            
        }else{
            [self playShapeDetectedSound];
        }
        
        
        shapeSoundToPlay = UIT.label;
        if ([shapeSoundTimer isValid]) {
            [shapeSoundTimer invalidate];
        }
        shapeSoundTimer = [NSTimer scheduledTimerWithTimeInterval:1.5f target:self selector:@selector(playSoundForShape) userInfo:nil repeats:NO];
        
        
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
        boolIsPageCurled = YES;
        
        [self.view.layer removeAllAnimations];
        
        UIGraphicsBeginImageContext(CGSizeMake(1024, 768));
        [[UIColor whiteColor] set];
        UIRectFill(CGRectMake(0.0, 0.0,1024,768));
        [self.view.layer renderInContext:UIGraphicsGetCurrentContext()];
        
        UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        self.mainView.hidden = YES;
        
        tempImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 1024, 768)];
        tempImgView.image = image;
        [self.viewForCurl addSubview:tempImgView];
        [self.view bringSubviewToFront:self.viewForCurl];
        
        boolIsTouchMoved = NO;
        
        
        
        return;
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
    CGPoint p = [[touches anyObject] locationInView:touchView];
    if(boolIsPageCurled){
        if(!boolIsTouchMoved){
            boolIsTouchMoved = YES;
            
            [pageCurlView drawViewOnFrontOfPage:self.viewForCurl];
            //            pageCurlView.cylinderPosition =bottomSnappingPoint.position;
            //            pageCurlView.cylinderAngle = bottomSnappingPoint.angle;
            //            pageCurlView.cylinderRadius = bottomSnappingPoint.radius;
            
            pageCurlView.hidden = NO;
            self.viewForCurl.hidden = YES;
            [pageCurlView startAnimating];
            
            [pageCurlView touchBeganAtPoint:p];
            
            curlConfirmedButton.hidden = YES;
            
        }else{
            [pageCurlView touchMovedToPoint:p];
        }
        return;
    }

}

-(void)touchVerificationViewTouchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    DebugLog(@"");
//    isTouchesOnTouchLayer = NO;
    CGPoint p = [[touches anyObject] locationInView:touchView];
    if(boolIsPageCurled){
        boolIsPageCurled = NO;
        
        if(boolIsTouchMoved){
            
            [pageCurlView touchEndedAtPoint:p];
            
            float time = FLOAT_CURL_TIME;
            
            if(p.x < INT_X_LIMIT_TO_FULL_CURL && p.y > INT_Y_LIMIT_TO_FULL_CURL){
                
                time = FLOAT_FULL_CURL_TIME;
                for(FruitView *fruit in fruitObjectArray){
                    [fruit removeFromSuperview];
                }
                
                homeButton.hidden = YES;
                [self hideVideoCameraButtons];
                
                fruitObjectArray = [[NSMutableArray alloc]initWithCapacity:1];
            }
            
            [tempImgView removeFromSuperview];
            
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
            
            [pageCurlView drawViewOnFrontOfPage:self.viewForCurl];
            pageCurlView.cylinderPosition =bottomSnappingPoint.position;
            pageCurlView.cylinderAngle = bottomSnappingPoint.angle;
            pageCurlView.cylinderRadius = bottomSnappingPoint.radius;
            
            pageCurlView.hidden = NO;
            self.viewForCurl.hidden = YES;
            [pageCurlView startAnimating];
            pageCurlView.boolIsPageDragEnabled = YES;
            
            [unCurlTimer invalidate];
            unCurlTimer = [NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(unCurl) userInfo:nil repeats:NO];
            
            curlConfirmedButton.hidden = NO;
        }
        return;
    }
    
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
        CGPoint point = [[touches anyObject] locationInView:touchView];
        [self.mainView bringSubviewToFront:fruit];
        
        [fruit moveObject:touches point:point];
    }
    
    if (isWithShape) {
        [touchView touchesMoved:touches withEvent:nil];
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
    
    if(!isRecording){
        if(CGRectIntersectsRect(fruit.frame, garbageCan.frame)){
            DebugLog(@"Delete Object");
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
            NSString *sound = [winterSceneObject getAnimalDropSoundForObject:fruit.objectName];
            [[TDSoundManager sharedManager] playSound:sound withFormat:@"mp3"];
        }else if (sceneType == kSceneFall) {
            if(isRecording){
                return;
            }
            NSString *sound = [fallSceneObject getAnimalDropSoundForObject:fruit.objectName];
            [[TDSoundManager sharedManager] playSound:sound withFormat:@"mp3"];
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
    
        if(centerX < 140)
            return;
    
        shapeToDraw = nil;

        if(sceneType == kSceneWinter) {
            self.shapes = [[NSMutableArray alloc]initWithArray:[winterSceneObject shapeForObject:phyShapeView.shapeName]];
        }else if (sceneType == kSceneFall){
            self.shapes = [[NSMutableArray alloc]initWithArray:[fallSceneObject shapeForObject:phyShapeView.shapeName]];
        }


        if(shouldShapeDetected){
            shouldShapeDetected = NO;

            [self buildShape:phyShapeView.shapeName];

            if(sceneType == kSceneFall && isRecording) {

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
    RigthTickButton.hidden = YES;

    [self.mainView bringSubviewToFront:btnView];

    [UIView animateWithDuration:0.8 animations:^{
        btnView.frame = CGRectMake(256, 0, 512, 90);
    }completion:^(BOOL finished) {
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
            btnView.frame = CGRectMake(256,-90, 512,90);
        }completion:^(BOOL finished) {
            videoButton.hidden = YES;
            cameraButton.hidden = YES;
            btnView.frame = CGRectMake(-512, 0, 512,90);
        }];
    }

    
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
    
    [self.navigationController popViewControllerAnimated:YES];
    [cImageView removeFromSuperview];
}


-(void) onHomeButtonClicked:(CapturedImageView *)cImageView{
    DebugLog(@"");
    [[TDSoundManager sharedManager] playSound:@"Blop_Sound_effect" withFormat:@"mp3"];
    
    [[TDSoundManager sharedManager] stopMusic];
    
    
    [moviePlayer stop];
    
    [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:1] animated:YES];
    [cImageView removeFromSuperview];
}

-(void) onPlayButtonClicked:(CapturedImageView *)cImageView {
    DebugLog(@"");
    [self playVideo];
    
}


#pragma mark- ===============================
#pragma mark- Video Handling
#pragma mark- ===============================

-(void)screenVideoShotStop {
    DebugLog(@"");
    [cameraButton setHidden:YES];
    [videoButton setHidden:YES];
    [garbageCan setHidden:YES];
    
    NSString *imageStr = [NSString stringWithFormat:@"%@",screenCapture.exportUrl];
    
    ccImageView = [[CapturedImageView alloc] initWithFrame:CGRectMake(0, 0, 1024, 768) ImageName:imageStr];
    ccImageView.delegate = self;
    
    [self.mainView addSubview:ccImageView];
    [self.mainView bringSubviewToFront:ccImageView];
    
    //Create and add the Activity Indicator to splashView
    activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    activityIndicator.alpha = 1.0;
    activityIndicator.color = [UIColor blackColor];
    activityIndicator.center = self.view.center;
    activityIndicator.hidesWhenStopped = NO;
    [self.mainView addSubview:activityIndicator];
    [activityIndicator startAnimating];
    
}

- (void) recordingFinished:(NSString*)outputPathOrNil{
    DebugLog(@"");
    NSURL *url = screenCapture.exportUrl;
    // [self playRandomPraiseSound];
    
    double delayInSeconds = 1.0;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        [self playSlidingSounds];
    });
    
    UIImage *thumbnail = [[TigglyStampUtils sharedInstance] getThumbnailImageOfMovieFile:[url lastPathComponent]];
    ccImageView.imageView.image = thumbnail;
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
    [moviePlayer.view setFrame:CGRectMake(80, 80,820,600)];
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
    
    
    if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"English US"]) {
        
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
    if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"English US"]) {
        
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
            [[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"English US"]){
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
        [[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"English US"]){
        
        int ranNo = arc4random() % 2;
            
            switch (ranNo) {
                case 0:
                    [[TDSoundManager sharedManager] playSound:@"Tiggly_Word_TouchTheScreenWithYourFingerToMakeAPicture_01" withFormat:@"mp3"];
                    break;
                case 1:
                    [[TDSoundManager sharedManager] playSound:@"Tiggly_Word_TouchTheScreenWithYourFinger_01" withFormat:@"mp3"];
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

@end
