//
//  TigglyStampUtils.m
//  TigglyStamp
//
//  Created by cuelogic on 16/07/13.
//  Copyright (c) 2013 cuelogic. All rights reserved.
//

#import "TigglyStampUtils.h"

#import <MessageUI/MessageUI.h>
#import <MessageUI/MFMailComposeViewController.h>


#define KEY_WRITE_KEYS_INCSV @"keyincsv"
#define KEY_IS_SEND_MAIL @"keyissendmail"
#define KEY_SHAPE_STORE_KEY @"keyshapestore"
#define KEY_FIRST_TIME_LAUNCH @"firsttimelaunch"
#define KEY_CURRENT_LANGUAGE @"currentlang"


@implementation TigglyStampUtils

static TigglyStampUtils *sharedInstance = nil;


#pragma mark -
#pragma mark =======================================
#pragma mark Init
#pragma mark =======================================

// Get the shared instance and create it if necessary.
+ (TigglyStampUtils *)sharedInstance {
    if (sharedInstance == nil) {
        sharedInstance = [[TigglyStampUtils alloc]init];
        
    }
    
    return sharedInstance;
}
// We can still have a regular init method, that will get called the first time the Singleton is used.
- (id)init {
    
    self = [super init];    
    if (self) {
        // Work your initialising magic here as you normally would
        DebugLog(@"");
        
    }
    
    return self;
}

#pragma mark -
#pragma mark =======================================
#pragma mark Game Scene Data
#pragma mark =======================================


-(UIColor *)getRGBValueForShape:(NSString *)shapeToDraw withBasicShape:(NSString *)basicShape {
    DebugLog(@"");
    
    /*This function returns the color of basic shapes of the objects used in Fall and Winter Scene*/
    
    UIColor *color;
    if([basicShape isEqualToString:@"square"]){
        
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
        
        /************************************* fall *******************************************/
        
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

    }
    if([basicShape isEqualToString:@"triangle"]){
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
        
        /************************************* fall *******************************************/
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
        
    }
    if([basicShape isEqualToString:@"circle"]){
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
        /************************************* fall *******************************************/
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
    }
    if([basicShape isEqualToString:@"star"]){
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
        /************************************* fall *******************************************/
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

        }
    return color;
}

#pragma mark -
#pragma mark =======================================
#pragma mark App Settings Data
#pragma mark =======================================


-(void) setMusicStatus:(NSString *) status{
    DebugLog(@"");
    /*This function persists the value of Music settings */
    [[NSUserDefaults standardUserDefaults] setValue:status forKey:MUSIC];
}

-(NSString *) getMusicStatus {
    DebugLog(@"");
    
    return  [[NSUserDefaults standardUserDefaults] objectForKey:MUSIC];
}


-(void)setShapeMode:(BOOL) bVar{
    /*This function persists the value of Shape settings */
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setBool:bVar forKey:IS_WITH_SHAPE];
    
}

-(BOOL)getShapeMode{
     NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    BOOL isWithShape = [userDefaults boolForKey:IS_WITH_SHAPE];
    return isWithShape;
}

-(void)setCurrentLanguage:(NSString *)lang{
    
    /*This function persists the value of Language settings */
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setValue:lang forKey:KEY_CURRENT_LANGUAGE];
}

-(NSString *)getCurrentLanguage{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSString *lang = [userDefaults valueForKey:KEY_CURRENT_LANGUAGE];
    return lang;
}

-(BOOL) isAppUnlockedForShapes {
    DebugLog(@"");
    
    return [[NSUserDefaults standardUserDefaults] boolForKey:IS_UNLOCKED_FOR_SHAPES];
}

-(void)unlockAppForShapes:(BOOL) boolean{
    DebugLog(@"");
    
    /*This function persists the value of App's Shape/NoShape mode settings */
    [[NSUserDefaults standardUserDefaults] setBool:boolean forKey:IS_UNLOCKED_FOR_SHAPES];
    
}


-(BOOL) isSpaceAvailableOnDisk{
    DebugLog(@"");
    /* This functions checks if the available disk space is above 50mb*/
    
    if([self getFreeDiskspace] < 50)
        return NO;
    
    return YES;
}

#pragma mark -
#pragma mark =======================================
#pragma mark File Sysytem Handling
#pragma mark =======================================


- (NSString *) getDocumentDirPath {
    DebugLog(@"");
    /*This function returns the App's Document directory path*/
    NSString *docsDirectory = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    return docsDirectory;
}

#pragma mark -
#pragma mark =======================================
#pragma mark Artwork Names Handling
#pragma mark =======================================

