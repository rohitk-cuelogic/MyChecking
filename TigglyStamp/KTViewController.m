//
//  KTViewController.m
//
//
//  Created by Philip Hayes on 8/9/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "KTViewController.h"
#import "AppDelegate.h"
@implementation KTViewController
int volumeFadeInCnt;

-(AppDelegate *)appDelegate{
    //DebugLog(@"");
    return [UIApplication sharedApplication].delegate;
    
}

-(void)moveView:(CGPoint)point{
    
}
-(void)moveView:(CGPoint)point style:(UIViewAnimationOptions)options{
    //DebugLog(@"");
    
}
+ (SystemSoundID) createSoundID: (NSString*)name
{
    //DebugLog(@"createSoundID");
    NSString *path = [NSString stringWithFormat: @"%@/%@", [[NSBundle mainBundle] resourcePath], name];
    NSData * data = [[NSData alloc]initWithContentsOfFile:path];
    if (data.length == 0) {
        //DebugLog(@"No file found for %@", name);
    }
    
    NSURL* filePath = [NSURL fileURLWithPath: path isDirectory: NO];
    SystemSoundID soundID;
    AudioServicesCreateSystemSoundID((__bridge CFURLRef)filePath, &soundID);
    //DebugLog(@"createSoundID end");
    return soundID;
}
+(void)playMusic: (NSString*)name withFormat:(NSString *)format{
    // DebugLog(@"");
    //    NSString *soundFilePath = [[NSBundle mainBundle] pathForResource:name ofType:@"mp3"];
    NSString *soundFilePath = [[NSBundle mainBundle] pathForResource:name ofType:format];
    
    NSURL *soundFileURL = [NSURL fileURLWithPath:soundFilePath];
    player = [[AVAudioPlayer alloc] initWithContentsOfURL:soundFileURL error:nil];
    
    player.numberOfLoops = 0; //play once(default value)
    player.volume = 1;
    if ([[[NSUserDefaults standardUserDefaults] valueForKey:MUSIC] isEqualToString:@"yes"]) {
        [player play];
    }
    
}
+(void)playMusicAlt: (NSString*)name withFormat:(NSString *)format{
    //DebugLog(@"");
    volumeFadeInCnt=0;
    NSString *soundFilePath = [[NSBundle mainBundle] pathForResource:name ofType:format];
    NSURL *soundFileURL = [NSURL fileURLWithPath:soundFilePath];
    if([name isEqualToString:@"applause"]){
        DebugLog(@"playing applause.mp3");
        playerApplause = [[AVAudioPlayer alloc] initWithContentsOfURL:soundFileURL error:nil];
        playerApplause.numberOfLoops = 0; //play once(default value)
        playerApplause.volume = 1;
        if ([[[NSUserDefaults standardUserDefaults] valueForKey:MUSIC] isEqualToString:@"yes"]) {
            [playerApplause play];
        }
        return;
    }
    if([name rangeOfString:@"CakeCandle"].location != NSNotFound){
        DebugLog(@"CakeCandle substring found");
        playerCake = [[AVAudioPlayer alloc] initWithContentsOfURL:soundFileURL error:nil];
        playerCake.numberOfLoops = 0; //play once(default value)
        playerCake.volume = 1;
        if ([[[NSUserDefaults standardUserDefaults] valueForKey:MUSIC] isEqualToString:@"yes"]) {
            [playerCake play];
        }
        return;
    }
    DebugLog(@"CakeCandle substring not found");
    
    playerAlt = [[AVAudioPlayer alloc] initWithContentsOfURL:soundFileURL error:nil];
    
    playerAlt.numberOfLoops = 0; //play once(default value)
    playerAlt.volume = 1;
    if([name isEqualToString:@"Tiggy_ocean_music"]){
        playerAlt.numberOfLoops = -1; //play infinite times
        playerAlt.volume=0;
    }
    if([name isEqualToString:@"whale_back_clip"]){
        playerAlt.volume=0.3;
    }
    if ([[[NSUserDefaults standardUserDefaults] valueForKey:MUSIC] isEqualToString:@"yes"]) {
        
        [playerAlt play];
    }
}

+(void)stopMusic{
    //DebugLog(@"");
    [player stop];
}
+(void)stopMusicAlt{
    // DebugLog(@"");
    [playerAlt stop];
}
+(void)doVolumeFadeIn{
    //DebugLog(@"");
    if (playerAlt.volume < 1.0) {
        playerAlt.volume = playerAlt.volume + 0.05;
        [self performSelector:@selector(doVolumeFadeIn) withObject:nil afterDelay:0.1];
    }
}
+(void)doVolumeFadeOut{
    //DebugLog(@"");
    if (playerAlt.volume > 0.1) {
        playerAlt.volume = playerAlt.volume - 0.05;
        [self performSelector:@selector(doVolumeFadeOut) withObject:nil afterDelay:0.1];
    } else {
        // Stop and get the sound ready for playing again
        [playerAlt stop];
        playerAlt.currentTime = 0;
        [playerAlt prepareToPlay];
        playerAlt.volume = 1.0;
    }
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	return (interfaceOrientation == UIInterfaceOrientationLandscapeLeft || interfaceOrientation == UIInterfaceOrientationLandscapeRight);
}

@end
