//
//  UITouchVerificationView.m
//  TouchVerification
//
//  Created by Philip Hayes on 3/3/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "UITouchVerificationView.h"
#import "AppDelegate.h"
#import "CALayer+CALayer_Fade.h"
#include <sys/types.h>
#include <sys/sysctl.h>
#include "TigglyStampUtils.h"

@implementation UITouchVerificationView
@synthesize touchCache,shapeRequest, delegate, renderShapesToSelf, captureTouchesBegin, captureTouchesEnded, captureTouchesMoved, stampShapes, fadeShapes, mode, writeMode, activated, recognitionPoint,detectedPoints;
@synthesize  cachedGroup,isWithShape;
UITouchShapeRecognizer *rectangleShape, *triangleShape, *circleShape;
UILabel *requestLabel;
UILabel *correctCount;
UITouch * t;
float scale = 1;
double shapeFadeTime = 5;
int maxIterations = 5;
int iterations = 0;
int touchCount = 0;
int previousTouchCount = 0;

//=====================================================================================================================================//

#pragma mark-
#pragma mark======================
#pragma mark View Life Cycles
#pragma mark======================

- (NSString *) platform
{
    //DebugLog(@"");
    size_t size;
    sysctlbyname("hw.machine", NULL, &size, NULL, 0);
    char *machine = malloc(size);
    sysctlbyname("hw.machine", machine, &size, NULL, 0);
    NSString *platform = [NSString stringWithCString:machine encoding:NSUTF8StringEncoding];
    free(machine);
    return platform;
}

//=====================================================================================================================================//

- (id)init
{
    self = [super init];
    if (self) {
       // DebugLog(@"");
        // Initialization code
        
        circleShpDetected = 0;
        triangleShpDetected = 0;
        starShpDetected = 0;
        squareShpDetected = 0;
        mode = vVerificationMode3Point;
        activated = NO;
        writeMode = NO;
        [self setMultipleTouchEnabled:YES];
        touchCache = [[NSMutableArray alloc]init];
        touchPoints = [[NSMutableArray alloc]init];
        recordedShapes = [[NSMutableDictionary alloc]init];
        shapeDataCache = [[NSMutableSet alloc]init];
        touchGroups = [[NSMutableSet alloc]init];
        self.captureTouchesBegin = YES;
        self.captureTouchesMoved = YES;
        self.captureTouchesEnded = YES;
        self.fadeShapes = NO;
        for (int i = 0; i < 3; i++) {
            UITouchGroup *tg = [[UITouchGroup alloc]init];
            [touchGroups addObject:tg];
        }
        
        shapeDicionary = [[NSMutableDictionary alloc]init];
    }
    [self setAutoresizingMask:UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleBottomMargin];
    return self;
}
//=====================================================================================================================================//
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        DebugLog(@"");
         circleShpDetected = 0;
         triangleShpDetected = 0;
         starShpDetected = 0;
         squareShpDetected = 0;
        // Initialization code
        mode = vVerificationMode3Point;
        activated = NO;
        writeMode = NO;
        [self setMultipleTouchEnabled:YES];
        touchCache = [[NSMutableArray alloc]init];
        touchPoints = [[NSMutableArray alloc]init];
        recordedShapes = [[NSMutableDictionary alloc]init];
        shapeDataCache = [[NSMutableSet alloc]init];
        touchGroups = [[NSMutableSet alloc]init];
        self.captureTouchesBegin = YES;
        self.captureTouchesMoved = YES;
        self.captureTouchesEnded = YES;
        self.fadeShapes = NO;
        for (int i = 0; i < 3; i++) {
            UITouchGroup *tg = [[UITouchGroup alloc]init];
            [touchGroups addObject:tg];
        }
        isStartDetectShape = 0.5;
        detectShapeTimer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(startListeningShape) userInfo:nil repeats:YES];
        shapeDicionary = [[NSMutableDictionary alloc]init];
    }
    [self setAutoresizingMask:UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleBottomMargin];
    return self;
}

