//
//  AppDelegate.h
//  TigglyStamp
//
//  Created by cuelogic on 01/07/13.
//  Copyright (c) 2013 cuelogic. All rights reserved.
//

#import <UIKit/UIKit.h>
@class IntroScreen;
@class IntroScreenViewController;
static NSMutableDictionary *shapeDicionary;
@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) IntroScreenViewController *viewController;
@property (strong, nonatomic) UINavigationController *navController;

@end
