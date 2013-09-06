//
//  WinterScene.m
//  TigglyStamp
//
//  Created by cuelogic on 01/07/13.
//  Copyright (c) 2013 cuelogic. All rights reserved.
//

#import "WinterScene.h"
#import "TigglyStampUtils.h"

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

-(NSString *) getAnimalNameSoundForObject:(NSString *) winterObject{
    DebugLog(@"");
    
    NSString *soundFile;
    
    if([winterObject isEqualToString:@"present"]) {
        
        if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"English US"]) {
            int ranNo = random()%2;
            
            if(ranNo == 0){
                soundFile = @"Tiggly_Word_Giftbox_01";
            }else if (ranNo == 1) {
                soundFile = @"Tiggly_Word_Giftbox_Oh_01";
            }
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"English UK"]){
             soundFile = @"gift_box_breng";
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"Portuguese"]){
             soundFile = @"gift box_prtgs";
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"Russian"]){
             soundFile = @"gift_box_ru";
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"Spanish"]){
             soundFile = @"gift box_sp";
        }
        
        
        
    }else if([winterObject isEqualToString:@"cup"]) {
        
        if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"English US"]) {
            int ranNo = random()%2;
            
            if(ranNo == 0){
                soundFile = @"Tiggly_Word_Mug_01";
            }else if (ranNo == 1) {
                soundFile = @"Tiggly_Word_Mug_Ooh_01";
            }
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"English UK"]){
            soundFile = @"mug_breng";
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"Portuguese"]){
            soundFile = @"mug_prtgs";
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"Russian"]){
            soundFile = @"mug_ru";
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"Spanish"]){
            soundFile = @"mug_sp";
        }
        
        
    }else if([winterObject isEqualToString:@"sled"]) {
        
        if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"English US"]) {
            int ranNo = random()%2;
            
            if(ranNo == 0){
                soundFile = @"Tiggly_Word_Sled_01";
            }else if (ranNo == 1) {
                soundFile = @"Tiggly_Word_Sled_Oh_01";
            }
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"English UK"]){
            soundFile = @"snow_sled_breng";
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"Portuguese"]){
            soundFile = @"snow_sled_prtgs";
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"Russian"]){
            soundFile = @"snow sled_ru";
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"Spanish"]){
            soundFile = @"snow sled_sp";
        }
        
       
        
    }else if([winterObject isEqualToString:@"choo"]) {
        
        if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"English US"]) {
            int ranNo = random()%2;
            
            if(ranNo == 0){
                soundFile = @"Tiggly_Word_Train_01";
            }else if (ranNo == 1) {
                soundFile = @"Tiggly_Word_Train_Ooh_01";
            }
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"English UK"]){
            soundFile = @"train_breng";
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"Portuguese"]){
            soundFile = @"train_prtgs";
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"Russian"]){
            soundFile = @"train_ru";
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"Spanish"]){
            soundFile = @"train_sp";
        }   
      
        
    }else if([winterObject isEqualToString:@"fireplace"]) {
        
        if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"English US"]) {
            int ranNo = random()%2;
            
            if(ranNo == 0){
                soundFile = @"Tiggly_Word_Fireplace_01";
            }else if (ranNo == 1) {
                soundFile = @"Tiggly_Word_Fireplace_Ah_01";
            }
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"English UK"]){
            soundFile = @"fire_place_breng";
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"Portuguese"]){
            soundFile = @"fire_place_prtgs";
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"Russian"]){
            soundFile = @"fire_place_ru";
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"Spanish"]){
            soundFile = @"fire place_sp";
        }
        
        
    }else if([winterObject isEqualToString:@"green_sweater"]) {
        if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"English US"]) {
            int ranNo = random()%2;
            
            if(ranNo == 0){
                soundFile = @"Tiggly_Word_Sweater_01";
            }else if (ranNo == 1) {
                soundFile = @"Tiggly_Word_Sweater_Mmm_01";
            }
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"English UK"]){
            soundFile = @"sweater_breng";
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"Portuguese"]){
            soundFile = @"sweater_prtgs";
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"Russian"]){
            soundFile = @"sweater_ru";
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"Spanish"]){
            soundFile = @"sweater_sp";
        }
        
        
    }else if([winterObject isEqualToString:@"ornament"]) {
        
        if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"English US"]) {
            int ranNo = random()%2;
            
            if(ranNo == 0){
                soundFile = @"Tiggly_Word_Ornament_01";
            }else if (ranNo == 1) {
                soundFile = @"Tiggly_Word_Ornament_Wow_01";
            }

        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"English UK"]){
            soundFile = @"Ornoment_breng";
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"Portuguese"]){
            soundFile = @"Ornoment_prtgs";
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"Russian"]){
            soundFile = @"Ornoment_ru";
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"Spanish"]){
            soundFile = @"Ornoment_sp";
        }
        
                
    }else if([winterObject isEqualToString:@"pink_sweater"]) {
        
        if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"English US"]) {
            int ranNo = random()%2;
            
            if(ranNo == 0){
                soundFile = @"Tiggly_Word_Sweater_01";
            }else if (ranNo == 1) {
                soundFile = @"Tiggly_Word_Sweater_Mmm_01";
            }
            
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"English UK"]){
            soundFile = @"sweater_breng";
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"Portuguese"]){
            soundFile = @"sweater_prtgs";
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"Russian"]){
            soundFile = @"sweater_ru";
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"Spanish"]){
            soundFile = @"sweater_sp";
        }
        
       
        
    }else if([winterObject isEqualToString:@"shovel"]) {
        
        if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"English US"]) {
            int ranNo = random()%2;
            
            if(ranNo == 0){
                soundFile = @"Tiggly_Word_Shovel_01";
            }else if (ranNo == 1) {
                soundFile = @"Tiggly_Word_Shovel_Huh_01";
            }
            
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"English UK"]){
            soundFile = @"";
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"Portuguese"]){
            soundFile = @"shovel_prtgs";
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"Russian"]){
            soundFile = @"";
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"Spanish"]){
            soundFile = @"shovel_sp";
        }
        
        
        
    }else if([winterObject isEqualToString:@"bells"]) {
        
        if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"English US"]) {
            int ranNo = random()%2;
            
            if(ranNo == 0){
                soundFile = @"Tiggly_Word_Bell_01";
            }else if (ranNo == 1) {
                soundFile = @"Tiggly_Word_Bell_Wow";
            }
            
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"English UK"]){
            soundFile = @"bell_breng";
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"Portuguese"]){
            soundFile = @"bell_prtgs";
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"Russian"]){
            soundFile = @"bell_ru";
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"Spanish"]){
            soundFile = @"bell_sp";
        }
        
        
    }else if([winterObject isEqualToString:@"blue_hat"] ) {
        
        if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"English US"]) {
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

            
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"English UK"]){
            soundFile = @"hat_breng";
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"Portuguese"]){
            soundFile = @"hat_prtgs";
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"Russian"]){
            soundFile = @"hat_ru";
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"Spanish"]){
            soundFile = @"hat_sp";
        }
        
                
        
    }else if([winterObject isEqualToString:@"pink_hat"] ) {
        
        if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"English US"]) {
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
            
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"English UK"]){
            soundFile = @"hat_breng";
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"Portuguese"]){
            soundFile = @"hat_prtgs";
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"Russian"]){
            soundFile = @"hat_ru";
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"Spanish"]){
            soundFile = @"hat_sp";
        }
        
        
        
        
    }else if([winterObject isEqualToString:@"deer"] ) {
        
        if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"English US"]) {
            
            int ranNo = random()%2;
            
            if(ranNo == 0){
                soundFile = @"Tiggly_GenGreeting_Moose_04";
            }else if (ranNo == 1) {
                soundFile = @"Tiggly_GenGreeting_Moose_07";
            }

            
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"English UK"]){
            soundFile = @"";
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"Portuguese"]){
            soundFile = @"";
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"Russian"]){
            soundFile = @"";
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"Spanish"]){
            soundFile = @"";
        }
        
        
    }else if([winterObject isEqualToString:@"deer_2"] ) {
        
        
        
        if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"English US"]) {
            
            int ranNo = random()%7;
            
            if(ranNo == 0){
                soundFile = @"Tiggly_GenGreeting_Reindeer_09";
            }else if (ranNo == 1) {
                soundFile = @"Tiggly_GenGreeting_Reindeer_09";
            }else if (ranNo == 2) {
                soundFile = @"Tiggly_GenGreeting_Reindeer_09";
            }else if (ranNo == 3) {
                soundFile = @"Tiggly_GenGreeting_Reindeer_09";
            }else if (ranNo == 4) {
                soundFile = @"Tiggly_GenGreeting_Reindeer_09";
            }else if (ranNo == 5) {
                soundFile = @"Tiggly_GenGreeting_Reindeer_09";
            }else if (ranNo == 6) {
                soundFile = @"Tiggly_GenGreeting_Reindeer_09";
            }
            
            
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"English UK"]){
            soundFile = @"";
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"Portuguese"]){
            soundFile = @"";
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"Russian"]){
            soundFile = @"";
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"Spanish"]){
            soundFile = @"";
        }
        
        
        
    }else if([winterObject isEqualToString:@"green_umbrella"] ) {
        
        if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"English US"]) {
            
            int ranNo = random()%2;
            
            if(ranNo == 0){
                soundFile = @"Tiggly_Word_Umbrella_01";
            }else if (ranNo == 1) {
                soundFile = @"Tiggly_Word_Umbrella_01";
            }
            
            
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"English UK"]){
            soundFile = @"umbrella_breng";
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"Portuguese"]){
            soundFile = @"umbrella_prtgs";
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"Russian"]){
            soundFile = @"umbrella_ru";
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"Spanish"]){
            soundFile = @"umbrella_sp";
        }

        
        
    }else if([winterObject isEqualToString:@"hot_choclate"] ) {
        
        if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"English US"]) {
            
            int ranNo = random()%2;
            
            if(ranNo == 0){
                soundFile = @"Tiggly_Word_Cupcake_01";
            }else if (ranNo == 1) {
                soundFile = @"Tiggly_Word_Cupcake_Mmm_01";
            }
            
            
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"English UK"]){
            soundFile = @"cupcake_breng";
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"Portuguese"]){
            soundFile = @"cupcake_prtgs";
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"Russian"]){
            soundFile = @"hot cupcake_ru";
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"Spanish"]){
            soundFile = @"hot cupcake_sp";
        }

      
        
    }else if([winterObject isEqualToString:@"lightbulb"] ) {
        
        if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"English US"]) {
            
            int ranNo = random()%2;
            
            if(ranNo == 0){
                soundFile = @"Tiggly_Word_Lights_01";
            }else if (ranNo == 1) {
                soundFile = @"Tiggly_Word_Lights_Ooh_01";
            }
            
            
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"English UK"]){
            soundFile = @"lights_breng";
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"Portuguese"]){
            soundFile = @"lights_prtgs";
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"Russian"]){
            soundFile = @"lights_ru";
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"Spanish"]){
            soundFile = @"lights_sp";
        }
        
       
        
    }else if([winterObject isEqualToString:@"purple_umbrella"] ) {
        
        
        if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"English US"]) {
            
            int ranNo = random()%2;
            
            if(ranNo == 0){
                soundFile = @"Tiggly_Word_Umbrella_01";
            }else if (ranNo == 1) {
                soundFile = @"Tiggly_Word_Umbrella_01";
            }
            
            
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"English UK"]){
            soundFile = @"umbrella_breng";
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"Portuguese"]){
            soundFile = @"umbrella_prtgs";
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"Russian"]){
            soundFile = @"umbrella_ru";
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"Spanish"]){
            soundFile = @"umbrella_sp";
        }
        
       
        
    }else if([winterObject isEqualToString:@"bear"] ) {
        if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"English US"]) {
            
            int ranNo = random()%3;
            
            if(ranNo == 0){
                soundFile = @"Tiggly_GenGreeting_Bear_02";
            }else if (ranNo == 1) {
                soundFile = @"Tiggly_GenGreeting_Bear_06";
            }else if (ranNo == 2) {
                soundFile = @"Tiggly_GenGreeting_Bear_11";
            }
            
            
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"English UK"]){
            soundFile = @"bear_breng";
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"Portuguese"]){
            soundFile = @"bear_prtgs";
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"Russian"]){
            soundFile = @"bear_ru";
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"Spanish"]){
            soundFile = @"bear_sp";
        }
        
        
    }else if([winterObject isEqualToString:@"bird"] ) {
        
        if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"English US"]) {
            
            int ranNo = random()%2;
            
            if(ranNo == 0){
                soundFile = @"Tiggly_GenGreeting_Bird_05";
            }else if (ranNo == 1) {
                soundFile = @"Tiggly_GenGreeting_Bird_06";
            }
            
            
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"English UK"]){
            soundFile = @"bird_breng";
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"Portuguese"]){
            soundFile = @"bird_prtgs";
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"Russian"]){
            soundFile = @"bird_ru";
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"Spanish"]){
            soundFile = @"bird_sp";
        }
        
        
        
    }else if([winterObject isEqualToString:@"candy"] ) {
        
        if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"English US"]) {
            
            int ranNo = random()%2;
            
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
        }
        
        
        
    }else if([winterObject isEqualToString:@"choclate"] ) {
        
        if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"English US"]) {
            
            int ranNo = random()%2;
            
            if(ranNo == 0){
                soundFile = @"Tiggly_Word_HotChocolate_01";
            }else if (ranNo == 1) {
                soundFile = @"Tiggly_Word_HotChocolate_Mmm_01";
            }
            
            
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"English UK"]){
            soundFile = @"hot_chocolate_breng";
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"Portuguese"]){
            soundFile = @"hot_chocolate_prtgs";
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"Russian"]){
            soundFile = @"hot chocolate_ru";
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"Spanish"]){
            soundFile = @"hot chocolate_sp";
        }
        
        
        
    }else if([winterObject isEqualToString:@"girl"] ) {
        
        if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"English US"]) {
            
            int ranNo = random()%4;
            
            if(ranNo == 0){
                soundFile = @"Tiggly_GenGreeting_Girl_01";
            }else if (ranNo == 1) {
                soundFile = @"Tiggly_GenGreeting_Girl_03";
            }else if (ranNo == 2) {
                soundFile = @"Tiggly_GenGreeting_Girl_04";
            }else if (ranNo == 3) {
                soundFile = @"Tiggly_GenGreeting_Girl_05";
            }
            
            
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"English UK"]){
            soundFile = @"";
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"Portuguese"]){
            soundFile = @"";
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"Russian"]){
            soundFile = @"";
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"Spanish"]){
            soundFile = @"";
        }
        
        
        
        
    }else if([winterObject isEqualToString:@"igloo"] ) {
        
        if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"English US"]) {
            
            int ranNo = random()%3;
            
            if(ranNo == 0){
                soundFile = @"Tiggly_Word_Igloo_01";
            }else if (ranNo == 1) {
                soundFile = @"Tiggly_Word_Igloo_Brr_01";
            }else if (ranNo == 2) {
                soundFile = @"Tiggly_Word_Igloo_Oh_01";
            }
            
            
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"English UK"]){
            soundFile = @"igloo_breng";
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"Portuguese"]){
            soundFile = @"igloo_prtgs";
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"Russian"]){
            soundFile = @"igloo_ru";
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"Spanish"]){
            soundFile = @"igloo_sp";
        }

        
       
        
    }else if([winterObject isEqualToString:@"penguin_blue"] ) {
        
        if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"English US"]) {
            
            int ranNo = random()%2;
            
            if(ranNo == 0){
                soundFile = @"Tiggly_GenGreeting_Penguin_10";
            }else if (ranNo == 1) {
                soundFile = @"Tiggly_GenGreeting_Penguin_11";
            }

            
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"English UK"]){
            soundFile = @"Penguin_breng";
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"Portuguese"]){
            soundFile = @"Penguin_prtgs";
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"Russian"]){
            soundFile = @"Penguin_ru";
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"Spanish"]){
            soundFile = @"Penguin_sp";
        }
        
                
    }else if([winterObject isEqualToString:@"penguin_skate"] ) {
        
        if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"English US"]) {
            
            int ranNo = random()%2;
            
            if(ranNo == 0){
                soundFile = @"Tiggly_GenGreeting_Penguin_10";
            }else if (ranNo == 1) {
                soundFile = @"Tiggly_GenGreeting_Penguin_11";
            }
            
            
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"English UK"]){
            soundFile = @"Penguin_breng";
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"Portuguese"]){
            soundFile = @"Penguin_prtgs";
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"Russian"]){
            soundFile = @"Penguin_ru";
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"Spanish"]){
            soundFile = @"Penguin_sp";
        }
        
        
        
    }else if([winterObject isEqualToString:@"penguin"] ) {
        if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"English US"]) {
            
            int ranNo = random()%2;
            
            if(ranNo == 0){
                soundFile = @"Tiggly_GenGreeting_Penguin_10";
            }else if (ranNo == 1) {
                soundFile = @"Tiggly_GenGreeting_Penguin_11";
            }
            
            
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"English UK"]){
            soundFile = @"Penguin_breng";
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"Portuguese"]){
            soundFile = @"Penguin_prtgs";
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"Russian"]){
            soundFile = @"Penguin_ru";
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"Spanish"]){
            soundFile = @"Penguin_sp";
        }
    }else if([winterObject isEqualToString:@"snowglobe"] ) {
        
        if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"English US"]) {
            
            int ranNo = random()%2;
            
            if(ranNo == 0){
                soundFile = @"Tiggly_Word_Snowglobe_01";
            }else if (ranNo == 1) {
                soundFile = @"Tiggly_Word_Snowglobe_Ooh_01";
            }
            
            
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"English UK"]){
            soundFile = @"snowglobe_breng";
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"Portuguese"]){
            soundFile = @"snowglobe_prtgs";
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"Russian"]){
            soundFile = @"snowglobe_ru";
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"Spanish"]){
            soundFile = @"snowglobe_sp";
        }
        
        
        
    }else if([winterObject isEqualToString:@"snowman"] ) {
        
        if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"English US"]) {
            
            int ranNo = random()%3;
            
            if(ranNo == 0){
                soundFile = @"Tiggly_Word_SnowMan_DaDaa_01";
            }else if (ranNo == 1) {
                soundFile = @"Tiggly_Word_SnowMan_DaDaa_02";
            }else if (ranNo == 2) {
                soundFile = @"Tiggly_Word_SnowMan_DaDaa_03";
            }
            
            
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"English UK"]){
            soundFile = @"";
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"Portuguese"]){
            soundFile = @"";
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"Russian"]){
            soundFile = @"";
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"Spanish"]){
            soundFile = @"";
        }
        
        
        
    }else if([winterObject isEqualToString:@"chipmunk"] ) {
        if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"English US"]) {
            
            
            int ranNo = random()%2;
            
            if(ranNo == 0){
                soundFile = @"Tiggly_GenGreeting_Chipmunk_04";
            }else if (ranNo == 1) {
                soundFile = @"Tiggly_GenGreeting_Chipmunk_05";
            }
            
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"English UK"]){
            soundFile = @"chipmunk_breng";
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"Portuguese"]){
            soundFile = @"chipmunk_prtgs";
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"Russian"]){
            soundFile = @"chipmunk_ru";
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"Spanish"]){
            soundFile = @"chipmunk_sp";
        }
        
        
    }else if([winterObject isEqualToString:@"fox"] ) {
        
        if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"English US"]) {
            
            
            int ranNo = random()%6;
            
            if(ranNo == 0){
                soundFile = @"Tiggly_GenGreeting_Fox_01";
            }else if (ranNo == 1) {
                soundFile = @"Tiggly_GenGreeting_Fox_02";
            }else if (ranNo == 2) {
                soundFile = @"Tiggly_GenGreeting_Fox_03";
            }else if (ranNo == 3) {
                soundFile = @"Tiggly_GenGreeting_Fox_06";
            }else if(ranNo == 4){
                soundFile = @"Tiggly_GenGreeting_Fox_07";
            }else if (ranNo == 5) {
                soundFile = @"Tiggly_GenGreeting_Fox_08";
            }
            
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"English UK"]){
            soundFile = @"fox_breng";
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"Portuguese"]){
            soundFile = @"fox_prtgs";
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"Russian"]){
            soundFile = @"fox_ru";
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"Spanish"]){
            soundFile = @"fox_sp";
        }

        
      
        
    }else if([winterObject isEqualToString:@"ornament_purple"] ) {
        
        
        if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"English US"]) {
            
            
            int ranNo = random()%2;
            
            if(ranNo == 0){
                soundFile = @"Tiggly_Word_Ornament_01";
            }else if (ranNo == 1) {
                soundFile = @"Tiggly_Word_Ornament_Wow_01";
            }
            
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"English UK"]){
            soundFile = @"Ornoment_breng";
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"Portuguese"]){
            soundFile = @"Ornoment_prtgs";
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"Russian"]){
            soundFile = @"Ornoment_ru";
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"Spanish"]){
            soundFile = @"Ornoment_sp";
        }
        
        
        
    }else if([winterObject isEqualToString:@"snowflake_1"] ) {
        
        if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"English US"]) {
            
            
            int ranNo = random()%2;
            
            if(ranNo == 0){
                soundFile = @"Tiggly_Word_Snow_01";
            }else if (ranNo == 1) {
                soundFile = @"Tiggly_Word_Snow_Ooh_01";
            }
            
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"English UK"]){
            soundFile = @"Snow_breng";
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"Portuguese"]){
            soundFile = @"Snow_prtgs";
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"Russian"]){
            soundFile = @"Snow_ru";
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"Spanish"]){
            soundFile = @"Snow_sp";
        }
        
        
        
    }else if([winterObject isEqualToString:@"snowflake_2"] ) {
        if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"English US"]) {
            
            
            int ranNo = random()%2;
            
            if(ranNo == 0){
                soundFile = @"Tiggly_Word_Snow_01";
            }else if (ranNo == 1) {
                soundFile = @"Tiggly_Word_Snow_Ooh_01";
            }
            
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"English UK"]){
            soundFile = @"Snow_breng";
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"Portuguese"]){
            soundFile = @"Snow_prtgs";
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"Russian"]){
            soundFile = @"Snow_ru";
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"Spanish"]){
            soundFile = @"Snow_sp";
        }
        
    }else if([winterObject isEqualToString:@"snowflake_3"] ) {
        if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"English US"]) {
            
            
            int ranNo = random()%2;
            
            if(ranNo == 0){
                soundFile = @"Tiggly_Word_Snow_01";
            }else if (ranNo == 1) {
                soundFile = @"Tiggly_Word_Snow_Ooh_01";
            }
            
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"English UK"]){
            soundFile = @"Snow_breng";
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"Portuguese"]){
            soundFile = @"Snow_prtgs";
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"Russian"]){
            soundFile = @"Snow_ru";
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"Spanish"]){
            soundFile = @"Snow_sp";
        }
        
    }else if([winterObject isEqualToString:@"star_cookie"] ) {
        
        if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"English US"]) {
            
            
            int ranNo = random()%2;
            
            if(ranNo == 0){
                soundFile = @"Tiggly_Word_Cookie_01";
            }else if (ranNo == 1) {
                soundFile = @"Tiggly_Word_Cookie_Mmm_01";
            }
            
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"English UK"]){
            soundFile = @"cookie_breng";
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"Portuguese"]){
            soundFile = @"cookie_prtgs";
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"Russian"]){
            soundFile = @"cookie_ru";
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"Spanish"]){
            soundFile = @"cookie_sp";
        }
        
        
        
    }else if([winterObject isEqualToString:@"star_cookie_2"] ) {
        
        
        if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"English US"]) {
            
            int ranNo = random()%2;
            
            if(ranNo == 0){
                soundFile = @"Tiggly_Word_Cookie_01";
            }else if (ranNo == 1) {
                soundFile = @"Tiggly_Word_Cookie_Mmm_01";
            }
            
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"English UK"]){
            soundFile = @"cookie_breng";
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"Portuguese"]){
            soundFile = @"cookie_prtgs";
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"Russian"]){
            soundFile = @"cookie_ru";
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"Spanish"]){
            soundFile = @"cookie_sp";
        }
        
        
    }    
    return soundFile;
}



