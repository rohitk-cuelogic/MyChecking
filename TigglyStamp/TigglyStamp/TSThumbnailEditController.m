//
//  TSThumbnailEditController.m
//  ivyApplication
//
//  Created by Dattatraya Anarase on 25/07/13.
//
//

#import "TSThumbnailEditController.h"
#import "TDSoundManager.h"
#import "TSHomeViewController.h"
#import "TSTempData.h"

@interface TSThumbnailEditController ()

@end

@implementation TSThumbnailEditController

#pragma mark -
#pragma mark =======================================
#pragma mark Init
#pragma mark =======================================


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil withImage:(UIImage *)img imageName:(NSString *)imgName withHomeView:(TSHomeViewController *) homeView{
    DebugLog(@"");
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
        homeViewController = homeView;
        
        imageToBeEdit = img;
        
        if([[imgName pathExtension] isEqualToString:@"mov"]) {
            playBtn.hidden = NO;
        }else{
            playBtn.hidden = YES;
        }
                
        editImgName = [imgName lastPathComponent];
        
        upperPanel = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 1024, 100)];
        upperPanel.backgroundColor = [UIColor colorWithRed:253.0 / 255.0 green:102.0 / 255.0 blue:9.0 / 255.0 alpha:1.0];
        [self.view addSubview:upperPanel];
        
        [self.view bringSubviewToFront:homeBtn];
        [self.view bringSubviewToFront:saveImageBtn];
        [self.view bringSubviewToFront:deleteBtn];
        
        editorImgView = [[UIImageView alloc] initWithFrame:RECT_THUMBNAIL_EDITOR_FRAME];
        [editorImgView setContentMode:UIViewContentModeScaleAspectFit];
           editorImgView.center = CGPointMake(512, 420);
        editorImgView.image = img;
        editorImgView.userInteractionEnabled = YES;
        [self.view addSubview:editorImgView];
        
        UITapGestureRecognizer *mTapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(zoomTappedImage)];
        [editorImgView addGestureRecognizer:mTapGesture];
        
        UISwipeGestureRecognizer *swipeLeftGesture = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swippedLeftEditorImage)];
        [swipeLeftGesture setDirection:UISwipeGestureRecognizerDirectionLeft];
        [editorImgView addGestureRecognizer:swipeLeftGesture];
        
        UISwipeGestureRecognizer *swipeRightGesture = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swippedRightEditorImage)];
        [swipeRightGesture setDirection:UISwipeGestureRecognizerDirectionRight];
        [editorImgView addGestureRecognizer:swipeRightGesture];
        
        
    }
    return self;
}



#pragma mark -
#pragma mark =======================================
#pragma mark memory Management
#pragma mark =======================================

-(void) nullifyAllData{
    DebugLog(@"");
    
    if(savedImgArry != nil) {
        [savedImgArry removeAllObjects];
        savedImgArry = nil;
    }
    
    if(swipeTextArray != nil) {
        [swipeTextArray removeAllObjects];
        swipeTextArray = nil;
    }
    
    if(moviePlayer != nil) {
        moviePlayer = nil;
    }
    
    if(editorImgView != nil) {
        editorImgView = nil;
    }
    
}

#pragma mark-
#pragma mark======================
#pragma mark View Life Cycle
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
    
#ifdef GOOGLE_ANALYTICS_START
    NSMutableDictionary *event =
    [[GAIDictionaryBuilder createEventWithCategory:@"Gallery"
                                            action:@"Gallery opened"
                                             label:@"Gallery"
                                             value:nil] build];
    [[GAI sharedInstance].defaultTracker send:event];
    [[GAI sharedInstance] dispatch];
#else
    
#endif
    

    
    emSwipeRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swippedforConfirmation)];
    [emSwipeRecognizer setDirection:UISwipeGestureRecognizerDirectionRight];
    [emSwipeRecognizer setNumberOfTouchesRequired:2];
    [self.view addGestureRecognizer:emSwipeRecognizer];
    
    confirmationView.layer.cornerRadius = 20.0f;
    confirmationView.layer.masksToBounds = YES;
    
}

