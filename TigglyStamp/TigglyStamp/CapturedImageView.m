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
            
            viewForPreview = [[UIView alloc] initWithFrame:CGRectMake(155,90, 710, 650)];
            viewForPreview.backgroundColor = [UIColor whiteColor];
            viewForPreview.layer.cornerRadius = 20.0f;
            viewForPreview.layer.masksToBounds = YES;
            
            [viewForPreview.layer setBorderColor:[UIColor lightGrayColor].CGColor];
            [viewForPreview.layer setBorderWidth:1.5f];
            
            // drop shadow
            [viewForPreview.layer setShadowColor:[UIColor blackColor].CGColor];
            [viewForPreview.layer setShadowOpacity:0.8];
            [viewForPreview.layer setShadowRadius:3.0];
            [viewForPreview.layer setShadowOffset:CGSizeMake(2.0, 2.0)];
    
            
            [self addSubview:viewForPreview];
            
            NSDate* currentDate = [NSDate date];
            NSDateFormatter *dateFormat = [[NSDateFormatter alloc]init];
            [dateFormat setDateFormat:@"MM/dd/yyyy"];
            NSString *dateString = [dateFormat stringFromDate:currentDate];
            
            UILabel *lblDate = [[UILabel alloc] initWithFrame:CGRectMake(20, 520, 180, 50)];
            lblDate.textAlignment = UITextAlignmentCenter;
            lblDate.backgroundColor = [UIColor clearColor];
            lblDate.text = dateString;
            lblDate.textColor = [UIColor blueColor];
            lblDate.font = [UIFont fontWithName:APP_FONT size:30.0f];
            [viewForPreview addSubview:lblDate];
            
            NSString *strFile = [imgName lastPathComponent];
            UIImage *thumb = [[TigglyStampUtils sharedInstance] getThumbnailImageOfMovieFile:strFile];
            imageView = [[UIImageView alloc] initWithImage:thumb];
            imageView.frame = CGRectMake(30, 30,650,488);
            [viewForPreview addSubview:imageView];
            
            btnPlay = [UIButton buttonWithType:UIButtonTypeCustom];
            [btnPlay setBackgroundImage:[UIImage imageNamed:@"play_btn.png"] forState:UIControlStateNormal];
            [btnPlay setBackgroundImage:[UIImage imageNamed:@"play_btn.png"] forState:UIControlStateSelected];
            [btnPlay addTarget:self action:@selector(btnPlayClicked)forControlEvents:UIControlEventTouchUpInside];
            btnPlay.frame = CGRectMake(imageView.frame.size.width/2 - 25, imageView.frame.size.height/2 - 25,100, 100);
            btnPlay.center = imageView.center;
            btnPlay.hidden = NO;
            [viewForPreview addSubview:btnPlay];
            
            
            UIImage *img = [self changeImageColor:[UIImage imageNamed:@"color_splash.png"] withColor:[colorArray objectAtIndex:colorCnt]];
            img = [self changeImageColor:img withColor:[colorArray objectAtIndex:colorCnt]];
            
            btnColorSplash = [UIButton buttonWithType:UIButtonTypeCustom];
            [btnColorSplash setBackgroundImage:img forState:UIControlStateNormal];
            [btnColorSplash addTarget:self action:@selector(actionChangeColor)forControlEvents:UIControlEventTouchUpInside];
            btnColorSplash.frame = CGRectMake(0, 0, 100, 100);
            btnColorSplash.center = CGPointMake(950, 680);
            [self addSubview:btnColorSplash];
            btnColorSplash.alpha = 0.0;
            
            viewForSign = [[TDSignatureView alloc] initWithFrame:CGRectMake(200, 530, 480, 100)];
            viewForSign.delegate = self;
            [viewForPreview addSubview:viewForSign];
            [self bringSubviewToFront:viewForSign];
            
            colorCnt = 0;
            
            //red, yellow, blue, green, orange, purple
            colorArray = [[NSMutableArray alloc] initWithObjects:
                          [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:1.0],
                          [UIColor colorWithRed:1.0  green:176.0/255.0  blue:22.0/255.0 alpha:1.0],
                          [UIColor colorWithRed:96.0/255.0  green:170.0/255.0  blue:0.0 alpha:1.0],
                          [UIColor colorWithRed:131.0/255.0  green:48.0/255.0  blue:185.0/255.0 alpha:1.0],
                          [UIColor colorWithRed:208.0/255.0  green:48.0/255.0  blue:31.0/255.0 alpha:1.0],
                          [UIColor colorWithRed:240.0/255.0  green:221.0/255.0  blue:11.0/255.0 alpha:1.0],
                          [UIColor colorWithRed:255.0 green:255.0 blue:255.0 alpha:1.0],
                          nil];

            
        }else{
            
            viewForPreview = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 740, 650)];
            viewForPreview.backgroundColor = [UIColor clearColor];
            viewForPreview.center = CGPointMake(512, 1000);
            viewForPreview.transform = CGAffineTransformMakeRotation(-5 * M_PI / 180);
            [self addSubview:viewForPreview];
            [self bringSubviewToFront:viewForPreview];

            UIImageView *imgViewBorder = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 740, 650)];
            imgViewBorder.image = [UIImage imageNamed:@"photo_bg.png"];
            imgViewBorder.layer.cornerRadius = 20.0f;
            [viewForPreview addSubview:imgViewBorder];
            
            NSDate* currentDate = [NSDate date];
            NSDateFormatter *dateFormat = [[NSDateFormatter alloc]init];
            [dateFormat setDateFormat:@"MM/dd/yyyy"];
            NSString *dateString = [dateFormat stringFromDate:currentDate];            
            UILabel *lblDate = [[UILabel alloc] initWithFrame:CGRectMake(40, 500, 180, 50)];
            lblDate.textAlignment = UITextAlignmentLeft;
            lblDate.backgroundColor = [UIColor clearColor];
            lblDate.text = dateString;
            lblDate.textColor = [UIColor blueColor];
            lblDate.font = [UIFont fontWithName:APP_FONT size:30.0f];
            [imgViewBorder addSubview:lblDate];
            
            NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)objectAtIndex:0];
            UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfFile:[path stringByAppendingPathComponent:imgName]]];
            UIGraphicsBeginImageContext(CGSizeMake(800, 600));
            [image drawInRect:CGRectMake(0, 0, 800, 600)];
            UIImage *thumbnailImage = UIGraphicsGetImageFromCurrentImageContext();
            UIGraphicsEndImageContext();
            
            imageView = [[UIImageView alloc] initWithImage:thumbnailImage];
            imageView.frame = CGRectMake(40,40, 650, 465);
            [viewForPreview addSubview:imageView];
            
            
            [UIView animateWithDuration:1.2
                             animations:^{
                                 viewForPreview.center = CGPointMake(503, 420);
                                 
                             }
             completion:^(BOOL finished){
                
             }];
            
            UIImage *img = [self changeImageColor:[UIImage imageNamed:@"color_splash.png"] withColor:[colorArray objectAtIndex:colorCnt]];
            img = [self changeImageColor:img withColor:[colorArray objectAtIndex:colorCnt]];
            
            btnColorSplash = [UIButton buttonWithType:UIButtonTypeCustom];
            [btnColorSplash setBackgroundImage:img forState:UIControlStateNormal];
            [btnColorSplash addTarget:self action:@selector(actionChangeColor)forControlEvents:UIControlEventTouchUpInside];
            btnColorSplash.frame = CGRectMake(0, 0, 100, 100);
            btnColorSplash.center = BTN_COLOR_SPLASH_CENTER;
            [self addSubview:btnColorSplash];
            btnColorSplash.alpha = 0.0;
            
            viewForSign = [[TDSignatureView alloc] initWithFrame:CGRectMake(200, 515, 490, 100)];
            viewForSign.delegate = self;
            [viewForPreview addSubview:viewForSign];
            [self bringSubviewToFront:viewForSign];
            
            colorCnt = 0;
            
            //red, yellow, blue, green, orange, purple
            colorArray = [[NSMutableArray alloc] initWithObjects:
                          [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:1.0],
                          [UIColor colorWithRed:1.0  green:176.0/255.0  blue:22.0/255.0 alpha:1.0],
                          [UIColor colorWithRed:96.0/255.0  green:170.0/255.0  blue:0.0 alpha:1.0],
                          [UIColor colorWithRed:131.0/255.0  green:48.0/255.0  blue:185.0/255.0 alpha:1.0],
                          [UIColor colorWithRed:208.0/255.0  green:48.0/255.0  blue:31.0/255.0 alpha:1.0],
                          [UIColor colorWithRed:240.0/255.0  green:221.0/255.0  blue:11.0/255.0 alpha:1.0],
                          [UIColor colorWithRed:255.0 green:255.0 blue:255.0 alpha:1.0],
                          nil];
 

        }
        
        //adding home button and next scene button
        btnNext = [UIButton buttonWithType:UIButtonTypeCustom];
        [btnNext setBackgroundImage:[UIImage imageNamed:@"arrow_right_3.png"] forState:UIControlStateNormal];
        [btnNext setBackgroundImage:[UIImage imageNamed:@"arrow_right_3.png"] forState:UIControlStateSelected];
        [btnNext addTarget:self action:@selector(btnNextClicked)forControlEvents:UIControlEventTouchUpInside];
        btnNext.frame = CGRectMake(925, 10, 80, 80);
        [self addSubview:btnNext];
        
        btnHome = [UIButton buttonWithType:UIButtonTypeCustom];
        [btnHome setBackgroundImage:[UIImage imageNamed:@"home_icon_1.png"] forState:UIControlStateNormal];
        [btnHome setBackgroundImage:[UIImage imageNamed:@"home_icon_1.png"] forState:UIControlStateSelected];
        [btnHome addTarget:self action:@selector(btnHomeClicked)forControlEvents:UIControlEventTouchUpInside];
        btnHome.frame = CGRectMake(35, 10, 80, 80);
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

