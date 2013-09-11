//
//  FallSceneViewController.m
//  TigglyStamp
//
//  Created by Sachin Patil on 29/07/13.
//  Copyright (c) 2013 cuelogic. All rights reserved.
//

#import "FallSceneViewController.h"
#import "WinterScene.h"
#import "FruitView.h"
#import "TigglyStampUtils.h"
#import "TDSoundManager.h"

#define TAG_RIGHT_TICK_BTN 1
#define TAG_CURL_BTN 2
#define TAG_CURL_CONFIRMED_BTN 3


@interface FallSceneViewController (){
AVAudioRecorder *recorder;
}
@end

@implementation FallSceneViewController

#pragma mark -
#pragma mark =======================================
#pragma mark Synthesize
#pragma mark =======================================

@synthesize shapes;
@synthesize fruitObjectArray;
@synthesize pointComparison;
@synthesize multiTouchForFruitObject;
@synthesize multiTouchForTouchView;
@synthesize changeToFall;
@synthesize garbageCan;
@synthesize cameraButton;
@synthesize videoButton,curlConfirmedButton;
@synthesize isWithShape,introView,imageView,RigthTickButton,curlButton,mainView,backView, viewForCurl;
@synthesize screenCapture;
@synthesize backButton;
@synthesize isCameraClick;
@synthesize btnView;
@synthesize homeButton;

NSString *shapeToDraw,*prevShape;
NSString *shapeSoundToPlay;
bool bShouldShapeDetected = YES;
float centerX,centerY;
int numOfTouchPts;
int countShapeSound;


UITouchVerificationView * touchView;
int movedObjectAtTime;
NSTimer *unCurlTimer;
NSTimer *tickBtnTimer;
NSTimer *shapeSoundTimer;
UIImageView *tempImgView;

#pragma mark -
#pragma mark =======================================
#pragma mark Init
#pragma mark =======================================


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

#pragma mark -
#pragma mark =======================================
#pragma mark View Life Cycle
#pragma mark =======================================


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    DebugLog(@"Came on view did load from intro screen");
    
    [homeButton setHidden:true];
    
    isWithShape = [[TigglyStampUtils sharedInstance] GetBooleanWithShape];
    
    touchView = [[UITouchVerificationView alloc]initWithFrame:CGRectMake(0, 0, 1024, 768)];
    touchView.isWithShape = [self isWithShape];
    
    isRecording = NO;
    countShapeSound = 1;
    isMoveObject = YES;
    
    isBtnViewHidden = YES;
    self.btnView.frame = CGRectMake(-700, 0, 700, 100);
    
    [self.mainView addSubview:touchView];
    [self.mainView bringSubviewToFront:touchView];
    [self.mainView bringSubviewToFront:changeToFall];
    [self.mainView bringSubviewToFront:cameraButton];
    [self.mainView bringSubviewToFront:videoButton];
    [self.mainView bringSubviewToFront:RigthTickButton];
    [self.mainView bringSubviewToFront:curlButton];
    [self.mainView bringSubviewToFront:backButton];
    
    backButton.hidden = YES;
    homeButton.hidden = YES;
//    [RigthTickButton setHidden:YES];
//    [cameraButton setHidden:YES];
//    [videoButton setHidden:YES];
    [curlButton setTag:TAG_CURL_BTN];
    [RigthTickButton setTag:TAG_RIGHT_TICK_BTN];
    [curlConfirmedButton setTag:TAG_CURL_CONFIRMED_BTN];
    
    [self configureViewForCurl];

    [touchView configure];
    [touchView.layer setZPosition:1];
//    UITouchShapeRecognizer* squareRecognizer = [[UITouchShapeRecognizer alloc]initWithPlistfile:@"squareData"];
//    [squareRecognizer setLabel:@"square"];
//    UITouchShapeRecognizer* square2Recognizer = [[UITouchShapeRecognizer alloc]initWithPlistfile:@"square2Data"];
//    [square2Recognizer setLabel:@"square"];
//    UITouchShapeRecognizer* square3Recognizer = [[UITouchShapeRecognizer alloc]initWithPlistfile:@"squareTwoPointData"];
//    [square3Recognizer setLabel:@"square"];
//    UITouchShapeRecognizer* starRecognizer = [[UITouchShapeRecognizer alloc]initWithPlistfile:@"starData"];
//    [starRecognizer setLabel:@"star"];
//    UITouchShapeRecognizer* star3Recognizer = [[UITouchShapeRecognizer alloc]initWithPlistfile:@"star5Data"];
//    [star3Recognizer setLabel:@"star"];
//    UITouchShapeRecognizer* circleRecognizer = [[UITouchShapeRecognizer alloc]initWithPlistfile:@"circleData"];
//    [circleRecognizer setLabel:@"circle"];
//    UITouchShapeRecognizer* circle2Recognizer = [[UITouchShapeRecognizer alloc]initWithPlistfile:@"circle2Data"];
//    [circleRecognizer setLabel:@"circle"];
//    UITouchShapeRecognizer* circle3Recognizer = [[UITouchShapeRecognizer alloc]initWithPlistfile:@"circleData3"];
//    [circle3Recognizer setLabel:@"circle"];
//    UITouchShapeRecognizer* triangle2Recognizer = [[UITouchShapeRecognizer alloc]initWithPlistfile:@"triangle2Data"];
//    [triangle2Recognizer setLabel:@"triangle"];
//    UITouchShapeRecognizer* triangle3Recognizer = [[UITouchShapeRecognizer alloc]initWithPlistfile:@"triangleData3"];
//    [triangle3Recognizer setLabel:@"triangle"];
//    UITouchShapeRecognizer* triangleRecognizer = [[UITouchShapeRecognizer alloc]initWithPlistfile:@"triangleData"];
//    [triangleRecognizer setLabel:@"triangle"];
//    UITouchShapeRecognizer* strForWringMode = [[UITouchShapeRecognizer alloc]initWithPlistfile:@"starData6"];
//    [strForWringMode setLabel:@"star"];
//    // for old star
//    [touchView loadShape:starRecognizer];
//    [touchView loadShape:star3Recognizer];
//    // for new star
//    [touchView loadShape:strForWringMode];
//    //[touchView loadShape:triangleRecognizer];
//    //[self.touchView loadShape:triangle2Recognizer];
//    [touchView loadShape:triangle3Recognizer];
//    [touchView loadShape:circleRecognizer];
//    [touchView loadShape:circle2Recognizer];
//    [touchView loadShape:circle3Recognizer];
//    //[touchView loadShape:squareRecognizer];
//    //[self.touchView loadShape:square2Recognizer];
//    [touchView loadShape:square3Recognizer];
    
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
    fallSceneObject = [[FallScene alloc]init];
    fallSceneObject.delegate = self;
    fruitObjectArray = [[NSMutableArray alloc]initWithCapacity:1];
    increaseSize = 0;
    garbageCan.frame = CGRectMake(924,644,100,100);
    [self.mainView bringSubviewToFront:garbageCan];
    //new drwan image
    multiTouchForFruitObject = [[NSMutableArray alloc]init];
    multiTouchForTouchView = [[NSMutableArray alloc]init];
    changeToFall.hidden = YES;
      
    UITapGestureRecognizer *doubleFingerTap =
    [[UITapGestureRecognizer alloc] initWithTarget:self
                                            action:@selector(handleDoubleTap:)];
    doubleFingerTap.numberOfTapsRequired = 2;
    [self.videoButton addGestureRecognizer:doubleFingerTap];
    
    UITapGestureRecognizer *doubleFingerTapOnGarbage =
    [[UITapGestureRecognizer alloc] initWithTarget:self
                                            action:@selector(clearScreen:)];
    doubleFingerTapOnGarbage.numberOfTapsRequired = 2;
    [self.garbageCan addGestureRecognizer:doubleFingerTapOnGarbage];
    
