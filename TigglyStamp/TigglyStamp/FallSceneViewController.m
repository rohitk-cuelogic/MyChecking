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
@synthesize isWithShape,introView,imageView,RigthTickButton,curlButton,mainView,backView;
@synthesize screenCapture;
@synthesize backButton;
@synthesize isCameraClick;

NSString *shapeToDraw,*prevShape;
bool bShouldShapeDetected = YES;
float centerX,centerY;
UITouchVerificationView * touchView;
int movedObjectAtTime;
NSTimer *showSeasonsTimer;
NSTimer *unCurlTimer;
NSTimer *removeCurlTimer;
bool bStartStopRecorder = YES;

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
    
    isWithShape = [[TigglyStampUtils sharedInstance] GetBooleanWithShape];
    
    touchView = [[UITouchVerificationView alloc]initWithFrame:CGRectMake(0, 0, 1024, 768)];
    touchView.isWithShape = [self isWithShape];
    
        
    isMoveObject = YES;
    
    [self.mainView addSubview:touchView];
    [self.mainView bringSubviewToFront:touchView];
    [self.mainView bringSubviewToFront:changeToFall];
    [self.mainView bringSubviewToFront:cameraButton];
    [self.mainView bringSubviewToFront:videoButton];
    [self.mainView bringSubviewToFront:RigthTickButton];
    [self.mainView bringSubviewToFront:curlButton];
    [self.mainView bringSubviewToFront:backButton];
    
    backButton.hidden = YES;
    [RigthTickButton setHidden:YES];
    [cameraButton setHidden:YES];
    [videoButton setHidden:YES];
    [curlButton setTag:TAG_CURL_BTN];
    [RigthTickButton setTag:TAG_RIGHT_TICK_BTN];
    [curlConfirmedButton setTag:TAG_CURL_CONFIRMED_BTN];
    
    
    [touchView configure];
    [touchView.layer setZPosition:1];
    UITouchShapeRecognizer* squareRecognizer = [[UITouchShapeRecognizer alloc]initWithPlistfile:@"squareData"];
    [squareRecognizer setLabel:@"square"];
    UITouchShapeRecognizer* square2Recognizer = [[UITouchShapeRecognizer alloc]initWithPlistfile:@"square2Data"];
    [square2Recognizer setLabel:@"square"];
    UITouchShapeRecognizer* square3Recognizer = [[UITouchShapeRecognizer alloc]initWithPlistfile:@"squareTwoPointData"];
    [square3Recognizer setLabel:@"square"];
    UITouchShapeRecognizer* starRecognizer = [[UITouchShapeRecognizer alloc]initWithPlistfile:@"starData"];
    [starRecognizer setLabel:@"star"];
    UITouchShapeRecognizer* star3Recognizer = [[UITouchShapeRecognizer alloc]initWithPlistfile:@"star5Data"];
    [star3Recognizer setLabel:@"star"];
    UITouchShapeRecognizer* circleRecognizer = [[UITouchShapeRecognizer alloc]initWithPlistfile:@"circleData"];
    [circleRecognizer setLabel:@"circle"];
    UITouchShapeRecognizer* circle2Recognizer = [[UITouchShapeRecognizer alloc]initWithPlistfile:@"circle2Data"];
    [circleRecognizer setLabel:@"circle"];
    UITouchShapeRecognizer* circle3Recognizer = [[UITouchShapeRecognizer alloc]initWithPlistfile:@"circleData3"];
    [circle3Recognizer setLabel:@"circle"];
    UITouchShapeRecognizer* triangle2Recognizer = [[UITouchShapeRecognizer alloc]initWithPlistfile:@"triangle2Data"];
    [triangle2Recognizer setLabel:@"triangle"];
    UITouchShapeRecognizer* triangle3Recognizer = [[UITouchShapeRecognizer alloc]initWithPlistfile:@"triangleData3"];
    [triangle3Recognizer setLabel:@"triangle"];
    UITouchShapeRecognizer* triangleRecognizer = [[UITouchShapeRecognizer alloc]initWithPlistfile:@"triangleData"];
    [triangleRecognizer setLabel:@"triangle"];
    UITouchShapeRecognizer* strForWringMode = [[UITouchShapeRecognizer alloc]initWithPlistfile:@"starData6"];
    [strForWringMode setLabel:@"star"];
    // for old star
    [touchView loadShape:starRecognizer];
    [touchView loadShape:star3Recognizer];
    // for new star
    [touchView loadShape:strForWringMode];
    //[touchView loadShape:triangleRecognizer];
    //[self.touchView loadShape:triangle2Recognizer];
    [touchView loadShape:triangle3Recognizer];
    [touchView loadShape:circleRecognizer];
    [touchView loadShape:circle2Recognizer];
    [touchView loadShape:circle3Recognizer];
    //[touchView loadShape:squareRecognizer];
    //[self.touchView loadShape:square2Recognizer];
    [touchView loadShape:square3Recognizer];
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
    
