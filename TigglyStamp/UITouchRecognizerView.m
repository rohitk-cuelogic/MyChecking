//
//  UITouchRecognizerView.m
//  ivyApplication
//
//  Created by Philip Hayes on 8/7/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "UITouchRecognizerView.h"
#import "AppDelegate.h"

@implementation UITouchRecognizerView
@synthesize shapeRequest, delegate, renderShapesToSelf, captureTouchesBegin, captureTouchesEnded, captureTouchesMoved, stampShapes, fadeShapes, mode, writeMode;
NSMutableDictionary *calculationHash;
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        DebugLog(@"");
        // Initialization code
        mode = vVerificationMode6Point;
        
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/
-(BOOL)calculateShape:(UITouchGroup *)group{
    DebugLog(@"");
    if ([mode isEqualToString:vVerificationMode3Point]) {
    } else if ([mode isEqualToString:vVerificationMode6Point]){
        calculateShape(group, self);
    } 
      
    return false;
}

BOOL calculateShape(UITouchGroup *group, UITouchRecognizerView *view){
    DebugLog(@"");

    if (calculationHash == nil) {
        calculationHash = [[NSMutableDictionary alloc]init];
    }
    NSMutableSet * processedTouches = [[NSMutableSet alloc]init];
    
    if ([view.mode isEqualToString:vVerificationMode6Point]) {
        UITouch *nextTouch = [group.groupCache objectAtIndex:0];
        for (int i = 0; i < 6; i++) {
            UITouch * t = [group closestTouchToPoint:[nextTouch locationInView:view] inView:view notInCollection:processedTouches];
            [calculationHash setObject:t forKey:[NSString stringWithFormat:@"%i", i]];
            [processedTouches addObject:nextTouch];
            nextTouch = t;
        }
        

    }
    
        
    return false;
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    DebugLog(@"");
    DebugLog(@"method name: %@", NSStringFromSelector(_cmd));
    if (!self.captureTouchesBegin || ![mode isEqualToString:vVerificationMode3Point]) {
        return;
    }
    
    
    
    for (UITouch *touch  in touches) {
        
        
        for (UITouchGroup *group in touchGroups) {
            if ([group.groupCache count] < 6 && ![UITouchGroup touchBelongsToGroup:touch]) {
                //DebugLog(@"TouchGroup %i Count %i",group.groupTag, [group.groupCache count]);
                [group addTouch:touch];
            }
        }
    }
    
    for (UITouchGroup *group in touchGroups) {
        touchCache = group.groupCache;
        [self calculateShape:group];
    }
    
    
}
-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
    DebugLog(@"");
    if (!self.captureTouchesMoved || ![mode isEqualToString:vVerificationMode3Point]) {
        return;
    }
    for (UITouchGroup *group in touchGroups) {
        touchCache = group.groupCache;
        //DebugLog(@"TouchGroup %i Count %i",group.groupTag, [group.groupCache count]);
        [self calculateShape:group];
    }
}
-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    DebugLog(@"");
    if (!self.captureTouchesEnded || [mode isEqualToString:vVerificationMode3Point]) {
        self.stampShapes = YES;
        return;
    } else {//self.stampShapes = NO; }
    }
    
    DebugLog(@"method name: %@", NSStringFromSelector(_cmd));
    
    for (UITouch *touch  in touches) {
        for (UITouchGroup *group in touchGroups) {
            if ([group.groupCache containsObject:touch]) {
                [group.groupCache removeObject:touch];
                if (group.groupCache.count <=1) {
                    if (group.groupShape && !stampShapes) {
                        
                        [group.groupShape removeFromSuperlayer];
                        
                        group.groupShape = nil;
                    }
                }
            }
        }
    }
    if ([touches count]== 0) {
        for (UITouchGroup *group in touchGroups) {
            [group.groupCache removeAllObjects];
            
        }
    }
    
    if (writeMode) {
        shapeDicionary = [recordedShapes mutableCopy];
        NSString *documentsDirectory = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
        NSString *filePath = [documentsDirectory stringByAppendingPathComponent:@"shapesdata.plist"];
        [shapeDicionary writeToFile:filePath atomically:YES];
        
    }
}
-(void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event{
    DebugLog(@"");
    //DebugLog(@"method name: %@", NSStringFromSelector(_cmd));
    
    for (UITouch *touch  in touches) {
        for (UITouchGroup *group in touchGroups) {
            if ([group.groupCache containsObject:touch]) {
                [group.groupCache removeObject:touch];
                if (group.groupCache.count <=1) {
                    if (group.groupShape && !stampShapes) {
                        
                        [group.groupShape removeFromSuperlayer];
                        
                        group.groupShape = nil;
                    }
                }
            }
        }
    }
    if ([touches count]== 0) {
        for (UITouchGroup *group in touchGroups) {
            [group.groupCache removeAllObjects];
            
        }
    }
}
@end
