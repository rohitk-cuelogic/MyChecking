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

@interface FallSceneViewController : KTViewController<UITouchVerificationViewDelegate,FallSceneShapeToDrawProtocol,FruitViewProtocol,AVAudioRecorderDelegate,CapturedImageViewDelegate> {
    //    IBOutlet UITouchVerificationView * touchView;
    FallScene *fallSceneObject;
    CGPoint touchLocation;
    CALayer *currentLayer;
    UIColor *colorOrnament;
    CGPoint fruitInitialPos;
    int increaseSize;
    IntroScreenViewController *introView;
    BOOL isTouchesOnTouchLayer;
    BOOL isMoveObject;
    BOOL isRecording;
    
    IBOutlet ScreenCaptureView *screenCapture;
    
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
@property (nonatomic,strong) IBOutlet UIButton *videoButton;
@property (nonatomic,strong) IBOutlet UIButton *RigthTickButton;
@property (nonatomic,strong) IBOutlet UIButton *curlButton;
@property (nonatomic,strong) IBOutlet UIButton *curlConfirmedButton;
@property (nonatomic,strong) IBOutlet UIView *mainView;
@property (nonatomic,strong) IBOutlet UIView *backView;
@property (nonatomic,strong) IntroScreenViewController *introView;
@property (nonatomic, retain) XBCurlView *curlView;
@property (nonatomic, retain) IBOutlet UIButton *backButton;

-(IBAction)screenShot:(id)sender;
-(IBAction)onBackButtonClicked:(id)sender;
-(IBAction)onButtonClicked:(id)sender;
-(IBAction)actionRecording:(id)sender;
-(IBAction)actionBack;;
@end
