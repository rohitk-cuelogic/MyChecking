//
//  ThumbnailView.h
//  TigglyStamp
//
//  Created by Sachin Patil on 01/08/13.
//  Copyright (c) 2013 cuelogic. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TConstant.h"
#import "TigglyStampUtils.h"


@class ThumbnailView;

@protocol ThumbnailViewProtocol <NSObject>

-(void)thumbnailViewTapped:(ThumbnailView *)thumbnail;

@end

@interface ThumbnailView : UIView {
    UIImageView *imgView;
    UIImage *actualImage;
    NSString *imageName;
}

@property (nonatomic, strong) UIImageView *imgView;
@property (nonatomic, strong) UIImage *actulaImage;
@property (nonatomic, strong) NSString *imageName;
@property (unsafe_unretained, nonatomic) id<ThumbnailViewProtocol> delegate;

- (id)initWithFrame:(CGRect)frame withThumbnailImagePath:(NSString *) imgePath;

@end
