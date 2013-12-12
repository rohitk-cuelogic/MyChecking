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
#import "GestureConfirmationView.h"
#import "ServerController.h"
#import "FBConnect.h"
#import "Facebook.h"

#import <Twitter/Twitter.h>
#import <Accounts/Accounts.h>
#import <MessageUI/MessageUI.h>
#import <MessageUI/MFMailComposeViewController.h>

#import "AppDelegate.h"

#ifdef GOOGLE_ANALYTICS_START
#import "GAITrackedViewController.h"
#import "GAI.h"
#import "GAIDictionaryBuilder.h"
#import "GAIFields.h"
#else

#endif

@interface TSThumbnailEditController : UIViewController<GestireViewProtocol,FBSessionDelegate, FBRequestDelegate, FBDialogDelegate,MFMailComposeViewControllerDelegate>{
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
    
    IBOutlet UIView *viewSharingButtons;
    IBOutlet UIButton *btnFacebook;
    IBOutlet UIButton *btnTwitter;
    IBOutlet UIButton *btnPinterest;
    IBOutlet UIButton *btnAirdrop;
    IBOutlet UIButton *btnSave;
    IBOutlet UIButton *btnMail;
    MFMailComposeViewController *mailsend;
    
    
    GestureConfirmationView *gestureView;

}



- (id) initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil withImage:(UIImage *)img imageName:(NSString *)imgName withHomeView:(TSHomeViewController *) homeView;
-(IBAction) goToHomeScreen:(id)sender;
-(IBAction) saveImageToGallary:(id)sender;
-(IBAction)saveImageConfirmed:(id)sender;
-(IBAction) deleteImage:(id)sender;
-(IBAction)noConfirmation:(id)sender;
-(IBAction)actionPlayVideo;

-(IBAction)actionFacebook:(id)sender;
-(IBAction)actionTwitter:(id)sender;
-(IBAction)actionPinterest:(id)sender;
-(IBAction)actionAirdrop:(id)sender;
-(IBAction)actionSaveToGallery:(id)sender;
-(IBAction)actionSendMail:(id)sender;
-(IBAction)actionClose:(id)sender;

@property (retain, strong) Facebook *facebook;
@property (retain, strong) NSArray *permissions;

@end
