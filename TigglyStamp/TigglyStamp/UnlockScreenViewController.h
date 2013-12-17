//
//  UnlockScreenViewController.h
//  TigglyStamp
//
//  Created by Sachin Patil on 19/09/13.
//  Copyright (c) 2013 cuelogic. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UITouchVerificationView.h"
#import "TDSoundManager.h"
#import "TSHomeViewController.h"
#import "GestureConfirmationView.h"
#import "ServerController.h"
#ifdef GOOGLE_ANALYTICS_START
#import "GAITrackedViewController.h"
#import "GAI.h"
#import "GAIDictionaryBuilder.h"
#import "GAIFields.h"
#else

#endif

@interface UnlockScreenViewController : UIViewController <UITouchVerificationViewDelegate,GestireViewProtocol,UIWebViewDelegate> {
    
    UIImageView *promtView;
    UIImageView *shapeView;
      
    int shapeCount;
    int totalShapes;
    int countShapeSound;
    
    BOOL isPromptDisplayed;
    
    NSString *shapeToBeDetected;
    NSTimer *promptTimer;
    NSMutableArray *promptsArray;
    
    UnlockScreenEntry screenFrom;
    
    TSHomeViewController *homeViewController;
    
    GestureConfirmationView *gestureView;
    
    IBOutlet UIView *viewForWeb;
    IBOutlet UIWebView *webViewFirstLaunch;
}

@property(nonatomic, strong)UITouchVerificationView * touchView;
@property (nonatomic, strong) IBOutlet UIView *bkgView;
@property (nonatomic, strong) IBOutlet UILabel *lblAboutTiggly;
@property (nonatomic, strong) IBOutlet UILabel *lblAboutTigglyText;
@property (nonatomic, strong) IBOutlet UILabel *lblRemainingShapes;
@property (nonatomic, strong) IBOutlet UILabel *lblInstructionHead;
@property (nonatomic, strong) IBOutlet UILabel *lblInstructionText;
@property (nonatomic, strong) IBOutlet UIButton *btnBack;
@property (nonatomic, strong) IBOutlet UIButton *btnLearnMore;
@property (nonatomic, strong) IBOutlet UIButton *btnBuyShapes;
@property (nonatomic, strong) NSString *shapeToBeDetected;
@property (nonatomic, strong) IBOutlet UILabel *lblLearnMore;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil entryFrom:(UnlockScreenEntry ) fromScreen withHomeView:(TSHomeViewController *) homeView;


-(IBAction)actionBack;
-(IBAction)actionBuyNow;
-(IBAction)actionLearnMore;


@end