#pragma mark -
#pragma mark =======================================
#pragma mark Helpers
#pragma mark =======================================

-(UIImage *) changeImageColor:(UIImage *) image withColor:(UIColor *) color {
    DebugLog(@"");
    
    CGRect rect = CGRectMake(0, 0, image.size.width, image.size.height);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextClipToMask(context, rect, image.CGImage);
    CGContextSetFillColorWithColor(context,color.CGColor);
    CGContextFillRect(context, rect);
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    UIImage *flippedImage = [UIImage imageWithCGImage:img.CGImage
                                                scale:1.0 orientation: UIImageOrientationUp];
    
    return flippedImage;
}

-(void)actionChangeColor{
    DebugLog(@"");
    
    colorCnt++;
    if(colorCnt > 6){
        colorCnt = 0;
        
        //this will anything written on signboard
        [viewForSign.myPath removeAllPoints];
    }
    
    UIImage *img = [self changeImageColor:[UIImage imageNamed:@"color_splash.png"] withColor:[colorArray objectAtIndex:colorCnt]];
    img = [self changeImageColor:img withColor:[colorArray objectAtIndex:colorCnt]];
    [btnColorSplash setBackgroundImage:img forState:UIControlStateNormal];
    
    viewForSign.lineColor = [colorArray objectAtIndex:colorCnt];
    [viewForSign setNeedsDisplay];
    
}

