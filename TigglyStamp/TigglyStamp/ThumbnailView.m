//
//  ThumbnailView.m
//  TigglyStamp
//
//  Created by Sachin Patil on 01/08/13.
//  Copyright (c) 2013 cuelogic. All rights reserved.
//

#import "ThumbnailView.h"

#define RADIANS(degrees) ((degrees * M_PI) / 180.0)

@implementation ThumbnailView

@synthesize imageName,imgView,actulaImage,delegate;

- (id)initWithFrame:(CGRect)frame withThumbnailImagePath:(NSString *) imgePath{
    DebugLog(@"");
    DebugLog(@"Frame : %@",NSStringFromCGRect(frame));
    DebugLog(@"ImagePath : %@",imgePath);
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor clearColor];
//        self.layer.cornerRadius = 30.0f;
//        self.layer.masksToBounds = YES;
        
        imageName = imgePath;
        
        imgView = [[UIImageView alloc] initWithFrame:CGRectMake(10,10, frame.size.width-20, frame.size.height-20)];
        [imgView setContentMode:UIViewContentModeScaleToFill];
        imgView.layer.cornerRadius = 30.0f;
        imgView.layer.masksToBounds = YES;
        imgView.backgroundColor = [UIColor lightGrayColor];

        busyView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
        busyView.frame = CGRectMake(imgView.frame.size.width/2 - 20, imgView.frame.size.height/2 - 20, 40, 40);
        [imgView addSubview:busyView];
        [busyView startAnimating];
        
        
        playBtn = [[UIImageView alloc] initWithFrame:CGRectMake(imgView.frame.size.width/2 - 25, imgView.frame.size.height/2 - 25,50, 50)];
        playBtn.image = [UIImage imageNamed:@"play_btn.png"];
        [imgView addSubview:playBtn];
        [imgView bringSubviewToFront:playBtn];
        playBtn.hidden = YES;
        
        [NSThread detachNewThreadSelector:@selector(displayImages) toTarget:self withObject:nil];
        
        [self addSubview:imgView];

        closeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [closeBtn setBackgroundImage:[UIImage imageNamed:@"close.png"] forState:UIControlStateNormal];
        [closeBtn setBackgroundImage:[UIImage imageNamed:@"close.png"] forState:UIControlStateSelected];
        [closeBtn addTarget:self action:@selector(actionClose)forControlEvents:UIControlEventTouchUpInside];
        closeBtn.frame = CGRectMake(imgView.frame.size.width - 22,0,44, 44);
        [self addSubview:closeBtn];
        closeBtn.hidden =YES;
        
        
        [self setUserInteractionEnabled:YES];
        
        UITapGestureRecognizer *mTapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageTapped)];
        [self addGestureRecognizer:mTapGesture];
        
        UILongPressGestureRecognizer *gesture = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(handleGesture:)];
        gesture.minimumPressDuration = 1.0;
        gesture.allowableMovement = 600;
        [self addGestureRecognizer:gesture];

        
        
    }
    return self;
}

#pragma mark-
#pragma mark======================
#pragma mark Game Handlers
#pragma mark======================

-(void) displayImages {
    DebugLog(@"");
        UIImage *image = nil;
        if([[[imageName lastPathComponent] pathExtension] isEqualToString:@"png"]){
            image = [UIImage imageWithData:[NSData dataWithContentsOfFile:imageName]];
            UIGraphicsBeginImageContext(RECT_ACTUAL_THUMBNAIL_IMAGE_FRAME.size);
            [image drawInRect:RECT_ACTUAL_THUMBNAIL_IMAGE_FRAME];
            UIImage *thumbnailImage = UIGraphicsGetImageFromCurrentImageContext();
            UIGraphicsEndImageContext();
            imgView.image = thumbnailImage;
            actulaImage = image;
            playBtn.hidden = YES;
            [busyView stopAnimating];
            busyView.hidden = YES;

        }else if([[[imageName lastPathComponent] pathExtension] isEqualToString:@"mov"]){

            UIImage *thumb = [[TigglyStampUtils sharedInstance] getThumbnailImageOfMovieFile:[imageName lastPathComponent]];
            imgView.image = thumb;
            actulaImage = thumb;
            playBtn.hidden = NO;
            [busyView stopAnimating];
            busyView.hidden = YES;
        }
}

-(void) actionClose {
    DebugLog(@"");
    
    [self.delegate thumbnailViewCloseBtnClicked:self];
}

- (void)handleGesture:(UIGestureRecognizer *)gestureRecognizer {
    DebugLog(@"");
    [self.delegate thumbnailViewLongPressed];
}

-(void)imageTapped{
    DebugLog(@"");
    [self.delegate thumbnailViewTapped:self];
}


- (void) startAnimation {
   DebugLog(@"");
    closeBtn.hidden = NO;
    self.transform = CGAffineTransformRotate(CGAffineTransformIdentity, RADIANS(-3));
    [UIView animateWithDuration:0.5
                          delay:0.0
                        options:(UIViewAnimationOptionAllowUserInteraction | UIViewAnimationOptionRepeat | UIViewAnimationOptionAutoreverse)
                     animations:^ {
                         self.transform = CGAffineTransformRotate(CGAffineTransformIdentity, RADIANS(3));
                     }
                     completion:NULL
     ];
}

- (void) stopAnimation {
   DebugLog(@"");
    closeBtn.hidden = YES;
    [UIView animateWithDuration:0.5
                          delay:0.0
                        options:(UIViewAnimationOptionAllowUserInteraction | UIViewAnimationOptionBeginFromCurrentState | UIViewAnimationOptionCurveLinear)
                     animations:^ {
                         self.transform = CGAffineTransformIdentity;
                     }
                     completion:NULL
     ];
}


@end