-(void)viewDidAppear:(BOOL)animated {
    DebugLog(@"");
     [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationNone];
}

-(void) viewDidDisappear:(BOOL)animated{
    DebugLog(@"");
    
    [self.view removeGestureRecognizer:emSwipeRecognizer];
}

-(void)viewWillAppear:(BOOL)animated{
    DebugLog(@"");
    
    [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationNone];
    
    [self loadSavedImagesIntoArray];
    
    confirmationView.hidden = YES;
    confirmationViewBKG.hidden = YES;
    readyToSave = NO;
    readyToDelete = NO;
    readyToZoom = YES;
    confirmSaveBtn.hidden = YES;
    [self.view bringSubviewToFront:playBtn];
    
    if([[editImgName pathExtension] isEqualToString:@"mov"]) {
        playBtn.hidden = NO;
    }else{
        playBtn.hidden = YES;
    }
    
    swipeTextArray = [[NSMutableArray alloc] initWithObjects:@"RIGHT\nwith 2", @"RIGHT\nwith 2", @"LEFT\nwith 2", @"LEFT\nwith 2", @"UP\nwith 2", @"UP\nwith 2", @"DOWN\nwith 2", @"DOWN\nwith 2", nil];
}
- (void)didReceiveMemoryWarning
{
    DebugLog(@"");
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return UIInterfaceOrientationIsLandscape(interfaceOrientation);
}

-(BOOL)shouldAutorotate
{
    DebugLog(@"");
    return YES;
}

-(NSUInteger)supportedInterfaceOrientations
{
    DebugLog(@"");
    return UIInterfaceOrientationMaskLandscape;
}

#pragma mark-
#pragma mark======================
#pragma mark Game Handlers
#pragma mark======================

-(void) showConfirmationView{
    DebugLog(@"");
    gestureView = [[GestureConfirmationView alloc] initWithFrame:CGRectMake(0, 0, 1024, 768)];
    gestureView.delegate = self;
    gestureView.layer.zPosition = 1500;
    [self.view addSubview:gestureView];
}

-(void)loadSavedImagesIntoArray{
    DebugLog(@"");
    savedImgArry = [[NSMutableArray alloc]initWithCapacity:1];
    NSArray *directoryContents = [[TigglyStampUtils sharedInstance] getAllImagesAndMovies];

    for (NSString *file in directoryContents) {
           [savedImgArry addObject:[file lastPathComponent]];
    }

    savedImgArry = (NSMutableArray *)[[savedImgArry reverseObjectEnumerator] allObjects];
    DebugLog(@"Saved Image Array : %@",savedImgArry);
}

-(void) zoomTappedImage{
    DebugLog(@"");
    
    if(isVideoPlaying)
        return;
    
    if(readyToZoom){
        homeBtn.hidden = YES;
        saveImageBtn.hidden = YES;
        deleteBtn.hidden = YES;
        upperPanel.hidden = YES;
        
        editorImgView.frame = RECT_MAIN_SCREEN_FRAME;
        editorImgView.center = CGPointMake(512, 384);
        
        
    }else{
        homeBtn.hidden = NO;
        saveImageBtn.hidden = NO;
        deleteBtn.hidden = NO;
        upperPanel.hidden = NO;
        
        editorImgView.frame = RECT_THUMBNAIL_EDITOR_FRAME;
        editorImgView.center = CGPointMake(512, 420);
    }
    readyToZoom = !readyToZoom;
}
-(void)swippedforConfirmation{
    if(readyToSave){
        DebugLog(@"");
        confirmSaveBtn.hidden = NO;
        
        if([[editImgName pathExtension] isEqualToString:@"mov"]) {
            [confirmSaveBtn setTitle:[[TigglyStampUtils sharedInstance]getLocalisedStringForKey:@"kSaveVideo"] forState:UIControlStateNormal];
        }else{
            [confirmSaveBtn setTitle:[[TigglyStampUtils sharedInstance]getLocalisedStringForKey:@"kSaveImage"] forState:UIControlStateNormal];
        }
        
        [self.view bringSubviewToFront:confirmSaveBtn];
        
        confirmationView.hidden = YES;
        confirmationViewBKG.hidden = YES;
        readyToSave = NO;
    }
    if(readyToDelete){
        DebugLog(@"");

        confirmationView.hidden = YES;
        confirmationViewBKG.hidden = YES;
        readyToDelete = NO;
        
        upperPanel.alpha = 1;
        editorImgView.alpha = 1;
        
        
        [self deleteImageAfterConfirm];
        
        
    }
}

