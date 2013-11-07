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
@synthesize delegate;

CGPoint freeFormVeryFirstStartPoint,freeFormStartPoint,freeFormPrevPoint;
BOOL boolTouchMoved;
NSMutableArray *arr;
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
         arr = [[NSMutableArray alloc] initWithCapacity:1];
        
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
    
    for (NSMutableDictionary *dict in arr) {
        UIBezierPath *path = [dict valueForKey:@"path"];
        NSString *flag =[dict valueForKey:@"flag"];
        if ([flag isEqualToString:@"0"]) {
            [[UIColor whiteColor] setStroke];
        }else{
            if ([lineColor isEqual:[UIColor whiteColor]]) {
                [ [UIColor colorWithRed:240.0/255.0  green:221.0/255.0  blue:11.0/255.0 alpha:1.0] setStroke];
            }else{
                [lineColor setStroke];
            }
            // [lineColor setStroke];
        }
        [path strokeWithBlendMode:kCGBlendModeNormal alpha:1.0];
    }
    
    if (boolTouchMoved) {
        
        if ([lineColor isEqual:[UIColor whiteColor]]) {
            [[UIColor whiteColor] setStroke];
        }else{
            [lineColor setStroke];
        }
        
        [myPath strokeWithBlendMode:kCGBlendModeNormal alpha:1.0];
    }

}

#pragma mark-
#pragma mark======================
#pragma mark Touch Handlers
#pragma mark======================

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    DebugLog(@"");
    
    myPath = [[UIBezierPath alloc] init];
    myPath.lineCapStyle = kCGLineCapRound;
    myPath.miterLimit = 0;
    myPath.lineWidth = 8;
    
    boolTouchMoved = NO;
    
    UITouch *mytouch=[[touches allObjects] objectAtIndex:0];
    freeFormStartPoint = [mytouch locationInView:self];
    [myPath moveToPoint:[mytouch locationInView:self]];
    
    [self.delegate signatureViewOnTouchesBegan:self];
    
}
-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    DebugLog(@"");
    
    boolTouchMoved = YES;
    
    freeFormStartPoint = CGPointMake(-200, -200);
    UITouch *mytouch=[[touches allObjects] objectAtIndex:0];
    [myPath addLineToPoint:[mytouch locationInView:self]];
    [self setNeedsDisplay];
    
    [self.delegate signatureViewOnTouchesMoved:self];
    
}
-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    DebugLog(@"");

    if(!boolTouchMoved){
        [myPath addLineToPoint:CGPointMake(freeFormStartPoint.x + 1, freeFormStartPoint.y)];
        [self setNeedsDisplay];
    }
    
    NSMutableDictionary *dict = [[NSMutableDictionary alloc ] initWithCapacity:1];
    [dict setValue:myPath forKey:@"path"];
    if ([lineColor isEqual:[UIColor whiteColor]]) {
        [dict setValue:@"0" forKey:@"flag"];
    }else{
        [dict setValue:@"1" forKey:@"flag"];
    }
    [arr addObject:dict];
    
    boolTouchMoved = NO;
    
    [self.delegate signatureViewOnTouchesEnded:self];
    
}




@end
