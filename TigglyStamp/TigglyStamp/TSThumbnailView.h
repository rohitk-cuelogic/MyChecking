//
//  TDThumbnailView.h
//  ivyApplication
//
//  Created by Dattatraya Anarase on 25/07/13.
//
//

#import <UIKit/UIKit.h>
#import "TConstant.h"

@class TDThumbnailView;

@protocol ThumbnailViewDelegate <NSObject>

-(void)thumbnailViewTapped:(TDThumbnailView *)thumbnail;

@end

@interface TDThumbnailView : UIView{
    UIImageView *imgView;
    UIImage *actulaImage;
    NSString *imageName;
}

@property (nonatomic, strong) UIImageView *imgView;
@property (nonatomic, strong) UIImage *actulaImage;
@property (nonatomic, strong) NSString *imageName;
@property (unsafe_unretained, nonatomic) id<ThumbnailViewDelegate> delegate;

-(id) initWithFrame:(CGRect)frame withImage:(UIImage *)img imageName:(NSString *)imgName;

@end
