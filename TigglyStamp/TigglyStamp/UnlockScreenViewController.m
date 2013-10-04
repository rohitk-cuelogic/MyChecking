//
//  UnlockScreenViewController.m
//  TigglyStamp
//
//  Created by Sachin Patil on 19/09/13.
//  Copyright (c) 2013 cuelogic. All rights reserved.
//

#import "UnlockScreenViewController.h"
#import "TConstant.h"
#import "TigglyStampUtils.h"
#import "TSHomeViewController.h"

#define INSTRUCTION_TEXT1 @"Tap the Tiggly shape on the screen that matches what you see. Once you match 6 shapes in a row, the app will be unlocked."
#define INSTRUCTION_TEXT2 @"Congratulations! You unlocked the full version of Tiggly Stamp. To play the app without the shapes, you can change the settings in parents section."
#define INSTRUCTION_RESTART @"Restart..."

@interface UnlockScreenViewController ()

@end

@implementation UnlockScreenViewController

@synthesize lblAboutTiggly,lblAboutTigglyText,lblRemainingShapes,lblInstructionHead,lblInstructionText;
@synthesize btnBack,btnBuyShapes,btnLearnMore;
@synthesize bkgView;
@synthesize touchView;
@synthesize shapeToBeDetected;


#pragma mark -
#pragma mark =======================================
#pragma mark Init
#pragma mark =======================================

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil entryFrom:(UnlockScreenEntry ) fromScreen withHomeView:(TSHomeViewController *) homeView {
    DebugLog(@"");
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        totalShapes = 6;
        shapeCount = 0;
        countShapeSound = 1;
        
        isPromptDisplayed = NO;
        promptsArray = [[NSMutableArray alloc] initWithObjects:@"circle",@"square",@"triangle",@"star", nil];
        
        screenFrom = fromScreen;
        
        homeViewController = homeView;
    }
    return self;
}

#pragma mark -
#pragma mark =======================================
#pragma mark View Lifecycle
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
    
    [self initializeTouchVerificationView];
    
    [self displayPrompt];
    
    [self.view bringSubviewToFront:btnBack];
    [self.view bringSubviewToFront:btnLearnMore];
    [self.view bringSubviewToFront:btnBuyShapes];
    
    bkgView.layer.cornerRadius = 20.0f;
    bkgView.layer.masksToBounds  =YES;
    
     lblRemainingShapes.text = [NSString stringWithFormat:@"matched %d out of %d",shapeCount, totalShapes];
    
    lblInstructionHead.font = [UIFont fontWithName:APP_FONT_BOLD size:20.0f];
    lblInstructionText.font = [UIFont fontWithName:APP_FONT size:20.0f];
    lblRemainingShapes.font = [UIFont fontWithName:APP_FONT_BOLD size:20.0f];
    lblAboutTiggly.font = [UIFont fontWithName:APP_FONT_BOLD size:20.0f];
    lblAboutTigglyText.font = [UIFont fontWithName:APP_FONT size:17.0f];


}

