//
//  WinterScene.m
//  TigglyStamp
//
//  Created by cuelogic on 01/07/13.
//  Copyright (c) 2013 cuelogic. All rights reserved.
//

#import "WinterScene.h"

@implementation WinterScene
@synthesize winterSquareObjects,winterTriangleObjects,winterCircleObjects,winterStarObjects,winterObjectWithShapes,delegate;

@synthesize presentBoxShapeArray,cupShapeArray,sledShapeArray,chooShapeArray,fireplaceShapeArray,green_sweaterShapeArray,ornamentShapeArray,pink_hatShapeArray,
pink_sweaterShapeArray,shovelShapeArray;

@synthesize bellsShapeArray,blue_hatShapeArray,deerShapeArray,deer_2ShapeArray,green_umbrellaShapeArray,
hot_choclateShapeArray,lightbulbShapeArray,purple_umbrellaShapeArray;

@synthesize bearShapeArray,birdShapeArray,candyShapeArray,choclateShapeArray,girlShapeArray,iglooShapeArray,
penguin_blueShapeArray,penguin_skateShapeArray,penguinShapeArray,snowglobeShapeArray,snowmanShapeArray;

@synthesize chipmunkShapeArray,foxShapeArray,ornament_purpleShapeArray,snowflake_1ShapeArray,snowflake_2ShapeArray,snowflake_3ShapeArray,star_cookieShapeArray,star_cookie_2ShapeArray;

int currentObject;