//    // Set the audio file name
//    //Check the already created files
//    NSString *documentDirPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
//    // create directory named "test"
//    [[NSFileManager defaultManager] createDirectoryAtPath:[documentDirPath stringByAppendingPathComponent:@"tigglyAudio"] withIntermediateDirectories:YES attributes:nil error:nil];
//    // retrieved all directories
//    DebugLog(@"%@", [[NSFileManager defaultManager] contentsOfDirectoryAtPath:documentDirPath error:nil]);
//    
//    NSArray *paths = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:documentDirPath error:nil];
//    DebugLog(@"Total files recorded are %d",paths.count);
//    NSString* a = @"tigglyAudio";
//    NSString *fileNameToRecord = [NSString stringWithFormat:@"%@%d.m4a",a,paths.count];
//    NSArray *pathComponents = [NSArray arrayWithObjects:
//                               [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject],
//                               fileNameToRecord,
//                               nil];
//    NSURL *outputFileURL = [NSURL fileURLWithPathComponents:pathComponents];
//    
//    // Setup audio session
//    AVAudioSession *session = [AVAudioSession sharedInstance];
//    [session setCategory:AVAudioSessionCategoryPlayAndRecord error:nil];
//    
//    // Define the recorder setting
//    NSMutableDictionary *recordSetting = [[NSMutableDictionary alloc] init];
//    
//    [recordSetting setValue:[NSNumber numberWithInt:kAudioFormatMPEG4AAC] forKey:AVFormatIDKey];
//    [recordSetting setValue:[NSNumber numberWithFloat:44100.0] forKey:AVSampleRateKey];
//    [recordSetting setValue:[NSNumber numberWithInt: 2] forKey:AVNumberOfChannelsKey];
//    
//    // Initiate and prepare the recorder
//    recorder = [[AVAudioRecorder alloc] initWithURL:outputFileURL settings:recordSetting error:NULL];
//    recorder.delegate = self;
//    recorder.meteringEnabled = YES;
//    [recorder prepareToRecord];
    

    CABasicAnimation *theAnimation;
    
    theAnimation=[CABasicAnimation animationWithKeyPath:@"opacity"];
    theAnimation.duration=1.0;
    theAnimation.repeatCount=HUGE_VALF;
    theAnimation.autoreverses=YES;
    theAnimation.fromValue=[NSNumber numberWithFloat:1.0];
    theAnimation.toValue=[NSNumber numberWithFloat:0.2];
    [RigthTickButton.layer addAnimation:theAnimation forKey:@"animateLayer"]; //animateOpacity
}