//    [[TDSoundManager sharedManager] playMusic:@"Tiggly_SFX_BACKGROUND_AUTUMN" withFormat:@"mp3"];
   
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:YES];
    DebugLog(@"");
    
    isGreetingPlaying = NO;
    
    if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"English UK"] || [[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"English US"]){
        if (isWithShape) {
            [self playShapeinstructionSounds];
        }else{
            [self playFingerInstructionSound];
        }
    }

}

- (void) addCurlAnimation {
    DebugLog(@"");
    
    DebugLog(@"ViewFrame : %@",NSStringFromCGRect(self.view.frame));
    
    
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

- (void)clearScreen:(UITapGestureRecognizer *)sender {
    DebugLog(@"");
    
//    SystemSoundID logoSound = [TDSoundManager createSoundID:@"trashsweep.mp3"];
//    AudioServicesPlayAlertSound(logoSound);
    
     [[TDSoundManager sharedManager] playSound:@"trashsweep" withFormat:@"mp3"];
    
    if (sender.state == UIGestureRecognizerStateRecognized) {
        for(FruitView *f in fruitObjectArray){
            [f removeFromSuperview];
        }
        fruitObjectArray = [[NSMutableArray alloc]initWithCapacity:1];
        homeButton.hidden = YES;
 
        [self hideVideoCameraButtons];
        [RigthTickButton.layer removeAnimationForKey:@"transform.scale"];

        
        UIImageView *tempImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 1024, 768)];
        tempImgView.image = [UIImage imageNamed:@"fallView.png"];
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
- (void)handleDoubleTap:(UITapGestureRecognizer *)sender {

}
 
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
 
#pragma mark-
#pragma mark======================
#pragma mark Landscape Orientation
#pragma mark======================

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return UIInterfaceOrientationIsLandscape(interfaceOrientation);
}

-(BOOL)shouldAutorotate {
    return YES;
}
 
-(NSUInteger)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskLandscape;
}
 

#pragma mark-
#pragma mark======================
#pragma mark UITouchVerification Delegate
#pragma mark======================

-(void)shapeDetected:(UITouchShapeRecognizer *)UIT inView:(UITouchVerificationView*)view{
    DebugLog(@"");
    if(!bShouldShapeDetected){
        NSLog(@"I got the shape but i am returning");
        return;
    }

    // play sound
    
    
    
    
    shapeToDraw = nil;
    self.shapes = [[NSMutableArray alloc]initWithArray:[fallSceneObject shapeForObject:UIT.label]];
    centerX = 0;
    centerY = 0;
    pointComparison = [[NSArray alloc]initWithArray:view.detectedPoints];
    numOfTouchPts = pointComparison.count;

    for(UITouch *touch in view.detectedPoints){
        CGPoint tochLocation = [touch locationInView:touchView];
        centerX = centerX + tochLocation.x;
        centerY = centerY + tochLocation.y;
    }
    if(bShouldShapeDetected){
        bShouldShapeDetected = NO;
        NSLog(@"I got the shape i am displaying");
        [self buildShape:UIT.label];
        [self playShapeDetectedSound];
        
        shapeSoundToPlay = UIT.label;
        if ([shapeSoundTimer isValid]) {
            [shapeSoundTimer invalidate];
        }
        shapeSoundTimer = [NSTimer scheduledTimerWithTimeInterval:1.5f target:self selector:@selector(playSoundForShape) userInfo:nil repeats:NO];
        
//        int64_t delayInSecondsTodetect = 1.5f;
//        dispatch_time_t popTimetoDetect = dispatch_time(DISPATCH_TIME_NOW, delayInSecondsTodetect * NSEC_PER_SEC);
//        dispatch_after(popTimetoDetect, dispatch_get_main_queue(), ^(void){
//           [[TDSoundManager sharedManager] playSound:UIT.label withFormat:@"mp3"];
//        });
 
    }else{
        NSLog(@"I got the shape but dont wanna display");
    }
    int64_t delayInSecondsTodetect = 0.0f;
    dispatch_time_t popTimetoDetect = dispatch_time(DISPATCH_TIME_NOW, delayInSecondsTodetect * NSEC_PER_SEC);
    dispatch_after(popTimetoDetect, dispatch_get_main_queue(), ^(void){
        bShouldShapeDetected = YES;
    });
}
 
