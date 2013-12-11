//
//  ActivityAlertView.m
//  CreamLRG
//
//  Created by Gaurav Jindal on 10/11/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "ActivityAlertView.h"


@implementation ActivityAlertView


- (id)initWithFrame:(CGRect)frame
{
    if ((self = [super initWithFrame:frame]))
	{
        
		//[activityView startAnimating];
    }
	
    return self;
}

- (void) close
{
	[self dismissWithClickedButtonIndex:0 animated:YES];
}

-(void)statAnimation
{
    UIActivityIndicatorView *activityView = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(125, 55, 30, 30)];
    [activityView startAnimating];
    activityView.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhiteLarge;
    [self addSubview:activityView];
}

#pragma mark - Show Activity Indicator -
-(void)showActivityIndicator
{
    [self show];
    [self statAnimation];
}

#pragma mark - Hide Activity Indicator -
-(void)hideActivityIndicator
{
    //Remove the alert
    [self close];
}

@end
