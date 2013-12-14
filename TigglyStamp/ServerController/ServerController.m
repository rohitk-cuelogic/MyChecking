//
//  ServerController.m
//  TigglySafari
//
//  Created by swapnil Jagtap on 08/12/13.
//  Copyright (c) 2013 Sachin Patil. All rights reserved.
//

#import "ServerController.h"


@implementation ServerController
@synthesize getResponseData;
@synthesize arrQueue;
@synthesize responseDictionary;
@synthesize delegate = _delegate;

#pragma mark -
#pragma mark =======================================
#pragma mark Init
#pragma mark =======================================

static ServerController *sharedInstance = nil;

// Get the shared instance and create it if necessary.
+ (ServerController *)sharedInstance {
    if (sharedInstance == nil) {
        sharedInstance = [[ServerController alloc]init];

    }
    return sharedInstance;
}

- (id)init {
    DebugLog(@"");
    self = [super init];
    if (self) {
        [self initNetworkQueue];
        self.arrQueue=[[NSMutableArray alloc]init];
        self.responseDictionary=[[NSDictionary alloc]init];

    }
    return self;
}

#pragma mark -
#pragma mark =======================================
#pragma mark Init Network Queue
#pragma mark =======================================

-(void) initNetworkQueue{
//    DebugLog(@"");
    
    if (!networkQueue) {
        networkQueue = [[ASINetworkQueue alloc] init];
    }
    [networkQueue setRequestDidFinishSelector:@selector(dataFetchComplete:)];
    [networkQueue setRequestDidFailSelector:@selector(dataFetchFailed:)];
    [networkQueue setDelegate:self];
}



#pragma mark -
#pragma mark =======================================
#pragma mark Network Connection
#pragma mark =======================================

-(BOOL)isNetworkAvailable {
    DebugLog(@"");
    UIAlertView *errorView;
    NetworkStatus internetStatus = [[Reachability reachabilityForInternetConnection] currentReachabilityStatus];
    
    if(internetStatus== NotReachable){
        
        errorView = [[UIAlertView alloc]
                     initWithTitle: @"Tiggly"
                     message: @"It seems that your internet connection is not working. Please check your internet connection."
                     delegate: nil
                     cancelButtonTitle: @"Ok" otherButtonTitles: nil];
        [errorView show];
        return NO;
    }
    
        return YES;
}

#pragma mark -
#pragma mark =======================================
#pragma mark ASIHTTP WebService Queue Requests
#pragma mark =======================================

-(void)sendSubscriptionEmail:(NSString *)emailId{
    DebugLog(@"");
    
    // web service 1
    DebugLog(@"EmailId: %@",emailId);
    
    NSMutableString *url = [NSMutableString stringWithFormat:@"%@%@%@",SERVICE_URL, SERVICE_NAME_SUBSCRIPTION, SERVICE_URL_PART];
    [url appendString:[NSString stringWithFormat:@"{\"user_deviceid\":\"%@\",",[[TigglyStampUtils sharedInstance] getDeviceIDMacAddres]] ];
    [url appendString:[NSString stringWithFormat:@"\"app_name\":\"%@\",",APP_NAME]];
    [url appendString:[NSString stringWithFormat:@"\"email\":\"%@\"}",emailId]];
    
    DebugLog(@"RequestURL : %@",url);
    
    NSString *safestring=[url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:safestring]];
    [request setShouldContinueWhenAppEntersBackground:NO];
    [request setTimeOutSeconds:80];
    [request setNumberOfTimesToRetryOnTimeout:2];
    [request setRequestMethod:@"POST"];
    [networkQueue addOperation:request];
    
    [networkQueue go];
    
    /* NSMutableDictionary *loginDict = [[NSMutableDictionary alloc] init];
     [loginDict setValue:[[TigglySafariUtils sharedInstance] getDeviceIDMacAddres] forKey:@"user_deviceid"];
     [loginDict setValue:APP_NAME forKey:@"app_name"];
     [loginDict setValue:emailId forKey:@"email"];
     
     [self updateForDictMethod:@"subscribe" WithDictionary:loginDict];*/
}