-(void)deleteImageAfterConfirm{
    DebugLog(@"");
    
    UIImageView *viewToDelete = [[UIImageView alloc] initWithFrame:editorImgView.frame];
    [viewToDelete setContentMode:UIViewContentModeScaleAspectFit];
    viewToDelete.image = editorImgView.image;
    
    if([[editImgName pathExtension] isEqualToString:@"mov"]){
        UIImage *img = [[TigglyStampUtils sharedInstance] getMovieImageForMovieName:editImgName];
        viewToDelete.image = img;
    }
    
    [self.view addSubview:viewToDelete];
    
    CGRect endRect = CGRectMake(deleteBtn.frame.origin.x + 40, deleteBtn.frame.origin.y + 40, 10, 10);
    [viewToDelete genieInTransitionWithDuration:1.0
                                destinationRect:endRect
                                destinationEdge:BCRectEdgeBottom
                                     completion:^{
                                         
                                         [self loadSavedImagesIntoArray];
                                         
                                         homeBtn.enabled = YES;
                                         if([savedImgArry count]){
                                             saveImageBtn.enabled = YES;
                                             deleteBtn.userInteractionEnabled = YES;
                                             editorImgView.userInteractionEnabled = YES;
                                         }
                                         [viewToDelete removeFromSuperview];
                                     }];
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSMutableArray *directoryContents = [[NSMutableArray alloc]initWithCapacity:1];
    NSArray *dContents = [[TigglyStampUtils sharedInstance] getAllImagesAndMovies];
   
    for (NSString *file in dContents) {
        [directoryContents addObject:file];
    }
    
    directoryContents = (NSMutableArray*)[[directoryContents reverseObjectEnumerator] allObjects];
   
    int cnt = -1;
    for(NSString *file in directoryContents){
        cnt++;
        if([[file lastPathComponent] isEqualToString:editImgName]){
            NSString *fullPath = file;
            
            if([[fullPath pathExtension] isEqualToString:@"mov"]){
                
                //delete mov file
                [fileManager removeItemAtPath:fullPath error:nil];
                
                NSString *moviePngPath = [[TigglyStampUtils sharedInstance] getMovieImagePathForMovieName:fullPath];
                DebugLog(@"moviePngPath:%@",moviePngPath);
                
                //delete png file
                [fileManager removeItemAtPath:moviePngPath error:nil];

                
            }else if([[fullPath pathExtension] isEqualToString:@"png"]){
                DebugLog(@"Filed  deleted:%@",fullPath);
                [fileManager removeItemAtPath:fullPath error:nil];
            }
            
            break;
        }
    }
    
    directoryContents = [[NSMutableArray alloc]initWithCapacity:1];
    dContents = [[TigglyStampUtils sharedInstance] getAllImagesAndMovies];
    
    for (NSString *file in dContents) {
        [directoryContents addObject:file];
    }
    
    directoryContents = (NSMutableArray*)[[directoryContents reverseObjectEnumerator] allObjects];
    DebugLog(@"directoryContents : %@",directoryContents);
    
    if([directoryContents count] == 0){
        [UIView beginAnimations:nil context:nil];
        [UIView animateWithDuration:1 animations:nil];
        editorImgView.image = nil;
        [UIView commitAnimations];
        
        imageToBeEdit = nil;
        editImgName = nil;
        
    }else{
        
        if(cnt >= [directoryContents count]){
            cnt = 0;
        }
        if([[[directoryContents objectAtIndex:cnt] pathExtension] isEqualToString:@"mov"]) {
            UIImage *img = [[TigglyStampUtils sharedInstance] getMovieImageForMovieName:[directoryContents objectAtIndex:cnt]];
            imageToBeEdit = img;
            playBtn.hidden = NO;
        }else{
            imageToBeEdit = [UIImage imageWithData:[NSData dataWithContentsOfFile:[directoryContents objectAtIndex:cnt]]];
            playBtn.hidden = YES;
        }
        
        editorImgView.image = imageToBeEdit;
        editImgName = [[directoryContents objectAtIndex:cnt]lastPathComponent];
    }
    
    [self.view bringSubviewToFront:deleteBtn];

}