#pragma mark -
#pragma mark =======================================
#pragma mark Image Capturing
#pragma mark =======================================

-(void)saveImageWithBorderToGallary:(BOOL)toPhotoGallary{
    DebugLog(@"");

    [btnPlay removeFromSuperview];
    
    viewForPreview.transform = CGAffineTransformMakeRotation(0);
    
    UIGraphicsBeginImageContext(viewForPreview.frame.size);
    [[UIColor clearColor] set];
    UIRectFill(CGRectMake(0.0, 0.0,viewForPreview.frame.size.width, viewForPreview.frame.size.height));
    [viewForPreview.layer.presentationLayer renderInContext:UIGraphicsGetCurrentContext()];
    
    UIImage *imgToSave = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    
        if(toPhotoGallary){
            NSData *imageData = UIImagePNGRepresentation(imgToSave);
            UIImage *img = [UIImage imageWithData:imageData];
            UIImageWriteToSavedPhotosAlbum(img, nil, nil, nil);
            
        }else{
            NSString *imgName1;
            NSString *iName = @"";
            if([[imageName pathExtension] isEqualToString:@"mov"]){
                iName =[[imageName lastPathComponent ]stringByDeletingPathExtension];
                DebugLog(@"iName: %@",iName);
                imgName1 = [NSString stringWithFormat:@"%@_%@.png",iName, STR_WITH_MOVIE_BORDER];
                DebugLog(@"Image Name : %@",imgName1);
            }else{
                iName  =[imageName stringByDeletingPathExtension];
                DebugLog(@"iName: %@",iName);
                imgName1 = [NSString stringWithFormat:@"%@_%@.png",iName, STR_WITH_BORDER];
                DebugLog(@"Image Name : %@",imgName1);
            }
            
            NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
            NSString *documentsDirectory = [paths objectAtIndex:0];
            NSString *savedImagePath = [documentsDirectory stringByAppendingPathComponent:imgName1];
            DebugLog(@"Image Path: %@",savedImagePath);
            
            NSData *imageData = UIImagePNGRepresentation(imgToSave);
            
            BOOL isSuccess =  [imageData writeToFile:savedImagePath atomically:YES];
            if(isSuccess)
                DebugLog(@"Imaged saved successfully");
            else
                DebugLog(@"Failed to save the image");
        }
    
    viewForPreview.transform = CGAffineTransformMakeRotation(-5 * M_PI / 180);
    
}