- (void) drawShapeWithIsVirtualShape:(NSString*)isvertualshape withShapeType:(NSString*)shapetype withShapeCorrect:(NSString*)isCorrectShape
{
    DebugLog(@"");
    
    // web service 4
    /*http://www.cuelogic.co.in/projects/tiggly_web/manageapi?f=tig.shapeDraw&u=42a6787c06386024958742c737a1bd56&p={"user_deviceid":"deviceid","app_name":"safari","is_virtual_shape" :"yes","shape_type":"star","is_correct":"yes"}*/
    
    NSMutableString *url = [NSMutableString stringWithFormat:@"%@%@%@",SERVICE_URL, SERVICE_URL_SHAPEDRAW, SERVICE_URL_PART];
    [url appendString:[NSString stringWithFormat:@"{\"user_deviceid\":\"%@\",",[[TigglyStampUtils sharedInstance] getDeviceIDMacAddres]] ];
    [url appendString:[NSString stringWithFormat:@"\"app_name\":\"%@\",",APP_NAME]];
    [url appendString:[NSString stringWithFormat:@"\"is_virtual_shape\":\"%@\",",isvertualshape]];
    [url appendString:[NSString stringWithFormat:@"\"shape_type\":\"%@\",",shapetype]];
    [url appendString:[NSString stringWithFormat:@"\"is_correct\":\"%@\"}",isCorrectShape]];
    
    DebugLog(@"RequestURL : %@",url);
    NSString *safestring=[url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:safestring]];
    [request setShouldContinueWhenAppEntersBackground:NO];
    [request setTimeOutSeconds:80];
    [request setNumberOfTimesToRetryOnTimeout:2];
    [networkQueue addOperation:request];
    [networkQueue go];
}

-(void)sessionDetailsWithType:(NSString*)sessionType VirtualShape:(NSString*)isVirtualShape
{
    // web service 5
    
    NSMutableString *url = [NSMutableString stringWithFormat:@"%@%@%@",SERVICE_URL, SERVICE_URL_SESSIONDETAILS, SERVICE_URL_PART];
    [url appendString:[NSString stringWithFormat:@"{\"user_deviceid\":\"%@\",",[[TigglyStampUtils sharedInstance] getDeviceIDMacAddres]] ];
    [url appendString:[NSString stringWithFormat:@"\"app_name\":\"%@\",",APP_NAME]];
    [url appendString:[NSString stringWithFormat:@"\"is_virtual_shape\":\"%@\",",isVirtualShape]];
    [url appendString:[NSString stringWithFormat:@"\"session_type\":\"%@\"}",sessionType]];
    
    DebugLog(@"RequestURL : %@",url);
    
    NSString *safestring=[url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:safestring]];
    [request setShouldContinueWhenAppEntersBackground:NO];
    [request setTimeOutSeconds:80];
    [request setNumberOfTimesToRetryOnTimeout:2];
    [request setRequestMethod:@"POST"];
    [networkQueue addOperation:request];
    
    [networkQueue go];
    
}

- (void) sendEvent :(NSString *)eventName withEventValue:(NSString *)eventValue withServiceName:(NSString *)serviceName
{
    DebugLog(@"");
    // web service 3
    /*http://www.cuelogic.co.in/projects/tiggly_web/manageapi?f=tig.setDeviceProfile&u=42a6787c06386024958742c737a1bd56&p={"user_deviceid":"deviceid","app_name":"cristmas","app_download":"yes"}*/
    
    // web service 6
    /*www.cuelogic.co.in/projects/tiggly_web/manageapi?f=tig.setBehaviourCount&u=42a6787c06386024958742c737a1bd56&p={"user_deviceid":"deviceid","app_name":"safari","tab_pin_interest" :"yes","tab_review":"star","tab_skill_icon":"yes","tab_play":"yes","tab_learning_tips":"yes","tab_learn_philosophy":"yes","tab_goto_gallery":"yes","tab_saveto_gallery":"yes","language":"1"}*/
    
    NSMutableString *url = [NSMutableString stringWithFormat:@"%@%@%@",SERVICE_URL, serviceName, SERVICE_URL_PART];
    [url appendString:[NSString stringWithFormat:@"{\"user_deviceid\":\"%@\",",[[TigglyStampUtils sharedInstance] getDeviceIDMacAddres]] ];
    [url appendString:[NSString stringWithFormat:@"\"app_name\":\"%@\",",APP_NAME]];
    [url appendString:[NSString stringWithFormat:@"\"language\":\"%@\",",[[TigglyStampUtils sharedInstance] getCurrentLanguageCode]]];
    [url appendString:[NSString stringWithFormat:@"\"%@\":\"%@\"}",eventName,eventValue]];
    DebugLog(@"RequestURL : %@",url);
    NSString *safestring=[url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:safestring]];
    [request setShouldContinueWhenAppEntersBackground:NO];
    [request setTimeOutSeconds:80];
    [request setNumberOfTimesToRetryOnTimeout:2];
    [networkQueue addOperation:request];
    [networkQueue go];
}