-(void)swippedLeftEditorImage {
    DebugLog(@"");
    DebugLog(@"Saved Image Array : %@",savedImgArry);
    
    if([savedImgArry count] == 0){
        return;
    }
    
    if(isVideoPlaying)
        return;
    
    editorImgView.hidden = YES;
    editorImgView.userInteractionEnabled = NO;
    
    UIImageView *goingView = [[UIImageView alloc] initWithFrame:editorImgView.frame];
    [goingView setContentMode:UIViewContentModeScaleAspectFit];
    goingView.image = editorImgView.image;
    [self.view addSubview:goingView];
    
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    int cnt = 0;
    for(NSString *file in savedImgArry){
        cnt++;
        if([file isEqualToString:editImgName]){
            break;
        }
    }
    if(cnt == [savedImgArry count]){
        //image found at last position in savedImgArray
        if(readyToZoom){
            goingView.center = CGPointMake(512, 420);
            
            [UIView animateWithDuration:0.3
                             animations:^{
                                 goingView.center = CGPointMake(300, 420);
                             }
                             completion:^(BOOL finished){
                                 [goingView removeFromSuperview];
                                 editorImgView.hidden = NO;
                                 editorImgView.userInteractionEnabled = YES;
                             }];
        }else{
            goingView.center = CGPointMake(512, 384);
            
            [UIView animateWithDuration:0.3
                             animations:^{
                                 goingView.center = CGPointMake(300, 384);
                             }
                             completion:^(BOOL finished){
                                 [goingView removeFromSuperview];
                                 editorImgView.hidden = NO;
                                 editorImgView.userInteractionEnabled = YES;
                             }];
        }
        
    }else{
        
      //  [self playSlidingSounds];
        
        if([[[savedImgArry objectAtIndex:cnt] pathExtension] isEqualToString:@"mov"]) {
            UIImage *img = [[TigglyStampUtils sharedInstance] getMovieImageForMovieName:[savedImgArry objectAtIndex:cnt]];
            imageToBeEdit = img;
            playBtn.hidden = NO;
        
        }else{
            imageToBeEdit = [UIImage imageWithData:[NSData dataWithContentsOfFile:[path stringByAppendingPathComponent:[savedImgArry objectAtIndex:cnt]]]];
            playBtn.hidden = YES;
        }
                
        editImgName = [savedImgArry objectAtIndex:cnt];
        DebugLog(@"EditImage Name : %@",editImgName);
        
        UIImageView *comingView = [[UIImageView alloc] initWithFrame:editorImgView.frame];
        [comingView setContentMode:UIViewContentModeScaleAspectFit];
        comingView.image = imageToBeEdit;
        [self.view addSubview:comingView];
        
        if(readyToZoom){
            goingView.center = CGPointMake(512, 420);
            comingView.center = CGPointMake(1500, 420);
            if([[[savedImgArry objectAtIndex:cnt] pathExtension] isEqualToString:@"mov"]) {
                playBtn.hidden = YES;
            }
            [UIView animateWithDuration:1
                             animations:^{
                                 goingView.center = CGPointMake(-700, 420);
                                 comingView.center = CGPointMake(512, 420);
                             }
                             completion:^(BOOL finished){
                                 if([[[savedImgArry objectAtIndex:cnt] pathExtension] isEqualToString:@"mov"]) {
                                     playBtn.hidden = NO;
                                 }
                                 [goingView removeFromSuperview];
                                 [comingView removeFromSuperview];
                                 editorImgView.image = imageToBeEdit;
                                 editorImgView.hidden = NO;
                                 editorImgView.userInteractionEnabled = YES;
                             }];
        }else{
            goingView.center = CGPointMake(512, 384);
            comingView.center = CGPointMake(1700, 384);
            if([[[savedImgArry objectAtIndex:cnt] pathExtension] isEqualToString:@"mov"]) {
                playBtn.hidden = YES;
            }
            [UIView animateWithDuration:1
                             animations:^{
                                 goingView.center = CGPointMake(-700, 384);
                                 comingView.center = CGPointMake(512, 384);
                             }
                             completion:^(BOOL finished){
                                 if([[[savedImgArry objectAtIndex:cnt] pathExtension] isEqualToString:@"mov"]) {
                                     playBtn.hidden = NO;
                                 }
                                 [goingView removeFromSuperview];
                                 [comingView removeFromSuperview];
                                 editorImgView.image = imageToBeEdit;
                                 editorImgView.hidden = NO;
                                 editorImgView.userInteractionEnabled = YES;
                             }];
        }
    }
}

