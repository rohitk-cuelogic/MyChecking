//
//  ShapeDetectionLogic.m
//  TigglySafari
//
//  Created by Ninad Shah on 08/11/13.
//  Copyright (c) 2013. All rights reserved.
//

#import "ShapeDetectionLogic.h"
#import "TConstant.h"
#include <sys/types.h>
#include <sys/sysctl.h>
#import "TigglyStampUtils.h"


#define TRIANGLE_SHAPE_RANGE_MIN 152
#define TRIANGLE_SHAPE_RANGE_MAX 173
#define CIRCLE_SHAPE_RANGE_MIN 182
#define CIRCLE_SHAPE_RANGE_MAX 205
#define STAR_SHAPE_RANGE_MIN 217
#define STAR_SHAPE_RANGE_MAX 244
#define CIRCLE_SHAPE_RANGE_MIN_2 245
#define CIRCLE_SHAPE_RANGE_MAX_2 278
#define SQUARE_SHAPE_RANGE_MIN 325
#define SQUARE_SHAPE_RANGE_MAX 345

@implementation ShapeDetectionLogic {
    // This will store the NSString represtation of all the CGPoint touch locations
    NSMutableArray *_touchLocation;
    float _scale;
}

#pragma mark -
#pragma mark =======================================
#pragma mark Platform detection
#pragma mark =======================================

- (NSString *) platformString {
   
    size_t size;
    sysctlbyname("hw.machine", NULL, &size, NULL, 0);
    char *machine = malloc(size);
    sysctlbyname("hw.machine", machine, &size, NULL, 0);
    NSString *platform = [NSString stringWithCString:machine encoding:NSUTF8StringEncoding];
    free(machine);
    return platform;
}


#pragma mark -
#pragma mark =======================================
#pragma mark Init functions
#pragma mark =======================================
- (id) init {
    if ([super init]) {
        _touchLocation = [[NSMutableArray alloc] initWithCapacity:1];
        _scale = 1.0;
        
        NSMutableArray * arr = [[TigglyStampUtils sharedInstance] getiPadMiniDeviceVersion];
        if(arr != nil){
            for(NSString *str in arr){
                if([[self platformString] isEqualToString:str]){
                    _scale = 0.8;
                }
            }
        }

    }
    
    return self;
}

#pragma mark -
#pragma mark =======================================
#pragma mark Touch location functions
#pragma mark =======================================
- (void) addTouchLocation:(CGPoint)touchLoction {
    DebugLog(@"");
    // If we already have 3 touch points then ignore the additional touch points
    if ([_touchLocation count] >= 3)
        return;
    
    NSString *strTouchLocation = NSStringFromCGPoint(touchLoction);

    // Ensure that this touch points is not already in our array
    // If yes, then ignore that touch point
    for (NSString *existingTouchLocation in _touchLocation) {
        if ([existingTouchLocation isEqualToString:strTouchLocation]) {
            // Don't add this location as it is already in our array
            DebugLog(@"We found a location which is already existing in touch array, so ignoring");
            return;
        }
    }
    DebugLog(@"Adding touch location: %@", strTouchLocation);
    // Add the touch location
    [_touchLocation addObject:strTouchLocation];
}

- (void) clearAllTouchPoints {
    DebugLog(@"");
    [_touchLocation removeAllObjects];
}

- (NSArray *) touchLocations {
    NSArray *tempLocation = [_touchLocation copy];
    return tempLocation;
}

#pragma mark -
#pragma mark =======================================
#pragma mark Identifying shape
#pragma mark =======================================

- (BOOL) isShapeTriangle: (NSInteger) distance {
    if (distance >= TRIANGLE_SHAPE_RANGE_MIN && distance <= TRIANGLE_SHAPE_RANGE_MAX) {
        return YES;
    }
    
    return NO;
}

- (BOOL) isShapeSquare: (NSInteger) distance {
    if (distance >= SQUARE_SHAPE_RANGE_MIN && distance <= SQUARE_SHAPE_RANGE_MAX) {
        return YES;
    }
    return NO;
}

