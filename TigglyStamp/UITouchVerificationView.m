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
        
        shapeDicionary = [[NSMutableDictionary alloc]init];
    }
    [self setAutoresizingMask:UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleBottomMargin];
    return self;
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
    if([[self platform] isEqualToString:@"iPad2,5"]){
        scale = 0.8;
    }
    shapeDicionary = [[NSMutableDictionary alloc]init];
    
    allTouchPoints = [[NSMutableArray alloc]initWithCapacity:1];
    distanceArr = [[NSMutableArray alloc]initWithCapacity:1];
    
}

//=====================================================================================================================================//
/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect
 {
 // Drawing code
 }
 */
//-(void)visualizeShapeFromData:(NSArray*)pointComparison andRecognizer:(UITouchShapeRecognizer*)shapeRec withTouchGroup:(UITouchGroup*)group{
//    DebugLog(@"");
//    
//    //Unpack the data
//    UITouch *touch = [pointComparison objectAtIndex:0];
//    
//    UITouch *compare = [pointComparison objectAtIndex:1];
//    UITouch *reference = [pointComparison objectAtIndex:4];
//    
//    //Rohit compare != touch != reference
//    
//    if (reference == compare || reference == touch) {
//        int i = 0;
//        while (reference == compare || reference == touch) {
//            i++;
//            if (i < [touchCache count]) {
//                reference = [touchCache objectAtIndex:i];
//            } else {
//                break;
//            }
//            
//        }
//        DebugLog(@"it will not come to this loop because reference is always garbage");
//        DebugLog(@"ERROR fixed");
//    }
//    CGPoint touchLocation = [touch locationInView:self];
//    
//    CGPoint compareLocation = [compare locationInView:self];
//    
//    CGPoint referenceLocation = [reference locationInView:self];
//    
//    
//    
//    CGPoint midPoint = CGPointMake((touchLocation.x + compareLocation.x + referenceLocation.x) / 3, (touchLocation.y + compareLocation.y + referenceLocation.y) / 3);
//    self.recognitionPoint = midPoint;
//    double angle = atan2(midPoint.y - referenceLocation.y, midPoint.x - referenceLocation.x) * 180 / M_PI;
//    float correctionFactor;
//    
//    correctionFactor = [[shapeRec.shapeData objectForKey:@"angleOffset"] floatValue];
//    
//    //DebugLog(@"CORRECTION %f", correctionFactor);
//    
//    angle = angle - correctionFactor;
//    DebugLog(@"ANGLE %f", angle);
//    
//    
//    if(!shapeRec.displayShape){
//        return;
//    }
//    //int distance = [[pointComparison objectAtIndex:4] intValue];
//    if (group.groupShape != shapeRec.displayShape) {
//        group.groupShape = shapeRec.displayShape;
//        
//    }
//    DebugLog(@"stampShapes :%d",stampShapes);
//    if (self.stampShapes) {
//        
//        CAShapeLayer *shape = [CAShapeLayer layer];
//        shape.backgroundColor = group.groupShape.backgroundColor;
//        shape.borderColor = group.groupShape.borderColor;
//        shape.borderWidth = group.groupShape.borderWidth;
//        shape.frame = group.groupShape.frame;
//        shape.path = group.groupShape.path;
//        CGColorRef ref = CGColorCreateCopy( group.groupShape.strokeColor);
//        shape.strokeColor = [UIColor blackColor].CGColor;
//        shape.fillColor = group.groupShape.fillColor;
//        [shape setPosition:CGPointMake(midPoint.x, midPoint.y)];
//        [shape setAnchorPoint:CGPointMake(0.5f, 0.5f)];
//        [shape setValue:[NSNumber numberWithFloat:angle* M_PI / 180] forKeyPath:@"transform.rotation.z"];
//        [self.layer addSublayer:shape];
//        DebugLog(@"Shapes : %i", self.layer.sublayers.count);
//        if (self.fadeShapes) {
//            [shape fadeOutAfterTime:shapeFadeTime];
//        }
//        
//        [shape setShouldRasterize:YES];
//        
//    } else {
//        //        renderShapesToSelf is not set any where so that it will always NO
//        if (![self.layer.sublayers containsObject:group.groupShape] && renderShapesToSelf) {
//            [self.layer addSublayer:group.groupShape];
//            //[CATransaction setDisableActions:YES];
//            [CATransaction setAnimationDuration:0.2];
//            
//            [group.groupShape setPosition:CGPointMake(midPoint.x, midPoint.y)];
//            [group.groupShape setAnchorPoint:CGPointMake(0.5f, 0.5f)];
//            [group.groupShape setValue:[NSNumber numberWithFloat:angle* M_PI / 180] forKeyPath:@"transform.rotation.z"];
//            
//            if (delegate && [delegate respondsToSelector:@selector(shapeRendered:)]) {
//                [delegate shapeRendered:group.groupShape];
//            }
//        }
//    }
//    
//}
//=====================================================================================================================================//
/*
 writeMode is always "NO"
 */