- (NSArray *) getAllImagesAndMovies{
    DebugLog(@"");
    /*This function returns all the images and movie files stored in documents directory path*/
    
    NSMutableArray *dirArray = [[NSMutableArray alloc] initWithCapacity:1];
    
    NSString *path = [[TigglyStampUtils sharedInstance]getDocumentDirPath];
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSArray *directoryContents = [fileManager contentsOfDirectoryAtPath:path error:NULL];

    //Filter only the png and mov files
    for (NSString *file in directoryContents) {
        if([file hasPrefix:@"TigglyStamp"] && ([[[file lastPathComponent] pathExtension] isEqualToString:@"png"] ||[[[file lastPathComponent] pathExtension] isEqualToString:@"mov"] )){
            [dirArray addObject:[path stringByAppendingPathComponent:file]];
        }
    }
    
    return dirArray;
}


-(NSString *) getImagePathOfMovieThumbnailWithBorder:(NSString *) moveName {
    DebugLog(@"");
    /*This function takes the movie file name and forms a name that will give the image name of the movie's thumbnail with white border*/
    
    NSString *path = [[TigglyStampUtils sharedInstance]getDocumentDirPath];
    NSString *iName = [NSString stringWithFormat:@"%@_%@.png",[moveName stringByDeletingPathExtension],STR_WITH_MOVIE_BORDER];
    path = [path stringByAppendingPathComponent:iName];
    
    return path;
}

-(UIImage *) getMovieImageForMovieName:(NSString *) moviePath {
    DebugLog(@"");
    /*This function returns the thumbnail image of the movie*/
    
    NSString *movieName = [[moviePath lastPathComponent] stringByReplacingOccurrencesOfString:@"mov" withString:@"png"];
    NSString *fileName=[NSString stringWithFormat:@"%@/Movie%@",[[TigglyStampUtils sharedInstance]getDocumentDirPath],movieName];
    UIImage *img;
    
     if (![[NSFileManager defaultManager] fileExistsAtPath:fileName]) {
         //If MovieImage not found. Create a thumbnail from the movie file
         DebugLog(@"MovieImage not found. Create thumbnail");
        NSString *path = [[TigglyStampUtils sharedInstance]getDocumentDirPath];
        path = [path stringByAppendingPathComponent:moviePath];
        NSURL *url = [NSURL fileURLWithPath:path];
        AVURLAsset *asset = [[AVURLAsset alloc] initWithURL:url options:nil];
        AVAssetImageGenerator *gen = [[AVAssetImageGenerator alloc] initWithAsset:asset];
        gen.appliesPreferredTrackTransform = YES;
        CMTime time = CMTimeMakeWithSeconds(0.0, 30.0);
        NSError *error = nil;

        CGImageRef image = [gen copyCGImageAtTime:time actualTime:NULL error:&error];
        img= [[UIImage alloc] initWithCGImage:image];
        CGImageRelease(image);
     }else{
         DebugLog(@"MovieImage found.");
         img = [UIImage imageWithContentsOfFile:fileName];
     }
    return img;
}

-(NSString *) getMovieImagePathForMovieName:(NSString *) moviePath{
    DebugLog(@"");
    /*This function returns the path of movie's thumbnail image*/
    NSString *movieName = [[moviePath lastPathComponent] stringByReplacingOccurrencesOfString:@"mov" withString:@"png"];
    NSString *fileName=[NSString stringWithFormat:@"%@/Movie%@",[[TigglyStampUtils sharedInstance]getDocumentDirPath],movieName];
    return fileName;
}

#pragma mark -
#pragma mark =======================================
#pragma mark Localization
#pragma mark =======================================

-(NSString*) getLocalisedStringForKey:(NSString*) key {
    DebugLog(@"");
    /*This function returns the localised string for the given key */
    NSString *selectedLanguage = [self getCurrentLanguage];
	NSString *path;
    if([selectedLanguage isEqualToString:@"Portuguese"])
		path = [[NSBundle mainBundle] pathForResource:@"pt" ofType:@"lproj"];
    else if([selectedLanguage isEqualToString:@"Russian"])
		path = [[NSBundle mainBundle] pathForResource:@"ru" ofType:@"lproj"];
    else if([selectedLanguage isEqualToString:@"Spanish"])
		path = [[NSBundle mainBundle] pathForResource:@"es" ofType:@"lproj"];
    else if([selectedLanguage isEqualToString:@"English"])
		path = [[NSBundle mainBundle] pathForResource:@"en" ofType:@"lproj"];
    else if([selectedLanguage isEqualToString:@"French"])
		path = [[NSBundle mainBundle] pathForResource:@"fr" ofType:@"lproj"];
    else if([selectedLanguage isEqualToString:@"German"])
		path = [[NSBundle mainBundle] pathForResource:@"de" ofType:@"lproj"];
    else if([selectedLanguage isEqualToString:@"Italian"])
		path = [[NSBundle mainBundle] pathForResource:@"it" ofType:@"lproj"];
    else
        path = [[NSBundle mainBundle] pathForResource:@"en" ofType:@"lproj"];
    
	NSBundle* languageBundle = [NSBundle bundleWithPath:path];
	NSString* str=[languageBundle localizedStringForKey:key value:@"" table:nil];
	return str;
}