- (void)clearScreen:(UITapGestureRecognizer *)sender {
    DebugLog(@"");
    if (sender.state == UIGestureRecognizerStateRecognized) {
        for(FruitView *f in fruitObjectArray){
            [f removeFromSuperview];
        }
        fruitObjectArray = [[NSMutableArray alloc]initWithCapacity:1];
    }
    else{
        
    }
}
- (void)handleDoubleTap:(UITapGestureRecognizer *)sender {
//    if (sender.state == UIGestureRecognizerStateRecognized) {
//        if(bStartStopRecorder){
//            DebugLog(@"double tapped");
//            DebugLog(@"Recording on");
//            bStartStopRecorder = NO;
//            if (player.playing) {
//                [player stop];
//            }
//            
//            if (!recorder.recording) {
//                AVAudioSession *session = [AVAudioSession sharedInstance];
//                [session setActive:YES error:nil];
//                
//                // Start recording
//                [recorder record];
//                //            [recordPauseButton setTitle:@"Pause" forState:UIControlStateNormal];
//                
//            } else {
//                
//                // Pause recording
//                [recorder pause];
//                //            [recordPauseButton setTitle:@"Record" forState:UIControlStateNormal];
//            }
//        }else{
//            [recorder stop];
//            DebugLog(@"Recording off");
//            bStartStopRecorder = YES;
//            AVAudioSession *audioSession = [AVAudioSession sharedInstance];
//            [audioSession setActive:NO error:nil];
//        }
//    }
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
    shapeToDraw = nil;
    self.shapes = [[NSMutableArray alloc]initWithArray:[fallSceneObject shapeForObject:UIT.label]];
    centerX = 0;
    centerY = 0;
    pointComparison = [[NSArray alloc]initWithArray:view.detectedPoints];
    for(UITouch *touch in view.detectedPoints){
        CGPoint tochLocation = [touch locationInView:touchView];
        centerX = centerX + tochLocation.x;
        centerY = centerY + tochLocation.y;
    }
    if(bShouldShapeDetected){
        bShouldShapeDetected = NO;
        NSLog(@"I got the shape i am displaying");
        [self buildShape:UIT.label];
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

-(void)buildShape:(NSString *)shape {
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
        midPoint = CGPointMake(((centerX/3)),((centerY/3)));
        
        if([shape isEqualToString:@"triangle"]){
            //DebugLog(@"triangle");
            UITouch *touch = [pointComparison objectAtIndex:0];
            UITouch *compare = [pointComparison objectAtIndex:1];
            UITouch *reference = [pointComparison objectAtIndex:2];
            float pointX=0, pointY=0;
            for(UITouch *t in pointComparison){
                //DebugLog(@"point=%@",NSStringFromCGPoint([t locationInView:self]));
                pointX += [t locationInView:self.view].x;
                pointY += [t locationInView:self.view].y;
            }
            midPoint=CGPointMake(pointX / pointComparison.count, pointY / pointComparison.count);
            
            if (reference == compare || reference == touch) {
                int i = 0;
                while (reference == compare || reference == touch) {
                    i++;
                    if (i < [pointComparison count]) {
                        reference = [pointComparison objectAtIndex:i];
                    } else {
                        break;
                    }
                    
                }
                //DebugLog(@"ERROR fixed");
            }
            CGPoint touchLocation1 = [touch locationInView:self.view];
            CGPoint compareLocation = [compare locationInView:self.view];
            CGPoint referenceLocation = [reference locationInView:self.view];
            
            UIBezierPath *trianglePath;
            NSMutableArray *newPoints = [[NSMutableArray alloc] init];
            midPoint=CGPointMake((touchLocation1.x + compareLocation.x + referenceLocation.x)/3,(touchLocation1.y+ compareLocation.y + referenceLocation.y)/3);
            int i=0;
            
            for(UITouch *t in pointComparison){
                i++;
                if(i >= pointComparison.count){
                    i = 0;
                }
                CGPoint first = [t locationInView:self.view];
                CGPoint second = [[pointComparison objectAtIndex:i] locationInView:self.view];
                CGPoint mid = CGPointMake((first.x + second.x) / 2, (first.y + second.y) / 2);
                float dist = sqrtf(((first.x - second.x) * (first.x - second.x)) + ((first.y - second.y) * (first.y - second.y)));
                
                dist = 110;    //defines size of triangle to be drawn (to get shape same as physical shape, use 'dist += 60;')
                float offset = (float)abs(midPoint.y - mid.y) / (float)abs(midPoint.x - mid.x);
                float newX = (dist) * (dist);
                float temp = (offset) * (offset);
                temp += 1;
                newX /= temp;
                newX = sqrtf(newX);
                float newY = newX * offset;
                
                if(midPoint.x < mid.x){
                    newX += midPoint.x;
                }else if(midPoint.x > mid.x){
                    newX = midPoint.x - newX;
                    
                }
                if(midPoint.y < mid.y){
                    newY += midPoint.y;
                }else if(midPoint.y > mid.y){
                    newY = midPoint.y - newY;
                }
                if(offset == 0){
                    if(midPoint.x < mid.x){
                        newX = midPoint.x + dist;
                    }else if(midPoint.x > mid.x){
                        newX = midPoint.x - dist;
                    }
                    newY = midPoint.y;
                }
                if(offset == INFINITY){
                    newX = midPoint.x;
                    if(midPoint.y < mid.y){
                        newY = midPoint.y + dist;
                    }else if(midPoint.y > mid.y){
                        newY = midPoint.y - dist;
                    }
                }
                [newPoints addObject:[NSValue valueWithCGPoint:CGPointMake(newX, newY)]];
                DebugLog(@" point of triangle%f %f",newX,newY);
            }
            DebugLog(@" point of triangle array %@",newPoints);
            trianglePath = [[UIBezierPath alloc]init];
            [trianglePath moveToPoint:[[newPoints objectAtIndex:0] CGPointValue]];
            [trianglePath addLineToPoint:[[newPoints objectAtIndex:1] CGPointValue]];
            [trianglePath addLineToPoint:[[newPoints objectAtIndex:2] CGPointValue]];
            [trianglePath addLineToPoint:[[newPoints objectAtIndex:0] CGPointValue]];
            [trianglePath closePath];
            //    }
            CAShapeLayer *shapeLayer = [CAShapeLayer layer];
            shapeLayer.backgroundColor = [[UIColor clearColor] CGColor];
            shapeLayer.borderColor = [[UIColor clearColor] CGColor];
            shapeLayer.borderWidth = 3.0f;
            CGPoint midpointoftriangle = CGPointMake((touchLocation1.x + compareLocation.x + referenceLocation.x)/3,(touchLocation1.y+ compareLocation.y + referenceLocation.y)/3);
            DebugLog(@"Center point %@", NSStringFromCGPoint(midpointoftriangle));
            shapeLayer.position = midpointoftriangle;
            shapeLayer.frame = CGRectMake(0, 0, 400, 400);
            shapeLayer.strokeColor = [UIColor blueColor].CGColor;
            //if([shapeName isEqualToString:@"triangle"])
            [shapeLayer setPath:trianglePath.CGPath];
            [trianglePath closePath];
            [self.view.layer addSublayer:shapeLayer];
            [shapeLayer setOpacity:0];
            
            
            CGPoint smallX;
            smallX = CGPointMake(INFINITY, INFINITY);
            for (int i = 0; i<newPoints.count;i++){
                CGPoint point = [[newPoints objectAtIndex:i] CGPointValue];
                if(smallX.x > point.x){
                    smallX = point;
                }
            }
            CGPoint bigY = CGPointZero;
            for (int i = 0; i< newPoints.count;i++){
                CGPoint point = [[newPoints objectAtIndex:i] CGPointValue];
                if(!CGPointEqualToPoint(point, smallX)){
                    if(point.y > bigY.y){
                        bigY = point;
                    }
                }
            }
            
            float hyp = sqrt(pow((bigY.y - smallX.y),2) + pow((bigY.x - smallX.x), 2));
            float oppSide = abs(bigY.y - smallX.y);
            angleDiff = asinf(oppSide/hyp);// * 180 / M_PI;
            if(bigY.y <= smallX.y){
                angleDiff = -1 * angleDiff;
            }
            DebugLog(@"SmallX : %@ BigY : %@",NSStringFromCGPoint(smallX),NSStringFromCGPoint(bigY));
            DebugLog(@"Hyp : %f Opp : %f",hyp,oppSide);
            DebugLog(@"AngleDiff : %f",angleDiff);
        }
        else if([shape isEqualToString:@"square"]){
            UITouch *touch = [pointComparison objectAtIndex:0];
            UITouch *compare = [pointComparison objectAtIndex:1];
            float pointX=0, pointY=0;
            for(UITouch *t in pointComparison){
                //DebugLog(@"point=%@",NSStringFromCGPoint([t locationInView:self]));
                pointX += [t locationInView:self.view].x;
                pointY += [t locationInView:self.view].y;
            }
            midPoint=CGPointMake(pointX / pointComparison.count, pointY / pointComparison.count);
            CGPoint touchLocation1 = [touch locationInView:self.view];
            CGPoint compareLocation = [compare locationInView:self.view];
            midPoint=CGPointMake((touchLocation1.x + compareLocation.x)/2,(touchLocation1.y+ compareLocation.y)/2);
            
            float hyp = sqrt(pow((touchLocation1.y - compareLocation.y),2) + pow((touchLocation1.x - compareLocation.x), 2));
            float oppSide = abs(compareLocation.y - touchLocation1.y);
            
            float sinAngle;
            
            sinAngle=oppSide/hyp;
            sinAngle=asinf(sinAngle);   //sin inverse
            
            CGPoint pointUp,pointDown;
            if(touchLocation1.y <= compareLocation.y){
                pointUp=touchLocation1;
                pointDown=compareLocation;
            }else{
                pointUp=compareLocation;
                pointDown=touchLocation1;
            }
            if(pointUp.x >= pointDown.x){
                //DebugLog(@"OK");
                angleDiff=(45 * M_PI / 180) - sinAngle;
                
            }else{
                //DebugLog(@"Not OK");
                angleDiff=sinAngle - (135 * M_PI / 180);
            }
            //    }
            CAShapeLayer *square= [CAShapeLayer layer];
            [square setFrame:CGRectMake(0, 0, 180, 180)];//in old code it was (0, 0, 350, 350)
            [square setBackgroundColor:[UIColor redColor].CGColor];
            [square setBorderColor:[UIColor blackColor].CGColor];
            [square setBorderWidth:3.0f];
            
            [self.view.layer addSublayer:square];
            [square setOpacity:0];
            [square setPosition:midPoint];
            [square setValue:[NSNumber numberWithFloat:angleDiff] forKeyPath:@"transform.rotation.z"];
            
        }
        
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
        layer.frame = CGRectMake(((centerX/2) - (img.size.width/4)),((centerY/2) - (img.size.height/4)), img.size.width/2, img.size.height/2);
    }else{
        layer.frame = CGRectMake(((centerX/3) - (img.size.width/4)),((centerY/3) - (img.size.height/4)), img.size.width/2, img.size.height/2);
        
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
            for(FruitView *f in fruitObjectArray){
                [self.mainView bringSubviewToFront:f];
            }
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
 
-(void)deleteObject {
    
}
 
/*
 This method is called when user is idle for more than 3 seconds.
 */
-(void)needToShowRightTickButton{
    DebugLog(@"");
    if ([fruitObjectArray count] > 0 && [videoButton isHidden]) {
        RigthTickButton.hidden = NO;
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
    RigthTickButton.hidden = YES;
    [showSeasonsTimer invalidate];
    
    if (event != nil) {
        // if touch count is greater than 1
        if ([touches count]>0) {
            DebugLog(@"touche count is greater than 1");
            isTouchesOnTouchLayer = YES;
        }
        
    }
    
    if (!isWithShape) {
        int randomNo = random() % 4;
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
        }
        int64_t delayInSecondsTodetect = 0.8f;
        dispatch_time_t popTimetoDetect = dispatch_time(DISPATCH_TIME_NOW, delayInSecondsTodetect * NSEC_PER_SEC);
        dispatch_after(popTimetoDetect, dispatch_get_main_queue(), ^(void){
            bShouldShapeDetected = YES;
        });
        
    }else{
        
    }
}
 
-(void) touchVerificationViewTouchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
    DebugLog(@"The layer to move %@",[currentLayer name]);
}
 
-(void)touchVerificationViewTouchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    DebugLog(@"");
    [showSeasonsTimer invalidate];
    isTouchesOnTouchLayer = NO;
    showSeasonsTimer = [NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(needToShowRightTickButton) userInfo:nil repeats:NO];
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
    RigthTickButton.hidden = YES;
    [showSeasonsTimer invalidate];
    //    [multiTouchForFruitObject addObject:touches];
    for (UITouch * touch in touches) {
    }
    //    if([multiTouchForFruitObject count]==1){
    //        [self.view sendSubviewToBack:touchView];
    //    }
    if (isWithShape) {
        [touchView touchesBegan:touches withEvent:nil];
    }
    
}
 
-(void) onFruitView:(FruitView *)fruit touchesMoved:(NSSet *)touches {
    DebugLog(@"");
    for (UITouch * touch in touches) {
    }
    if (isTouchesOnTouchLayer) {
        isMoveObject = NO;
    }
    //    if([multiTouchForFruitObject count]>1){
    //         [multiTouchForFruitObject addObject:touches];
    //        [self.view bringSubviewToFront:touchView];
    //        [multiTouchForFruitObject removeAllObjects];
    //    }
    //    else{
    //         [self.view bringSubviewToFront:fruit];
    //    }
    
    if (isMoveObject) {
        CGPoint point = [[touches anyObject] locationInView:touchView];
        [self.mainView bringSubviewToFront:fruit];
        [fruit moveObject:touches point:point];
    }
    
    if (isWithShape) {
        [touchView touchesMoved:touches withEvent:nil];
    }
    
    
}
 
-(void) onFruitView:(FruitView *)fruit touchesEnded:(NSSet *)touches {
    //    [inactivityTimer invalidate];
    increaseSize =0;
    isMoveObject = YES;
    //    [fruit.layer setTransform:CATransform3DMakeScale(1.0, 1.0, 1.0)];
    [multiTouchForFruitObject removeAllObjects];
    if(CGRectIntersectsRect(fruit.frame, garbageCan.frame)){
        //called delete Object method
        DebugLog(@"Delete Object");
        fruit.layer.position = CGPointMake(1024 - garbageCan.frame.size.width/2, 768 - garbageCan.frame.size.height/2);
        DebugLog(@"Frame is %@",NSStringFromCGRect(fruit.frame));
        dispatch_time_t playAudioIn = dispatch_time(DISPATCH_TIME_NOW, 0.1 * NSEC_PER_SEC);
        dispatch_after(playAudioIn, dispatch_get_main_queue(), ^(void){
            [KTViewController playMusic:@"trashsweep" withFormat:@"mp3"];
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
        
    }
    [showSeasonsTimer invalidate];
    showSeasonsTimer = [NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(needToShowRightTickButton) userInfo:nil repeats:NO];
    
    if (isWithShape) {
        [touchView touchesEnded:touches withEvent:nil];
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

-(IBAction)actionRecording:(id)sender {
    DebugLog(@"");
    if(isRecording) {
        isRecording = NO;
        [videoButton setBackgroundImage:[UIImage imageNamed:@"recordingStarted"] forState:UIControlStateNormal];
        cameraButton.hidden = NO;
        [screenCapture stopRecording];
        [self screenVideoShotStop];
        
        [videoButton.layer removeAllAnimations];
        
    }else{
        isRecording = YES;
        [videoButton setBackgroundImage:[UIImage imageNamed:@"recordingStarted"] forState:UIControlStateNormal];
        cameraButton.hidden = YES;
        screenCapture.delegate = self;
        [screenCapture startRecording];
        [screenCapture setNeedsDisplay];
        
        CABasicAnimation *theAnimation;
        theAnimation=[CABasicAnimation animationWithKeyPath:@"opacity"];
        theAnimation.duration=1.0;
        theAnimation.repeatCount=HUGE_VALF;
        theAnimation.autoreverses=YES;
        theAnimation.fromValue=[NSNumber numberWithFloat:1.0];
        theAnimation.toValue=[NSNumber numberWithFloat:0.1];
        [videoButton.layer addAnimation:theAnimation forKey:@"animateLayer"]; //animateOpacity
        
    }
    
}

-(IBAction)screenShot:(id)sender {
    
    isCameraClick = YES;

    DebugLog(@"");
    UIButton *btn = sender;
    
    if ([btn isHidden]) {
        return;
    }
    
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
        
    [KTViewController playMusic:@"camera_click" withFormat:@"mp3"];
    
    UIView *flashView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 1024, 768)];
    flashView.backgroundColor = [UIColor whiteColor];
    flashView.alpha = 0;
    [self.view addSubview:flashView];
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

 

-(IBAction)onButtonClicked:(id)sender{
    DebugLog(@"");
    UIButton *btn = sender;
    if ([btn tag] == TAG_RIGHT_TICK_BTN) {
        [self sendEmail];
        if (![btn isHidden]) {
            [RigthTickButton setHidden:YES];
            [cameraButton setHidden:NO];
            [videoButton setHidden:NO];
        }
        
    }
    if ([btn tag] == TAG_CURL_BTN) {
        CGRect r = self.imageView.frame;
        [self.view bringSubviewToFront:backView];
        
        self.curlView = [[XBCurlView alloc] initWithFrame:r];
        self.curlView.opaque = NO;
        self.curlView.pageOpaque = YES;
        self.curlView.cylinderPosition = CGPointMake(self.mainView.bounds.size.width, self.mainView.bounds.size.height);
        [self.curlView curlView:self.mainView cylinderPosition:CGPointMake(800,600) cylinderAngle:3*M_PI_4 cylinderRadius:UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad? 100: 70 animatedWithDuration:0.6];
        
        unCurlTimer = [NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(unCurl) userInfo:nil repeats:NO];
    }
    
    if ([btn tag] == TAG_CURL_CONFIRMED_BTN) {
        
        [unCurlTimer invalidate];
        
        [self.curlView CurlFullView:1.2];
        [self.view sendSubviewToBack:backView];
        
        for(FruitView *fruit in fruitObjectArray){
            [fruit removeFromSuperview];
        }
        fruitObjectArray = [[NSMutableArray alloc]initWithCapacity:1];
        //[RigthTickButton setHidden:YES];

    }
}

-(void) unCurl{
    DebugLog(@"");
    
    [self.curlView uncurlAnimatedWithDuration:0.6];
    [self.view sendSubviewToBack:backView];
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
//    if(isCameraClick == YES) {
//        [cImageView removeFromSuperview];
//        isCameraClick = NO;
//    }
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
    [cImageView removeFromSuperview];
    for(FruitView *fruit in fruitObjectArray){
        [fruit removeFromSuperview];
    }
    fruitObjectArray = [[NSMutableArray alloc]initWithCapacity:1];
    [cameraButton setHidden:YES];
    [videoButton setHidden:YES];
    [RigthTickButton setHidden:YES];

}


-(void) onHomeButtonClicked:(CapturedImageView *)cImageView{
    
    [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:1] animated:YES];
    [cImageView removeFromSuperview];
}
 
-(void) onPlayButtonClicked:(CapturedImageView *)cImageView
{
    [self actionPlayVideo];
    
}

//================================================================================================================
#pragma mark- ===============================
#pragma mark- Play Button Action
#pragma mark- ===============================
-(void)screenVideoShotStop {
    DebugLog(@"");
//    [cameraButton setHidden:YES];
//    [videoButton setHidden:YES];
//    [garbageCan setHidden:YES];
//    [curlButton setHidden:YES];
    
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
    
    UIImage *thumbnail = [[TigglyStampUtils sharedInstance] getThumbnailImageOfMovieFile:[url lastPathComponent]];
    ccImageView.imageView.image = thumbnail;
    [activityIndicator removeFromSuperview];
    ccImageView.btnPlay.hidden = NO;
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
    
    moviePlayer.controlStyle = MPMovieControlStyleDefault;
    moviePlayer.shouldAutoplay = YES;
    [self.view addSubview:moviePlayer.view];
    [moviePlayer setFullscreen:YES animated:YES];
    
    double delayInSeconds = 0.5;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        
    });
    
    
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


@end
