//
//  TConstant.h
//  Tiggly Safari
//
//  Created by Rohit Kale on 15/04/13.
//  Copyright (c) 2013 Tiggly. All rights reserved.
//

#import <Foundation/Foundation.h>


#define DEBUG_MODE
//#define IS_RUN_WITHOUT_SHAPE_FOR_TESTING 1


//#define TEST_MODE 1

#ifdef DEBUG_MODE
#define DebugLog( s, ... ) NSLog( @"<%s (%d)> %@", __FUNCTION__, __LINE__, [NSString stringWithFormat:(s), ##__VA_ARGS__] )
#else
#define DebugLog( s, ... )
#endif

#define APP_FONT @"Rockwell"
#define APP_FONT_BOLD @"Rockwell-Bold"
#define APP_FONT_BOLD_ITALIC @"Rockwell-BoldItalic"

#define SPEED_TIME_EASY 12
#define SPEED_TIME_MEDIUM 8
#define SPEED_TIME_HARD 4
#define RECT_THUMBNAIL_EDITOR_FRAME CGRectMake(0, 0, 735, 551)
#define RECT_MAIN_SCREEN_FRAME CGRectMake(0, 0, 1024, 768)

#define RECT_THUMBNAIL_FRAME CGRectMake(0, 0, 200, 184)
#define RECT_ACTUAL_THUMBNAIL_IMAGE_FRAME CGRectMake(0, 0, 200, 184)

// Setting screen 
#define LANGUAGE_SELECTED @"language"
#define MUSIC @"music"
#define SAVE_ART @"saveArt"
#define LIMIT_GALLERY @"limitGallery"
#define IS_WITH_SHAPE @"withShape"
#define IS_UNLOCKED_FOR_SHAPES @"unlockedForShapes"

// Twitter Tokens
#define kOAuthConsumerKey           @"M3Nq5aWit1KMvxMiK3Vng"
#define kOAuthConsumerSecret		@"4MhzodK7wiAves9vWFn4qbWIQX77lwS2fkajlJVqNmY"

//page curl
#define INT_X_LIMIT_TO_FULL_CURL 512
#define INT_Y_LIMIT_TO_FULL_CURL 384
#define FLOAT_FULL_CURL_TIME 0.8
#define FLOAT_CURL_TIME 0.3

//Do not change the sequence
typedef enum {
    kShapeTypeCircle,
    kShapeTypeTriangle,
    kShapeTypeStar,
    kShapeTypeSquare    
} ShapeType;

typedef enum {
    kSceneWinter,
    kSceneFall    
} SceneType;

@interface TConstant : NSObject

@end
