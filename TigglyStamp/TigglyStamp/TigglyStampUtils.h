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
@interface TigglyStampUtils : NSObject

+ (id)sharedInstance;
-(UIColor *)getRGBValueForShape:(NSString *)shapeToDraw withBasicShape:(NSString *)basicShape;

-(void)SetBooleanWithShape:(BOOL) bVar;
-(BOOL)GetBooleanWithShape;

- (NSString *) getDocumentDirPath;
- (NSArray *) getAllImagesAndMovies;

-(UIImage *) getThumbnailImageOfMovieFile:(NSString *) filePath;

@end
