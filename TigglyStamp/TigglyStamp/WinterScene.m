//
//  WinterScene.m
//  TigglyStamp
//
//  Created by cuelogic on 01/07/13.
//  Copyright (c) 2013 cuelogic. All rights reserved.
//

#import "WinterScene.h"
#import "TigglyStampUtils.h"

@implementation WinterScene{
    
    NSMutableArray *winterSquareObjects;
    NSMutableArray *winterTriangleObjects;
    NSMutableArray *winterStarObjects;
    NSMutableArray *winterCircleObjects;
    
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
        winterSquareObjects = [[NSMutableArray alloc] initWithObjects:
                               @"present",
                               @"cup",
                               @"sled",
                               @"choo",
                               @"fireplace",
                               @"green_sweater",
                               @"ornament",
                               @"pink_sweater",
                               @"shovel",
                               @"cordoroy_pants",
                               @"blueSquareJeans",
                               @"stripped_pants",nil];
        
        winterTriangleObjects = [[NSMutableArray alloc] initWithObjects:
                                 @"bells",
                                 @"blue_hat",
                                 @"pink_hat",
                                 @"deer",
                                 @"deer_2",
                                 @"green_umbrella",
                                 @"hot_choclate",
                                 @"lightbulb",
                                 @"purple_umbrella",
                                 @"pink_skirt_winter",
                                 @"winter_coat",
                                 @"winter_coat_purple",nil];
        
        winterCircleObjects = [[NSMutableArray alloc] initWithObjects:
                               @"bear",
                               @"bird",
                               @"candy",
                               @"choclate",
                               @"girl",
                               @"igloo",
                               @"penguin_blue",
                               @"penguin_skate",
                               @"penguin",
                               @"snowglobe",
                               @"snowman",nil];
        
        winterStarObjects = [[NSMutableArray alloc] initWithObjects:
                             @"chipmunk",
                             @"fox",
                             @"ornament_purple",
                             @"snowflake_1",
                             @"snowflake_2",
                             @"snowflake_3",
                             @"star_cookie",
                             @"star_cookie_2",
                             nil];
            
    }
    return self;
}

#pragma mark -
#pragma mark =======================================
#pragma mark Helpers
#pragma mark =======================================


-(NSString *) getObjectForShape:(NSString *)shape;{
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
            [winterTriangleObjects addObject:@"lightbulb"];
            [winterTriangleObjects addObject:@"purple_umbrella"];
            [winterTriangleObjects addObject:@"pink_skirt_winter"];
            [winterTriangleObjects addObject:@"winter_coat"];
            [winterTriangleObjects addObject:@"winter_coat_purple"];
            size = 12;
        
        }
        currentObject =  arc4random()%size;
        objectName = [winterTriangleObjects objectAtIndex:currentObject];
        DebugLog(@"winterTriangleObject: %@", objectName);
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
            [winterCircleObjects addObject:@"girl"];
            [winterCircleObjects addObject:@"snowman"];
            size = 9;
          }
        currentObject =  arc4random()%size;
        objectName = [winterCircleObjects objectAtIndex:currentObject];
        DebugLog(@"winterCircleObject: %@", objectName);
        
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
            [winterSquareObjects addObject:@"cordoroy_pants"];
            [winterSquareObjects addObject:@"blueSquareJeans"];
            [winterSquareObjects addObject:@"stripped_pants"];
            
            size = 12;
        }
        currentObject =  arc4random()%size;
        objectName = [winterSquareObjects objectAtIndex:currentObject];
        DebugLog(@"winterSquareObject: %@", objectName);
        
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
        DebugLog(@"winterStarObject: %@", objectName);
        
    }
    [self removeDrawnObject:objectName forShape:shape];
    return objectName;
}

-(void)removeDrawnObject:(NSString *)objectName forShape:(NSString *)shape{
    DebugLog(@"");
    if([shape isEqualToString:@"triangle"]){
        [winterTriangleObjects removeObject:objectName];
    }
    if([shape isEqualToString:@"square"]){
        [winterSquareObjects removeObject:objectName];
    }
    if([shape isEqualToString:@"star"]){
        [winterStarObjects removeObject:objectName];
    }
    if([shape isEqualToString:@"circle"]){
        [winterCircleObjects removeObject:objectName];
    }
    
}

-(void)removeAllObjects{
    DebugLog(@"");
    [winterCircleObjects removeAllObjects];
    [winterStarObjects removeAllObjects];
    [winterSquareObjects removeAllObjects];
    [winterTriangleObjects removeAllObjects];
}

#pragma mark -
#pragma mark =======================================
#pragma mark Color Handling
#pragma mark =======================================

-(UIColor *)getRGBValueForShape:(NSString *)shapeToDraw{
    UIColor *color;
    
    if ([shapeToDraw isEqualToString:@"choo"]) {
        color = [UIColor colorWithRed:255.0/255.0 green:235.0/255.0 blue:55.0/255.0 alpha:1];
    }
    if ([shapeToDraw isEqualToString:@"ornament"]) {
        color = [UIColor colorWithRed:236.0/255.0 green:17.0/255.0 blue:99.0/255.0 alpha:1];
    }
    if ([shapeToDraw isEqualToString:@"shovel"]) {
        color = [UIColor colorWithRed:171.0/255.0 green:73.0/255.0 blue:156.0/255.0 alpha:1];
    }
    if ([shapeToDraw isEqualToString:@"fireplace"]) {
        color = [UIColor colorWithRed:247.0/255.0 green:147.0/255.0 blue:30.0/255.0 alpha:1];
    }
    if ([shapeToDraw isEqualToString:@"pink_sweater"]) {
        color = [UIColor colorWithRed:235.0/255.0 green:19.0/255.0 blue:142.0/255.0 alpha:1];
    }
    if ([shapeToDraw isEqualToString:@"green_sweater"]) {
        color = [UIColor colorWithRed:177.0/255.0 green:210.0/255.0 blue:53.0/255.0 alpha:1];
    }
    if ([shapeToDraw isEqualToString:@"present"]) {
        color = [UIColor colorWithRed:32.0/255.0 green:87.0/255.0 blue:213.0/255.0 alpha:1];
    }
    if ([shapeToDraw isEqualToString:@"cup"]) {
        color = [UIColor colorWithRed:228.0/255.0 green:51.0/255.0 blue:12.0/255.0 alpha:1];
    }
    if ([shapeToDraw isEqualToString:@"sled"]) {
        color = [UIColor colorWithRed:228.0/255.0 green:51.0/255.0 blue:12.0/255.0 alpha:1];
    }
    if ([shapeToDraw isEqualToString:@"bells"]) {
        color = [UIColor colorWithRed:255.0/255.0 green:235.0/255.0 blue:55.0/255.0 alpha:1];
    }
    if ([shapeToDraw isEqualToString:@"blue_hat"]) {
        color = [UIColor colorWithRed:0.0/255.0 green:168.0/255.0 blue:222.0/255.0 alpha:1];
    }
    if ([shapeToDraw isEqualToString:@"pink_hat"]) {
        color = [UIColor colorWithRed:235.0/255.0 green:19.0/255.0 blue:142.0/255.0 alpha:1];
    }
    if ([shapeToDraw isEqualToString:@"deer"]) {
        color = [UIColor colorWithRed:197.0/255.0 green:105.0/255.0 blue:61.0/255.0 alpha:1];
    }
    if ([shapeToDraw isEqualToString:@"deer_2"]) {
        color = [UIColor colorWithRed:247.0/255.0 green:147.0/255.0 blue:30.0/255.0 alpha:1];
    }
    if ([shapeToDraw isEqualToString:@"green_umbrella"]) {
        color = [UIColor colorWithRed:145.0/255.0 green:189.0/255.0 blue:73.0/255.0 alpha:1];
    }
    if ([shapeToDraw isEqualToString:@"hot_choclate"]) {
        color = [UIColor colorWithRed:176.0/255.0 green:134.0/255.0 blue:106.0/255.0 alpha:1];
    }
    if ([shapeToDraw isEqualToString:@"lightbulb"]) {
        color = [UIColor colorWithRed:236.0/255.0 green:28.0/255.0 blue:35.0/255.0 alpha:1];
    }
    if ([shapeToDraw isEqualToString:@"purple_umbrella"]) {
        color = [UIColor colorWithRed:169.0/255.0 green:103.0/255.0 blue:170.0/255.0 alpha:1];
    }
    if ([shapeToDraw isEqualToString:@"bear"]) {
        color = [UIColor colorWithRed:250.0/255.0 green:184.0/255.0 blue:133.0/255.0 alpha:1];
    }
    if ([shapeToDraw isEqualToString:@"bird"]) {
        color = [UIColor colorWithRed:246.0/255.0 green:149.0/255.0 blue:124.0/255.0 alpha:1];
    }
    if ([shapeToDraw isEqualToString:@"candy"]) {
        color = [UIColor colorWithRed:234.0/255.0 green:21.0/255.0 blue:43.0/255.0 alpha:1];
    }
    if ([shapeToDraw isEqualToString:@"choclate"]) {
        color = [UIColor colorWithRed:175.0/255.0 green:84.0/255.0 blue:28.0/255.0 alpha:1];
    }
    if ([shapeToDraw isEqualToString:@"girl"]) {
        color = [UIColor colorWithRed:253.0/255.0 green:223.0/255.0 blue:192.0/255.0 alpha:1];
    }
    if ([shapeToDraw isEqualToString:@"igloo"]) {
        color = [UIColor colorWithRed:199.0/255.0 green:234.0/255.0 blue:245.0/255.0 alpha:1];
    }
    if ([shapeToDraw isEqualToString:@"penguin_blue"]) {
        color = [UIColor colorWithRed:0.0/255.0 green:131.0/255.0 blue:201.0/255.0 alpha:1];
    }
    if ([shapeToDraw isEqualToString:@"penguin_skate"]) {
        color = [UIColor colorWithRed:169.0/255.0 green:103.0/255.0 blue:170.0/255.0 alpha:1];
    }
    if ([shapeToDraw isEqualToString:@"penguin"]) {
        color = [UIColor colorWithRed:96.0/255.0 green:199.0/255.0 blue:208.0/255.0 alpha:1];
    }
    if ([shapeToDraw isEqualToString:@"snowglobe"]) {
        color = [UIColor colorWithRed:173.0/255.0 green:223.0/255.0 blue:232.0/255.0 alpha:1];
    }
    if ([shapeToDraw isEqualToString:@"snowman"]) {
        color = [UIColor colorWithRed:255.0/255.0 green:249.0/255.0 blue:241.0/255.0 alpha:1];
    }
    if ([shapeToDraw isEqualToString:@"chipmunk"]) {
        color = [UIColor colorWithRed:250.0/255.0 green:180.0/255.0 blue:111.0/255.0 alpha:1];
    }
    if ([shapeToDraw isEqualToString:@"fox"]) {
        color = [UIColor colorWithRed:248.0/255.0 green:159.0/255.0 blue:27.0/255.0 alpha:1];
    }
    if ([shapeToDraw isEqualToString:@"ornament_purple"]) {
        color = [UIColor colorWithRed:171.0/255.0 green:73.0/255.0 blue:156.0/255.0 alpha:1];
    }
    if ([shapeToDraw isEqualToString:@"snowflake_1"]) {
        color = [UIColor colorWithRed:255.0/255.0 green:197.0/255.0 blue:10.0/255.0 alpha:1];
    }
    if ([shapeToDraw isEqualToString:@"snowflake_2"]) {
        color = [UIColor colorWithRed:0.0/255.0 green:173.0/255.0 blue:238.0/255.0 alpha:1];
    }
    if ([shapeToDraw isEqualToString:@"snowflake_3"]) {
        color = [UIColor colorWithRed:0.0/255.0 green:173.0/255.0 blue:238.0/255.0 alpha:1];
    }
    if ([shapeToDraw isEqualToString:@"star_cookie"]) {
        color = [UIColor colorWithRed:241.0/255.0 green:189.0/255.0 blue:126.0/255.0 alpha:1];
    }
    if ([shapeToDraw isEqualToString:@"star_cookie_2"]) {
        color = [UIColor colorWithRed:171.0/255.0 green:247.0/255.0 blue:251.0/255.0 alpha:1];
    }
    if ([shapeToDraw isEqualToString:@"blue_star_gift"]) {
        color = [UIColor colorWithRed:78.0/255.0 green:219.0/255.0 blue:249.0/255.0 alpha:1];
    }
    if ([shapeToDraw isEqualToString:@"cordoroy_pants"]) {
        color = [UIColor colorWithRed:234.0/255.0 green:192.0/255.0 blue:80.0/255.0 alpha:1];
    }
    if ([shapeToDraw isEqualToString:@"green_triangle_gift"]) {
        color = [UIColor colorWithRed:182.0/255.0 green:223.0/255.0 blue:16.0/255.0 alpha:1];
    }
    if ([shapeToDraw isEqualToString:@"blueSquareJeans"]) {
        color = [UIColor colorWithRed:2.0/255.0 green:147.0/255.0 blue:229.0/255.0 alpha:1];
    }
    if ([shapeToDraw isEqualToString:@"pink_skirt_winter"]) {
        color = [UIColor colorWithRed:237.0/255.0 green:2.0/255.0 blue:138.0/255.0 alpha:1];
    }
    if ([shapeToDraw isEqualToString:@"purple_star_gift"]) {
        color = [UIColor colorWithRed:156.0/255.0 green:41.0/255.0 blue:140.0/255.0 alpha:1];
    }
    if ([shapeToDraw isEqualToString:@"purple_triangle_gift"]) {
        color = [UIColor colorWithRed:154.0/255.0 green:1.0/255.0 blue:182.0/255.0 alpha:1];
    }
    if ([shapeToDraw isEqualToString:@"red_star_gift"]) {
        color = [UIColor colorWithRed:255.0/255.0 green:66.0/255.0 blue:29.0/255.0 alpha:1];
    }
    if ([shapeToDraw isEqualToString:@"stripped_pants"]) {
        color = [UIColor colorWithRed:229.0/255.0 green:2.0/255.0 blue:82.0/255.0 alpha:1];
    }
    if ([shapeToDraw isEqualToString:@"winter_coat"]) {
        color = [UIColor colorWithRed:3.0/255.0 green:214.0/255.0 blue:217.0/255.0 alpha:1];
    }
    if ([shapeToDraw isEqualToString:@"winter_coat_purple"]) {
        color = [UIColor colorWithRed:180.0/255.0 green:167.0/255.0 blue:224.0/255.0 alpha:1];
    }

    return color;
}

