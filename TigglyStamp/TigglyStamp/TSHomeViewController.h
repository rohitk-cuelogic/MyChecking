//
//  TSHomeViewController.h
//  ivyApplication
//
//  Created by Dattatraya Anarase on 19/07/13.
//
//

#import <UIKit/UIKit.h>
#import "TConstant.h"
#import "TSThumbnailView.h"
#import "TigglyStampUtils.h"
#import "ThumbnailView.h"
#import "GestureConfirmationView.h"

@interface TSHomeViewController : UIViewController<ThumbnailViewProtocol,GestireViewProtocol>{
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
    
    NSMutableArray *diskImages;
    NSMutableArray *allThumbnails;
    
    NSTimer *playBtnTimer;
    CALayer *bkgLayer;
    
    BOOL isFirstTimePlay;
    BOOL isThumbnailLongPressed;
    
    GestureConfirmationView *gestureView;
}

@property(nonatomic, strong) UIScrollView *imgScrollView;
@property(nonatomic, strong) UIImageView *bkgImageView;
@property(nonatomic, strong) UIView *containerView;
@property(nonatomic,strong) IBOutlet UIButton *learnMoreBtn;

-(IBAction)playGame:(id)sender;
-(IBAction)goToParentsScreen:(id)sender;
-(IBAction)noConfirmation:(id)sender;
-(IBAction)goToNewsScreen:(id)sender;
-(IBAction)actionLearnMore;

@end
