//
//  TDSignatureView.m
//  TigglyDraw
//
//  Created by datta on 03/10/13.
//
//

#import "TDSignatureView.h"

@implementation TDSignatureView

@synthesize lineColor, myPath;

CGPoint freeFormVeryFirstStartPoint,freeFormStartPoint,freeFormPrevPoint;
BOOL boolTouchMoved;

#pragma mark-
#pragma mark======================
#pragma mark Init
#pragma mark======================

- (id)initWithFrame:(CGRect)frame
{
    DebugLog(@"");
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        self.backgroundColor=[UIColor whiteColor];
        myPath = [[UIBezierPath alloc] init];
        myPath.lineCapStyle = kCGLineCapRound;
        myPath.miterLimit = 0;
        myPath.lineWidth = 8;
        self.lineColor = [UIColor blackColor];
        
        
    }
    return self;
}

#pragma mark-
#pragma mark======================
#pragma mark Draw Method
#pragma mark======================

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    DebugLog(@"");
    [lineColor setStroke];
    [myPath strokeWithBlendMode:kCGBlendModeNormal alpha:1.0];
}

#pragma mark-
#pragma mark======================
#pragma mark Touch Handlers
#pragma mark======================

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    DebugLog(@"");
    
    boolTouchMoved = NO;
    
    UITouch *mytouch=[[touches allObjects] objectAtIndex:0];
    freeFormStartPoint = [mytouch locationInView:self];
    [myPath moveToPoint:[mytouch locationInView:self]];
    
    
}
-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    DebugLog(@"");
    
    boolTouchMoved = YES;
    
    freeFormStartPoint = CGPointMake(-200, -200);
    UITouch *mytouch=[[touches allObjects] objectAtIndex:0];
    [myPath addLineToPoint:[mytouch locationInView:self]];
    [self setNeedsDisplay];
    
}
-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    DebugLog(@"");

    if(!boolTouchMoved){
        [myPath addLineToPoint:CGPointMake(freeFormStartPoint.x + 1, freeFormStartPoint.y)];
        [self setNeedsDisplay];
    }
    
}


@end
