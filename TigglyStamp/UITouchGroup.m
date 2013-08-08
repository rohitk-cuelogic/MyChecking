//
//  UITouchGroup.m
//  TouchVerification
//
//  Created by Philip Hayes on 3/13/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "UITouchGroup.h"

@implementation UITouchGroup
@synthesize groupCache, groupTag, groupArea, groupShape;
- (id)init {
    self = [super init];
    if (self) {
        //DebugLog(@"");
        if (!touchGroupSet) {
            touchGroupSet = [[NSMutableSet alloc]init];
        }
        groupCache = [[NSMutableArray alloc]init];
        groupTag = [touchGroupSet count];
        [touchGroupSet addObject:self];
    }
    return self;
}
-(void)addTouch:(UITouch*)touch{
    DebugLog(@"");
    [groupCache addObject:touch];
    DebugLog(@"groupCache count :%d",[groupCache count]);

    
}
-(BOOL)removeTouch:(UITouch*)touch{
    DebugLog(@"");
    if ([self containsTouch:touch]) {
        [groupCache removeObject:touch];
        return true;
    }
    return false;
}
-(int)count{
    DebugLog(@"");
    return [groupCache count];
}
-(BOOL)containsTouch:(UITouch*)touch{
    DebugLog(@"");
    if ([groupCache containsObject:touch]) {
        return YES;
    }
    return NO;
}
+(UITouchGroup*)getGroupWithTouchInArea:(CGPoint*)point{
    DebugLog(@"");
    
    return nil;
}
+(UITouchGroup*)getGroupByTag:(int)tag{return nil;}

+(BOOL)touchBelongsToGroup:(UITouch *)touch{
    DebugLog(@"");
    BOOL success = NO;
    
    for (UITouchGroup *group in touchGroupSet) {
        if ([group.groupCache containsObject:touch]) {
            success = YES;
        }
    }
    DebugLog(@"touchBelongsToGroup :%d",success);
    return success;
}
-(UITouch*)closestTouchToPoint:(CGPoint)point inView:(UIView*)view{
    DebugLog(@"");
    UITouch * closestTouch;
    float smallestX = 9999;
    float smallestY = 9999;
    for (UITouch * t in self.groupCache) {
        CGPoint currentPoint = [t locationInView:view];
        float x = fabsf(point.x - currentPoint.x);
        float y = fabsf(point.y - currentPoint.y);
        if (x < smallestX && y < smallestY) {
            closestTouch = t;
            smallestX = x;
            smallestY = y;
        }
    }
    
    return closestTouch;
}
-(UITouch*)closestTouchToPoint:(CGPoint)point inView:(UIView *)view notInCollection:(NSSet*)set{
    DebugLog(@"");
    UITouch * closestTouch;
    float smallestX = 9999;
    float smallestY = 9999;
    for (UITouch * t in self.groupCache) {
        CGPoint currentPoint = [t locationInView:view];
        float x = fabsf(point.x - currentPoint.x);
        float y = fabsf(point.y - currentPoint.y);
        if (x < smallestX && y < smallestY && ![set containsObject:t]) {
            closestTouch = t;
            smallestX = x;
            smallestY = y;
        }
    }
    
    return closestTouch;
}
-(UITouch*)closetTouchToTouch:(UITouch*)touch inView:(UIView*)view{
    DebugLog(@"");
    return [self closestTouchToPoint:[touch locationInView:view]  inView:view];
}
@end