- (BOOL) isShapeCircle: (NSInteger) distance {
    DebugLog(@"");
    if (distance >= CIRCLE_SHAPE_RANGE_MIN && distance <= CIRCLE_SHAPE_RANGE_MAX) {
        return YES;
    }
    
    if (distance >= CIRCLE_SHAPE_RANGE_MIN_2 && distance <= CIRCLE_SHAPE_RANGE_MAX_2) {
        return YES;
    }
    
    return NO;
}

- (BOOL) isShapeStar: (NSInteger) distance {
    if (distance >= STAR_SHAPE_RANGE_MIN && distance <= STAR_SHAPE_RANGE_MAX) {
        return YES;
    }
    return NO;
}

- (ShapeType) detectShape {
    DebugLog(@"");
    // Skip the logic if there is only one or less than one touch point
    if ([_touchLocation count] <= 1)
        return kShapeTypeNone;
    
    // Main logic for shape detection
    
    // First calcuate all the distances between the touch points
    NSMutableArray *distanceArray = [[NSMutableArray alloc] initWithCapacity:1];
    [self calcuateDistances:distanceArray];
    
    NSUInteger triangleCount = 0;
    NSUInteger circleCount = 0;
    NSUInteger starCount = 0;
    NSUInteger squareCount = 0;
    
    for (NSNumber *distance in distanceArray) {
        int dis = [distance intValue];
        DebugLog(@"checking Distance: %d", dis);
        
        if ([self isShapeCircle:dis]) {
            circleCount++;
        } else if ([self isShapeSquare:dis]) {
            squareCount++;
        } else if ([self isShapeStar:dis]) {
            starCount++;
        } else if ([self isShapeTriangle:dis]) {
            triangleCount++;
        }
    }
    
    DebugLog(@"FINAL tri :%d cir :%d star :%d squ :%d ",triangleCount,circleCount,starCount,squareCount);

    // Now we have all the counts lets figure out which shape is it really
    NSUInteger minReqShape = 1;
    if (triangleCount >= minReqShape && triangleCount >= circleCount && triangleCount >= starCount && triangleCount >= squareCount) {
        return kShapeTypeTriangle;
    } else if (circleCount >= minReqShape && circleCount >= triangleCount && circleCount >= starCount && circleCount >= squareCount) {
        return kShapeTypeCircle;
    } else if (starCount >= minReqShape && starCount >= triangleCount && starCount >= circleCount && starCount >= squareCount) {
        return kShapeTypeStar;
    } else if (squareCount >= minReqShape && squareCount >= triangleCount && squareCount >= circleCount && squareCount >= starCount) {
        return kShapeTypeSquare;
    }
        
    return kShapeTypeNone;
}

#pragma mark -
#pragma mark =======================================
#pragma mark Calculating distance
#pragma mark =======================================

- (void) calcuateDistances: (NSMutableArray *) distanceArray {
    DebugLog(@"");
    for(int i = 0;i<[_touchLocation count];i++) {
        NSString *strTouchLocation = [_touchLocation objectAtIndex:i];
        CGPoint touchLocation = CGPointFromString(strTouchLocation);
        
        for(int j = i+1;j<[_touchLocation count];j++) {
            NSString *strCompareLocation = _touchLocation[j];
            CGPoint compareLocation = CGPointFromString(strCompareLocation);
            
            // Ninad: I have removed scale from the distance caclulation
            // Not sure if the same is getting used anywhere
            int distance = (sqrt(pow((compareLocation.y - touchLocation.y),2) + pow((compareLocation.x - touchLocation.x), 2)) * _scale);
            
            NSNumber *numDistance = @(distance);
            [distanceArray addObject:numDistance];
            
            DebugLog(@"touchLocation: %@, compareLocation: %@", NSStringFromCGPoint(touchLocation), NSStringFromCGPoint(compareLocation));
            DebugLog(@"Distance: %d", distance);
        }
    }
}


@end