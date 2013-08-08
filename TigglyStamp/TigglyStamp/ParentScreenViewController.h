//
//  ParentScreenViewController.h
//  TigglyStamp
//
//  Created by Swpnil j. on 26/07/13.
//  Copyright (c) 2013 cuelogic. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TConstant.h"
#import <QuartzCore/QuartzCore.h>
#import "SettingsViewController.h"
#import "FHSTwitterEngine.h"
#import <FacebookSDK/FacebookSDK.h>
#import <Pinterest/Pinterest.h>

@interface ParentScreenViewController : UIViewController<UITextFieldDelegate,FHSTwitterEngineAccessTokenDelegate>
{
    Pinterest*  _pinterest;
    
}
@property (nonatomic,strong) IBOutlet UIButton *homeBTN;
@property (nonatomic,strong) IBOutlet UIButton *subscribeBTN;
@property (nonatomic,strong) IBOutlet UIButton *settingsBTN;
@property (nonatomic,strong) IBOutlet UIButton *faceBookBTN;
@property (nonatomic,strong) IBOutlet UIButton *twitterBTN;
@property (nonatomic,strong) IBOutlet UIButton *pathBTN;
@property (nonatomic,strong) IBOutlet UIButton *skipBTN;
@property (nonatomic,strong) IBOutlet UIButton *submitBTN;
@property (nonatomic,strong) IBOutlet UIView *childInfoView;
@property (nonatomic,strong) IBOutlet UIView *childInfoSubView;
@property (nonatomic,strong) IBOutlet UIView *confView;
@property (nonatomic,strong) IBOutlet UIView *confSubView;
@property (nonatomic,strong) IBOutlet UITextField *emailidTextField;
@property (nonatomic,strong) IBOutlet UITextField *nameTextField;
@property (nonatomic,strong) IBOutlet UITextField *ageTextField;
@property (nonatomic, retain) FBSession *activeSession;
@property (nonatomic, retain) NSString *userFieldsRequired;
@property (nonatomic, retain) NSArray *permissions;

-(IBAction)onButtonClicked:(id)sender;
@end
