//
//  PhysicalShapesView.h
//  Tiggly Safari
//
//  Created by Sachin Patil on 25/06/13.
//  Copyright (c) 2013 Tiggly. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PhysicalShapesView;

@protocol PhysicalShapeViewProtocol <NSObject>
-(void) physicalShapeViewOnTouchesBegan:(PhysicalShapesView *) phyShapeView;
-(void) physicalShapeViewOnTouchesMoved:(PhysicalShapesView *) phyShapeView;
-(void) physicalShapeViewOnTouchesEnded:(NSSet *)touches withEvent:(UIEvent *)event forView:(PhysicalShapesView *) phyShapeView;
@end

@interface PhysicalShapesView : UIView {
    NSString *shapeName;
    CGRect initialFrame;
    CGPoint touchLocation;
    UIImageView *imgView;
}

@property (nonatomic, strong) NSString *shapeName;
@property (unsafe_unretained,nonatomic) id<PhysicalShapeViewProtocol> delagate;
@property (nonatomic, readonly)CGRect initialFrame;
@property (nonatomic, strong) UIImageView *imgView;

-(id) initWithFrame:(CGRect)frame withShapeName:(NSString *) sName;

@end
