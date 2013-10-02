//
//  CapturedImageView.h
//  TigglyStamp
//
//  Created by Sagar Kudale on 25/07/13.
//  Copyright (c) 2013 cuelogic. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KTViewController.h"
#import "GestureConfirmationView.h"
#import "UIImage+Resize.h"
#ifdef GOOGLE_ANALYTICS_START
#import "GAITrackedViewController.h"
#import "GAI.h"
#import "GAIDictionaryBuilder.h"
#import "GAIFields.h"
#else
#endif

@class CapturedImageView;

@protocol CapturedImageViewDelegate <NSObject>
-(void) onImageClicked:(CapturedImageView *)cImageView;
-(void) onNextButtonClicked:(CapturedImageView *)cImageView;
-(void) onHomeButtonClicked:(CapturedImageView *)cImageView;
-(void) onPlayButtonClicked:(CapturedImageView *)cImageView;
-(void) onSendButton:(CapturedImageView *)cImageView;

@end

@interface CapturedImageView : UIView<GestireViewProtocol>
{
    UIImageView *imageView ;
    UIButton *btnHome;
    UIButton *btnNext;
    UIButton *btnPlay;
    UIButton *btnSend;
    NSString *imageName;
    UILabel *lblImageSaved;

}
@property(nonatomic,strong) id<CapturedImageViewDelegate>delegate;
@property (nonatomic,strong) UIImageView *imageView;
@property (nonatomic,strong) UIButton *btnPlay;

-(id) initWithFrame:(CGRect )rect ImageName:(NSString *) imgName;
@end
