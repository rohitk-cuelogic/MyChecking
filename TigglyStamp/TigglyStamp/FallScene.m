//
//  FallScene.m
//  TigglyStamp
//
//  Created by Sachin Patil on 30/07/13.
//  Copyright (c) 2013 cuelogic. All rights reserved.
//

#import "FallScene.h"
#import "TigglyStampUtils.h"

@implementation FallScene {
    
    NSMutableArray *fallSquareObjects;
    NSMutableArray *fallTriangleObjects;
    NSMutableArray *fallStarObjects;
    NSMutableArray *fallCircleObjects;
    int currentObject;
}



#pragma mark -
#pragma mark =======================================
#pragma mark Init
#pragma mark =======================================

- (id)init{
    DebugLog(@"");
    self = [super init];
    if (self) {

        fallSquareObjects = [[NSMutableArray alloc] initWithObjects:
                             @"bat",
                             @"blue_candy",
                             @"green_leaf",
                             @"haybale",
                             @"orange_candy",
                             @"orange_leaf",
                             @"purple_spirder",
                             @"spider",
                             @"yellow_candy",
                             @"pirate",
                             @"barn_2",nil];
        
        fallTriangleObjects = [[NSMutableArray alloc] initWithObjects:
                               @"bee",
                               @"broom",
                               @"horse",
                               @"leaves",
                               @"mushroom",
                               @"pear",
                               @"raincoat",
                               @"three_color",
                               @"witches_hat_purple",
                               @"witches_hat",
                               @"zebra_2",
                               @"duck_1",
                               @"pinkRaincoat",
                               @"orangeRaincoat",
                               @"yellowRaincoat",
                               @"rooster",
                               @"blue_jeans",
                               @"green_skirt",
                               @"khakis",
                               @"pink_skirt_fall",
                               @"purple_pants",
                               @"yellow_skirt",nil];
        
        fallCircleObjects = [[NSMutableArray alloc] initWithObjects:
                             @"apple_red",
                             @"blue_turkey",
                             @"cranberries_leaves",
                             @"cranberries",
                             @"green_apple",
                             @"greyish_cat",
                             @"litepurple_racoon",
                             @"orange_turkey",
                             @"pink_cat",
                             @"pumkin_1",
                             @"pumpkin_3",
                             @"racoon",nil];
        
        fallStarObjects = [[NSMutableArray alloc] initWithObjects:
                           @"green_leaf_2",
                           @"hampster",
                           @"orange_leaf_2",
                           @"pink_leaf",
                           @"scare_crow",
                           @"yellow_leaf",
                           @"chicken",nil];
        
      
    }
    return self;
}

#pragma mark -
#pragma mark =======================================
#pragma mark Helpers
#pragma mark =======================================

-(NSString *)getObjectForShape:(NSString *)shape {
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
            [fallTriangleObjects addObject:@"pinkRaincoat"];
            [fallTriangleObjects addObject:@"orangeRaincoat"];
            [fallTriangleObjects addObject:@"yellowRaincoat"];
            [fallTriangleObjects addObject:@"rooster"];
            [fallTriangleObjects addObject:@"blue_jeans"];
            [fallTriangleObjects addObject:@"green_skirt"];
            [fallTriangleObjects addObject:@"khakis"];
            [fallTriangleObjects addObject:@"pink_skirt_fall"];
            [fallTriangleObjects addObject:@"purple_pants"];
            [fallTriangleObjects addObject:@"yellow_skirt"];
            
            size = 22;
        }
        currentObject =  arc4random()%size;
        objectName = [fallTriangleObjects objectAtIndex:currentObject];
        DebugLog(@"fallTriangleObject: %@", objectName);
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
        DebugLog(@"fallCircleObject: %@", objectName);
        
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
        DebugLog(@"fallSquareObject: %@", objectName);
        
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
            [fallStarObjects addObject:@"chicken"];
            size = 7;
        }
        currentObject =  arc4random()%size;
        objectName = [fallStarObjects objectAtIndex:currentObject];
        DebugLog(@"fallStarObject: %@", objectName);
        
    }
    [self removeDrawnObject:objectName forShape:shape];
    return objectName;
}

-(void)removeDrawnObject:(NSString *)objectName forShape:(NSString *)shape{
    DebugLog(@"");
    
    //NSLog(@"Remove Object: %@",objectName);
    
    if([shape isEqualToString:@"triangle"]){
        //NSLog(@"Before: fallTriangleObjects: %@",fallTriangleObjects);
        [fallTriangleObjects removeObject:objectName];
        //NSLog(@"After: fallTriangleObjects: %@",fallTriangleObjects);
    }
    if([shape isEqualToString:@"square"]){
        //NSLog(@"Before: fallSquareObjects: %@",fallSquareObjects);
        [fallSquareObjects removeObject:objectName];
        //NSLog(@"After: fallSquareObjects: %@",fallSquareObjects);
    }
    if([shape isEqualToString:@"star"]){
        //NSLog(@"Before: fallStarObjects: %@",fallStarObjects);
        [fallStarObjects removeObject:objectName];
        //NSLog(@"After: fallStarObjects: %@",fallStarObjects);
    }
    if([shape isEqualToString:@"circle"]){
        //NSLog(@"Before: fallCircleObjects: %@",fallCircleObjects);
        [fallCircleObjects removeObject:objectName];
        //NSLog(@"After: fallCircleObjects: %@",fallCircleObjects);
    }
    
}

-(void)removeAllObjects{
    DebugLog(@"");
    [fallTriangleObjects removeAllObjects];
    [fallSquareObjects removeAllObjects];
    [fallStarObjects removeAllObjects];
    [fallCircleObjects removeAllObjects];
}

#pragma mark -
#pragma mark =======================================
#pragma mark Color Handling
#pragma mark =======================================

