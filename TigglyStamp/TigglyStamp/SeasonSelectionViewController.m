//
//  SeassonSelectionViewController.m
//  TigglyStamp
//
//  Created by Sagar Kudale on 25/07/13.
//  Copyright (c) 2013 cuelogic. All rights reserved.
//

#import "SeasonSelectionViewController.h"


#define TAG_FALL_BTN 1
#define TAG_WINTER_BTN 2
#define TAG_SUMMER_BTN 3
#define TAG_SPRING_BTN 4

@interface SeasonSelectionViewController ()

@end
//============================================================================================
@implementation SeasonSelectionViewController
UISwipeGestureRecognizer *mSwpeRecognizer;
NSMutableArray *swipeTxtArray;
int swipeTxtCnt;
@synthesize winterSeasonBtn,SummerSeasonBtn,SpringSeasonBtn,fallSeasonBtn,lockWinter,homeBtn,learnMoreBtn;

//============================================================================================

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

//============================================================================================
- (void)viewDidLoad{
    DebugLog(@"");
    [super viewDidLoad];
  
    if(![[TigglyStampUtils sharedInstance] isAppUnlockedForShapes]){
        [lockWinter setHidden:FALSE];
        [learnMoreBtn setHidden:FALSE];
        [winterSeasonBtn setAlpha:0.5f];
       // [winterSeasonBtn  setBackgroundImage:[UIImage imageNamed:@"btnLock.png"] forState:UIControlStateNormal];
        winterSeasonBtn.userInteractionEnabled = NO;
    }else{
        [lockWinter setHidden:TRUE];
        [learnMoreBtn setHidden:TRUE];
        //[winterSeasonBtn  setBackgroundImage:[UIImage imageNamed:@"winter_btn.png"] forState:UIControlStateNormal];
        winterSeasonBtn.userInteractionEnabled = YES;
    }
    
    
    mSwpeRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swippedforConfirmation)];
    [mSwpeRecognizer setDirection:UISwipeGestureRecognizerDirectionRight];
    [mSwpeRecognizer setNumberOfTouchesRequired:2];
    [self.view addGestureRecognizer:mSwpeRecognizer];
    
    confirmationView.layer.cornerRadius = 20.0f;
    confirmationView.layer.masksToBounds = YES;
    
    
    confirmationView.hidden = YES;
    confirmationViewBKG.hidden = YES;
    
    
    swipeTxtArray = [[NSMutableArray alloc] initWithObjects:@"RIGHT\nwith 2", @"RIGHT\nwith 2", @"LEFT\nwith 2", @"LEFT\nwith 2", @"UP\nwith 2", @"UP\nwith 2", @"DOWN\nwith 2", @"DOWN\nwith 2", nil];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return UIInterfaceOrientationIsLandscape(interfaceOrientation);
}

-(BOOL)shouldAutorotate {
    return YES;
}

-(NSUInteger)supportedInterfaceOrientations {
    DebugLog(@"");
    return UIInterfaceOrientationMaskLandscape;
}

//============================================================================================
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//============================================================================================

#pragma mark -
#pragma mark =======================================
#pragma mark Action Handling
#pragma mark =======================================

//============================================================================================

-(IBAction)actionHomeButtonClicked:(id)sender{
    [self.navigationController popViewControllerAnimated:YES];
}
//============================================================================================

-(IBAction)actionLearnMore:(id)sender{
    learnMoreBtn.enabled = NO;
    fallSeasonBtn.enabled = NO;
    winterSeasonBtn.enabled = NO;
    homeBtn.enabled = NO;
    [self showConfirmationView];
}
//============================================================================================

-(IBAction) onButtonTouched:(id)sender{
    DebugLog(@"");
    UIButton *btn = (UIButton *) sender;
    DebugLog(@"Btn Tag : %d",btn.tag);
    
    StampViewController *stampViewController = nil;
    
    if (btn.tag == TAG_WINTER_BTN) {
         if(![[TigglyStampUtils sharedInstance] isAppUnlockedForShapes]){
             return;
         }
        
        NSMutableDictionary *event =
        [[GAIDictionaryBuilder createEventWithCategory:@"Game Scene"
                                                action:@"Scene selected"
                                                 label:@"Winter scene"
                                                 value:nil] build];
        [[GAI sharedInstance].defaultTracker send:event];
        [[GAI sharedInstance] dispatch];
        
        stampViewController = [[StampViewController alloc] initWithNibName:@"StampViewController" bundle:nil withSceneType:kSceneWinter];
        [self.navigationController pushViewController:stampViewController animated:YES];
    }else if (btn.tag == TAG_FALL_BTN){
        
        NSMutableDictionary *event =
        [[GAIDictionaryBuilder createEventWithCategory:@"Game Scene"
                                                action:@"Scene selected"
                                                 label:@"Fall scene"
                                                 value:nil] build];
        [[GAI sharedInstance].defaultTracker send:event];
        [[GAI sharedInstance] dispatch];
        
        stampViewController = [[StampViewController alloc] initWithNibName:@"StampViewController" bundle:nil withSceneType:kSceneFall];
        [self.navigationController pushViewController:stampViewController animated:YES];
    }
    
    
    

}

-(void) showConfirmationView{
    DebugLog(@"");
    
    swipeTxtCnt = arc4random()%7;
    
    [txtView setText:[NSString stringWithFormat:@"To continue,\nswipe %@ fingers.", [swipeTxtArray objectAtIndex:swipeTxtCnt]]];
    txtView.font = [UIFont fontWithName:APP_FONT_BOLD size:35.0f];
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
    confirmationViewBKG.hidden = NO;
    [self.view bringSubviewToFront:confirmationViewBKG];
    [self.view bringSubviewToFront:confirmationView];
    [confirmationView  bringSubviewToFront:notConfirm];
}

-(void)swippedforConfirmation{
    
    [self noConfirmation:NULL];
    
    NSMutableDictionary *event =
    [[GAIDictionaryBuilder createEventWithCategory:@"About tiggly"
                                            action:@"Learn more"
                                             label:@"Learn more"
                                             value:nil] build];
    [[GAI sharedInstance].defaultTracker send:event];
    [[GAI sharedInstance] dispatch];
    
    
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://tiggly.myshopify.com/products/tiggly-shapes"]];
}

-(IBAction)noConfirmation:(id)sender{
    DebugLog(@"");
    
    
    confirmationView.hidden = YES;
    confirmationViewBKG.hidden = YES;
    
    fallSeasonBtn.enabled = YES;
    winterSeasonBtn.enabled = YES;
     homeBtn.enabled = YES;
    learnMoreBtn.enabled = YES;
    
}

@end
