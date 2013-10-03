//
//  UITouchVerificationView.h
//  TouchVerification
//
//  Created by Philip Hayes on 3/3/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//
#define vVerificationMode3Point @"3-p"
#import <UIKit/UIKit.h>
#import "UITouchGroup.h"
#import "UITouchShapeRecognizer.h"
#import <QuartzCore/QuartzCore.h>
#import "TConstant.h"

@protocol UITouchVerificationViewDelegate <NSObject>
@optional
-(void)shapeDetected:(UITouchShapeRecognizer*)UIT;
-(void)shapeDetected:(UITouchShapeRecognizer *)UIT inView:(id)view;
-(void)shapeRendered:(CALayer *)shape;
-(void)touchVerificationViewTouchesBegan:(NSSet *)touches withEvent:(UIEvent *)event;
-(void)touchVerificationViewTouchesMoved:(NSSet *)touches withEvent:(UIEvent *)event;
-(void)touchVerificationViewTouchesEnded:(NSSet *)touches withEvent:(UIEvent *)event;
-(void)visualizeShapeFromData:(NSArray*)pointComparison andRecognizer:(UITouchShapeRecognizer*)shapeRec withTouchGroup:(UITouchGroup*)group;
@end

@interface UITouchVerificationView : UIView{
    NSDictionary *recordedShapes;
    NSMutableArray * touchCache; // this is stroring the array  UITouchGroup->groupcache
    NSMutableArray * touchPoints;
    NSMutableSet * shapeDataCache;
    NSMutableSet * touchGroups;  // this is private function which store  UITouchGroup objects same as static variable UITouchGroup->touchGroupSet
    
    NSMutableSet *shapes;
    CALayer *currentShape;
    NSTimer *detectShapeTimer;
    float isStartDetectShape;
    NSMutableArray *allTouchPoints;
    NSMutableArray *distanceArr;
    NSMutableArray *detectedPoints;
    BOOL isContaintSelfPoint;
    
    NSMutableArray *allTestViews;
    
    int circleShpDetected;
    int triangleShpDetected;
    int starShpDetected;
    int squareShpDetected;
    
    
}
@property (nonatomic,strong) NSMutableArray * touchCache;
@property (nonatomic, unsafe_unretained)BOOL renderShapesToSelf, captureTouchesBegin, captureTouchesMoved, captureTouchesEnded, stampShapes, fadeShapes, writeMode, activated;


@property (nonatomic, strong)NSString *shapeRequest, *mode;
@property (nonatomic, unsafe_unretained)CGPoint recognitionPoint;
@property (nonatomic, strong)id<UITouchVerificationViewDelegate> delegate;
@property (nonatomic, strong)NSArray *detectedPoints;
@property (nonatomic, strong)UITouchGroup *cachedGroup;
@property (nonatomic, assign) BOOL isWithShape;

-(void)configure;
-(void)requestShape:(NSString*)request;
-(BOOL)calculateShape:(UITouchGroup*)group;
-(void)loadShapesWithSet:(NSMutableSet*)shapesSet;
-(void)loadShape:(UITouchShapeRecognizer*)shape;
-(void)removeAllShapes;
-(void)loadPlistDataForWriteMode:(NSMutableDictionary *)dic;

@end
