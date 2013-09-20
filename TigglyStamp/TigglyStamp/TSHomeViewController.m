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

@interface TSHomeViewController ()

@end

@implementation TSHomeViewController
@synthesize imgScrollView;
@synthesize bkgImageView;
@synthesize containerView;

UISwipeGestureRecognizer *mSwpeRecognizer;
BOOL readyToParentScreen, readyToNewsScreen,readyToDeleteThumbnail;
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

- (void)viewDidLoad {
    DebugLog(@"");
    [super viewDidLoad];
    
    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"firstLaunch"];

    
    // Do any additional setup after loading the view from its nib.
    imgScrollView.frame = CGRectMake(0,768 - (RECT_THUMBNAIL_FRAME.size.height + 40), 1024, RECT_THUMBNAIL_FRAME.size.height + 40);
    
    mSwpeRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swippedforConfirmation)];
    [mSwpeRecognizer setDirection:UISwipeGestureRecognizerDirectionRight];
    [mSwpeRecognizer setNumberOfTouchesRequired:2];
    [self.view addGestureRecognizer:mSwpeRecognizer];
    
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
    
    for(UIView *thumbnail in imgScrollView.subviews){
        [thumbnail removeFromSuperview];
    }
    
    swipeTxtArray = [[NSMutableArray alloc] initWithObjects:@"RIGHT\nwith 2", @"RIGHT\nwith 2", @"LEFT\nwith 2", @"LEFT\nwith 2", @"UP\nwith 2", @"UP\nwith 2", @"DOWN\nwith 2", @"DOWN\nwith 2", nil];

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
    
//    CATransition *animation=[CATransition animation];
//    [animation setDuration:1.5];
//    [animation setType:@"rippleEffect"];
//    [animation setFillMode:kCAFillModeBoth];
//    animation.endProgress=0.6;
//    animation.repeatCount = HUGE_VAL;
//    [animation setRemovedOnCompletion:YES];
//    animation.autoreverses = NO;
//    animation.delegate=self;
//    [animation setTimingFunction: [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear]];
//    [playBtn.layer addAnimation:animation forKey:nil];
    
    
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
  
    NSArray *allFiles = [[TigglyStampUtils sharedInstance] getAllImagesAndMovies];
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
        forParentsBtn.alpha = 1;
        newsBtn.alpha = 1;
        playBtn.alpha = 1;
        imgScrollView.alpha = 1;
        
        forParentsBtn.enabled = YES;
        newsBtn.enabled = YES;
        playBtn.enabled = YES;
        [imgScrollView setUserInteractionEnabled:YES];
        readyToParentScreen = NO;
        
        [playBtnTimer invalidate];
        ParentScreenViewController *parentViewCOntroller = [[ParentScreenViewController alloc] initWithNibName:@"ParentScreenViewController" bundle:nil];
        [self.navigationController pushViewController:parentViewCOntroller animated:YES];
    }
    if(readyToNewsScreen){
        DebugLog(@"");
        confirmationView.hidden = YES;
        forParentsBtn.alpha = 1;
        newsBtn.alpha = 1;
        playBtn.alpha = 1;
        imgScrollView.alpha = 1;
        
        forParentsBtn.enabled = YES;
        playBtn.enabled = YES;
        newsBtn.enabled = YES;
        [imgScrollView setUserInteractionEnabled:YES];        
        readyToNewsScreen = NO;
        
        
        NSMutableDictionary *event =
        [[GAIDictionaryBuilder createEventWithCategory:@"Button Click"
                                                action:@"Button Clicked"
                                                 label:@"Unlock for shapes"
                                                 value:nil] build];
        [[GAI sharedInstance].defaultTracker send:event];
        [[GAI sharedInstance] dispatch];

        
        [playBtnTimer invalidate];
        UnlockScreenViewController *unlockScreen = [[UnlockScreenViewController alloc] initWithNibName:@"UnlockScreenViewController" bundle:nil];
         [self.navigationController pushViewController:unlockScreen animated:YES];
    }
    
    if(readyToDeleteThumbnail) {
        readyToDeleteThumbnail = NO;
        for(ThumbnailView *thumbnail in allThumbnails) {
            [thumbnail startAnimation];
        }
        
        confirmationView.hidden = YES;
        forParentsBtn.alpha = 1;
        newsBtn.alpha = 1;
        playBtn.alpha = 1;
        imgScrollView.alpha = 1;
        bkgLayer.opacity  =1.0;
        
        forParentsBtn.enabled = YES;
        playBtn.enabled = YES;
        newsBtn.enabled = YES;
        [imgScrollView setUserInteractionEnabled:YES];

    }
}

