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


-(NSString *) getAnimalNameSoundForObject:(NSString *) fallObject{
    DebugLog(@"");
    
    NSString *soundFile;
 
    if([fallObject isEqualToString:@"apple_red"] || [fallObject isEqualToString:@"green_apple"]) {
        int ranNo = random()%2;
        
        if(ranNo == 0){
            soundFile = @"Tiggly_Word_Apple_01";
        }else if (ranNo == 1) {
            soundFile = @"Tiggly_Word_Apple_Wow_01";
        }
        
    }else if([fallObject isEqualToString:@"blue_turkey"] || [fallObject isEqualToString:@"orange_turkey"]) {
        int ranNo = random()%5;
        
        if(ranNo == 0){
            soundFile = @"Tiggly_GenGreeting_Turkey_01";
        }else if (ranNo == 1) {
            soundFile = @"Tiggly_GenGreeting_Turkey_02";
        }else if (ranNo == 2) {
            soundFile = @"Tiggly_GenGreeting_Turkey_03";
        }else if (ranNo == 3) {
            soundFile = @"Tiggly_GenGreeting_Turkey_04";
        }else if (ranNo == 4) {
            soundFile = @"Tiggly_GenGreeting_Turkey_05";
        }
        
    }else if([fallObject isEqualToString:@"cranberries"]) {
        int ranNo = random()%2;
        
        if(ranNo == 0){
            soundFile = @"Tiggly_Word_Cranberries_01";
        }else if (ranNo == 1) {
            soundFile = @"Tiggly_Word_Cranberries_Oh_01";
        }
        
    }else if([fallObject isEqualToString:@"greyish_cat"] || [fallObject isEqualToString:@"pink_cat"]|| [fallObject isEqualToString:@"cat"]) {
        int ranNo = random()%6;
        
        if(ranNo == 0){
            soundFile = @"Tiggly_GenGreeting_Cat_04";
        }else if (ranNo == 1) {
            soundFile = @"Tiggly_GenGreeting_Cat_05";
        }else if (ranNo == 2) {
            soundFile = @"Tiggly_GenGreeting_Cat_07";
        }else if (ranNo == 3) {
            soundFile = @"Tiggly_GenGreeting_Cat_08";
        }else if (ranNo == 4) {
            soundFile = @"Tiggly_GenGreeting_Cat_09";
        }else if (ranNo == 5) {
            soundFile = @"Tiggly_GenGreeting_Cat_10";
        }
        
    }else if([fallObject isEqualToString:@"litepurple_racoon"] || [fallObject isEqualToString:@"racoon"]) {
        int ranNo = random()%8;
        
        if(ranNo == 0){
            soundFile = @"Tiggly_GenGreeting_Raccoon_02";
        }else if (ranNo == 1) {
            soundFile = @"Tiggly_GenGreeting_Raccoon_03";
        }else if (ranNo == 2) {
            soundFile = @"Tiggly_GenGreeting_Raccoon_05";
        }else if (ranNo == 3) {
            soundFile = @"Tiggly_GenGreeting_Raccoon_06";
        }else if (ranNo == 4) {
            soundFile = @"Tiggly_GenGreeting_Raccoon_07";
        }else if (ranNo == 5) {
            soundFile = @"Tiggly_GenGreeting_Raccoon_09";
        }else if (ranNo == 6) {
            soundFile = @"Tiggly_GenGreeting_Raccoon_10";
        }else if (ranNo == 7) {
            soundFile = @"Tiggly_GenGreeting_Raccoon_11";
        }
        
    }else if([fallObject isEqualToString:@"pumkin_1"] || [fallObject isEqualToString:@"pumpkin_3"]|| [fallObject isEqualToString:@"pumkin_bag"] ) {
        int ranNo = random()%7;
        
        if(ranNo == 0){
            soundFile = @"Tiggly_GenGreeting_Pumpkin_01";
        }else if (ranNo == 1) {
            soundFile = @"Tiggly_GenGreeting_Pumpkin_02";
        }else if (ranNo == 2) {
            soundFile = @"Tiggly_GenGreeting_Pumpkin_03";
        }else if (ranNo == 3) {
            soundFile = @"Tiggly_GenGreeting_Pumpkin_04";
        }else if (ranNo == 4) {
            soundFile = @"Tiggly_GenGreeting_Pumpkin_06";
        }else if (ranNo == 5) {
            soundFile = @"Tiggly_GenGreeting_Pumpkin_07";
        }else if (ranNo == 6) {
            soundFile = @"Tiggly_GenGreeting_Pumpkin_08";
        }
        
    }else if([fallObject isEqualToString:@"barn_2"] ) {
        int ranNo = random()%2;
        
        if(ranNo == 0){
            soundFile = @"Tiggly_Word_Barn_01";
        }else if (ranNo == 1) {
            soundFile = @"Tiggly_Word_Barn_Wow_01";
        }
        
    }else if([fallObject isEqualToString:@"bat"]) {
        int ranNo = random()%4;
        
        if(ranNo == 0){
            soundFile = @"Tiggly_GenGreeting_Bat_01";
        }else if (ranNo == 1) {
            soundFile = @"Tiggly_GenGreeting_Bat_02";
        }else if (ranNo == 2) {
            soundFile = @"Tiggly_GenGreeting_Bat_03";
        }else if (ranNo == 3) {
            soundFile = @"Tiggly_GenGreeting_Bat_04";
        }
        
    }else if([fallObject isEqualToString:@"blue_candy"] || [fallObject isEqualToString:@"orange_candy"]|| [fallObject isEqualToString:@"yellow_candy"] ) {
        int ranNo = random()%2;
        
        if(ranNo == 0){
            soundFile = @"Tiggly_Word_Candy_01";
        }else if (ranNo == 1) {
            soundFile = @"Tiggly_Word_Candy_Mmm_01";
        }
        
    }else if([fallObject isEqualToString:@"green_leaf"] || [fallObject isEqualToString:@"orange_leaf"]|| [fallObject isEqualToString:@"yellow_leaf"]|| [fallObject isEqualToString:@"pink_leaf"]|| [fallObject isEqualToString:@"green_leaf_2"] || [fallObject isEqualToString:@"orange_leaf_2"]) {
        int ranNo = random()%2;
        
        if(ranNo == 0){
            soundFile = @"Tiggly_Word_Leaf_01";
        }else if (ranNo == 1) {
            soundFile = @"Tiggly_Word_Leaf_Wow_01";
        }
        
    }else if([fallObject isEqualToString:@"haybale"] ) {
        int ranNo = random()%2;
        
        if(ranNo == 0){
            soundFile = @"Tiggly_Word_Haybale_01";
        }else if (ranNo == 1) {
            soundFile = @"Tiggly_Word_Haybale_Oh_01";
        }
        
    }else if([fallObject isEqualToString:@"pirate"] ) {
        int ranNo = random()%2;
        
        if(ranNo == 0){
            soundFile = @"Tiggly_Word_Shirt_01";
        }else if (ranNo == 1) {
            soundFile = @"Tiggly_Word_Shirt_Gasp_01";
        }
        
    } else if([fallObject isEqualToString:@"spider"]) {
        int ranNo = random()%2;
        
        if(ranNo == 0){
            soundFile = @"Tiggly_Word_Spider_Ooh_01";
        }else if (ranNo == 1) {
            soundFile = @"Tiggly_Word_Spider_Ooh_01";
        }
        
    }else if([fallObject isEqualToString:@"purple_spirder"] ) {
        int ranNo = random()%4;
        
        if(ranNo == 0){
            soundFile = @"Tiggly_GenGreeting_Fly_01";
        }else if (ranNo == 1) {
            soundFile = @"Tiggly_GenGreeting_Fly_02";
        }else if (ranNo == 2) {
            soundFile = @"Tiggly_GenGreeting_Fly_04";
        }else if (ranNo == 3) {
            soundFile = @"Tiggly_GenGreeting_Fly_07";
        }
        
    }else if([fallObject isEqualToString:@"hampster"]) {
        int ranNo = random()%5;
        
        if(ranNo == 0){
            soundFile = @"Tiggly_GenGreeting_Hamster_01";
        }else if (ranNo == 1) {
            soundFile = @"Tiggly_GenGreeting_Hamster_05";
        }else if (ranNo == 2) {
            soundFile = @"Tiggly_GenGreeting_Hamster_06";
        }else if (ranNo == 3) {
            soundFile = @"Tiggly_GenGreeting_Hamster_07";
        }else if (ranNo == 4) {
            soundFile = @"Tiggly_GenGreeting_Hamster_08";
        }
        
    }else if([fallObject isEqualToString:@"rooster"] || [fallObject isEqualToString:@"rooster_2"]) {
        int ranNo = random()%6;
        
        if(ranNo == 0){
            soundFile = @"Tiggly_GenGreeting_Rooster_01";
        }else if (ranNo == 1) {
            soundFile = @"Tiggly_GenGreeting_Rooster_02";
        }else if (ranNo == 2) {
            soundFile = @"Tiggly_GenGreeting_Rooster_03";
        }else if (ranNo == 3) {
            soundFile = @"Tiggly_GenGreeting_Rooster_04";
        }else if (ranNo == 4) {
            soundFile = @"Tiggly_GenGreeting_Rooster_05";
        }else if (ranNo == 5) {
            soundFile = @"Tiggly_GenGreeting_Rooster_06";
        }
        
    }else if([fallObject isEqualToString:@"scare_crow"]) {
        int ranNo = random()%7;
        
        if(ranNo == 0){
            soundFile = @"Tiggly_GenGreeting_Scarecrow_02";
        }else if (ranNo == 1) {
            soundFile = @"Tiggly_GenGreeting_Scarecrow_03";
        }else if (ranNo == 2) {
            soundFile = @"Tiggly_GenGreeting_Scarecrow_05";
        }else if (ranNo == 3) {
            soundFile = @"Tiggly_GenGreeting_Scarecrow_06";
        }else if (ranNo == 4) {
            soundFile = @"Tiggly_GenGreeting_Scarecrow_07";
        }else if (ranNo == 5) {
            soundFile = @"Tiggly_GenGreeting_Scarecrow_08";
        }else if (ranNo == 6) {
            soundFile = @"Tiggly_GenGreeting_Scarecrow_10";
        }
        
    }else if([fallObject isEqualToString:@"bee"]) {
        int ranNo = random()%4;
        
        if(ranNo == 0){
            soundFile = @"Tiggly_GenGreeting_Bee_01";
        }else if (ranNo == 1) {
            soundFile = @"Tiggly_GenGreeting_Bee_02";
        }else if (ranNo == 2) {
            soundFile = @"Tiggly_GenGreeting_Bee_03";
        }else if (ranNo == 3) {
            soundFile = @"Tiggly_GenGreeting_Bee_05";
        }
        
    }else if([fallObject isEqualToString:@"broom"]) {
        int ranNo = random()%2;
        
        if(ranNo == 0){
            soundFile = @"Tiggly_Word_Broom_01";
        }else if (ranNo == 1) {
            soundFile = @"Tiggly_Word_Broom_Ooh_01";
        }
        
    }else if([fallObject isEqualToString:@"duck_1"]) {
        int ranNo = random()%2;
        
        if(ranNo == 0){
            soundFile = @"Tiggly_GenGreeting_Duck_01";
        }else if (ranNo == 1) {
            soundFile = @"Tiggly_GenGreeting_Duck_02";
        }
        
    }else if([fallObject isEqualToString:@"horse"]) {
        int ranNo = random()%4;
        
        if(ranNo == 0){
            soundFile = @"Tiggly_GenGreeting_Donkey_01";
        }else if (ranNo == 1) {
            soundFile = @"Tiggly_GenGreeting_Donkey_02";
        }else if (ranNo == 2) {
            soundFile = @"Tiggly_GenGreeting_Donkey_05";
        }else if (ranNo == 3) {
            soundFile = @"Tiggly_GenGreeting_Donkey_06";
        }
        
    }else if([fallObject isEqualToString:@"leaves"]|| [fallObject isEqualToString:@"cranberries_leaves"]) {
        int ranNo = random()%2;
        
        if(ranNo == 0){
            soundFile = @"Tiggly_Word_Leaves_01";
        }else if (ranNo == 1) {
            soundFile = @"Tiggly_Word_Leaves_Ooh_01";
        }
        
    }else if([fallObject isEqualToString:@"mushroom"]) {
        int ranNo = random()%2;
        
        if(ranNo == 0){
            soundFile = @"Tiggly_Word_Mushroom_01";
        }else if (ranNo == 1) {
            soundFile = @"Tiggly_Word_Mushroom_Wow_01";
        }
        
    }else if([fallObject isEqualToString:@"pear"]) {
        int ranNo = random()%2;
        
        if(ranNo == 0){
            soundFile = @"Tiggly_Word_Pear_01";
        }else if (ranNo == 1) {
            soundFile = @"Tiggly_Word_Pear_Ooh_01";
        }
        
    }else if([fallObject isEqualToString:@"raincoat"]) {
        int ranNo = random()%2;
        
        if(ranNo == 0){
            soundFile = @"Tiggly_Word_Raincoat_01";
        }else if (ranNo == 1) {
            soundFile = @"Tiggly_Word_Raincoat_Ah_01";
        }
        
    }else if([fallObject isEqualToString:@"zebra_2"]) {
        int ranNo = random()%6;
        
        if(ranNo == 0){
            soundFile = @"Tiggly_GenGreeting_Zebra_01";
        }else if (ranNo == 1) {
            soundFile = @"Tiggly_GenGreeting_Zebra_02";
        }else if (ranNo == 2) {
            soundFile = @"Tiggly_GenGreeting_Zebra_03";
        }else if (ranNo == 3) {
            soundFile = @"Tiggly_GenGreeting_Zebra_04";
        }else if (ranNo == 4) {
            soundFile = @"Tiggly_GenGreeting_Zebra_06";
        }else if (ranNo == 5) {
            soundFile = @"Tiggly_GenGreeting_Zebra_09";
        }
        
    }else if([fallObject isEqualToString:@"witches_hat"] || [fallObject isEqualToString:@"witches_hat_purple"]) {
        int ranNo = random()%4;
        
        if(ranNo == 0){
            soundFile = @"Tiggly_Word_Hat_Gasp_01";
        }else if (ranNo == 1) {
            soundFile = @"Tiggly_Word_Hat_Ooh_01";
        }else if (ranNo == 2) {
            soundFile = @"Tiggly_Word_Hat_Wow_01";
        }else if (ranNo == 3) {
            soundFile = @"Tiggly_Word_Hat_Wow_02";
        }
        
    }    

    return soundFile;
}