#pragma mark -
#pragma mark =======================================
#pragma mark Sound Handling
#pragma mark =======================================


-(NSString *) getAnimalNameSoundForObject:(NSString *) winterObject{
    DebugLog(@"");
    
    NSString *soundFile;
    
    if([winterObject isEqualToString:@"present"]) {
        
        if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"English"]) {
            int ranNo =arc4random()%2;
            
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
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"French"]){
            soundFile = @"gift_box_fr";
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"German"]){
            soundFile = @"gift_box_gr";
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"Italian"]){
            soundFile = @"gift_box_ita";
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"Chinese"]){
            soundFile = @"gift_box_ch";
        }
        
        
        
    }else if([winterObject isEqualToString:@"cup"]) {
        
        if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"English"]) {
            int ranNo =arc4random()%2;
            
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
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"French"]){
            soundFile = @"mug_fr";
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"German"]){
            soundFile = @"mug_gr";
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"Italian"]){
            soundFile = @"mug_ita";
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"Chinese"]){
            soundFile = @"mug_ch";
        }
        
        
    }else if([winterObject isEqualToString:@"sled"]) {
        
        if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"English"]) {
            int ranNo =arc4random()%2;
            
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
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"French"]){
            soundFile = @"snow_sled_fr";
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"German"]){
            soundFile = @"snow_sled_gr";
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"Italian"]){
            soundFile = @"snow_sled_ita";
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"Chinese"]){
            soundFile = @"snow_sled_ch";
        }
        
        
        
    }else if([winterObject isEqualToString:@"choo"]) {
        
        if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"English"]) {
            int ranNo =arc4random()%2;
            
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
        } else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"French"]){
            soundFile = @"train_fr";
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"German"]){
            soundFile = @"train_gr";
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"Italian"]){
            soundFile = @"train_ita";
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"Chinese"]){
            soundFile = @"train_ch";
        }
        
        
    }else if([winterObject isEqualToString:@"fireplace"]) {
        
        if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"English"]) {
            int ranNo =arc4random()%2;
            
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
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"French"]){
            soundFile = @"fire_place_fr";
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"German"]){
            soundFile = @"fire_place_gr";
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"Italian"]){
            soundFile = @"fire_place_ita";
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"Chinese"]){
            soundFile = @"fire_place_ch";
        }
        
        
    }else if([winterObject isEqualToString:@"green_sweater"]) {
        if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"English"]) {
            int ranNo =arc4random()%2;
            
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
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"French"]){
            soundFile = @"sweater_fr";
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"German"]){
            soundFile = @"sweater_gr";
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"Italian"]){
            soundFile = @"sweater_ita";
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"Chinese"]){
            soundFile = @"sweater_ch";
        }
        
        
    }else if([winterObject isEqualToString:@"ornament"]) {
        
        if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"English"]) {
            int ranNo =arc4random()%2;
            
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
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"French"]){
            soundFile = @"Ornoment_fr";
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"German"]){
            soundFile = @"Ornoment_gr";
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"Italian"]){
            soundFile = @"Ornoment_ita";
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"Chinese"]){
            soundFile = @"Ornoment_ch";
        }
        
        
    }else if([winterObject isEqualToString:@"pink_sweater"]) {
        
        if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"English"]) {
            int ranNo =arc4random()%2;
            
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
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"French"]){
            soundFile = @"sweater_fr";
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"German"]){
            soundFile = @"sweater_gr";
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"Italian"]){
            soundFile = @"sweater_ita";
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"Chinese"]){
            soundFile = @"sweater_ch";
        }
        
        
        
    }else if([winterObject isEqualToString:@"shovel"]) {
        
        if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"English"]) {
            int ranNo =arc4random()%2;
            
            if(ranNo == 0){
                soundFile = @"Tiggly_Word_Shovel_01";
            }else if (ranNo == 1) {
                soundFile = @"Tiggly_Word_Shovel_Huh_01";
            }
            
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"English UK"]){
            soundFile = @"Tiggly_Word_Shovel_01";
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"Portuguese"]){
            soundFile = @"shovel_prtgs";
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"Russian"]){
            soundFile = @"Tiggly_Word_Shovel_01";
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"Spanish"]){
            soundFile = @"shovel_sp";
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"French"]){
            soundFile = @"shovel_fr";
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"German"]){
            soundFile = @"shovel_gr";
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"Italian"]){
            soundFile = @"shovel_ita";
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"Chinese"]){
            soundFile = @"shovel_ch";
        }
        
        
        
    }else if([winterObject isEqualToString:@"bells"]) {
        
        if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"English"]) {
            int ranNo =arc4random()%2;
            
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
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"French"]){
            soundFile = @"bell_fr";
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"German"]){
            soundFile = @"bell_gr";
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"Italian"]){
            soundFile = @"bell_ita";
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"Chinese"]){
            soundFile = @"bell_ch";
        }
        
        
    }else if([winterObject isEqualToString:@"blue_hat"] ) {
        
        if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"English"]) {
            
            int ranNo =arc4random()%3;
            
            if(ranNo == 0){
                soundFile = @"Tiggly_Word_Bluehat_Var2_01";
            }else if (ranNo == 1) {
                soundFile = @"Tiggly_Word_Bluehat_Var1_01";
            }else if (ranNo == 2) {
                soundFile = @"Tiggly_Word_Bluehat_01";
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
        
        
        
    }else if([winterObject isEqualToString:@"pink_hat"] ) {
        
        if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"English"]) {
            int ranNo =arc4random()%4;
            
            if(ranNo == 0){
                soundFile = @"Tiggly_Word_Pinkhat_01";
            }else if (ranNo == 1) {
                soundFile = @"Tiggly_Word_Pinkhat_Var1_01";
            }else if (ranNo == 2) {
                soundFile = @"Tiggly_Word_Pinkhat_Var2_01";
            }else if (ranNo == 3) {
                soundFile = @"Tiggly_Word_Pinkhat_Var2_02";
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
        
        
        
        
    }else if([winterObject isEqualToString:@"deer"] ) {
        
        if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"English"]) {
            
            int ranNo =arc4random()%2;
            
            if(ranNo == 0){
                soundFile = @"Tiggly_GenGreeting_Moose_04";
            }else if (ranNo == 1) {
                soundFile = @"Tiggly_GenGreeting_Moose_07";
            }
            
            
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"English UK"]){
            soundFile = @"Tiggly_GenGreeting_Moose_04";
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"Portuguese"]){
            soundFile = @"Tiggly_GenGreeting_Moose_04";
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"Russian"]){
            soundFile = @"Tiggly_GenGreeting_Moose_04";
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"Spanish"]){
            soundFile = @"Tiggly_GenGreeting_Moose_04";
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"French"]){
            soundFile = @"Tiggly_GenGreeting_Moose_04";
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"German"]){
            soundFile = @"Tiggly_GenGreeting_Moose_04";
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"Italian"]){
            soundFile = @"Tiggly_GenGreeting_Moose_04";
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"Chinese"]){
            soundFile = @"moose_ch";
        }
        
        
    }else if([winterObject isEqualToString:@"deer_2"] ) {
        
        if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"English"]) {
            soundFile = @"Tiggly_GenGreeting_Reindeer_09";
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"English UK"]){
            soundFile = @"Tiggly_GenGreeting_Reindeer_09";
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"Portuguese"]){
            soundFile = @"Tiggly_GenGreeting_Reindeer_09";
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"Russian"]){
            soundFile = @"Tiggly_GenGreeting_Reindeer_09";
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"Spanish"]){
            soundFile = @"Tiggly_GenGreeting_Reindeer_09";
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"French"]){
            soundFile = @"reindeer_fr";
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"German"]){
            soundFile = @"range_deer_gr";
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"Italian"]){
            soundFile = @"range_deer_ita";
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"Chinese"]){
            soundFile = @"range_deer_ch";
        }
        
        
        
    }else if([winterObject isEqualToString:@"green_umbrella"] ) {
        
        if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"English"]) {
            
            int ranNo =arc4random()%2;
            
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
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"French"]){
            soundFile = @"umbrella_fr";
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"German"]){
            soundFile = @"umbrella_gr";
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"Italian"]){
            soundFile = @"umbrella_ita";
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"Chinese"]){
            soundFile = @"umbrella_ch";
        }
        
        
        
    }else if([winterObject isEqualToString:@"hot_choclate"] ) {
        
        if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"English"]) {
            
            int ranNo =arc4random()%2;
            
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
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"French"]){
            soundFile = @"hot_chocolate_fr";
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"German"]){
            soundFile = @"hot_chocolate_gr";
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"Italian"]){
            soundFile = @"hot_chocolate_ita";
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"Chinese"]){
            soundFile = @"hot_chocolate_ch";
        }
        
        
        
    }else if([winterObject isEqualToString:@"lightbulb"] ) {
        
        if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"English"]) {
            
            int ranNo =arc4random()%2;
            
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
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"French"]){
            soundFile = @"lights_fr";
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"German"]){
            soundFile = @"lights_gr";
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"Italian"]){
            soundFile = @"lights_ita";
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"Chinese"]){
            soundFile = @"lights_ch";
        }
        
        
        
    }else if([winterObject isEqualToString:@"purple_umbrella"] ) {
        
        
        if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"English"]) {
            
            int ranNo =arc4random()%2;
            
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
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"French"]){
            soundFile = @"umbrella_fr";
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"German"]){
            soundFile = @"umbrella_gr";
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"Italian"]){
            soundFile = @"umbrella_ita";
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"Chinese"]){
            soundFile = @"umbrella_ch";
        }
        
        
        
    }else if([winterObject isEqualToString:@"bear"] ) {
        if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"English"]) {
            
            int ranNo =arc4random()%3;
            
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
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"French"]){
            soundFile = @"bear_fr";
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"German"]){
            soundFile = @"bear_gr";
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"Italian"]){
            soundFile = @"bear_ita";
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"Chinese"]){
            soundFile = @"bear_ch";
        }
        
        
    }else if([winterObject isEqualToString:@"bird"] ) {
        
        if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"English"]) {
            
            int ranNo =arc4random()%2;
            
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
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"French"]){
            soundFile = @"bird_fr";
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"German"]){
            soundFile = @"bird_gr";
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"Italian"]){
            soundFile = @"bird_ita";
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"Chinese"]){
            soundFile = @"bird_ch";
        }
        
        
        
    }else if([winterObject isEqualToString:@"candy"] ) {
        
        if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"English"]) {
            
            int ranNo =arc4random()%2;
            
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
        
        
        
    }else if([winterObject isEqualToString:@"choclate"] ) {
        
        
        if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"English"]) {
            
            int ranNo =arc4random()%2;
            
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
            soundFile = @"cupcake_ru";
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"Spanish"]){
            soundFile = @"cupcake_sp";
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"French"]){
            soundFile = @"cupcake_fr";
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"German"]){
            soundFile = @"cupcake_gr";
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"Italian"]){
            soundFile = @"cupcake_ita";
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"Chinese"]){
            soundFile = @"cupcake_ch";
        }
        
        
        
        
        
    }else if([winterObject isEqualToString:@"girl"] ) {
        
//        if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"English"]) {
        
            int ranNo =arc4random()%4;
            
            if(ranNo == 0){
                soundFile = @"Tiggly_GenGreeting_Girl_01";
            }else if (ranNo == 1) {
                soundFile = @"Tiggly_GenGreeting_Girl_03";
            }else if (ranNo == 2) {
                soundFile = @"Tiggly_GenGreeting_Girl_04";
            }else if (ranNo == 3) {
                soundFile = @"Tiggly_GenGreeting_Girl_05";
            }
            
            
//        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"English UK"]){
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
//        
        
    }else if([winterObject isEqualToString:@"igloo"] ) {
        
        if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"English"]) {
            
            int ranNo =arc4random()%3;
            
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
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"French"]){
            soundFile = @"igloo_fr";
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"German"]){
            soundFile = @"igloo_gr";
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"Italian"]){
            soundFile = @"igloo_ita";
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"Chinese"]){
            soundFile = @"igloo_ch";
        }
        
        
        
        
    }else if([winterObject isEqualToString:@"penguin_blue"] ) {
        
        if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"English"]) {
            
            int ranNo =arc4random()%2;
            
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
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"French"]){
            soundFile = @"Penguin_fr";
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"German"]){
            soundFile = @"Penguin_gr";
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"Italian"]){
            soundFile = @"Penguin_ita";
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"Chinese"]){
            soundFile = @"Penguin_ch";
        }
        
        
    }else if([winterObject isEqualToString:@"penguin_skate"] ) {
        
        if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"English"]) {
            
            int ranNo =arc4random()%2;
            
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
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"French"]){
            soundFile = @"Penguin_fr";
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"German"]){
            soundFile = @"Penguin_gr";
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"Italian"]){
            soundFile = @"Penguin_ita";
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"Chinese"]){
            soundFile = @"Penguin_ch";
        }
        
        
    }else if([winterObject isEqualToString:@"penguin"] ) {
        if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"English"]) {
            
            int ranNo =arc4random()%2;
            
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
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"French"]){
            soundFile = @"Penguin_fr";
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"German"]){
            soundFile = @"Penguin_gr";
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"Italian"]){
            soundFile = @"Penguin_ita";
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"Chinese"]){
            soundFile = @"Penguin_ch";
        }
        
    }else if([winterObject isEqualToString:@"snowglobe"] ) {
        
        if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"English"]) {
            
            int ranNo =arc4random()%2;
            
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
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"French"]){
            soundFile = @"snowglobe_fr";
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"German"]){
            soundFile = @"snowglobe_gr";
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"Italian"]){
            soundFile = @"snowglobe_ita";
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"Chinese"]){
            soundFile = @"snowglobe_ch";
        }
        
        
        
    }else if([winterObject isEqualToString:@"snowman"] ) {
        
        if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"English"]) {
            
            int ranNo =arc4random()%2;
            
            if(ranNo == 0){
                soundFile = @"Tiggly_Animal_Snowman_ImASnowman_01";
            }else if (ranNo == 1) {
                soundFile = @"Tiggly_Animal_Snowman_ImASnowman_02";
            }
            
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"English UK"]){
            soundFile = @"Tiggly_Animal_Snowman_ImASnowman_01";
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"Portuguese"]){
            soundFile = @"Tiggly_Animal_Snowman_ImASnowman_01";
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"Russian"]){
            soundFile = @"Tiggly_Animal_Snowman_ImASnowman_01";
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"Spanish"]){
            soundFile = @"Tiggly_Animal_Snowman_ImASnowman_01";
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"French"]){
            soundFile = @"Tiggly_Animal_Snowman_ImASnowman_01";
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"German"]){
            soundFile = @"Tiggly_Animal_Snowman_ImASnowman_01";
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"Italian"]){
            soundFile = @"Tiggly_Animal_Snowman_ImASnowman_01";
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"Chinese"]){
            soundFile = @"snowman_ch";
        }
        
        
        
    }else if([winterObject isEqualToString:@"chipmunk"] ) {
        if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"English"]) {
            
            
            int ranNo =arc4random()%2;
            
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
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"French"]){
            soundFile = @"chipmunk_fr";
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"German"]){
            soundFile = @"chipmunk_gr";
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"Italian"]){
            soundFile = @"chipmunk_ita";
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"Chinese"]){
            soundFile = @"chipmunk_ch";
        }
        
        
    }else if([winterObject isEqualToString:@"fox"] ) {
        
        if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"English"]) {
            
            
            int ranNo =arc4random()%6;
            
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
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"French"]){
            soundFile = @"fox_fr";
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"German"]){
            soundFile = @"fox_gr";
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"Italian"]){
            soundFile = @"fox_ita";
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"Chinese"]){
            soundFile = @"fox_ch";
        }
        
                
        
    }else if([winterObject isEqualToString:@"ornament_purple"] ) {
        
        
        if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"English"]) {
            
            
            int ranNo =arc4random()%2;
            
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
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"French"]){
            soundFile = @"Ornoment_fr";
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"German"]){
            soundFile = @"Ornoment_gr";
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"Italian"]){
            soundFile = @"Ornoment_ita";
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"Chinese"]){
            soundFile = @"Ornoment_ch";
        }
        
        
        
    }else if([winterObject isEqualToString:@"snowflake_1"] ) {
        
        if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"English"]) {
            
            
            int ranNo =arc4random()%7;
            
            if(ranNo == 0){
                soundFile = @"Tiggly_Word_Snow_01";
            }else if (ranNo == 1) {
                soundFile = @"Tiggly_Word_Snow_Ooh_01";
            }else if (ranNo == 2) {
                soundFile = @"Tiggly_Word_Snowflake_01";
            }else if (ranNo == 3) {
                soundFile = @"Tiggly_Word_Snowflake_Var1_01";
            }else if (ranNo == 4) {
                soundFile = @"Tiggly_Word_Snowflake_Var2_01";
            }else if (ranNo == 5) {
                soundFile = @"Tiggly_Word_Snowflake_Var2_02";
            }else if (ranNo == 6) {
                soundFile = @"Tiggly_Word_Snowflake_Var2_03";
            }
            
            
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"English UK"]){
            soundFile = @"Snow_breng";
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"Portuguese"]){
            soundFile = @"Snow_prtgs";
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"Russian"]){
            soundFile = @"Snow_ru";
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"Spanish"]){
            soundFile = @"Snow_sp";
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"French"]){
            soundFile = @"Snow_fr";
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"German"]){
            soundFile = @"Snow_gr";
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"Italian"]){
            soundFile = @"Snow_ita";
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"Chinese"]){
            soundFile = @"Snow_ch";
        }
        
        
        
    }else if([winterObject isEqualToString:@"snowflake_2"] ) {
        if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"English"]) {
            
            
            int ranNo =arc4random()%7;
            
            if(ranNo == 0){
                soundFile = @"Tiggly_Word_Snow_01";
            }else if (ranNo == 1) {
                soundFile = @"Tiggly_Word_Snow_Ooh_01";
            }else if (ranNo == 2) {
                soundFile = @"Tiggly_Word_Snowflake_01";
            }else if (ranNo == 3) {
                soundFile = @"Tiggly_Word_Snowflake_Var1_01";
            }else if (ranNo == 4) {
                soundFile = @"Tiggly_Word_Snowflake_Var2_01";
            }else if (ranNo == 5) {
                soundFile = @"Tiggly_Word_Snowflake_Var2_02";
            }else if (ranNo == 6) {
                soundFile = @"Tiggly_Word_Snowflake_Var2_03";
            }
            
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"English UK"]){
            soundFile = @"Snow_breng";
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"Portuguese"]){
            soundFile = @"Snow_prtgs";
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"Russian"]){
            soundFile = @"Snow_ru";
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"Spanish"]){
            soundFile = @"Snow_sp";
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"French"]){
            soundFile = @"Snow_fr";
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"German"]){
            soundFile = @"Snow_gr";
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"Italian"]){
            soundFile = @"Snow_ita";
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"Chinese"]){
            soundFile = @"Snow_ch";
        }
        
        
    }else if([winterObject isEqualToString:@"snowflake_3"] ) {
        if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"English"]) {
            
            
            int ranNo =arc4random()%2;
            
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
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"French"]){
            soundFile = @"Snow_fr";
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"German"]){
            soundFile = @"Snow_gr";
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"Italian"]){
            soundFile = @"Snow_ita";
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"Chinese"]){
            soundFile = @"Snow_ch";
        }
        
        
    }else if([winterObject isEqualToString:@"star_cookie"] ) {
        
        if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"English"]) {
            
            
            int ranNo =arc4random()%2;
            
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
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"French"]){
            soundFile = @"cookie_fr";
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"German"]){
            soundFile = @"cookie_gr";
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"Italian"]){
            soundFile = @"cookie_ita";
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"Chinese"]){
            soundFile = @"cookie_ch";
        }
        
        
    }else if([winterObject isEqualToString:@"star_cookie_2"] ) {
        
        
        if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"English"]) {
            
            int ranNo =arc4random()%2;
            
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
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"French"]){
            soundFile = @"cookie_fr";
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"German"]){
            soundFile = @"cookie_gr";
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"Italian"]){
            soundFile = @"cookie_ita";
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"Chinese"]){
            soundFile = @"cookie_ch";
        }
        
    }
    
    else if ([winterObject isEqualToString:@"blue_star_gift"]) {
        
    }
    else if ([winterObject isEqualToString:@"cordoroy_pants"]) {
        //yellow pants
        
        if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"English"]) {
            
            int ranNo =arc4random()%3;
            
            if(ranNo == 0){
                soundFile = @"Tiggly_Word_Yellowpants_01";
            }else if (ranNo == 1) {
                soundFile = @"Tiggly_Word_Yellowpants_Var1_01";
            }else if (ranNo == 2) {
                soundFile = @"Tiggly_Word_Yellowpants_Var2_01";
            }
            
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"English UK"]){
            soundFile = @"Tiggly_Word_Pants_01";
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"Portuguese"]){
            soundFile = @"Tiggly_Word_Pants_01";
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"Russian"]){
            soundFile = @"Tiggly_Word_Pants_01";
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"Spanish"]){
            soundFile = @"Tiggly_Word_Pants_01";
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"French"]){
            soundFile = @"Tiggly_Word_Pants_01";
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"German"]){
            soundFile = @"Tiggly_Word_Pants_01";
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"Italian"]){
            soundFile = @"Tiggly_Word_Pants_01";
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"Chinese"]){
            soundFile = @"Pants_ch";
        }
        
    }
    else if ([winterObject isEqualToString:@"green_triangle_gift"]) {
        
    }
    else if ([winterObject isEqualToString:@"blueSquareJeans"]) {
        //blue pants
        if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"English"]) {
            
            int ranNo =arc4random()%3;
            
            if(ranNo == 0){
                soundFile = @"Tiggly_Word_BluePants_01";
            }else if (ranNo == 1) {
                soundFile = @"Tiggly_Word_BluePants_Var1_01";
            }else if (ranNo == 2) {
                soundFile = @"Tiggly_Word_BluePants_Var2_01";
            }
            
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"English UK"]){
            soundFile = @"Tiggly_Word_Pants_01";
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"Portuguese"]){
            soundFile = @"Tiggly_Word_Pants_01";
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"Russian"]){
            soundFile = @"Tiggly_Word_Pants_01";
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"Spanish"]){
            soundFile = @"Tiggly_Word_Pants_01";
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"French"]){
            soundFile = @"Tiggly_Word_Pants_01";
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"German"]){
            soundFile = @"Tiggly_Word_Pants_01";
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"Italian"]){
            soundFile = @"Tiggly_Word_Pants_01";
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"Chinese"]){
            soundFile = @"Pants_ch";
        }
        
    }
    else if ([winterObject isEqualToString:@"pink_skirt_winter"]) {
        //skirt
        
        if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"English"]) {
            
            int ranNo =arc4random()%6;
            
            if(ranNo == 0){
                soundFile = @"Tiggly_Word_Skirt_01";
            }else if (ranNo == 1) {
                soundFile = @"Tiggly_Word_Skirt_Var1_01";
            }else if (ranNo == 2) {
                soundFile = @"Tiggly_Word_Skirt_Var2_01";
            }else if(ranNo == 3){
                soundFile = @"Tiggly_Word_Skirt_Var2_02";
            }else if (ranNo == 4) {
                soundFile = @"Tiggly_Word_Skirt_Var2_03";
            }else if (ranNo == 5) {
                soundFile = @"Tiggly_Word_Skirt_Var2_04";
            }
            
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"English UK"]){
            soundFile = @"Tiggly_Word_Skirt_01";
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"Portuguese"]){
            soundFile = @"Tiggly_Word_Skirt_01";
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"Russian"]){
            soundFile = @"Tiggly_Word_Skirt_01";
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"Spanish"]){
            soundFile = @"Tiggly_Word_Skirt_01";
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"French"]){
            soundFile = @"Tiggly_Word_Skirt_01";
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"German"]){
            soundFile = @"Tiggly_Word_Skirt_01";
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"Italian"]){
            soundFile = @"Tiggly_Word_Skirt_01";
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"Chinese"]){
            soundFile = @"Skirt_ch";
        }
        
    }
    else if ([winterObject isEqualToString:@"purple_star_gift"]) {
        
    }
    else if ([winterObject isEqualToString:@"purple_triangle_gift"]) {
        
    }
    else if ([winterObject isEqualToString:@"red_star_gift"]) {
        
    }
    else if ([winterObject isEqualToString:@"stripped_pants"]) {
        if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"English"]) {
            
            int ranNo =arc4random()%5;
            
            if(ranNo == 0){
                soundFile = @"Tiggly_Word_Stripedpants_01";
            }else if (ranNo == 1) {
                soundFile = @"Tiggly_Word_Stripedpants_Var1_01";
            }else if (ranNo == 2) {
                soundFile = @"Tiggly_Word_Stripedpants_Var2_01";
            }else if(ranNo == 3){
                soundFile = @"Tiggly_Word_Stripedpants_Var2_02";
            }else if (ranNo == 4) {
                soundFile = @"Tiggly_Word_Stripedpants_Var2_03";
            }
            
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"English UK"]){
            soundFile = @"Tiggly_Word_Pants_01";
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"Portuguese"]){
            soundFile = @"Tiggly_Word_Pants_01";
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"Russian"]){
            soundFile = @"Tiggly_Word_Pants_01";
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"Spanish"]){
            soundFile = @"Tiggly_Word_Pants_01";
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"French"]){
            soundFile = @"Tiggly_Word_Pants_01";
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"German"]){
            soundFile = @"Tiggly_Word_Pants_01";
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"Italian"]){
            soundFile = @"Tiggly_Word_Pants_01";
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"Chinese"]){
            soundFile = @"Pants_ch";
        }
        
    }
    else if ([winterObject isEqualToString:@"winter_coat"]) {
        //bllue coat
//        if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"English"]) {
        
            int ranNo =arc4random()%6;
            
            if(ranNo == 0){
                soundFile = @"Tiggly_Word_Bluecoat_01";
            }else if (ranNo == 1) {
                soundFile = @"Tiggly_Word_Bluecoat_Var1_01";
            }else if (ranNo == 2) {
                soundFile = @"Tiggly_Word_Bluecoat_Var2_01";
            }else if(ranNo == 3){
                soundFile = @"Tiggly_Word_Bluecoat_Var2_02";
            }else if (ranNo == 4) {
                soundFile = @"Tiggly_Word_Bluecoat_Var2_03";
            }else if (ranNo == 5) {
                soundFile = @"Tiggly_Word_Bluecoat_Var2_04";
            }
            
//        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"English UK"]){
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
        
    }
    else if ([winterObject isEqualToString:@"winter_coat_purple"]) {
        // purple coat
        
//        if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"English"]) {
        
            int ranNo =arc4random()%4;
            
            if(ranNo == 0){
                soundFile = @"Tiggly_Word_Purplecoat_01";
            }else if (ranNo == 1) {
                soundFile = @"Tiggly_Word_Purplecoat_02";
            }else if (ranNo == 2) {
                soundFile = @"Tiggly_Word_Purplecoat_Var1_01";
            }else if(ranNo == 3){
                soundFile = @"Tiggly_Word_Purplecoat_Var2_01";
            }
            
//        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"English UK"]){
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

        
   }
    
    return soundFile;
}



