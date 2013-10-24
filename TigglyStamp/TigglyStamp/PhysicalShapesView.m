//
//  PhysicalShapesView.m
//  Tiggly Stamp
//
//  Created by Sachin Patil on 25/06/13.
//  Copyright (c) 2013 Tiggly. All rights reserved.
//

#import "PhysicalShapesView.h"
#import "TConstant.h"

@implementation PhysicalShapesView
@synthesize shapeName;
@synthesize delagate;
@synthesize initialFrame;
@synthesize imgView;

#pragma mark -
#pragma mark =======================================
#pragma mark Init
#pragma mark =======================================

-(id) initWithFrame:(CGRect)frame withShapeName:(NSString *) sName {
    DebugLog(@"");
    self = [super initWithFrame:frame];
    if (self) {
        self.shapeName = sName;
        initialFrame = frame;
        imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        imgView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@_1.png",sName]];
        [self addSubview:imgView];
        
        self.userInteractionEnabled = YES;
    }
    return self;
}

#pragma mark -
#pragma mark =======================================
#pragma mark Touch Handling
#pragma mark =======================================

-(void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    DebugLog(@"");
    touchLocation = [[touches anyObject] locationInView:self];
    [self.delagate physicalShapeViewOnTouchesBegan:self];
}

-(void) touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    DebugLog(@"");
    UITouch *aTouch = [touches anyObject];
    CGPoint location = [aTouch locationInView:self];
    
    CGRect frame = self.frame;
    frame.origin.x = self.frame.origin.x + location.x - touchLocation.x;
    frame.origin.y = self.frame.origin.y + location.y - touchLocation.y;
    DebugLog(@"Fruit Frame : %@", NSStringFromCGRect(frame));
    
    [self setFrame:frame];
    [self.delagate physicalShapeViewOnTouchesMoved:self];
}

-(void) touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    DebugLog(@"");
    [self.delagate physicalShapeViewOnTouchesEnded:touches withEvent:event forView:self];
}


@end
