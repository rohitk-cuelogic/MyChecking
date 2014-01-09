//
//  UITouchVerificationView.h
//  TouchVerification
//
//  Created by Philip Hayes on 3/3/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//
#define vVerificationMode3Point @"3-p"
#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "TConstant.h"


@protocol UITouchVerificationViewDelegate <NSObject>
@optional

-(void)shapeDetected:(ShapeType)shapeType inView:(id)view withTouchLocation:(NSArray *)touchLocations;
-(void)touchVerificationViewTouchesBegan:(NSSet *)touches withEvent:(UIEvent *)event;
-(void)touchVerificationViewTouchesMoved:(NSSet *)touches withEvent:(UIEvent *)event;
-(void)touchVerificationViewTouchesEnded:(NSSet *)touches withEvent:(UIEvent *)event;

@end

@interface UITouchVerificationView : UIView

@property (nonatomic, unsafe_unretained) id<UITouchVerificationViewDelegate> delegate;

#warning WHy we need this?
//@property (nonatomic, readwrite) BOOL isWithShape;



-(void) removeAllObjectsForTouchVerification;

@end
