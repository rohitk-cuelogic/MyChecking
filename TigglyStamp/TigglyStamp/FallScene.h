//
//  FallScene.h
//  TigglyStamp
//
//  Created by Sachin Patil on 30/07/13.
//  Copyright (c) 2013 cuelogic. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TConstant.h"

@protocol FallSceneShapeToDrawProtocol <NSObject>;

-(void)fallSceneDrawObjectForObjectName:(NSString *)objectName;

@end

@interface FallScene : NSObject
@property(nonatomic, unsafe_unretained)id<FallSceneShapeToDrawProtocol>delegate;

@property(nonatomic, strong)NSMutableArray *fallSquareObjects;
@property(nonatomic, strong)NSMutableArray *fallTriangleObjects;
@property(nonatomic, strong)NSMutableArray *fallStarObjects;
@property(nonatomic, strong)NSMutableArray *fallCircleObjects;

//Square
@property(nonatomic,strong)NSMutableArray *batShapeArray;
@property(nonatomic,strong)NSMutableArray *blue_candyShapeArray;
@property(nonatomic,strong)NSMutableArray *green_leafShapeArray;
@property(nonatomic,strong)NSMutableArray *haybaleShapeArray;
@property(nonatomic,strong)NSMutableArray *orange_candyShapeArray;
@property(nonatomic,strong)NSMutableArray *orange_leafShapeArray;
@property(nonatomic,strong)NSMutableArray *purple_spirderShapeArray;
@property(nonatomic,strong)NSMutableArray *spiderShapeArray;
@property(nonatomic,strong)NSMutableArray *yellow_candyShapeArray;
@property(nonatomic,strong)NSMutableArray *pirateShapeArray;
@property(nonatomic,strong)NSMutableArray *barn_2ShapeArray;

//Triangle
@property(nonatomic,strong)NSMutableArray *beeShapeArray;
@property(nonatomic,strong)NSMutableArray *broomShapeArray;
@property(nonatomic,strong)NSMutableArray *horseShapeArray;
@property(nonatomic,strong)NSMutableArray *leavesShapeArray;
@property(nonatomic,strong)NSMutableArray *mushroomShapeArray;
@property(nonatomic,strong)NSMutableArray *pearShapeArray;
@property(nonatomic,strong)NSMutableArray *raincoatShapeArray;
@property(nonatomic,strong)NSMutableArray *three_colorShapeArray;
@property(nonatomic,strong)NSMutableArray *witches_hat_purpleShapeArray;
@property(nonatomic,strong)NSMutableArray *witches_hatShapeArray;
@property(nonatomic,strong)NSMutableArray *zebra_2ShapeArray;
@property(nonatomic,strong)NSMutableArray *duck_1ShapeArray;
@property(nonatomic, strong) NSMutableArray *pinkRaincoatArray;
@property(nonatomic, strong) NSMutableArray *orangeRaincoatArray;
@property(nonatomic, strong) NSMutableArray *yellowRaincoatArray;
@property(nonatomic, strong) NSMutableArray *roosterArray;

//Circle
@property(nonatomic,strong)NSMutableArray *apple_redShapeArray;
@property(nonatomic,strong)NSMutableArray *blue_turkeyShapeArray;
@property(nonatomic,strong)NSMutableArray *cranberries_leavesShapeArray;
@property(nonatomic,strong)NSMutableArray *cranberriesShapeArray;
@property(nonatomic,strong)NSMutableArray *green_appleShapeArray;
@property(nonatomic,strong)NSMutableArray *greyish_catShapeArray;
@property(nonatomic,strong)NSMutableArray *litepurple_racoonShapeArray;
@property(nonatomic,strong)NSMutableArray *orange_turkeyShapeArray;
@property(nonatomic,strong)NSMutableArray *pink_catShapeArray;
@property(nonatomic,strong)NSMutableArray *pumkin_1ShapeArray;
@property(nonatomic,strong)NSMutableArray *pumpkin_3ShapeArray;
@property(nonatomic,strong)NSMutableArray *racoonShapeArray;

//Star
@property(nonatomic,strong)NSMutableArray *green_leaf_2ShapeArray;
@property(nonatomic,strong)NSMutableArray *hampsterShapeArray;
@property(nonatomic,strong)NSMutableArray *orange_leaf_2ShapeArray;
@property(nonatomic,strong)NSMutableArray *pink_leafShapeArray;
@property(nonatomic,strong)NSMutableArray *scare_crowShapeArray;
@property(nonatomic,strong)NSMutableArray *yellow_leafShapeArray;
@property(nonatomic,strong)NSMutableArray *chickenShapeArray;
@property(nonatomic,strong)NSMutableDictionary *fallObjectWithShapes;

-(NSMutableArray *)shapeForObject:(NSString *)shape;
-(void)removeDrawnShapeObject:(NSString *)typeOfShape  objectToRemove:(NSString *)objectDrawn;
-(NSString *) getAnimalNameSoundForObject:(NSString *) fallObject;
-(NSString *) getAnimalDropSoundForObject:(NSString *) fallObject;
@end
