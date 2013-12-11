//
//  ActivityAlertView.h
//  CreamLRG
//
//  Created by Gaurav Jindal on 10/11/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface ActivityAlertView : UIAlertView {
}


- (void) close;
-(void)statAnimation;
-(void)showActivityIndicator;
-(void)hideActivityIndicator;

@end
