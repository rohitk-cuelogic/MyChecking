//
//  ThumbnailView.m
//  TigglyStamp
//
//  Created by Sachin Patil on 01/08/13.
//  Copyright (c) 2013 cuelogic. All rights reserved.
//

#import "ThumbnailView.h"
#import "TDSoundManager.h"

#define RADIANS(degrees) ((degrees * M_PI) / 180.0)

@implementation ThumbnailView

@synthesize imageName,imgView,actulaImage,delegate,imageNameWithBorder;

#pragma mark -
#pragma mark =======================================
#pragma mark Init
#pragma mark =======================================


- (id)initWithFrame:(CGRect)frame withThumbnailImagePath:(NSString *) imgePath{
    DebugLog(@"");
    DebugLog(@"Frame : %@",NSStringFromCGRect(frame));
    DebugLog(@"ImagePath : %@",imgePath);
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor clearColor];
        
        imageName = imgePath;
        
        imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0,0, self.frame.size.width-20, self.frame.size.height-20) ];
        [imgView setContentMode:UIViewContentModeScaleToFill];
        imgView.layer.cornerRadius = 30.0f;
        imgView.layer.masksToBounds = YES;
        imgView.backgroundColor = [UIColor grayColor];
        [self addSubview:imgView];
        

        busyView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
        busyView.frame = CGRectMake(imgView.frame.size.width/2 - 20, imgView.frame.size.height/2 - 20, 40, 40);
        [imgView addSubview:busyView];
        [busyView startAnimating];
        
        
        playBtn = [[UIImageView alloc] initWithFrame:CGRectMake(imgView.frame.size.width/2 - 25, imgView.frame.size.height/2 - 25,50, 50)];
        playBtn.image = [UIImage imageNamed:@"play_btn.png"];
        [imgView addSubview:playBtn];
        [imgView bringSubviewToFront:playBtn];
        playBtn.hidden = YES;

        closeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [closeBtn setBackgroundImage:[UIImage imageNamed:@"close.png"] forState:UIControlStateNormal];
        [closeBtn setBackgroundImage:[UIImage imageNamed:@"close.png"] forState:UIControlStateSelected];
        [closeBtn addTarget:self action:@selector(actionClose)forControlEvents:UIControlEventTouchUpInside];
        closeBtn.frame = CGRectMake(imgView.frame.size.width - 30,-5,44, 44);
        closeBtn.hidden =YES;
        [self addSubview:closeBtn];
        closeBtn.userInteractionEnabled = YES;
        [imgView bringSubviewToFront:closeBtn];
        [self bringSubviewToFront:closeBtn];
        
        [self setUserInteractionEnabled:YES];
        
        mTapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageTapped)];
        [self addGestureRecognizer:mTapGesture];
        
        UILongPressGestureRecognizer *gesture = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(handleGesture:)];
        gesture.minimumPressDuration = 1.0;
        gesture.allowableMovement = 600;
        [self addGestureRecognizer:gesture];

        
        dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
            [self performSelectorInBackground:@selector(displayImages) withObject:nil];
        });
    }
    return self;
}

#pragma mark-
#pragma mark======================
#pragma mark Helpers
#pragma mark======================

-(void) displayImages {
    DebugLog(@"");

        UIImage *image = nil;
    
        CGRect rect = CGRectMake(40, 40, 640, 460);
        if ([[UIScreen mainScreen] respondsToSelector:@selector(scale)] == YES && [[UIScreen mainScreen] scale] == 2.00) {
            rect = CGRectMake(80, 80, 1280,920);
        }
    
        if([[[imageName lastPathComponent] pathExtension] isEqualToString:@"png"]){
            image = [UIImage imageWithContentsOfFile:imageName];
            
            //Crop the image to remove the border
            CGImageRef imageRef = CGImageCreateWithImageInRect([image CGImage], rect);
            UIImage *cropped = [UIImage imageWithCGImage:imageRef];
            CGImageRelease(imageRef);
            
            imgView.image = cropped;
            UIGraphicsEndImageContext();
            
            actulaImage = image;
            
            playBtn.hidden = YES;
            [busyView stopAnimating];
            busyView.hidden = YES;

        }else if([[[imageName lastPathComponent] pathExtension] isEqualToString:@"mov"]){
            
            UIImage *img = [[TigglyStampUtils sharedInstance] getMovieImageForMovieName:[imageName lastPathComponent]];
          
            //Crop the image to remove the border
            CGImageRef imageRef = CGImageCreateWithImageInRect([img CGImage], rect);
            UIImage *cropped = [UIImage imageWithCGImage:imageRef];
            CGImageRelease(imageRef);
            
            imgView.image = cropped;
            UIGraphicsEndImageContext();
         
            actulaImage =  img;
            
            playBtn.hidden = NO;
            [busyView stopAnimating];
            busyView.hidden = YES;
            

        }
}

-(void) playSlidingSounds{
    DebugLog(@"");
    int ranNo = arc4random() % 3;
    
    switch (ranNo) {
        case 0:
            [[TDSoundManager sharedManager] playSound:@"Tiggly_SFX_MAGIC_12" withFormat:@"mp3"];
            break;
        case 1:
            [[TDSoundManager sharedManager] playSound:@"Tiggly_SFX_MAGIC_13" withFormat:@"mp3"];
            break;
        case 2:
            [[TDSoundManager sharedManager] playSound:@"Tiggly_SFX_MAGIC_14" withFormat:@"mp3"];
            break;
            
        default:
            break;
    }
    
    
}
-(void) actionClose {
    DebugLog(@"");    
    [self.delegate thumbnailViewCloseBtnClicked:self];
}

- (void)handleGesture:(UIGestureRecognizer *)gestureRecognizer {
    DebugLog(@"");
    if(closeBtn.hidden)
        [self.delegate thumbnailViewLongPressed];
}

-(void)imageTapped{
    DebugLog(@"");
    if(closeBtn.hidden) {
        [self.delegate thumbnailViewTapped:self];
    }
}


- (void) startAnimation {
   DebugLog(@"");
    [self removeGestureRecognizer:mTapGesture];
    closeBtn.hidden = NO;
    closeBtn.userInteractionEnabled = YES;
    [imgView bringSubviewToFront:closeBtn];
    [self bringSubviewToFront:closeBtn];

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
    [self addGestureRecognizer:mTapGesture];
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
