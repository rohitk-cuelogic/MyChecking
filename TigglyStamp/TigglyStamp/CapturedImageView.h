//
//  CapturedImageView.h
//  TigglyStamp
//
//  Created by Sagar Kudale on 25/07/13.
//  Copyright (c) 2013 cuelogic. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KTViewController.h"
#import "GAITrackedViewController.h"
#import "GAI.h"
#import "GAIDictionaryBuilder.h"
#import "GAIFields.h"

@class CapturedImageView;

@protocol CapturedImageViewDelegate <NSObject>
-(void) onImageClicked:(CapturedImageView *)cImageView;
-(void) onNextButtonClicked:(CapturedImageView *)cImageView;
-(void) onHomeButtonClicked:(CapturedImageView *)cImageView;
-(void) onPlayButtonClicked:(CapturedImageView *)cImageView;
-(void) onSendButton:(CapturedImageView *)cImageView;

@end

@interface CapturedImageView : UIView
{
    UIImageView *imageView ;
    UIButton *btnHome;
    UIButton *btnNext;
    UIButton *btnPlay;
    UIButton *btnSend;
    NSString *imageName;
    UILabel *lblImageSaved;
    
    UIView *confirmationView;
    UIImageView *confirmationViewBKG;
    UIButton *notConfirm;
    UITextView *txtView;
    
}
@property(nonatomic,strong) id<CapturedImageViewDelegate>delegate;
@property (nonatomic,strong) UIImageView *imageView;
@property (nonatomic,strong) UIButton *btnPlay;

-(id) initWithFrame:(CGRect )rect ImageName:(NSString *) imgName;
@end