-(NSString *) getAnimalDropSoundForObject:(NSString *) winterObject{
    DebugLog(@"");
    
    NSString *soundFile;
    
    if([winterObject isEqualToString:@"present"]) {
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
    }else if([winterObject isEqualToString:@"cup"]) {
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
    }else if([winterObject isEqualToString:@"sled"]) {
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
    }else if([winterObject isEqualToString:@"choo"]) {
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
    }else if([winterObject isEqualToString:@"fireplace"]) {
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
    }else if([winterObject isEqualToString:@"green_sweater"]) {
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
    }else if([winterObject isEqualToString:@"ornament"]) {
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
    }else if([winterObject isEqualToString:@"pink_sweater"]) {
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
    }else if([winterObject isEqualToString:@"shovel"]) {
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
        
    }else if([winterObject isEqualToString:@"bells"]) {
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
    }else if([winterObject isEqualToString:@"blue_hat"] ) {
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
    }else if([winterObject isEqualToString:@"pink_hat"] ) {
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
    }else if([winterObject isEqualToString:@"deer"] ) {
        int ranNo = random()%2;
        
        if(ranNo == 0){
            soundFile = @"Tiggly_GenGreeting_Moose_04";
        }else if (ranNo == 1) {
            soundFile = @"Tiggly_GenGreeting_Moose_07";
        }

        
    }else if([winterObject isEqualToString:@"deer_2"] ) {
        int ranNo = random()%2;
        
        if(ranNo == 0){
            soundFile = @"Tiggly_GenGreeting_Reindeer_056";
        }else if (ranNo == 1) {
            soundFile = @"Tiggly_GenGreeting_Reindeer_07";
        }
        
    }else if([winterObject isEqualToString:@"green_umbrella"] ) {
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
    }else if([winterObject isEqualToString:@"hot_choclate"] ) {
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
    }else if([winterObject isEqualToString:@"lightbulb"] ) {
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
    }else if([winterObject isEqualToString:@"purple_umbrella"] ) {
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
    }else if([winterObject isEqualToString:@"bear"] ) {
        int ranNo = random()%6;
        
        if(ranNo == 0){
            soundFile = @"Tiggly_GenGreeting_Bear_03";
        }else if (ranNo == 1) {
            soundFile = @"Tiggly_GenGreeting_Bear_04";
        }else if (ranNo == 2) {
            soundFile = @"Tiggly_GenGreeting_Bear_05";
        }else if (ranNo == 3) {
            soundFile = @"Tiggly_GenGreeting_Bear_07";
        }else if (ranNo == 4) {
            soundFile = @"Tiggly_GenGreeting_Bear_09";
        }else if (ranNo == 5) {
            soundFile = @"Tiggly_GenGreeting_Bear_10";
        }
        
    }else if([winterObject isEqualToString:@"bird"] ) {
        int ranNo = random()%10;
        
        if(ranNo == 0){
            soundFile = @"Tiggly_GenGreeting_Bird_02";
        }else if (ranNo == 1) {
            soundFile = @"Tiggly_GenGreeting_Bird_08";
        }else if (ranNo == 2) {
            soundFile = @"Tiggly_GenGreeting_Bird_09";
        }else if (ranNo == 3) {
            soundFile = @"Tiggly_GenGreeting_Bird_10";
        }else if (ranNo == 4) {
            soundFile = @"Tiggly_GenGreeting_Bird_12";
        }else if (ranNo == 5) {
            soundFile = @"Tiggly_GenGreeting_Bird_13";
        }else if (ranNo == 6) {
            soundFile = @"Tiggly_GenGreeting_Bird_14";
        }else if (ranNo == 7) {
            soundFile = @"Tiggly_GenGreeting_Bird_16";
        }else if (ranNo == 8) {
            soundFile = @"Tiggly_GenGreeting_Bird_17";
        }else if (ranNo == 9) {
            soundFile = @"Tiggly_GenGreeting_Bird_18";
        }
        
    }else if([winterObject isEqualToString:@"candy"] ) {
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
        
    }else if([winterObject isEqualToString:@"choclate"] ) {
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
    }else if([winterObject isEqualToString:@"girl"] ) {
        int ranNo = random()%5;
        
        if(ranNo == 0){
            soundFile = @"Tiggly_GenGreeting_Girl_01";
        }else if (ranNo == 1) {
            soundFile = @"Tiggly_GenGreeting_Girl_03";
        }else if (ranNo == 2) {
            soundFile = @"Tiggly_GenGreeting_Girl_04";
        }else if (ranNo == 3) {
            soundFile = @"Tiggly_GenGreeting_Girl_05";
        }else if (ranNo == 4) {
            soundFile = @"Tiggly_GenGreeting_Girl_06";
        }
        
    }else if([winterObject isEqualToString:@"igloo"] ) {
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
    }else if([winterObject isEqualToString:@"penguin_blue"] ) {
        int ranNo = random()%5;
        
        if(ranNo == 0){
            soundFile = @"Tiggly_GenGreeting_Penguin_03";
        }else if (ranNo == 1) {
            soundFile = @"Tiggly_GenGreeting_Penguin_04";
        }else if (ranNo == 2) {
            soundFile = @"Tiggly_GenGreeting_Penguin_05";
        }else if (ranNo == 3) {
            soundFile = @"Tiggly_GenGreeting_Penguin_07";
        }else if(ranNo == 4){
            soundFile = @"Tiggly_GenGreeting_Penguin_08";
        }
        
    }else if([winterObject isEqualToString:@"penguin_skate"] ) {
        int ranNo = random()%5;
        
        if(ranNo == 0){
            soundFile = @"Tiggly_GenGreeting_Penguin_03";
        }else if (ranNo == 1) {
            soundFile = @"Tiggly_GenGreeting_Penguin_04";
        }else if (ranNo == 2) {
            soundFile = @"Tiggly_GenGreeting_Penguin_05";
        }else if (ranNo == 3) {
            soundFile = @"Tiggly_GenGreeting_Penguin_07";
        }else if(ranNo == 4){
            soundFile = @"Tiggly_GenGreeting_Penguin_08";
        }
        
    }else if([winterObject isEqualToString:@"penguin"] ) {
        int ranNo = random()%5;
        
        if(ranNo == 0){
            soundFile = @"Tiggly_GenGreeting_Penguin_03";
        }else if (ranNo == 1) {
            soundFile = @"Tiggly_GenGreeting_Penguin_04";
        }else if (ranNo == 2) {
            soundFile = @"Tiggly_GenGreeting_Penguin_05";
        }else if (ranNo == 3) {
            soundFile = @"Tiggly_GenGreeting_Penguin_07";
        }else if(ranNo == 4){
            soundFile = @"Tiggly_GenGreeting_Penguin_08";
        }
        
    }else if([winterObject isEqualToString:@"snowglobe"] ) {
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
        
    }else if([winterObject isEqualToString:@"snowman"] ) {
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
        
    }else if([winterObject isEqualToString:@"chipmunk"] ) {
        int ranNo = random()%4;
        
        if(ranNo == 0){
            soundFile = @"Tiggly_GenGreeting_Chipmunk_03";
        }else if (ranNo == 1) {
            soundFile = @"Tiggly_GenGreeting_Chipmunk_07";
        }else if (ranNo == 2) {
            soundFile = @"Tiggly_GenGreeting_Chipmunk_08";
        }else if (ranNo == 3) {
            soundFile = @"Tiggly_GenGreeting_Chipmunk_09";
        }
        
    }else if([winterObject isEqualToString:@"fox"] ) {
        int ranNo = random()%3;
        
        if(ranNo == 0){
            soundFile = @"Tiggly_GenGreeting_Fox_04";
        }else if (ranNo == 1) {
            soundFile = @"Tiggly_GenGreeting_Fox_05";
        }else if (ranNo == 2) {
            soundFile = @"Tiggly_GenGreeting_Fox_09";
        }
        
    }else if([winterObject isEqualToString:@"ornament_purple"] ) {
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
        
    }else if([winterObject isEqualToString:@"snowflake_1"] ) {
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
        
    }else if([winterObject isEqualToString:@"snowflake_2"] ) {
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
        
    }else if([winterObject isEqualToString:@"snowflake_3"] ) {
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
        
    }else if([winterObject isEqualToString:@"star_cookie"] ) {
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
        
    }else if([winterObject isEqualToString:@"star_cookie_2"] ) {
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
