//
//  ThumbnailView.m
//  TigglyStamp
//
//  Created by Sachin Patil on 01/08/13.
//  Copyright (c) 2013 cuelogic. All rights reserved.
//

#import "ThumbnailView.h"

@implementation ThumbnailView

@synthesize imageName,imgView,actulaImage,delegate;

- (id)initWithFrame:(CGRect)frame withThumbnailImagePath:(NSString *) imgePath{
    DebugLog(@"");
    DebugLog(@"Frame : %@",NSStringFromCGRect(frame));
    DebugLog(@"ImagePath : %@",imgePath);
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor whiteColor];
        self.layer.cornerRadius = 30.0f;
        self.layer.masksToBounds = YES;
        
//        UIActivityIndicatorView *busyView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
//        busyView.frame = CGRectMake(self.frame.size.width/2 - 20, self.frame.size.height/2 - 20, 40, 40);
//        [self addSubview:busyView];
//        [busyView startAnimating];
        
        imageName = imgePath;
        
        imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0,0, frame.size.width, frame.size.height)];
        [imgView setContentMode:UIViewContentModeScaleAspectFit];
        
//        UIImageView *imgViewFrame = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0,frame.size.width, frame.size.height)];
//        imgViewFrame.image = [UIImage imageNamed:@"frame.png"];
//        [self addSubview:imgViewFrame];
        
        UIImageView *playBtn = [[UIImageView alloc] initWithFrame:CGRectMake(imgView.frame.size.width/2 - 25, imgView.frame.size.height/2 - 25,50, 50)];
        playBtn.image = [UIImage imageNamed:@"play_btn.png"];
        [imgView addSubview:playBtn];
        [imgView bringSubviewToFront:playBtn];

        
        UIImage *image = nil;
        if([[[imgePath lastPathComponent] pathExtension] isEqualToString:@"png"]){
            image = [UIImage imageWithData:[NSData dataWithContentsOfFile:imgePath]];            
            UIGraphicsBeginImageContext(RECT_ACTUAL_THUMBNAIL_IMAGE_FRAME.size);
            [image drawInRect:RECT_ACTUAL_THUMBNAIL_IMAGE_FRAME];
            UIImage *thumbnailImage = UIGraphicsGetImageFromCurrentImageContext();
            UIGraphicsEndImageContext();
            imgView.image = thumbnailImage;
            actulaImage = image;
            playBtn.hidden = YES;
            
        }else if([[[imgePath lastPathComponent] pathExtension] isEqualToString:@"mov"]){

            UIImage *thumb = [[TigglyStampUtils sharedInstance] getThumbnailImageOfMovieFile:[imgePath lastPathComponent]];
            imgView.image = thumb;
            actulaImage = thumb;
            playBtn.hidden = NO;
        }
        
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
