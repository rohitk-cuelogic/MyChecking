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
#import "KTViewController.h"
#import "UITouchVerificationView.h"
#import "IntroScreenViewController.h"
#import "FruitView.h"
#import "CapturedImageView.h"
#import "ScreenCaptureView.h"
#import <MediaPlayer/MediaPlayer.h>
#import "UIView+Genie.h"
#import "XBCurlView.h"
#import "TDSoundManager.h"
#import "PhysicalShapesView.h"

@interface StampViewController : KTViewController<UITouchVerificationViewDelegate,ShapeToDrawProtocol,FruitViewProtocol,AVAudioRecorderDelegate,CapturedImageViewDelegate,ScreenCaptureViewDelegate,FallSceneShapeToDrawProtocol,PhysicalShapeViewProtocol>{
   
    WinterScene *winterSceneObject;
    FallScene *fallSceneObject;
    
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
    
    MPMoviePlayerController *moviePlayer;    
    UIActivityIndicatorView *activityIndicator;
    MPMoviePlayerController *mplayer;
    NSTimer *continuityTimer;
    UIView *viewShapesTray;
    
    SceneType sceneType;
}
@property(nonatomic,strong) IBOutlet  ScreenCaptureView *screenCapture;
@property(nonatomic, strong) NSMutableArray * shapes;
@property(nonatomic,strong)NSMutableArray *fruitObjectArray;
@property(nonatomic,strong)NSArray *pointComparison;
@property (nonatomic,strong) NSMutableArray * multiTouchForFruitObject;
@property (nonatomic,strong) NSMutableArray * multiTouchForTouchView;
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
@property (nonatomic, retain) XBCurlView *curlView;
@property (nonatomic)  BOOL isCameraClick;
@property (nonatomic) IBOutlet UIImageView *backViewImage;
@property (nonatomic) IBOutlet UIImageView *curlViewImage;


-(IBAction)screenShot:(id)sender;
-(IBAction)onButtonClicked:(id)sender;
-(IBAction)actionRecording:(id)sender;
-(IBAction)onHomeButton:(id)sender;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil withSceneType:(SceneType) scene;

@end