-(NSString *) getAnimalDropSoundForObject:(NSString *) fallObject{
    DebugLog(@"");
    
    NSString *soundFile;
    
    if([fallObject isEqualToString:@"apple_red"] || [fallObject isEqualToString:@"green_apple"]) {
        
        
        
        int ranNo = random()%4;
        
        if(ranNo == 0){
            soundFile = @"Tiggly_SFX_DragNDrop_DROP_01";
        }else if (ranNo == 1) {
            soundFile = @"Tiggly_SFX_DragNDrop_DROP_02";
        }else if (ranNo == 2) {
            soundFile = @"Tiggly_SFX_DragNDrop_DROP_03";
        }else if (ranNo == 3) {
            soundFile = @"Tiggly_SFX_DragNDrop_DROP_04";
        }
        
    }else if([fallObject isEqualToString:@"blue_turkey"] || [fallObject isEqualToString:@"orange_turkey"]) {
        int ranNo = random()%7;
        
        if(ranNo == 0){
            soundFile = @"Tiggly_GenGreeting_Turkey_01";
        }else if (ranNo == 1) {
            soundFile = @"Tiggly_GenGreeting_Turkey_02";
        }else if (ranNo == 2) {
            soundFile = @"Tiggly_GenGreeting_Turkey_03";
        }else if (ranNo == 3) {
            soundFile = @"Tiggly_GenGreeting_Turkey_05";
        }else if (ranNo == 4) {
            soundFile = @"Tiggly_GenGreeting_Turkey_06";
        }else if (ranNo == 5) {
            soundFile = @"Tiggly_GenGreeting_Turkey_07";
        }else if (ranNo == 6) {
            soundFile = @"Tiggly_GenGreeting_Turkey_08";
        }
        
    }else if([fallObject isEqualToString:@"cranberries"]|| [fallObject isEqualToString:@"cranberries_leaves"]) {
        int ranNo = random()%4;
        
        if(ranNo == 0){
            soundFile = @"Tiggly_SFX_DragNDrop_DROP_01";
        }else if (ranNo == 1) {
            soundFile = @"Tiggly_SFX_DragNDrop_DROP_02";
        }else if (ranNo == 2) {
            soundFile = @"Tiggly_SFX_DragNDrop_DROP_03";
        }else if (ranNo == 3) {
            soundFile = @"Tiggly_SFX_DragNDrop_DROP_04";
        }
        
    }else if([fallObject isEqualToString:@"greyish_cat"] || [fallObject isEqualToString:@"pink_cat"]|| [fallObject isEqualToString:@"cat"]) {
        int ranNo = random()%8;
        
        if(ranNo == 0){
            soundFile = @"Tiggly_GenGreeting_Cat_01";
        }else if (ranNo == 1) {
            soundFile = @"Tiggly_GenGreeting_Cat_02";
        }else if (ranNo == 2) {
            soundFile = @"Tiggly_GenGreeting_Cat_03";
        }else if (ranNo == 3) {
            soundFile = @"Tiggly_GenGreeting_Cat_04";
        }else if (ranNo == 4) {
            soundFile = @"Tiggly_GenGreeting_Cat_05";
        }else if (ranNo == 5) {
            soundFile = @"Tiggly_GenGreeting_Cat_06";
        }else if (ranNo == 6) {
            soundFile = @"Tiggly_GenGreeting_Cat_08";
        }else if (ranNo == 7) {
            soundFile = @"Tiggly_GenGreeting_Cat_09";
        }
        
    }else if([fallObject isEqualToString:@"litepurple_racoon"] || [fallObject isEqualToString:@"racoon"]) {
        int ranNo = random()%9;
        
        if(ranNo == 0){
            soundFile = @"Tiggly_GenGreeting_Raccoon_01";
        }else if (ranNo == 1) {
            soundFile = @"Tiggly_GenGreeting_Raccoon_03";
        }else if (ranNo == 2) {
            soundFile = @"Tiggly_GenGreeting_Raccoon_04";
        }else if (ranNo == 3) {
            soundFile = @"Tiggly_GenGreeting_Raccoon_05";
        }else if (ranNo == 4) {
            soundFile = @"Tiggly_GenGreeting_Raccoon_06";
        }else if (ranNo == 5) {
            soundFile = @"Tiggly_GenGreeting_Raccoon_07";
        }else if (ranNo == 6) {
            soundFile = @"Tiggly_GenGreeting_Raccoon_08";
        }else if (ranNo == 7) {
            soundFile = @"Tiggly_GenGreeting_Raccoon_12";
        }else if (ranNo == 8) {
            soundFile = @"Tiggly_GenGreeting_Raccoon_13";
        }
        
    }else if([fallObject isEqualToString:@"pumkin_1"] || [fallObject isEqualToString:@"pumpkin_3"]|| [fallObject isEqualToString:@"pumkin_bag"] ) {
        int ranNo = random()%7;
        
        if(ranNo == 0){
            soundFile = @"Tiggly_GenGreeting_Pumpkin_01";
        }else if (ranNo == 1) {
            soundFile = @"Tiggly_GenGreeting_Pumpkin_02";
        }else if (ranNo == 2) {
            soundFile = @"Tiggly_GenGreeting_Pumpkin_04";
        }else if (ranNo == 3) {
            soundFile = @"Tiggly_GenGreeting_Pumpkin_05";
        }else if (ranNo == 4) {
            soundFile = @"Tiggly_GenGreeting_Pumpkin_06";
        }else if (ranNo == 5) {
            soundFile = @"Tiggly_GenGreeting_Pumpkin_07";
        }else if (ranNo == 6) {
            soundFile = @"Tiggly_GenGreeting_Pumpkin_08";
        }
        
    }else if([fallObject isEqualToString:@"barn_2"] ) {
        int ranNo = random()%4;
        
        if(ranNo == 0){
            soundFile = @"Tiggly_SFX_DragNDrop_DROP_01";
        }else if (ranNo == 1) {
            soundFile = @"Tiggly_SFX_DragNDrop_DROP_02";
        }else if (ranNo == 2) {
            soundFile = @"Tiggly_SFX_DragNDrop_DROP_03";
        }else if (ranNo == 3) {
            soundFile = @"Tiggly_SFX_DragNDrop_DROP_04";
        }
    }else if([fallObject isEqualToString:@"bat"]) {
        int ranNo = random()%4;
        
        if(ranNo == 0){
            soundFile = @"Tiggly_GenGreeting_Bat_02";
        }else if (ranNo == 1) {
            soundFile = @"Tiggly_GenGreeting_Bat_03";
        }
        
    }else if([fallObject isEqualToString:@"blue_candy"] || [fallObject isEqualToString:@"orange_candy"]|| [fallObject isEqualToString:@"yellow_candy"] ) {
        int ranNo = random()%4;
        
        if(ranNo == 0){
            soundFile = @"Tiggly_SFX_DragNDrop_DROP_01";
        }else if (ranNo == 1) {
            soundFile = @"Tiggly_SFX_DragNDrop_DROP_02";
        }else if (ranNo == 2) {
            soundFile = @"Tiggly_SFX_DragNDrop_DROP_03";
        }else if (ranNo == 3) {
            soundFile = @"Tiggly_SFX_DragNDrop_DROP_04";
        }
        
    }else if([fallObject isEqualToString:@"green_leaf"] || [fallObject isEqualToString:@"orange_leaf"]|| [fallObject isEqualToString:@"yellow_leaf"]|| [fallObject isEqualToString:@"pink_leaf"]|| [fallObject isEqualToString:@"green_leaf_2"] || [fallObject isEqualToString:@"orange_leaf_2"]) {
        int ranNo = random()%4;
        
        if(ranNo == 0){
            soundFile = @"Tiggly_SFX_DragNDrop_DROP_01";
        }else if (ranNo == 1) {
            soundFile = @"Tiggly_SFX_DragNDrop_DROP_02";
        }else if (ranNo == 2) {
            soundFile = @"Tiggly_SFX_DragNDrop_DROP_03";
        }else if (ranNo == 3) {
            soundFile = @"Tiggly_SFX_DragNDrop_DROP_04";
        }
        
    }else if([fallObject isEqualToString:@"haybale"] ) {
        int ranNo = random()%4;
        
        if(ranNo == 0){
            soundFile = @"Tiggly_SFX_DragNDrop_DROP_01";
        }else if (ranNo == 1) {
            soundFile = @"Tiggly_SFX_DragNDrop_DROP_02";
        }else if (ranNo == 2) {
            soundFile = @"Tiggly_SFX_DragNDrop_DROP_03";
        }else if (ranNo == 3) {
            soundFile = @"Tiggly_SFX_DragNDrop_DROP_04";
        }
        
    }else if([fallObject isEqualToString:@"pirate"] ) {
        int ranNo = random()%4;
        
        if(ranNo == 0){
            soundFile = @"Tiggly_SFX_DragNDrop_DROP_01";
        }else if (ranNo == 1) {
            soundFile = @"Tiggly_SFX_DragNDrop_DROP_02";
        }else if (ranNo == 2) {
            soundFile = @"Tiggly_SFX_DragNDrop_DROP_03";
        }else if (ranNo == 3) {
            soundFile = @"Tiggly_SFX_DragNDrop_DROP_04";
        }
        
    }else if([fallObject isEqualToString:@"spider"]) {
        int ranNo = random()%2;
        
        if(ranNo == 0){
            soundFile = @"Tiggly_GenGreeting_spider_01";
        }else if (ranNo == 1) {
            soundFile = @"Tiggly_GenGreeting_spider_01";
        }
        
    }else if([fallObject isEqualToString:@"purple_spirder"] ) {
        int ranNo = random()%3;
        
        if(ranNo == 0){
            soundFile = @"Tiggly_GenGreeting_Fly_03";
        }else if (ranNo == 1) {
            soundFile = @"Tiggly_GenGreeting_Fly_05";
        }else if (ranNo == 2) {
            soundFile = @"Tiggly_GenGreeting_Fly_06";
        }
        
    }else if([fallObject isEqualToString:@"hampster"]) {
        int ranNo = random()%4;
        
        if(ranNo == 0){
            soundFile = @"Tiggly_GenGreeting_Hamster_02";
        }else if (ranNo == 1) {
            soundFile = @"Tiggly_GenGreeting_Hamster_03";
        }else if (ranNo == 2) {
            soundFile = @"Tiggly_GenGreeting_Hamster_04";
        }else if (ranNo == 3) {
            soundFile = @"Tiggly_GenGreeting_Hamster_06";
        }
        
    }else if([fallObject isEqualToString:@"rooster"] || [fallObject isEqualToString:@"rooster_2"]) {
        int ranNo = random()%4;
        
        if(ranNo == 0){
            soundFile = @"Tiggly_GenGreeting_Rooster_02";
        }else if (ranNo == 1) {
            soundFile = @"Tiggly_GenGreeting_Rooster_03";
        }else if (ranNo == 2) {
            soundFile = @"Tiggly_GenGreeting_Rooster_04";
        }else if (ranNo == 3) {
            soundFile = @"Tiggly_GenGreeting_Rooster_05";
        }
        
    }else if([fallObject isEqualToString:@"scare_crow"]) {
        int ranNo = random()%5;
        
        if(ranNo == 0){
            soundFile = @"Tiggly_GenGreeting_Scarecrow_03";
        }else if (ranNo == 1) {
            soundFile = @"Tiggly_GenGreeting_Scarecrow_05";
        }else if (ranNo == 2) {
            soundFile = @"Tiggly_GenGreeting_Scarecrow_06";
        }else if (ranNo == 3) {
            soundFile = @"Tiggly_GenGreeting_Scarecrow_07";
        }else if (ranNo == 4) {
            soundFile = @"Tiggly_GenGreeting_Scarecrow_09";
        }
        
    }else if([fallObject isEqualToString:@"bee"]) {
        int ranNo = random()%1;
        
        if(ranNo == 0){
            soundFile = @"Tiggly_GenGreeting_Bee_04";
        }
        
    }else if([fallObject isEqualToString:@"broom"]) {
        int ranNo = random()%4;
        
        if(ranNo == 0){
            soundFile = @"Tiggly_SFX_DragNDrop_DROP_01";
        }else if (ranNo == 1) {
            soundFile = @"Tiggly_SFX_DragNDrop_DROP_02";
        }else if (ranNo == 2) {
            soundFile = @"Tiggly_SFX_DragNDrop_DROP_03";
        }else if (ranNo == 3) {
            soundFile = @"Tiggly_SFX_DragNDrop_DROP_04";
        }
        
    }else if([fallObject isEqualToString:@"duck_1"]) {
        int ranNo = random()%2;
        
        if(ranNo == 0){
            soundFile = @"Tiggly_GenGreeting_Duck_03";
        }else if (ranNo == 1) {
            soundFile = @"Tiggly_GenGreeting_Duck_03";
        }
        
    }else if([fallObject isEqualToString:@"horse"]) {
        int ranNo = random()%2;
        
        if(ranNo == 0){
            soundFile = @"Tiggly_GenGreeting_Donkey_03";
        }else if (ranNo == 1) {
            soundFile = @"Tiggly_GenGreeting_Donkey_04";
        }
        
    }else if([fallObject isEqualToString:@"leaves"]) {
        int ranNo = random()%4;
        
        if(ranNo == 0){
            soundFile = @"Tiggly_SFX_DragNDrop_DROP_01";
        }else if (ranNo == 1) {
            soundFile = @"Tiggly_SFX_DragNDrop_DROP_02";
        }else if (ranNo == 2) {
            soundFile = @"Tiggly_SFX_DragNDrop_DROP_03";
        }else if (ranNo == 3) {
            soundFile = @"Tiggly_SFX_DragNDrop_DROP_04";
        }
        
    }else if([fallObject isEqualToString:@"mushroom"]) {
        int ranNo = random()%4;
        
        if(ranNo == 0){
            soundFile = @"Tiggly_SFX_DragNDrop_DROP_01";
        }else if (ranNo == 1) {
            soundFile = @"Tiggly_SFX_DragNDrop_DROP_02";
        }else if (ranNo == 2) {
            soundFile = @"Tiggly_SFX_DragNDrop_DROP_03";
        }else if (ranNo == 3) {
            soundFile = @"Tiggly_SFX_DragNDrop_DROP_04";
        }
        
    }else if([fallObject isEqualToString:@"pear"]) {
        int ranNo = random()%4;
        
        if(ranNo == 0){
            soundFile = @"Tiggly_SFX_DragNDrop_DROP_01";
        }else if (ranNo == 1) {
            soundFile = @"Tiggly_SFX_DragNDrop_DROP_02";
        }else if (ranNo == 2) {
            soundFile = @"Tiggly_SFX_DragNDrop_DROP_03";
        }else if (ranNo == 3) {
            soundFile = @"Tiggly_SFX_DragNDrop_DROP_04";
        }
    }else if([fallObject isEqualToString:@"raincoat"]) {
        int ranNo = random()%4;
        
        if(ranNo == 0){
            soundFile = @"Tiggly_SFX_DragNDrop_DROP_01";
        }else if (ranNo == 1) {
            soundFile = @"Tiggly_SFX_DragNDrop_DROP_02";
        }else if (ranNo == 2) {
            soundFile = @"Tiggly_SFX_DragNDrop_DROP_03";
        }else if (ranNo == 3) {
            soundFile = @"Tiggly_SFX_DragNDrop_DROP_04";
        }
    }else if([fallObject isEqualToString:@"zebra_2"]) {
        int ranNo = random()%3;
        
        if(ranNo == 0){
            soundFile = @"Tiggly_GenGreeting_Zebra_05";
        }else if (ranNo == 1) {
            soundFile = @"Tiggly_GenGreeting_Zebra_07";
        }else if (ranNo == 2) {
            soundFile = @"Tiggly_GenGreeting_Zebra_08";
        }
        
    }else if([fallObject isEqualToString:@"witches_hat"] || [fallObject isEqualToString:@"witches_hat_purple"]) {
        int ranNo = random()%4;
        
        if(ranNo == 0){
            soundFile = @"Tiggly_SFX_DragNDrop_DROP_01";
        }else if (ranNo == 1) {
            soundFile = @"Tiggly_SFX_DragNDrop_DROP_02";
        }else if (ranNo == 2) {
            soundFile = @"Tiggly_SFX_DragNDrop_DROP_03";
        }else if (ranNo == 3) {
            soundFile = @"Tiggly_SFX_DragNDrop_DROP_04";
        }
    }
    
    return soundFile;
}

@end
