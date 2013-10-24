//
//  FruitView.h
//  Tiggly Stamp
//
//  Created by Sachin Patil on 29/05/13.
//  Copyright (c) 2013 Tiggly. All rights reserved.
//

#import <UIKit/UIKit.h>

@class FruitView;

@protocol FruitViewProtocol <NSObject>
-(void) onFruitView:(FruitView *) fruit touchesBegan:(NSSet *)touches;
-(void) onFruitView:(FruitView *) fruit touchesMoved:(NSSet *)touches;
-(void) onFruitView:(FruitView *) fruit touchesEnded:(NSSet *)touches;
-(void) onFruitViewSwipeLeft:(FruitView *) fruit;
-(void) onFruitViewSwipeRight:(FruitView *) fruit;
@end

@interface FruitView : UIView {
    
    NSString *shape;   
    CGPoint touchLocation;
    int increaseSize;
 
    CGRect initialRect;
 
}
@property (nonatomic, readonly) BOOL isFruitMovedSufficiently;
@property(nonatomic,strong) id<FruitViewProtocol>delegate;
@property(nonatomic,strong)UIImageView *imgView;
@property(nonatomic,strong)NSString *objectName;
-(id) initWithFrame:(CGRect)frame withShape:(NSString *) shapeName;
-(void) moveObject:(NSSet *)set point:(CGPoint)point isRecording:(BOOL) isTrue;
@end