-(void)swippedRightEditorImage{
    DebugLog(@"");
    
    DebugLog(@"Saved Image Array : %@",savedImgArry);
    
    if([savedImgArry count] == 0){
        return;
    }
    
    if(isVideoPlaying)
        return;
    
    editorImgView.hidden = YES;
    editorImgView.userInteractionEnabled = NO;
    
    UIImageView *goingView = [[UIImageView alloc] initWithFrame:editorImgView.frame];
    [goingView setContentMode:UIViewContentModeScaleAspectFit];
    goingView.image = editorImgView.image;
    [self.view addSubview:goingView];
    
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    int cnt = 0;
    for(NSString *file in savedImgArry){
        cnt++;
        if([file isEqualToString:editImgName]){
            break;
        }
    }
    cnt -= 2;
    if(cnt < 0){
        //image found at first position in savedImgArray
        if(readyToZoom){
            goingView.center = CGPointMake(512, 420);
            
            [UIView animateWithDuration:0.3
                             animations:^{
                                 goingView.center = CGPointMake(800, 420);
                             }
                             completion:^(BOOL finished){
                                 [goingView removeFromSuperview];
                                 editorImgView.hidden = NO;
                                 editorImgView.userInteractionEnabled = YES;
                             }];
        }else{
            goingView.center = CGPointMake(512, 384);
            
            [UIView animateWithDuration:0.3
                             animations:^{
                                 goingView.center = CGPointMake(800, 384);
                             }
                             completion:^(BOOL finished){
                                 [goingView removeFromSuperview];
                                 editorImgView.hidden = NO;
                                 editorImgView.userInteractionEnabled = YES;
                             }];
        }
    }else{
        
      //  [self playSlidingSounds];
        
        if([[[savedImgArry objectAtIndex:cnt] pathExtension] isEqualToString:@"mov"]) {
            UIImage *img = [[TigglyStampUtils sharedInstance] getMovieImageForMovieName:[savedImgArry objectAtIndex:cnt]];
            imageToBeEdit = img;
            playBtn.hidden = NO;
        }else{
            imageToBeEdit = [UIImage imageWithData:[NSData dataWithContentsOfFile:[path stringByAppendingPathComponent:[savedImgArry objectAtIndex:cnt]]]];
            playBtn.hidden = YES;
        }
        editImgName = [savedImgArry objectAtIndex:cnt];
        DebugLog(@"EditImage Name : %@",editImgName);
        
        UIImageView *comingView = [[UIImageView alloc] initWithFrame:editorImgView.frame];
        [comingView setContentMode:UIViewContentModeScaleAspectFit];
        comingView.image = imageToBeEdit;
        [self.view addSubview:comingView];
        
        if(readyToZoom){
            goingView.center = CGPointMake(512, 420);
            comingView.center = CGPointMake(-500, 420);
            if([[[savedImgArry objectAtIndex:cnt] pathExtension] isEqualToString:@"mov"]) {
                playBtn.hidden = YES;
            }
            [UIView animateWithDuration:1
                             animations:^{
                                 goingView.center = CGPointMake(1500, 420);
                                 comingView.center = CGPointMake(512, 420);
                             }
                             completion:^(BOOL finished){
                                 if([[[savedImgArry objectAtIndex:cnt] pathExtension] isEqualToString:@"mov"]) {
                                     playBtn.hidden = NO;
                                 }
                                 [goingView removeFromSuperview];
                                 [comingView removeFromSuperview];
                                 editorImgView.image = imageToBeEdit;
                                 editorImgView.hidden = NO;
                                 editorImgView.userInteractionEnabled = YES;
                             }];
        }else{
            goingView.center = CGPointMake(512, 384);
            comingView.center = CGPointMake(-700, 384);
            if([[[savedImgArry objectAtIndex:cnt] pathExtension] isEqualToString:@"mov"]) {
                playBtn.hidden = YES;
            }            [UIView animateWithDuration:1
                                          animations:^{
                                              goingView.center = CGPointMake(1700, 384);
                                              comingView.center = CGPointMake(512, 384);
                                          }
                                          completion:^(BOOL finished){
                                              if([[[savedImgArry objectAtIndex:cnt] pathExtension] isEqualToString:@"mov"]) {
                                                  playBtn.hidden = NO;
                                              }
                                              [goingView removeFromSuperview];
                                              [comingView removeFromSuperview];
                                              editorImgView.image = imageToBeEdit;
                                              editorImgView.hidden = NO;
                                              editorImgView.userInteractionEnabled = YES;
                                          }];
        }
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
    
    
    if (readyToZoom == NO) {
        [moviePlayer.view setFrame:CGRectMake(self.view.frame.origin.x, self.view.frame.origin.x, self.view.frame.size.width, self.view.frame.size.height)];
    }else{
        [moviePlayer.view setFrame:CGRectMake(512-(600/2), 148, 600, 450)];

    }
    
    
    moviePlayer.shouldAutoplay = YES;
    [self.view addSubview:moviePlayer.view];
    [moviePlayer prepareToPlay];
    [moviePlayer play];

    
//    double delayInSeconds = 0.5;
//    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
//    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
//        
//        homeBtn.hidden = NO;
//        saveImageBtn.hidden = NO;
//        deleteBtn.hidden = NO;
//        upperPanel.hidden = NO;
//        
//        editorImgView.frame = RECT_THUMBNAIL_EDITOR_FRAME;
//        editorImgView.center = CGPointMake(512, 400);
//
//    });

    
}


- (void) moviePlayBackDidFinish:(NSNotification*)notification {
    DebugLog(@"");
    playBtn.hidden = NO;

    isVideoPlaying = NO;
    
    moviePlayer = [notification object];

    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:MPMoviePlayerPlaybackDidFinishNotification
                                                  object:moviePlayer];
    
    if ([moviePlayer    respondsToSelector:@selector(setFullscreen:animated:)])
    {
       
        [moviePlayer.view removeFromSuperview];
    }
  
}