#pragma mark -
#pragma mark =============================================
#pragma mark Debugging Shape Detection
#pragma mark =============================================

-(void)setDebugModeForWriteKeyInCsvOn:(BOOL) isOn{
    DebugLog(@"setDebugModeForWriteKeyInCsvOn :%d",isOn);
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setBool:isOn forKey:KEY_WRITE_KEYS_INCSV];
    
}
-(BOOL)getDebugModeForWriteKeyInCsvOn{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSString *strfirstTime = [userDefaults stringForKey:KEY_FIRST_TIME_LAUNCH];
    if (strfirstTime==NULL||[strfirstTime isEqualToString:@""] ) {
        [self setDebugModeForWriteKeyInCsvOn:NO];
        [self setSendMailOn:NO];
        [userDefaults setObject:@"YES" forKey:KEY_FIRST_TIME_LAUNCH];
    }
    BOOL isWithShape = [userDefaults boolForKey:KEY_WRITE_KEYS_INCSV];
    DebugLog(@"getDebugModeForWriteKeyInCsvOn :%d",isWithShape);

    return isWithShape;
}

-(void)setSendMailOn:(BOOL) isOn{
    DebugLog(@"setsendMailOn :%d",isOn);
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setBool:isOn forKey:KEY_IS_SEND_MAIL];
    
}
-(BOOL)getSendMailOn{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    BOOL isWithShape = [userDefaults boolForKey:KEY_IS_SEND_MAIL];
    DebugLog(@"getsendMailOn :%d",isWithShape);
    return isWithShape;
}


-(void)setCurrentSahpeForStoringKeys:(ShapeType)sType {
    DebugLog(@"setCurrentSahpeForStoringKeys :%d",sType);
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setInteger:sType forKey:KEY_SHAPE_STORE_KEY];
}
-(ShapeType)getCurrentSahpeForStoringKeys {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    ShapeType sType = [userDefaults integerForKey:KEY_SHAPE_STORE_KEY];
    DebugLog(@"getCurrentSahpeForStoringKeys :%d",sType);
    return sType;
}


- (void) saveCSVFileData {
    DebugLog(@"");
    
    NSString *filename = NULL;

    filename = [NSString stringWithFormat:@"ShapeTouchPoints.csv"];
	NSString *path = [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"]
					  stringByAppendingPathComponent:filename];
	[strCsvKyes writeToFile:path atomically:NO encoding:NSStringEncodingConversionAllowLossy error:NULL];

	DebugLog(@"File saved at path : %@", path);
}

- (void) deleteCSVFile{
    DebugLog(@"");

    NSString *path = [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"]
                              stringByAppendingPathComponent:@"ShapeTouchPoints.csv"];
    NSError *error = nil;
    [[NSFileManager defaultManager] removeItemAtPath:path error:&error];
    if (error != nil) {
        DebugLog(@"Error deleting file: %@ withError:%@", path, [error localizedDescription]);
    }
    strCsvKyes = NULL;
}

-(void)appendKeyDatatoString:(NSString *)str {
    if ([self getDebugModeForWriteKeyInCsvOn]==NO) {
        return;
    }
    if (strCsvKyes==NULL) {
        strCsvKyes = [[NSMutableString alloc]initWithString:@"SingleTouch,D1,D2,D3,SHAPE\n"];
    }
    [strCsvKyes appendString:str];
    DebugLog(@"Final Key Data String is :\n%@",strCsvKyes);
    [self saveCSVFileData];
}
- (BOOL) isMailSupported {
	Class mailClass = (NSClassFromString(@"MFMailComposeViewController"));
	if (mailClass != nil) {
		// We must always check whether the current device is configured for sending emails
		if ([mailClass canSendMail]) {
			return YES;
		}
		else {
			return NO;
		}
	}
	else {
		return NO;
	}
}

-(NSString *)getCsvKeys {
    return strCsvKyes;
}



