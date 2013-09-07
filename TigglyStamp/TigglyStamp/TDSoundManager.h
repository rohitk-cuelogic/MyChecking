//
//  TDSoundManager.h
//  ivyApplication
//
//  Created by Dattatraya Anarase on 08/07/13.
//
//

#import <Foundation/Foundation.h>
#import "AudioToolBox/AudioToolbox.h"
#import <AVFoundation/AVFoundation.h>

@interface TDSoundManager : NSObject
 


+ (TDSoundManager *) sharedManager;
+ (SystemSoundID) createSoundID: (NSString*)name;
-(void)playMusic: (NSString*)name withFormat: (NSString*)format;
-(void) playSound:(NSString *) name withFormat: (NSString*)format;
-(void)stopMusic;
-(void)stopSound;
-(void)doVolumeFadeIn;
-(void)doVolumeFadeOut;
-(float)getSoundDuration;
@end