-(void) showConfirmationView{
    DebugLog(@"");
    bkgLayer.opacity = 0.0;
    swipeTxtCnt = arc4random()%7;
    
    [txtView setText:[NSString stringWithFormat:@"To continue,\nswipe %@ fingers.", [swipeTxtArray objectAtIndex:swipeTxtCnt]]];
    txtView.font = [UIFont fontWithName:APP_FONT_BOLD size:26.0f];
    txtView.textColor = [UIColor whiteColor];
    
    switch (swipeTxtCnt) {
        case 0:
            [mSwpeRecognizer setDirection: UISwipeGestureRecognizerDirectionRight];
            [mSwpeRecognizer setNumberOfTouchesRequired: 2];
            break;
        case 1:
            [mSwpeRecognizer setDirection: UISwipeGestureRecognizerDirectionRight];
            [mSwpeRecognizer setNumberOfTouchesRequired: 2];
            break;
        case 2:
            [mSwpeRecognizer setDirection: UISwipeGestureRecognizerDirectionLeft];
            [mSwpeRecognizer setNumberOfTouchesRequired: 2];
            break;
        case 3:
            [mSwpeRecognizer setDirection: UISwipeGestureRecognizerDirectionLeft];
            [mSwpeRecognizer setNumberOfTouchesRequired: 2];
            break;
        case 4:
            [mSwpeRecognizer setDirection: UISwipeGestureRecognizerDirectionUp];
            [mSwpeRecognizer setNumberOfTouchesRequired: 2];
            break;
        case 5:
            [mSwpeRecognizer setDirection: UISwipeGestureRecognizerDirectionUp];
            [mSwpeRecognizer setNumberOfTouchesRequired: 2];
            break;
        case 6:
            [mSwpeRecognizer setDirection: UISwipeGestureRecognizerDirectionDown];
            [mSwpeRecognizer setNumberOfTouchesRequired: 2];
            break;
        case 7:
            [mSwpeRecognizer setDirection: UISwipeGestureRecognizerDirectionDown];
            [mSwpeRecognizer setNumberOfTouchesRequired: 2];
            break;
        default:
            break;
    }
    
    confirmationView.hidden = NO;
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
    
    SeasonSelectionViewController *hmView = [[SeasonSelectionViewController alloc]initWithNibName:@"SeasonSelectionViewController" bundle:nil];
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
    [imgScrollView setUserInteractionEnabled:NO];
    
    [self showConfirmationView];
}

-(IBAction)noConfirmation:(id)sender{
    DebugLog(@"");
    readyToParentScreen = NO;
    readyToNewsScreen = NO;
     readyToDeleteThumbnail = NO;
    isThumbnailLongPressed = NO;
    
    confirmationView.hidden = YES;
    forParentsBtn.alpha = 1;
    newsBtn.alpha = 1;
    playBtn.alpha = 1;
    imgScrollView.alpha = 1;
    bkgLayer.opacity = 1.0;
    
    forParentsBtn.enabled = YES;
    newsBtn.enabled = YES;
    playBtn.enabled = YES;
    [imgScrollView setUserInteractionEnabled:YES];
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
    
    TSThumbnailEditController *thumbnailEditor = [[TSThumbnailEditController alloc] initWithNibName:@"TSThumbnailEditController" bundle:nil withImage:thumbnail.actulaImage imageName:thumbnail.imageName];
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
