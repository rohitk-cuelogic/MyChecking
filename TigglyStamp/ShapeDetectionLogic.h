//
//  ShapeDetectionLogic.h
//  TigglySafari
//
//  Created by Ninad Shah on 08/11/13.
//  Copyright (c) 2013. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TConstant.h"

@interface ShapeDetectionLogic : NSObject

// Call this function to add multiple touch locations
- (void) addTouchLocation: (CGPoint) touchLoction;

// Call this function to clear all the touch points
- (void) clearAllTouchPoints;

// Get all the touch locations, this is an array of NSString's
- (NSArray *) touchLocations;

// Once you have added all the touch location call this function to
// detect the shape
- (ShapeType) detectShape;


@end
