//
//  TSRateMe.h
//  TigglySafari
//
//  Created by datta on 06/01/14.
//  Copyright (c) 2014 Sachin Patil. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TSRateMe;

@protocol rateMeDelegates <NSObject>

-(void)rateMeOkButtonClicked:(TSRateMe *) rateMeView;
-(void)rateMeCancelButtonCLicked:(TSRateMe *) rateMeView;
@end

@interface TSRateMe : UIView{
    
    IBOutlet UIView *view;
    IBOutlet UIView *viewRateMe;
    IBOutlet UIImageView *imgBkg;

}

@property(nonatomic,retain)IBOutlet UIView *view;
@property(nonatomic, unsafe_unretained)id<rateMeDelegates>delegate;

-(void)showPopUp;
-(void)hidePopUp;

@end
