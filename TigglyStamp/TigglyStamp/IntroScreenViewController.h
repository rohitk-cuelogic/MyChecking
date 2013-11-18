//
//  IntroScreenViewController.h
//  TigglyStamp
//
//  Created by cuelogic on 01/07/13.
//  Copyright (c) 2013 cuelogic. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import <MediaPlayer/MediaPlayer.h>
#import "TConstant.h"



#ifdef GOOGLE_ANALYTICS_START
#import "GAITrackedViewController.h"
#import "GAI.h"
#import "GAIDictionaryBuilder.h"
#import "GAIFields.h"
#else
#endif


@interface IntroScreenViewController:UIViewController<UIPopoverControllerDelegate> {

    BOOL isLanguageScreenDisplayed;
    IBOutlet UILabel *lblWithoutShape;
    IBOutlet UILabel *lblWithShape;
    MPMoviePlayerController *moviePlayer;
    UIView *viewForVideo;
    NSTimer *tmrCloseBtn;
    BOOL _isRemoveAllElement;

}
@property (nonatomic, strong) IBOutlet UIButton *btnGoLanguage;
@property (nonatomic, strong) IBOutlet UIButton *btnWithShape;
@property (nonatomic, strong) IBOutlet UIButton *btnWithoutShape;
@property (nonatomic, strong) IBOutlet UIView *languageView;
@property (nonatomic, strong) IBOutlet UIView *languageSubView;
@property (nonatomic, strong) IBOutlet UILabel *lblLunguage;
@property (nonatomic, strong) IBOutlet UILabel *lblLunguageTest;
@property (nonatomic, strong) IBOutlet UIImageView *bkgImageView;
@property (nonatomic, strong) IBOutlet UIImageView *bkgImageViewlang;
@property (nonatomic, strong) IBOutlet UITableView *tblView;
@property (nonatomic, strong) IBOutlet UIView *gameTypeView;
@property (nonatomic, readwrite) BOOL isShowLogo;
@property (nonatomic, strong) NSMutableArray *arrLanguage;

-(IBAction)onButtonTouched:(id)sender;
-(IBAction)closeButtonClicked:(id)sender;
-(IBAction)actionGoBackToLanguage;
@end