-(void)didExitFullScreen:(NSNotification*)notification{
    DebugLog(@"");
    playBtn.hidden = NO;
    
    isVideoPlaying = NO;
    
    moviePlayer = [notification object];
    
    readyToZoom = NO;
    
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:MPMoviePlayerPlaybackDidFinishNotification
                                                  object:moviePlayer];
    
    if ([moviePlayer  respondsToSelector:@selector(setFullscreen:animated:)])
    {
        
        [moviePlayer.view removeFromSuperview];
    }

}


#pragma mark-
#pragma mark======================
#pragma mark IBActions
#pragma mark======================

-(IBAction)actionPlayVideo {
    DebugLog(@"");
    
    if([[[editImgName lastPathComponent] pathExtension]isEqualToString:@"mov"]) {
        NSURL *url = [NSURL fileURLWithPath:[[[TigglyStampUtils sharedInstance] getDocumentDirPath] stringByAppendingPathComponent:editImgName]];
        [self playVideoWithURL:url];
        isVideoPlaying = YES;
    }
}

-(IBAction)goToHomeScreen:(id)sender{
    DebugLog(@"");
    [moviePlayer stop];
    [self.navigationController popToViewController:homeViewController animated:YES];
    homeViewController = nil;
    [self nullifyAllData];
}

