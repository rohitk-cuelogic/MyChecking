//
//  StampViewController.h
//  TigglyStamp
//
//  Created by Sachin Patil on 10/09/13.
//  Copyright (c) 2013 cuelogic. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TConstant.h"
#import "FallScene.h"
#import "WinterScene.h"
#import "UITouchVerificationView.h"
#import "IntroScreenViewController.h"
#import "FruitView.h"
#import "CapturedImageView.h"
#import "ScreenCaptureView.h"
#import <MediaPlayer/MediaPlayer.h>
#import <MessageUI/MessageUI.h>
#import <MessageUI/MFMailComposeViewController.h>
#import "UIView+Genie.h"
#import "XBCurlView.h"
#import "XBPageCurlView.h"
#import "TDSoundManager.h"
#import "PhysicalShapesView.h"
#import "TSHomeViewController.h"
#import "ImageAnimatorView.h"

#import "FBConnect.h"
#import "Facebook.h"

#import <Twitter/Twitter.h>
#import <Accounts/Accounts.h>
#import <MessageUI/MessageUI.h>
#import <MessageUI/MFMailComposeViewController.h>

@interface StampViewController : UIViewController<UITouchVerificationViewDelegate,FruitViewProtocol,AVAudioRecorderDelegate,CapturedImageViewDelegate,ScreenCaptureViewDelegate,PhysicalShapeViewProtocol,XBPageCurlViewDelegate,MFMailComposeViewControllerDelegate,FBSessionDelegate, FBRequestDelegate, FBDialogDelegate>{
   
    WinterScene *winterSceneObject;
    FallScene *fallSceneObject;
    
    NSString *shapeToDraw;
    
    CGPoint touchLocation;
    CALayer *currentLayer;
    UIColor *colorOrnament;
    CGPoint fruitInitialPos;
 
    IntroScreenViewController *introView;
    ScreenCaptureView *screenCapture;
    CapturedImageView *ccImageView;
    
    BOOL isTouchesOnTouchLayer;
    BOOL isMoveObject;
    BOOL isRecording;
    BOOL isBtnViewHidden;
    BOOL isGreetingSoundPlaying;
    BOOL isShapesTrayHidden;
    BOOL _isVideo;
    
    MPMoviePlayerController *moviePlayer;    
    UIActivityIndicatorView *activityIndicator;
    MPMoviePlayerController *mplayer;
    NSTimer *continuityTimer;
    UIImageView *viewShapesTray;
    UIView *btnView;
    NSTimer *videoPlayTimer;
    UIButton *btnShapesTray;
    
    NSString *movieScreenshotName;
    UIImage *movieScreenshotImage;
    
    SceneType sceneType;
    
    TSHomeViewController *homeViewController;
    
    CAShapeLayer * rainBowLayer;
    CAShapeLayer * rainBowBtnLayer;
    NSMutableArray *arrRainbowImages;
    BOOL isRainbowMusicStarted;
    
    
    IBOutlet UIView *viewSharingButtons;
    IBOutlet UIButton *btnFacebook;
    IBOutlet UIButton *btnTwitter;
    IBOutlet UIButton *btnPinterest;
    IBOutlet UIButton *btnAirdrop;
    IBOutlet UIButton *btnSave;
    IBOutlet UIButton *btnMail;
    MFMailComposeViewController *mailsend;
    
    
    ImageAnimatorView *rainbowAnimationView;
}

@property (nonatomic,strong) IntroScreenViewController *introView;
@property (nonatomic,strong) XBCurlView *curlView;
@property (nonatomic,strong) ImageAnimatorView *rainbowAnimationView;

@property (nonatomic,strong) NSString *shapeToDraw;
@property (nonatomic,strong) NSMutableArray *fruitObjectArray;
@property (nonatomic,strong) NSArray *pointComparison;
@property (nonatomic,strong) NSMutableArray * multiTouchForFruitObject;
@property (nonatomic,strong) NSMutableArray * multiTouchForTouchView;

@property (nonatomic,strong) IBOutlet  ScreenCaptureView *screenCapture;
@property (nonatomic,strong) IBOutlet UIButton *garbageCan;
@property (nonatomic,strong) IBOutlet UIButton *cameraButton;
@property (nonatomic,strong) IBOutlet UIButton *homeButton;
@property (nonatomic,strong) IBOutlet UIButton *videoButton;
@property (nonatomic,strong) IBOutlet UIButton *RigthTickButton;
@property (nonatomic,strong) IBOutlet UIButton *curlButton;
@property (nonatomic,strong) IBOutlet UIButton *curlConfirmedButton;
@property (nonatomic,strong) IBOutlet UIView *mainView;
@property (nonatomic,strong) IBOutlet UIView *backView;
@property (nonatomic,strong) IBOutlet UIView *viewForCurl;
@property (nonatomic,strong) IBOutlet UILabel *lblTimer;
@property (nonatomic,strong) IBOutlet UIImageView *backViewImage;
@property (nonatomic,strong) IBOutlet UIImageView *curlViewImage;
@property (nonatomic,strong) IBOutlet UIView *btnView;

@property (nonatomic,readwrite)  BOOL isCameraClick;
@property (nonatomic,readwrite) BOOL isWithShape;

-(IBAction)screenShot:(id)sender;
-(IBAction)onButtonClicked:(id)sender;
-(IBAction)actionRecording:(id)sender;
-(IBAction)onHomeButton:(id)sender;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil withSceneType:(SceneType) scene withHomeView:(TSHomeViewController *) homeView;


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
