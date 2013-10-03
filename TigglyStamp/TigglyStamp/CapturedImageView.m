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
        imageName = imgName;
        
        [self setUserInteractionEnabled:YES];
        
        [self setBackgroundColor:[UIColor colorWithRed:150.0f/255.0f green:199.0f/255.0f blue:87.0f/255.0f alpha:1.0f]];

        if([[[imgName lastPathComponent]pathExtension] isEqualToString:@"mov"]) {
            
            UIView *view = [[UIView alloc] initWithFrame:CGRectMake(100,90, 820, 650)];
            view.backgroundColor = [UIColor whiteColor];
             view.layer.cornerRadius = 20.0f;
            
            [self addSubview:view];
            
            NSDate* currentDate = [NSDate date];
            NSDateFormatter *dateFormat = [[NSDateFormatter alloc]init];
            [dateFormat setDateFormat:@"MM/dd/yyyy"];
            // convert it to a string
            NSString *dateString = [dateFormat stringFromDate:currentDate];
            
            UILabel *lblDate = [[UILabel alloc] initWithFrame:CGRectMake(0, 595, 820, 50)];
            lblDate.textAlignment = UITextAlignmentCenter;
            lblDate.backgroundColor = [UIColor clearColor];
            lblDate.text = dateString;
            lblDate.textColor = [UIColor blueColor];
            lblDate.font = [UIFont fontWithName:APP_FONT size:30.0f];
            [view addSubview:lblDate];
            
            NSString *strFile = [imgName lastPathComponent];
            UIImage *thumb = [[TigglyStampUtils sharedInstance] getThumbnailImageOfMovieFile:strFile];
            imageView = [[UIImageView alloc] initWithImage:thumb];
            imageView.frame = CGRectMake(140, 120,750,563);
            [self addSubview:imageView];
            
            btnPlay = [UIButton buttonWithType:UIButtonTypeCustom];
            [btnPlay setBackgroundImage:[UIImage imageNamed:@"play_btn.png"] forState:UIControlStateNormal];
            [btnPlay setBackgroundImage:[UIImage imageNamed:@"play_btn.png"] forState:UIControlStateSelected];
            [btnPlay addTarget:self action:@selector(btnPlayClicked)forControlEvents:UIControlEventTouchUpInside];
            btnPlay.frame = CGRectMake(imageView.frame.size.width/2 - 25, imageView.frame.size.height/2 - 25,100, 100);
            btnPlay.center = imageView.center;
            btnPlay.hidden = YES;
            [self addSubview:btnPlay];
            
            
        }else{

            UIImageView *view = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 740, 540)];
            view.image = [UIImage imageNamed:@"photo_bg.png"];
            view.center = CGPointMake(512, 1000);
            view.transform = CGAffineTransformMakeRotation(-5 * M_PI / 180);
            view.layer.cornerRadius = 20.0f;
            [self addSubview:view];
            
            NSDate* currentDate = [NSDate date];
            NSDateFormatter *dateFormat = [[NSDateFormatter alloc]init];
            [dateFormat setDateFormat:@"MM/dd/yyyy"];
            NSString *dateString = [dateFormat stringFromDate:currentDate];
            
            UILabel *lblDate = [[UILabel alloc] initWithFrame:CGRectMake(0, 450, 700, 50)];
            lblDate.textAlignment = UITextAlignmentCenter;
            lblDate.backgroundColor = [UIColor clearColor];
            lblDate.text = dateString;
            lblDate.textColor = [UIColor blueColor];
            lblDate.font = [UIFont fontWithName:APP_FONT size:30.0f];
            [view addSubview:lblDate];
            
            NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)objectAtIndex:0];
            UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfFile:[path stringByAppendingPathComponent:imgName]]];
            UIGraphicsBeginImageContext(CGSizeMake(800, 600));
            [image drawInRect:CGRectMake(0, 0, 800, 600)];
            UIImage *thumbnailImage = UIGraphicsGetImageFromCurrentImageContext();
            UIGraphicsEndImageContext();
            
            UIImage *imagenew = [thumbnailImage imageByScalingAndCroppingForSize:CGSizeMake(665,405)];
            imageView = [[UIImageView alloc] initWithImage:imagenew];
            imageView.frame = CGRectMake(20,20, 665, 405);
            imageView.center = CGPointMake(503, 965);
            [self addSubview:imageView];
            
            imageView.transform = CGAffineTransformMakeRotation(-5 * M_PI / 180);
            
            
            [UIView animateWithDuration:1.2
                             animations:^{
                                 imageView.center = CGPointMake(503, 365);
                                 view.center = CGPointMake(512, 400);
                             }
                             completion:^(BOOL finished){
                             }];

        }
        
        //adding home button and next scene button
        btnNext = [UIButton buttonWithType:UIButtonTypeCustom];
        [btnNext setBackgroundImage:[UIImage imageNamed:@"arrow_right_3.png"] forState:UIControlStateNormal];
        [btnNext setBackgroundImage:[UIImage imageNamed:@"arrow_right_3.png"] forState:UIControlStateSelected];
        [btnNext addTarget:self action:@selector(btnNextClicked)forControlEvents:UIControlEventTouchUpInside];
        btnNext.frame = CGRectMake(900, 10, 80, 80);
        [self addSubview:btnNext];
        
        btnHome = [UIButton buttonWithType:UIButtonTypeCustom];
        [btnHome setBackgroundImage:[UIImage imageNamed:@"home_icon_1.png"] forState:UIControlStateNormal];
        [btnHome setBackgroundImage:[UIImage imageNamed:@"home_icon_1.png"] forState:UIControlStateSelected];
        [btnHome addTarget:self action:@selector(btnHomeClicked)forControlEvents:UIControlEventTouchUpInside];
        btnHome.frame = CGRectMake(44, 10, 75, 75);
        [self addSubview:btnHome];
        
        
        btnSend = [UIButton buttonWithType:UIButtonTypeCustom];
        [btnSend setBackgroundImage:[UIImage imageNamed:@"send_icon.png"] forState:UIControlStateNormal];
        [btnSend setBackgroundImage:[UIImage imageNamed:@"send_icon.png"] forState:UIControlStateSelected];
        [btnSend addTarget:self action:@selector(btnSendClicked)forControlEvents:UIControlEventTouchUpInside];
        btnSend.frame = CGRectMake(472, 10, 80, 80);
        [self addSubview:btnSend];
        

    }
    
    return self;
}

