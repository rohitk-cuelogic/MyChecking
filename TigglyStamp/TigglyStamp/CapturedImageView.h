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
#import "TDSignatureView.h"


#ifdef GOOGLE_ANALYTICS_START
#import "GAITrackedViewController.h"
#import "GAI.h"
#import "GAIDictionaryBuilder.h"
#import "GAIFields.h"
#else
#endif

#define FRAME_VIEW_FOR_SIGN CGRectMake(200, 515, 490, 100)
#define BTN_COLOR_SPLASH_CENTER_ALT CGPointMake(950, 700)
#define BTN_COLOR_SPLASH_CENTER CGPointMake(950, 650)

@class CapturedImageView;

@protocol CapturedImageViewDelegate <NSObject>
-(void) onImageClicked:(CapturedImageView *)cImageView;
-(void) onNextButtonClicked:(CapturedImageView *)cImageView;
-(void) onHomeButtonClicked:(CapturedImageView *)cImageView;
-(void) onPlayButtonClicked:(CapturedImageView *)cImageView;
-(void) onSendButton:(CapturedImageView *)cImageView;

@end

@interface CapturedImageView : UIView<GestireViewProtocol,SignatureViewProtocol> {
    UIImageView *imageView ;
    UIButton *btnHome;
    UIButton *btnNext;
    UIButton *btnPlay;
    UIButton *btnSend;
    NSString *imageName;
    UILabel *lblImageSaved;
    GestureConfirmationView *gestureView;
    UIView *viewForPreview;
    TDSignatureView *viewForSign;
    UIButton *btnColorSplash;
    NSMutableArray *colorArray;
    int colorCnt;
    
    BOOL isVideoImage;
    NSString *moviePngName;
    UIImage *imgToSave;
}
@property(nonatomic,strong) id<CapturedImageViewDelegate>delegate;
@property (nonatomic,strong) UIImageView *imageView;
@property (nonatomic,strong) UIButton *btnPlay;
@property (nonatomic, strong) NSString *moviePngName;

-(id) initWithFrame:(CGRect )rect withImage:(UIImage *) img isVideo:(BOOL) isVideo;

@end
