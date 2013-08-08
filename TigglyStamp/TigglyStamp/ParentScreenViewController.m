//
//  ParentScreenViewController.m
//  TigglyStamp
//
//  Created by Swpnil j. on 26/07/13.
//  Copyright (c) 2013 cuelogic. All rights reserved.
//

#import "ParentScreenViewController.h"

#define TAG_SUBSCRIBE_BTN 1
#define TAG_SETTINGS_BTN 2
#define TAG_FACEBOOK_BTN 3
#define TAG_TWITTER_BTN 4
#define TAG_PATH_BTN 5
#define TAG_SKIP_BTN 6
#define TAG_SUBMIT_BTN 7
#define TAG_HOME_BTN 8

@interface ParentScreenViewController ()

@end

@implementation ParentScreenViewController

@synthesize subscribeBTN,settingsBTN,faceBookBTN,twitterBTN,pathBTN,childInfoView,confView,homeBTN,skipBTN,submitBTN;
@synthesize childInfoSubView;
@synthesize confSubView;
@synthesize emailidTextField;
@synthesize nameTextField;
@synthesize ageTextField;
@synthesize activeSession;
@synthesize userFieldsRequired;
@synthesize permissions;

#pragma mark- Activity LifeCycle
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    
    [subscribeBTN setTag:TAG_SUBSCRIBE_BTN];
    [settingsBTN setTag:TAG_SETTINGS_BTN];
    [faceBookBTN setTag:TAG_FACEBOOK_BTN];
    [twitterBTN setTag:TAG_TWITTER_BTN];
    [pathBTN setTag:TAG_PATH_BTN];
    [skipBTN setTag:TAG_SKIP_BTN];
    [submitBTN setTag:TAG_SUBMIT_BTN];
    [homeBTN setTag:TAG_HOME_BTN];
    
    childInfoSubView.layer.cornerRadius = 30.0f;
    childInfoSubView.layer.masksToBounds = YES;
    
    confSubView.layer.cornerRadius = 25.0f;
    confSubView.layer.masksToBounds = YES;
    confSubView.layer.borderColor =  [UIColor blueColor].CGColor;
    confSubView.layer.borderWidth = 1.5f;
    
    settingsBTN.layer.cornerRadius = 10.0f;
    settingsBTN.layer.masksToBounds = YES;
    
    subscribeBTN.layer.cornerRadius = 10.0f;
    subscribeBTN.layer.masksToBounds = YES;
    
    skipBTN.layer.cornerRadius = 10.0f;
    skipBTN.layer.masksToBounds = YES;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark- Helpers
-(void) launchSettingScreen {
    DebugLog(@"");
    SettingsViewController *settingsView = [[SettingsViewController alloc] init];
    settingsView.modalPresentationStyle = UIModalPresentationPageSheet;
   // settingsView.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    [self presentModalViewController:settingsView animated:YES];

    [settingsView.view.superview setAutoresizingMask:(UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth)];
    [settingsView.view.superview setFrame:CGRectMake(128, 177, 768, 414)];
    settingsView.view.superview.layer.cornerRadius = 25.0f;
    settingsView.view.superview.layer.masksToBounds = YES;
//    settingsView.view.superview.frame = CGRectMake(0, 0, 768, 414);//it's important to do this after
//    settingsView.view.superview.center = self.view.center;
//    settingsView.view.superview.layer.cornerRadius = 25.0f;
//    settingsView.view.superview.layer.masksToBounds = YES;
}

- (void)removeConfirmationDilog:(NSTimer*)timer {
    
    [self.confView removeFromSuperview];
}

