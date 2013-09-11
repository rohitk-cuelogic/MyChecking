//
//  CapturedImageView.m
//  TigglyStamp
//
//  Created by Sagar Kudale on 25/07/13.
//  Copyright (c) 2013 cuelogic. All rights reserved.
//

#import "CapturedImageView.h"
#import "TConstant.h"
#import "TigglyStampUtils.h"

@implementation CapturedImageView
@synthesize delegate;
@synthesize imageView;
@synthesize btnPlay;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

-(id) initWithFrame:(CGRect )rect ImageName:(NSString *) imgName{
    DebugLog(@"");
    self = [super initWithFrame:rect];
    if (self) {
        
        [self setUserInteractionEnabled:YES];
        
        [self setBackgroundColor:[UIColor whiteColor]];
        
        if([[[imgName lastPathComponent]pathExtension] isEqualToString:@"mov"]) {
            NSString *strFile = [imgName lastPathComponent];
            UIImage *thumb = [[TigglyStampUtils sharedInstance] getThumbnailImageOfMovieFile:strFile];
            imageView = [[UIImageView alloc] initWithImage:thumb];
            imageView.frame = CGRectMake(100, 80,800,600);
            [self addSubview:imageView];
            
            btnPlay = [UIButton buttonWithType:UIButtonTypeCustom];
            [btnPlay setBackgroundImage:[UIImage imageNamed:@"play_btn.png"] forState:UIControlStateNormal];
            [btnPlay setBackgroundImage:[UIImage imageNamed:@"play_btn.png"] forState:UIControlStateSelected];
            [btnPlay addTarget:self action:@selector(btnPlayClicked)forControlEvents:UIControlEventTouchUpInside];
            btnPlay.frame = CGRectMake(imageView.frame.size.width/2 - 25, imageView.frame.size.height/2 - 25,100, 100);
            btnPlay.center = imageView.center;
            btnPlay.hidden = YES;
            [self addSubview:btnPlay];
            
            //adding home button and next scene button
            btnNext = [UIButton buttonWithType:UIButtonTypeCustom];
            [btnNext setBackgroundImage:[UIImage imageNamed:@"back_btn@2x~ipad.png"] forState:UIControlStateNormal];
            [btnNext setBackgroundImage:[UIImage imageNamed:@"back_btn@2x~ipad.png"] forState:UIControlStateSelected];
            [btnNext addTarget:self action:@selector(btnNextClicked)forControlEvents:UIControlEventTouchUpInside];
            btnNext.frame = CGRectMake(900, 10, 80, 80);
           // btnNext.transform=CGAffineTransformMakeRotation(M_PI);
            [self addSubview:btnNext];
            
            btnHome = [UIButton buttonWithType:UIButtonTypeCustom];
            [btnHome setBackgroundImage:[UIImage imageNamed:@"home-icon.png"] forState:UIControlStateNormal];
            [btnHome setBackgroundImage:[UIImage imageNamed:@"home-icon.png"] forState:UIControlStateSelected];
            [btnHome addTarget:self action:@selector(btnHomeClicked)forControlEvents:UIControlEventTouchUpInside];
            btnHome.frame = CGRectMake(05, 05, 75, 75);
            [self addSubview:btnHome];
            
        }else{
    
//            [self showFlashEffect:imgName];
            
            [self showPhotoPreview:imgName];

        }
    }
    
    return self;
}

#pragma mark - ============================
#pragma mark - button  and image touch handling
#pragma mark - ============================

-(void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    DebugLog(@"");
      CGPoint point = [[touches anyObject] locationInView:self];
    if (CGRectContainsPoint(imageView.frame, point)) {
        // call delegate
       // [delegate onImageClicked:self];
    }
    
}

-(void)btnNextClicked{
    DebugLog(@"");
    //call delegate
    [delegate onNextButtonClicked:self];
}

-(void)btnHomeClicked{
    DebugLog(@"");
    //call delegate
    
    [delegate onHomeButtonClicked:self];
}

-(void)btnPlayClicked{
    DebugLog(@"");
    //call delegate
    [delegate onPlayButtonClicked:self];
}


-(void)showPhotoPreview:(NSString *)imgName {
    DebugLog(@"");
    
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)objectAtIndex:0];
    UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfFile:[path stringByAppendingPathComponent:imgName]]];
    UIGraphicsBeginImageContext(CGSizeMake(800, 600));
    [image drawInRect:CGRectMake(0, 0, 800, 600)];
    UIImage *thumbnailImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    imageView = [[UIImageView alloc] initWithImage:thumbnailImage];
    imageView.frame = CGRectMake(0, 0, 700, 525);
    imageView.center = CGPointMake(512, 1000);
    [self addSubview:imageView];
    
    imageView.transform = CGAffineTransformMakeRotation(-5 * M_PI / 180);
    
    imageView.layer.shadowColor = [UIColor grayColor].CGColor;
    imageView.layer.shadowOffset = CGSizeMake(-3.0, 3.0);
    imageView.layer.shadowOpacity = 1.0;
    imageView.layer.shadowRadius = 3.0;
    
    [UIView animateWithDuration:1.2
                     animations:^{
                         imageView.center = CGPointMake(512, 384);
                     }
                     completion:^(BOOL finished){
                     }];

    //adding home button and next scene button
    btnNext = [UIButton buttonWithType:UIButtonTypeCustom];
    [btnNext setBackgroundImage:[UIImage imageNamed:@"back_btn@2x~ipad.png"] forState:UIControlStateNormal];
    [btnNext setBackgroundImage:[UIImage imageNamed:@"back_btn@2x~ipad.png"] forState:UIControlStateSelected];
    [btnNext addTarget:self action:@selector(btnNextClicked)forControlEvents:UIControlEventTouchUpInside];
    btnNext.frame = CGRectMake(900, 10, 80, 80);
    //btnNext.transform=CGAffineTransformMakeRotation(M_PI);
    [self addSubview:btnNext];
    
    btnHome = [UIButton buttonWithType:UIButtonTypeCustom];
    [btnHome setBackgroundImage:[UIImage imageNamed:@"home-icon.png"] forState:UIControlStateNormal];
    [btnHome setBackgroundImage:[UIImage imageNamed:@"home-icon.png"] forState:UIControlStateSelected];
    [btnHome addTarget:self action:@selector(btnHomeClicked)forControlEvents:UIControlEventTouchUpInside];
    btnHome.frame = CGRectMake(05, 05, 75, 75);
    [self addSubview:btnHome];
    
}



@end
