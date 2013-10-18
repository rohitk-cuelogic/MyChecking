//
//  TSThumbnailEditController.h
//  ivyApplication
//
//  Created by Dattatraya Anarase on 25/07/13.
//
//

#import <UIKit/UIKit.h>
#import "TConstant.h"
#import <QuartzCore/QuartzCore.h>
#import "UIView+Genie.h"
#import "TigglyStampUtils.h"
#import <MediaPlayer/MediaPlayer.h>
#import "TSHomeViewController.h"

#ifdef GOOGLE_ANALYTICS_START
#import "GAITrackedViewController.h"
#import "GAI.h"
#import "GAIDictionaryBuilder.h"
#import "GAIFields.h"
#else

#endif

@interface TSThumbnailEditController : UIViewController{
    IBOutlet UIButton *homeBtn;
    IBOutlet UIButton *saveImageBtn;
    IBOutlet UIButton *confirmSaveBtn;
    IBOutlet UIButton *deleteBtn;
    IBOutlet UIView *confirmationView;
    IBOutlet UIView *confirmationViewBKG;
    IBOutlet UITextView *textView;
    IBOutlet UIButton *notConfirm;
    IBOutlet UIButton *playBtn;
    UIImageView *editorImgView;
    MPMoviePlayerController *moviePlayer;
    
    TSHomeViewController *homeViewController;
    
    BOOL isVideoPlaying;
    
    UISwipeGestureRecognizer *emSwipeRecognizer;
    UIImage *imageToBeEdit;
    NSString * editImgName;
    UIView *upperPanel;
    BOOL readyToSave, readyToDelete, readyToZoom;
    NSMutableArray *savedImgArry;
    NSMutableArray *swipeTextArray;
    int swipeTextCnt;

}



- (id) initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil withImage:(UIImage *)img imageName:(NSString *)imgName withHomeView:(TSHomeViewController *) homeView;
-(IBAction) goToHomeScreen:(id)sender;
-(IBAction) saveImageToGallary:(id)sender;
-(IBAction)saveImageConfirmed:(id)sender;
-(IBAction) deleteImage:(id)sender;
-(IBAction)noConfirmation:(id)sender;
-(IBAction)actionPlayVideo;

@end
