//
//  UITouchShapeRecognizer.h
//  TouchVerification
//
//  Created by Philip Hayes on 3/3/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TConstant.h"

@interface UITouchShapeRecognizer : NSObject
@property(nonatomic, strong)NSMutableDictionary *shapeData;
@property(nonatomic, strong)NSString *dataName;
@property(nonatomic, strong)CALayer *displayShape;
@property(nonatomic, strong)NSString * file, *label;

-(id)initWithPlistfile:(NSString*)fileName;
-(BOOL)verifyShapeData:(NSString*)key;
-(void)loadShapDataWithFile:(NSString*)fileName;
@end
