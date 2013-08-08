//
//  CapturedImageView.h
//  TigglyStamp
//
//  Created by Sagar Kudale on 25/07/13.
//  Copyright (c) 2013 cuelogic. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CapturedImageView;

@protocol CapturedImageViewDelegate <NSObject>
-(void) onImageClicked:(CapturedImageView *)cImageView;
-(void) onNextButtonClicked:(CapturedImageView *)cImageView;
-(void) onHomeButtonClicked:(CapturedImageView *)cImageView;
@end

@interface CapturedImageView : UIView
{
    UIImageView *imageView ;
    UIButton *btnHome;
    UIButton *btnNext;
}
@property(nonatomic,strong) id<CapturedImageViewDelegate>delegate;
-(id) initWithFrame:(CGRect )rect ImageName:(NSString *) imgName;
@end