- (void)didReceiveMemoryWarning {
    DebugLog(@"");
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -
#pragma mark =======================================
#pragma mark  Helpers
#pragma mark =======================================

-(void) initializeTouchVerificationView {
    DebugLog(@"");
    
    if (self.touchView == nil) {
        self.touchView = [[UITouchVerificationView alloc]initWithFrame:CGRectMake(0 , 0, 1024, 768)];
        self.touchView.delegate =self;
        [self.view addSubview:self.touchView];
        [self.view bringSubviewToFront:touchView];
    }
    [self.touchView configure];
    [self.touchView setDelegate:self];
    
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
    
    UITouchShapeRecognizer* starRecognizerNew = [[UITouchShapeRecognizer alloc]initWithPlistfile:@"starData6"];
    [starRecognizerNew setLabel:@"star"];
    
    UITouchShapeRecognizer* circleRecognizer = [[UITouchShapeRecognizer alloc]initWithPlistfile:@"circleData"];
    [circleRecognizer setLabel:@"circle"];
    //    UITouchShapeRecognizer* circle2Recognizer = [[UITouchShapeRecognizer alloc]initWithPlistfile:@"circle2Data"];
    //    [circleRecognizer setLabel:@"circle"];
    UITouchShapeRecognizer* circle3Recognizer = [[UITouchShapeRecognizer alloc]initWithPlistfile:@"circleData3"];
    [circle3Recognizer setLabel:@"circle"];
    
    UITouchShapeRecognizer* triangle2Recognizer = [[UITouchShapeRecognizer alloc]initWithPlistfile:@"triangle2Data"];
    [triangle2Recognizer setLabel:@"triangle"];
    
    UITouchShapeRecognizer* triangle3Recognizer = [[UITouchShapeRecognizer alloc]initWithPlistfile:@"triangleData3"];
    [triangle3Recognizer setLabel:@"triangle"];
    
    UITouchShapeRecognizer* triangleRecognizer = [[UITouchShapeRecognizer alloc]initWithPlistfile:@"triangleData"];
    [triangleRecognizer setLabel:@"triangle"];
    
    // for old star
    [self.touchView loadShape:starRecognizer];
    [self.touchView loadShape:star3Recognizer];
    
    // for new star
    [self.touchView loadShape:starRecognizerNew];
    
    [self.touchView loadShape:triangleRecognizer];
    //[self.touchView loadShape:triangle2Recognizer];
    [self.touchView loadShape:triangle3Recognizer];
    
    [self.touchView loadShape:circleRecognizer];
    //[self.touchView loadShape:circle2Recognizer];
    [self.touchView loadShape:circle3Recognizer];
    
    [self.touchView loadShape:squareRecognizer];
    //[self.touchView loadShape:square2Recognizer];
    [self.touchView loadShape:square3Recognizer];
}


-(void) displayPrompt{
    DebugLog(@"");
    NSString *prompt;
    
    DebugLog(@"ArrCount : %d", promptsArray.count);
    
    if(promptsArray.count != 0) {
        
        int rNo = arc4random()%[promptsArray count];
        prompt = [promptsArray objectAtIndex:rNo];
        [promptsArray removeObjectAtIndex:rNo];
        
    }else{
            int ranNo = arc4random()%4;
        
            
            switch (ranNo) {
                case 0:
                    prompt = @"circle";
                    break;

                case 1:
                    prompt = @"triangle";
                    break;

                case 2:
                    prompt = @"square";
                    break;

                case 3:
                    prompt = @"star";
                    break;

                default:
                    break;
            }
    }
    
    if(shapeCount == 6){
        prompt = @"tick_mark";
        promtView = [[UIImageView alloc] initWithFrame:CGRectMake(215,240,400, 400)];
        promtView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@.png",prompt]];
        promtView.layer.zPosition = 1000;
        [self.view addSubview:promtView];
        isPromptDisplayed = NO;

    }else{
        shapeToBeDetected = prompt;
        promtView = [[UIImageView alloc] initWithFrame:CGRectMake(215,250,400, 400)];
        promtView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@_prompt.png",prompt]];
        promtView.layer.zPosition = 1000;
        [self.view addSubview:promtView];
        isPromptDisplayed = YES;
        
        if([lblInstructionText.text isEqualToString:INSTRUCTION_RESTART]) {
            lblInstructionText.text = INSTRUCTION_TEXT1;

        }
    }
}

-(void) buildShape:(NSString *) shape{
    DebugLog(@"");
    
    [promtView removeFromSuperview];
    promtView = nil;
    isPromptDisplayed = NO;
    
    shapeView = [[UIImageView alloc] initWithFrame:CGRectMake(215,250,400, 400)];
    shapeView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@_shape.png",shape]];
    shapeView.layer.zPosition = 1000;
    [self.view addSubview:shapeView];
    
    double delayInSeconds = 0.8;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        [UIView animateWithDuration:0.0 animations:^{
            shapeView.transform = CGAffineTransformMakeScale(1.0, 1.0);
            
            shapeCount++;
            lblRemainingShapes.text = [NSString stringWithFormat:@"matched %d out of %d",shapeCount, totalShapes];
            //lblInstructionHead.hidden = YES;
            
            if(shapeCount == 6) {
                lblInstructionText.text = INSTRUCTION_TEXT2;
                
                [self setUnlockStatus];
            }
            
        }completion:^(BOOL finished) {
            double delayInSeconds = 1.0;
            dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
            dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
                [shapeView removeFromSuperview];
                shapeView = nil;
                
                double delayInSeconds = 0.5;
                dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
                dispatch_after(popTime, dispatch_get_main_queue(), ^(void){

                    if(shapeCount < 6){
                        [self displayPrompt];
                    }else if (shapeCount == 6){
                        [self displayPrompt];
                    }

                    
                });
            });
        }];
    });

}

