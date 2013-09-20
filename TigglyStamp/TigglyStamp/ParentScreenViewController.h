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
#import "GAI.h"
#import "GAIDictionaryBuilder.h"
#import "GAIFields.h"

@interface ParentScreenViewController : UIViewController<UITextFieldDelegate,FHSTwitterEngineAccessTokenDelegate>
{
    Pinterest*  _pinterest;
    
    IBOutlet UIView *viewForWeb;
    IBOutlet UIWebView *webView;
    IBOutlet UIButton *btnClose;
    IBOutlet UIButton *btnTigglyNews;
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
@property (nonatomic,strong) IBOutlet UIButton *tabLetterBTN;
@property (nonatomic,strong) IBOutlet UIButton *tabPlayBTN;
@property (nonatomic,strong) IBOutlet UIButton *tabLearningTipBTN;
@property (nonatomic,strong) IBOutlet UIButton *tabLearPhilosophyBTN;
@property (nonatomic,strong) IBOutlet UIImageView *tabTitleIMGVIEW;
@property (nonatomic,strong) IBOutlet UITextView *tabHeading1TEXT;
@property (nonatomic,strong) IBOutlet UITextView *tabBody1TEXT;
@property (nonatomic,strong) IBOutlet UITextView *tabHeading2TEXT;
@property (nonatomic,strong) IBOutlet UITextView *tabBody2TEXT;
@property (nonatomic,strong) IBOutlet UITextView *tabHeading3TEXT;
@property (nonatomic,strong) IBOutlet UILabel *lblMotarTEXT;
@property (nonatomic,strong) IBOutlet UILabel *lblLanguageTEXT;
@property (nonatomic,strong) IBOutlet UILabel *lblSpatialTEXT;

@property (nonatomic,strong) IBOutlet UIButton *tabLetterMotarBTN;
@property (nonatomic,strong) IBOutlet UIButton *tabLetterLanguageBTN;
@property (nonatomic,strong) IBOutlet UIButton *tabLetterSpatialBTN;
@property (nonatomic,strong) IBOutlet UIScrollView *tabInforSCROLL;


-(IBAction)onButtonClicked:(id)sender;

@end
