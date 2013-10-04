//
//  AppDelegate.m
//  TigglyStamp
//
//  Created by cuelogic on 01/07/13.
//  Copyright (c) 2013 cuelogic. All rights reserved.
//

#import "AppDelegate.h"
#import "IntroScreenViewController.h"
#import "TigglyStampUtils.h"
#import "TDSoundManager.h"
#import "TConstant.h"

#ifdef GOOGLE_ANALYTICS_START
#import "GAI.h"
#else

#endif


@implementation AppDelegate
@synthesize navController;
@synthesize allFiles;

/******* Set your tracking ID here *******/
static NSString *const kTrackingId = @"UA-43978705-5";
static NSString *const kAllowTracking = @"allowTracking";


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.viewController =[[IntroScreenViewController alloc]initWithNibName:@"IntroScreenViewController" bundle:nil];
    self.navController = [[UINavigationController alloc] initWithRootViewController:self.viewController];
    
    self.window.rootViewController = self.navController;
    
    [self.window makeKeyAndVisible];
    
    allFiles = [[TigglyStampUtils sharedInstance]getAllImagesAndMovies];
    DebugLog(@"AllFilesCount : %d",allFiles.count);
    
#ifdef GOOGLE_ANALYTICS_START
    [[GAI sharedInstance] trackerWithName:@"iOSTigglySafari"
                               trackingId:kTrackingId];
    
    NSMutableDictionary *event =
    [[GAIDictionaryBuilder createEventWithCategory:@"About tiggly"
                                            action:@"App Open"
                                             label:@"Application open"
                                             value:nil] build];
    [[GAI sharedInstance].defaultTracker send:event];
    [[GAI sharedInstance] dispatch];
#else
    
#endif

    
    

    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    
    [[TDSoundManager sharedManager] stopMusic];
    [[TDSoundManager sharedManager] stopSound];
    
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
