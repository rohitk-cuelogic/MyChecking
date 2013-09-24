//
//  SettingsView.h
//  TigglyStamp
//
//  Created by Sachin Patil on 24/09/13.
//  Copyright (c) 2013 cuelogic. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@class SettingsView;

@protocol SettingViewProtocol <NSObject>
-(void) settingViewOnCloseButtonClick:(SettingsView *) sView;
@end

@interface SettingsView : UIView {
    
    
}

@property(nonatomic, unsafe_unretained)     id <SettingViewProtocol> delegate;


@end
