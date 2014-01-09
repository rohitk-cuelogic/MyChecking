//
//  UITouchVerificationView.m
//  TouchVerification
//
//  Created by Philip Hayes on 3/3/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "UITouchVerificationView.h"
#include <sys/types.h>
#include <sys/sysctl.h>
#import "TigglyStampUtils.h"
#import "ShapeDetectionLogic.h"

@implementation UITouchVerificationView {
    ShapeDetectionLogic *_shapeDetectionLogic;
    NSTimer *detectShapeTimer;
    float isStartDetectShape;
}
@synthesize  delegate;


#pragma mark -
#pragma mark ==============================
#pragma mark Memory managment
#pragma mark ==============================

-(void) removeAllObjectsForTouchVerification {
    DebugLog(@"");
    
    _shapeDetectionLogic = NULL;
    
    if (detectShapeTimer!=NULL) {
        [detectShapeTimer invalidate];
        detectShapeTimer = NULL;
    }
    
    
    delegate = NULL;
    DebugLog(@"removeAllObjectsForTouchVerification - complete");
}

-(void)inititallyResetAllVariableToNUll {
    detectShapeTimer = NULL;
}
//=====================================================================================================================================//


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        DebugLog(@"");
        _shapeDetectionLogic = [[ShapeDetectionLogic alloc]init];
        [self inititallyResetAllVariableToNUll];
        
        // Initialization code
        [self setMultipleTouchEnabled:YES];
        
        isStartDetectShape = 0.5;
        if (detectShapeTimer!=NULL) {
            [detectShapeTimer invalidate];
            detectShapeTimer = NULL;
        }
        detectShapeTimer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(startListeningShape) userInfo:nil repeats:YES];
    }
    [self setAutoresizingMask:UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleBottomMargin];
    return self;
}
#pragma mark -
#pragma mark ==============================
#pragma mark Detection algorithm
#pragma mark ==============================

-(void) startListeningShape {
    //0.5f means ready to detect shape
    isStartDetectShape = isStartDetectShape+0.1;
    if (isStartDetectShape>=999) {
        isStartDetectShape = 0.5f;
    }
}

#pragma mark-
#pragma mark======================
#pragma mark Touches Handlers
#pragma mark======================

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    DebugLog(@"");
    if(delegate && [delegate respondsToSelector:@selector(touchVerificationViewTouchesBegan:withEvent:)]) {
        [self.delegate touchVerificationViewTouchesBegan:touches withEvent:event];
    }
    
    for (UITouch *touch  in touches) {
        [_shapeDetectionLogic addTouchLocation:[touch locationInView:self]];
    }
    if (isStartDetectShape>=0.3f) {
        ShapeType detectedShapeType = [_shapeDetectionLogic detectShape];
        DebugLog(@"detectedShapeType :%d",detectedShapeType);
        if (delegate && [delegate respondsToSelector:@selector(shapeDetected: inView: withTouchLocation:)] && detectedShapeType!=kShapeTypeNone) {
            DebugLog(@"Came in delegate");
            isStartDetectShape = 0;
            [delegate shapeDetected:detectedShapeType inView:self withTouchLocation:[_shapeDetectionLogic touchLocations]];
            
        }else{
            DebugLog(@"Didnt go in delegate");
        }
    }else  {
        DebugLog(@"Device is not ready to show shape");
    }
    
}

//======================================================================================================================//

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
    
    if(delegate && [delegate respondsToSelector:@selector(touchVerificationViewTouchesBegan:withEvent:)]) {
        [self.delegate touchVerificationViewTouchesMoved:touches withEvent:event];
    }
    
    
}



-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    
    if(delegate && [delegate respondsToSelector:@selector(touchVerificationViewTouchesEnded:withEvent:)]) {
        [self.delegate touchVerificationViewTouchesEnded:touches withEvent:event];
    }
    [_shapeDetectionLogic clearAllTouchPoints];
    
    
    
}



@end