#pragma mark - ============================
#pragma mark - Action Handling
#pragma mark - ============================

-(void)btnNextClicked{
    DebugLog(@"");
    //call delegate
    
      [self saveImageWithBorderToGallary:NO];   
    
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
    

   [self saveImageWithBorderToGallary:NO];    
   
    
    [delegate onHomeButtonClicked:self];
}

-(void)btnSendClicked{
    DebugLog(@"");
    
    gestureView = [[GestureConfirmationView alloc] initWithFrame:CGRectMake(0, 0, 1024, 768)];
    gestureView.delegate = self;
    [self addSubview:gestureView];
    [self bringSubviewToFront:gestureView];
    
}

-(void)btnPlayClicked{
    DebugLog(@"");
    //call delegate
    [delegate onPlayButtonClicked:self];
}


#pragma mark -
#pragma mark =======================================
#pragma mark Gesture View Protocol
#pragma mark =======================================


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
        
        [self saveImageWithBorderToGallary:YES];

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


#pragma mark-
#pragma mark======================
#pragma mark Touch Responders
#pragma mark======================

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    DebugLog(@"");
    
    if(gestureView != nil){        
        double delayInSeconds = 0.3;
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
            [gestureView removeFromSuperview];
        });
    }

}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
    DebugLog(@"");
    

}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    DebugLog(@"");
    
    
}

#pragma mark -
#pragma mark =======================================
#pragma mark Signature View Protocol
#pragma mark =======================================

-(void) signatureViewOnTouchesBegan:(TDSignatureView *)signView {
    DebugLog(@"");
    
    [UIView animateWithDuration:0.5
                     animations:^(void){
                         btnColorSplash.alpha = 1.0;
                     } completion:^(BOOL finished){
                     }];

}

-(void) signatureViewOnTouchesMoved:(TDSignatureView *)signView {
    DebugLog(@"");

    [UIView animateWithDuration:0.5
                     animations:^(void){
                         btnColorSplash.alpha = 1.0;
                     } completion:^(BOOL finished){
                     }];

}

-(void) signatureViewOnTouchesEnded:(TDSignatureView *)signView {
    DebugLog(@"");
    
}


@end
