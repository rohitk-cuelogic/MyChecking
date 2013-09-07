//
//  TDSoundManager.m
//  ivyApplication
//
//  Created by Dattatraya Anarase on 08/07/13.
//
//

#import "TDSoundManager.h"
#import "TConstant.h"

static AVAudioPlayer *player;
static AVAudioPlayer *player2;
static TDSoundManager *sharedInstance = nil;
int val;
@implementation TDSoundManager

+ (TDSoundManager *) sharedManager {
    
    if (sharedInstance == nil) {
        sharedInstance = [[super alloc] init];
    }
    return sharedInstance;
}
- (id) init {
    self = [super init];
    if (self) {
        DebugLog(@"");
        val = 10;
    }
    return self;
}
+ (SystemSoundID) createSoundID: (NSString*)name {
    DebugLog(@"createSoundID");
    NSString *path = [NSString stringWithFormat: @"%@/%@", [[NSBundle mainBundle] resourcePath], name];
    NSData * data = [[NSData alloc]initWithContentsOfFile:path];
    if (data.length == 0) {
        NSLog(@"No file found for %@", name);
    }
    
    NSURL* filePath = [NSURL fileURLWithPath: path isDirectory: NO];
    SystemSoundID soundID;
    AudioServicesCreateSystemSoundID((__bridge CFURLRef)filePath, &soundID);
#ifdef DISABLE_SOUND
    return NULL;
#else
    if ([[[NSUserDefaults standardUserDefaults] valueForKey:MUSIC] isEqualToString:@"yes"])
        return soundID;
    else
        return NULL;
#endif
}

-(void)playMusic:(NSString *)name withFormat:(NSString *)format{
    DebugLog(@"");

    DebugLog(@"Name: %@",name);
    
    if([name isEqualToString:@""] || name == nil || [name isEqual:NULL])
        return;
    
    
    NSString *soundFilePath = [[NSBundle mainBundle] pathForResource:name ofType:format];
    
    DebugLog(@"SoundFilePath: %@",soundFilePath);
    
    if ([[NSFileManager defaultManager] fileExistsAtPath:soundFilePath])
    {    
            NSURL *soundFileURL = [NSURL fileURLWithPath:soundFilePath];
            player = [[AVAudioPlayer alloc] initWithContentsOfURL:soundFileURL error:nil];
            player.numberOfLoops = -1;
            player.volume = 1;
        #ifdef DISABLE_SOUND
            
        #else
            if ([[[NSUserDefaults standardUserDefaults] valueForKey:MUSIC] isEqualToString:@"yes"]) {
              if(player.isPlaying)
                  [player stop];
                
              [player play];
            }
        #endif
    }
}

-(void) playSound:(NSString *) name withFormat: (NSString*)format {
    DebugLog(@"");

    DebugLog(@"Name: %@",name);
    

    
    if([name isEqualToString:@""] || name == nil || [name isEqual:NULL])
           return;
    
    
    NSString *soundFilePath = [[NSBundle mainBundle] pathForResource:name ofType:format];
    
   DebugLog(@"SoundFilePath: %@",soundFilePath);
    
    if ([[NSFileManager defaultManager] fileExistsAtPath:soundFilePath])
    {
                
            NSURL *soundFileURL = [NSURL fileURLWithPath:soundFilePath];
            player2 = [[AVAudioPlayer alloc] initWithContentsOfURL:soundFileURL error:nil];
            player2.numberOfLoops = 0;
        if ([name isEqualToString:@"rooster_Animal"]) {
            player2.volume = 0.7;
        }else{
            player2.volume = 1.0;
        }
            

            if ([[[NSUserDefaults standardUserDefaults] valueForKey:MUSIC] isEqualToString:@"yes"]) {
                if(player2.isPlaying)
                    [player2 stop];
                
                [player2 play];
            }
        
    }
}

-(void)stopMusic{
    DebugLog(@"");
    [player stop];
}


-(void)stopSound{
    DebugLog(@"");
    [player2 stop];
}

-(void)doVolumeFadeIn{
    DebugLog(@"");
    if (player.volume < 1.0) {
        player.volume = player.volume + 0.05;
        [self performSelector:@selector(doVolumeFadeIn) withObject:nil afterDelay:0.1];
    }
}
-(void)doVolumeFadeOut{
    DebugLog(@"");
    if (player.volume > 0.1) {
        player.volume = player.volume - 0.05;
        [self performSelector:@selector(doVolumeFadeOut) withObject:nil afterDelay:0.1];
    } else {
        // Stop and get the sound ready for playing again
        [player stop];
        player.currentTime = 0;
        [player prepareToPlay];
        player.volume = 1.0;
    }
}

@end