-(void) startListeningShape {
    //0.5f means ready to detect shape
    isStartDetectShape = isStartDetectShape+0.1;
    if (isStartDetectShape>=999) {
        isStartDetectShape = 0.5f;
    }
}

//=====================================================================================================================================//

#pragma mark-
#pragma mark======================
#pragma mark Game Handlers
#pragma mark======================

-(void)configure{
    //DebugLog(@"");
    // Initialization code
    mode = vVerificationMode3Point;
    activated = NO;
    writeMode = NO;
    [self setMultipleTouchEnabled:YES];
    touchCache = [[NSMutableArray alloc]init];
    touchPoints = [[NSMutableArray alloc]init];
    recordedShapes = [[NSMutableDictionary alloc]init];
    shapeDataCache = [[NSMutableSet alloc]init];
    touchGroups = [[NSMutableSet alloc]init];
    self.captureTouchesBegin = YES;
    self.captureTouchesMoved = YES;
    self.captureTouchesEnded = YES;
    self.fadeShapes = NO;
    for (int i = 0; i < 3; i++) {
        UITouchGroup *tg = [[UITouchGroup alloc]init];
        [touchGroups addObject:tg];
    }
    if([[self platform] isEqualToString:@"iPad2,5"]||[[self platform] isEqualToString:@"iPad2,6"]||[[self platform] isEqualToString:@"iPad2,7"]||[[self platform] isEqualToString:@"iPad4,4"]||[[self platform] isEqualToString:@"iPad4,5"]){
        scale = 0.8;
    }
    shapeDicionary = [[NSMutableDictionary alloc]init];
    
    allTouchPoints = [[NSMutableArray alloc]initWithCapacity:1];
    distanceArr = [[NSMutableArray alloc]initWithCapacity:1];
    
}


-(void)requestShape:(NSString *)request{
    DebugLog(@"");
    self.shapeRequest = request;
}

-(void)removeAllShapes{
    DebugLog(@"");
    NSMutableArray * array = [[NSMutableArray alloc]init];
    for (CALayer *shape in self.layer.sublayers) {
        [array addObject:shape];
    }
    for (int i = 0; i < array.count; i++) {
        [CATransaction setCompletionBlock:^(void){
            //[[array objectAtIndex:i] removeFromSuperlayer];
        }];
        double delayInSeconds = 0.5;
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
            
            [[array objectAtIndex:i] fadeOutAfterTime:0.5];
        });
        
    }
    //[array removeAllObjects];
}
//=====================================================================================================================================//