-(BOOL) isItemCountBelowTheLimit{
    DebugLog(@"");

    NSArray *directoryContents = [self getAllImagesAndMovies];
    DebugLog(@"Gallery Intems Count : %d",directoryContents.count);
    if(directoryContents.count < GALLERY_LIMIT){        
            return YES;
    }else{
        if([[[NSUserDefaults standardUserDefaults]valueForKey:LIMIT_GALLERY] isEqualToString:@"yes"]){
            return NO;
        }
    }
    
    return YES;
    
}

-(uint64_t)getFreeDiskspace {
    uint64_t totalSpace = 0;
    uint64_t totalFreeSpace = 0;
    NSError *error = nil;
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSDictionary *dictionary = [[NSFileManager defaultManager] attributesOfFileSystemForPath:[paths lastObject] error: &error];
    
    if (dictionary) {
        NSNumber *fileSystemSizeInBytes = [dictionary objectForKey: NSFileSystemSize];
        NSNumber *freeFileSystemSizeInBytes = [dictionary objectForKey:NSFileSystemFreeSize];
        totalSpace = [fileSystemSizeInBytes unsignedLongLongValue];
        totalFreeSpace = [freeFileSystemSizeInBytes unsignedLongLongValue];
        DebugLog(@"Memory Capacity of %llu MiB with %llu MiB Free memory available.", ((totalSpace/1024ll)/1024ll), ((totalFreeSpace/1024ll)/1024ll));
    } else {
        DebugLog(@"Error Obtaining System Memory Info: Domain = %@, Code = %d", [error domain], [error code]);
    }
    
    return totalFreeSpace;
}

#pragma mark -
#pragma mark =======================================
#pragma mark Temp Data
#pragma mark =======================================

- (BOOL) createFolderForProject: (NSString *) folder {
    DebugLog(@"");
    
    //Create a path for new mtally folder
    NSString *docsDirectory = [self getDocumentDirPath];
    NSString *path = [docsDirectory stringByAppendingPathComponent:folder];
    DebugLog(@"Project saved at Path: %@", path);
    NSError *error = nil;
    
    //Create the folder
    if (![[NSFileManager defaultManager] fileExistsAtPath:path]) {
        
        [[NSFileManager defaultManager] createDirectoryAtPath:path withIntermediateDirectories:NO attributes:nil error:&error];
        
        if(error != nil) {
            DebugLog(@"Error creating the folder: %@",[error localizedDescription]);
        } else {
            DebugLog(@"Folder created sucessfully");
        }
    }
    return YES;
}

-(BOOL) packTempData:(TSTempData *) pInfo toFolder:(NSString *) folder{
    
    //Encode the project info object into NSData
    NSMutableData *data = [[NSMutableData alloc]init];
    NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc]initForWritingWithMutableData:data];
    [archiver encodeObject:pInfo];
    [archiver finishEncoding];
    
    //Save the data to the specified file
    NSString *path = [self getDocumentDirPath];
    [self createFolderForProject:folder] ;
    NSString *directory = [path stringByAppendingPathComponent:folder];
    DebugLog(@"Directory after adding project name: %@",directory);
    NSString *datapath = [directory stringByAppendingPathComponent:[NSString stringWithFormat:@"%@%d.tiggly",folder,[self getTempFilesCountInFolder:folder]]];
    DebugLog(@"Metadata file saved at path: %@",datapath);
    [data writeToFile:datapath atomically:YES];
    
    return YES;
}

- (NSMutableArray *) getAllTempDataFromFolder:(NSString *)folder {
    DebugLog(@"");
    
    NSMutableArray *arr = [[NSMutableArray alloc] initWithCapacity:1];
    NSString *path = [self getDocumentDirPath];
    NSString *directory = [path stringByAppendingPathComponent:folder];
    DebugLog(@"directory : %@",directory);
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSArray *directoryContents = [fileManager contentsOfDirectoryAtPath:directory error:NULL];
    
    for (NSString *file in directoryContents) {
        DebugLog(@"FFile : %@",file);
        NSMutableData *data = [[NSMutableData alloc]initWithContentsOfFile:[directory stringByAppendingPathComponent:file]];
        NSKeyedUnarchiver *unarchiver = [[NSKeyedUnarchiver alloc] initForReadingWithData:data];
        TSTempData *tempData = (TSTempData *)[unarchiver decodeObject];
        
        if(tempData != nil)
            [arr addObject:tempData];
    }
    
    return arr;
}

-(int) getTempFilesCountInFolder:(NSString *) folder {
    DebugLog(@"");
    
    NSString *path = [self getDocumentDirPath];
    NSString *directory = [path stringByAppendingPathComponent:folder];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSArray *directoryContents = [fileManager contentsOfDirectoryAtPath:directory error:NULL];
    
    return directoryContents.count;
}



@end
