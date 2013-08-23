//
//  MovingView.m
//  TigglyStamp
//
//  Created by Sachin Patil on 22/08/13.
//  Copyright (c) 2013 cuelogic. All rights reserved.
//

#import "MovingView.h"
#import "TConstant.h"

@implementation MovingView

- (id)initWithFrame:(CGRect)frame withImageName:(NSString *) imgName {
    self = [super initWithFrame:frame];
    if (self) {
        self.alpha = 0.5;
        UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        imgView.image= [UIImage imageNamed:imgName];
        [self addSubview:imgView];
        
        [self performSelector:@selector(addRippleEffect) withObject:nil afterDelay:0.5];

    }
    return self;
}

-(void) addRippleEffect {
    DebugLog(@"");
    CATransition *animation=[CATransition animation];
    [animation setDuration:2.0];
    [animation setType:@"rippleEffect"];
    animation.delegate = self;
    [animation setFillMode:kCAFillModeBoth];
    animation.endProgress=0.8;
    animation.repeatCount = HUGE_VAL;
    [animation setRemovedOnCompletion:NO];
    animation.autoreverses = YES;
    [animation setTimingFunction: [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
    [self.layer addAnimation:animation forKey:nil];
}

@end