-(UIColor *)getRGBValueForShape:(NSString *)shapeToDraw{
    
    UIColor *color = nil;
    
    if ([shapeToDraw isEqualToString:@"bat"]) {
        color = [UIColor colorWithRed:153.0/255.0 green:144.0/255.0 blue:197.0/255.0 alpha:1];
    }
    if ([shapeToDraw isEqualToString:@"blue_candy"]) {
        color = [UIColor colorWithRed:0.0/255.0 green:170.0/255.0 blue:226.0/255.0 alpha:1];
    }
    if ([shapeToDraw isEqualToString:@"green_leaf"]) {
        color = [UIColor colorWithRed:95.0/255.0 green:129.0/255.0 blue:57.0/255.0 alpha:1];
    }
    if ([shapeToDraw isEqualToString:@"haybale"]) {
        color = [UIColor colorWithRed:224.0/255.0 green:169.0/255.0 blue:17.0/255.0 alpha:1];
    }
    if ([shapeToDraw isEqualToString:@"orange_candy"]) {
        color = [UIColor colorWithRed:241.0/255.0 green:128.0/255.0 blue:49.0/255.0 alpha:1];
    }
    if ([shapeToDraw isEqualToString:@"orange_leaf"]) {
        color = [UIColor colorWithRed:241.0/255.0 green:89.0/255.0 blue:34.0/255.0 alpha:1];
    }
    if ([shapeToDraw isEqualToString:@"purple_spirder"]) {
        color = [UIColor colorWithRed:217.0/255.0 green:215.0/255.0 blue:235.0/255.0 alpha:1];
    }
    if ([shapeToDraw isEqualToString:@"yellow_candy"]) {
        color = [UIColor colorWithRed:255.0/255.0 green:197.0/255.0 blue:14.0/255.0 alpha:1];
    }
    if ([shapeToDraw isEqualToString:@"spider"]) {
        color = [UIColor colorWithRed:125.0/255.0 green:107.0/255.0 blue:113.0/255.0 alpha:1];
    }
    if ([shapeToDraw isEqualToString:@"pirate"]) {
        color = [UIColor colorWithRed:235.0/255.0 green:39.0/255.0 blue:60.0/255.0 alpha:1];
    }
    if ([shapeToDraw isEqualToString:@"barn_2"]) {
        color = [UIColor colorWithRed:237.0/255.0 green:28.0/255.0 blue:36.0/255.0 alpha:1];
    }

    if ([shapeToDraw isEqualToString:@"bee"]) {
        color = [UIColor colorWithRed:255.0/255.0 green:222.0/255.0 blue:3.0/255.0 alpha:1];
    }
    if ([shapeToDraw isEqualToString:@"broom"]) {
        color = [UIColor colorWithRed:224.0/255.0 green:169.0/255.0 blue:17.0/255.0 alpha:1];
    }
    if ([shapeToDraw isEqualToString:@"horse"]) {
        color = [UIColor colorWithRed:217.0/255.0 green:215.0/255.0 blue:235.0/255.0 alpha:1];
    }
    if ([shapeToDraw isEqualToString:@"mushroom"]) {
        color = [UIColor colorWithRed:237.0/255.0 green:29.0/255.0 blue:36.0/255.0 alpha:1];
    }
    if ([shapeToDraw isEqualToString:@"leaves"]) {
        color = [UIColor colorWithRed:209.0/255.0 green:51.0/255.0 blue:35.0/255.0 alpha:1];
    }
    if ([shapeToDraw isEqualToString:@"pear"]) {
        color = [UIColor colorWithRed:255.0/255.0 green:175.0/255.0 blue:3.0/255.0 alpha:1];
    }
    if ([shapeToDraw isEqualToString:@"raincoat"]) {
        color = [UIColor colorWithRed:255.0/255.0 green:197.0/255.0 blue:14.0/255.0 alpha:1];
    }
    if ([shapeToDraw isEqualToString:@"pinkRaincoat"]) {
        color = [UIColor colorWithRed:255.0/255.0 green:103.0/255.0 blue:148.0/255.0 alpha:1];
    }
    if ([shapeToDraw isEqualToString:@"orangeRaincoat"]) {
        color = [UIColor colorWithRed:248.0/255.0 green:147.0/255.0 blue:29.0/255.0 alpha:1];
    }
    if ([shapeToDraw isEqualToString:@"yellowRaincoat"]) {
        color = [UIColor colorWithRed:248.0/255.0 green:235.0/255.0 blue:120.0/255.0 alpha:1];
    }
    if ([shapeToDraw isEqualToString:@"three_color"]) {
        color = [UIColor colorWithRed:254.0/255.0 green:208.0/255.0 blue:10.0/255.0 alpha:1];
    }
    if ([shapeToDraw isEqualToString:@"witches_hat_purple"]) {
        color = [UIColor colorWithRed:112.0/255.0 green:44.0/255.0 blue:143.0/255.0 alpha:1];
    }
    if ([shapeToDraw isEqualToString:@"witches_hat"]) {
        color = [UIColor colorWithRed:145.0/255.0 green:192.0/255.0 blue:75.0/255.0 alpha:1];
    }
    if ([shapeToDraw isEqualToString:@"zebra_2"]) {
        color = [UIColor colorWithRed:173.0/255.0 green:223.0/255.0 blue:234.0/255.0 alpha:1];
    }
    if ([shapeToDraw isEqualToString:@"duck_1"]) {
        color = [UIColor colorWithRed:249.0/255.0 green:160.0/255.0 blue:28.0/255.0 alpha:1];
    }
    if ([shapeToDraw isEqualToString:@"rooster"]) {
        color = [UIColor colorWithRed:234.0/255.0 green:109.0/255.0 blue:8.0/255.0 alpha:1];
    }
    if ([shapeToDraw isEqualToString:@"blue_jeans"]) {
        color = [UIColor colorWithRed:37.0/255.0 green:205.0/255.0 blue:211.0/255.0 alpha:1];
    }
    if ([shapeToDraw isEqualToString:@"green_skirt"]) {
        color = [UIColor colorWithRed:126.0/255.0 green:177.0/255.0 blue:2.0/255.0 alpha:1];
    }
    if ([shapeToDraw isEqualToString:@"khakis"]) {
        color = [UIColor colorWithRed:230.0/255.0 green:189.0/255.0 blue:125.0/255.0 alpha:1];
    }
    if ([shapeToDraw isEqualToString:@"pink_skirt_fall"]) {
        color = [UIColor colorWithRed:255.0/255.0 green:62.0/255.0 blue:126.0/255.0 alpha:1];
    }
    if ([shapeToDraw isEqualToString:@"purple_pants"]) {
        color = [UIColor colorWithRed:148.0/255.0 green:150.0/255.0 blue:213.0/255.0 alpha:1];
    }
    if ([shapeToDraw isEqualToString:@"yellow_skirt"]) {
        color = [UIColor colorWithRed:254.0/255.0 green:248.0/255.0 blue:212.0/255.0 alpha:1];
    }
    
    if ([shapeToDraw isEqualToString:@"apple_red"]) {
        color = [UIColor colorWithRed:237.0/255.0 green:28.0/255.0 blue:36.0/255.0 alpha:1];
    }
    if ([shapeToDraw isEqualToString:@"blue_turkey"]) {
        color = [UIColor colorWithRed:0.0/255.0 green:174.0/255.0 blue:239.0/255.0 alpha:1];
    }
    if ([shapeToDraw isEqualToString:@"cranberries_leaves"]) {
        color = [UIColor colorWithRed:215.0/255.0 green:26.0/255.0 blue:33.0/255.0 alpha:1];
    }
    if ([shapeToDraw isEqualToString:@"cranberries"]) {
        color = [UIColor colorWithRed:215.0/255.0 green:26.0/255.0 blue:33.0/255.0 alpha:1];
    }
    if ([shapeToDraw isEqualToString:@"green_apple"]) {
        color = [UIColor colorWithRed:145.0/255.0 green:192.0/255.0 blue:75.0/255.0 alpha:1];
    }
    if ([shapeToDraw isEqualToString:@"greyish_cat"]) {
        color = [UIColor colorWithRed:217.0/255.0 green:215.0/255.0 blue:235.0/255.0 alpha:1];
    }
    if ([shapeToDraw isEqualToString:@"litepurple_racoon"]) {
        color = [UIColor colorWithRed:153.0/255.0 green:144.0/255.0 blue:197.0/255.0 alpha:1];
    }
    if ([shapeToDraw isEqualToString:@"orange_turkey"]) {
        color = [UIColor colorWithRed:249.0/255.0 green:160.0/255.0 blue:28.0/255.0 alpha:1];
    }
    if ([shapeToDraw isEqualToString:@"pink_cat"]) {
        color = [UIColor colorWithRed:245.0/255.0 green:142.0/255.0 blue:129.0/255.0 alpha:1];
    }
    if ([shapeToDraw isEqualToString:@"pumkin_1"]) {
        color = [UIColor colorWithRed:223.0/255.0 green:129.0/255.0 blue:38.0/255.0 alpha:1];
    }
    if ([shapeToDraw isEqualToString:@"pumpkin_3"]) {
        color = [UIColor colorWithRed:223.0/255.0 green:129.0/255.0 blue:38.0/255.0 alpha:1];
    }
    if ([shapeToDraw isEqualToString:@"racoon"]) {
        color = [UIColor colorWithRed:171.0/255.0 green:73.0/255.0 blue:155.0/255.0 alpha:1];
    }
    
    if ([shapeToDraw isEqualToString:@"green_leaf_2"]) {
        color = [UIColor colorWithRed:145.0/255.0 green:192.0/255.0 blue:75.0/255.0 alpha:1];
    }
    if ([shapeToDraw isEqualToString:@"hampster"]) {
        color = [UIColor colorWithRed:247.0/255.0 green:148.0/255.0 blue:31.0/255.0 alpha:1];
    }
    if ([shapeToDraw isEqualToString:@"orange_leaf_2"]) {
        color = [UIColor colorWithRed:231.0/255.0 green:139.0/255.0 blue:29.0/255.0 alpha:1];
    }
    if ([shapeToDraw isEqualToString:@"pink_leaf"]) {
        color = [UIColor colorWithRed:245.0/255.0 green:142.0/255.0 blue:129.0/255.0 alpha:1];
    }
    if ([shapeToDraw isEqualToString:@"scare_crow"]) {
        color = [UIColor colorWithRed:0.0/255.0 green:170.0/255.0 blue:226.0/255.0 alpha:1];
    }
    if ([shapeToDraw isEqualToString:@"yellow_leaf"]) {
        color = [UIColor colorWithRed:255.0/255.0 green:222.0/255.0 blue:3.0/255.0 alpha:1];
    }
    if ([shapeToDraw isEqualToString:@"chicken"]) {
        color = [UIColor colorWithRed:251.0/255.0 green:242.0/255.0 blue:195.0/255.0 alpha:1];
    }

    return color;
}

#pragma mark -
#pragma mark =======================================
#pragma mark Sound Handling
#pragma mark =======================================