#pragma mark- IBAction handling
-(IBAction)onButtonClicked:(id)sender{
    DebugLog(@"");
    
    UIButton *btn = sender;
    if ([btn tag] == TAG_HOME_BTN) {
        [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:1] animated:YES];
    }
    if ([btn tag] == TAG_SUBSCRIBE_BTN) {
        if (emailidTextField.text.length != 0) {
            if ([self isValidEmailAddress:emailidTextField.text] == YES) {
                
                [self.view addSubview:childInfoView];
                [nameTextField becomeFirstResponder];
                
            }else{
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Tiggly" message:@"Please enter valid email address" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
                [alert show];
            }
        }else{
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Tiggly" message:@"Please enter email address" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
            [alert show];
        }
    }
    if ([btn tag] == TAG_SETTINGS_BTN) {
        [self launchSettingScreen];
    }
    if ([btn tag] == TAG_FACEBOOK_BTN) {
        [self signInWithFacebook:sender];
    }
    if ([btn tag] == TAG_TWITTER_BTN) {
        [self signInWithTwitter:sender];
    }
    if ([btn tag] == TAG_PATH_BTN) {
        [self signInWithPinterest:sender];
    }
    if ([btn tag] == TAG_SKIP_BTN) {
        [self.childInfoView removeFromSuperview];
    }
    if ([btn tag] == TAG_SUBMIT_BTN) {
        if ([self validateData] == YES) {
            [self.childInfoView removeFromSuperview];
            [self.view addSubview:confView];
            nameTextField.text = @"";
            ageTextField.text = @"";
            [NSTimer scheduledTimerWithTimeInterval:4.0 target:self selector:@selector(removeConfirmationDilog:) userInfo:nil repeats:NO];
            
        }
    }
}

#pragma mark- Facebook Integration
-(void)signInWithFacebook:(id)sender
{
    [self facebookLogout];
    [self facebookAuthentication];
}

- (void) facebookLogout
{
    [FBSession.activeSession closeAndClearTokenInformation];
    [FBSession.activeSession close];
    [FBSession setActiveSession:nil];
    NSHTTPCookie *cookie;
    NSHTTPCookieStorage *storage = [NSHTTPCookieStorage sharedHTTPCookieStorage];
    for (cookie in [storage cookies])
    {
        NSString *domainName = [cookie domain];
        NSRange domainRange = [domainName rangeOfString:@"facebook"];
        if(domainRange.length > 0)
        {
            [storage deleteCookie:cookie];
        }
    }
    //    activeSession = [[FBSession alloc] initWithPermissions:permissions];
}



- (void) facebookAuthentication
{
    // FBSample logic
    // Check to see whether we have already opened a session.
    
    userFieldsRequired = @"id,name,first_name, last_name, gender,birthday,email,username, work";
    permissions = [[NSArray alloc] initWithObjects:
                   @"email" , @"user_about_me",@"user_birthday", @"user_work_history",@"user_interests", @"user_activities",@"user_status",@"user_photos",@"user_likes",
                   nil];
    
    if (!FBSession.activeSession.isOpen)
    {
        activeSession = [[FBSession alloc] initWithPermissions:permissions];
        
        [activeSession openWithBehavior:FBSessionLoginBehaviorForcingWebView
                      completionHandler:^(FBSession *session,
                                          FBSessionState status,
                                          NSError *error) {
                          // if login fails for any reason, we alert
                          if (error) {

                            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Tiggly" message:@"Do you want to try again?" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
                              
                              // if otherwise we check to see if the session is open, an alternative to
                              // to the FB_ISSESSIONOPENWITHSTATE helper-macro would be to check the isOpen
                              // property of the session object; the macros are useful, however, for more
                              // detailed state checking for FBSession objects
                          } else if (FB_ISSESSIONOPENWITHSTATE(session.state)) {
                              // send our requests if we successfully logged in
                              [self sendRequests:[NSString stringWithFormat:@"me?access_token=%@",activeSession.accessToken] params:[NSDictionary dictionaryWithObject:userFieldsRequired forKey:@"fields"]];
                          }
                          else
                          {
                              [activeSession closeAndClearTokenInformation];
                          }
                      }];
        
    }else
    {
        [self sendRequests:[NSString stringWithFormat:@"me?access_token=%@",activeSession.accessToken] params:[NSDictionary dictionaryWithObject:userFieldsRequired forKey:@"fields"]];
    }
    
}

-(void) sendRequests:(NSString *) fbid
{
    [self sendRequests:fbid params:NULL];
}