- (id)init{
    DebugLog(@"");
    self = [super init];
    if (self) {
         winterSquareObjects = [[NSMutableArray alloc] initWithObjects:@"present", @"cup", @"sled",@"choo",@"fireplace",@"green_sweater",@"ornament",@"pink_sweater",@"shovel",nil];
        
         winterTriangleObjects = [[NSMutableArray alloc] initWithObjects:@"bells", @"blue_hat", @"pink_hat",@"deer",@"deer_2",@"green_umbrella",@"hot_choclate",@"lightbulb",@"purple_umbrella",nil];
        
        winterCircleObjects = [[NSMutableArray alloc] initWithObjects:@"bear",@"bird",@"candy",@"choclate",@"girl",@"igloo",@"penguin_blue",@"penguin_skate",@"penguin",@"snowglobe",@"snowman",nil];
        
        winterStarObjects = [[NSMutableArray alloc] initWithObjects:@"chipmunk",@"fox",@"ornament_purple",@"snowflake_1",@"snowflake_2",@"snowflake_3",@"star_cookie",@"star_cookie_2",nil];
        
        presentBoxShapeArray =[[NSMutableArray alloc] initWithObjects:@"square", nil];
        cupShapeArray =[[NSMutableArray alloc] initWithObjects:@"square", nil];
        sledShapeArray =[[NSMutableArray alloc] initWithObjects:@"square", nil];
        chooShapeArray =[[NSMutableArray alloc] initWithObjects:@"square", nil];
        fireplaceShapeArray =[[NSMutableArray alloc] initWithObjects:@"square", nil];
        green_sweaterShapeArray =[[NSMutableArray alloc] initWithObjects:@"square", nil];
        ornamentShapeArray =[[NSMutableArray alloc] initWithObjects:@"square", nil];

        pink_sweaterShapeArray =[[NSMutableArray alloc] initWithObjects:@"square", nil];
        shovelShapeArray =[[NSMutableArray alloc] initWithObjects:@"square", nil];
        
        bellsShapeArray = [[NSMutableArray alloc] initWithObjects:@"triangle", nil];
        blue_hatShapeArray = [[NSMutableArray alloc] initWithObjects:@"triangle", nil];
        pink_hatShapeArray =[[NSMutableArray alloc] initWithObjects:@"triangle", nil];
        deerShapeArray = [[NSMutableArray alloc] initWithObjects:@"triangle", nil];
        deer_2ShapeArray = [[NSMutableArray alloc] initWithObjects:@"triangle", nil];
        green_umbrellaShapeArray = [[NSMutableArray alloc] initWithObjects:@"triangle", nil];
        hot_choclateShapeArray = [[NSMutableArray alloc] initWithObjects:@"triangle", nil];
        lightbulbShapeArray = [[NSMutableArray alloc] initWithObjects:@"triangle", nil];
        purple_umbrellaShapeArray = [[NSMutableArray alloc] initWithObjects:@"triangle", nil];
        
      
        bearShapeArray =[[NSMutableArray alloc] initWithObjects:@"circle", nil];
        birdShapeArray =[[NSMutableArray alloc] initWithObjects:@"circle", nil];
        candyShapeArray =[[NSMutableArray alloc] initWithObjects:@"circle", nil];
        choclateShapeArray =[[NSMutableArray alloc] initWithObjects:@"circle", nil];
        girlShapeArray =[[NSMutableArray alloc] initWithObjects:@"circle", nil];
        iglooShapeArray =[[NSMutableArray alloc] initWithObjects:@"circle", nil];
        penguin_blueShapeArray =[[NSMutableArray alloc] initWithObjects:@"circle", nil];
        penguin_skateShapeArray =[[NSMutableArray alloc] initWithObjects:@"circle", nil];
        penguinShapeArray =[[NSMutableArray alloc] initWithObjects:@"circle", nil];
        snowglobeShapeArray =[[NSMutableArray alloc] initWithObjects:@"circle", nil];
        snowmanShapeArray =[[NSMutableArray alloc] initWithObjects:@"circle", nil];
        

        chipmunkShapeArray = [[NSMutableArray alloc] initWithObjects:@"star", nil];
        foxShapeArray = [[NSMutableArray alloc] initWithObjects:@"star", nil];
        ornament_purpleShapeArray = [[NSMutableArray alloc] initWithObjects:@"star", nil];
        snowflake_1ShapeArray = [[NSMutableArray alloc] initWithObjects:@"star", nil];
        snowflake_2ShapeArray = [[NSMutableArray alloc] initWithObjects:@"star", nil];
        snowflake_3ShapeArray = [[NSMutableArray alloc] initWithObjects:@"star", nil];
        star_cookieShapeArray = [[NSMutableArray alloc] initWithObjects:@"star", nil];
        star_cookie_2ShapeArray = [[NSMutableArray alloc] initWithObjects:@"star", nil];
        
                
        winterObjectWithShapes = [[NSMutableDictionary alloc] init];
        
        [winterObjectWithShapes setObject:presentBoxShapeArray forKey:@"present"];
        [winterObjectWithShapes setObject:cupShapeArray forKey:@"cup"];
        [winterObjectWithShapes setObject:sledShapeArray forKey:@"sled"];
        [winterObjectWithShapes setObject:chooShapeArray forKey:@"choo"];
        [winterObjectWithShapes setObject:fireplaceShapeArray forKey:@"fireplace"];
        [winterObjectWithShapes setObject:green_sweaterShapeArray forKey:@"green_sweater"];
        [winterObjectWithShapes setObject:ornamentShapeArray forKey:@"ornament"];
        
        [winterObjectWithShapes setObject:pink_sweaterShapeArray forKey:@"pink_sweater"];
        [winterObjectWithShapes setObject:shovelShapeArray forKey:@"shovel"];
        
        
        [winterObjectWithShapes setObject:bellsShapeArray forKey:@"bells"];
        [winterObjectWithShapes setObject:blue_hatShapeArray forKey:@"blue_hat"];
        [winterObjectWithShapes setObject:pink_hatShapeArray forKey:@"pink_hat"];
        [winterObjectWithShapes setObject:deerShapeArray forKey:@"deer"];
        [winterObjectWithShapes setObject:deer_2ShapeArray forKey:@"deer_2"];
        [winterObjectWithShapes setObject:green_umbrellaShapeArray forKey:@"green_umbrella"];
        [winterObjectWithShapes setObject:hot_choclateShapeArray forKey:@"hot_choclate"];
        [winterObjectWithShapes setObject:lightbulbShapeArray forKey:@"lightbulb"];
        [winterObjectWithShapes setObject:purple_umbrellaShapeArray forKey:@"purple_umbrella"];
        
                
        [winterObjectWithShapes setObject:bearShapeArray forKey:@"bear"];
        [winterObjectWithShapes setObject:birdShapeArray forKey:@"bird"];
        [winterObjectWithShapes setObject:candyShapeArray forKey:@"candy"];
        [winterObjectWithShapes setObject:choclateShapeArray forKey:@"choclate"];
        [winterObjectWithShapes setObject:girlShapeArray forKey:@"girl"];
        [winterObjectWithShapes setObject:iglooShapeArray forKey:@"igloo"];
        [winterObjectWithShapes setObject:penguin_blueShapeArray forKey:@"penguin_blue"];
        [winterObjectWithShapes setObject:penguin_skateShapeArray forKey:@"penguin_skate"];
        [winterObjectWithShapes setObject:penguinShapeArray forKey:@"penguin"];
        [winterObjectWithShapes setObject:snowglobeShapeArray forKey:@"snowglobe"];
        [winterObjectWithShapes setObject:snowmanShapeArray forKey:@"snowman"];

        
        [winterObjectWithShapes setObject:chipmunkShapeArray forKey:@"chipmunk"];
        [winterObjectWithShapes setObject:foxShapeArray forKey:@"fox"];
        [winterObjectWithShapes setObject:ornament_purpleShapeArray forKey:@"ornament_purple"];
        [winterObjectWithShapes setObject:snowflake_1ShapeArray forKey:@"snowflake_1"];
        [winterObjectWithShapes setObject:snowflake_2ShapeArray forKey:@"snowflake_2"];
        [winterObjectWithShapes setObject:snowflake_3ShapeArray forKey:@"snowflake_3"];
        [winterObjectWithShapes setObject:star_cookieShapeArray forKey:@"star_cookie"];
        [winterObjectWithShapes setObject:star_cookie_2ShapeArray forKey:@"star_cookie_2"];

    }
    return self;
}
-(NSMutableArray *)shapeForObject:(NSString *)shape {
    DebugLog(@"");
    NSString *objectName = nil;
    if([shape isEqualToString:@"triangle"]){
        int size = [winterTriangleObjects count];
        if(size == 0){
            [winterTriangleObjects addObject:@"bells"];
            [winterTriangleObjects addObject:@"blue_hat"];
            [winterTriangleObjects addObject:@"pink_hat"];
            [winterTriangleObjects addObject:@"deer"];
            [winterTriangleObjects addObject:@"deer_2"];
            [winterTriangleObjects addObject:@"green_umbrella"];
            [winterTriangleObjects addObject:@"hot_choclate"];
            [winterTriangleObjects addObject:@"purple_umbrella"];
            size = 8;
        }
        currentObject =  arc4random()%size;
        objectName = [winterTriangleObjects objectAtIndex:currentObject];
        DebugLog(@"Give array of shape %@", objectName);
    }
    if([shape isEqualToString:@"circle"]){
        int size = [winterCircleObjects count];
        if(size == 0){            
            [winterCircleObjects addObject:@"bear"];
            [winterCircleObjects addObject:@"bird"];
            [winterCircleObjects addObject:@"candy"];
            [winterCircleObjects addObject:@"choclate"];
            [winterCircleObjects addObject:@"igloo"];
            [winterCircleObjects addObject:@"penguin_blue"];
            [winterCircleObjects addObject:@"penguin_skate"];
            [winterCircleObjects addObject:@"penguin"];
            [winterCircleObjects addObject:@"snowglobe"];
            size = 9;
        }
        currentObject =  arc4random()%size;
        objectName = [winterCircleObjects objectAtIndex:currentObject];
        DebugLog(@"Give array of shape %@", objectName);
        
    }
    if([shape isEqualToString:@"square"]){
        int size = [winterSquareObjects count];
        if(size == 0){
            [winterSquareObjects addObject:@"present"];
            [winterSquareObjects addObject:@"cup"];
            [winterSquareObjects addObject:@"sled"];
            [winterSquareObjects addObject:@"choo"];
            [winterSquareObjects addObject:@"fireplace"];
            [winterSquareObjects addObject:@"green_sweater"];
            [winterSquareObjects addObject:@"ornament"];
            [winterSquareObjects addObject:@"pink_sweater"];
            [winterSquareObjects addObject:@"shovel"];
            size = 9;
        }
        currentObject =  arc4random()%size;
        objectName = [winterSquareObjects objectAtIndex:currentObject];
        DebugLog(@"Give array of shape %@", objectName);
        
    }
    if([shape isEqualToString:@"star"]){
        int size = [winterStarObjects count];
        if(size == 0){
            [winterStarObjects addObject:@"chipmunk"];
            [winterStarObjects addObject:@"fox"];
            [winterStarObjects addObject:@"ornament_purple"];
            [winterStarObjects addObject:@"snowflake_1"];
            [winterStarObjects addObject:@"snowflake_2"];
            [winterStarObjects addObject:@"snowflake_3"];
            [winterStarObjects addObject:@"star_cookie"];
            [winterStarObjects addObject:@"star_cookie_2"];
            size = 8;
        }
        currentObject =  arc4random()%size;
        objectName = [winterStarObjects objectAtIndex:currentObject];
        DebugLog(@"Give array of shape %@", objectName);
        
    }
    [self.delegate drawObjectForObjectName:objectName];
    return [winterObjectWithShapes objectForKey:objectName];
}

-(void)removeDrawnShapeObject:(NSString *)typeOfShape  objectToRemove:(NSString *)objectDrawn{
    DebugLog(@"triangls=%@",winterTriangleObjects.description);
    DebugLog(@"squr=%@",winterSquareObjects.description);
    DebugLog(@"star=%@",winterStarObjects.description);
    DebugLog(@"shape type %@, to remove %@",typeOfShape,objectDrawn);
    
    if([typeOfShape isEqualToString:@"triangle"]){
        [winterTriangleObjects removeObjectIdenticalTo:objectDrawn];
    }
    if([typeOfShape isEqualToString:@"square"]){
        [winterSquareObjects removeObjectIdenticalTo:objectDrawn];
    }
    if([typeOfShape isEqualToString:@"star"]){
        [winterStarObjects removeObjectIdenticalTo:objectDrawn];
    }
    if([typeOfShape isEqualToString:@"circle"]){
        [winterCircleObjects removeObjectIdenticalTo:objectDrawn];
    }
        
}


@end