#pragma mark-
#pragma mark======================
#pragma mark Game Logic
#pragma mark======================

-(void)configureViewForCurl{
    DebugLog(@"");
    
    [self addCurlAnimation];
    
    [self.view bringSubviewToFront:self.mainView];
}

-(void)buildShape:(NSString *)shape {
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

-(void)thisIsCalledEvery1Second:(NSTimer *)timer {
    if(increaseSize <5){
        increaseSize = increaseSize +1;
        DebugLog(@"increse call %d",increaseSize);
        FruitView *f = timer.userInfo;
        DebugLog(@"Frame to animate %@ ",f.objectName);
        if([f.objectName isEqualToString:@"present"] ||
           [f.objectName isEqualToString:@"sled" ]){
            if(increaseSize == 1)
                [f.layer setTransform:CATransform3DMakeScale(1.1, 1.1, 1.0)];
            if(increaseSize == 2)
                [f.layer setTransform:CATransform3DMakeScale(1.2, 1.2, 1.0)];
            if(increaseSize == 3)
                [f.layer setTransform:CATransform3DMakeScale(1.3, 1.3, 1.0)];
            if(increaseSize == 4)
                [f.layer setTransform:CATransform3DMakeScale(1.4, 1.4, 1.0)];
            if(increaseSize == 5)
                [f.layer setTransform:CATransform3DMakeScale(1.5, 1.5, 1.0)];
        }else{
            if(increaseSize == 1)
                [f.layer setTransform:CATransform3DMakeScale(0.9, 0.9, 1.0)];
            if(increaseSize == 2)
                [f.layer setTransform:CATransform3DMakeScale(0.8, 0.8, 1.0)];
            if(increaseSize == 3)
                [f.layer setTransform:CATransform3DMakeScale(0.7, 0.7, 1.0)];
            if(increaseSize == 4)
                [f.layer setTransform:CATransform3DMakeScale(0.6, 0.6, 1.0)];
            if(increaseSize == 5)
                [f.layer setTransform:CATransform3DMakeScale(0.5, 0.5, 1.0)];
        }
    }
}
 
-(void) randomiseColorOfOrnamment {
    DebugLog(@"");
    int randomNo = random() % 5;
    switch (randomNo) {
        case 0:
            colorOrnament = [UIColor colorWithRed:255.0/255.0 green:0.0/255.0 blue:0.0/255.0 alpha:1];
            break;
            
        case 1:
            colorOrnament = [UIColor colorWithRed:0.0/255.0 green:0.0/255.0 blue:255.0/255.0 alpha:1];
            break;
            
        case 2:
            colorOrnament = [UIColor colorWithRed:255.0/255.0 green:255.0/255.0 blue:0.0/255.0 alpha:1];
            break;
            
        case 3:
            colorOrnament = [UIColor colorWithRed:111.0/255.0 green:0.0/255.0 blue:255.0/255.0 alpha:1];
            break;
            
        case 4:
            colorOrnament = [UIColor colorWithRed:255.0/255.0 green:0.0/255.0 blue:255.0/255.0 alpha:1];
            break;
            
        default:
            break;
    }
    
}
 
-(void)visualizeShapeFromData:(NSArray *)pointComparison andRecognizer:(UITouchShapeRecognizer *)shapeRec withTouchGroup:(UITouchGroup *)group{
    DebugLog(@"");
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
        
//        if([shape isEqualToString:@"triangle"]){
//            //DebugLog(@"triangle");
//            UITouch *touch = [pointComparison objectAtIndex:0];
//            UITouch *compare = [pointComparison objectAtIndex:1];
//            UITouch *reference = [pointComparison objectAtIndex:2];
//            float pointX=0, pointY=0;
//            for(UITouch *t in pointComparison){
//                //DebugLog(@"point=%@",NSStringFromCGPoint([t locationInView:self]));
//                pointX += [t locationInView:self.view].x;
//                pointY += [t locationInView:self.view].y;
//            }
//            midPoint=CGPointMake(pointX / pointComparison.count, pointY / pointComparison.count);
//            
//            if (reference == compare || reference == touch) {
//                int i = 0;
//                while (reference == compare || reference == touch) {
//                    i++;
//                    if (i < [pointComparison count]) {
//                        reference = [pointComparison objectAtIndex:i];
//                    } else {
//                        break;
//                    }
//                    
//                }
//                //DebugLog(@"ERROR fixed");
//            }
//            CGPoint touchLocation1 = [touch locationInView:self.view];
//            CGPoint compareLocation = [compare locationInView:self.view];
//            CGPoint referenceLocation = [reference locationInView:self.view];
//            
//            UIBezierPath *trianglePath;
//            NSMutableArray *newPoints = [[NSMutableArray alloc] init];
//            midPoint=CGPointMake((touchLocation1.x + compareLocation.x + referenceLocation.x)/3,(touchLocation1.y+ compareLocation.y + referenceLocation.y)/3);
//            int i=0;
//            
//            for(UITouch *t in pointComparison){
//                i++;
//                if(i >= pointComparison.count){
//                    i = 0;
//                }
//                CGPoint first = [t locationInView:self.view];
//                CGPoint second = [[pointComparison objectAtIndex:i] locationInView:self.view];
//                CGPoint mid = CGPointMake((first.x + second.x) / 2, (first.y + second.y) / 2);
//                float dist = sqrtf(((first.x - second.x) * (first.x - second.x)) + ((first.y - second.y) * (first.y - second.y)));
//                
//                dist = 110;    //defines size of triangle to be drawn (to get shape same as physical shape, use 'dist += 60;')
//                float offset = (float)abs(midPoint.y - mid.y) / (float)abs(midPoint.x - mid.x);
//                float newX = (dist) * (dist);
//                float temp = (offset) * (offset);
//                temp += 1;
//                newX /= temp;
//                newX = sqrtf(newX);
//                float newY = newX * offset;
//                
//                if(midPoint.x < mid.x){
//                    newX += midPoint.x;
//                }else if(midPoint.x > mid.x){
//                    newX = midPoint.x - newX;
//                    
//                }
//                if(midPoint.y < mid.y){
//                    newY += midPoint.y;
//                }else if(midPoint.y > mid.y){
//                    newY = midPoint.y - newY;
//                }
//                if(offset == 0){
//                    if(midPoint.x < mid.x){
//                        newX = midPoint.x + dist;
//                    }else if(midPoint.x > mid.x){
//                        newX = midPoint.x - dist;
//                    }
//                    newY = midPoint.y;
//                }
//                if(offset == INFINITY){
//                    newX = midPoint.x;
//                    if(midPoint.y < mid.y){
//                        newY = midPoint.y + dist;
//                    }else if(midPoint.y > mid.y){
//                        newY = midPoint.y - dist;
//                    }
//                }
//                [newPoints addObject:[NSValue valueWithCGPoint:CGPointMake(newX, newY)]];
//                DebugLog(@" point of triangle%f %f",newX,newY);
//            }
//            DebugLog(@" point of triangle array %@",newPoints);
//            trianglePath = [[UIBezierPath alloc]init];
//            [trianglePath moveToPoint:[[newPoints objectAtIndex:0] CGPointValue]];
//            [trianglePath addLineToPoint:[[newPoints objectAtIndex:1] CGPointValue]];
//            [trianglePath addLineToPoint:[[newPoints objectAtIndex:2] CGPointValue]];
//            [trianglePath addLineToPoint:[[newPoints objectAtIndex:0] CGPointValue]];
//            [trianglePath closePath];
//            //    }
//            CAShapeLayer *shapeLayer = [CAShapeLayer layer];
//            shapeLayer.backgroundColor = [[UIColor clearColor] CGColor];
//            shapeLayer.borderColor = [[UIColor clearColor] CGColor];
//            shapeLayer.borderWidth = 3.0f;
//            CGPoint midpointoftriangle = CGPointMake((touchLocation1.x + compareLocation.x + referenceLocation.x)/3,(touchLocation1.y+ compareLocation.y + referenceLocation.y)/3);
//            DebugLog(@"Center point %@", NSStringFromCGPoint(midpointoftriangle));
//            shapeLayer.position = midpointoftriangle;
//            shapeLayer.frame = CGRectMake(0, 0, 400, 400);
//            shapeLayer.strokeColor = [UIColor blueColor].CGColor;
//            //if([shapeName isEqualToString:@"triangle"])
//            [shapeLayer setPath:trianglePath.CGPath];
//            [trianglePath closePath];
//            [self.view.layer addSublayer:shapeLayer];
//            [shapeLayer setOpacity:0];
//            
//            
//            CGPoint smallX;
//            smallX = CGPointMake(INFINITY, INFINITY);
//            for (int i = 0; i<newPoints.count;i++){
//                CGPoint point = [[newPoints objectAtIndex:i] CGPointValue];
//                if(smallX.x > point.x){
//                    smallX = point;
//                }
//            }
//            CGPoint bigY = CGPointZero;
//            for (int i = 0; i< newPoints.count;i++){
//                CGPoint point = [[newPoints objectAtIndex:i] CGPointValue];
//                if(!CGPointEqualToPoint(point, smallX)){
//                    if(point.y > bigY.y){
//                        bigY = point;
//                    }
//                }
//            }
//            
//            float hyp = sqrt(pow((bigY.y - smallX.y),2) + pow((bigY.x - smallX.x), 2));
//            float oppSide = abs(bigY.y - smallX.y);
//            angleDiff = asinf(oppSide/hyp);// * 180 / M_PI;
//            if(bigY.y <= smallX.y){
//                angleDiff = -1 * angleDiff;
//            }
//            DebugLog(@"SmallX : %@ BigY : %@",NSStringFromCGPoint(smallX),NSStringFromCGPoint(bigY));
//            DebugLog(@"Hyp : %f Opp : %f",hyp,oppSide);
//            DebugLog(@"AngleDiff : %f",angleDiff);
//        }
//        else if([shape isEqualToString:@"square"]){
//            UITouch *touch = [pointComparison objectAtIndex:0];
//            UITouch *compare = [pointComparison objectAtIndex:1];
//            float pointX=0, pointY=0;
//            for(UITouch *t in pointComparison){
//                //DebugLog(@"point=%@",NSStringFromCGPoint([t locationInView:self]));
//                pointX += [t locationInView:self.view].x;
//                pointY += [t locationInView:self.view].y;
//            }
//            midPoint=CGPointMake(pointX / pointComparison.count, pointY / pointComparison.count);
//            CGPoint touchLocation1 = [touch locationInView:self.view];
//            CGPoint compareLocation = [compare locationInView:self.view];
//            midPoint=CGPointMake((touchLocation1.x + compareLocation.x)/2,(touchLocation1.y+ compareLocation.y)/2);
//            
//            float hyp = sqrt(pow((touchLocation1.y - compareLocation.y),2) + pow((touchLocation1.x - compareLocation.x), 2));
//            float oppSide = abs(compareLocation.y - touchLocation1.y);
//            
//            float sinAngle;
//            
//            sinAngle=oppSide/hyp;
//            sinAngle=asinf(sinAngle);   //sin inverse
//            
//            CGPoint pointUp,pointDown;
//            if(touchLocation1.y <= compareLocation.y){
//                pointUp=touchLocation1;
//                pointDown=compareLocation;
//            }else{
//                pointUp=compareLocation;
//                pointDown=touchLocation1;
//            }
//            if(pointUp.x >= pointDown.x){
//                //DebugLog(@"OK");
//                angleDiff=(45 * M_PI / 180) - sinAngle;
//                
//            }else{
//                //DebugLog(@"Not OK");
//                angleDiff=sinAngle - (135 * M_PI / 180);
//            }
//            //    }
//            CAShapeLayer *square= [CAShapeLayer layer];
//            [square setFrame:CGRectMake(0, 0, 180, 180)];//in old code it was (0, 0, 350, 350)
//            [square setBackgroundColor:[UIColor redColor].CGColor];
//            [square setBorderColor:[UIColor blackColor].CGColor];
//            [square setBorderWidth:3.0f];
//            
//            [self.view.layer addSublayer:square];
//            [square setOpacity:0];
//            [square setPosition:midPoint];
//            [square setValue:[NSNumber numberWithFloat:angleDiff] forKeyPath:@"transform.rotation.z"];
//            
//        }
        
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
        layer.frame = CGRectMake(((centerX/2) - (img.size.width/4)),((centerY/2) - (img.size.height/4)), img.size.width/2.5, img.size.height/2.5);
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
            if([shapeImage isEqualToString:@"horse"]||[shapeImage isEqualToString:@"leaves"]||
               [shapeImage isEqualToString:@"zebra_2"])
                [layer setValue:[NSNumber numberWithFloat:M_PI] forKeyPath:@"transform.rotation.z"];
            else
                [layer setValue:[NSNumber numberWithFloat:0] forKeyPath:@"transform.rotation.z"];
        });
    }
    
    //To animate the triangle to original position as depending on shape
    if([ shape isEqualToString:@"star"]){
        int64_t delayInSecondsTodetect = 1.0;
        dispatch_time_t popTimetoDetect = dispatch_time(DISPATCH_TIME_NOW, delayInSecondsTodetect * NSEC_PER_SEC);
        dispatch_after(popTimetoDetect, dispatch_get_main_queue(), ^(void){
            if([shapeImage isEqualToString:@"green_leaf_2"])
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
            isGreetingPlaying = YES;
            
           // for(FruitView *f in fruitObjectArray){
                [self.mainView bringSubviewToFront:fruit];
                [self.mainView bringSubviewToFront:RigthTickButton];
                [self.mainView bringSubviewToFront:homeButton];
            [self.mainView bringSubviewToFront:videoButton];
            [self.mainView bringSubviewToFront:cameraButton];
            //}
            
            centerX = 0;
            centerY = 0;
            [fallSceneObject removeDrawnShapeObject:shape objectToRemove:shapeImage];
            if([shapeToDraw isEqualToString:@"shooting_star"]){
                if(fruit.frame.origin.y <200){
                    [UIView animateWithDuration:5.0
                                     animations:^{
                                         if(fruit.frame.origin.x>512){
                                             fruit.frame = CGRectMake(150, 600, imgOfShape.size.width, imgOfShape.size.height);
                                         }else{
                                             fruit.frame = CGRectMake(500, 600, imgOfShape.size.width, imgOfShape.size.height);
                                         }
                                         
                                     }
                                     completion:^(BOOL finished){}];
                }
            }
            
        });
    });
    
}

