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
#define I_HAVE_SHAPE @"iHaveShape"
#define I_MISS_SHAPE @"iMissShape"
#define LIMIT_GALLERY @"limitGallery"

// Twitter Tokens
#define kOAuthConsumerKey           @"M3Nq5aWit1KMvxMiK3Vng"
#define kOAuthConsumerSecret		@"4MhzodK7wiAves9vWFn4qbWIQX77lwS2fkajlJVqNmY"

//Do not change the sequence
typedef enum {
    kShapeTypeCircle,
    kShapeTypeTriangle,
    kShapeTypeStar,
    kShapeTypeSquare    
} ShapeType;

@interface TConstant : NSObject

@end
