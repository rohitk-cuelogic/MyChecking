//
//  GestureConfirmationView.m
//  TigglyStamp
//
//  Created by Sachin Patil on 24/09/13.
//  Copyright (c) 2013 cuelogic. All rights reserved.
//

#import "GestureConfirmationView.h"
#import "TConstant.h"
#import "TigglyStampUtils.h"

@implementation GestureConfirmationView

@synthesize delegate;

- (id)initWithFrame:(CGRect)frame {
    DebugLog(@"");
    self = [super initWithFrame:frame];
    if (self) {
      
        self.backgroundColor = [UIColor clearColor];
        self.userInteractionEnabled = YES;

        
        UIImageView *bkgImage = [[UIImageView alloc] initWithFrame:frame];
        bkgImage.image = [UIImage imageNamed:@"parent_gesture_black_bg.png"];
        [self addSubview:bkgImage];
        bkgImage.userInteractionEnabled  =YES;
        
        UIView *confirmationView = [[UIImageView alloc] initWithFrame:CGRectMake(230, 240, 570, 285)];
        confirmationView.backgroundColor = [UIColor colorWithRed:98.0f/255.0f green:173.0f/255.0f blue:1.0f/255.0f alpha:1.0f];
        [self addSubview:confirmationView];
        confirmationView.userInteractionEnabled  =YES;
        confirmationView.layer.cornerRadius = 20.0f;
        confirmationView.layer.masksToBounds = YES;
        
        UIButton *btnClose = [UIButton buttonWithType:UIButtonTypeCustom];
        [btnClose setBackgroundImage:[UIImage imageNamed:@"close_btn.png"] forState:UIControlStateNormal];
        [btnClose setBackgroundImage:[UIImage imageNamed:@"close_btn.png"] forState:UIControlStateSelected];
        [btnClose addTarget:self action:@selector(actionClose)forControlEvents:UIControlEventTouchUpInside];
        btnClose.frame = CGRectMake(500, 10, 70, 70);
        [confirmationView addSubview:btnClose];
        
        
        txtView = [[UITextView alloc] initWithFrame:CGRectMake(90, 80, 415, 160)];
        txtView.textAlignment = UITextAlignmentCenter;
        txtView.font = [UIFont fontWithName:APP_FONT_BOLD size:35.0f];
        txtView.backgroundColor =[UIColor clearColor];
        [confirmationView addSubview:txtView];
        txtView.editable = NO;
        txtView.scrollEnabled = NO;
        
        swipeTextArray = [[NSArray alloc] initWithObjects:@"RIGHT\nwith 2", @"RIGHT\nwith 2", @"LEFT\nwith 2", @"LEFT\nwith 2", @"UP\nwith 2", @"UP\nwith 2", @"DOWN\nwith 2", @"DOWN\nwith 2", nil];
        swipeGesture = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swippedforConfirmation)];
        [swipeGesture setNumberOfTouchesRequired:2];
        [self addGestureRecognizer:swipeGesture];
        
        [self showTextView];
    }
    return self;
}

-(void) showTextView{
       DebugLog(@"");
        int swipeTxtCnt = arc4random()%7;

        [txtView setText:[NSString stringWithFormat:@"To continue,\nswipe %@ fingers.", [swipeTextArray objectAtIndex:swipeTxtCnt]]];
        txtView.font = [UIFont fontWithName:APP_FONT_BOLD size:35.0f];
        txtView.textColor = [UIColor whiteColor];

        switch (swipeTxtCnt) {
            case 0:
                [swipeGesture setDirection: UISwipeGestureRecognizerDirectionRight];
                [swipeGesture setNumberOfTouchesRequired: 2];
                break;
            case 1:
                [swipeGesture setDirection: UISwipeGestureRecognizerDirectionRight];
                [swipeGesture setNumberOfTouchesRequired: 2];
                break;
            case 2:
                [swipeGesture setDirection: UISwipeGestureRecognizerDirectionLeft];
                [swipeGesture setNumberOfTouchesRequired: 2];
                break;
            case 3:
                [swipeGesture setDirection: UISwipeGestureRecognizerDirectionLeft];
                [swipeGesture setNumberOfTouchesRequired: 2];
                break;
            case 4:
                [swipeGesture setDirection: UISwipeGestureRecognizerDirectionUp];
                [swipeGesture setNumberOfTouchesRequired: 2];
                break;
            case 5:
                [swipeGesture setDirection: UISwipeGestureRecognizerDirectionUp];
                [swipeGesture setNumberOfTouchesRequired: 2];
                break;
            case 6:
                [swipeGesture setDirection: UISwipeGestureRecognizerDirectionDown];
                [swipeGesture setNumberOfTouchesRequired: 2];
                break;
            case 7:
                [swipeGesture setDirection: UISwipeGestureRecognizerDirectionDown];
                [swipeGesture setNumberOfTouchesRequired: 2];
                break;
            default:
                break;
        }
}

-(void)swippedforConfirmation{
    DebugLog(@"");

    [self.delegate gestureViewOnGestureConfirmed:self];
    [self removeFromSuperview];
    [self removeGestureRecognizer:swipeGesture];
}

-(void) actionClose{
    DebugLog(@"");
    
    [self removeGestureRecognizer:swipeGesture];
    [self removeFromSuperview];
}

@end
