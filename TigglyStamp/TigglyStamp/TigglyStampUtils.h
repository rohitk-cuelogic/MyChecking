//
//  TigglyStampUtils.h
//  TigglyStamp
//
//  Created by cuelogic on 16/07/13.
//  Copyright (c) 2013 cuelogic. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TConstant.h"
#import <AVFoundation/AVFoundation.h>
#import <MediaPlayer/MediaPlayer.h>
@interface TigglyStampUtils : NSObject{
    NSMutableString *strCsvKyes;
    int thumbnailCount;
}

+ (id)sharedInstance;
-(UIColor *)getRGBValueForShape:(NSString *)shapeToDraw withBasicShape:(NSString *)basicShape;

-(void)SetBooleanWithShape:(BOOL) bVar;
-(BOOL)GetBooleanWithShape;

- (NSString *) getDocumentDirPath;
- (NSArray *) getAllImagesAndMovies;

-(UIImage *) getThumbnailImageOfMovieFile:(NSString *) filePath;


//for writing csv for keys
-(BOOL)getDebugModeForWriteKeyInCsvOn;
    
-(void)setDebugModeForWriteKeyInCsvOn:(BOOL) isOn;

- (void) saveCSVFileData;
- (void) deleteCSVFile;
-(void)appendKeyDatatoString:(NSString *)str;
- (BOOL) isMailSupported;
-(NSString *)getCsvKeys;
-(BOOL)getSendMailOn;
-(void)setSendMailOn:(BOOL) isOn;

-(ShapeType)getCurrentSahpeForStoringKeys;
-(void)setCurrentSahpeForStoringKeys:(ShapeType)sType;


-(void)setCurrentLanguage:(NSString *)lang;
-(NSString *)getCurrentLanguage;

@end