-(void) playGreetingSoundForObject:(NSTimer *) timer {
    DebugLog(@"");
    
    if (isRecording) {
        return;
    }
    
    NSString *str = (NSString *)[timer userInfo];
    [[TDSoundManager sharedManager] playSound:[fallSceneObject getAnimalNameSoundForObject:str] withFormat:@"mp3"];
    
    
    double delayInSeconds = [[TDSoundManager sharedManager] getSoundDuration] + 0.3;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        isGreetingPlaying = NO;
    });

}

-(void)deleteObject {
    
}

/*
 This method is called when user is idle for more than 3 seconds.
 */
-(void)needToShowRightTickButton{
    DebugLog(@"");
    if ([fruitObjectArray count] > 0 ) {
        RigthTickButton.hidden = NO;
        videoButton.hidden = YES;
        cameraButton.hidden = YES;

    }
}
 
#pragma mark-
#pragma mark======================
#pragma mark WinterScene Delegate
#pragma mark======================

-(void)fallSceneDrawObjectForObjectName:(NSString *)objectName{
    DebugLog(@"");
    shapeToDraw = objectName;
    prevShape = objectName;
}
 


#pragma mark-
#pragma mark======================
#pragma mark UITouchVerification TouchDelegate
#pragma mark======================
-(void)touchVerificationViewTouchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    
    DebugLog(@"TouchBegan");

    if (event != nil) {
        // if touch count is greater than 1
        if ([touches count]>0) {
            DebugLog(@"touche count is greater than 1");
            isTouchesOnTouchLayer = YES;
        }
        
    }
    
    if (!isWithShape) {
        int randomNo = arc4random() % 4;
        NSString *shape;
        if (randomNo == 1) {
            shape = @"triangle";
        }else if (randomNo == 2){
            shape = @"square";
        }else if (randomNo == 3){
            shape = @"star";
        }else{
            shape = @"circle";
        }
        
        shapeSoundToPlay = shape;
        

        
        shapeToDraw = nil;
        self.shapes = [[NSMutableArray alloc]initWithArray:[fallSceneObject shapeForObject:shape]];
        centerX = 0;
        centerY = 0;
        CGPoint point = [[touches anyObject] locationInView:touchView];
        centerX = point.x;
        centerY =  point.y;
        if(bShouldShapeDetected){
            bShouldShapeDetected = NO;
            [self buildShape:shape];
             [self playShapeDetectedSound];
            
            double delayInSeconds = 0.7;
            dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
            dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
               // [[TDSoundManager sharedManager] playSound:shape withFormat:@"mp3"];
            });
        }
