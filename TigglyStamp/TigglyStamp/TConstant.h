//
//  TConstant.h
//  Tiggly Stamp
//
//  Created by Rohit Kale on 15/04/13.
//  Copyright (c) 2013 Tiggly. All rights reserved.
//

#import <Foundation/Foundation.h>


//#define DEBUG_MODE
//#define IS_RUN_WITHOUT_SHAPE_FOR_TESTING 1
//#define IS_RUN_ON_SIMULATOR
//#define TEST_MODE 1


#ifdef IS_RUN_ON_SIMULATOR
#else
#define GOOGLE_ANALYTICS_START
#endif


#ifdef DEBUG_MODE
#define DebugLog( s, ... ) NSLog( @"<%s (%d)> %@", __FUNCTION__, __LINE__, [NSString stringWithFormat:(s), ##__VA_ARGS__] )
#else
#define DebugLog( s, ... )
#endif

#define APP_FONT @"Rockwell"
#define APP_FONT_BOLD @"Rockwell-Bold"
#define APP_FONT_BOLD_ITALIC @"Rockwell-BoldItalic"

#define RECT_THUMBNAIL_EDITOR_FRAME CGRectMake(0, 0, 800, 600)
#define RECT_MAIN_SCREEN_FRAME CGRectMake(0, 0, 1000, 750)

#define RECT_THUMBNAIL_FRAME CGRectMake(0, 0, 230, 180)
#define RECT_ACTUAL_THUMBNAIL_IMAGE_FRAME CGRectMake(0, 0, 230, 180)

// Setting screen
#define LANGUAGE_SELECTED @"language"
#define MUSIC @"music"
#define SAVE_ART @"saveArt"
#define LIMIT_GALLERY @"limitGallery"
#define IS_WITH_SHAPE @"withShape"
#define IS_UNLOCKED_FOR_SHAPES @"unlockedForShapes"

//page curl
#define INT_X_LIMIT_TO_FULL_CURL 512
#define INT_Y_LIMIT_TO_FULL_CURL 384
#define FLOAT_FULL_CURL_TIME 0.8
#define FLOAT_CURL_TIME 0.3

#define SUBSCRIPTION_EMAIL_ID  @"subscription@tiggly.com"
#define SENDER_EMAIL_ID @"tigglytwitter@gmail.com"
#define SENDER_EMAIL_ID_PASSWORD @"tiggly123"

#define FOLDER_CHILD_DATA @"TigglyChildData"
#define FOLDER_SUBSCRIPTION_DATA @"TigglySubscriptionData"

#define GALLERY_LIMIT 60

#define STR_WITH_BORDER @"Border"
#define STR_WITH_MOVIE_BORDER @"BorderMovie"

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


typedef enum {
        kScreenEntryFromHomeView,
        kScreenEntryFromIntroView,
        kScreenEntryFromSettingView,
} UnlockScreenEntry;

