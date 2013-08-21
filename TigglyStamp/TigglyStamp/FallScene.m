//
//  FallScene.m
//  TigglyStamp
//
//  Created by Sachin Patil on 30/07/13.
//  Copyright (c) 2013 cuelogic. All rights reserved.
//

#import "FallScene.h"

@implementation FallScene
@synthesize fallSquareObjects,fallTriangleObjects,fallCircleObjects,fallStarObjects,fallObjectWithShapes,delegate;

@synthesize batShapeArray,blue_candyShapeArray,green_leafShapeArray,haybaleShapeArray,orange_candyShapeArray,orange_leafShapeArray,purple_spirderShapeArray,spiderShapeArray,yellow_candyShapeArray,pirateShapeArray,barn_2ShapeArray;

@synthesize beeShapeArray,broomShapeArray,horseShapeArray,leavesShapeArray,mushroomShapeArray,pearShapeArray,raincoatShapeArray,three_colorShapeArray,witches_hat_purpleShapeArray,witches_hatShapeArray,zebra_2ShapeArray,duck_1ShapeArray;

@synthesize apple_redShapeArray,blue_turkeyShapeArray,cranberries_leavesShapeArray,cranberriesShapeArray,green_appleShapeArray,greyish_catShapeArray,litepurple_racoonShapeArray,orange_turkeyShapeArray,pink_catShapeArray,pumkin_1ShapeArray,pumpkin_3ShapeArray,racoonShapeArray;

@synthesize green_leaf_2ShapeArray,hampsterShapeArray,orange_leaf_2ShapeArray,pink_leafShapeArray,scare_crowShapeArray,yellow_leafShapeArray,rooster_2ShapeArray,roosterShapeArray;

int currentObject;

#pragma mark -
#pragma mark =======================================
#pragma mark Init
#pragma mark =======================================

