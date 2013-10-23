//
//  GestureConfirmationView.h
//  TigglyStamp
//
//  Created by Sachin Patil on 24/09/13.
//  Copyright (c) 2013 cuelogic. All rights reserved.
//

#import <UIKit/UIKit.h>

@class GestureConfirmationView;

@protocol GestireViewProtocol <NSObject>
-(void) gestureViewOnGestureConfirmed:(GestureConfirmationView *) gView;
@optional
-(void) gestureViewOnCancel:(GestureConfirmationView *) gView;
@end

@interface GestureConfirmationView : UIView{
    UITextView *txtView;
    NSArray *swipeTextArray;
    UISwipeGestureRecognizer *swipeGesture;
}

@property (nonatomic, unsafe_unretained) id<GestireViewProtocol> delegate;
@end
