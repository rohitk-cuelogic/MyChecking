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
#import <FacebookSDK/FacebookSDK.h>
#import <CFNetwork/CFNetwork.h>
#import "TSHomeViewController.h"
#import "SettingsView.h"
#import <MessageUI/MessageUI.h>
#import <MessageUI/MFMailComposeViewController.h>
#import "TSHomeViewController.h"
#import "ServerController.h"

typedef enum{
        kTabLetter,
        kTabPlay,
        kTabTips,
        kTabPhilosophy
}CurrentTab;

#ifdef GOOGLE_ANALYTICS_START
#import "GAI.h"
#import "GAIDictionaryBuilder.h"
#import "GAIFields.h"

@interface ParentScreenViewController : GAITrackedViewController<UITextFieldDelegate,UIWebViewDelegate, SettingViewProtocol,MFMailComposeViewControllerDelegate>
#else


@interface ParentScreenViewController : UIViewController<UITextFieldDelegate,UIWebViewDelegate, SettingViewProtocol,MFMailComposeViewControllerDelegate,SKPSMTPMessageDelegate>
#endif



{

    SettingsView *settingView;
    
    IBOutlet UIView *viewForWeb;
    IBOutlet UIWebView *webView;
    IBOutlet UIButton *btnClose;
    IBOutlet UIButton *btnReviewApp;
    IBOutlet UILabel *lblSubscribeHead;
    IBOutlet UILabel *lblSubscribeBtn;
    IBOutlet UILabel *lblSettingBtn;
    IBOutlet UILabel *lblReviewAppBtn;
    IBOutlet UILabel *lblSubscribConfirm;
    BOOL  isConnection;
    
    CurrentTab currTab;
    
    TSHomeViewController *homeViewController;
}

@property (nonatomic,strong) FBSession *activeSession;
@property (nonatomic,strong) NSString *userFieldsRequired;
@property (nonatomic,strong) NSArray *permissions;
@property (nonatomic, readwrite) BOOL isConnection;
@property (nonatomic,strong) IBOutlet UIButton *homeBTN;
@property (nonatomic,strong) IBOutlet UIButton *subscribeBTN;
@property (nonatomic,strong) IBOutlet UIButton *settingsBTN;
@property (nonatomic,strong) IBOutlet UIButton *faceBookBTN;
@property (nonatomic,strong) IBOutlet UIButton *twitterBTN;
@property (nonatomic,strong) IBOutlet UIButton *pathBTN;
@property (nonatomic,strong) IBOutlet UIButton *skipBTN;
@property (nonatomic,strong) IBOutlet UIButton *submitBTN;
@property (nonatomic,strong) IBOutlet UIView *confView;
@property (nonatomic,strong) IBOutlet UIView *confSubView;
@property (nonatomic,strong) IBOutlet UITextField *emailidTextField;
@property (nonatomic,strong) IBOutlet UITextField *nameTextField;
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
@property (nonatomic,strong) IBOutlet UIButton *tabLetterMotarBTN;
@property (nonatomic,strong) IBOutlet UIButton *tabLetterLanguageBTN;
@property (nonatomic,strong) IBOutlet UIButton *tabLetterSpatialBTN;
@property (nonatomic,strong) IBOutlet UIScrollView *tabInforSCROLL;
@property (nonatomic,strong) IBOutlet UIWebView *webViewTab;
@property (nonatomic,strong) IBOutlet UIButton *btnPrivacyPolicy;
@property (nonatomic,strong) IBOutlet UIView *privacymainView;
@property (nonatomic,strong) IBOutlet UILabel *lblTigglyPrivacyPolicy;
@property (nonatomic,strong) IBOutlet UITextView *txtViewPrivacyPolicy;
@property (nonatomic,strong) IBOutlet UIView *letterTabView;
@property (nonatomic,strong) IBOutlet UILabel *lettertabHeadingLBL;
@property (nonatomic,strong) IBOutlet UITextView *lettertabBodyTEXT;
@property (nonatomic,strong) IBOutlet UIButton *lettertabCloseBTN;

-(void) launchUnlockScreen;
-(IBAction)onButtonClicked:(id)sender;
-(IBAction)actionClosePrivacyPolicy:(id)sender;
-(IBAction)actionPrivacyPolicy:(id)sender;
-(IBAction)actionReview:(id)sender;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil withHomeView:(TSHomeViewController *) homeView;

@end
