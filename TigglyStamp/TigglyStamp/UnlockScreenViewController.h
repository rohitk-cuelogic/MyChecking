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

@interface UnlockScreenViewController : UIViewController <UITouchVerificationViewDelegate> {
    
    UIImageView *promtView;
    UIImageView *shapeView;
    NSString *shapeToBeDetected;
    int shapeCount;
    int totalShapes;
    BOOL isPromptDisplayed;
    NSTimer *promptTimer;
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

-(IBAction)actionBack;
-(IBAction)actionBuyNow;
-(IBAction)actionLearnMore;

@end