-(BOOL)calculateShape:(UITouchGroup*)group{
    DebugLog(@"");
    BOOL success = NO;
    
    NSMutableArray * distanceArray = [[NSMutableArray alloc]init];
    NSMutableArray * angleArray = [[NSMutableArray alloc]init]; // not used
    NSMutableArray * pointComparisons = [[NSMutableArray alloc]init];
    DebugLog(@"[touchCache count] :%d ",[touchCache count]);
    for (int i = 0; i < [touchCache count]; i++) {
        
        UITouch *touch = [touchCache objectAtIndex:i];
        CGPoint touchLocation = [touch locationInView:self];
        //This for loop executes in a special manor such that it will not process the same point twice if there are only three points.
        //Manage and pass in three points at a time to produce separate instances of shape recognition.
        
        //Keep j one ahead of i
        int j = i + 1;
        if (i >= [touchCache count] - 1) {
            j = 0;
        }
        //Keep k one ahead of j
        int k = j + 1;
        if (k >= [touchCache count] - 1) {
            k = 0;
        }
        
        //The actual for loop
        for (; j < [touchCache count]; j++ ) {
            if (j == 0) {
                break;
            }
            UITouch *compare = [touchCache objectAtIndex:j];
            if (compare != touch) {
                CGPoint compareLocation = [compare locationInView:self];
                UITouch* reference;/* = [touchCache objectAtIndex:k];*/
                CGPoint referenceLocation = [reference locationInView:self];
                
                // it will not go in while loop because "reference" is garbage pointer
                //Keep the reference point unique from the other two touches
                while (reference == compare || reference == touch) {
                    //if reference is equal to any of the other touches then change it.
                    k++;
                    if (k >= [touchCache count] - 1) {
                        k = 0;
                    }
                    reference = [touchCache objectAtIndex:k];
                    DebugLog(@"ERROR %i", k);
                }
                //Get the angle and distance of the two points
                ///scale = 1;
                DebugLog(@"touchLocation :%d :%@ compareLocation :%d :%@ referenceLocation :%d :%@",i,NSStringFromCGPoint(touchLocation),j,NSStringFromCGPoint(compareLocation),k,NSStringFromCGPoint(referenceLocation));
                double angle = atan2(compareLocation.y - touchLocation.y, compareLocation.x - touchLocation.x) * 180 / M_PI;//Rohit Never used
                int distance = (sqrt(pow((compareLocation.y - touchLocation.y),2) + pow((compareLocation.x - touchLocation.x), 2))*scale);
                int distance2 = (sqrt(pow((referenceLocation.y - touchLocation.y),2) + pow((referenceLocation.x - touchLocation.x), 2))*scale); //Rohit Never used
                int distance3 = (sqrt(pow((compareLocation.y - referenceLocation.y),2) + pow((compareLocation.x - referenceLocation.x), 2))*scale);//Rohit Never used
                DebugLog(@"Touch width %f height %f device %@", [[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.height, [self platform]);
                DebugLog(@"angle :%f distance :%d distance2 :%d distance3 :%d",angle,distance,distance2,distance3);
                //When the loop finishes there will be three unique distances and angles of line segments
                [distanceArray addObject:[NSNumber numberWithInt:distance]];
                
                [angleArray addObject:[NSNumber numberWithFloat:angle]];
                
                //The points that make up the segements will be stored in the order that they are processed
                //This allows me to determine if I should use the default angle or the inverse angle since the touches never come through in the same order
                [pointComparisons addObject:[NSArray arrayWithObjects:touch, compare, [NSNumber numberWithFloat:angle], [NSNumber numberWithInt:distance], [touchCache objectAtIndex:k], [NSNumber numberWithInt:distance2], [NSNumber numberWithInt:distance3],nil]];
                //pointComparisons used value at index 0,1,3,4
            }
        }
        if (i == 2) {
            break;
        }
    }
    //Shape recognition
    //When in record mode it will remember all the possible deviations for a particular group of touches.
    //Since the precise point of a touch is approximated from a larger area the distance is never garuanteed to be the same
    //But similar.
    if ([touchCache count] >= 2) {
        // Rohit : touchCache count = max 3  only because we are inserting only 3 values in groupcache
        if (iterations == 0) {
            previousTouchCount = [touchCache count];
        }
        if([touchCache count] > previousTouchCount){
            previousTouchCount = [touchCache count];
        }
        touchCount = [touchCache count];
        
        NSArray *sortedT = [distanceArray sortedArrayUsingSelector:@selector(compare:)];
        DebugLog(@"sortedT :%@",[sortedT description]);
        NSMutableString *key = [[NSMutableString alloc]init];
        for (NSNumber *i in sortedT) {
            
            [key appendFormat:@"%@ ", i];
            
        }
        
        
        DebugLog(@"Final key is :%@",key);
        NSString *shapeCombination = [NSString stringWithFormat:@"shape%i", [recordedShapes count]];
        DebugLog(@"shapeCombination :%@",shapeCombination);
        
        if (writeMode) {
            if ([recordedShapes objectForKey:key]) {
                DebugLog(@"Found %@ shape: %@ Key: %@", @"Previous",[recordedShapes valueForKey:key], key);
                
                success = YES;
            } else {
                
                DebugLog(@"creating New shape: %@", shapeCombination);
                [recordedShapes setValue:shapeCombination forKey:key];
                
            }
            
        } else {
            //            DebugLog(@"shapeDataCache :%@",[shapeDataCache description]);
            
            
            for (UITouchShapeRecognizer *UIT in shapeDataCache) {
                recordedShapes = UIT.shapeData;
                DebugLog(@"UIT.label :%@",UIT.label);
                //                DebugLog(@"recordedShapes :%@",[recordedShapes description]);
                if ([recordedShapes objectForKey:key]) {
                    DebugLog(@"Found %@ shape: %@ Key: %@", UIT.dataName,[recordedShapes valueForKey:key], key);
                    if (iterations < maxIterations) {///If we haven't collected enough data don't do it yet
                        //DebugLog(@"                prevented false positive");
                        DebugLog(@"iterations :%d so return false",iterations);
                        iterations++;
                        return false;
                    } else { ///Else its safe to see if the value changed
                        iterations = 0;
                        DebugLog(@"TouchCount: %i \nPReviousTouch count : %i", touchCount, previousTouchCount);
                        if (touchCount == previousTouchCount) { ///IF the number of touches hasn't changed then its deliberate
                            ///Ok you can go
                            touchCount = 0;
                            previousTouchCount = 0;
                            DebugLog(@"You may go.science prev and touchCount count same :%d ",touchCount);
                        } else  if(touchCount > previousTouchCount){
                            touchCount = 0;
                            previousTouchCount = 0;
                            DebugLog(@"                You may go");
                        } else {
                            touchCount = 0;
                            previousTouchCount = 0;
                            DebugLog(@"                Failed");
                            return false;
                        }
                    }
                    DebugLog(@"pointComparisons %@",[pointComparisons description]);
                    for (NSMutableArray *array in pointComparisons) {
                        //find the point comparison array that had the shortest distance. This is what will be used to determine
                        //the angle since the angle of the two points with the smallest distance will be there.
                        //The dictionary will have two values one called default angle and another called inverse angle.
                        //Subtract that from the currently displayed angle and you will have the proper shapes orientation.
                        int d1 = [[array objectAtIndex:3] intValue];
                        int d2 = [[sortedT objectAtIndex:0] intValue];
                        
                        if (d1 == d2) {
                            //[self confirmShape:UIT.dataName];
                            if (delegate && [delegate respondsToSelector:@selector(shapeDetected: inView:)]) {
//                                [delegate shapeDetected:UIT inView:self];
                                [delegate visualizeShapeFromData:array andRecognizer:UIT withTouchGroup:group];
                                activated = YES;
                            }
                            success = YES;
//                            [self visualizeShapeFromData:array andRecognizer:UIT withTouchGroup:group];
                            
                        }
                    }
                    
                    
                    
                } else {
                    if (writeMode) {
                        DebugLog(@"creating New shape: %@", shapeCombination);
                        [recordedShapes setValue:shapeCombination forKey:key];
                    } else {
                        DebugLog(@"we are not able to find key:%@ for shape :%@",key,UIT.label);
                        
                        //DebugLog(@"Shape Not recognized");
                    }
                    
                }
            }
            
            
            
        }
    }
    DebugLog(@"success :%d",success);
    return success;
}
//=====================================================================================================================================//
-(void)requestShape:(NSString *)request{
    DebugLog(@"");
    self.shapeRequest = request;
}
//=====================================================================================================================================//
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
    BOOL isKeyPresent = NO;
    NSArray *sortedT = [distanceArr sortedArrayUsingSelector:@selector(compare:)];
    NSMutableString *csvString = [[NSMutableString alloc]init];
    BOOL isDataWrite = NO;
    //Generate the key from the distances calculated
    NSMutableString *key = [[NSMutableString alloc]init];
    for (NSNumber *i in sortedT) {
        [key appendFormat:@"%@ ", i];
        [csvString appendFormat:@"%@,", i];
    }
    if (sortedT.count!=3) {
        for (int i=0; i<(3-sortedT.count); i++) {
            [csvString appendFormat:@"-,"];
        }
    }
    NSLog(@"Final key is :%@",key);
    
    //Check the key in all plist
    for (UITouchShapeRecognizer *UIT in shapeDataCache) {
        recordedShapes = UIT.shapeData;
        //if the key is present in any of the plist ==> success
        if ([recordedShapes objectForKey:key]) {
            isKeyPresent = YES;
            isDataWrite = YES;
            [[TigglyStampUtils sharedInstance]appendKeyDatatoString:[NSString stringWithFormat:@"%@%@\n",csvString,UIT.label]];
            NSLog(@"Shape Detected With Original Key:  %@",UIT.label);
            DebugLog(@"Found %@ Shape: %@ Key: %@", UIT.label,[recordedShapes valueForKey:key], key);
            detectedPoints = [NSArray arrayWithArray:allTouchPoints];
            [distanceArr removeAllObjects];
            [allTouchPoints removeAllObjects];
            if (delegate && [delegate respondsToSelector:@selector(shapeDetected: inView:)]) {
                NSLog(@"Came in delegate");
                [delegate shapeDetected:UIT inView:self];
            }else{
                NSLog(@"Didnt go in delegate");
            }
            isKeyPresent = YES;
            
            return;
        }else{
            isKeyPresent = NO;
        }
    }
    
    //if the key is not present in any of the plist the adjust the key values (+3 and -3)
    if(!isKeyPresent) {
        
        DebugLog(@"Key generated but not present. Hence modifyng");
        if (sortedT.count == 3) {
            
            int n1 = [[sortedT objectAtIndex:0] intValue];
            int n2 = [[sortedT objectAtIndex:1] intValue];
            int n3 = [[sortedT objectAtIndex:2] intValue];
            
            //As we are modifying the keys by considering 3 values before and 3 values after the original key values
            n1 = n1 - 3;
            n2 = n2 - 3;
            n3 = n3 - 3;
            int count = 0;
            for(int i = 0; i < 6 ; i++) {
                int x = n1 + i;
                for(int j=0;j < 6; j++) {
                    int y = n2 + j;
                    for(int k=0; k <6 ; k++) {
                        int z = n3 + k;
                        NSMutableString *tempKey = [[NSMutableString alloc]init];
                        [tempKey appendFormat:@"%d %d %d ",x,y,z]; // there is a space after the last value
                        
                        //DebugLog(@"Temp key (%d) :%@",count,tempKey);
                        count++;
                        for (UITouchShapeRecognizer *UIT in shapeDataCache) {
                            recordedShapes = UIT.shapeData;
                            if ([recordedShapes objectForKey:tempKey]) {
                                NSLog(@"Shape Detected with Modified Key :  %@",UIT.label);

                                isDataWrite = YES;
                                [[TigglyStampUtils sharedInstance]appendKeyDatatoString:[NSString stringWithFormat:@"%@%@\n",csvString,UIT.label]];

                                DebugLog(@"Found %@ Shape: %@ Key: %@", UIT.label,[recordedShapes valueForKey:tempKey], tempKey);
                                detectedPoints = [NSArray arrayWithArray:allTouchPoints];
                                [distanceArr removeAllObjects];
                                [allTouchPoints removeAllObjects];
                                if (delegate && [delegate respondsToSelector:@selector(shapeDetected: inView:)]) {
                                    NSLog(@"Came in delegate");
                                    [delegate shapeDetected:UIT inView:self];                                     
                                }else{
                                    NSLog(@"Didnt go in delegate");
                                }

                                
                                return;
                            }
                        }
                    }
                }
            }
        }
    }
    if (isDataWrite==NO) {
        [csvString appendFormat:@"NoShape"];
        [[TigglyStampUtils sharedInstance]appendKeyDatatoString:[NSString stringWithFormat:@"%@\n",csvString]];
    }
    [allTouchPoints removeAllObjects];
    [distanceArr removeAllObjects];
    
    
    
    
}
-(void) detectShape:(UITouchGroup *)group {
    DebugLog(@"");
    BOOL isKeyPresent = NO;
    NSArray *sortedT = [distanceArr sortedArrayUsingSelector:@selector(compare:)];
    
    //Generate the key from the distances calculated
    NSMutableString *key = [[NSMutableString alloc]init];
    for (NSNumber *i in sortedT) {
        [key appendFormat:@"%@ ", i];
    }
    
    DebugLog(@"Final key is :%@",key);
    
    //Check the key in all plist
    for (UITouchShapeRecognizer *UIT in shapeDataCache) {
        recordedShapes = UIT.shapeData;
        //if the key is present in any of the plist ==> success
        if ([recordedShapes objectForKey:key]) {
            isKeyPresent = YES;
            DebugLog(@"Shape Detected With Original Key:  %@",UIT.label);
            DebugLog(@"Found %@ Shape: %@ Key: %@", UIT.label,[recordedShapes valueForKey:key], key);
            detectedPoints = [NSArray arrayWithArray:allTouchPoints];
            [distanceArr removeAllObjects];
            [allTouchPoints removeAllObjects];
            if (delegate && [delegate respondsToSelector:@selector(shapeDetected: inView:)]) {
                //                [delegate shapeDetected:UIT inView:self];
                [delegate visualizeShapeFromData:detectedPoints andRecognizer:UIT withTouchGroup:group];
            }
            isKeyPresent = YES;
            return;
        }else{
            isKeyPresent = NO;
        }
    }
    
    //if the key is not present in any of the plist the adjust the key values (+3 and -3)
    if(!isKeyPresent) {
        
        DebugLog(@"Key generated but not present. Hence modifyng");
        if (sortedT.count == 3) {
            
            int n1 = [[sortedT objectAtIndex:0] intValue];
            int n2 = [[sortedT objectAtIndex:1] intValue];
            int n3 = [[sortedT objectAtIndex:2] intValue];
            
            //As we are modifying the keys by considering 3 values before and 3 values after the original key values
            n1 = n1 - 3;
            n2 = n2 - 3;
            n3 = n3 - 3;
            int count = 0;
            for(int i = 0; i < 6 ; i++) {
                int x = n1 + i;
                for(int j=0;j < 6; j++) {
                    int y = n2 + j;
                    for(int k=0; k <6 ; k++) {
                        int z = n3 + k;
                        NSMutableString *tempKey = [[NSMutableString alloc]init];
                        [tempKey appendFormat:@"%d %d %d ",x,y,z]; // there is a space after the last value
                        
                        //DebugLog(@"Temp key (%d) :%@",count,tempKey);
                        count++;
                        for (UITouchShapeRecognizer *UIT in shapeDataCache) {
                            recordedShapes = UIT.shapeData;
                            if ([recordedShapes objectForKey:tempKey]) {
                                DebugLog(@"Shape Detected with Modified Key :  %@",UIT.label);
                                DebugLog(@"Found %@ Shape: %@ Key: %@", UIT.label,[recordedShapes valueForKey:key], key);
                                detectedPoints = [NSArray arrayWithArray:allTouchPoints];
                                [distanceArr removeAllObjects];
                                [allTouchPoints removeAllObjects];
                                if (delegate && [delegate respondsToSelector:@selector(shapeDetected: inView:)]) {
                                    //[delegate shapeDetected:UIT inView:self];
//                                    [delegate visualizeShapeFromData:detectedPoints andRecognizer:UIT withTouchGroup:group];
                                }
                                return;
                            }
                        }
                    }
                }
            }
        }
    }
    
    [allTouchPoints removeAllObjects];
    [distanceArr removeAllObjects];
    
    
}

//=====================================================================================================================================//

-(void) performCalculations{
    DebugLog(@"");
    
    NSLog(@"PerformCalculations allTouchCount : %d",allTouchPoints.count);
    
    if(allTouchPoints.count == 2) {
        for(int i = 0;i<allTouchPoints.count - 1;i++){
            UITouch *touch = [allTouchPoints objectAtIndex:i];
            CGPoint touchLocation = [touch locationInView:self];
            
            int compareLocationX,compareLocationY;
            compareLocationX = touchLocation.x;
            compareLocationY = touchLocation.y;
            int touchLocationX,touchLocationY;
            
            if(i == allTouchPoints.count - 1){
                UITouch *touch2 = [allTouchPoints objectAtIndex:0];
                CGPoint touchLocation2 = [touch2 locationInView:self];
                touchLocationX = touchLocation2.x;
                touchLocationY = touchLocation2.y;
            }
            else{
                UITouch *touch3 = [allTouchPoints objectAtIndex:i+1];
                CGPoint touchLocation3 = [touch3 locationInView:self];
                touchLocationX = touchLocation3.x;
                touchLocationY = touchLocation3.y;
            }
            
            int distance = (sqrt(pow((compareLocationY - touchLocationY),2) + pow((compareLocationX - touchLocationX), 2))*scale);
            
            [distanceArr addObject:[NSNumber numberWithInt:distance]];
            
            if([[TigglyStampUtils sharedInstance] getDebugModeForWriteKeyInCsvOn]) {
                    UIView *testView= [[UIView alloc] initWithFrame:CGRectMake(touchLocation.x, touchLocation.y, 20, 20)];
                    testView.backgroundColor = [UIColor blueColor];
                    testView.layer.cornerRadius = 10.0f;
                    testView.layer.masksToBounds=YES;
                    [self addSubview:testView];
           
                    double delayInSeconds = 0.2;
                    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
                    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
                        [testView removeFromSuperview];
                        
                    });
            }
            
        }
         [self detectShape];
    }
    
    if(allTouchPoints.count == 3) {
        
        for(int i = 0;i<allTouchPoints.count;i++){
            UITouch *touch = [allTouchPoints objectAtIndex:i];
            CGPoint touchLocation = [touch locationInView:self];
            
            int compareLocationX,compareLocationY;
            compareLocationX = touchLocation.x;
            compareLocationY = touchLocation.y;
            int touchLocationX,touchLocationY;
            
            if(i == allTouchPoints.count - 1){
                UITouch *touch2 = [allTouchPoints objectAtIndex:0];
                CGPoint touchLocation2 = [touch2 locationInView:self];
                touchLocationX = touchLocation2.x;
                touchLocationY = touchLocation2.y;
            }
            else{
                UITouch *touch3 = [allTouchPoints objectAtIndex:i+1];
                CGPoint touchLocation3 = [touch3 locationInView:self];
                touchLocationX = touchLocation3.x;
                touchLocationY = touchLocation3.y;
            }
            
            int distance = (sqrt(pow((compareLocationY - touchLocationY),2) + pow((compareLocationX - touchLocationX), 2))*scale);
            
            [distanceArr addObject:[NSNumber numberWithInt:distance]];
            
            if([[TigglyStampUtils sharedInstance] getDebugModeForWriteKeyInCsvOn]) {
                    UIView *testView= [[UIView alloc] initWithFrame:CGRectMake(touchLocation.x, touchLocation.y, 20, 20)];
                    testView.backgroundColor = [UIColor redColor];
                    [self addSubview:testView];
                    testView.layer.cornerRadius = 10.0f;
                    testView.layer.masksToBounds=YES;
                    [allTestViews addObject:testView];

                    double delayInSeconds = 0.2;
                    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
                    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
                        [testView removeFromSuperview];
                        
                    });
            }
        }
        
         [self detectShape];
    }
    
    [allTouchPoints removeAllObjects];
    [distanceArr removeAllObjects];
    
}