-(void) sendRequests:(NSString *) fbid params:(NSDictionary *) params
{
    // create the connection object
    FBRequestConnection *newConnection = [[FBRequestConnection alloc] init];
    
    // create a handler block to handle the results of the request for fbid's profile
    FBRequestHandler handler =
    ^(FBRequestConnection *connection, id result, NSError *error) {
        // output the results of the request
        [self requestCompleted:connection forFbID:fbid result:result error:error];
    };
    
    // create the request object, using the fbid as the graph path
    // as an alternative the request* static methods of the FBRequest class could
    // be used to fetch common requests, such as /me and /me/friends
    FBRequest *request = NULL;
    if(params != NULL)
    {
        request = [[FBRequest alloc] initWithSession:activeSession
                                           graphPath:fbid parameters:params HTTPMethod:@"GET"] ;
    }
    else
    {
        request = [[FBRequest alloc] initWithSession:activeSession
                                           graphPath:fbid];
    }
    
    // add the request to the connection object, if more than one request is added
    // the connection object will compose the requests as a batch request; whether or
    // not the request is a batch or a singleton, the handler behavior is the same,
    // allowing the application to be dynamic in regards to whether a single or multiple
    // requests are occuring
    [newConnection addRequest:request completionHandler:handler];
    
    
    // if there's an outstanding connection, just cancel
    //    [self.requestConnection cancel];
    //
    //    // keep track of our connection, and start it
    //    self.requestConnection = newConnection;
    [newConnection start];
}


// FBSample logic
// Report any results.  Invoked once for each request we make.
- (void)requestCompleted:(FBRequestConnection *)connection
                 forFbID:fbID
                  result:(id)result
                   error:(NSError *)error
{
    
}

#pragma mark- Pinterest Integration
-(void)signInWithPinterest:(id)sender
{
    _pinterest = [[Pinterest alloc] initWithClientId:@"1432658"];
    
    [_pinterest createPinWithImageURL:[NSURL URLWithString:@"http://placekitten.com/500/400"]
                            sourceURL:[NSURL URLWithString:@"http://placekitten.com"]
                          description:@"Pinning from Tiggly Application"];
    
}

#pragma mark- Twitter Integration
-(void)signInWithTwitter:(id)sender
{
    [[FHSTwitterEngine sharedEngine]permanentlySetConsumerKey:kOAuthConsumerKey andSecret:kOAuthConsumerSecret];
    [[FHSTwitterEngine sharedEngine]setDelegate:self];
    
    [[FHSTwitterEngine sharedEngine]showOAuthLoginControllerFromViewController:self withCompletion:^(BOOL success) {
        NSLog(success?@"L0L success":@"O noes!!! Loggen faylur!!!");
        NSDictionary *twitterDict =  [[FHSTwitterEngine sharedEngine] getTwitterAccountDetails:[[FHSTwitterEngine sharedEngine]loggedInUsername]];
        NSLog(@"USER DICT _ %@",twitterDict);
    }];
}

#pragma mark- UITextField Delegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField == nameTextField) {
        [ageTextField becomeFirstResponder];
    }else{
        [textField resignFirstResponder];
    }
    return YES;
}

#pragma mark - Data Validation
- (BOOL)isValidEmailAddress:(NSString*)emailAddress
{
	if (emailAddress.length > 160)
		return NO;
    
	NSString* pattern = @"[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\\.[a-zA-Z]{2,4}";
	NSPredicate* predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
	return [predicate evaluateWithObject:emailAddress];
}

- (void)showValidationError:(NSString*)message
{
	[self showValidationError:message title:NSLocalizedString(@"Tiggly", @"")];
}

- (void)showValidationError:(NSString*)message title:(NSString*)theTitle
{
	UIAlertView *alertView = [[UIAlertView alloc]
                              initWithTitle:theTitle
                              message:message
                              delegate:nil
                              cancelButtonTitle:NSLocalizedString(@"Ok", nil)
                              otherButtonTitles:nil] ;
    
	[alertView show];
}

- (BOOL)requiredField:(NSString*)fieldValue named:(NSString*)fieldName
{
	if (fieldValue.length == 0)
	{
		[self showValidationError:[NSString stringWithFormat:NSLocalizedString(@"Please enter %@", nil), fieldName]];
		return NO;
	}
	return YES;
}

- (BOOL)validateData
{
	if (![self requiredField:nameTextField.text named:NSLocalizedString(@"child's name", nil)])
		return NO;
    if (![self requiredField:ageTextField.text named:NSLocalizedString(@"child's age", nil)])
		return NO;
    
   	return YES;
}

@end