-(void) detectShape {
    DebugLog(@"");
    NSArray *sortedT = [distanceArr sortedArrayUsingSelector:@selector(compare:)];
    //Generate the key from the distances calculated
    DebugLog(@"distanceArr count :%d",distanceArr.count);
    NSMutableString *keyAllTouchPts = [[NSMutableString alloc]init];

    for (NSNumber *j in sortedT) {
        [keyAllTouchPts appendFormat:@",%@", j];
    }
    for (int k=0;k<3-sortedT.count; k++) {
        [keyAllTouchPts appendFormat:@",-"];

    }
    for (NSNumber *i in sortedT) {
        if (i==0) {
            DebugLog(@"Error we get 0 distance detectShape");
        }
        NSMutableString *key = [[NSMutableString alloc]init];
        [key appendFormat:@"%@", i];
        int keyint = key.intValue;
        DebugLog(@"keyint :%d",keyint);

        if (keyint>= 152 && keyint<=173) {
            // triangle shape
            triangleShpDetected++;
//            [[TigglyStampUtils sharedInstance]appendKeyDatatoString:[NSString stringWithFormat:@"-%@,%@,triangle\n",keyAllTouchPts,i] ];
            
        }else if (keyint>= 182 && keyint<=205) {
            // circle shape
            circleShpDetected++;
//            [[TigglyStampUtils sharedInstance]appendKeyDatatoString:[NSString stringWithFormat:@"-%@,%@,circle\n",keyAllTouchPts,i] ];

        }else if (keyint>= 217 && keyint<=244) {
            // circle shape
            starShpDetected++;
//            [[TigglyStampUtils sharedInstance]appendKeyDatatoString:[NSString stringWithFormat:@"-%@,%@,star\n",keyAllTouchPts,i] ];

        }else if (keyint>= 245 && keyint<=278) {
            // star shape
            circleShpDetected++;
//            [[TigglyStampUtils sharedInstance]appendKeyDatatoString:[NSString stringWithFormat:@"-%@,%@,circle\n",keyAllTouchPts,i] ];

        }else if (keyint>= 330 && keyint<=342) {
            // square shape
            squareShpDetected++;
//            [[TigglyStampUtils sharedInstance]appendKeyDatatoString:[NSString stringWithFormat:@"-%@,%@,square\n",keyAllTouchPts,i] ];

        }else {
//            [[TigglyStampUtils sharedInstance]appendKeyDatatoString:[NSString stringWithFormat:@"-%@,%@,noshape\n",keyAllTouchPts,i] ];
        }


        
        DebugLog(@"tri :%d cir :%d star :%d squ :%d ",triangleShpDetected,circleShpDetected,starShpDetected,squareShpDetected);

    }
    DebugLog(@"Final tri :%d cir :%d star :%d squ :%d ",triangleShpDetected,circleShpDetected,starShpDetected,squareShpDetected);


    UITouchShapeRecognizer *UITShape = NULL;
    int totlsreqshape = 1;
    if (triangleShpDetected>=totlsreqshape && triangleShpDetected>=circleShpDetected && triangleShpDetected>=starShpDetected && triangleShpDetected>=squareShpDetected) {
        DebugLog(@"Triangle Detected....");
        for (UITouchShapeRecognizer *UIT in shapeDataCache) {
            if ([UIT.label isEqualToString:@"triangle"]) {
                [[TigglyStampUtils sharedInstance]appendKeyDatatoString:[NSString stringWithFormat:@"-%@,triangle\n",keyAllTouchPts] ];
                UITShape = UIT;
            }
        }
    }else if (circleShpDetected>=totlsreqshape && circleShpDetected>=triangleShpDetected && circleShpDetected>=starShpDetected && circleShpDetected>=squareShpDetected) {
        DebugLog(@"circle Detected....");
        for (UITouchShapeRecognizer *UIT in shapeDataCache) {
            if ([UIT.label isEqualToString:@"circle"]) {
                UITShape = UIT;
                [[TigglyStampUtils sharedInstance]appendKeyDatatoString:[NSString stringWithFormat:@"-%@,circle\n",keyAllTouchPts] ];
            }
        }
    }else if (starShpDetected>=totlsreqshape && starShpDetected>=triangleShpDetected && starShpDetected>=circleShpDetected && starShpDetected>=squareShpDetected) {
        DebugLog(@"Star Detected....");
        for (UITouchShapeRecognizer *UIT in shapeDataCache) {
            if ([UIT.label isEqualToString:@"star"]) {
                UITShape = UIT;
                [[TigglyStampUtils sharedInstance]appendKeyDatatoString:[NSString stringWithFormat:@"-%@,star\n",keyAllTouchPts] ];
            }
        }
    }else if (squareShpDetected>=1 && squareShpDetected>=triangleShpDetected && squareShpDetected>=circleShpDetected && squareShpDetected>=starShpDetected) {
        DebugLog(@"Square Detected....");
        for (UITouchShapeRecognizer *UIT in shapeDataCache) {
            if ([UIT.label isEqualToString:@"square"]) {
                UITShape = UIT;
                [[TigglyStampUtils sharedInstance]appendKeyDatatoString:[NSString stringWithFormat:@"-%@,square\n",keyAllTouchPts] ];
            }
        }
    }else {
        [[TigglyStampUtils sharedInstance]appendKeyDatatoString:[NSString stringWithFormat:@"-%@,noshape\n",keyAllTouchPts] ];
    }
    
    if (UITShape!=NULL) {
        circleShpDetected = 0;
        triangleShpDetected = 0;
        starShpDetected = 0;
        squareShpDetected = 0;
        detectedPoints = [NSMutableArray arrayWithArray:allTouchPoints];
        @synchronized(distanceArr) {
            [distanceArr removeAllObjects];
        }
        @synchronized(allTouchPoints) {
            [allTouchPoints removeAllObjects];
        }
        if (delegate && [delegate respondsToSelector:@selector(shapeDetected: inView:)]) {
            DebugLog(@"Came in delegate");
            if (isStartDetectShape>=0.3f) {
                isStartDetectShape = 0;
                [delegate shapeDetected:UITShape inView:self];
            }else  {
                DebugLog(@"Device is not ready to show shape");
            }
        }else{
            DebugLog(@"Didnt go in delegate");
        }
    }

       

    @synchronized(allTouchPoints) {
        [allTouchPoints removeAllObjects];
    }
    @synchronized(distanceArr) {
                [distanceArr removeAllObjects];
            }
    
    
    
    
}
//=====================================================================================================================================//
-(void)showTouchPoints {
    
    for(int i = 0;i<allTouchPoints.count;i++){
        UITouch *touch = [allTouchPoints objectAtIndex:i];
        CGPoint touchLocation = [touch locationInView:self];
        if([[TigglyStampUtils sharedInstance] getDebugModeForWriteKeyInCsvOn]) {
            UIView *testView= [[UIView alloc] initWithFrame:CGRectMake(touchLocation.x-32, touchLocation.y-32, 65, 65)];
            testView.backgroundColor = [UIColor blueColor];
            testView.layer.cornerRadius = 20.0f;
            testView.layer.masksToBounds=YES;
            [self addSubview:testView];
            
            double delayInSeconds = 0.2;
            dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
            dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
                [testView removeFromSuperview];
                
            });
        }
        
    }
    
}

