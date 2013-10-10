//
//  TDSignatureView.h
//  TigglyDraw
//
//  Created by datta on 03/10/13.
//
//

#import <UIKit/UIKit.h>
#import "TConstant.h"

@class TDSignatureView;

@protocol SignatureViewProtocol <NSObject>
@optional
-(void) signatureViewOnTouchesBegan:(TDSignatureView *)signView;
-(void) signatureViewOnTouchesMoved:(TDSignatureView *)signView;
-(void) signatureViewOnTouchesEnded:(TDSignatureView *)signView;
@end

@interface TDSignatureView : UIView{
    
    UIImageView *imgViewForSign;
    UIColor *lineColor;

    UIBezierPath *myPath;
}

@property (nonatomic, unsafe_unretained ) id<SignatureViewProtocol> delegate;
@property (nonatomic,strong)UIColor *lineColor;
@property (nonatomic,strong)UIBezierPath *myPath;

@end
