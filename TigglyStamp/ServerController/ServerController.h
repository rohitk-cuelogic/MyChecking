//
//  ServerController.h
//  TigglySafari
//
//  Created by swapnil Jagtap on 08/12/13.
//  Copyright (c) 2013 Sachin Patil. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TigglyStampUtils.h"
#import "Reachability.h"
#import "ASIHTTPRequest.h"
#import "ASINetworkQueue.h"
#import "JSON.h"
#import "CustomizedNetworkChecks.h"
#import "ActivityAlertView.h"

@protocol ServiceControlerDelegate

- (void) newsDataRetrived:(NSMutableArray *) data;
- (void) newsCountDataRetrived:(NSDictionary *) dict;
- (void) iPadMiniDeviceVersionDataRetrived:(NSDictionary *) dict;

@end

@interface ServerController : NSObject {
    
    ASINetworkQueue *networkQueue;
    NSMutableArray *arrQueue;
    NSArray *arrTempQueue;
    NSDictionary *responseDictionary;
    id<ServiceControlerDelegate> _delegate;
    ActivityAlertView *objActivityAlertView;
    
}

@property (nonatomic, strong) NSMutableData *getResponseData;
@property (nonatomic, strong) NSMutableArray *arrQueue;
@property (nonatomic, strong)NSArray *arrTempQueue;
@property (nonatomic, strong)NSDictionary *responseDictionary;
@property (nonatomic,retain) id<ServiceControlerDelegate> delegate;

+ (id)sharedInstance;

// ASIHTTP
//Send email for subscription
-(void)sendSubscriptionEmail:(NSString *)emailId;

// Featch news count required to display badge count on home screen
- (void) fetchNewsFeedCountWithService:(id<ServiceControlerDelegate>) serviceDelegate;

//This is method is called to fetch news feed
- (void) fetchNewsFeedWithPageNumber:(NSString *)pageno service:(id<ServiceControlerDelegate>) serviceDelegate;

//This method should call when used for draw shape
- (void) drawShapeWithIsVirtualShape:(NSString*)isvertualshape withShapeType:(NSString*)shapetype withShapeCorrect:(NSString*)isCorrectShape;

//This method should call when use to store the session time
-(void)sessionDetailsWithType:(NSString*)sessionType VirtualShape:(NSString*)isVirtualShape;

// This method should call when use to store the detailed behaviour of how the user's uses app
- (void) sendEvent :(NSString *)eventName withEventValue:(NSString *)eventValue withServiceName:(NSString *)serviceName;
// Featch device version array
- (void) fetchiPadDeviceVersion:(id<ServiceControlerDelegate>) serviceDelegate;

-(void)saveASIHTTPRequestArrayInDocumentsDirectory;
-(void)fetchASIHTTPRequestArrayFromDocumentsDirectory;

@end
