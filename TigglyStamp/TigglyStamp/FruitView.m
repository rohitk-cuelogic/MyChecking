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
@synthesize isFruitMovedSufficiently;

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

    }
    
    
    return self;
}

#pragma mark -
#pragma mark =======================================
#pragma mark Touches Handling
#pragma mark =======================================

-(void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    DebugLog(@"");
    initialRect = self.frame;

    isFruitMovedSufficiently = NO;
    touchLocation = [[touches anyObject] locationInView:self];
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
}

-(void) touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    DebugLog(@"");
    
    DebugLog(@"Initial Loc.x : %f", initialRect.origin.x);
    DebugLog(@"Initial Loc.y : %f", initialRect.origin.y);
    
    DebugLog(@"Frame origin.x : %f", self.frame.origin.x);
    DebugLog(@"Frame origin.y : %f", self.frame.origin.y);
    
    int xDiff =  self.frame.origin.x - initialRect.origin.x;
    int yDiff = self.frame.origin.y - initialRect.origin.y;
    
    DebugLog(@"Diff  x: %d y : %d",xDiff,yDiff);
    
    if(xDiff > 10 || xDiff  < -10)
        isFruitMovedSufficiently = YES;
    else
        isFruitMovedSufficiently = NO;
    
    if(isFruitMovedSufficiently  != YES) {
        if(yDiff > 10 || yDiff  < -10)
            isFruitMovedSufficiently = YES;
        else
            isFruitMovedSufficiently = NO;
    }
    
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