-(NSString *) getAnimalNameSoundForObject:(NSString *) fallObject{
    DebugLog(@"");
    
    NSString *soundFile = @"";
 
    if([fallObject isEqualToString:@"apple_red"]) {
        
        if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"English"]) {
            
            int ranNo = arc4random()%4;
            
            if(ranNo == 0){
                soundFile = @"Tiggly_Word_RedApple_Var2_03";
            }else if (ranNo == 1) {
                soundFile = @"Tiggly_Word_RedApple_Var2_02";
            }else if (ranNo == 2) {
                soundFile = @"Tiggly_Word_RedApple_Var2_01";
            }else if (ranNo == 3) {
                soundFile = @"Tiggly_Word_RedApple_01";
            }
            
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"English UK"]){
            soundFile = @"Apple_breng";
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"Portuguese"]){
            soundFile = @"Apple_prtgs";
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"Russian"]){
            soundFile = @"Apple_ru";
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"Spanish"]){
            soundFile = @"Apple_sp";
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"French"]){
            soundFile = @"Apple_fr";
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"German"]){
            soundFile = @"Apple_gr";
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"Italian"]){
            soundFile = @"Apple_ita";
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"Chinese"]){
            soundFile = @"Apple_ch";
        }
        
       
        
    }else if([fallObject isEqualToString:@"green_apple"]) {
        
        if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"English"]) {
            
            int ranNo = arc4random()%3;
            
            if(ranNo == 0){
                soundFile = @"Tiggly_Word_Greenapple_01";
            }else if (ranNo == 1) {
                soundFile = @"Tiggly_Word_Greenapple_Var2_03";
            }else if (ranNo == 2) {
                soundFile = @"Tiggly_Word_Greenapple_Var2_04";
            }
            
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"English UK"]){
            soundFile = @"Apple_breng";
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"Portuguese"]){
            soundFile = @"Apple_prtgs";
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"Russian"]){
            soundFile = @"Apple_ru";
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"Spanish"]){
            soundFile = @"Apple_sp";
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"French"]){
            soundFile = @"Apple_fr";
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"German"]){
            soundFile = @"Apple_gr";
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"Italian"]){
            soundFile = @"Apple_ita";
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"Chinese"]){
            soundFile = @"Apple_ch";
        }
        
        
        
    } else if([fallObject isEqualToString:@"blue_turkey"] || [fallObject isEqualToString:@"orange_turkey"]) {
    
        if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"English"]) {
        
            int ranNo = arc4random()%2;
        
            if(ranNo == 0){
                soundFile = @"Tiggly_GenGreeting_Turkey_01";
            }else if (ranNo == 1) {
                soundFile = @"Tiggly_GenGreeting_Turkey_05";
        }
            
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"English UK"]){
            soundFile = @"Turkey_01_breng";
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"Portuguese"]){
            soundFile = @"Turkey-01_prtgs";
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"Russian"]){
            soundFile = @"Turkey-01_ru";
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"Spanish"]){
            soundFile = @"Turkey-01_sp";
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"French"]){
            soundFile = @"turkey_fr";
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"German"]){
            soundFile = @"turkey_gr";
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"Italian"]){
            soundFile = @"turkey_ita";
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"Chinese"]){
            soundFile = @"Turkey_01_ch";
        }
        
        
    }else if([fallObject isEqualToString:@"cranberries"]|| [fallObject isEqualToString:@"cranberries_leaves"]) {
        if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"English"]) {
            
            int ranNo = arc4random()%2;
            
            if(ranNo == 0){
                soundFile = @"Tiggly_Word_Cranberries_01";
            }else if (ranNo == 1) {
                soundFile = @"Tiggly_Word_Cranberries_Oh_01";
            }
            
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"English UK"]){
            soundFile = @"cranberries_breng";
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"Portuguese"]){
            soundFile = @"cranberries_prtgs";
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"Russian"]){
            soundFile = @"cranberries_ru";
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"Spanish"]){
            soundFile = @"cranberries_sp";
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"French"]){
            soundFile = @"cranberries_fr";
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"German"]){
            soundFile = @"cranberries_gr";
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"Italian"]){
            soundFile = @"cranberries_ita";
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"Chinese"]){
            soundFile = @"cranberries_ch";
        }
        
        
    }else if([fallObject isEqualToString:@"greyish_cat"] || [fallObject isEqualToString:@"pink_cat"]|| [fallObject isEqualToString:@"cat"]) {
        
        if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"English"]) {
           soundFile = @"Tiggly_GenGreeting_Cat_07";
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"English UK"]){
            soundFile = @"cat_breng";
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"Portuguese"]){
            soundFile = @"cat_prtgs";
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"Russian"]){
            soundFile = @"cat_ru";
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"Spanish"]){
            soundFile = @"cat_sp";
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"French"]){
            soundFile = @"cat_fr";
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"German"]){
            soundFile = @"cat_gr";
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"Italian"]){
            soundFile = @"cat_ita";
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"Chinese"]){
            soundFile = @"cat_ch";
        }
        
        
        
    }else if([fallObject isEqualToString:@"litepurple_racoon"] || [fallObject isEqualToString:@"racoon"]) {
       
        
        if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"English"]) {
            
            int ranNo = arc4random()%4;
            
            if(ranNo == 0){
                soundFile = @"Tiggly_GenGreeting_Raccoon_02";
            }else if (ranNo == 1) {
                soundFile = @"Tiggly_GenGreeting_Raccoon_09";
            }else if (ranNo == 2) {
                soundFile = @"Tiggly_GenGreeting_Raccoon_10";
            }else if (ranNo == 3) {
                soundFile = @"Tiggly_GenGreeting_Raccoon_11";
            }

            
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"English UK"]){
            soundFile = @"racoon_breng";
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"Portuguese"]){
            soundFile = @"racoon_prtgs";
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"Russian"]){
            soundFile = @"racoon_ru";
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"Spanish"]){
            soundFile = @"racoon_sp";
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"French"]){
            soundFile = @"racoon_fr";
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"German"]){
            soundFile = @"racoon_gr";
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"Italian"]){
            soundFile = @"racoon_ita";
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"Chinese"]){
            soundFile = @"racoon_ch";
        }
        
        
               
    }
    else if([fallObject isEqualToString:@"pumpkin_3"]) {
        if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"English"]) {
            soundFile = @"Tiggly_GenGreeting_JackOLantern_06";
        }else{
            //soundFile = @"Tiggly_GenGreeting_JackOLantern_06";
        }
    }
    
    else if([fallObject isEqualToString:@"pumkin_1"] || [fallObject isEqualToString:@"pumkin_bag"] ) {
        
        if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"English"]) {
            
            int ranNo = arc4random()%7;
            
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
            
            
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"English UK"]){
            soundFile = @"pumkin_breng";
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"Portuguese"]){
            soundFile = @"pumkin_prtgs";
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"Russian"]){
            soundFile = @"pumkin_ru";
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"Spanish"]){
            soundFile = @"pumkin_sp";
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"French"]){
            soundFile = @"pumkin_fr";
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"German"]){
            soundFile = @"pumkin_gr";
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"Italian"]){
            soundFile = @"pumkin_ita";
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"Chinese"]){
            soundFile = @"pumkin_ch";
        }

        
        
        
    }else if([fallObject isEqualToString:@"barn_2"] ) {
        
        if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"English"]) {
            
            int ranNo = arc4random()%2;
            
            if(ranNo == 0){
                soundFile = @"Tiggly_Word_Barn_01";
            }else if (ranNo == 1) {
                soundFile = @"Tiggly_Word_Barn_Wow_01";
            }

            
            
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"English UK"]){
            soundFile = @"barn_breng";
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"Portuguese"]){
            soundFile = @"barn_prtgs";
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"Russian"]){
            soundFile = @"barn_ru";
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"Spanish"]){
            soundFile = @"barn_sp";
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"French"]){
            soundFile = @"barn_fr";
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"German"]){
            soundFile = @"barn_gr";
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"Italian"]){
            soundFile = @"barn_ita";
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"Chinese"]){
            soundFile = @"barn_ch";
        }
        
              
    }else if([fallObject isEqualToString:@"bat"]) {
        
        if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"English"]) {
            
            int ranNo = arc4random()%6;
            
            if(ranNo == 0){
                soundFile = @"Tiggly_GenGreeting_Bat_01";
            }else if (ranNo == 1) {
                soundFile = @"Tiggly_GenGreeting_Bat_02";
            }else if (ranNo == 2) {
                soundFile = @"Tiggly_GenGreeting_Bat_03";
            }else if (ranNo == 3) {
                soundFile = @"Tiggly_GenGreeting_Bat_04";
            }else if (ranNo == 4) {
                soundFile = @"Tiggly_Animal_Bat_ImAFriendlyBat_01";
            }else if (ranNo == 5) {
                soundFile = @"Tiggly_Animal_Bat_ImAFriendlyBat_02";
            }
            
            
            
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"English UK"]){
            soundFile = @"bat_breng";
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"Portuguese"]){
            soundFile = @"bat_prtgs";
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"Russian"]){
            soundFile = @"bat_ru";
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"Spanish"]){
            soundFile = @"bat_sp";
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"French"]){
            soundFile = @"bat_fr";
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"German"]){
            soundFile = @"bat_gr";
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"Italian"]){
            soundFile = @"bat_ita";
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"Chinese"]){
            soundFile = @"bat_ch";
        }
        
       
        
    }else if([fallObject isEqualToString:@"blue_candy"] || [fallObject isEqualToString:@"orange_candy"]|| [fallObject isEqualToString:@"yellow_candy"] ) {
       
        
        if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"English"]) {
            int ranNo = arc4random()%2;
            if(ranNo == 0){
                soundFile = @"Tiggly_Word_Candy_01";
            }else if (ranNo == 1) {
                soundFile = @"Tiggly_Word_Candy_Mmm_01";
            }

        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"English UK"]){
            soundFile = @"candy_breng";
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"Portuguese"]){
            soundFile = @"candy_prtgs";
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"Russian"]){
            soundFile = @"candy_ru";
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"Spanish"]){
            soundFile = @"candy_sp";
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"French"]){
            soundFile = @"candy_fr";
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"German"]){
            soundFile = @"candy_gr";
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"Italian"]){
            soundFile = @"candy_ita";
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"Chinese"]){
            soundFile = @"candy_ch";
        }
        
               
    }else if([fallObject isEqualToString:@"green_leaf"] || [fallObject isEqualToString:@"orange_leaf"]|| [fallObject isEqualToString:@"yellow_leaf"]|| [fallObject isEqualToString:@"pink_leaf"]|| [fallObject isEqualToString:@"green_leaf_2"] || [fallObject isEqualToString:@"orange_leaf_2"]) {
        
        
        if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"English"]) {
            
            
            int ranNo = arc4random()%2;
            
            if(ranNo == 0){
                soundFile = @"Tiggly_Word_Leaf_01";
            }else if (ranNo == 1) {
                soundFile = @"Tiggly_Word_Leaf_Wow_01";
            }
            
            
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"English UK"]){
            soundFile = @"leaf_breng";
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"Portuguese"]){
            soundFile = @"leaf_prtgs";
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"Russian"]){
            soundFile = @"leaf_ru";
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"Spanish"]){
            soundFile = @"leaf_sp";
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"French"]){
            soundFile = @"leaf_fr";
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"German"]){
            soundFile = @"leaf_gr";
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"Italian"]){
            soundFile = @"leaf_ita";
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"Chinese"]){
            soundFile = @"leaf_ch";
        }
        
        
        
        
    }else if([fallObject isEqualToString:@"haybale"] ) {
        if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"English"]) {
            
            int ranNo = arc4random()%2;
            
            if(ranNo == 0){
                soundFile = @"Tiggly_Word_Haybale_01";
            }else if (ranNo == 1) {
                soundFile = @"Tiggly_Word_Haybale_Oh_01";
            }
            
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"English UK"]){
            soundFile = @"haybale_breng";
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"Portuguese"]){
            soundFile = @"haybale_prtgs";
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"Russian"]){
            soundFile = @"haybale_ru";
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"Spanish"]){
            soundFile = @"haybale_sp";
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"French"]){
            soundFile = @"haybale_fr";
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"German"]){
            soundFile = @"haybale_gr";
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"Italian"]){
            soundFile = @"haybale_ita";
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"Chinese"]){
            soundFile = @"haybale_ch";
        }
        
              
    }else if([fallObject isEqualToString:@"pirate"] ) {
       
        if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"English"]) {
            
            int ranNo = arc4random()%2;
            
            if(ranNo == 0){
                soundFile = @"Tiggly_Word_Shirt_01";
            }else if (ranNo == 1) {
                soundFile = @"Tiggly_Word_Shirt_Gasp_01";
            }
            
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"English UK"]){
            soundFile = @"shirt_breng";
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"Portuguese"]){
            soundFile = @"shirt_prtgs";
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"Russian"]){
            soundFile = @"shirt_ru";
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"Spanish"]){
            soundFile = @"shirt_sp";
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"French"]){
            soundFile = @"shirt_fr";
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"German"]){
            soundFile = @"shirt_gr";
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"Italian"]){
            soundFile = @"shirt_ita";
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"Chinese"]){
            soundFile = @"shirt_ch";
        }
        
        
        
    } else if([fallObject isEqualToString:@"spider"]) {
        
        if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"English"]) {
            
            int ranNo = arc4random()%3;
            
            if(ranNo == 0){
                soundFile = @"Tiggly_Animal_Spider_ImASpider_01";
            }else if (ranNo == 1) {
                soundFile = @"Tiggly_Animal_Spider_ImASpider_02";
            }else if (ranNo == 2) {
                soundFile = @"Tiggly_Animal_Spider_ImASpider_04";
            }
            
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"English UK"]){
            soundFile = @"spider_breng";
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"Portuguese"]){
            soundFile = @"spider_prtgs";
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"Russian"]){
            soundFile = @"spider_ru";
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"Spanish"]){
            soundFile = @"spider_sp";
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"French"]){
            soundFile = @"spider_fr";
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"German"]){
            soundFile = @"spider_gr";
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"Italian"]){
            soundFile = @"spider_ita";
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"Chinese"]){
            soundFile = @"spider_ch";
        }
        
        
        
        
    }else if([fallObject isEqualToString:@"purple_spirder"] ) {
        
        if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"English"]) {
            
            int ranNo = arc4random()%4;
            
            if(ranNo == 0){
                soundFile = @"Tiggly_GenGreeting_Fly_01";
            }else if (ranNo == 1) {
                soundFile = @"Tiggly_GenGreeting_Fly_02";
            }else if (ranNo == 2) {
                soundFile = @"Tiggly_GenGreeting_Fly_04";
            }else if (ranNo == 3) {
                soundFile = @"Tiggly_GenGreeting_Fly_07";
            }
            
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"English UK"]){
            soundFile = @"spider_breng";
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"Portuguese"]){
            soundFile = @"spider_prtgs";
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"Russian"]){
            soundFile = @"spider_ru";
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"Spanish"]){
            soundFile = @"spider_sp";
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"French"]){
            soundFile = @"spider_fr";
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"German"]){
            soundFile = @"spider_gr";
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"Italian"]){
            soundFile = @"spider_ita";
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"Chinese"]){
            soundFile = @"spider_ch";
        }
        
        
        
    }else if([fallObject isEqualToString:@"hampster"]) {
        
        if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"English"]) {
            
            int ranNo = arc4random()%3;
            
            if(ranNo == 0){
                soundFile = @"Tiggly_GenGreeting_Hamster_01";
            }else if (ranNo == 1) {
                soundFile = @"Tiggly_GenGreeting_Hamster_07";
            }else if (ranNo == 2) {
                soundFile = @"Tiggly_GenGreeting_Hamster_08";
            }
            
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"English UK"]){
            soundFile = @"hamster_breng";
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"Portuguese"]){
            soundFile = @"hamster_prtgs";
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"Russian"]){
            soundFile = @"hamster_ru";
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"Spanish"]){
            soundFile = @"hamster_sp";
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"French"]){
            soundFile = @"hamster_fr";
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"German"]){
            soundFile = @"hamster_gr";
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"Italian"]){
            soundFile = @"hamster_ita";
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"Chinese"]){
            soundFile = @"hamster_ch";
        }
        
        
       
        
    }else if([fallObject isEqualToString:@"rooster"] || [fallObject isEqualToString:@"rooster_2"]) {
       
        
        if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"English"]) {
            
            int ranNo = arc4random()%2;
            
            if(ranNo == 0){
                soundFile = @"Tiggly_GenGreeting_Rooster_01";
            }else if (ranNo == 1) {
                soundFile = @"Tiggly_GenGreeting_Rooster_06";
            }
            
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"English UK"]){
            soundFile = @"rooster_breng";
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"Portuguese"]){
            soundFile = @"rooster_prtgs";
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"Russian"]){
            soundFile = @"rooster_ru";
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"Spanish"]){
            soundFile = @"rooster_sp";
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"French"]){
            soundFile = @"rooster_fr";
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"German"]){
            soundFile = @"rooster_gr";
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"Italian"]){
            soundFile = @"rooster_ita";
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"Chinese"]){
            soundFile = @"rooster_ch";
        }
        
       
        
    }else if([fallObject isEqualToString:@"chicken"]) {
        if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"English"]) {
            soundFile = @"Tiggly_GenGreeting_Chicken_00";
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"Portuguese"]){
            soundFile = @"chicken_prtgs";
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"French"]){
            soundFile = @"chicken_fr";
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"German"]){
            soundFile = @"chicken_gr";
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"Italian"]){
            soundFile = @"chicken_ita";
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"Chinese"]){
            soundFile = @"chicken_ch";
        }else{
             soundFile = @"Tiggly_GenGreeting_Chicken_00";
        }
        
    }else if([fallObject isEqualToString:@"scare_crow"]) {
       
        if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"English"]) {
            
            int ranNo = arc4random()%4;
            
            if(ranNo == 0){
                soundFile = @"Tiggly_GenGreeting_Scarecrow_02";
            }else if (ranNo == 1) {
                soundFile = @"Tiggly_GenGreeting_Scarecrow_07";
            }else if (ranNo == 2) {
                soundFile = @"Tiggly_GenGreeting_Scarecrow_08";
            }else if (ranNo == 3) {
                soundFile = @"Tiggly_GenGreeting_Scarecrow_10";
            }

            
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"English UK"]){
            soundFile = @"scare_crow_breng";
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"Portuguese"]){
            soundFile = @"scare_crow_prtgs";
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"Russian"]){
            soundFile = @"scare crow_ru";
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"Spanish"]){
            soundFile = @"scare crow_sp";
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"French"]){
            soundFile = @"scare_crow_fr";
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"German"]){
            soundFile = @"scare_crow_gr";
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"Italian"]){
            soundFile = @"scare_crow_ita";
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"Chinese"]){
            soundFile = @"scare_crow_ch";
        }

                
    }else if([fallObject isEqualToString:@"bee"]) {
      if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"English"]) {
            int ranNo = arc4random()%5;
            if(ranNo == 0){
                soundFile = @"Tiggly_Animal_Bee_ImTheBee_01";
            }else if (ranNo == 1) {
                soundFile = @"Tiggly_Animal_Bee_ImTheBee_02";
            }else if (ranNo == 2) {
                soundFile = @"Tiggly_Animal_Bee_ImTheBee_03";
            }else if (ranNo == 3) {
                soundFile = @"Tiggly_Animal_Bee_ImTheHoneyBee_01";
            }else if (ranNo == 4) {
                soundFile = @"Tiggly_Animal_Bee_ImTheHoneyBee_02";
            }

        }
