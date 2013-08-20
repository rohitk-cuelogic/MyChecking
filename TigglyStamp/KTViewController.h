//
//  KTViewController.h
//  
//
//  Created by Philip Hayes on 8/9/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MacroMite.h"
#import <AudioToolbox/AudioToolbox.h>
#import <AVFoundation/AVFoundation.h>
#import "TConstant.h"
#import "TigglyStampUtils.h"
#import <MessageUI/MessageUI.h>
#import <MessageUI/MFMailComposeViewController.h>

@class AppDelegate;
static AVAudioPlayer *player,*playerAlt, *playerCake, *playerApplause,*playerFailSound1,*playerFailSound2;
@interface KTViewController : UIViewController<MFMailComposeViewControllerDelegate>{
    
    //SystemSoundID wrong, correct, circleSound, squareSound, triangleSound;

}

-(AppDelegate*)appDelegate;

-(void)moveView:(CGPoint)point;
-(void)moveView:(CGPoint)point style:(UIViewAnimationOptions)options;
+ (SystemSoundID) createSoundID: (NSString*)name; 
+(void)playMusic: (NSString*)name withFormat: (NSString*)format;
+(void)playMusicAlt: (NSString*)name withFormat: (NSString*)format;
+(void)stopMusic;
+(void)stopMusicAlt;
+(void)doVolumeFadeIn;
+(void)doVolumeFadeOut;
-(void) sendEmail;

@end