-(NSString *) getAnimalDropSoundForObject:(NSString *) winterObject{
    DebugLog(@"");
    
    NSString *soundFile;
    
    if([winterObject isEqualToString:@"present"]) {
        
        int ranNo =arc4random()%2;
        
        if(ranNo == 0){
            soundFile = @"Tiggly_SFX_DragNDrop_DROP_02";
        }else if (ranNo == 1) {
            soundFile = @"Tiggly_SFX_DragNDrop_DROP_03";
        }
        
    }else if([winterObject isEqualToString:@"cup"]) {
        
        int ranNo =arc4random()%2;
        
        if(ranNo == 0){
            soundFile = @"Tiggly_SFX_DragNDrop_DROP_02";
        }else if (ranNo == 1) {
            soundFile = @"Tiggly_SFX_DragNDrop_DROP_03";
        }
        
    }else if([winterObject isEqualToString:@"sled"]) {
        
        int ranNo =arc4random()%2;
        
        if(ranNo == 0){
            soundFile = @"Tiggly_SFX_DragNDrop_DROP_02";
        }else if (ranNo == 1) {
            soundFile = @"Tiggly_SFX_DragNDrop_DROP_03";
        }
        
    }else if([winterObject isEqualToString:@"choo"]) {
        
        int ranNo =arc4random()%2;
        
        if(ranNo == 0){
            soundFile = @"Tiggly_SFX_TRAIN_01";
        }else if (ranNo == 1) {
            soundFile = @"Tiggly_SFX_TRAIN_01";
        }
        
    }else if([winterObject isEqualToString:@"fireplace"]) {
        
        int ranNo =arc4random()%2;
        
        if(ranNo == 0){
            soundFile = @"Tiggly_SFX_DragNDrop_DROP_02";
        }else if (ranNo == 1) {
            soundFile = @"Tiggly_SFX_DragNDrop_DROP_03";
        }
        
    }else if([winterObject isEqualToString:@"green_sweater"]) {
        
        int ranNo =arc4random()%2;
        
        if(ranNo == 0){
            soundFile = @"Tiggly_SFX_DragNDrop_DROP_02";
        }else if (ranNo == 1) {
            soundFile = @"Tiggly_SFX_DragNDrop_DROP_03";
        }
        
    }else if([winterObject isEqualToString:@"ornament"]) {
        
        int ranNo =arc4random()%2;
        
        if(ranNo == 0){
            soundFile = @"Tiggly_SFX_DragNDrop_DROP_02";
        }else if (ranNo == 1) {
            soundFile = @"Tiggly_SFX_DragNDrop_DROP_03";
        }
        
    }else if([winterObject isEqualToString:@"pink_sweater"]) {
        
        int ranNo =arc4random()%2;
        
        if(ranNo == 0){
            soundFile = @"Tiggly_SFX_DragNDrop_DROP_02";
        }else if (ranNo == 1) {
            soundFile = @"Tiggly_SFX_DragNDrop_DROP_03";
        }
        
    }else if([winterObject isEqualToString:@"shovel"]) {
        
        int ranNo =arc4random()%2;
        
        if(ranNo == 0){
            soundFile = @"Tiggly_SFX_DragNDrop_DROP_02";
        }else if (ranNo == 1) {
            soundFile = @"Tiggly_SFX_DragNDrop_DROP_03";
        }
        
    }else if([winterObject isEqualToString:@"bells"]) {
        
        int ranNo =arc4random()%2;
        
        if(ranNo == 0){
            soundFile = @"Tiggly_SFX_BELL";
        }else if (ranNo == 1) {
            soundFile = @"Tiggly_SFX_BELL";
        }
        
    }else if([winterObject isEqualToString:@"blue_hat"] ) {
        
        int ranNo =arc4random()%2;
        
        if(ranNo == 0){
            soundFile = @"Tiggly_SFX_DragNDrop_DROP_02";
        }else if (ranNo == 1) {
            soundFile = @"Tiggly_SFX_DragNDrop_DROP_03";
        }
        
    }else if([winterObject isEqualToString:@"pink_hat"] ) {
        
        int ranNo =arc4random()%2;
        
        if(ranNo == 0){
            soundFile = @"Tiggly_SFX_DragNDrop_DROP_02";
        }else if (ranNo == 1) {
            soundFile = @"Tiggly_SFX_DragNDrop_DROP_03";
        }
        
    }else if([winterObject isEqualToString:@"deer"] ) {
        if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"English"]) {
            int ranNo =arc4random()%15;
            if(ranNo == 0){
                soundFile = @"Tiggly_GenGreeting_Moose_04";
            }else if (ranNo == 1) {
                soundFile = @"Tiggly_GenGreeting_Moose_07";
            }else if(ranNo == 2){
                soundFile = @"Tiggly_Animal_Moose_GiveMeACookie_01";
            }else if (ranNo == 3) {
                soundFile = @"Tiggly_Animal_Moose_GiveMeACupOfHotChocolate_01";
            }else if(ranNo == 4){
                soundFile = @"Tiggly_Animal_Moose_GiveMeACupOfHotChocolate_02";
            }else if (ranNo == 5) {
                soundFile = @"Tiggly_Animal_Moose_GiveMeAnUmbrealla_02";
            }else if(ranNo == 6){
                soundFile = @"Tiggly_Animal_Moose_ILookPrettyDapper_01";
            }else if (ranNo == 7) {
                soundFile = @"Tiggly_Animal_Moose_ILookVeryHandsome_02";
            }else if(ranNo == 8){
                soundFile = @"Tiggly_Animal_Moose_INeedACoat_02";
            }else if (ranNo == 9) {
                soundFile = @"Tiggly_Animal_Moose_INeedAHat_01";
            }else if(ranNo == 10){
                soundFile = @"Tiggly_Animal_Moose_INeedASweater_01";
            }else if (ranNo == 11) {
                soundFile = @"Tiggly_Animal_Moose_INeedPants_01";
            }else if(ranNo == 12){
                soundFile = @"Tiggly_Animal_Moose_INeedPants_02";
            }else if (ranNo == 13) {
                soundFile = @"Tiggly_Animal_Moose_IsItStoryTimeYet_01";
            }else if(ranNo == 14){
                soundFile = @"Tiggly_Animal_Moose_IsItStoryTimeYet_02";
            }
        }else{
            int ranNo =arc4random()%2;
            if(ranNo == 0){
                soundFile = @"Tiggly_SFX_DragNDrop_DROP_02";
            }else if (ranNo == 1) {
                soundFile = @"Tiggly_SFX_DragNDrop_DROP_03";
            }
        }
        
    }else if([winterObject isEqualToString:@"deer_2"] ) {
        if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"English"]) {
            int ranNo =arc4random()%20;
            if(ranNo == 0){
                soundFile = @"Tiggly_GenGreeting_Reindeer_056";
            }else if (ranNo == 1) {
                soundFile = @"Tiggly_GenGreeting_Reindeer_07";
            }else if(ranNo == 3){
                soundFile = @"Tiggly_Animal_Reindeer_GiveMeACupOfHotCocoa_01";
            }else if (ranNo == 4) {
                soundFile = @"Tiggly_Animal_Reindeer_GiveMeTheShovel_01";
            }else if(ranNo == 5){
                soundFile = @"Tiggly_Animal_Reindeer_HowDoILook_01";
            }else if (ranNo == 6) {
                soundFile = @"Tiggly_Animal_Reindeer_ILookMarvelous_01";
            }else if(ranNo == 7){
                soundFile = @"Tiggly_Animal_Reindeer_ILookSoPretty_01";
            }else if (ranNo == 8) {
                soundFile = @"Tiggly_Animal_Reindeer_ILookSplendid_01";
            }else if(ranNo == 9){
                soundFile = @"Tiggly_Animal_Reindeer_INeedACoat_02";
            }else if (ranNo == 10) {
                soundFile = @"Tiggly_Animal_Reindeer_INeedAHat_01";
            }else if(ranNo == 11){
                soundFile = @"Tiggly_Animal_Reindeer_INeedASkirt_01";
            }else if (ranNo == 12) {
                soundFile = @"Tiggly_Animal_Reindeer_INeedASkirt_02";
            }else if(ranNo == 13){
                soundFile = @"Tiggly_Animal_Reindeer_INeedASweater_01";
            }else if (ranNo == 14) {
                soundFile = @"Tiggly_Animal_Reindeer_INeedASweater_02";
            }else if(ranNo == 15){
                soundFile = @"Tiggly_Animal_Reindeer_INeedPants_01";
            }else if (ranNo == 16) {
                soundFile = @"Tiggly_Animal_Reindeer_INeedPants_02";
            }else if(ranNo == 17){
                soundFile = @"Tiggly_Animal_Reindeer_IsItTimeForAStory_01";
            }else if (ranNo == 18) {
                soundFile = @"Tiggly_Animal_Reindeer_IsItTimeForAStory_02";
            }else if (ranNo == 19) {
                soundFile = @"Tiggly_Animal_Reindeer_IsItTimeForAStory_03";
            }

        }else{
            int ranNo =arc4random()%2;
            if(ranNo == 0){
                soundFile = @"Tiggly_SFX_DragNDrop_DROP_02";
            }else if (ranNo == 1) {
                soundFile = @"Tiggly_SFX_DragNDrop_DROP_03";
            }
        }
        
    }else if([winterObject isEqualToString:@"green_umbrella"] ) {
        
        int ranNo =arc4random()%2;
        
        if(ranNo == 0){
            soundFile = @"Tiggly_SFX_DragNDrop_DROP_02";
        }else if (ranNo == 1) {
            soundFile = @"Tiggly_SFX_DragNDrop_DROP_03";
        }
        
    }else if([winterObject isEqualToString:@"hot_choclate"] ) {
        
        int ranNo =arc4random()%2;
        
        if(ranNo == 0){
            soundFile = @"Tiggly_SFX_DragNDrop_DROP_02";
        }else if (ranNo == 1) {
            soundFile = @"Tiggly_SFX_DragNDrop_DROP_03";
        }
        
    }else if([winterObject isEqualToString:@"lightbulb"] ) {
        
        int ranNo =arc4random()%2;
        
        if(ranNo == 0){
            soundFile = @"Tiggly_SFX_DragNDrop_DROP_02";
        }else if (ranNo == 1) {
            soundFile = @"Tiggly_SFX_DragNDrop_DROP_03";
        }
        
    }else if([winterObject isEqualToString:@"purple_umbrella"] ) {
        
        int ranNo =arc4random()%2;
        
        if(ranNo == 0){
            soundFile = @"Tiggly_SFX_DragNDrop_DROP_02";
        }else if (ranNo == 1) {
            soundFile = @"Tiggly_SFX_DragNDrop_DROP_03";
        }
        
    }else if([winterObject isEqualToString:@"bear"] ) {
        if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"English"]) {
            int ranNo =arc4random()%13;
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
            }else if (ranNo == 6) {
                soundFile = @"Tiggly_Animal_Bear_CanIPleaseHaveACookie_01";
            }else if (ranNo == 7) {
                soundFile = @"Tiggly_Animal_Bear_IWantACookie_01";
            }else if (ranNo == 8) {
                soundFile = @"Tiggly_Animal_Bear_IWantACupOfHotCocoa_01";
            }else if (ranNo == 9) {
                soundFile = @"Tiggly_Animal_Bear_OhGushItsCold_01";
            }else if (ranNo == 10) {
                soundFile = @"Tiggly_Animal_Bear_OhGushItsSnowing_01";
            }else if (ranNo == 11) {
                soundFile = @"Tiggly_Animal_Bear_WhereIsMyHat_01";
            }else if (ranNo == 12) {
                soundFile = @"Tiggly_Animal_Bear_YourTheBest_01";
            }
        }else{
            int ranNo =arc4random()%5;
            if(ranNo == 0){
                soundFile = @"Tiggly_GenGreeting_Bear_03";
            }else if (ranNo == 1) {
                soundFile = @"Tiggly_GenGreeting_Bear_10";
            }else if (ranNo == 2) {
                soundFile = @"Tiggly_GenGreeting_Bear_05";
            }else if (ranNo == 3) {
                soundFile = @"Tiggly_GenGreeting_Bear_07";
            }else if (ranNo == 4) {
                soundFile = @"Tiggly_GenGreeting_Bear_09";
            }
        }
        
    }else if([winterObject isEqualToString:@"bird"] ) {
        if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"English"]) {
            int ranNo =arc4random()%16;
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
            }else if (ranNo == 10) {
                soundFile = @"Tiggly_Animal_Bird_GiveMeACandyPlease_01";
            }else if (ranNo == 11) {
                soundFile = @"Tiggly_Animal_Bird_ILoveToSing_01";
            }else if (ranNo == 12) {
                soundFile = @"Tiggly_Animal_Bird_ImABirdAndICanFly_01";
            }else if (ranNo == 13) {
                soundFile = @"Tiggly_Animal_Bird_ImABirdAndICanSing_01";
            }else if (ranNo == 14) {
                soundFile = @"Tiggly_Animal_Bird_ImABirdAndISingASong_01";
            }else if (ranNo == 15) {
                soundFile = @"Tiggly_Animal_Bird_PleaseGiveMeACupcake_01";
            }
        }else{
            int ranNo =arc4random()%9;
            if(ranNo == 0){
                soundFile = @"Tiggly_GenGreeting_Bird_02";
            }else if (ranNo == 1) {
                soundFile = @"Tiggly_GenGreeting_Bird_18";
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
            }
            
        }
    }else if([winterObject isEqualToString:@"candy"] ) {
        
        int ranNo =arc4random()%2;
        
        if(ranNo == 0){
            soundFile = @"Tiggly_SFX_DragNDrop_DROP_02";
        }else if (ranNo == 1) {
            soundFile = @"Tiggly_SFX_DragNDrop_DROP_03";
        }
        
    }else if([winterObject isEqualToString:@"choclate"] ) {
        
        int ranNo =arc4random()%2;
        
        if(ranNo == 0){
            soundFile = @"Tiggly_SFX_DragNDrop_DROP_02";
        }else if (ranNo == 1) {
            soundFile = @"Tiggly_SFX_DragNDrop_DROP_03";
        }
        
    }else if([winterObject isEqualToString:@"girl"] ) {
        if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"English"]) {
            int ranNo =arc4random()%11;
            
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
            }else if (ranNo == 5) {
                soundFile = @"Tiggly_Animal_Girl_CanYouPutTheOrnamentsOnTheTree_01";
            }else if (ranNo == 6) {
                soundFile = @"Tiggly_Animal_Girl_GiveMeTheShovel_01";
            }else if (ranNo == 7) {
                soundFile = @"Tiggly_Animal_Girl_ItsColdOutHere_01";
            }else if (ranNo == 8) {
                soundFile = @"Tiggly_Animal_Girl_ItsWinterTimeAndItsSnowing_01";
            }else if (ranNo == 9) {
                soundFile = @"Tiggly_Animal_Girl_WhyDontYouTapOnTheStarToTellAStoryAboutUs_01";
            }else if (ranNo == 10) {
                soundFile = @"Tiggly_Animal_Girl_WhyDontYouTapOnTheStarToTellAStoryAboutUs_02";
            }
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"English UK"]){
            soundFile = @"";
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"Portuguese"]){
            soundFile = @"Hello_prtgs";
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"Russian"]){
            soundFile = @"Hello_ru";
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"Spanish"]){
            soundFile = @"Hello_sp";
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"French"]){
            soundFile = @"Hello_fr";
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"German"]){
            soundFile = @"Hello_gr";
        }else if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"Italian"]){
            soundFile = @"Hello_ita";
        }
        
    }else if([winterObject isEqualToString:@"igloo"] ) {
        
        int ranNo =arc4random()%2;
        
        if(ranNo == 0){
            soundFile = @"Tiggly_SFX_DragNDrop_DROP_02";
        }else if (ranNo == 1) {
            soundFile = @"Tiggly_SFX_DragNDrop_DROP_03";
        }
        
    }else if([winterObject isEqualToString:@"penguin_blue"] ) {
        int ranNo =arc4random()%22;
        
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
        }else if (ranNo == 5) {
            soundFile = @"Tiggly_Animal_Penguin_CanIPleaseHaveACupcake_01";
        }else if (ranNo == 6) {
            soundFile = @"Tiggly_Animal_Penguin_DoYouKnowAnyStoriesAboutPenguinsTheyreMyFavorite_01";
        }else if (ranNo == 7) {
            soundFile = @"Tiggly_Animal_Penguin_GiveMeACandyPlease_01";
        }else if(ranNo == 8){
            soundFile = @"Tiggly_Animal_Penguin_HuhTheOrnamentsNeedToGoOnTheTree_01";
        }else if (ranNo == 9) {
            soundFile = @"Tiggly_Animal_Penguin_ILoveItWhenItSnows_01";
        }else if (ranNo == 10) {
            soundFile = @"Tiggly_Animal_Penguin_ILoveTheSnow_01";
        }else if (ranNo == 11) {
            soundFile = @"Tiggly_Animal_Penguin_ILoveToSkateOnTheIce_01";
        }else if(ranNo == 12){
            soundFile = @"Tiggly_Animal_Penguin_ImMuchObligedToYou_01";
        }else if (ranNo == 13) {
            soundFile = @"Tiggly_Animal_Penguin_IWantACupOfHotChocolate_01";
        }else if (ranNo == 14) {
            soundFile = @"Tiggly_Animal_Penguin_IWantaCupOfHotCocoa_01";
        }else if (ranNo == 15) {
            soundFile = @"Tiggly_Animal_Penguin_IWantAHat_01";
        }else if(ranNo == 16){
            soundFile = @"Tiggly_Animal_Penguin_PrettyPleaseGiveMeACookie_01";
        }else if (ranNo == 17) {
            soundFile = @"Tiggly_Animal_Penguin_TellMeAStoryAboutMe_01";
        }else if (ranNo == 18) {
            soundFile = @"Tiggly_Animal_Penguin_TellMeAStoryAboutMe_02";
        }else if (ranNo == 19) {
            soundFile = @"Tiggly_Animal_Penguin_YohoooWinterTime_01";
        }else if(ranNo == 20){
            soundFile = @"Tiggly_Animal_Penguin_YouAreTheAbsoluteBest_01";
        }else if(ranNo == 21){
            soundFile = @"Tiggly_Animal_Penguin_YourePrettyAwesome_01";
        }
        
    }else if([winterObject isEqualToString:@"penguin_skate"] ) {
        int ranNo =arc4random()%22;
        
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
        }else if (ranNo == 5) {
            soundFile = @"Tiggly_Animal_Penguin_CanIPleaseHaveACupcake_01";
        }else if (ranNo == 6) {
            soundFile = @"Tiggly_Animal_Penguin_DoYouKnowAnyStoriesAboutPenguinsTheyreMyFavorite_01";
        }else if (ranNo == 7) {
            soundFile = @"Tiggly_Animal_Penguin_GiveMeACandyPlease_01";
        }else if(ranNo == 8){
            soundFile = @"Tiggly_Animal_Penguin_HuhTheOrnamentsNeedToGoOnTheTree_01";
        }else if (ranNo == 9) {
            soundFile = @"Tiggly_Animal_Penguin_ILoveItWhenItSnows_01";
        }else if (ranNo == 10) {
            soundFile = @"Tiggly_Animal_Penguin_ILoveTheSnow_01";
        }else if (ranNo == 11) {
            soundFile = @"Tiggly_Animal_Penguin_ILoveToSkateOnTheIce_01";
        }else if(ranNo == 12){
            soundFile = @"Tiggly_Animal_Penguin_ImMuchObligedToYou_01";
        }else if (ranNo == 13) {
            soundFile = @"Tiggly_Animal_Penguin_IWantACupOfHotChocolate_01";
        }else if (ranNo == 14) {
            soundFile = @"Tiggly_Animal_Penguin_IWantaCupOfHotCocoa_01";
        }else if (ranNo == 15) {
            soundFile = @"Tiggly_Animal_Penguin_IWantAHat_01";
        }else if(ranNo == 16){
            soundFile = @"Tiggly_Animal_Penguin_PrettyPleaseGiveMeACookie_01";
        }else if (ranNo == 17) {
            soundFile = @"Tiggly_Animal_Penguin_TellMeAStoryAboutMe_01";
        }else if (ranNo == 18) {
            soundFile = @"Tiggly_Animal_Penguin_TellMeAStoryAboutMe_02";
        }else if (ranNo == 19) {
            soundFile = @"Tiggly_Animal_Penguin_YohoooWinterTime_01";
        }else if(ranNo == 20){
            soundFile = @"Tiggly_Animal_Penguin_YouAreTheAbsoluteBest_01";
        }else if(ranNo == 21){
            soundFile = @"Tiggly_Animal_Penguin_YourePrettyAwesome_01";
        }
        
    }else if([winterObject isEqualToString:@"penguin"] ) {
        int ranNo =arc4random()%22;
        
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
        }else if (ranNo == 5) {
            soundFile = @"Tiggly_Animal_Penguin_CanIPleaseHaveACupcake_01";
        }else if (ranNo == 6) {
            soundFile = @"Tiggly_Animal_Penguin_DoYouKnowAnyStoriesAboutPenguinsTheyreMyFavorite_01";
        }else if (ranNo == 7) {
            soundFile = @"Tiggly_Animal_Penguin_GiveMeACandyPlease_01";
        }else if(ranNo == 8){
            soundFile = @"Tiggly_Animal_Penguin_HuhTheOrnamentsNeedToGoOnTheTree_01";
        }else if (ranNo == 9) {
            soundFile = @"Tiggly_Animal_Penguin_ILoveItWhenItSnows_01";
        }else if (ranNo == 10) {
            soundFile = @"Tiggly_Animal_Penguin_ILoveTheSnow_01";
        }else if (ranNo == 11) {
            soundFile = @"Tiggly_Animal_Penguin_ILoveToSkateOnTheIce_01";
        }else if(ranNo == 12){
            soundFile = @"Tiggly_Animal_Penguin_ImMuchObligedToYou_01";
        }else if (ranNo == 13) {
            soundFile = @"Tiggly_Animal_Penguin_IWantACupOfHotChocolate_01";
        }else if (ranNo == 14) {
            soundFile = @"Tiggly_Animal_Penguin_IWantaCupOfHotCocoa_01";
        }else if (ranNo == 15) {
            soundFile = @"Tiggly_Animal_Penguin_IWantAHat_01";
        }else if(ranNo == 16){
            soundFile = @"Tiggly_Animal_Penguin_PrettyPleaseGiveMeACookie_01";
        }else if (ranNo == 17) {
            soundFile = @"Tiggly_Animal_Penguin_TellMeAStoryAboutMe_01";
        }else if (ranNo == 18) {
            soundFile = @"Tiggly_Animal_Penguin_TellMeAStoryAboutMe_02";
        }else if (ranNo == 19) {
            soundFile = @"Tiggly_Animal_Penguin_YohoooWinterTime_01";
        }else if(ranNo == 20){
            soundFile = @"Tiggly_Animal_Penguin_YouAreTheAbsoluteBest_01";
        }else if(ranNo == 21){
            soundFile = @"Tiggly_Animal_Penguin_YourePrettyAwesome_01";
        }
        
    }else if([winterObject isEqualToString:@"snowglobe"] ) {
        
        int ranNo =arc4random()%2;
        
        if(ranNo == 0){
            soundFile = @"Tiggly_SFX_DragNDrop_DROP_02";
        }else if (ranNo == 1) {
            soundFile = @"Tiggly_SFX_DragNDrop_DROP_03";
        }
        
    }else if([winterObject isEqualToString:@"snowman"] ) {
        
        int ranNo =arc4random()%11;
        
        if(ranNo == 0){
            soundFile = @"Tiggly_SFX_DragNDrop_DROP_02";
        }else if (ranNo == 1) {
            soundFile = @"Tiggly_SFX_DragNDrop_DROP_03";
        }else if(ranNo == 2){
            soundFile = @"Tiggly_Animal_Snowman_HahLookAtMyhat_01";
        }else if (ranNo == 3) {
            soundFile = @"Tiggly_Animal_Snowman_Hi_01";
        }else if(ranNo == 4){
            soundFile = @"Tiggly_Animal_Snowman_ILoveTheWinterTimeThatsWhenIExist_01";
        }else if (ranNo == 5) {
            soundFile = @"Tiggly_Animal_Snowman_IsThatACarrotAsMyNose_01";
        }else if(ranNo == 6){
            soundFile = @"Tiggly_Animal_Snowman_NowThisIsThetimeOfYearImTalkingAboutWinterTime_01";
        }else if (ranNo == 7) {
            soundFile = @"Tiggly_Animal_Snowman_OhILoveTheSnow_01";
        }else if(ranNo == 8){
            soundFile = @"Tiggly_Animal_Snowman_OhILoveTheSnow_02";
        }else if (ranNo == 9) {
            soundFile = @"Tiggly_Animal_Snowman_YouveGottaMakeItSnow_01";
        }else if (ranNo == 10) {
            soundFile = @"Tiggly_Animal_Snowman_YouveGottaMakeItSnow_02";
        }
        
        
    }else if([winterObject isEqualToString:@"chipmunk"] ) {
        int ranNo =arc4random()%20;
        
        if(ranNo == 0){
            soundFile = @"Tiggly_GenGreeting_Chipmunk_03";
        }else if (ranNo == 1) {
            soundFile = @"Tiggly_GenGreeting_Chipmunk_07";
        }else if (ranNo == 2) {
            soundFile = @"Tiggly_GenGreeting_Chipmunk_08";
        }else if (ranNo == 3) {
            soundFile = @"Tiggly_GenGreeting_Chipmunk_09";
        }else if(ranNo == 4){
            soundFile = @"Tiggly_Animal_Chipmunk_AmIFunnyOrWhat_02";
        }else if (ranNo == 5) {
            soundFile = @"Tiggly_Animal_Chipmunk_GiveMeACookie_01";
        }else if (ranNo == 6) {
            soundFile = @"Tiggly_Animal_Chipmunk_GiveMeACupOfHotChocolate_01";
        }else if (ranNo == 7) {
            soundFile = @"Tiggly_Animal_Chipmunk_GiveMeAnShovel_01";
        }else if(ranNo == 8){
            soundFile = @"Tiggly_Animal_Chipmunk_HeyDontILookMarvelous_01";
        }else if (ranNo == 9) {
            soundFile = @"Tiggly_Animal_Chipmunk_HohIThinkImFunny_01";
        }else if (ranNo == 10) {
            soundFile = @"Tiggly_Animal_Chipmunk_INeedACoat_02";
        }else if (ranNo == 11) {
            soundFile = @"Tiggly_Animal_Chipmunk_INeedACoat_03";
        }else if(ranNo == 12){
            soundFile = @"Tiggly_Animal_Chipmunk_INeedAHat_01";
        }else if (ranNo == 13) {
            soundFile = @"Tiggly_Animal_Chipmunk_INeedASweater_01";
        }else if (ranNo == 14) {
            soundFile = @"Tiggly_Animal_Chipmunk_INeedSomePants_01";
        }else if (ranNo == 15) {
            soundFile = @"Tiggly_Animal_Chipmunk_OkHowDoILook_02";
        }else if(ranNo == 16){
            soundFile = @"Tiggly_Animal_Chipmunk_TheyCallMeSillyTheChipmunk_01";
        }else if (ranNo == 17) {
            soundFile = @"Tiggly_Animal_Chipmunk_TheyCallMeSillyTheChipmunk_03";
        }else if (ranNo == 18) {
            soundFile = @"Tiggly_Animal_Chipmunk_YouCanCallMeAnythingYouWant_01";
        }else if (ranNo == 19) {
            soundFile = @"Tiggly_Animal_Chipmunk_YouGottaTellAStoryAboutMe_01";
        }
        
    }else if([winterObject isEqualToString:@"fox"] ) {
        if ([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"English"]) {
            int ranNo =arc4random()%21;
            if(ranNo == 0){
                soundFile = @"Tiggly_GenGreeting_Fox_04";
            }else if (ranNo == 1) {
                soundFile = @"Tiggly_GenGreeting_Fox_05";
            }else if (ranNo == 2) {
                soundFile = @"Tiggly_GenGreeting_Fox_09";
            }else if(ranNo == 3){
                soundFile = @"Tiggly_Animal_Fox_GiveMeACandy_02";
            }else if (ranNo == 4) {
                soundFile = @"Tiggly_Animal_Fox_GiveMeACookie_02";
            }else if (ranNo == 5) {
                soundFile = @"Tiggly_Animal_Fox_GiveMeACupcake_01";
            }else if(ranNo == 6){
                soundFile = @"Tiggly_Animal_Fox_GiveMeACupOfHotChocolate_01";
            }else if (ranNo == 7) {
                soundFile = @"Tiggly_Animal_Fox_GiveMeACupOfHotCocoa_01";
            }else if (ranNo == 8) {
                soundFile = @"Tiggly_Animal_Fox_GiveMeTheRedMug_02";
            }else if(ranNo == 9){
                soundFile = @"Tiggly_Animal_Fox_HohIThinkImFunny_01";
            }else if (ranNo == 10) {
                soundFile = @"Tiggly_Animal_Fox_HowDoILook_01";
            }else if (ranNo == 11) {
                soundFile = @"Tiggly_Animal_Fox_IFeelVeryFancy_01";
            }else if(ranNo == 12){
                soundFile = @"Tiggly_Animal_Fox_INeedACoat_01";
            }else if (ranNo == 13) {
                soundFile = @"Tiggly_Animal_Fox_INeedAHat_02";
            }else if (ranNo == 14) {
                soundFile = @"Tiggly_Animal_Fox_INeedAHat_03";
            }else if(ranNo == 15){
                soundFile = @"Tiggly_Animal_Fox_INeedASkirt_01";
            }else if (ranNo == 16) {
                soundFile = @"Tiggly_Animal_Fox_INeedASkirt_02";
            }else if (ranNo == 17) {
                soundFile = @"Tiggly_Animal_Fox_INeedASweater_01";
            }else if(ranNo == 18){
                soundFile = @"Tiggly_Animal_Fox_INeedASweater_02";
            }else if (ranNo == 19) {
                soundFile = @"Tiggly_Animal_Fox_ThatsAFashionistaFox_01";
            }else if (ranNo == 20) {
                soundFile = @"Tiggly_Animal_Fox_ThatsAFashionistaFox_02";
            }
        }else{
            int ranNo =arc4random()%2;
            if(ranNo == 0){
                soundFile = @"Tiggly_GenGreeting_Fox_05";
            }else if (ranNo == 1) {
                soundFile = @"Tiggly_GenGreeting_Fox_09";
            }
        }
    }else if([winterObject isEqualToString:@"ornament_purple"] ) {
        
        int ranNo =arc4random()%2;
        
        if(ranNo == 0){
            soundFile = @"Tiggly_SFX_DragNDrop_DROP_02";
        }else if (ranNo == 1) {
            soundFile = @"Tiggly_SFX_DragNDrop_DROP_03";
        }
        
    }else if([winterObject isEqualToString:@"snowflake_1"] ) {
        
        int ranNo =arc4random()%2;
        
        if(ranNo == 0){
            soundFile = @"Tiggly_SFX_DragNDrop_DROP_02";
        }else if (ranNo == 1) {
            soundFile = @"Tiggly_SFX_DragNDrop_DROP_03";
        }
        
    }else if([winterObject isEqualToString:@"snowflake_2"] ) {
        
        int ranNo =arc4random()%2;
        
        if(ranNo == 0){
            soundFile = @"Tiggly_SFX_DragNDrop_DROP_02";
        }else if (ranNo == 1) {
            soundFile = @"Tiggly_SFX_DragNDrop_DROP_03";
        }
        
    }else if([winterObject isEqualToString:@"snowflake_3"] ) {
        
        int ranNo =arc4random()%2;
        
        if(ranNo == 0){
            soundFile = @"Tiggly_SFX_DragNDrop_DROP_02";
        }else if (ranNo == 1) {
            soundFile = @"Tiggly_SFX_DragNDrop_DROP_03";
        }
        
    }else if([winterObject isEqualToString:@"star_cookie"] ) {
        
        int ranNo =arc4random()%2;
        
        if(ranNo == 0){
            soundFile = @"Tiggly_SFX_DragNDrop_DROP_02";
        }else if (ranNo == 1) {
            soundFile = @"Tiggly_SFX_DragNDrop_DROP_03";
        }
        
    }else if([winterObject isEqualToString:@"star_cookie_2"] ) {
        
        int ranNo =arc4random()%2;
        
        if(ranNo == 0){
            soundFile = @"Tiggly_SFX_DragNDrop_DROP_02";
        }else if (ranNo == 1) {
            soundFile = @"Tiggly_SFX_DragNDrop_DROP_03";
        }
        
    }
    
    else if ([winterObject isEqualToString:@"blue_star_gift"]) {
        int ranNo =arc4random()%2;
        
        if(ranNo == 0){
            soundFile = @"Tiggly_SFX_DragNDrop_DROP_02";
        }else if (ranNo == 1) {
            soundFile = @"Tiggly_SFX_DragNDrop_DROP_03";
        }
        
    }
    else if ([winterObject isEqualToString:@"cordoroy_pants"]) {
        int ranNo =arc4random()%2;
        
        if(ranNo == 0){
            soundFile = @"Tiggly_SFX_DragNDrop_DROP_02";
        }else if (ranNo == 1) {
            soundFile = @"Tiggly_SFX_DragNDrop_DROP_03";
        }
        
    }
    else if ([winterObject isEqualToString:@"green_triangle_gift"]) {
        int ranNo =arc4random()%2;
        
        if(ranNo == 0){
            soundFile = @"Tiggly_SFX_DragNDrop_DROP_02";
        }else if (ranNo == 1) {
            soundFile = @"Tiggly_SFX_DragNDrop_DROP_03";
        }
        
    }
    else if ([winterObject isEqualToString:@"blueSquareJeans"]) {
        int ranNo =arc4random()%2;
        
        if(ranNo == 0){
            soundFile = @"Tiggly_SFX_DragNDrop_DROP_02";
        }else if (ranNo == 1) {
            soundFile = @"Tiggly_SFX_DragNDrop_DROP_03";
        }
        
    }
    else if ([winterObject isEqualToString:@"pink_skirt_winter"]) {
        int ranNo =arc4random()%2;
        
        if(ranNo == 0){
            soundFile = @"Tiggly_SFX_DragNDrop_DROP_02";
        }else if (ranNo == 1) {
            soundFile = @"Tiggly_SFX_DragNDrop_DROP_03";
        }
        
    }
    else if ([winterObject isEqualToString:@"purple_star_gift"]) {
        int ranNo =arc4random()%2;
        
        if(ranNo == 0){
            soundFile = @"Tiggly_SFX_DragNDrop_DROP_02";
        }else if (ranNo == 1) {
            soundFile = @"Tiggly_SFX_DragNDrop_DROP_03";
        }
        
    }
    else if ([winterObject isEqualToString:@"purple_triangle_gift"]) {
        int ranNo =arc4random()%2;
        
        if(ranNo == 0){
            soundFile = @"Tiggly_SFX_DragNDrop_DROP_02";
        }else if (ranNo == 1) {
            soundFile = @"Tiggly_SFX_DragNDrop_DROP_03";
        }
        
    }
    else if ([winterObject isEqualToString:@"red_star_gift"]) {
        int ranNo =arc4random()%2;
        
        if(ranNo == 0){
            soundFile = @"Tiggly_SFX_DragNDrop_DROP_02";
        }else if (ranNo == 1) {
            soundFile = @"Tiggly_SFX_DragNDrop_DROP_03";
        }
        
    }
    else if ([winterObject isEqualToString:@"stripped_pants"]) {
        int ranNo =arc4random()%2;
        
        if(ranNo == 0){
            soundFile = @"Tiggly_SFX_DragNDrop_DROP_02";
        }else if (ranNo == 1) {
            soundFile = @"Tiggly_SFX_DragNDrop_DROP_03";
        }
        
    }
    else if ([winterObject isEqualToString:@"winter_coat"]) {
        int ranNo =arc4random()%2;
        
        if(ranNo == 0){
            soundFile = @"Tiggly_SFX_DragNDrop_DROP_02";
        }else if (ranNo == 1) {
            soundFile = @"Tiggly_SFX_DragNDrop_DROP_03";
        }
        
    }
    else if ([winterObject isEqualToString:@"winter_coat_purple"]) {
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
