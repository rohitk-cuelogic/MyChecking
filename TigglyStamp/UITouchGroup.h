//
//  UITouchGroup.h
//  TouchVerification
//
//  Created by Philip Hayes on 3/13/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <QuartzCore/QuartzCore.h>
#import "TConstant.h"

static NSMutableSet *touchGroupSet; // this is static variable and store UITouchGroup objects
@interface UITouchGroup : NSObject
@property(nonatomic, strong)NSMutableArray *groupCache;
@property(nonatomic, unsafe_unretained)int groupTag;
@property(nonatomic, unsafe_unretained)CGRect groupArea;
@property(nonatomic, strong)CAShapeLayer *groupShape;
-(void)addTouch:(UITouch*)touch;
-(BOOL)removeTouch:(UITouch*)touch;
-(int)count;
+(UITouchGroup*)getGroupWithTouchInArea:(CGPoint*)point;
+(UITouchGroup*)getGroupByTag:(int)tag;
+(BOOL)touchBelongsToGroup:(UITouch*)touch;
-(UITouch*)closestTouchToPoint:(CGPoint)point inView:(UIView *)view notInCollection:(NSSet*)set;
-(UITouch*)closetTouchToTouch:(UITouch*)touch inView:(UIView*)view;
-(UITouch*)closestTouchToPoint:(CGPoint)point inView:(UIView*)view;
@end
