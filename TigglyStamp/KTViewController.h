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
@interface KTViewController : UIViewController<MFMailComposeViewControllerDelegate>{
  
}

-(AppDelegate*)appDelegate;

-(void) sendEmail;

@end