-(void) performCalculations:(UITouchGroup *)group{
    DebugLog(@"");
    
    if(allTouchPoints.count == 2) {
        for(int i = 0;i<allTouchPoints.count - 1;i++){
            UITouch *touch = [allTouchPoints objectAtIndex:i];
            CGPoint touchLocation = [touch locationInView:self];
            
            int compareLocationX,compareLocationY;
            compareLocationX = touchLocation.x;
            compareLocationY = touchLocation.y;
            int touchLocationX,touchLocationY;
            
            if(i == allTouchPoints.count - 1){
                UITouch *touch2 = [allTouchPoints objectAtIndex:0];
                CGPoint touchLocation2 = [touch2 locationInView:self];
                touchLocationX = touchLocation2.x;
                touchLocationY = touchLocation2.y;
            }
            else{
                UITouch *touch3 = [allTouchPoints objectAtIndex:i+1];
                CGPoint touchLocation3 = [touch3 locationInView:self];
                touchLocationX = touchLocation3.x;
                touchLocationY = touchLocation3.y;
            }
            
            int distance = (sqrt(pow((compareLocationY - touchLocationY),2) + pow((compareLocationX - touchLocationX), 2))*scale);
            
            [distanceArr addObject:[NSNumber numberWithInt:distance]];
            
        }
        
    }
    
    if(allTouchPoints.count == 3) {
        
        for(int i = 0;i<allTouchPoints.count;i++){
            UITouch *touch = [allTouchPoints objectAtIndex:i];
            CGPoint touchLocation = [touch locationInView:self];
            
            int compareLocationX,compareLocationY;
            compareLocationX = touchLocation.x;
            compareLocationY = touchLocation.y;
            int touchLocationX,touchLocationY;
            
            if(i == allTouchPoints.count - 1){
                UITouch *touch2 = [allTouchPoints objectAtIndex:0];
                CGPoint touchLocation2 = [touch2 locationInView:self];
                touchLocationX = touchLocation2.x;
                touchLocationY = touchLocation2.y;
            }
            else{
                UITouch *touch3 = [allTouchPoints objectAtIndex:i+1];
                CGPoint touchLocation3 = [touch3 locationInView:self];
                touchLocationX = touchLocation3.x;
                touchLocationY = touchLocation3.y;
            }
            
            int distance = (sqrt(pow((compareLocationY - touchLocationY),2) + pow((compareLocationX - touchLocationX), 2))*scale);
            
            [distanceArr addObject:[NSNumber numberWithInt:distance]];
            
        }
    }
    
    [self detectShape:group];
    
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
        if(allTouchPoints.count < 3)
           [allTouchPoints addObject:touch];
    }
    
    if(allTouchPoints.count ==  2) {
        [self performCalculations];
    }

    NSLog(@"touchesBegan : AllTouchpoints : %d",allTouchPoints.count);
}

