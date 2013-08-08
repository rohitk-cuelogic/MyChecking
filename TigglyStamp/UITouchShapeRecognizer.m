//
//  UITouchShapeRecognizer.m
//  TouchVerification
//
//  Created by Philip Hayes on 3/3/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "UITouchShapeRecognizer.h"

@implementation UITouchShapeRecognizer
@synthesize shapeData, dataName, displayShape, file, label;


//=====================================================================================================================================//

#pragma mark-
#pragma mark======================
#pragma mark View Life Cycles
#pragma mark======================
- (id)init {
    self = [super init];
    if (self) {
        DebugLog(@"");
        
    }
    return self;
}
//=====================================================================================================================================//
#pragma mark-
#pragma mark======================
#pragma mark Shapes Plist
#pragma mark======================

-(id)initWithPlistfile:(NSString*)fileName{
    self = [super init];
    if (self) {
        //DebugLog(@"");
        [self loadShapDataWithFile:fileName];
        
    }
    return self;
}
//=====================================================================================================================================//
-(void)loadShapDataWithFile:(NSString*)fileName{
    //DebugLog(@"fileName :%@",fileName);
    shapeData = [[NSMutableDictionary alloc]initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:fileName ofType:@"plist"]];
}
//=====================================================================================================================================//
#pragma mark-
#pragma mark======================
#pragma mark Shape Verification
#pragma mark======================

-(BOOL)verifyShapeData:(NSString*)key{
    DebugLog(@"");
    BOOL verified = NO;
    if ([shapeData objectForKey:key]) {
        
        verified = YES;
    }
    
    DebugLog(@"verifyShapeData shape verified :%d",verified);
    return verified;
}
@end