-(void) performCalculations{
    DebugLog(@"");
    
    DebugLog(@"PerformCalculations allTouchCount : %d",allTouchPoints.count);
    
    for(int i = 0;i<allTouchPoints.count;i++){
        UITouch *touch = [allTouchPoints objectAtIndex:i];
        CGPoint touchLocation = [touch locationInView:self];
        int touchLocationX,touchLocationY;
        touchLocationX = touchLocation.x;
        touchLocationY = touchLocation.y;
        
        for(int j = i+1;j<allTouchPoints.count;j++){
            UITouch *touchcomplare = [allTouchPoints objectAtIndex:j];
            CGPoint touchLocationcomplare = [touchcomplare locationInView:self];
            int compareLocationX,compareLocationY;
            compareLocationX = touchLocationcomplare.x;
            compareLocationY = touchLocationcomplare.y;
            
            int distance = (sqrt(pow((compareLocationY - touchLocationY),2) + pow((compareLocationX - touchLocationX), 2))*scale);
            DebugLog(@"i j :%d :%d :%d",i,j,distance);
            @synchronized(distanceArr) {
                [distanceArr addObject:[NSNumber numberWithInt:distance]];
            }
            
        }

    
    }
    [self showTouchPoints];
    DebugLog(@" allTouchCount a: %d distanceArr :%d",allTouchPoints.count,distanceArr.count);
    if (allTouchPoints.count==1) {
        UITouch *touch = [allTouchPoints objectAtIndex:0];
        CGPoint touchLocation = [touch locationInView:self];
        int touchLocationX,touchLocationY;
        touchLocationX = touchLocation.x;
        touchLocationY = touchLocation.y;
        [[TigglyStampUtils sharedInstance]appendKeyDatatoString:[NSString stringWithFormat:@"(%d:%d),-,-,-,-\n",touchLocationX,touchLocationY] ];
    }
    if (distanceArr.count >=1) {
        [self detectShape];
    }

    
    @synchronized(allTouchPoints) {
        [allTouchPoints removeAllObjects];
    }
    @synchronized(distanceArr) {
                [distanceArr removeAllObjects];
    }
    
}