-(IBAction)saveImageToGallary:(id)sender{
    DebugLog(@"");
    
    upperPanel.alpha = 0.5;
    editorImgView.alpha = 0.3;
    
    homeBtn.enabled = NO;
    saveImageBtn.enabled = NO;
    deleteBtn.enabled = NO;
    editorImgView.userInteractionEnabled = NO;
    
    readyToSave = YES;
    
    [self showConfirmationView];
}

-(IBAction)saveImageConfirmed:(id)sender{
    DebugLog(@"");
    //save image to the photo album
    
#ifdef GOOGLE_ANALYTICS_START
    NSMutableDictionary *event =
    [[GAIDictionaryBuilder createEventWithCategory:@"Gallery"
                                            action:@"Gallery opened"
                                             label:@"Save Image/ Video"
                                             value:nil] build];
    [[GAI sharedInstance].defaultTracker send:event];
    [[GAI sharedInstance] dispatch];
#else
    
#endif
    

    
    if([[editImgName pathExtension] isEqualToString:@"mov"]) {
        
        NSString *exportPath = [[NSString alloc] initWithFormat:@"%@/%@",
                                [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0], editImgName];
        if (UIVideoAtPathIsCompatibleWithSavedPhotosAlbum (exportPath)) {
            UISaveVideoAtPathToSavedPhotosAlbum (exportPath, nil, nil, nil);
        }
        
    }else{
        UIImageWriteToSavedPhotosAlbum(imageToBeEdit, nil, nil, nil);
        [confirmSaveBtn setTitle:@"Image Saved" forState:UIControlStateNormal];
    }
    
    [UIView animateWithDuration:0.50
                     animations:^{
                         confirmSaveBtn.alpha = 0;
                     }
                     completion:^(BOOL finished){
                         confirmSaveBtn.alpha = 1;
                         confirmSaveBtn.hidden = YES;
                         [confirmSaveBtn setTitle:[[TigglyStampUtils sharedInstance]getLocalisedStringForKey:@"kSaveImage"] forState:UIControlStateNormal];
    }];
    
    upperPanel.alpha = 1;
    editorImgView.alpha = 1;
    
    homeBtn.enabled = YES;
    saveImageBtn.enabled = YES;
    deleteBtn.enabled = YES;
    editorImgView.userInteractionEnabled = YES;
}

-(IBAction)deleteImage:(id)sender{
    
    [moviePlayer stop];

    DebugLog(@"");
    upperPanel.alpha = 0.5;
    editorImgView.alpha = 0.3;
    
    homeBtn.enabled = NO;
    saveImageBtn.enabled = NO;
    deleteBtn.userInteractionEnabled = NO;
    editorImgView.userInteractionEnabled = NO;
    
    readyToDelete = YES;
    
    [self showConfirmationView];
}

-(IBAction)noConfirmation:(id)sender{
    DebugLog(@"");
    confirmationView.hidden = YES;
    confirmationViewBKG.hidden = YES;
    readyToSave = NO;
    readyToDelete = NO;
    
    upperPanel.alpha = 1;
    editorImgView.alpha = 1;
    
    homeBtn.enabled = YES;
    saveImageBtn.enabled = YES;
    deleteBtn.enabled = YES;
    deleteBtn.userInteractionEnabled = YES;
    editorImgView.userInteractionEnabled = YES;
}


#pragma mark ===========================================
#pragma mark - play sounds
#pragma mark ===========================================

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

-(void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    
    double delayInSeconds = 0.3;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        [gestureView removeFromSuperview];
        gestureView = nil;
        [self noConfirmation:nil];
    });
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

-(void) gestureViewOnCancel:(GestureConfirmationView *)gView {
    DebugLog(@"");

    [self noConfirmation:nil];
    
    if(readyToDelete){
        readyToDelete = NO;
    }
    
    if(readyToSave){
        readyToSave = NO;
    }
}

@end
