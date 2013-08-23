//
//  MovingView.m
//  TigglyStamp
//
//  Created by Sachin Patil on 22/08/13.
//  Copyright (c) 2013 cuelogic. All rights reserved.
//

#import "MovingView.h"

@implementation MovingView

- (id)initWithFrame:(CGRect)frame withImageName:(NSString *) imgName {
    self = [super initWithFrame:frame];
    if (self) {
        self.alpha = 0.5;
        UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        imgView.image= [UIImage imageNamed:imgName];
        [self addSubview:imgView];

        
        [UIView beginAnimations:@"rippleEffect" context:NULL];
        [UIView setAnimationDuration:1.0];
        [UIView setAnimationRepeatCount:HUGE_VAL];
        [UIView setAnimationTransition:110 forView:self cache:NO];
        [UIView commitAnimations];
        
    }
    return self;
}


@end