//        int64_t delayInSecondsTodetect = 0.0f;
//        dispatch_time_t popTimetoDetect = dispatch_time(DISPATCH_TIME_NOW, delayInSecondsTodetect * NSEC_PER_SEC);
//        dispatch_after(popTimetoDetect, dispatch_get_main_queue(), ^(void){
//          
            bShouldShapeDetected = YES;
//        });
        
    }else{
        
    }
}
 
-(void) touchVerificationViewTouchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
    DebugLog(@"The layer to move %@",[currentLayer name]);
}
 
-(void)touchVerificationViewTouchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    DebugLog(@"");

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
    DebugLog(@"FruitTouchBegan");
    

    fruitInitialPoint = fruit.frame.origin;
    
    for (UITouch * touch in touches) {
    }
   
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
    [self.mainView bringSubviewToFront:videoButton];
    [self.mainView bringSubviewToFront:cameraButton];
}

-(void) onFruitView:(FruitView *)fruit touchesEnded:(NSSet *)touches {

    increaseSize =0;
    isMoveObject = YES;
    [multiTouchForFruitObject removeAllObjects];
    
    
    if (isWithShape) {
        [touchView touchesEnded:touches withEvent:nil];
    }
    
    if(!isRecording) {
            if(CGRectIntersectsRect(fruit.frame, garbageCan.frame)){
                DebugLog(@"Delete Object");
                fruit.layer.position = CGPointMake(1024 - garbageCan.frame.size.width/2, 768 - garbageCan.frame.size.height/2);
                DebugLog(@"Frame is %@",NSStringFromCGRect(fruit.frame));
                dispatch_time_t playAudioIn = dispatch_time(DISPATCH_TIME_NOW, 0.05 * NSEC_PER_SEC);
                dispatch_after(playAudioIn, dispatch_get_main_queue(), ^(void){
                    if (!isRecording) {
                         [[TDSoundManager sharedManager] playSound:@"Tiggly_SFX_DELETE_01" withFormat:@"mp3"];
                    }
                   
                    
                });
                fruit.userInteractionEnabled = NO;
                CABasicAnimation *animation4a = nil;
                animation4a = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
                [animation4a setToValue:[NSNumber numberWithDouble:0]];
                [animation4a setFromValue:[NSNumber numberWithDouble:1]];
                [animation4a setAutoreverses:NO];
                [animation4a setDuration:1.5f];
                [animation4a setBeginTime:0.0f];
                [fruit.layer addAnimation:animation4a forKey:@"transform.scale"];
                
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
    
    
    if(fruit.isFruitMovedSufficiently && !isGreetingPlaying && !isRecording){
        NSString *sound = [fallSceneObject getAnimalDropSoundForObject:fruit.objectName];
        [[TDSoundManager sharedManager] playSound:sound withFormat:@"mp3"];
    }

}


-(void) onFruitViewSwipeLeft:(FruitView *) fruit
{
    if(fruit.frame.origin.x  > 1){
        [UIView animateWithDuration:5.0
                         animations:^{
                             fruit.frame = CGRectMake(0, fruit.frame.origin.y+(fruit.frame.size.height/2), fruit.frame.size.width, fruit.frame.size.height);
                         }
                         completion:^(BOOL finished){}];
    }
}
 
-(void) onFruitViewSwipeRight:(FruitView *) fruit {
    DebugLog(@"");
    if(fruit.frame.origin.x + fruit.frame.size.width < 1024){
        [UIView animateWithDuration:5.0
                         animations:^{
                             fruit.frame = CGRectMake(1024 - fruit.frame.size.width, fruit.frame.origin.y+(fruit.frame.size.height/2), fruit.frame.size.width, fruit.frame.size.height);
                             
                         }
                         completion:^(BOOL finished){}];
    }
}


#pragma mark- ===============================
#pragma mark- button touch handling functions
#pragma mark- ===============================
-(void) hideButtons{
    DebugLog(@"");
    
    
    [self.view.layer removeAnimationForKey:@"pageUnCurl"];
    [self.view.layer removeAllAnimations];
    
    
    cameraButton.hidden = YES;
    RigthTickButton.hidden = YES;
   [homeButton setHidden:YES];
    garbageCan.hidden = YES;
    curlButton.hidden = YES;
    cameraButton.hidden = YES;
    
    for(CALayer *layer in btnView.layer.sublayers) {
        [layer removeAnimationForKey:@"transform.scale"];
        [layer removeAllAnimations];
    }
    
    [videoButton setBackgroundImage:[UIImage imageNamed:@"recordingStarted"] forState:UIControlStateNormal];
    
}

-(IBAction)actionRecording:(id)sender {
    DebugLog(@"");
    
    if(isRecording) {

        isRecording = NO;
        [videoButton setBackgroundImage:[UIImage imageNamed:@"recordingStarted"] forState:UIControlStateNormal];
        cameraButton.hidden = NO;
        [screenCapture stopRecording];
        [self screenVideoShotStop];
        
        garbageCan.hidden = NO;
        curlButton.hidden = NO;
        
        [videoButton.layer removeAnimationForKey:@"opacity"];
        [videoButton.layer removeAllAnimations];
        
        [self hideVideoCameraButtons];
        
       // [self addCurlAnimation];
        
    }else{

        isRecording = YES;
        
        [[TDSoundManager sharedManager] stopMusic];
        
        [NSThread detachNewThreadSelector:@selector(hideButtons) toTarget:self withObject:nil];
        
        [self playTellUsStorySound];
    }
    
}

-(void) startScreenRecording{
    isRecording = YES;

    [NSThread detachNewThreadSelector:@selector(hideButtons) toTarget:self withObject:nil];
    
    screenCapture.delegate = self;
    [screenCapture startRecording];
    [screenCapture setNeedsDisplay];
    
    CABasicAnimation *theAnimation;
    theAnimation=[CABasicAnimation animationWithKeyPath:@"opacity"];
    theAnimation.duration=1.0;
    theAnimation.repeatCount=HUGE_VALF;
    theAnimation.autoreverses=NO;
    theAnimation.fromValue=[NSNumber numberWithFloat:1.0];
    theAnimation.toValue=[NSNumber numberWithFloat:0.5];
    [videoButton.layer addAnimation:theAnimation forKey:@"opacity"]; //animateOpacity
}

-(IBAction)screenShot:(id)sender {
    DebugLog(@"");
    
    [[TDSoundManager sharedManager] stopMusic];

    [[[self view] layer] removeAnimationForKey:@"pageUnCurl"];
    [[[self view] layer]removeAllAnimations];
    
    [self hideVideoCameraButtons];
    
    isCameraClick = YES;

    DebugLog(@"");
    UIButton *btn = sender;
    
    if ([btn isHidden]) {
        return;
    }
     [homeButton setHidden:YES];
    [RigthTickButton setHidden:YES];
    [cameraButton setHidden:YES];
    [videoButton setHidden:YES];
    [garbageCan setHidden:YES];
    [curlButton setHidden:YES];
    
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
    [curlButton setHidden:NO];
        

    
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
                                              //[self playRandomPraiseSound];
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

-(IBAction)onBackButtonClicked:(id)sender{
    DebugLog(@"onBackButtonClicked");
    
    introView.isShowLogo = NO;
    if ([self respondsToSelector:@selector(dismissViewControllerAnimated:completion:)]) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }else{
        [self dismissModalViewControllerAnimated:YES];
        
    }
    
}

-(IBAction)onhomeButton:(id)sender{
    [[TDSoundManager sharedManager] stopSound];
    [[TDSoundManager sharedManager] stopMusic];
    [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:1] animated:YES];
}

 

-(IBAction)onButtonClicked:(id)sender{
    DebugLog(@"");
    UIButton *btn = sender;
    if ([btn tag] == TAG_RIGHT_TICK_BTN) {
        
        [[TDSoundManager sharedManager] playSound:@"Blop_Sound_effect" withFormat:@"mp3"];
        
//        [NSTimer scheduledTimerWithTimeInterval:0.29 + 0.1 target:self selector:@selector(playDragSound) userInfo:nil repeats:NO];
        
        [self sendEmail];
        if (![btn isHidden]) {
            RigthTickButton.hidden = YES;
            [homeButton setHidden:false];
            [self.mainView bringSubviewToFront:homeButton];
            
            [self showVideoCameraButtons];
            [tickBtnTimer invalidate];
            [RigthTickButton.layer removeAnimationForKey:@"transform.scale"];
            
        }
        
    }
    if ([btn tag] == TAG_CURL_BTN) {
        RigthTickButton.hidden = NO;
        self.mainView.userInteractionEnabled = NO;
        [[[self view] layer] removeAllAnimations];
        [self hideVideoCameraButtons];
        homeButton.hidden = YES;
        
        UIGraphicsBeginImageContext(CGSizeMake(1024, 768));
        [[UIColor whiteColor] set];
        UIRectFill(CGRectMake(0.0, 0.0,1024,768));
        [self.view.layer renderInContext:UIGraphicsGetCurrentContext()];
        
        UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
        [self.curlView uncurlAnimatedWithDuration:0.0];
        
        
        double delayInSeconds = 0.1;
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
            
            tempImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 1024, 768)];
            tempImgView.image = image;
            [self.viewForCurl addSubview:tempImgView];
            
            [self.view bringSubviewToFront:self.backView];
            self.curlConfirmedButton.hidden = NO;
            
            [self.curlView curlView:self.viewForCurl cylinderPosition:CGPointMake(800,600) cylinderAngle:3*M_PI_4 cylinderRadius:UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad? 100: 70 animatedWithDuration:0.6];
            
            unCurlTimer = [NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(unCurl) userInfo:nil repeats:NO];
            
        });
    }
    
    if ([btn tag] == TAG_CURL_CONFIRMED_BTN) {
        
        self.curlConfirmedButton.hidden = YES;
        [unCurlTimer invalidate];
        
        [[TDSoundManager sharedManager] playSound:@"Tiggly_SFX_PAGETURN" withFormat:@"mp3"];
        
        [self.curlView CurlFullView:1.0];
        
        for(FruitView *fruit in fruitObjectArray){
            [fruit removeFromSuperview];
        }
        [tempImgView removeFromSuperview];
        fruitObjectArray = [[NSMutableArray alloc]initWithCapacity:1];
        [self hideVideoCameraButtons];
//        [videoButton setHidden:YES];
//        [cameraButton setHidden:YES];
//        [RigthTickButton setHidden:YES];
        [homeButton setHidden:YES];
        
        double delayInSecondsTodetect = 1.1f;
        dispatch_time_t popTimetoDetect = dispatch_time(DISPATCH_TIME_NOW, delayInSecondsTodetect * NSEC_PER_SEC);
        dispatch_after(popTimetoDetect, dispatch_get_main_queue(), ^(void){
            [self configureViewForCurl];
            self.mainView.userInteractionEnabled = YES;
            [self.mainView bringSubviewToFront:self.curlButton];
        });

    }
}

