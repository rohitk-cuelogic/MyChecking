//
//  UITouchRecognizerView.h
//  ivyApplication
//
//  Created by Philip Hayes on 8/7/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//
#define vVerificationMode6Point @"6-p"
#define vVerificationModePassive @""
#import "UITouchVerificationView.h"
#import "TConstant.h"

BOOL calculateShape(UITouchGroup*group, UIView *view);
@interface UITouchRecognizerView : UITouchVerificationView

@end