//======================================================================================================================//

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
    
    if(delegate && [delegate respondsToSelector:@selector(touchVerificationViewTouchesBegan:withEvent:)]) {
        [self.delegate touchVerificationViewTouchesMoved:touches withEvent:event];
    }
    
    for (UITouch *touch  in touches) {
        if(allTouchPoints.count < 3)
            [allTouchPoints addObject:touch];
    }
    
    if(allTouchPoints.count ==  2) {
        [self performCalculations];
    }

    NSLog(@"touchesMoved : AllTouchpoints : %d",allTouchPoints.count);
}



-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    isContaintSelfPoint = NO;
    
    if(delegate && [delegate respondsToSelector:@selector(touchVerificationViewTouchesEnded:withEvent:)]) {
        [self.delegate touchVerificationViewTouchesEnded:touches withEvent:event];
    }

    NSLog(@"touchesEnded : AllTouchpoints : %d " ,allTouchPoints.count);
    [self performCalculations];
    
#ifdef IS_RUN_WITHOUT_SHAPE_FOR_TESTING
    for (UITouchShapeRecognizer *UIT in shapeDataCache) {
        if (delegate && [delegate respondsToSelector:@selector(shapeDetected: inView:)]) {
            [delegate shapeDetected:UIT inView:self];
        }
    }