-(void) unCurl{
    DebugLog(@"");
    
    self.curlConfirmedButton.hidden = YES;
    [self.curlView uncurlAnimatedWithDuration:0.6];
    
    double delayInSeconds = 0.7;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        [tempImgView removeFromSuperview];
        [self configureViewForCurl];
        self.mainView.userInteractionEnabled = YES;
        [self.view bringSubviewToFront:self.mainView];
    });
    
}

-(void) removeCurl{
    DebugLog(@"");
    [self.curlView removeFromSuperview];
    [self.view sendSubviewToBack:backView];
    [self.view bringSubviewToFront:mainView];
}

-(IBAction)actionBack {
    introView.isShowLogo = NO;
    
      [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:1] animated:YES];
    
}
 
#pragma mark- ===============================
#pragma mark- CapturedImageView Delegates
#pragma mark- ===============================
-(void) onImageClicked:(CapturedImageView *)cImageView{

    [self addCurlAnimation];
    
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

//    SystemSoundID logoSound = [TDSoundManager createSoundID:@"Blop_Sound_effect.mp3"];
//    AudioServicesPlayAlertSound(logoSound);
    
    [[TDSoundManager sharedManager] playSound:@"Blop_Sound_effect" withFormat:@"mp3"];
    
    
    [moviePlayer stop];

    [self.navigationController popViewControllerAnimated:YES];
    [cImageView removeFromSuperview];

}


