//
//  CALayer+CALayer_Fade.m
//  TouchVerification
//
//  Created by Philip Hayes on 4/2/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CALayer+CALayer_Fade.h"

@implementation CALayer (CALayer_Fade)
-(void)fadeOutAfterTime:(double)time{
    DebugLog(@"");
    
    [CATransaction setAnimationDuration:2];
    double delayInSeconds = time;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        self.opacity = 0;
        double delayInSeconds = 2.0;
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
            [self removeFromSuperlayer];
        });
    });
    
}
@end
