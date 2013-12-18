//
//  FallScene.h
//  TigglyStamp
//
//  Created by Sachin Patil on 30/07/13.
//  Copyright (c) 2013 cuelogic. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TConstant.h"


@interface FallScene : NSObject
-(NSString *) getObjectForShape:(NSString *)shape;
-(UIColor  *)getRGBValueForShape:(NSString *)shapeToDraw;
-(NSString *) getAnimalNameSoundForObject:(NSString *) fallObject;
-(NSString *) getAnimalDropSoundForObject:(NSString *) fallObject;
-(void)removeAllObjects;
@end
