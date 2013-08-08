//
//  FruitView.m
//  Tiggly Safari
//
//  Created by Sachin Patil on 29/05/13.
//  Copyright (c) 2013 Tiggly. All rights reserved.
//

#import "FruitView.h"
#import "TConstant.h"

@implementation FruitView

@synthesize delegate;
@synthesize imgView;
@synthesize objectName;

#pragma mark -
#pragma mark =======================================
#pragma mark Init
#pragma mark =======================================

-(id) initWithFrame:(CGRect)frame withShape:(NSString *) shapeName {
    DebugLog(@"");
    self = [super initWithFrame:frame];
    if (self) {
        imgView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        imgView.contentMode = UIViewContentModeScaleAspectFit;
        imgView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@.png",shapeName]];
        objectName = shapeName;
        [self addSubview:imgView];
        self.userInteractionEnabled = YES;
        increaseSize = 0;
//        if([shapeName isEqualToString:@"sled"]){
//            UISwipeGestureRecognizer *oneFingerSwipeLeft = [[UISwipeGestureRecognizer alloc]
//                                                            initWithTarget:self
//                                                            action:@selector(oneFingerSwipeLeft:)];
//            [oneFingerSwipeLeft setDirection:UISwipeGestureRecognizerDirectionLeft];
//            [self addGestureRecognizer:oneFingerSwipeLeft];
//            
//            UISwipeGestureRecognizer *oneFingerSwipeRight = [[UISwipeGestureRecognizer alloc]
//                                                             initWithTarget:self
//                                                             action:@selector(oneFingerSwipeRight:)];
//            [oneFingerSwipeRight setDirection:UISwipeGestureRecognizerDirectionRight];
//            [self addGestureRecognizer:oneFingerSwipeRight];
//        }
        
//        UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panGestureMoveAround:)];
//        [panGesture setMaximumNumberOfTouches:1];
//        [self addGestureRecognizer:panGesture];
        
//        UITapGestureRecognizer *singleFingerTap = [[UITapGestureRecognizer alloc] initWithTarget:self
//                                                action:@selector(handleSingleTap:)];
//        [self addGestureRecognizer:singleFingerTap];
    }
    
    
    return self;
}

#pragma mark -
#pragma mark =======================================
#pragma mark Touches Handling
#pragma mark =======================================

-(void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    DebugLog(@"");
    touchLocation = [[touches anyObject] locationInView:self];
//    [self.delegate onFruitViewTouchesBegan:self];
    [self.delegate onFruitView:self touchesBegan:touches];
    
}
-(void) moveObject:(NSSet *)set point:(CGPoint)point{
    UITouch *aTouch = [set anyObject];
    CGPoint location = [aTouch locationInView:self];
    
    CGRect frame = self.frame;

    if ((self.frame.origin.x + location.x - touchLocation.x > 1024 - (imgView.frame.size.width) && self.frame.origin.y + location.y - touchLocation.y > (768 - (imgView.frame.size.height))) || (self.frame.origin.x + location.x - touchLocation.x > 1024 - (imgView.frame.size.width) && self.frame.origin.y + location.y - touchLocation.y < 0) || ( self.frame.origin.x + location.x - touchLocation.x < 0 && self.frame.origin.y + location.y - touchLocation.y > (768 - (imgView.frame.size.height))) || (self.frame.origin.x + location.x - touchLocation.x < 0 && self.frame.origin.y + location.y - touchLocation.y < 0)) {
        
    }else if ( self.frame.origin.x + location.x - touchLocation.x > 1024 - (imgView.frame.size.width) ) {
        frame.origin.x = self.frame.origin.x;
        frame.origin.y = self.frame.origin.y + location.y - touchLocation.y;
    }else if ( self.frame.origin.x + location.x - touchLocation.x < 0){
        frame.origin.x = self.frame.origin.x;
        frame.origin.y = self.frame.origin.y + location.y - touchLocation.y;
    }else if (self.frame.origin.y + location.y - touchLocation.y > (768 - (imgView.frame.size.height))){
        frame.origin.x = self.frame.origin.x + location.x - touchLocation.x;
        frame.origin.y = self.frame.origin.y;
    }else if (self.frame.origin.y + location.y - touchLocation.y < 0){
        frame.origin.x = self.frame.origin.x + location.x - touchLocation.x;
        frame.origin.y = self.frame.origin.y;
    }else{
        frame.origin.x = self.frame.origin.x + location.x - touchLocation.x;
        frame.origin.y = self.frame.origin.y + location.y - touchLocation.y;
    }

    
    
    DebugLog(@"Fruit Frame : %@", NSStringFromCGRect(frame));
    
    [self setFrame:frame];
}

-(void) touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    DebugLog(@"");
   [self.delegate onFruitView:self touchesMoved:touches];
    
//    [self.delegate onFruitView:self touchesMoved:touches];
}

-(void) touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    DebugLog(@"");
     
    [self .delegate onFruitView:self touchesEnded:touches];
}
- (void)oneFingerSwipeLeft:(UITapGestureRecognizer *)recognizer {
    // Insert your own code to handle swipe left
    DebugLog(@"Move to left");
    //[self .delegate onFruitViewSwipeLeft:self];
}

- (void)oneFingerSwipeRight:(UITapGestureRecognizer *)recognizer {
    // Insert your own code to handle swipe right
    DebugLog(@"Move to right");
    //[self .delegate onFruitViewSwipeRight:self];
}

//-(void)panGestureMoveAround:(UIPanGestureRecognizer *)recognizer {
//    DebugLog(@"");
//    if(recognizer.state == UIGestureRecognizerStateBegan)
//        DebugLog(@"Tap called");
//}

//-(void)handleSingleTap:(UITapGestureRecognizer *)recognizer {
//    DebugLog(@"");
//    DebugLog(@"Tap called");
//}
@end