#pragma mark -
#pragma mark =======================================
#pragma mark Network Queue Delegate
#pragma mark =======================================

-(void)dataFetchComplete:(ASIHTTPRequest *)request {
    DebugLog(@"");
    if([request responseData]!=nil)
    {
        NSDictionary* responseDict = [NSJSONSerialization
                                      JSONObjectWithData:[request responseData]
                                      options:kNilOptions
                                      error:nil];
        
        //DebugLog(@"response Dictionary : %@",responseDict);

        DebugLog(@"Response Dict : %@",responseDict);
        if([responseDict objectForKey:@"servicename"])
        {
            NSLog(@"response came for news feed");
            responseDictionary=responseDict;
        }
        DebugLog(@"network count %d",networkQueue.requestsCount);
        
    }
}

-(void)dataFetchFailed:(ASIHTTPRequest *)request {
   // DebugLog(@"dataFetchFailed.....");
   // DebugLog(@"dataFetchFailed network count %d",networkQueue.requestsCount);

    if(![self.arrQueue containsObject:request])
    {
        ASIHTTPRequest *newReq=[request copy];
        if([self.arrQueue count]== MAX_QUEUE_COUNT)
        {
            [self.arrQueue removeObjectAtIndex:0];
        }
        [self.arrQueue addObject:newReq];
    }
    //DebugLog(@"After dataFetchFailed network count %d",[self.arrQueue count]);
    
    if (networkQueue.requestsCount == 0)
    {
        networkQueue= nil;
        [self initNetworkQueue];
        arrTempQueue=[[NSArray alloc] initWithArray:self.arrQueue copyItems:YES];
        for(ASIHTTPRequest *req in self.arrQueue)
        {
            [networkQueue addOperation:req];
        }
        [self.arrQueue removeAllObjects];
        [networkQueue go];
    }

}

#pragma mark -
#pragma mark =======================================
#pragma mark File Manager Operations
#pragma mark =======================================
-(void)saveASIHTTPRequestArrayInDocumentsDirectory
{
    DebugLog(@" arr queue count %d",arrTempQueue.count);
    NSMutableArray *arrUrlStr=[[NSMutableArray alloc]init];
    for (int i=0; i<[arrTempQueue count]; i++)
    {
        ASIHTTPRequest *newreq=[arrTempQueue objectAtIndex:i];
       NSString *myString = [ newreq.url absoluteString];
        [arrUrlStr addObject:myString];


    }
    [[NSUserDefaults standardUserDefaults] setObject:arrUrlStr forKey:REQUEST_ARRAY];
    [[NSUserDefaults standardUserDefaults] synchronize];
    /*NSString *documentsDirectory = [self getDocumentDirPath]; // Get documents folder
    NSString *folderPath = [documentsDirectory stringByAppendingPathComponent:@"UniqueUserAccount"];
    
    if (![[NSFileManager defaultManager] fileExistsAtPath:folderPath])
        [[NSFileManager defaultManager] createDirectoryAtPath:folderPath withIntermediateDirectories:NO attributes:nil error:&error];
    
    folderPath = [folderPath stringByAppendingPathComponent:@"array.out"];
    [arrTempQueue writeToFile:folderPath atomically:YES];*/
}

-(void)fetchASIHTTPRequestArrayFromDocumentsDirectory
{
    [self performSelector:@selector(fetchRequestArrayAndinQueue) withObject:Nil afterDelay:1.0];
    
    
    /*NSString *documentsDirectory = [self getDocumentDirPath];;
    NSString *folderPath = [documentsDirectory stringByAppendingPathComponent:@"UniqueUserAccount"];
    
    NSArray *arrayFromFile = [NSArray arrayWithContentsOfFile:folderPath];
    NSLog(@"%@",arrayFromFile);*/
    
}
-(void)fetchRequestArrayAndinQueue
{
    NSArray *arr=[[NSUserDefaults standardUserDefaults] objectForKey:REQUEST_ARRAY];
    [self initNetworkQueue];
    for (int icount=0; icount<[arr count]; icount++)
    {
        //NSString *safestring=[url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:[arr objectAtIndex:icount]]];
        [request setShouldContinueWhenAppEntersBackground:NO];
        [request setTimeOutSeconds:80];
        [request setNumberOfTimesToRetryOnTimeout:2];
        [request setRequestMethod:@"POST"];
       // [networkQueue addOperation:request];
        //[networkQueue go];
    }
    arr=nil;
    [[NSUserDefaults standardUserDefaults] setObject:arr forKey:REQUEST_ARRAY];

}
- (NSString *) getDocumentDirPath
{
    DebugLog(@"");
    NSString *docsDirectory = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    return docsDirectory;
}


