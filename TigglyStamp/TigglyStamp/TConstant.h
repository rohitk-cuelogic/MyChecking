//
//  TConstant.h
//  Tiggly Stamp
//
//  Created by Rohit Kale on 15/04/13.
//  Copyright (c) 2013 Tiggly. All rights reserved.
//

#import <Foundation/Foundation.h>


#define DEBUG_MODE
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

#define RECT_IPAD CGRectMake(0, 0, 1024, 768)


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


// Facebook sharing
#define FACEBOOK_APP_KEY @"184233351778353"

#define APPLICATION_NAME @"Tiggly Stamp"

//Web Services
#define APP_NAME @"stamp"
#define REQUEST_ARRAY @"RequestArray"
#define SERVICE_MAIN_URL @"http://api.tiggly.com/manageapi?"
#define SERVICE_URL_PART @"&u=4a6cb8d9ef751088a25bb26a11446910&p="

//live
//#define SERVICE_URL @"http://api.tiggly.com/manageapi?f=tig."

// Dev
#define SERVICE_URL @"http://development.tiggly.com/version1.0/manageapi?f=tig."

//Web Service names
#define SERVICE_NAME_SUBSCRIPTION @"subscribe"
#define SERVICE_URL_SET_DEVICEPROFILE @"setDeviceProfile"
#define SERVICE_URL_SET_BEHAVIOURCOUNT @"setBehaviourCount"
#define SERVICE_URL_SHAPEDRAW @"shapeDraw"
#define SERVICE_URL_NEWSFEED_COUNT @"getUserNewsCount"
#define SERVICE_URL_NEWSFEED @"newsFeed"
#define SERVICE_URL_SESSIONDETAILS @"sessionDetails"
#define SERVICE_URL_IPAD_DEVICE_VERSION @"getiPadMiniDeviceVersion"
#define IPADMINI_DEVICE_ARRAY @"iPadMiniDeviceArray"
#define MAX_QUEUE_COUNT   50
#define UNREAD_NEWS_COUNT @"UnreadNewsCount"
#define JSON_RESPONSE @"ResponseDict.json"

#define SYSTEM_VERSION_EQUAL_TO(v)                  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedSame)
#define SYSTEM_VERSION_GREATER_THAN(v)              ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedDescending)
#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN(v)                 ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN_OR_EQUAL_TO(v)     ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedDescending)

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