-(void) onHomeButtonClicked:(CapturedImageView *)cImageView{
    
//    SystemSoundID logoSound = [TDSoundManager createSoundID:@"Blop_Sound_effect.mp3"];
//    AudioServicesPlayAlertSound(logoSound);
    
    [[TDSoundManager sharedManager] playSound:@"Blop_Sound_effect" withFormat:@"mp3"];
    
    [moviePlayer stop];

    [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:1] animated:YES];
    [cImageView removeFromSuperview];
}
 
-(void) onPlayButtonClicked:(CapturedImageView *)cImageView
{
    [self actionPlayVideo];
    
}

//================================================================================================================

#pragma mark -
#pragma mark =======================================
#pragma mark Video and Camera Buttons Handling
#pragma mark =======================================

-(void) showVideoCameraButtons {
    DebugLog(@"");
    
//    isBtnViewHidden = NO;
//    videoButton.hidden = NO;
//    cameraButton.hidden = NO;
//    RigthTickButton.hidden = YES;
//    
//    [self.view bringSubviewToFront:btnView];
//
//    [UIView animateWithDuration:0.8 animations:^{
//        btnView.frame = CGRectMake(162, 0, 700,100);
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
//    

}

-(void) hideVideoCameraButtons {
    DebugLog(@"");
    
//    if(!isRecording) {
//            RigthTickButton.hidden = NO;
//            
//            for(CALayer *layer in btnView.layer.sublayers) {
//                [layer removeAnimationForKey:@"transform.scale"];
//                [layer removeAllAnimations];
//            }
//            isBtnViewHidden = YES;
//            [UIView animateWithDuration:0.3 animations:^{
//                btnView.frame = CGRectMake(162, -100, 700,100);
//            }completion:^(BOOL finished) {
//                videoButton.hidden = YES;
//                cameraButton.hidden = YES;
//                btnView.frame = CGRectMake(-700, 0, 700,100);
//            }];
//    }
//    

}