#pragma mark -
#pragma mark =======================================
#pragma mark ASIHTTP WebService Single Requests
#pragma mark =======================================

- (void) fetchNewsFeedCountWithService:(id<ServiceControlerDelegate>) serviceDelegate
{
    DebugLog(@"");
    // web service 1
    /*www.cuelogic.co.in/projects/tiggly_web/manageapi?f=tig.getUserNewsCount&u=42a6787c06386024958742c737a1bd56&p={"user_deviceid":"deviceid","app_name":"safari"}*/
    
    [self setDelegate:serviceDelegate];
//    objActivityAlertView =[[ActivityAlertView alloc]initWithTitle:nil message:@"Please wait..." delegate:nil cancelButtonTitle:nil otherButtonTitles:nil];
//    [objActivityAlertView showActivityIndicator];
    
    CustomizedNetworkChecks*  objCustomizedNetworkChecks =[[CustomizedNetworkChecks alloc]init];
    [objCustomizedNetworkChecks startObtainingNetworkChangeNotificationWithHostName:@"www.google.com"];
    
    if ([objCustomizedNetworkChecks internatIsReachable])
    {
        NSMutableString *url = [NSMutableString stringWithFormat:@"%@%@%@",SERVICE_URL, SERVICE_URL_NEWSFEED_COUNT, SERVICE_URL_PART];
        [url appendString:[NSString stringWithFormat:@"{\"user_deviceid\":\"%@\",",[[TigglyStampUtils sharedInstance] getDeviceIDMacAddres]] ];
        [url appendString:[NSString stringWithFormat:@"\"app_name\":\"%@\"}",APP_NAME]];
        
        DebugLog(@"RequestURL : %@",url);
        NSString *safestring=[url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:safestring]];
        [request setTimeOutSeconds:80];
        [request setDidFinishSelector:@selector(newsFeedCountFeatchCompleted:)];
        [request setDidFailSelector:@selector(newsFeedFetchCountFailed:)];
        [request setDelegate:self];
        [request setUserInfo:nil];
        [request startAsynchronous];
    }
    else
    {
//        [objActivityAlertView hideActivityIndicator];
//        UIAlertView* networkAlert=[[UIAlertView alloc] initWithTitle:APPLICATION_NAME message:@"Network connection not available." delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
//        [networkAlert show];
    }
}

- (void) fetchNewsFeedWithPageNumber:(NSString *)pageno service:(id<ServiceControlerDelegate>) serviceDelegate
{
    DebugLog(@"");
    // web service 2
    /*http://www.cuelogic.co.in/projects/tiggly_web/manageapi?f=tig.newsFeed&u=42a6787c06386024958742c737a1bd56&p={%22user_deviceid%22:%22deviceid%22,%22page%22:%221%22}*/
    
    [self setDelegate:serviceDelegate];
    objActivityAlertView =[[ActivityAlertView alloc]initWithTitle:nil message:@"Please wait..." delegate:nil cancelButtonTitle:nil otherButtonTitles:nil];
    [objActivityAlertView showActivityIndicator];
    
    CustomizedNetworkChecks*  objCustomizedNetworkChecks =[[CustomizedNetworkChecks alloc]init];
    [objCustomizedNetworkChecks startObtainingNetworkChangeNotificationWithHostName:@"www.google.com"];
    
    if ([objCustomizedNetworkChecks internatIsReachable])
    {
        NSMutableString *url = [NSMutableString stringWithFormat:@"%@%@%@",SERVICE_URL, SERVICE_URL_NEWSFEED, SERVICE_URL_PART];
        [url appendString:[NSString stringWithFormat:@"{\"user_deviceid\":\"%@\",",[[TigglyStampUtils sharedInstance] getDeviceIDMacAddres]] ];
        [url appendString:[NSString stringWithFormat:@"\"app_name\":\"%@\",",APP_NAME]];
        [url appendString:[NSString stringWithFormat:@"\"page\":\"%@\"}",pageno]];
        
        DebugLog(@"RequestURL : %@",url);
        NSString *safestring=[url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:safestring]];
        [request setTimeOutSeconds:80];
        [request setDidFinishSelector:@selector(newsFeedFeatchCompleted:)];
        [request setDidFailSelector:@selector(newsFeedFetchFailed:)];
        [request setDelegate:self];
        [request setUserInfo:nil];
        [request startAsynchronous];
    }
    else
    {
        [objActivityAlertView hideActivityIndicator];
        UIAlertView* networkAlert=[[UIAlertView alloc] initWithTitle:APPLICATION_NAME message:@"Network connection not available." delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [networkAlert show];
    }
}