//            else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"English UK"]){
//            soundFile = @"";
//        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"Portuguese"]){
//            soundFile = @"";
//        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"Russian"]){
//            soundFile = @"";
//        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"Spanish"]){
//            soundFile = @"";
//        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"French"]){
//            soundFile = @"";
//        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"German"]){
//            soundFile = @"";
//        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"Italian"]){
//            soundFile = @"";
//        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"Chinese"]){
//            soundFile = @"";
//        }
            
    }else if([fallObject isEqualToString:@"broom"]) {
        
        if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"English"]) {
            int ranNo = arc4random()%2;
            if(ranNo == 0){
                soundFile = @"Tiggly_Word_Broom_01";
            }else if (ranNo == 1) {
                soundFile = @"Tiggly_Word_Broom_Ooh_01";
            }
            
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"English UK"]){
            soundFile = @"broom_breng";
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"Portuguese"]){
            soundFile = @"broom_prtgs";
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"Russian"]){
            soundFile = @"broom_ru";
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"Spanish"]){
            soundFile = @"broom_sp";
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"French"]){
            soundFile = @"broom_fr";
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"German"]){
            soundFile = @"broom_gr";
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"Italian"]){
            soundFile = @"broom_ita";
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"Chinese"]){
            soundFile = @"broom_ch";
        }
        
        
    }else if([fallObject isEqualToString:@"duck_1"]) {
        if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"English"]) {
            int ranNo = arc4random()%2;
            if(ranNo == 0){
                soundFile = @"Tiggly_GenGreeting_Duck_01";
            }else if (ranNo == 1) {
                soundFile = @"Tiggly_GenGreeting_Duck_02";
            }
            
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"English UK"]){
            soundFile = @"duck_breng";
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"Portuguese"]){
            soundFile = @"duck_prtgs";
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"Russian"]){
            soundFile = @"duck_ru";
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"Spanish"]){
            soundFile = @"duck_sp";
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"French"]){
            soundFile = @"duck_fr";
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"German"]){
            soundFile = @"duck_gr";
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"Italian"]){
            soundFile = @"duck_ita";
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"Chinese"]){
            soundFile = @"duck_ch";
        }
        
        
    }else if([fallObject isEqualToString:@"horse"]) {
        if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"English"]) {
            int ranNo = arc4random()%4;
            
            if(ranNo == 0){
                soundFile = @"Tiggly_GenGreeting_Donkey_01";
            }else if (ranNo == 1) {
                soundFile = @"Tiggly_GenGreeting_Donkey_02";
            }else if (ranNo == 2) {
                soundFile = @"Tiggly_GenGreeting_Donkey_05";
            }else if (ranNo == 3) {
                soundFile = @"Tiggly_GenGreeting_Donkey_06";
            }
            
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"English UK"]){
            soundFile = @"Donkey_breng";
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"Portuguese"]){
            soundFile = @"Donkey_prtgs";
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"Russian"]){
            soundFile = @"Donkey_ru";
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"Spanish"]){
            soundFile = @"Donkey_sp";
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"French"]){
            soundFile = @"Donkey_fr";
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"German"]){
            soundFile = @"Donkey_gr";
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"Italian"]){
            soundFile = @"Donkey_ita";
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"Chinese"]){
            soundFile = @"Donkey_ch";
        }
        
        
    }else if([fallObject isEqualToString:@"leaves"]) {
        if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"English"]) {
            int ranNo = arc4random()%2;
            
            if(ranNo == 0){
                soundFile = @"Tiggly_Word_Leaves_01";
            }else if (ranNo == 1) {
                soundFile = @"Tiggly_Word_Leaves_Ooh_01";
            }
            
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"English UK"]){
            soundFile = @"leaves_breng";
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"Portuguese"]){
            soundFile = @"leaves_prtgs";
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"Russian"]){
            soundFile = @"leaves_ru";
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"Spanish"]){
            soundFile = @"leaves_sp";
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"French"]){
            soundFile = @"leaves_fr";
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"German"]){
            soundFile = @"leaves_gr";
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"Italian"]){
            soundFile = @"leaves_ita";
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"Chinese"]){
            soundFile = @"leaves_ch";
        }
        
        
    }else if([fallObject isEqualToString:@"mushroom"]) {
        if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"English"]) {
            int ranNo = arc4random()%2;
            
            if(ranNo == 0){
                soundFile = @"Tiggly_Word_Mushroom_01";
            }else if (ranNo == 1) {
                soundFile = @"Tiggly_Word_Mushroom_Wow_01";
            }
            
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"English UK"]){
            soundFile = @"mushroom_breng";
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"Portuguese"]){
            soundFile = @"mushroom_prtgs";
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"Russian"]){
            soundFile = @"mushroom_ru";
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"Spanish"]){
            soundFile = @"mushroom_sp";
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"French"]){
            soundFile = @"mushroom_fr";
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"German"]){
            soundFile = @"mushroom_gr";
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"Italian"]){
            soundFile = @"mushroom__ita";
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"Chinese"]){
            soundFile = @"mushroom_ch";
        }
        
        
    }else if([fallObject isEqualToString:@"pear"]) {
        if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"English"]) {
            int ranNo = arc4random()%2;
            
            if(ranNo == 0){
                soundFile = @"Tiggly_Word_Pear_01";
            }else if (ranNo == 1) {
                soundFile = @"Tiggly_Word_Pear_Ooh_01";
            }
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"English UK"]){
            soundFile = @"pear_breng";
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"Portuguese"]){
            soundFile = @"pear_prtgs";
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"Russian"]){
            soundFile = @"pear_ru";
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"Spanish"]){
            soundFile = @"pear_sp";
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"French"]){
            soundFile = @"pear_fr";
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"German"]){
            soundFile = @"pear_gr";
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"Italian"]){
            soundFile = @"pear_ita";
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"Chinese"]){
            soundFile = @"pear_ch";
        }

       
        
    }else if([fallObject isEqualToString:@"raincoat"]) {
        if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"English"]) {
            int ranNo = arc4random()%2;
            
            if(ranNo == 0){
                soundFile = @"Tiggly_Word_Raincoat_01";
            }else if (ranNo == 1) {
                soundFile = @"Tiggly_Word_Raincoat_Ah_01";
            }
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"English UK"]){
            soundFile = @"rain_coat_breng";
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"Portuguese"]){
            soundFile = @"rain coat_prtgs";
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"Russian"]){
            soundFile = @"rain coat_ru";
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"Spanish"]){
            soundFile = @"rain coat_sp";
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"French"]){
            soundFile = @"raincoat_fr";
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"German"]){
            soundFile = @"rain_coat_gr";
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"Italian"]){
            soundFile = @"rain_coat_ita";
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"Chinese"]){
            soundFile = @"raincoat_ch";
        }
        
        
    }
    else if([fallObject isEqualToString:@"pinkRaincoat"]) {
        if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"English"]) {
            int ranNo = arc4random()%5;
            
            if(ranNo == 0){
                soundFile = @"Tiggly_Word_Pinkraincoat_01";
            }else if (ranNo == 1) {
                soundFile = @"Tiggly_Word_Pinkraincoat_Var1_01";
            }else if (ranNo == 2) {
                soundFile = @"Tiggly_Word_Pinkraincoat_Var2_01";
            }else if (ranNo == 3) {
                soundFile = @"Tiggly_Word_Pinkraincoat_Var2_02";
            }else if (ranNo == 4) {
                soundFile = @"Tiggly_Word_Pinkraincoat_Var2_03";
            }
            
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"English UK"]){
            soundFile = @"rain_coat_breng";
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"Portuguese"]){
            soundFile = @"rain coat_prtgs";
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"Russian"]){
            soundFile = @"rain coat_ru";
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"Spanish"]){
            soundFile = @"rain coat_sp";
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"French"]){
            soundFile = @"raincoat_fr";
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"German"]){
            soundFile = @"rain_coat_gr";
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"Italian"]){
            soundFile = @"rain_coat_ita";
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"Chinese"]){
            soundFile = @"raincoat_ch";
        }
       
        
    }else if([fallObject isEqualToString:@"orangeRaincoat"] ) {
        if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"English"]) {
            int ranNo = arc4random()%5;
            
            if(ranNo == 0){
                soundFile = @"Tiggly_Word_Orangeraincoat_01";
            }else if (ranNo == 1) {
                soundFile = @"Tiggly_Word_Orangeraincoat_Var1_01";
            }else if (ranNo == 2) {
                soundFile = @"Tiggly_Word_Orangeraincoat_Var2_01";
            }else if (ranNo == 3) {
                soundFile = @"Tiggly_Word_Orangeraincoat_Var2_02";
            }else if (ranNo == 4) {
                soundFile = @"Tiggly_Word_Orangeraincoat_Var2_03";
            }
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"English UK"]){
            soundFile = @"rain_coat_breng";
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"Portuguese"]){
            soundFile = @"rain coat_prtgs";
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"Russian"]){
            soundFile = @"rain coat_ru";
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"Spanish"]){
            soundFile = @"rain coat_sp";
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"French"]){
            soundFile = @"raincoat_fr";
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"German"]){
            soundFile = @"rain_coat_gr";
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"Italian"]){
            soundFile = @"rain_coat_ita";
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"Chinese"]){
            soundFile = @"raincoat_ch";
        }
        
        
    }else if([fallObject isEqualToString:@"yellowRaincoat"]) {
        if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"English"]) {
            int ranNo = arc4random()%6;
            
            if(ranNo == 0){
                soundFile = @"Tiggly_Word_Yellowraincoat_01";
            }else if (ranNo == 1) {
                soundFile = @"Tiggly_Word_Yellowraincoat_Var1_01";
            }else if (ranNo == 2) {
                soundFile = @"Tiggly_Word_Yellowraincoat_Var2_01";
            }else if (ranNo == 3) {
                soundFile = @"Tiggly_Word_Yellowraincoat_Var2_02";
            }else if (ranNo == 4) {
                soundFile = @"Tiggly_Word_Yellowraincoat_Var2_03";
            }else if (ranNo == 5) {
                soundFile = @"Tiggly_Word_Yellowraincoat_Var2_04";
            }

        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"English UK"]){
            soundFile = @"rain_coat_breng";
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"Portuguese"]){
            soundFile = @"rain coat_prtgs";
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"Russian"]){
            soundFile = @"rain coat_ru";
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"Spanish"]){
            soundFile = @"rain coat_sp";
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"French"]){
            soundFile = @"raincoat_fr";
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"German"]){
            soundFile = @"rain_coat_gr";
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"Italian"]){
            soundFile = @"rain_coat_ita";
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"Chinese"]){
            soundFile = @"raincoat_ch";
        }
        
        
    }
    
    else if([fallObject isEqualToString:@"zebra_2"]) {
        if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"English"]) {
            int ranNo = arc4random()%6;
            
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
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"English UK"]){
            soundFile = @"Zebra_breng";
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"Portuguese"]){
            soundFile = @"Zebra_prtgs";
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"Russian"]){
            soundFile = @"Zebra_ru";
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"Spanish"]){
            soundFile = @"Zebra_sp";
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"French"]){
            soundFile = @"Zebra_fr";
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"German"]){
            soundFile = @"Zebra_gr";
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"Italian"]){
            soundFile = @"Zebra_ita";
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"Chinese"]){
            soundFile = @"Zebra_ch";
        }
        
        
    }else if([fallObject isEqualToString:@"witches_hat"] || [fallObject isEqualToString:@"witches_hat_purple"]) {
        
        if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"English"]) {
            int ranNo = arc4random()%2;
            
            if(ranNo == 0){
                soundFile = @"Tiggly_Word_Hat_Var2_02";
            }else if (ranNo == 1) {
                soundFile = @"Tiggly_Word_Hat_Var2_03";
            }
            
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"English UK"]){
            soundFile = @"hat_breng";
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"Portuguese"]){
            soundFile = @"hat_prtgs";
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"Russian"]){
            soundFile = @"hat_ru";
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"Spanish"]){
            soundFile = @"hat_sp";
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"French"]){
            soundFile = @"hat_fr";
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"German"]){
            soundFile = @"hat_gr";
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"Italian"]){
            soundFile = @"hat_ita";
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"Chinese"]){
            soundFile = @"hat_ch";
        }

        
        
    }else if ([fallObject isEqualToString:@"blue_jeans"]) {
        if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"English"]) {
            int ranNo = arc4random()%5;
            
            if(ranNo == 0){
                soundFile = @"Tiggly_Word_BluePants_01";
            }else if (ranNo == 1) {
                soundFile = @"Tiggly_Word_BluePants_Var1_01";
            }else if (ranNo == 2) {
                soundFile = @"Tiggly_Word_BluePants_Var2_01";
            }else if (ranNo == 3) {
                soundFile = @"Tiggly_Word_BluePants_Var2_02";
            }else if (ranNo == 4) {
                soundFile = @"Tiggly_Word_BluePants_Var2_03";
            }
            
        } else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"English UK"]){
            soundFile = @"Tiggly_Word_Pants_01";
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"Portuguese"]){
            soundFile = @"pants_prtgs";
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"Russian"]){
            soundFile = @"pants_ru";
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"Spanish"]){
            soundFile = @"pants_sp";
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"French"]){
            soundFile = @"pants_fr";
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"German"]){
            soundFile = @"pants_gr";
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"Italian"]){
            soundFile = @"pants_ita";
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"Chinese"]){
            soundFile = @"pants_ch";
        }else{
            soundFile = @"Tiggly_Word_Pants_01";
        }
        
    }
    else if ([fallObject isEqualToString:@"green_skirt"]) {
        
        if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"English"]) {
            int ranNo = arc4random()%5;
            if(ranNo == 0){
                soundFile = @"Tiggly_Word_Greenskirt_01";
            }else if (ranNo == 1) {
                soundFile = @"Tiggly_Word_Greenskirt_Var1_01";
            }else if (ranNo == 2) {
                soundFile = @"Tiggly_Word_Greenskirt_Var2_01";
            }else if (ranNo == 3) {
                soundFile = @"Tiggly_Word_Greenskirt_Var2_02";
            }else if (ranNo == 4) {
                soundFile = @"Tiggly_Word_Greenskirt_Var2_03";
            }
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"English UK"]){
            soundFile = @"Tiggly_Word_Skirt_01";
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"Portuguese"]){
            soundFile = @"skirt_prtgs";
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"Russian"]){
            soundFile = @"skirt_ru";
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"Spanish"]){
            soundFile = @"skirt_sp";
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"French"]){
            soundFile = @"skirt_fr";
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"German"]){
            soundFile = @"skirt_gr";
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"Italian"]){
            soundFile = @"skirt_ita";
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"Chinese"]){
            soundFile = @"skirt_ch";
        }else{
            soundFile = @"Tiggly_Word_Skirt_01";
        }

    }
    else if ([fallObject isEqualToString:@"khakis"]) {
        if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"English"]) {
            int ranNo = arc4random()%5;
            if(ranNo == 0){
                soundFile = @"Tiggly_Word_Pants_01";
            }else if (ranNo == 1) {
                soundFile = @"Tiggly_Word_Pants_Var1_01";
            }else if (ranNo == 2) {
                soundFile = @"Tiggly_Word_Pants_Var2_01";
            }else if (ranNo == 3) {
                soundFile = @"Tiggly_Word_Pants_Var2_02";
            }else if (ranNo == 4) {
                soundFile = @"Tiggly_Word_Pants_Var2_03";
            }
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"English UK"]){
            soundFile = @"Tiggly_Word_Pants_01";
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"Portuguese"]){
            soundFile = @"pants_prtgs";
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"Russian"]){
            soundFile = @"pants_ru";
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"Spanish"]){
            soundFile = @"pants_sp";
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"French"]){
            soundFile = @"pants_fr";
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"German"]){
            soundFile = @"pants_gr";
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"Italian"]){
            soundFile = @"pants_ita";
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"Chinese"]){
            soundFile = @"pants_ch";
        }else{
            soundFile = @"Tiggly_Word_Pants_01";
        }

    }
   else  if ([fallObject isEqualToString:@"pink_skirt_fall"]) {
       if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"English"]) {
           int ranNo = arc4random()%5;
           if(ranNo == 0){
               soundFile = @"Tiggly_Word_Pinkskirt_01";
           }else if (ranNo == 1) {
               soundFile = @"Tiggly_Word_Pinkskirt_Var1_01";
           }else if (ranNo == 2) {
               soundFile = @"Tiggly_Word_Pinkskirt_Var2_01";
           }else if (ranNo == 3) {
               soundFile = @"Tiggly_Word_Pinkskirt_Var2_02";
           }else if (ranNo == 4) {
               soundFile = @"Tiggly_Word_Pinkskirt_Var2_03";
           }
       }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"English UK"]){
           soundFile = @"Tiggly_Word_Skirt_01";
       }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"Portuguese"]){
           soundFile = @"skirt_prtgs";
       }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"Russian"]){
           soundFile = @"skirt_ru";
       }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"Spanish"]){
           soundFile = @"skirt_sp";
       }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"French"]){
           soundFile = @"skirt_fr";
       }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"German"]){
           soundFile = @"skirt_gr";
       }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"Italian"]){
           soundFile = @"skirt_ita";
       }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"Chinese"]){
           soundFile = @"skirt_ch";
       }else{
           soundFile = @"Tiggly_Word_Skirt_01";
       }
       
    }
    else if ([fallObject isEqualToString:@"purple_pants"]) {
        if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"English"]) {
            int ranNo = arc4random()%6;
            
            if(ranNo == 0){
                soundFile = @"Tiggly_Word_Purplepants_01";
            }else if (ranNo == 1) {
                soundFile = @"Tiggly_Word_Purplepants_Var1_01";
            }else if (ranNo == 2) {
                soundFile = @"Tiggly_Word_Purplepants_Var2_01";
            }else if (ranNo == 3) {
                soundFile = @"Tiggly_Word_Purplepants_Var2_02";
            }else if (ranNo == 4) {
                soundFile = @"Tiggly_Word_Purplepants_Var2_03";
            }else if (ranNo == 5) {
                soundFile = @"Tiggly_Word_Purplepants_Var2_04";
            }
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"English UK"]){
            soundFile = @"Tiggly_Word_Pants_01";
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"Portuguese"]){
            soundFile = @"pants_prtgs";
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"Russian"]){
            soundFile = @"pants_ru";
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"Spanish"]){
            soundFile = @"pants_sp";
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"French"]){
            soundFile = @"pants_fr";
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"German"]){
            soundFile = @"pants_gr";
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"Italian"]){
            soundFile = @"pants_ita";
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"Chinese"]){
            soundFile = @"pants_ch";
        }else{
            soundFile = @"Tiggly_Word_Pants_01";
        }
        
    }
    else if ([fallObject isEqualToString:@"yellow_skirt"]) {
        if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"English"]) {
            int ranNo = arc4random()%6;
            
            if(ranNo == 0){
                soundFile = @"Tiggly_Word_Skirt_01";
            }else if (ranNo == 1) {
                soundFile = @"Tiggly_Word_Skirt_Var1_01";
            }else if (ranNo == 2) {
                soundFile = @"Tiggly_Word_Skirt_Var2_01";
            }else if (ranNo == 3) {
                soundFile = @"Tiggly_Word_Skirt_Var2_02";
            }else if (ranNo == 4) {
                soundFile = @"Tiggly_Word_Skirt_Var2_03";
            }else if (ranNo == 5) {
                soundFile = @"Tiggly_Word_Skirt_Var2_04";
            }
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"English UK"]){
            soundFile = @"Tiggly_Word_Skirt_01";
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"Portuguese"]){
            soundFile = @"skirt_prtgs";
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"Russian"]){
            soundFile = @"skirt_ru";
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"Spanish"]){
            soundFile = @"skirt_sp";
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"French"]){
            soundFile = @"skirt_fr";
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"German"]){
            soundFile = @"skirt_gr";
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"Italian"]){
            soundFile = @"skirt_ita";
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"Chinese"]){
            soundFile = @"skirt_ch";
        }else{
            soundFile = @"Tiggly_Word_Skirt_01";
        }
        
    }
    return soundFile;
}