- (id)init{
    DebugLog(@"");
    self = [super init];
    if (self) {

        fallSquareObjects = [[NSMutableArray alloc] initWithObjects:
                             @"bat", @"blue_candy",@"green_leaf",@"haybale",@"orange_candy",@"orange_leaf",@"purple_spirder",@"spider",@"yellow_candy",@"pirate",@"barn_2",nil];
        
        fallTriangleObjects = [[NSMutableArray alloc] initWithObjects:
                               @"bee", @"broom", @"horse",@"leaves",@"mushroom",@"pear",@"raincoat",@"three_color",@"witches_hat_purple",@"witches_hat",@"zebra_2",@"duck_1",nil];
        
        fallCircleObjects = [[NSMutableArray alloc] initWithObjects:                             @"apple_red",@"blue_turkey",@"cranberries_leaves",@"cranberries",@"green_apple",@"greyish_cat",@"litepurple_racoon",@"orange_turkey",@"pink_cat",@"pumkin_1",@"pumpkin_3",@"racoon",nil];
        
        fallStarObjects = [[NSMutableArray alloc] initWithObjects:
                           @"green_leaf_2",@"hampster",@"orange_leaf_2",@"pink_leaf",@"scare_crow",@"yellow_leaf",@"rooster_2",@"rooster",nil];
        
        batShapeArray =[[NSMutableArray alloc] initWithObjects:@"square", nil];
        blue_candyShapeArray =[[NSMutableArray alloc] initWithObjects:@"square", nil];
        green_leafShapeArray =[[NSMutableArray alloc] initWithObjects:@"square", nil];
        haybaleShapeArray =[[NSMutableArray alloc] initWithObjects:@"square", nil];
        orange_candyShapeArray =[[NSMutableArray alloc] initWithObjects:@"square", nil];
        purple_spirderShapeArray =[[NSMutableArray alloc] initWithObjects:@"square", nil];
        orange_leafShapeArray =[[NSMutableArray alloc] initWithObjects:@"square", nil];        
        spiderShapeArray =[[NSMutableArray alloc] initWithObjects:@"square", nil];
        yellow_candyShapeArray =[[NSMutableArray alloc] initWithObjects:@"square", nil];
        pirateShapeArray=[[NSMutableArray alloc] initWithObjects:@"square", nil];
        barn_2ShapeArray = [[NSMutableArray alloc] initWithObjects:@"square", nil];

        
        beeShapeArray = [[NSMutableArray alloc] initWithObjects:@"triangle", nil];
        broomShapeArray = [[NSMutableArray alloc] initWithObjects:@"triangle", nil];
        horseShapeArray = [[NSMutableArray alloc] initWithObjects:@"triangle", nil];
        leavesShapeArray = [[NSMutableArray alloc] initWithObjects:@"triangle", nil];
        mushroomShapeArray = [[NSMutableArray alloc] initWithObjects:@"triangle", nil];
        pearShapeArray = [[NSMutableArray alloc] initWithObjects:@"triangle", nil];
        raincoatShapeArray = [[NSMutableArray alloc] initWithObjects:@"triangle", nil];
        three_colorShapeArray = [[NSMutableArray alloc] initWithObjects:@"triangle", nil];
        witches_hat_purpleShapeArray = [[NSMutableArray alloc] initWithObjects:@"triangle", nil];
        witches_hatShapeArray = [[NSMutableArray alloc] initWithObjects:@"triangle", nil];
        zebra_2ShapeArray = [[NSMutableArray alloc] initWithObjects:@"triangle", nil];
        duck_1ShapeArray = [[NSMutableArray alloc] initWithObjects:@"triangle", nil];
        
        
        apple_redShapeArray =[[NSMutableArray alloc] initWithObjects:@"circle", nil];
        blue_turkeyShapeArray =[[NSMutableArray alloc] initWithObjects:@"circle", nil];
        cranberries_leavesShapeArray =[[NSMutableArray alloc] initWithObjects:@"circle", nil];
        cranberriesShapeArray =[[NSMutableArray alloc] initWithObjects:@"circle", nil];
        green_appleShapeArray =[[NSMutableArray alloc] initWithObjects:@"circle", nil];
        greyish_catShapeArray =[[NSMutableArray alloc] initWithObjects:@"circle", nil];
        litepurple_racoonShapeArray =[[NSMutableArray alloc] initWithObjects:@"circle", nil];
        orange_turkeyShapeArray =[[NSMutableArray alloc] initWithObjects:@"circle", nil];
        pink_catShapeArray =[[NSMutableArray alloc] initWithObjects:@"circle", nil];
        pumkin_1ShapeArray =[[NSMutableArray alloc] initWithObjects:@"circle", nil];
        pumpkin_3ShapeArray =[[NSMutableArray alloc] initWithObjects:@"circle", nil];
        racoonShapeArray =[[NSMutableArray alloc] initWithObjects:@"circle", nil];
        
        //star
        green_leaf_2ShapeArray = [[NSMutableArray alloc] initWithObjects:@"star", nil];
        hampsterShapeArray = [[NSMutableArray alloc] initWithObjects:@"star", nil];
        orange_leaf_2ShapeArray = [[NSMutableArray alloc] initWithObjects:@"star", nil];
        pink_leafShapeArray = [[NSMutableArray alloc] initWithObjects:@"star", nil];
        scare_crowShapeArray = [[NSMutableArray alloc] initWithObjects:@"star", nil];
        yellow_leafShapeArray = [[NSMutableArray alloc] initWithObjects:@"star", nil];
        roosterShapeArray= [[NSMutableArray alloc] initWithObjects:@"star", nil];
        rooster_2ShapeArray= [[NSMutableArray alloc] initWithObjects:@"star", nil];
        
        
        fallObjectWithShapes = [[NSMutableDictionary alloc] init];
        
        //square
        [fallObjectWithShapes setObject:batShapeArray forKey:@"bat"];
        [fallObjectWithShapes setObject:blue_candyShapeArray forKey:@"blue_candy"];
        [fallObjectWithShapes setObject:green_leafShapeArray forKey:@"green_leaf"];
        [fallObjectWithShapes setObject:haybaleShapeArray forKey:@"haybale"];
        [fallObjectWithShapes setObject:orange_candyShapeArray forKey:@"orange_candy"];
        [fallObjectWithShapes setObject:orange_leafShapeArray forKey:@"orange_leaf"];
        [fallObjectWithShapes setObject:purple_spirderShapeArray forKey:@"purple_spirder"];        
        [fallObjectWithShapes setObject:spiderShapeArray forKey:@"spider"];
        [fallObjectWithShapes setObject:yellow_candyShapeArray forKey:@"yellow_candy"];
        [fallObjectWithShapes setObject:pirateShapeArray forKey:@"pirate"];
        [fallObjectWithShapes setObject:barn_2ShapeArray forKey:@"barn_2"];
        

        //triangle
        [fallObjectWithShapes setObject:beeShapeArray forKey:@"bee"];
        [fallObjectWithShapes setObject:broomShapeArray forKey:@"broom"];
        [fallObjectWithShapes setObject:horseShapeArray forKey:@"horse"];
        [fallObjectWithShapes setObject:leavesShapeArray forKey:@"leaves"];
        [fallObjectWithShapes setObject:mushroomShapeArray forKey:@"mushroom"];
        [fallObjectWithShapes setObject:pearShapeArray forKey:@"pear"];
        [fallObjectWithShapes setObject:raincoatShapeArray forKey:@"raincoat"];
        [fallObjectWithShapes setObject:three_colorShapeArray forKey:@"three_color"];
        [fallObjectWithShapes setObject:witches_hat_purpleShapeArray forKey:@"witches_hat_purple"];
        [fallObjectWithShapes setObject:witches_hatShapeArray forKey:@"witches_hat"];
        [fallObjectWithShapes setObject:zebra_2ShapeArray forKey:@"zebra_2"];
         [fallObjectWithShapes setObject:duck_1ShapeArray forKey:@"duck_1"];
        
        
        //circle
        [fallObjectWithShapes setObject:apple_redShapeArray forKey:@"apple_red"];
        [fallObjectWithShapes setObject:blue_turkeyShapeArray forKey:@"blue_turkey"];
        [fallObjectWithShapes setObject:cranberries_leavesShapeArray forKey:@"cranberries_leaves"];
        [fallObjectWithShapes setObject:cranberriesShapeArray forKey:@"cranberries"];
        [fallObjectWithShapes setObject:green_appleShapeArray forKey:@"green_apple"];
        [fallObjectWithShapes setObject:greyish_catShapeArray forKey:@"greyish_cat"];
        [fallObjectWithShapes setObject:litepurple_racoonShapeArray forKey:@"litepurple_racoon"];
        [fallObjectWithShapes setObject:orange_turkeyShapeArray forKey:@"orange_turkey"];
        [fallObjectWithShapes setObject:pink_catShapeArray forKey:@"pink_cat"];
        [fallObjectWithShapes setObject:pumkin_1ShapeArray forKey:@"pumkin_1"];
        [fallObjectWithShapes setObject:pumpkin_3ShapeArray forKey:@"pumpkin_3"];
        [fallObjectWithShapes setObject:racoonShapeArray forKey:@"racoon"];
        
        //star
        [fallObjectWithShapes setObject:green_leaf_2ShapeArray forKey:@"green_leaf_2"];
        [fallObjectWithShapes setObject:hampsterShapeArray forKey:@"hampster"];
        [fallObjectWithShapes setObject:orange_leaf_2ShapeArray forKey:@"orange_leaf_2"];
        [fallObjectWithShapes setObject:pink_leafShapeArray forKey:@"pink_leaf"];
        [fallObjectWithShapes setObject:scare_crowShapeArray forKey:@"care_crow"];
        [fallObjectWithShapes setObject:yellow_leafShapeArray forKey:@"yellow_leaf"];
        [fallObjectWithShapes setObject:rooster_2ShapeArray forKey:@"rooster_2"];
        [fallObjectWithShapes setObject:roosterShapeArray forKey:@"rooster"];
;
        
    }
    return self;
}