- (void) fetchiPadDeviceVersion:(id<ServiceControlerDelegate>) serviceDelegate
{
    DebugLog(@"");
    [self setDelegate:serviceDelegate];
    
    CustomizedNetworkChecks*  objCustomizedNetworkChecks =[[CustomizedNetworkChecks alloc]init];
    [objCustomizedNetworkChecks startObtainingNetworkChangeNotificationWithHostName:@"www.google.com"];
    
    if ([objCustomizedNetworkChecks internatIsReachable])
    {
        NSMutableString *url = [NSMutableString stringWithFormat:@"%@%@%@",SERVICE_URL, SERVICE_URL_IPAD_DEVICE_VERSION, SERVICE_URL_PART];
        [url appendString:[NSString stringWithFormat:@"{\"user_deviceid\":\"%@\",",[[TigglyStampUtils sharedInstance] getDeviceIDMacAddres]] ];
        [url appendString:[NSString stringWithFormat:@"\"app_name\":\"%@\"}",APP_NAME]];
        
        DebugLog(@"RequestURL : %@",url);
        NSString *safestring=[url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:safestring]];
        [request setTimeOutSeconds:80];
        [request setDidFinishSelector:@selector(iPadMiniDeviceFeatchCompleted:)];
        [request setDidFailSelector:@selector(iPadMiniDeviceFeatchFailed:)];
        [request setDelegate:self];
        [request setUserInfo:nil];
        [request startAsynchronous];
    }
    else
    {
    }
}


#pragma mark -
#pragma mark =======================================
#pragma mark ASIHTTP Request Delegate
#pragma mark =======================================
-(void)newsFeedCountFeatchCompleted:(ASIHTTPRequest *)request
{
    if([request responseData]!=nil)
    {
        NSDictionary* responseDict = [NSJSONSerialization
                                      JSONObjectWithData:[request responseData]
                                      options:kNilOptions
                                      error:nil];
        
        [_delegate newsCountDataRetrived:responseDict];
    }
}

-(void)newsFeedFetchCountFailed:(ASIHTTPRequest *)request
{
//    [objActivityAlertView hideActivityIndicator];
//    UIAlertView* networkAlert=[[UIAlertView alloc] initWithTitle:APPLICATION_NAME message:@"There was an error fetching news count. Please try again later." delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
//    [networkAlert show];
}

-(void)newsFeedFeatchCompleted:(ASIHTTPRequest *)request
{
    if([request responseData]!=nil)
    {
        NSDictionary* responseDict = [NSJSONSerialization
                                      JSONObjectWithData:[request responseData]
                                      options:kNilOptions
                                      error:nil];
        
        NSArray *newsDetailsArray = [responseDict objectForKey:@"arrresponse"];
        NSMutableArray *NewsArray=[[NSMutableArray alloc] initWithArray:newsDetailsArray];

        [objActivityAlertView hideActivityIndicator];
        [_delegate newsDataRetrived:NewsArray];
    }
}

-(void)newsFeedFetchFailed:(ASIHTTPRequest *)request
{
    [objActivityAlertView hideActivityIndicator];
    UIAlertView* networkAlert=[[UIAlertView alloc] initWithTitle:APPLICATION_NAME message:@"There was an error fetching news feed. Please try again later." delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
    [networkAlert show];
}

-(void)iPadMiniDeviceFeatchCompleted:(ASIHTTPRequest *)request
{
    if([request responseData]!=nil)
    {
        NSDictionary* responseDict = [NSJSONSerialization
                                      JSONObjectWithData:[request responseData]
                                      options:kNilOptions
                                      error:nil];
        
        [_delegate iPadMiniDeviceVersionDataRetrived:responseDict];
    }
}

-(void)iPadMiniDeviceFeatchFailed:(ASIHTTPRequest *)request
{
    
}

@end