#endif

}



//-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
//    DebugLog(@"");
//
//    if(delegate && [delegate respondsToSelector:@selector(touchVerificationViewTouchesBegan:withEvent:)]) {
//        [self.delegate touchVerificationViewTouchesBegan:touches withEvent:event];
//    }
//    
//    if (!isWithShape) {
//        return;
//    }
//    
//    DebugLog(@"Total Touches : %d",touches.count);
//    for (UITouch *touch  in touches) {
//        [allTouchPoints addObject:touch];
//        if (event != NULL) {
//            isContaintSelfPoint = YES;
//        }
//    }
//
//    DebugLog(@"AllTouchPoints Count : %d",allTouchPoints.count);
//    if(allTouchPoints.count == 2 || allTouchPoints.count == 3) {
//
//        if (isContaintSelfPoint) {
//            [self performCalculations];
//        }
//        
//    }else{
//        if (allTouchPoints.count > 3) {
//            [allTouchPoints removeAllObjects];
//        }
//        
//    }
//    
//#ifdef IS_RUN_WITHOUT_SHAPE_FOR_TESTING
//    for (UITouchShapeRecognizer *UIT in shapeDataCache) {
//        if (delegate && [delegate respondsToSelector:@selector(shapeDetected: inView:)]) {
//            [delegate shapeDetected:UIT inView:self];
//        }
//    }
//#endif
//    
//}
//
//-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
//    DebugLog(@"");
//    if(delegate && [delegate respondsToSelector:@selector(touchVerificationViewTouchesBegan:withEvent:)]) {
//        [self.delegate touchVerificationViewTouchesMoved:touches withEvent:event];
//    }
//    for (UITouch *touch  in touches) {
//        [allTouchPoints addObject:touch];
//    }
//    
//    if (!isWithShape) {
//        return;
//    }
//    DebugLog(@"AllTouchPoints Count : %d",allTouchPoints.count);
//    if(allTouchPoints.count == 2 || allTouchPoints.count == 3) {
//        if (isContaintSelfPoint) {
//            [self performCalculations];
//        }
//    }else{
//        if (allTouchPoints.count > 3) {
//            [allTouchPoints removeAllObjects];
//        }
//    }
//
//}
//
//-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
//    DebugLog(@"");
//    isContaintSelfPoint = NO;
//    
//    if (event == nil) {
//        [allTouchPoints removeAllObjects];
//        return;
//    }
//    if (isWithShape) {
//        [allTouchPoints removeAllObjects];
//    }
//    if(delegate && [delegate respondsToSelector:@selector(touchVerificationViewTouchesEnded:withEvent:)]) {
//        [self.delegate touchVerificationViewTouchesEnded:touches withEvent:event];
//    }
//}
//
//
//-(void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event{
//    DebugLog(@"");
//    DebugLog(@"Total Touches : %d",touches.count);
//  
//}


@end
