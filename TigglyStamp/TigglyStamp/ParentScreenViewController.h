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
#import "FHSTwitterEngine.h"
#import <FacebookSDK/FacebookSDK.h>
#import <Pinterest/Pinterest.h>
#import <CFNetwork/CFNetwork.h>
#import "SKPSMTPMessage.h"
#import "NSData+Base64Additions.h"
#import "MBProgressHUD.h"
#import "Reachability.h"
#import "TSHomeViewController.h"
#import "SettingsView.h"
#import <MessageUI/MessageUI.h>
#import <MessageUI/MFMailComposeViewController.h>
#import "TSHomeViewController.h"

#ifdef GOOGLE_ANALYTICS_START
#import "GAI.h"
#import "GAIDictionaryBuilder.h"
#import "GAIFields.h"
@interface ParentScreenViewController : GAITrackedViewController<UITextFieldDelegate,UIWebViewDelegate, SettingViewProtocol,MFMailComposeViewControllerDelegate,SKPSMTPMessageDelegate>
#else
@interface ParentScreenViewController : UIViewController<UITextFieldDelegate,UIWebViewDelegate, SettingViewProtocol,MFMailComposeViewControllerDelegate,SKPSMTPMessageDelegate>
#endif



{
    Pinterest*  _pinterest;
    
    SettingsView *settingView;
    
    IBOutlet UIView *viewForWeb;
    IBOutlet UIWebView *webView;
    IBOutlet UIButton *btnClose;
    IBOutlet UIButton *btnTigglyNews;
    
    MBProgressHUD* hud;
    BOOL            isConnection;
    
    TSHomeViewController *homeViewController;
}
@property (nonatomic) BOOL isConnection;
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
@property (nonatomic,strong) IBOutlet UILabel *lettertabHeadingLBL;
@property (nonatomic,strong) IBOutlet UITextView *lettertabBodyTEXT;
@property (nonatomic,strong) IBOutlet UIButton *lettertabCloseBTN;
@property (nonatomic,strong) IBOutlet UIView *letterTabView;

@property (nonatomic,strong) IBOutlet UIButton *tabLetterMotarBTN;
@property (nonatomic,strong) IBOutlet UIButton *tabLetterLanguageBTN;
@property (nonatomic,strong) IBOutlet UIButton *tabLetterSpatialBTN;
@property (nonatomic,strong) IBOutlet UIScrollView *tabInforSCROLL;

@property (nonatomic,strong) IBOutlet UIWebView *webViewTab;

@property (nonatomic, strong) IBOutlet UIButton *btnPrivacyPolicy;
@property (nonatomic,strong)IBOutlet UIView *privacymainView;

@property (nonatomic,strong) IBOutlet UIView *clearView;

-(void) launchUnlockScreen;

-(IBAction)onButtonClicked:(id)sender;
-(IBAction)actionClosePrivacyPolicy:(id)sender;
-(IBAction)actionPrivacyPolicy:(id)sender;
-(IBAction)actionReview:(id)sender;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil withHomeView:(TSHomeViewController *) homeView;

@end