#pragma mark - ============================
#pragma mark - button  and image touch handling
#pragma mark - ============================

-(void)btnNextClicked{
    DebugLog(@"");
    //call delegate
    [delegate onNextButtonClicked:self];
}

-(void)btnHomeClicked{
    DebugLog(@"");
    //call delegate
#ifdef GOOGLE_ANALYTICS_START
    NSMutableDictionary *event =
    [[GAIDictionaryBuilder createEventWithCategory:@"Home Button"
                                            action:@"Home button Clicked"
                                             label:@"Home From Photo page"
                                             value:nil] build];
    [[GAI sharedInstance].defaultTracker send:event];
    [[GAI sharedInstance] dispatch];
#else
    
#endif
    

    
    [delegate onHomeButtonClicked:self];
}

-(void)btnSendClicked{
    DebugLog(@"");
    
    GestureConfirmationView *gestureView = [[GestureConfirmationView alloc] initWithFrame:CGRectMake(0, 0, 1024, 768)];
    gestureView.delegate = self;
    [self addSubview:gestureView];
    [self bringSubviewToFront:gestureView];
    
}

-(void)btnPlayClicked{
    DebugLog(@"");
    //call delegate
    [delegate onPlayButtonClicked:self];
}



-(void) gestureViewOnGestureConfirmed:(GestureConfirmationView *) gView {
    DebugLog(@"");
#ifdef GOOGLE_ANALYTICS_START
    NSMutableDictionary *event =
    [[GAIDictionaryBuilder createEventWithCategory:@"Gallery"
                                            action:@"Gallery opened"
                                             label:@"Save Image/ Video"
                                             value:nil] build];
    [[GAI sharedInstance].defaultTracker send:event];
    [[GAI sharedInstance] dispatch];
#else

#endif



    NSString *strFile = [imageName lastPathComponent];

    lblImageSaved = [[UILabel alloc] initWithFrame:CGRectMake(442, 91,  140, 50)];
    lblImageSaved.backgroundColor = [UIColor whiteColor];
    lblImageSaved.layer.cornerRadius = 13.0f;
    lblImageSaved.layer.masksToBounds = YES;
    lblImageSaved.layer.borderColor =  [UIColor blackColor].CGColor;
    lblImageSaved.layer.borderWidth = 1.0f;

    [self addSubview:lblImageSaved];
    lblImageSaved.font = [UIFont fontWithName:APP_FONT size:20.0f];
    lblImageSaved.textAlignment = UITextAlignmentCenter;
    if([[strFile pathExtension] isEqualToString:@"mov"]) {

        NSString *exportPath = [[NSString alloc] initWithFormat:@"%@/%@",
                                [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0], strFile];
        if (UIVideoAtPathIsCompatibleWithSavedPhotosAlbum (exportPath)) {
            UISaveVideoAtPathToSavedPhotosAlbum (exportPath, nil, nil, nil);
        }
        lblImageSaved.text = @"Video Saved";

    }else{
        NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)objectAtIndex:0];
        UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfFile:[path stringByAppendingPathComponent:imageName]]];

        UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil);

        lblImageSaved.text = @"Image Saved";
    }

    [UIView animateWithDuration:3.0
                     animations:^{
                         lblImageSaved.alpha = 0;
                     }
                     completion:^(BOOL finished){
                         [lblImageSaved removeFromSuperview];
                     }];

}

@end
