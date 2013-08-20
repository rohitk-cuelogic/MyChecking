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

#define KEY_BOOLEAN_ISWITH_SHAPE @"withShape"
#define KEY_WRITE_KEYS_INCSV @"keyincsv"

@implementation TigglyStampUtils
static TigglyStampUtils *sharedInstance = nil;

// Get the shared instance and create it if necessary.
+ (TigglyStampUtils *)sharedInstance {
    if (sharedInstance == nil) {
        sharedInstance = [[TigglyStampUtils alloc]init];
    }
    
    return sharedInstance;
}
// We can still have a regular init method, that will get called the first time the Singleton is used.
- (id)init
{
    self = [super init];
    
    if (self) {
        // Work your initialising magic here as you normally would
    }
    
    return self;
}

-(UIColor *)getRGBValueForShape:(NSString *)shapeToDraw withBasicShape:(NSString *)basicShape
{
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
            color = [UIColor colorWithRed:178.0/255.0 green:210.0/255.0 blue:53.0/255.0 alpha:1];
        }
        if ([shapeToDraw isEqualToString:@"raincoat"]) {
            color = [UIColor colorWithRed:255.0/255.0 green:197.0/255.0 blue:14.0/255.0 alpha:1];
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
            color = [UIColor colorWithRed:199.0/255.0 green:234.0/255.0 blue:245.0/255.0 alpha:1];
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
        if ([shapeToDraw isEqualToString:@"rooster_2"]) {
            color = [UIColor colorWithRed:255.0/255.0 green:236.0/255.0 blue:220.0/255.0 alpha:1];
        }
        if ([shapeToDraw isEqualToString:@"rooster"]) {
            color = [UIColor colorWithRed:234.0/255.0 green:109.0/255.0 blue:8.0/255.0 alpha:1];
        }
        }
    return color;
}


-(void)SetBooleanWithShape:(BOOL) bVar{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setBool:bVar forKey:KEY_BOOLEAN_ISWITH_SHAPE];
    
}
-(BOOL)GetBooleanWithShape{
     NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    BOOL isWithShape = [userDefaults boolForKey:KEY_BOOLEAN_ISWITH_SHAPE];
    return isWithShape;
    
}

- (NSString *) getDocumentDirPath {
    DebugLog(@"");
    NSString *docsDirectory = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    return docsDirectory;
}

- (NSArray *) getAllImagesAndMovies{
    DebugLog(@"");
    
    NSMutableArray *dirArray = [[NSMutableArray alloc] initWithCapacity:1];
    
    NSString *path = [[TigglyStampUtils sharedInstance]getDocumentDirPath];
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSArray *directoryContents = [fileManager contentsOfDirectoryAtPath:path error:NULL];

    for (NSString *file in directoryContents) {
        if([file hasPrefix:@"TigglyStamp"] && ([[[file lastPathComponent] pathExtension] isEqualToString:@"png"] ||[[[file lastPathComponent] pathExtension] isEqualToString:@"mov"] )){
            [dirArray addObject:[path stringByAppendingPathComponent:file]];
        }
    }
    
    return dirArray;
}

-(UIImage *) getThumbnailImageOfMovieFile:(NSString *) filePath {
    DebugLog(@"");
    
    NSString *path = [[TigglyStampUtils sharedInstance]getDocumentDirPath];
    path = [path stringByAppendingPathComponent:filePath];
    NSURL *url = [NSURL fileURLWithPath:path];
    AVURLAsset *asset = [[AVURLAsset alloc] initWithURL:url options:nil];
    AVAssetImageGenerator *gen = [[AVAssetImageGenerator alloc] initWithAsset:asset];
    gen.appliesPreferredTrackTransform = YES;
    CMTime time = CMTimeMakeWithSeconds(0.0, HUGE_VAL);
    NSError *error = nil;
    CMTime actualTime;
    
    CGImageRef image = [gen copyCGImageAtTime:time actualTime:&actualTime error:&error];
    UIImage *thumb = [[UIImage alloc] initWithCGImage:image];
    CGImageRelease(image);
    
//    MPMoviePlayerController *player = [[MPMoviePlayerController alloc] initWithContentURL:url];
//    UIImage *thumbnail = [player thumbnailImageAtTime:1.0 timeOption:MPMovieTimeOptionNearestKeyFrame];
//    //Player autoplays audio on init
//    [player stop];
//    
    
    return thumb;
}

#pragma mark -
#pragma mark =============================================
#pragma mark Writing csv file for key of shape detection
#pragma mark =============================================

-(void)setDebugModeForWriteKeyInCsvOn:(BOOL) isOn{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setBool:isOn forKey:KEY_WRITE_KEYS_INCSV];
    
}
-(BOOL)getDebugModeForWriteKeyInCsvOn{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    BOOL isWithShape = [userDefaults boolForKey:KEY_WRITE_KEYS_INCSV];
    return isWithShape;
}


- (void) saveCSVFileData {
    DebugLog(@"");
    
	NSString *path = [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"]
					  stringByAppendingPathComponent:@"keycsvfile.csv"];
	[strCsvKyes writeToFile:path atomically:NO encoding:NSStringEncodingConversionAllowLossy error:NULL];

	DebugLog(@"File saved at path : %@", path);
}

- (void) deleteCSVFile{
    DebugLog(@"");
    NSString *path = [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"]
					  stringByAppendingPathComponent:@"keycsvfile.csv"];
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
        strCsvKyes = [[NSMutableString alloc]initWithString:@"D1,D2,D3,AD1,AD2,AD3,SHAPE\n"];
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


@end
