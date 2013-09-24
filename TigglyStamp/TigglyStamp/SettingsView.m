//
//  SettingsView.m
//  TigglyStamp
//
//  Created by Sachin Patil on 24/09/13.
//  Copyright (c) 2013 cuelogic. All rights reserved.
//

#import "SettingsView.h"
#import "TConstant.h"


@implementation SettingsView

@synthesize delegate;

#pragma mark -
#pragma mark =======================================
#pragma mark Init
#pragma mark =======================================

- (id)initWithFrame:(CGRect)frame {
    DebugLog(@"");
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorWithRed:45.0f/255.0f green:116.0f/255.0f blue:210.0f/255.0f alpha:1.0f];
        self.layer.cornerRadius = 20.0f;
        self.userInteractionEnabled = YES;
        
        UIButton *btnClose = [UIButton buttonWithType:UIButtonTypeCustom];
        [btnClose setBackgroundImage:[UIImage imageNamed:@"close_btn.png.png"] forState:UIControlStateNormal];
        [btnClose setBackgroundImage:[UIImage imageNamed:@"close_btn.png.png"] forState:UIControlStateSelected];
        [btnClose addTarget:self action:@selector(actionClose)forControlEvents:UIControlEventTouchUpInside];
        btnClose.frame = CGRectMake(730, 0, 70, 70);
        [self addSubview:btnClose];
        
    }
    return self;
}

#pragma mark -
#pragma mark =======================================
#pragma mark Action Handling
#pragma mark =======================================

-(void) actionClose {
    DebugLog(@"");

    [self.delegate settingViewOnCloseButtonClick:self];
}

-(void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    DebugLog(@"");
    
}

@end
