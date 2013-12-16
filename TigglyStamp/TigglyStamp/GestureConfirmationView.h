//
//  GestureConfirmationView.h
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

@class GestureConfirmationView;

@protocol GestireViewProtocol <NSObject>
@optional
-(void) gestureViewOnGestureConfirmed:(GestureConfirmationView *) gView;
-(void) gestureViewOnCancel:(GestureConfirmationView *) gView;
-(void) gestureViewOnChangeLanguage;

@end

@interface GestureConfirmationView : UIView<UITableViewDataSource, UITableViewDelegate>{
    UITextView *txtView;
    UISwipeGestureRecognizer *swipeGesture;
    int swipeTxtCnt;
    UITableView *tblView;
    
}

@property (nonatomic, unsafe_unretained) id<GestireViewProtocol> delegate;
@property (nonatomic) int swipeTxtCnt;

- (id)initLoadLanguageOptionWithFrame:(CGRect)frame;
@end
