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


@interface TSHomeViewController ()

@end

@implementation TSHomeViewController
@synthesize imgScrollView;


UISwipeGestureRecognizer *mSwpeRecognizer;
BOOL readyToParentScreen, readyToNewsScreen;
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

- (void)viewDidLoad
{
    DebugLog(@"");
    [super viewDidLoad];
    
    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"firstLaunch"];

    
    // Do any additional setup after loading the view from its nib.
    imgScrollView.frame = CGRectMake(0,768 - (RECT_THUMBNAIL_FRAME.size.height + 80), 1024, RECT_THUMBNAIL_FRAME.size.height + 40);
    
    mSwpeRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swippedforConfirmation)];
    [mSwpeRecognizer setDirection:UISwipeGestureRecognizerDirectionRight];
    [mSwpeRecognizer setNumberOfTouchesRequired:2];
    [self.view addGestureRecognizer:mSwpeRecognizer];
    
    confirmationView.layer.cornerRadius = 20.0f;
    confirmationView.layer.masksToBounds = YES;
    
    newsBtn.layer.cornerRadius = 20.0f;
    newsBtn.layer.masksToBounds = YES;
    
    //    confirmationView.layer.borderColor = [UIColor blueColor].CGColor;
    //    confirmationView.layer.borderWidth = 2.0f;
    
    //    haveShapesBtn.layer.cornerRadius = 30.0f;
    //    haveShapesBtn.layer.masksToBounds = YES;
    
    
}

-(void) viewWillAppear:(BOOL)animated{
    DebugLog(@"");
    readyToParentScreen = NO;
    readyToNewsScreen = NO;
    confirmationView.hidden = YES;
    
    for(UIView *thumbnail in imgScrollView.subviews){
        [thumbnail removeFromSuperview];
    }
    
    swipeTxtArray = [[NSMutableArray alloc] initWithObjects:@"right with 2", @"right with 3", @"left with 2", @"left with 3", @"up with 2", @"up with 3", @"down with 2", @"down with 3", nil];

}
-(void) viewDidAppear:(BOOL)animated{
    
    [self loadThumbnails];
    
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
   
    int xPos = 10;
    for (NSString *file in allFiles) {
            
        ThumbnailView *thumbnail = [[ThumbnailView alloc] initWithFrame:CGRectMake(xPos,0, RECT_THUMBNAIL_FRAME.size.width, RECT_THUMBNAIL_FRAME.size.height) withThumbnailImagePath:file];
        thumbnail.delegate = self;
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
    }
}

-(void) showConfirmationView{
    DebugLog(@"");
    
    swipeTxtCnt = random()%7;
    [txtView setText:[NSString stringWithFormat:@"Hi there!\n\nSwipe %@ fingers to continue.", [swipeTxtArray objectAtIndex:swipeTxtCnt]]];
    
    switch (swipeTxtCnt) {
        case 0:
            [mSwpeRecognizer setDirection: UISwipeGestureRecognizerDirectionRight];
            [mSwpeRecognizer setNumberOfTouchesRequired: 2];
            break;
        case 1:
            [mSwpeRecognizer setDirection: UISwipeGestureRecognizerDirectionRight];
            [mSwpeRecognizer setNumberOfTouchesRequired: 3];
            break;
        case 2:
            [mSwpeRecognizer setDirection: UISwipeGestureRecognizerDirectionLeft];
            [mSwpeRecognizer setNumberOfTouchesRequired: 2];
            break;
        case 3:
            [mSwpeRecognizer setDirection: UISwipeGestureRecognizerDirectionLeft];
            [mSwpeRecognizer setNumberOfTouchesRequired: 3];
            break;
        case 4:
            [mSwpeRecognizer setDirection: UISwipeGestureRecognizerDirectionUp];
            [mSwpeRecognizer setNumberOfTouchesRequired: 2];
            break;
        case 5:
            [mSwpeRecognizer setDirection: UISwipeGestureRecognizerDirectionUp];
            [mSwpeRecognizer setNumberOfTouchesRequired: 3];
            break;
        case 6:
            [mSwpeRecognizer setDirection: UISwipeGestureRecognizerDirectionDown];
            [mSwpeRecognizer setNumberOfTouchesRequired: 2];
            break;
        case 7:
            [mSwpeRecognizer setDirection: UISwipeGestureRecognizerDirectionDown];
            [mSwpeRecognizer setNumberOfTouchesRequired: 3];
            break;
        default:
            break;
    }
    confirmationView.hidden = NO;
    [self.view bringSubviewToFront:confirmationView];
    
}

#pragma mark-
#pragma mark======================
#pragma mark IBActions
#pragma mark======================

-(void)playGame:(id)sender{
    DebugLog(@"");
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
    
    confirmationView.hidden = YES;
    forParentsBtn.alpha = 1;
    newsBtn.alpha = 1;
    playBtn.alpha = 1;
    imgScrollView.alpha = 1;
    
    forParentsBtn.enabled = YES;
    newsBtn.enabled = YES;
    playBtn.enabled = YES;
    [imgScrollView setUserInteractionEnabled:YES];
}

#pragma mark-
#pragma mark======================
#pragma mark thumbnailView Delegates
#pragma mark======================

-(void) thumbnailViewTapped:(ThumbnailView *)thumbnail{
    DebugLog(@"");
    
    DebugLog(@"Tapped Thumbnail Name: %@",thumbnail.imageName);
    
    TSThumbnailEditController *thumbnailEditor = [[TSThumbnailEditController alloc] initWithNibName:@"TSThumbnailEditController" bundle:nil withImage:thumbnail.actulaImage imageName:thumbnail.imageName];
    [self.navigationController pushViewController:thumbnailEditor animated:YES];
}
@end
