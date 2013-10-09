//
//  TDSignatureView.h
//  TigglyDraw
//
//  Created by datta on 03/10/13.
//
//

#import <UIKit/UIKit.h>
#import "TConstant.h"

@interface TDSignatureView : UIView{
    
    UIImageView *imgViewForSign;
    UIColor *lineColor;

    UIBezierPath *myPath;
}

@property (nonatomic,strong)UIColor *lineColor;
@property (nonatomic,strong)UIBezierPath *myPath;

@end
