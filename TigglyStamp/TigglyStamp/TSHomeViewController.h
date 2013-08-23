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

@interface TSHomeViewController : UIViewController<ThumbnailViewProtocol>{
    IBOutlet UIButton *playBtn;
    IBOutlet UIButton *forParentsBtn;
    IBOutlet UIButton *newsBtn;
    IBOutlet UIScrollView *imgScrollView;
    IBOutlet UILabel *lblForParents;
    IBOutlet UIView *confirmationView;
    IBOutlet UITextView *txtView;
    IBOutlet UIButton *notConfirm;
    NSMutableArray *diskImages;
    IBOutlet UIImageView *bkgImageView;
    NSMutableArray *arrMovingObj;
    IBOutlet UIView *containerView;
}

@property(nonatomic, strong)UIScrollView *imgScrollView;
@property(nonatomic, strong)UIImageView *bkgImageView;
@property (nonatomic, strong) UIView *containerView;

-(IBAction)playGame:(id)sender;
-(IBAction)goToParentsScreen:(id)sender;
-(IBAction)noConfirmation:(id)sender;
-(IBAction)goToNewsScreen:(id)sender;

@end