-(void) setUnlockStatus{
    DebugLog(@"");
    
    [[TigglyStampUtils sharedInstance] setShapeMode:YES];
    
    [[TigglyStampUtils sharedInstance] unlockAppForShapes:YES];
    
#ifdef GOOGLE_ANALYTICS_START
    NSMutableDictionary *event =
    [[GAIDictionaryBuilder createEventWithCategory:@"App Version"
                                            action:@"App Version"
                                             label:@"Full version"
                                             value:nil] build];
    [[GAI sharedInstance].defaultTracker send:event];
    [[GAI sharedInstance] dispatch];
    
    
    NSMutableDictionary *event1 =
    [[GAIDictionaryBuilder createEventWithCategory:@"App Version"
                                            action:@"Converted customers"
                                             label:@"Unlocked from trial version"
                                             value:nil] build];
    [[GAI sharedInstance].defaultTracker send:event1];
    [[GAI sharedInstance] dispatch];
#else
    
#endif
    

    
    double delayInSeconds = 5.0f;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        if(screenFrom == kScreenEntryFromHomeView){
            [self.navigationController popViewControllerAnimated:YES];
        }else if (screenFrom == kScreenEntryFromIntroView){
            TSHomeViewController *homeView = [[TSHomeViewController alloc] initWithNibName:@"TSHomeViewController" bundle:nil];
            [self.navigationController pushViewController:homeView animated:YES];
        }else if (screenFrom == kScreenEntryFromSettingView){
            [self.navigationController popToViewController:homeViewController animated:YES];
        }

    });
    
    
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

#pragma mark -
#pragma mark =======================================
#pragma mark Action Handling
#pragma mark =======================================

-(IBAction)actionBack {
    DebugLog(@"");
    
    [self.navigationController popViewControllerAnimated:YES];
}


-(IBAction)actionBuyNow {
    DebugLog(@"");
#ifdef GOOGLE_ANALYTICS_START
    NSMutableDictionary *event =
    [[GAIDictionaryBuilder createEventWithCategory:@"Buy shapes"
                                            action:@"Buy now"
                                             label:@"Buy Shape"
                                             value:nil] build];
    [[GAI sharedInstance].defaultTracker send:event];
    [[GAI sharedInstance] dispatch];
#else
    
#endif

    
    
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://tiggly.myshopify.com/products/tiggly-shapes"]];
}

-(IBAction)actionLearnMore {
    DebugLog(@"");
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



#pragma mark -
#pragma mark =======================================
#pragma mark TouchVerification View Delegates
#pragma mark =======================================

-(void)shapeDetected:(UITouchShapeRecognizer*)UIT {
    DebugLog(@"");
    
}

-(void)shapeDetected:(UITouchShapeRecognizer *)UIT inView:(UITouchVerificationView *)view {
    DebugLog(@"");
    DebugLog(@"Physical Shape: %@",UIT.label);
    
    BOOL isSuccess = YES;
    for(UITouch *touch in view.detectedPoints){
        CGPoint tochLocation = [touch locationInView:view];
        if(!CGRectContainsPoint(CGRectMake(90, 100, 655, 600), tochLocation)){
            isSuccess = NO;
        }
    }
    
    if([self.shapeToBeDetected isEqualToString:UIT.label]) {
        if(isPromptDisplayed) {
            if(isSuccess){
                [self buildShape:UIT.label];
                [self playShapeDetectedSound];
            }
             [promptTimer invalidate];
        }
    }else{
        if(isPromptDisplayed) {
            [[TDSoundManager sharedManager] playSound:@"Incorrect_01" withFormat:@"mp3"];
            shapeCount = 0;
            [promptsArray removeAllObjects];
            promptsArray = nil;
            promptsArray = [[NSMutableArray alloc] initWithObjects:@"circle",@"square",@"triangle",@"star", nil];
            lblInstructionText.text = INSTRUCTION_RESTART;
            lblRemainingShapes.text = [NSString stringWithFormat:@"matched %d out of %d",shapeCount, totalShapes];
            [promtView removeFromSuperview];
            promtView = nil;
            
            [promptTimer invalidate];
            promptTimer = [NSTimer scheduledTimerWithTimeInterval:3.0 target:self selector:@selector(displayPrompt) userInfo:nil repeats:NO];
        }
    }
 
}

-(void)shapeRendered:(CALayer *)shape {
    DebugLog(@"");
    
}

-(void)touchVerificationViewTouchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    DebugLog(@"");
    
#ifdef DEBUG_MODE
    if(isPromptDisplayed) {
        [self buildShape:self.shapeToBeDetected];
        [[TDSoundManager sharedManager] playSound:self.shapeToBeDetected withFormat:@"mp3"];
    }
#endif
    
}

-(void)touchVerificationViewTouchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    DebugLog(@"");
    
}


@end
