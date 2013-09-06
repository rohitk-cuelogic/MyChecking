//
//  FallSceneViewController.h
//  TigglyStamp
//
//  Created by Sachin Patil on 29/07/13.
//  Copyright (c) 2013 cuelogic. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KTViewController.h"
#import "UITouchVerificationView.h"
#import "FallScene.h"
#import "FruitView.h"
#import "IntroScreenViewController.h"
#import "CapturedImageView.h"
#import "XBCurlView.h"
#import "ScreenCaptureView.h"
#import <MediaPlayer/MediaPlayer.h>
#import "UIView+Genie.h"

@interface FallSceneViewController : KTViewController<UITouchVerificationViewDelegate,FallSceneShapeToDrawProtocol,FruitViewProtocol,AVAudioRecorderDelegate,CapturedImageViewDelegate,ScreenCaptureViewDelegate> {
    //    IBOutlet UITouchVerificationView * touchView;
    FallScene *fallSceneObject;
    CGPoint touchLocation;
    CALayer *currentLayer;
    UIColor *colorOrnament;
    int increaseSize;
    IntroScreenViewController *introView;
    BOOL isTouchesOnTouchLayer;
    BOOL isMoveObject;
    BOOL isRecording;
    
    IBOutlet ScreenCaptureView *screenCapture;
    MPMoviePlayerController *moviePlayer;
    CapturedImageView *ccImageView;
    UIActivityIndicatorView *activityIndicator;
    MPMoviePlayerController *mplayer;

    BOOL isBtnViewHidden;
    
    CGPoint fruitInitialPoint;
    BOOL isGreetingPlaying;
    NSTimer *continuityTimer;
    
}
@property(nonatomic,strong) ScreenCaptureView *screenCapture;
@property (nonatomic, strong) IBOutlet UITouchVerificationView * touchView;
@property (nonatomic,strong) IBOutlet UIImageView *imageView;
@property(nonatomic, strong) NSMutableArray * shapes;
@property(nonatomic,strong)NSMutableArray *fruitObjectArray;
@property(nonatomic,strong)NSArray *pointComparison;
@property (nonatomic,strong) NSMutableArray * multiTouchForFruitObject;
@property (nonatomic,strong) NSMutableArray * multiTouchForTouchView;
@property (nonatomic,strong) IBOutlet UIButton *changeToFall;
@property (nonatomic,strong) IBOutlet UIButton *garbageCan;
@property (nonatomic , assign) BOOL isWithShape;
@property (nonatomic,strong) IBOutlet UIButton *cameraButton;
@property (nonatomic,strong) IBOutlet UIButton *homeButton;
@property (nonatomic,strong) IBOutlet UIButton *videoButton;
@property (nonatomic,strong) IBOutlet UIButton *RigthTickButton;
@property (nonatomic,strong) IBOutlet UIButton *curlButton;
@property (nonatomic,strong) IBOutlet UIButton *curlConfirmedButton;
@property (nonatomic,strong) IBOutlet UIView *mainView;
@property (nonatomic,strong) IBOutlet UIView *backView;
@property (nonatomic,strong) IBOutlet UIView *viewForCurl;
@property (nonatomic,strong) IntroScreenViewController *introView;
@property (nonatomic, strong) XBCurlView *curlView;
@property (nonatomic, strong) IBOutlet UIButton *backButton;
@property (nonatomic)  BOOL isCameraClick;
@property (nonatomic, strong) IBOutlet UIView *btnView;

-(IBAction)screenShot:(id)sender;
-(IBAction)onBackButtonClicked:(id)sender;
-(IBAction)onButtonClicked:(id)sender;
-(IBAction)actionRecording:(id)sender;
-(IBAction)actionBack;
-(IBAction)onhomeButton:(id)sender;
@end