//=====================================================================================================================================//
#pragma mark-
#pragma mark======================
#pragma mark Shapes Plist
#pragma mark======================
-(void)loadShapesWithSet:(NSMutableSet*)shapesSet{
    DebugLog(@"");
    if (!writeMode) {
        
        shapeDataCache = shapesSet;
    }
    
}
//=====================================================================================================================================//
-(void)loadShape:(UITouchShapeRecognizer*)shape{
    DebugLog(@"");
    if (!writeMode) {
        
        [shapeDataCache addObject:shape];
    }
}
//=====================================================================================================================================//
-(void)loadPlistDataForWriteMode:(NSMutableDictionary *)dic {
    if (writeMode) {
        recordedShapes = [[NSMutableDictionary alloc]initWithDictionary:dic copyItems:YES];
        DebugLog(@"shapeDicionary  values:%@ \n\n\n count  :%d \n\n\n\n\n ",recordedShapes,[recordedShapes count]);
        
    }
}
//=====================================================================================================================================//

#pragma mark-
#pragma mark======================
#pragma mark Touches Handlers
#pragma mark======================


-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{

    if(delegate && [delegate respondsToSelector:@selector(touchVerificationViewTouchesBegan:withEvent:)]) {
        [self.delegate touchVerificationViewTouchesBegan:touches withEvent:event];
    }
    
    for (UITouch *touch  in touches) {
        if(allTouchPoints.count < 3){
            if (![allTouchPoints containsObject:touch]) {
                [allTouchPoints addObject:touch];

            }
        }
    }


    if(allTouchPoints.count >=  2) {
        [self performCalculations];
    }else {
        [self showTouchPoints];
    }

    DebugLog(@"touchesBegan : AllTouchpoints : %d",allTouchPoints.count);
}

//======================================================================================================================//

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
    
    if(delegate && [delegate respondsToSelector:@selector(touchVerificationViewTouchesBegan:withEvent:)]) {
        //[self.delegate touchVerificationViewTouchesMoved:touches withEvent:event];
    }
    
//    for (UITouch *touch  in touches) {
//        if(allTouchPoints.count < 3){
//                if (![allTouchPoints containsObject:touch]) {
//                    [allTouchPoints addObject:touch];
//                }
//            }
//    }
    
//    
//    if(allTouchPoints.count >=  2) {
//        [self performCalculations];
//    }

    DebugLog(@"touchesMoved : AllTouchpoints : %d",allTouchPoints.count);
}



-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    isContaintSelfPoint = NO;
    
    if(delegate && [delegate respondsToSelector:@selector(touchVerificationViewTouchesEnded:withEvent:)]) {
        //[self.delegate touchVerificationViewTouchesEnded:touches withEvent:event];
    }

    if (allTouchPoints.count==1) {
        UITouch *touch = [allTouchPoints objectAtIndex:0];
        CGPoint touchLocation = [touch locationInView:self];
        int touchLocationX,touchLocationY;
        touchLocationX = touchLocation.x;
        touchLocationY = touchLocation.y;
        [[TigglyStampUtils sharedInstance]appendKeyDatatoString:[NSString stringWithFormat:@"(%d:%d),-,-,-,-\n",touchLocationX,touchLocationY] ];
    }
    
    DebugLog(@"touchesEnded : AllTouchpoints : %d " ,allTouchPoints.count);
//    [self performCalculations];
    @synchronized(allTouchPoints) {
        [allTouchPoints removeAllObjects];
    }
    @synchronized(distanceArr) {
        [distanceArr removeAllObjects];
    }
    
    circleShpDetected = 0;
    triangleShpDetected = 0;
    starShpDetected = 0;
    squareShpDetected = 0;
    
#ifdef IS_RUN_WITHOUT_SHAPE_FOR_TESTING
    for (UITouchShapeRecognizer *UIT in shapeDataCache) {
        if (delegate && [delegate respondsToSelector:@selector(shapeDetected: inView:)]) {
            [delegate shapeDetected:UIT inView:self];
        }
    }
#endif

}



@end