#pragma mark -
#pragma mark =======================================
#pragma mark Helpers
#pragma mark =======================================

-(NSMutableArray *)shapeForObject:(NSString *)shape {
    DebugLog(@"");
    NSString *objectName = nil;
    if([shape isEqualToString:@"triangle"]){
        int size = [fallTriangleObjects count];
        if(size == 0){
            [fallTriangleObjects addObject:@"bee"];
            [fallTriangleObjects addObject:@"broom"];
            [fallTriangleObjects addObject:@"horse"];
            [fallTriangleObjects addObject:@"leaves"];
            [fallTriangleObjects addObject:@"mushroom"];
            [fallTriangleObjects addObject:@"pear"];
            [fallTriangleObjects addObject:@"raincoat"];
            [fallTriangleObjects addObject:@"three_color"];
            [fallTriangleObjects addObject:@"witches_hat_purple"];
            [fallTriangleObjects addObject:@"witches_hat"];
            [fallTriangleObjects addObject:@"zebra_2"];
            [fallTriangleObjects addObject:@"duck_1"];
            
            size = 12;
        }
        currentObject =  arc4random()%size;
        objectName = [fallTriangleObjects objectAtIndex:currentObject];
        DebugLog(@"Give array of shape %@", objectName);
    }
    if([shape isEqualToString:@"circle"]){
        int size = [fallCircleObjects count];
        if(size == 0){
            [fallCircleObjects addObject:@"apple_red"];
            [fallCircleObjects addObject:@"blue_turkey"];
            [fallCircleObjects addObject:@"cranberries_leaves"];
            [fallCircleObjects addObject:@"cranberries"];
            [fallCircleObjects addObject:@"green_apple"];
            [fallCircleObjects addObject:@"greyish_cat"];
            [fallCircleObjects addObject:@"litepurple_racoon"];
            [fallCircleObjects addObject:@"orange_turkey"];
            [fallCircleObjects addObject:@"pink_cat"];
            [fallCircleObjects addObject:@"pumkin_1"];
            [fallCircleObjects addObject:@"pumpkin_3"];
            [fallCircleObjects addObject:@"racoon"];
            size = 12;
        }
        currentObject =  arc4random()%size;
        objectName = [fallCircleObjects objectAtIndex:currentObject];
        DebugLog(@"Give array of shape %@", objectName);
        
    }
    if([shape isEqualToString:@"square"]){
        int size = [fallSquareObjects count];
        if(size == 0){
            [fallSquareObjects addObject:@"bat"];
            [fallSquareObjects addObject:@"blue_candy"];
            [fallSquareObjects addObject:@"green_leaf"];
            [fallSquareObjects addObject:@"haybale"];
            [fallSquareObjects addObject:@"orange_candy"];
            [fallSquareObjects addObject:@"orange_leaf"];
            [fallSquareObjects addObject:@"purple_spirder"];
            [fallSquareObjects addObject:@"spider"];
            [fallSquareObjects addObject:@"yellow_candy"];
            [fallSquareObjects addObject:@"pirate"];
            [fallSquareObjects addObject:@"barn_2"];
            size = 11;
        }
        currentObject =  arc4random()%size;
        objectName = [fallSquareObjects objectAtIndex:currentObject];
        DebugLog(@"Give array of shape %@", objectName);
        
    }
    if([shape isEqualToString:@"star"]){
        int size = [fallStarObjects count];
        if(size == 0){
            [fallStarObjects addObject:@"green_leaf_2"];
            [fallStarObjects addObject:@"hampster"];
            [fallStarObjects addObject:@"orange_leaf_2"];
            [fallStarObjects addObject:@"pink_leaf"];
            [fallStarObjects addObject:@"scare_crow"];
            [fallStarObjects addObject:@"yellow_leaf"];
            [fallStarObjects addObject:@"rooster_2"];
            [fallStarObjects addObject:@"rooster"];
            size = 8;
        }
        currentObject =  arc4random()%size;
        objectName = [fallStarObjects objectAtIndex:currentObject];
        DebugLog(@"Give array of shape %@", objectName);
        
    }
    [self.delegate fallSceneDrawObjectForObjectName:objectName];
    return [fallObjectWithShapes objectForKey:objectName];
}

-(void)removeDrawnShapeObject:(NSString *)typeOfShape  objectToRemove:(NSString *)objectDrawn{
//    DebugLog(@"triangls=%@",fallTriangleObjects.description);
//    DebugLog(@"squr=%@",fallSquareObjects.description);
//    DebugLog(@"star=%@",fallStarObjects.description);
//    DebugLog(@"shape type %@, to remove %@",typeOfShape,objectDrawn);
    
    if([typeOfShape isEqualToString:@"triangle"]){
        [fallTriangleObjects removeObjectIdenticalTo:objectDrawn];
    }
    if([typeOfShape isEqualToString:@"square"]){
        [fallSquareObjects removeObjectIdenticalTo:objectDrawn];
    }
    if([typeOfShape isEqualToString:@"star"]){
        [fallStarObjects removeObjectIdenticalTo:objectDrawn];
    }
    if([typeOfShape isEqualToString:@"circle"]){
        [fallCircleObjects removeObjectIdenticalTo:objectDrawn];
    }
    
}


@end
