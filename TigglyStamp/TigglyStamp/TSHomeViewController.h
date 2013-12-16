//
//  TSHomeViewController.h
//  ivyApplication
//
//  Created by Dattatraya Anarase on 19/07/13.
//
//

#import <UIKit/UIKit.h>
#import "TConstant.h"
#import "TigglyStampUtils.h"
#import "ThumbnailView.h"
#import "GestureConfirmationView.h"
#import "ServerController.h"

@interface TSHomeViewController : UIViewController<ThumbnailViewProtocol,GestireViewProtocol,ServiceControlerDelegate>{
    IBOutlet UIButton *playBtn;
    IBOutlet UIButton *forParentsBtn;
    IBOutlet UIButton *newsBtn;
    IBOutlet UIScrollView *imgScrollView;
    IBOutlet UILabel *lblForParents;
    IBOutlet UIView *confirmationView;
    IBOutlet UIImageView *confirmationViewBKG;
    IBOutlet UITextView *txtView;
    IBOutlet UIButton *notConfirm;
    IBOutlet UIImageView *bkgImageView;
    IBOutlet UIView *containerView;
    IBOutlet UILabel *lblUnlockWithShapes;
     IBOutlet UILabel *lblLearnMore;
    
    NSMutableArray *diskImages;
    NSMutableArray *allThumbnails;
    
    NSTimer *playBtnTimer;
    CALayer *bkgLayer;
    
    BOOL isFirstTimePlay;
    BOOL isThumbnailLongPressed;
    
    GestureConfirmationView *gestureView;
    
    IBOutlet UIWebView *_webView;
    IBOutlet UIButton *btnNews;    
    IBOutlet UILabel *lblHappyHolidays;
    IBOutlet UIActivityIndicatorView *activityIndicator;
    IBOutlet UIView *viewForNews;

}

@property(nonatomic, strong) UIScrollView *imgScrollView;
@property(nonatomic, strong) UIImageView *bkgImageView;
@property(nonatomic, strong) UIView *containerView;
@property(nonatomic,strong) IBOutlet UIButton *learnMoreBtn;

-(IBAction)playGame:(id)sender;
-(IBAction)goToParentsScreen:(id)sender;
-(IBAction)goToNewsScreen:(id)sender;
-(IBAction)actionLearnMore;
-(IBAction)actionForNews:(id)sender;

@end