-(void) pulseTickButton {
    DebugLog(@"");
    
//    CABasicAnimation *animation4a = nil;
//    animation4a = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
//    [animation4a setToValue:[NSNumber numberWithDouble:1.5]];
//    [animation4a setFromValue:[NSNumber numberWithDouble:1]];
//    [animation4a setAutoreverses:YES];
//    [animation4a setDuration:1.5f];
//    [animation4a setBeginTime:0.0f];
//    [animation4a setRepeatCount:HUGE_VAL];
//    [RigthTickButton.layer addAnimation:animation4a forKey:@"transform.scale"];

}


#pragma mark- ===============================
#pragma mark- Play Button Action
#pragma mark- ===============================

-(void)screenVideoShotStop {
    DebugLog(@"");
   
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

- (void) recordingFinished:(NSString*)outputPathOrNil
{    
    NSURL *url = screenCapture.exportUrl;
    //[self playRandomPraiseSound];
    
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

-(void)actionPlayVideo {
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
    
    [moviePlayer.view setFrame:CGRectMake(100, 80,800,600)];
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
#pragma mark- Play sound
#pragma mark- ===============================
-(void) playSlidingSounds{
    
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
    }
    
     [NSTimer scheduledTimerWithTimeInterval:timeToPlayGettingReadySound + 0.2f target:self selector:@selector(startScreenRecording) userInfo:nil repeats:NO];
    
    // schedule playGettingReadyTotellStorySound method after timeToPlayGettingReadySound sec
    
//    [NSTimer scheduledTimerWithTimeInterval:timeToPlayGettingReadySound + 0.4 target:self selector:@selector(playGettingReadyTotellStorySound) userInfo:nil repeats:NO];
}

-(void) playGettingReadyTotellStorySound{
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
        timeToStartVideoRecording = 4.18f;
        [[TDSoundManager sharedManager] playSound:@"321GO!_breng" withFormat:@"mp3"];
    }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"Portuguese"]){
        timeToStartVideoRecording = 2.26f;
        [[TDSoundManager sharedManager] playSound:@"321GO!_prtgs" withFormat:@"mp3"];
    }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"Russian"]){
        timeToStartVideoRecording = 3.94f;
        [[TDSoundManager sharedManager] playSound:@"321GO!_ru" withFormat:@"mp3"];
    }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"Spanish"]){
        timeToStartVideoRecording = 2.47f;
        [[TDSoundManager sharedManager] playSound:@"321GO!_sp" withFormat:@"mp3"];
    }
    
    
    [NSTimer scheduledTimerWithTimeInterval:timeToStartVideoRecording + 0.2f target:self selector:@selector(startScreenRecording) userInfo:nil repeats:NO];
}



-(void) playShapeinstructionSounds{
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

-(void) playFingerInstructionSound{
    int ranNo = arc4random() % 3;
    
    switch (ranNo) {
        case 0:
            [[TDSoundManager sharedManager] playSound:@"Tiggly_Word_TapOnTheScreen_WithYourShape_01" withFormat:@"mp3"];
            break;
        case 1:
            [[TDSoundManager sharedManager] playSound:@"Tiggly_Word_TouchTheScreenWithYourFinger_01" withFormat:@"mp3"];
            break;
        case 2:
            [[TDSoundManager sharedManager] playSound:@"Tiggly_Word_TouchTheScreenWithYourFingerToMakeAPicture_01" withFormat:@"mp3"];
            break;
        default:
            break;
    }
    
    
}

-(void) playDragSound{
    [[TDSoundManager sharedManager] playSound:@"Tiggly_SFX_DragNDrop_DRAG_04" withFormat:@"mp3"];
}

-(void) playShapeDetectedSound{
    DebugLog(@"");
    if (isRecording) {
        return;
    }
    NSString *soundName = [NSString stringWithFormat:@"CakeCandle%d",countShapeSound];
    [[TDSoundManager sharedManager] playSound:soundName withFormat:@"mp3"];
    
    countShapeSound ++;
    if (countShapeSound == 10) {
        countShapeSound = 1;
    }
    
}

-(void) playSoundForShape{
//    [[TDSoundManager sharedManager] playSound:shapeSoundToPlay withFormat:@"mp3"];
}

@end

