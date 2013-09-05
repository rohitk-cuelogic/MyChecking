//
//  WinterScene.h
//  TigglyStamp
//
//  Created by cuelogic on 01/07/13.
//  Copyright (c) 2013 cuelogic. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TConstant.h"

@protocol ShapeToDrawProtocol <NSObject>;

-(void)drawObjectForObjectName:(NSString *)objectName;

@end

@interface WinterScene : NSObject
@property(nonatomic, unsafe_unretained)id<ShapeToDrawProtocol>delegate;

@property(nonatomic, strong)NSMutableArray *winterSquareObjects;
@property(nonatomic, strong)NSMutableArray *winterTriangleObjects;
@property(nonatomic, strong)NSMutableArray *winterStarObjects;
@property(nonatomic, strong)NSMutableArray *winterCircleObjects;

@property(nonatomic,strong)NSMutableArray *presentBoxShapeArray;
@property(nonatomic,strong)NSMutableArray *cupShapeArray;
@property(nonatomic,strong)NSMutableArray *sledShapeArray;
@property(nonatomic,strong)NSMutableArray *chooShapeArray;
@property(nonatomic,strong)NSMutableArray *fireplaceShapeArray;
@property(nonatomic,strong)NSMutableArray *green_sweaterShapeArray;
@property(nonatomic,strong)NSMutableArray *ornamentShapeArray;
@property(nonatomic,strong)NSMutableArray *pink_hatShapeArray;
@property(nonatomic,strong)NSMutableArray *pink_sweaterShapeArray;
@property(nonatomic,strong)NSMutableArray *shovelShapeArray;

@property(nonatomic,strong)NSMutableArray *bellsShapeArray;
@property(nonatomic,strong)NSMutableArray *blue_hatShapeArray;
@property(nonatomic,strong)NSMutableArray *deerShapeArray;
@property(nonatomic,strong)NSMutableArray *deer_2ShapeArray;
@property(nonatomic,strong)NSMutableArray *green_umbrellaShapeArray;
@property(nonatomic,strong)NSMutableArray *hot_choclateShapeArray;
@property(nonatomic,strong)NSMutableArray *lightbulbShapeArray;
@property(nonatomic,strong)NSMutableArray *purple_umbrellaShapeArray;


@property(nonatomic,strong)NSMutableArray *bearShapeArray;
@property(nonatomic,strong)NSMutableArray *birdShapeArray;
@property(nonatomic,strong)NSMutableArray *candyShapeArray;
@property(nonatomic,strong)NSMutableArray *choclateShapeArray;
@property(nonatomic,strong)NSMutableArray *girlShapeArray;
@property(nonatomic,strong)NSMutableArray *iglooShapeArray;
@property(nonatomic,strong)NSMutableArray *penguin_blueShapeArray;
@property(nonatomic,strong)NSMutableArray *penguin_skateShapeArray;
@property(nonatomic,strong)NSMutableArray *penguinShapeArray;
@property(nonatomic,strong)NSMutableArray *snowglobeShapeArray;
@property(nonatomic,strong)NSMutableArray *snowmanShapeArray;


@property(nonatomic,strong)NSMutableArray *chipmunkShapeArray;
@property(nonatomic,strong)NSMutableArray *foxShapeArray;
@property(nonatomic,strong)NSMutableArray *ornament_purpleShapeArray;
@property(nonatomic,strong)NSMutableArray *snowflake_1ShapeArray;
@property(nonatomic,strong)NSMutableArray *snowflake_2ShapeArray;
@property(nonatomic,strong)NSMutableArray *snowflake_3ShapeArray;
@property(nonatomic,strong)NSMutableArray *star_cookieShapeArray;
@property(nonatomic,strong)NSMutableArray *star_cookie_2ShapeArray;


@property(nonatomic,strong)NSMutableDictionary *winterObjectWithShapes;
-(NSString *)pickRandomObject;
-(NSMutableArray *)shapeForObject:(NSString *)shape;
-(void)removeDrawnShapeObject:(NSString *)typeOfShape  objectToRemove:(NSString *)objectDrawn;
-(NSString *) getAnimalNameSoundForObject:(NSString *) winterObject;
-(NSString *) getAnimalDropSoundForObject:(NSString *) winterObject;
@end
