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
            
            UIView *view = [[UIView alloc] initWithFrame:CGRectMake(80,80, 820, 650)];
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
//            imageView.frame = CGRectMake(100, 80,800,600);
            imageView.frame = CGRectMake(120, 110,750,563);
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
            [btnNext setBackgroundImage:[UIImage imageNamed:@"arrow_right_3.png"] forState:UIControlStateNormal];
            [btnNext setBackgroundImage:[UIImage imageNamed:@"arrow_right_3.png"] forState:UIControlStateSelected];
            [btnNext addTarget:self action:@selector(btnNextClicked)forControlEvents:UIControlEventTouchUpInside];
            btnNext.frame = CGRectMake(900, 10, 80, 80);
           // btnNext.transform=CGAffineTransformMakeRotation(M_PI);
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
            
            
        }else{
            
//            UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 1024, 768)];
//            imgView.image = [UIImage imageNamed:@"yellow_bg_2.png"];
//            [self addSubview:imgView];
            
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
    NSMutableDictionary *event =
    [[GAIDictionaryBuilder createEventWithCategory:@"Home Button"
                                            action:@"Home button Clicked"
                                             label:@"Home From Photo page"
                                             value:nil] build];
    [[GAI sharedInstance].defaultTracker send:event];
    [[GAI sharedInstance] dispatch];
    
    [delegate onHomeButtonClicked:self];
}

-(void)btnSendClicked{
    DebugLog(@"");
    [delegate onSendButton:self];
    
    NSMutableDictionary *event =
    [[GAIDictionaryBuilder createEventWithCategory:@"Gallery"
                                            action:@"Gallery opened"
                                             label:@"Save Image/ Video"
                                             value:nil] build];
    [[GAI sharedInstance].defaultTracker send:event];
    [[GAI sharedInstance] dispatch];
    
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
-(void)btnPlayClicked{
    DebugLog(@"");
    //call delegate
    [delegate onPlayButtonClicked:self];
}


-(void)showPhotoPreview:(NSString *)imgName {
    DebugLog(@"");
    
    UIImageView *view = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 740, 540)];
    //view.backgroundColor = [UIColor whiteColor];
    view.image = [UIImage imageNamed:@"photo_bg.png"];
    view.center = CGPointMake(512, 1000);
    view.transform = CGAffineTransformMakeRotation(-5 * M_PI / 180);
    view.layer.cornerRadius = 20.0f;
    
    [self addSubview:view];
    
    NSDate* currentDate = [NSDate date];
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc]init];
    [dateFormat setDateFormat:@"MM/dd/yyyy"];
    // convert it to a string
    NSString *dateString = [dateFormat stringFromDate:currentDate];
    
    UILabel *lblDate = [[UILabel alloc] initWithFrame:CGRectMake(0, 475, 700, 50)];
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
    imageView = [[UIImageView alloc] initWithImage:thumbnailImage];
    imageView.frame = CGRectMake(20,20, 660, 440);
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
                         view.center = CGPointMake(512, 400);
                     }
                     completion:^(BOOL finished){
                     }];

    //adding home button and next scene button
    btnNext = [UIButton buttonWithType:UIButtonTypeCustom];
    [btnNext setBackgroundImage:[UIImage imageNamed:@"arrow_right_3.png"] forState:UIControlStateNormal];
    [btnNext setBackgroundImage:[UIImage imageNamed:@"arrow_right_3.png"] forState:UIControlStateSelected];
    [btnNext addTarget:self action:@selector(btnNextClicked)forControlEvents:UIControlEventTouchUpInside];
    btnNext.frame = CGRectMake(900, 10, 80, 80);
    // btnNext.transform=CGAffineTransformMakeRotation(M_PI);
    [self addSubview:btnNext];
    
    btnHome = [UIButton buttonWithType:UIButtonTypeCustom];
    [btnHome setBackgroundImage:[UIImage imageNamed:@"home_icon_1.png"] forState:UIControlStateNormal];
    [btnHome setBackgroundImage:[UIImage imageNamed:@"home_icon_1.png"] forState:UIControlStateSelected];
    [btnHome addTarget:self action:@selector(btnHomeClicked)forControlEvents:UIControlEventTouchUpInside];
    btnHome.frame = CGRectMake(44, 10, 80, 80);
    [self addSubview:btnHome];
    
    
    btnSend = [UIButton buttonWithType:UIButtonTypeCustom];
    [btnSend setBackgroundImage:[UIImage imageNamed:@"send_icon.png"] forState:UIControlStateNormal];
    [btnSend setBackgroundImage:[UIImage imageNamed:@"send_icon.png"] forState:UIControlStateSelected];
    [btnSend addTarget:self action:@selector(btnSendClicked)forControlEvents:UIControlEventTouchUpInside];
    btnSend.frame = CGRectMake(472, 10, 80, 80);
    [self addSubview:btnSend];
    
    
}



@end