-(NSString *) getAnimalDropSoundForObject:(NSString *) fallObject{
    DebugLog(@"");
    
    NSString *soundFile;
    
    if([fallObject isEqualToString:@"apple_red"] || [fallObject isEqualToString:@"green_apple"]) {
        
        int ranNo = arc4random()%2;
        
        if(ranNo == 0){
            soundFile = @"Tiggly_SFX_DragNDrop_DROP_02";
        }else if (ranNo == 1) {
            soundFile = @"Tiggly_SFX_DragNDrop_DROP_03";
        }
        
    }else if([fallObject isEqualToString:@"blue_turkey"] || [fallObject isEqualToString:@"orange_turkey"]) {
        int ranNo = arc4random()%12;
        if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"English"]) {
                if(ranNo == 0){
                    soundFile = @"Tiggly_GenGreeting_Turkey_07";
                }else if (ranNo == 1) {
                    soundFile = @"Tiggly_GenGreeting_Turkey_08";
                }else if (ranNo == 2) {
                    soundFile = @"Tiggly_Animal_Turkey_DontIHaveBeautifulFeathers_02";
                }else if (ranNo == 3) {
                    soundFile = @"Tiggly_Animal_Turkey_GiveMeAnApple_01";
                }else if (ranNo == 4) {
                    soundFile = @"Tiggly_Animal_Turkey_GiveMeAnApple_02";
                }else if (ranNo == 5) {
                    soundFile = @"Tiggly_Animal_Turkey_IsItFallAlready_01";
                }else if (ranNo == 6) {
                    soundFile = @"Tiggly_Animal_Turkey_IsItFallAlready_02";
                }else if (ranNo == 7) {
                    soundFile = @"Tiggly_Animal_Turkey_IWantACandy_01";
                }else if (ranNo == 8) {
                    soundFile = @"Tiggly_Animal_Turkey_IWantAPear_01";
                }else if (ranNo == 9) {
                    soundFile = @"Tiggly_Animal_Turkey_LeavesAreFallingItsGottaBeFall_01";
                }else if (ranNo == 10) {
                    soundFile = @"Tiggly_Animal_Turkey_LooksLikeItsTheFallSeason_01";
                }else if (ranNo == 11) {
                    soundFile = @"Tiggly_Animal_Turkey_LooksLikeItsTheFallSeason_02";
                }
        }else{
            int ranNo = arc4random()%2;
            if(ranNo == 0){
                soundFile = @"Tiggly_GenGreeting_Turkey_07";
            }else if (ranNo == 1) {
                soundFile = @"Tiggly_GenGreeting_Turkey_08";
            }
        }
        
    }else if([fallObject isEqualToString:@"cranberries"]|| [fallObject isEqualToString:@"cranberries_leaves"]) {
        int ranNo = arc4random()%2;
        if(ranNo == 0){
            soundFile = @"Tiggly_SFX_DragNDrop_DROP_02";
        }else if (ranNo == 1) {
            soundFile = @"Tiggly_SFX_DragNDrop_DROP_03";
        }
    }else if([fallObject isEqualToString:@"greyish_cat"] || [fallObject isEqualToString:@"pink_cat"]|| [fallObject isEqualToString:@"cat"]) {
         if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"English"]) {
            int ranNo = arc4random()%13;
            if(ranNo == 0){
                soundFile = @"Tiggly_GenGreeting_Cat_01";
            }else if (ranNo == 1) {
                soundFile = @"Tiggly_GenGreeting_Cat_02";
            }else if (ranNo == 2) {
                soundFile = @"Tiggly_GenGreeting_Cat_03";
            }else if (ranNo == 3) {
                soundFile = @"Tiggly_GenGreeting_Cat_04";
            }else if (ranNo == 4) {
                soundFile = @"Tiggly_Animal_Cat_GiveMeAnApple_01";
            }else if (ranNo == 5) {
                soundFile = @"Tiggly_Animal_Cat_GiveMeAnApple_02";
            }else if (ranNo == 6) {
                soundFile = @"Tiggly_Animal_Cat_IsItFallAlready_01";
            }else if (ranNo == 7) {
                soundFile = @"Tiggly_Animal_Cat_IWantACandy_01";
            }else if (ranNo == 8) {
                soundFile = @"Tiggly_Animal_Cat_IWantACandy_02";
            }else if (ranNo == 9) {
                soundFile = @"Tiggly_Animal_Cat_IWantAPear_01";
            }else if (ranNo == 10) {
                soundFile = @"Tiggly_Animal_Cat_IWantAPear_02";
            }else if (ranNo == 11) {
                soundFile = @"Tiggly_Animal_Cat_LeavesAreFallingItMustMeFall_01";
            }else if (ranNo == 12) {
                soundFile = @"Tiggly_Animal_Cat_LeavesAreFallingItMustMeFall_02";
            }
             
         }else{
             int ranNo = arc4random()%3;
             if(ranNo == 0){
                 soundFile = @"Tiggly_GenGreeting_Cat_01";
             }else if (ranNo == 1) {
                 soundFile = @"Tiggly_GenGreeting_Cat_02";
             }else if (ranNo == 2) {
                 soundFile = @"Tiggly_GenGreeting_Cat_03";
             }
         }
    }else if([fallObject isEqualToString:@"litepurple_racoon"] || [fallObject isEqualToString:@"racoon"]) {
      if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"English"]) {
            int ranNo = arc4random()%9;
            if(ranNo == 0){
                soundFile = @"Tiggly_GenGreeting_Raccoon_04";
            }else if (ranNo == 1) {
                soundFile = @"Tiggly_GenGreeting_Raccoon_05";
            }else if (ranNo == 2) {
                soundFile = @"Tiggly_GenGreeting_Raccoon_12";
            }else if (ranNo == 3) {
                soundFile = @"Tiggly_Animal_Raccoon_IWonderWhatStoryYouHaveAboutUs_01";
            }else if (ranNo == 4) {
                soundFile = @"Tiggly_Animal_Raccoon_IWonderWhatStoryYouHaveAboutUs_02";
            }else if (ranNo == 5) {
                soundFile = @"Tiggly_Animal_Raccoon_IWonderWhatStoryYouHaveAboutUs_03";
            }else if (ranNo == 6) {
                soundFile = @"Tiggly_Animal_Raccoon_YouCanGiveMeTheBroom_02";
            }else if (ranNo == 7) {
                soundFile = @"Tiggly_Animal_Raccoon_YouveGottaPileAllTheLeavesInTheCorner_01";
            }else if (ranNo == 8) {
                soundFile = @"Tiggly_Animal_Raccoon_YouveGottaPileAllTheLeavesInTheCorner_02";
            }
      }else{
          soundFile = @"Tiggly_GenGreeting_Raccoon_14";
      }
        
    }else if([fallObject isEqualToString:@"pumpkin_3"]) {
       
        if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"English"]) {
            int ranNo = arc4random()%7;
            
            if(ranNo == 0){
                soundFile = @"Tiggly_GenGreeting_JackOLantern_02";
            }else if (ranNo == 1) {
                soundFile = @"Tiggly_GenGreeting_JackOLantern_03";
            }else if (ranNo == 2) {
                soundFile = @"Tiggly_GenGreeting_JackOLantern_04";
            }else if (ranNo == 3) {
                soundFile = @"Tiggly_GenGreeting_JackOLantern_05";
            }else if (ranNo == 4) {
                soundFile = @"Tiggly_GenGreeting_JackOLantern_07";
            }else if (ranNo == 5) {
                soundFile = @"Tiggly_GenGreeting_JackOLantern_10";
            }else if (ranNo == 6) {
                soundFile = @"Tiggly_GenGreeting_JackOLantern_11";
            }
        }else{
            int ranNo = arc4random()%3;
            if(ranNo == 0){
                soundFile = @"Tiggly_GenGreeting_JackOLantern_02";
            }else if (ranNo == 1) {
                soundFile = @"Tiggly_GenGreeting_JackOLantern_03";
            }else if (ranNo == 2) {
                soundFile = @"Tiggly_GenGreeting_JackOLantern_04";
            }
        }
    } else if([fallObject isEqualToString:@"pumkin_1"] || [fallObject isEqualToString:@"pumkin_bag"] ) {
        int ranNo = arc4random()%6;
         if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"English"]) {
            if(ranNo == 0){
                soundFile = @"Tiggly_GenGreeting_Pumpkin_05";
            }else if (ranNo == 1) {
                soundFile = @"Tiggly_GenGreeting_Pumpkin_05";
            }else if (ranNo == 2) {
                soundFile = @"Tiggly_Animal_Pumpkin_ItsFallTime_01";
            }else if (ranNo == 3) {
                soundFile = @"Tiggly_Animal_Pumpkin_PickMe_02";
            }else if (ranNo == 4) {
                soundFile = @"Tiggly_Animal_Pumpkin_PickMe_03";
            }else if (ranNo == 5) {
                soundFile = @"Tiggly_Animal_Pumpkin_SoManyColorfulLeaves_01";
            }
         }else{
             int ranNo = arc4random()%2;
             if(ranNo == 0){
                 soundFile = @"Tiggly_GenGreeting_Pumpkin_05";
             }else if (ranNo == 1) {
                 soundFile = @"Tiggly_GenGreeting_Pumpkin_05";
             }
         }
        
    }else if([fallObject isEqualToString:@"barn_2"] ) {
        
        int ranNo = arc4random()%2;
        if(ranNo == 0){
            soundFile = @"Tiggly_SFX_DragNDrop_DROP_02";
        }else if (ranNo == 1) {
            soundFile = @"Tiggly_SFX_DragNDrop_DROP_03";
        }
        
    }else if([fallObject isEqualToString:@"bat"]) {
       if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"English"]) {
            int ranNo = arc4random()%2;
            if(ranNo == 0){
                soundFile = @"Tiggly_GenGreeting_Bat_02";
            }else if (ranNo == 1) {
                soundFile = @"Tiggly_GenGreeting_Bat_03";
            }
       }else{
           soundFile = @"Tiggly_SFX_BAT";
       }
    }else if([fallObject isEqualToString:@"blue_candy"] || [fallObject isEqualToString:@"orange_candy"]|| [fallObject isEqualToString:@"yellow_candy"] ) {
        
        int ranNo = arc4random()%2;
        
        if(ranNo == 0){
            soundFile = @"Tiggly_SFX_DragNDrop_DROP_02";
        }else if (ranNo == 1) {
            soundFile = @"Tiggly_SFX_DragNDrop_DROP_03";
        }
        
    }else if([fallObject isEqualToString:@"green_leaf"] || [fallObject isEqualToString:@"orange_leaf"]|| [fallObject isEqualToString:@"yellow_leaf"]|| [fallObject isEqualToString:@"pink_leaf"]|| [fallObject isEqualToString:@"green_leaf_2"] || [fallObject isEqualToString:@"orange_leaf_2"]) {
        
        int ranNo = arc4random()%2;
        
        if(ranNo == 0){
            soundFile = @"Tiggly_SFX_DragNDrop_DROP_02";
        }else if (ranNo == 1) {
            soundFile = @"Tiggly_SFX_DragNDrop_DROP_03";
        }
        
        
    }else if([fallObject isEqualToString:@"haybale"] ) {
        
        int ranNo = arc4random()%2;
        
        if(ranNo == 0){
            soundFile = @"Tiggly_SFX_DragNDrop_DROP_02";
        }else if (ranNo == 1) {
            soundFile = @"Tiggly_SFX_DragNDrop_DROP_03";
        }
        
    }else if([fallObject isEqualToString:@"pirate"] ) {
        
        int ranNo = arc4random()%2;
        
        if(ranNo == 0){
            soundFile = @"Tiggly_SFX_DragNDrop_DROP_02";
        }else if (ranNo == 1) {
            soundFile = @"Tiggly_SFX_DragNDrop_DROP_03";
        }
        
    }else if([fallObject isEqualToString:@"spider"]) {
        int ranNo = arc4random()%2;
        
        if(ranNo == 0){
            soundFile = @"Tiggly_GenGreeting_spider_01";
        }else if (ranNo == 1) {
            soundFile = @"Tiggly_GenGreeting_spider_01";
        }
        
    }else if([fallObject isEqualToString:@"purple_spirder"] ) {
      
        if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"English"]) {
                int ranNo = arc4random()%6;
                if(ranNo == 0){
                    soundFile = @"Tiggly_GenGreeting_Fly_03";
                }else if (ranNo == 1) {
                    soundFile = @"Tiggly_GenGreeting_Fly_06";
                }else if (ranNo == 2) {
                    soundFile = @"Tiggly_Animal_Fly_WhyAmISoShy_01";
                }else if (ranNo == 3) {
                    soundFile = @"Tiggly_Animal_Fly_WhyAmISoShy_02";
                }else if (ranNo == 4) {
                    soundFile = @"Tiggly_Animal_Fly_WhyAmISoShy_03";
                }else if (ranNo == 5) {
                    soundFile = @"Tiggly_Animal_Fly_YouWontSwatMe_01";
                }
        }else{
            int ranNo = arc4random()%1;
            if(ranNo == 0){
                soundFile = @"Tiggly_GenGreeting_Fly_03";
            }
        }
        
    }else if([fallObject isEqualToString:@"hampster"]) {
        if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"English"]) {
            int ranNo = arc4random()%6;
            
            if(ranNo == 0){
                soundFile = @"Tiggly_GenGreeting_Hamster_04";
            }else if (ranNo == 1) {
                soundFile = @"Tiggly_GenGreeting_Hamster_04";
            }else if (ranNo == 2) {
                soundFile = @"Tiggly_Animal_Hamster_CranberriesLookDelicious_01";
            }else if (ranNo == 3) {
                soundFile = @"Tiggly_Animal_Hamster_GiveMeAnApple_01";
            }else if (ranNo == 4) {
                soundFile = @"Tiggly_Animal_Hamster_IWantACandy_02";
            }else if (ranNo == 5) {
                soundFile = @"Tiggly_Animal_Hamster_IWantAPear_01";
            }
        }else{
            soundFile = @"Tiggly_GenGreeting_Hamster_04";
        }
    }else if([fallObject isEqualToString:@"rooster"] || [fallObject isEqualToString:@"rooster_2"]) {
        if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"English"]) {
            int ranNo = arc4random()%5;
            if(ranNo == 0){
                soundFile = @"rooster_Animal";
            }else if (ranNo == 1) {
                soundFile = @"rooster_Animal";
            }else if (ranNo == 2) {
                soundFile = @"Tiggly_Animal_Rooster_GoodMorning_01";
            }else if (ranNo == 3) {
                soundFile = @"Tiggly_Animal_Rooster_GoodMorning_02";
            }else if (ranNo == 4) {
                soundFile = @"Tiggly_Animal_Rooster_LookAtMyBeautifulRedComb_01";
            }
        }else{
            soundFile = @"rooster_Animal";
        }
        
    }else if([fallObject isEqualToString:@"chicken"]) {
        
        if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"English"]) {
            int ranNo = arc4random()%6;
            if(ranNo == 0){
                soundFile = @"Tiggly_GenGreeting_Chicken_01";
            }else if (ranNo == 1) {
                soundFile = @"Tiggly_GenGreeting_Chicken_02";
            }else if (ranNo == 2) {
                soundFile = @"Tiggly_GenGreeting_Chicken_03";
            }else if(ranNo == 3){
                soundFile = @"Tiggly_Animal_Chicken_IsItFall_01";
            }else if (ranNo == 4) {
                soundFile = @"Tiggly_Animal_Chicken_IsItFall_02";
            }else if (ranNo == 5) {
                soundFile = @"Tiggly_Animal_Chicken_IsItFall_03";
            }
        }else{
            soundFile = @"Tiggly_SFX_CHICKEN";
        }
        
        
    }else if([fallObject isEqualToString:@"scare_crow"]) {
       
        if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"English"]) {
            int ranNo = arc4random()%19;
            
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
            }else if (ranNo == 5) {
                soundFile = @"Tiggly_Animal_Scarecrow_CranberriesAndFallGoTogether_01";
            }else if (ranNo == 6) {
                soundFile = @"Tiggly_Animal_Scarecrow_CranberriesAndFallGoTogether_02";
            }else if (ranNo == 7) {
                soundFile = @"Tiggly_Animal_Scarecrow_GiveMeTheBroom_01";
            }else if (ranNo == 8) {
                soundFile = @"Tiggly_Animal_Scarecrow_HahFallIsAGoodSeasonForApples_01";
            }else if (ranNo == 9) {
                soundFile = @"Tiggly_Animal_Scarecrow_HahFallIsAGoodSeasonForApples_02";
            }else if (ranNo == 10) {
                soundFile = @"Tiggly_Animal_Scarecrow_IsItStorytimeYet_01";
            }else if (ranNo == 11) {
                soundFile = @"Tiggly_Animal_Scarecrow_IsItStorytimeYet_02";
            }else if (ranNo == 12) {
                soundFile = @"Tiggly_Animal_Scarecrow_IsThatAnOrangeLeaf_01";
            }else if (ranNo == 13) {
                soundFile = @"Tiggly_Animal_Scarecrow_IsThatAnOrangeLeaf_02";
            }else if (ranNo == 14) {
                soundFile = @"Tiggly_Animal_Scarecrow_IsThatARedLeaf_01";
            }else if (ranNo == 15) {
                soundFile = @"Tiggly_Animal_Scarecrow_IsThatARedLeaf_02";
            }else if (ranNo == 16) {
                soundFile = @"Tiggly_Animal_Scarecrow_IsThatAYellowLeaf_01";
            }else if (ranNo == 17) {
                soundFile = @"Tiggly_Animal_Scarecrow_IsThatAYellowLeaf_02";
            }else if (ranNo == 18) {
                soundFile = @"Tiggly_Animal_Scarecrow_IsThatAYellowLeaf_02";
            }
        }else{
            int ranNo = arc4random()%2;
            
            if(ranNo == 0){
                soundFile = @"Tiggly_SFX_DragNDrop_DROP_02";
            }else if (ranNo == 1) {
                soundFile = @"Tiggly_SFX_DragNDrop_DROP_03";
            }
        }
        
    }else if([fallObject isEqualToString:@"bee"]) {
        if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"English"]) {
            int ranNo = arc4random()%3;
            if(ranNo == 0){
                soundFile = @"Tiggly_Animal_Bee_ItsFallIsntIt_01";
            }else if (ranNo == 1) {
                soundFile = @"Tiggly_Animal_Bee_ItsFallIsntIt_02";
            }else if (ranNo == 2) {
                soundFile = @"Tiggly_Animal_Bee_StoryStory_01";
            }
        }else{
            soundFile = @"Tiggly_Animal_Bee";
        }
    }else if([fallObject isEqualToString:@"broom"]) {
        
        int ranNo = arc4random()%2;        
        if(ranNo == 0){
            soundFile = @"Tiggly_SFX_DragNDrop_DROP_02";
        }else if (ranNo == 1) {
            soundFile = @"Tiggly_SFX_DragNDrop_DROP_03";
        }
        
    }else if([fallObject isEqualToString:@"duck_1"]) {
         if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"English"]) {
            int ranNo = arc4random()%2;
            if(ranNo == 0){
                soundFile = @"Tiggly_GenGreeting_Duck_03";
            }else if (ranNo == 1) {
                soundFile = @"Tiggly_GenGreeting_Duck_03";
            }
         }else{
             soundFile = @"Tiggly_GenGreeting_Duck_24";
         }
        
    }else if([fallObject isEqualToString:@"horse"]) {
         if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"English"]) {
            int ranNo = arc4random()%4;
            
            if(ranNo == 0){
                soundFile = @"Tiggly_GenGreeting_Donkey_03";
            }else if (ranNo == 1) {
                soundFile = @"Tiggly_GenGreeting_Donkey_04";
            }else if(ranNo == 2){
                soundFile = @"Tiggly_Animal_Donkey_ILookGreat_01";
            }else if (ranNo == 3) {
                soundFile = @"Tiggly_Animal_Donkey_NiceShirt_01";
            }
         }else{
             soundFile = @"Tiggly_GenGreeting_Donkey_03";
         }
        
    }else if([fallObject isEqualToString:@"leaves"]) {
        
        int ranNo = arc4random()%2;
        
        if(ranNo == 0){
            soundFile = @"Tiggly_SFX_DragNDrop_DROP_02";
        }else if (ranNo == 1) {
            soundFile = @"Tiggly_SFX_DragNDrop_DROP_03";
        }
        
        
    }else if([fallObject isEqualToString:@"mushroom"]) {
        
        int ranNo = arc4random()%2;
        
        if(ranNo == 0){
            soundFile = @"Tiggly_SFX_DragNDrop_DROP_02";
        }else if (ranNo == 1) {
            soundFile = @"Tiggly_SFX_DragNDrop_DROP_03";
        }
        
    }else if([fallObject isEqualToString:@"pear"]) {
        
        int ranNo = arc4random()%2;
        
        if(ranNo == 0){
            soundFile = @"Tiggly_SFX_DragNDrop_DROP_02";
        }else if (ranNo == 1) {
            soundFile = @"Tiggly_SFX_DragNDrop_DROP_03";
        }
        
    }else if([fallObject isEqualToString:@"raincoat"] || [fallObject isEqualToString:@"pinkRaincoat"] || [fallObject isEqualToString:@"orangeRaincoat"] || [fallObject isEqualToString:@"yellowRaincoat"]) {
        
        int ranNo = arc4random()%2;
        
        if(ranNo == 0){
            soundFile = @"Tiggly_SFX_DragNDrop_DROP_02";
        }else if (ranNo == 1) {
            soundFile = @"Tiggly_SFX_DragNDrop_DROP_03";
        }
        
    }else if([fallObject isEqualToString:@"zebra_2"]) {
        if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"English"]) {
            int ranNo = arc4random()%2;
            if(ranNo == 0){
                soundFile = @"Tiggly_GenGreeting_Zebra_07";
            }else if (ranNo == 1) {
                soundFile = @"Tiggly_GenGreeting_Zebra_08";
            }
        }else{
            soundFile = @"Tiggly_GenGreeting_Zebra_08";
        }
        
    }else if([fallObject isEqualToString:@"witches_hat"] || [fallObject isEqualToString:@"witches_hat_purple"]) {
        
        int ranNo = arc4random()%2;
        
        if(ranNo == 0){
            soundFile = @"Tiggly_SFX_DragNDrop_DROP_02";
        }else if (ranNo == 1) {
            soundFile = @"Tiggly_SFX_DragNDrop_DROP_03";
        }
        
    }
    
    else if ([fallObject isEqualToString:@"blue_jeans"]) {
        int ranNo =arc4random()%2;
        
        if(ranNo == 0){
            soundFile = @"Tiggly_SFX_DragNDrop_DROP_02";
        }else if (ranNo == 1) {
            soundFile = @"Tiggly_SFX_DragNDrop_DROP_03";
        }

    }
    else if ([fallObject isEqualToString:@"green_skirt"]) {
        int ranNo =arc4random()%2;
        
        if(ranNo == 0){
            soundFile = @"Tiggly_SFX_DragNDrop_DROP_02";
        }else if (ranNo == 1) {
            soundFile = @"Tiggly_SFX_DragNDrop_DROP_03";
        }

    }
    else if ([fallObject isEqualToString:@"khakis"]) {
        int ranNo =arc4random()%2;
        
        if(ranNo == 0){
            soundFile = @"Tiggly_SFX_DragNDrop_DROP_02";
        }else if (ranNo == 1) {
            soundFile = @"Tiggly_SFX_DragNDrop_DROP_03";
        }

    }
    else if ([fallObject isEqualToString:@"pink_skirt_fall"]) {
        int ranNo =arc4random()%2;
        
        if(ranNo == 0){
            soundFile = @"Tiggly_SFX_DragNDrop_DROP_02";
        }else if (ranNo == 1) {
            soundFile = @"Tiggly_SFX_DragNDrop_DROP_03";
        }

    }
    else if ([fallObject isEqualToString:@"purple_pants"]) {
        int ranNo =arc4random()%2;
        
        if(ranNo == 0){
            soundFile = @"Tiggly_SFX_DragNDrop_DROP_02";
        }else if (ranNo == 1) {
            soundFile = @"Tiggly_SFX_DragNDrop_DROP_03";
        }

    }
    else if ([fallObject isEqualToString:@"yellow_skirt"]) {
        int ranNo =arc4random()%2;
        
        if(ranNo == 0){
            soundFile = @"Tiggly_SFX_DragNDrop_DROP_02";
        }else if (ranNo == 1) {
            soundFile = @"Tiggly_SFX_DragNDrop_DROP_03";
        }

    }
    
    return soundFile;
}

@end
