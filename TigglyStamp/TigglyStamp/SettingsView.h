//
//  SettingsView.h
//  TigglyStamp
//
//  Created by Sachin Patil on 24/09/13.
//  Copyright (c) 2013 cuelogic. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "GAITrackedViewController.h"
#import "GAI.h"
#import "GAIDictionaryBuilder.h"
#import "GAIFields.h"

@class SettingsView;

@protocol SettingViewProtocol <NSObject>
-(void) settingViewOnCloseButtonClick:(SettingsView *) sView;
-(void) settingViewOnShapeSwitchClick:(SettingsView *) sView;
@end

@interface SettingsView : UIView <UITableViewDataSource, UITableViewDelegate>{
    
    
}

@property(nonatomic, unsafe_unretained)     id <SettingViewProtocol> delegate;


@end
