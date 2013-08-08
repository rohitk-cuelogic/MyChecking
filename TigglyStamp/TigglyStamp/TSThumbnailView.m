//
//  TDThumbnailView.m
//  ivyApplication
//
//  Created by Dattatraya Anarase on 25/07/13.
//
//

#import "TSThumbnailView.h"

@implementation TDThumbnailView
@synthesize imgView, actulaImage, imageName;

#pragma mark-
#pragma mark======================
#pragma mark View Life Cycle
#pragma mark======================

- (id)initWithFrame:(CGRect)frame withImage:(UIImage *)img imageName:(NSString *)imgName{
    DebugLog(@"");
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code

        actulaImage = img;
        imageName = imgName;
        
        imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        [imgView setContentMode:UIViewContentModeScaleAspectFit];
        
        UIGraphicsBeginImageContext(RECT_ACTUAL_THUMBNAIL_IMAGE_FRAME.size);
        [img drawInRect:RECT_ACTUAL_THUMBNAIL_IMAGE_FRAME];
        UIImage *thumbnailImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
        imgView.image = thumbnailImage;
        [self addSubview:imgView];
        
        UITapGestureRecognizer *mTapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageTapped)];
        [self addGestureRecognizer:mTapGesture];
    }
    return self;
}

#pragma mark-
#pragma mark======================
#pragma mark Game Handlers
#pragma mark======================

-(void)imageTapped{
    DebugLog(@"");
    [self.delegate thumbnailViewTapped:self];
}


@end
