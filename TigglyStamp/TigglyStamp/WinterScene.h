//
//  WinterScene.h
//  TigglyStamp
//
//  Created by cuelogic on 01/07/13.
//  Copyright (c) 2013 cuelogic. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TConstant.h"

@interface WinterScene : NSObject
-(NSString *) getObjectForShape:(NSString *)shape;
-(UIColor *)getRGBValueForShape:(NSString *)shapeToDraw;
-(NSString *) getAnimalNameSoundForObject:(NSString *) winterObject;
-(NSString *) getAnimalDropSoundForObject:(NSString *) winterObject;
-(void)removeAllObjects;
@end
