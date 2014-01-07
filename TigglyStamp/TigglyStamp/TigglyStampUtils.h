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
#import "UIDevice+IdentifierAddition.h"
#import "Reachability.h"
#import "ZipArchive.h"

@interface TigglyStampUtils : NSObject{
    NSMutableString *strCsvKyes;
    int thumbnailCount;
}

+ (id)sharedInstance;

-(void)setShapeMode:(BOOL) bVar;
-(BOOL)getShapeMode;

- (NSString *) getDocumentDirPath;
- (NSArray *) getAllImagesAndMovies;

-(ShapeType)getCurrentSahpeForStoringKeys;
-(void)setCurrentSahpeForStoringKeys:(ShapeType)sType;

-(BOOL) isSpaceAvailableOnDisk;
-(BOOL) isItemCountBelowTheLimit;

-(void)setCurrentLanguage:(NSString *)lang;
-(NSString *)getCurrentLanguage;
-(NSString*) getLocalisedStringForKey:(NSString*) key;

-(BOOL) isAppUnlockedForShapes;
-(void)unlockAppForShapes:(BOOL) boolean;

-(uint64_t)getFreeDiskspace;

-(BOOL) packTempData:(TSTempData *) pInfo toFolder:(NSString *) folder;
- (NSMutableArray *) getAllTempDataFromFolder:(NSString *)folder;
-(void) deleteTempFileDataFromFolder:(NSString *) folder;
-(BOOL) shouldRestrictSavingDataFile;
-(void) setShouldRestrictSavingDataFile:(BOOL) status;

-(void) setMusicStatus:(NSString *) status;
-(NSString *) getMusicStatus;

-(UIImage *) getMovieImageForMovieName:(NSString *) moviePath;
-(NSString *) getMovieImagePathForMovieName:(NSString *) moviePath;

//for writing csv for keys
-(BOOL)getDebugModeForWriteKeyInCsvOn;
-(void)setDebugModeForWriteKeyInCsvOn:(BOOL) isOn;
-(void) saveCSVFileData;
-(void) deleteCSVFile;
-(void)appendKeyDatatoString:(NSString *)str;
-(BOOL) isMailSupported;
-(NSString *)getCsvKeys;
-(BOOL)getSendMailOn;
-(void)setSendMailOn:(BOOL) isOn;
-(NSString *) getDeviceIDMacAddres;
-(NSString*) getCurrentLanguageCode;
- (NSString *) platformString;
-(void) setiPadMiniDeviceVersion:(NSMutableArray *) deviceArray;
-(NSMutableArray *) getiPadMiniDeviceVersion;
-(BOOL)isNetworkAvailable;
- (void)unzipAndSaveFile:(NSString *)strFileName;

-(void)setRateMeCount;
-(int)getRateMeCount;

-(void)setShouldStopShowingRateMePopUp:(BOOL)bShoulShow;
-(BOOL)shouldStopShowingRateMePopUp;


@end
