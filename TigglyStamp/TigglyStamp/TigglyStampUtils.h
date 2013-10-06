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
#import "TSTempData.h"

@interface TigglyStampUtils : NSObject{
    NSMutableString *strCsvKyes;
    int thumbnailCount;
}

+ (id)sharedInstance;
-(UIColor *)getRGBValueForShape:(NSString *)shapeToDraw withBasicShape:(NSString *)basicShape;

-(void)setShapeMode:(BOOL) bVar;
-(BOOL)getShapeMode;

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

-(BOOL) isSpaceAvailableOnDisk;
-(BOOL) isItemCountBelowTheLimit;

-(void)setCurrentLanguage:(NSString *)lang;
-(NSString *)getCurrentLanguage;

-(BOOL) isAppUnlockedForShapes;
-(void)unlockAppForShapes:(BOOL) boolean;

-(uint64_t)getFreeDiskspace;

-(BOOL) packTempData:(TSTempData *) pInfo toFolder:(NSString *) folder;
- (NSMutableArray *) getAllTempDataFromFolder:(NSString *)folder;

@end
