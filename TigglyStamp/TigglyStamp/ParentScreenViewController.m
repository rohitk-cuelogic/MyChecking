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
#define TAG_TIGGLY_NEWS_BTN 9
#define TAG_CLOSE_WEB_BTN 10
#define TAG_LETTER_TAB_BTN 11
#define TAG_PLAY_TAB_BTN 12
#define TAG_TIP_TAB_BTN 13
#define TAG_PHILOSOPHY_TAB_BTN 14
#define TAG_LETTER_MOTAR_BTN 15
#define TAG_LETTER_LANGUAGE_BTN 16
#define TAG_LETTER_SPATIAL_BTN 17

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
@synthesize tabLetterBTN,tabLearningTipBTN,tabPlayBTN,tabLearPhilosophyBTN,tabTitleIMGVIEW,tabBodyTEXT,tabHeadingTEXT;
@synthesize tabLetterMotarBTN,tabLetterLanguageBTN,tabLetterSpatialBTN;
UIActivityIndicatorView *activityIndicator;

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
    
    if ([self respondsToSelector:@selector(setNeedsStatusBarAppearanceUpdate)]) {
        // iOS 7
        [self prefersStatusBarHidden];
        [self performSelector:@selector(setNeedsStatusBarAppearanceUpdate)];
    } else {
        // iOS 6
        [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationSlide];
    }
    
    [subscribeBTN setTag:TAG_SUBSCRIBE_BTN];
    [settingsBTN setTag:TAG_SETTINGS_BTN];
    [faceBookBTN setTag:TAG_FACEBOOK_BTN];
    [twitterBTN setTag:TAG_TWITTER_BTN];
    [pathBTN setTag:TAG_PATH_BTN];
    [skipBTN setTag:TAG_SKIP_BTN];
    [submitBTN setTag:TAG_SUBMIT_BTN];
    [homeBTN setTag:TAG_HOME_BTN];
    [btnTigglyNews setTag:TAG_TIGGLY_NEWS_BTN];
    [btnClose setTag:TAG_CLOSE_WEB_BTN];
    [tabLetterBTN setTag:TAG_LETTER_TAB_BTN];
    [tabPlayBTN setTag:TAG_PLAY_TAB_BTN];
    [tabLearningTipBTN setTag:TAG_TIP_TAB_BTN];
    [tabLetterMotarBTN setTag:TAG_LETTER_MOTAR_BTN];
    [tabLetterLanguageBTN setTag:TAG_LETTER_LANGUAGE_BTN];
    [tabLetterSpatialBTN setTag:TAG_LETTER_SPATIAL_BTN];
    
    
    [self setInfoForLetterTab];

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
    
    viewForWeb.frame = CGRectMake(0, 768, 1024, 768);

    activityIndicator = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    activityIndicator.center = webView.center;
    [webView addSubview:activityIndicator];
    [webView bringSubviewToFront:activityIndicator];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return UIInterfaceOrientationIsLandscape(interfaceOrientation);
}
-(BOOL)shouldAutorotate{
    return YES;
}

-(NSUInteger)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskLandscape;
}

#pragma mark- Helpers
-(void) launchSettingScreen {
    DebugLog(@"");
    SettingsViewController *settingsView = [[SettingsViewController alloc] initWithNibName:@"SettingsViewController" bundle:nil];
    settingsView.modalPresentationStyle = UIModalPresentationPageSheet;
//    settingsView.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    
    if([self respondsToSelector:@selector(presentModalViewController:animated:)])
        [self presentModalViewController:settingsView animated:YES];
    else
        [self presentViewController:settingsView animated:YES completion:nil];
    
    [settingsView.view.superview setAutoresizingMask:(UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth)];
    [settingsView.view.superview setFrame:CGRectMake(128, 177, 768, 414)]; //(128, 177, 768, 414)
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
    if([btn tag] == TAG_TIGGLY_NEWS_BTN){
        NSString *urlString = @"http://tiggly.com/";
        //Create a URL object.
        NSURL *url = [NSURL URLWithString:urlString];
        //URL Requst Object
        NSURLRequest *requestObj = [NSURLRequest requestWithURL:url];
        
        [webView loadRequest:requestObj];
        
//         viewForWeb.frame = CGRectMake(0, 0, 1024, 768);

        [UIView animateWithDuration:0.5
                         animations:^(void){
                             viewForWeb.frame = CGRectMake(0, 0, 1024, 768);
                         }
                         completion:^(BOOL finished){
                             
                         }];

    }
    if([btn tag] == TAG_CLOSE_WEB_BTN){
        [UIView animateWithDuration:0.5
                         animations:^(void){
                             viewForWeb.frame = CGRectMake(0, 768, 1024, 768);
                         }
                         completion:^(BOOL finished){
                             
                         }];
    }
    if([btn tag] == TAG_LETTER_TAB_BTN){
        tabBodyTEXT.frame =CGRectMake(tabBodyTEXT.frame.origin.x, tabBodyTEXT.frame.origin.y, tabBodyTEXT.frame.size.width, 350);
        [self setInfoForLetterTab];
        tabLetterMotarBTN.hidden =NO;
        tabLetterLanguageBTN.hidden =NO;
        tabLetterSpatialBTN.hidden =NO;
        
    }
    if([btn tag] == TAG_PLAY_TAB_BTN){
        tabBodyTEXT.frame =CGRectMake(tabBodyTEXT.frame.origin.x, tabBodyTEXT.frame.origin.y, tabBodyTEXT.frame.size.width, 430);
        [self setInfoForPlayTab];
        tabLetterMotarBTN.hidden =YES;
        tabLetterLanguageBTN.hidden =YES;
        tabLetterSpatialBTN.hidden =YES;

    }
    if([btn tag] == TAG_TIP_TAB_BTN){
        tabBodyTEXT.frame =CGRectMake(tabBodyTEXT.frame.origin.x, tabBodyTEXT.frame.origin.y, tabBodyTEXT.frame.size.width, 430);
        [self setInfoForTipTab];
        tabLetterMotarBTN.hidden =YES;
        tabLetterLanguageBTN.hidden =YES;
        tabLetterSpatialBTN.hidden =YES;

    }
    if([btn tag] == TAG_PHILOSOPHY_TAB_BTN){
        tabBodyTEXT.frame =CGRectMake(tabBodyTEXT.frame.origin.x, tabBodyTEXT.frame.origin.y, tabBodyTEXT.frame.size.width, 430);
        [self setInfoForPhilosophyTab];
        tabLetterMotarBTN.hidden =YES;
        tabLetterLanguageBTN.hidden =YES;
        tabLetterSpatialBTN.hidden =YES;
    }
    if([btn tag] == TAG_LETTER_MOTAR_BTN){
        [self showValidationError:@"Grabbing and holding the shapes, moving them, and placing them on the screen help your child enhance their fine motor skills. " title:@"Motor skills"];
    }
    if([btn tag] == TAG_LETTER_LANGUAGE_BTN){
        [self showValidationError:@"Children will hear the names of animals, fruits, and objects as they appear on screen and greet your child. They will also practice storytelling and producing language as part of their play" title:@"Language Development"];

    }
    if([btn tag] == TAG_LETTER_SPATIAL_BTN){
        [self showValidationError:@"Tiggly Safari encourages children to recognize and match basic shapes— circles, squares, triangles, and stars in various orientations. By manipulating real shapes, and grabbing, rotating, moving, and placing them on a target, children learn about spatial relations and transformations. Finally, by turning simple shapes into animals, they practice their ability to create complex images" title:@"Spatial Thinking"];
    }

    
}

-(void)setInfoForLetterTab {
    DebugLog(@"");
    tabTitleIMGVIEW.image = [UIImage imageNamed:@"tab_letter.png"];
    tabHeadingTEXT.text = @"";
    tabBodyTEXT.text = @"Dear Parent,\n\n  So glad you found us! At Tiggly, we respect the challenges of modern-day parenthood. It is a tough job! We founded Tiggly because we wanted to help parents introduce their children to the digital world in an easy yet educational way. Just like you, we are deeply invested in your child’s early development, and we believe we can create the best learning experiences for them by combining physical and digital play. Read more about our learning philosophy.\n\nAbout Tiggly Safari:\nI remember the first time I visited the zoo as a little girl and my sense of awe and wonder as I saw exotic animals from each corner of the globe, ones that I never even knew existed. When we were developing our first app to work with Tiggly Shapes, I knew there was no better place to start than by trying to capture the sense of wonder that the animal kingdom holds for children. Inspired by the artwork of Chaley Harper and Ed Emberley, we envisioned a farm, a jungle, and an ocean full of animals – all made from simple shapes awaiting your child as they enter the world of Tiggly!\n\n  In Tiggly Safari, your children use Tiggly Shapes to construct a series of fun and friendly animals – cows, turkeys, lions, owls, crabs, and many more! We designed each level in the game based on what we know about children’s spatial cognition development.\n\n  In the first level, children simply match shapes with what they see on the screen and create simple animals out of single shapes. As the levels proceed, children are challenged to create more complex animals with combination of shapes, recognize and match basic shapes in various orientations, and practice their hand-eye coordination by catching moving objects— all while being amazed by the cute animals of their creation!\nOur goal is to produce learning toys and apps that you love to share with your children, and we hope that this is the start of a long relationship.\n\nWarm regards,\n\nAzadeh Jamalian\nChief Learning Officer\nTiggly\n";
}
-(void)setInfoForPlayTab {
    
    tabTitleIMGVIEW.image = [UIImage imageNamed:@"tab_play.png"];
    tabHeadingTEXT.text = @"How to play:";
    tabBodyTEXT.text = @"Play with shapes:\n	•	It’s simple! Match your Tiggly Shape with what you see on the screen. See a circle? Tap the screen with your circle.\n	•	Take the shape off the screen to see what happens next.\n\nPlay without shapes:\n	•	Drag shapes from the tray and watch what happens.";
}
-(void)setInfoForTipTab {
    tabTitleIMGVIEW.image = [UIImage imageNamed:@"tab_learning.png"];
    tabHeadingTEXT.text = @"LEARNING TIPS";
    tabBodyTEXT.text = @"Tips to enhance your child’s play experience\nHere are few tips for you to support your child’s learning from the app:\n	-	Encourage them to repeat after the narrator as it names the objects and animals.\n	-	Challenge them by asking to guess what animal they are constructing.\n	-	Have two kids at home? Encourage them to share the shapes and collaborate on their creations!\n\nTips to enhance your child’s learning experience outside the app\nYour child’s education does not begin and end in one setting. Learning is fluid; the most effective learning experiences are the ones that transfer from one setting to another. Here is a list of suggested activities for you to help your little ones develop their spatial thinking and language skills outside the app. You will help them take what they learn in the app and apply the lessons to the outside world!\n\n	-	Talk with your child about shapes, spatial relations, and spatial transformations. Research shows that parents who use spatial words in their vocabulary have children with better spatial skills. Include words such as name of shapes (square, circle, triangle, star, rectangle, trapezoid, etc.), relational words (up, down, below, above, left, right, beside), and spatial	-transformation verbs (rotate, flip, slide) when talking to your child.\n	-	Encourage your child to see shapes around them. When you notice a circular object around your home or a triangle in a book, point that out to your child.\n	-	Help your child construct complex objects using simple shapes. Why not make paper cutouts of shapes and encourage your child to create their own animals or objects? Send us pictures, we’d love to include them in our next Safari update!\n	-	Solve puzzles together.\n	-	Have fun with the shapes beyond the tablet… We’ve seen many kids building towers with them or wear them as bracelets! \n";
    
}
-(void)setInfoForPhilosophyTab {
    tabTitleIMGVIEW.image = [UIImage imageNamed:@"tab_learning_philosophy.png"];
    tabHeadingTEXT.text = @"Tiggly’s Learning Philosophy:";
    tabBodyTEXT.text = @"At Tiggly, we design toys that interact with learning apps because we believe there is a powerful learning opportunity in the combination of physical and digital play.\n\nDigital play alone has many benefits on its own right: a digital platform can adapt to a child’s skills and knowledge; it can provide feedback, guidance, and structure targeted to the child’s needs; it can track a child’s performance and assess his or her development by providing instant reports of a child’s learning progression to their parents and teachers; and it can be sometimes even more fun to play with than a toy car or a teddy bear!\n\nHowever, what’s missing in a digital setting is the valuable interaction that comes with playing with real objects: grabbing objects in hand, holding them, placing them on a target, and otherwise manipulating them. Seventy years of research on children’s development -- from 20th century education and psychology revolutionaries like Maria Montessori and Jean Piaget to today’s cognitive scientists -- tells us that physical play is extremely important for proper childhood development. What’s obvious is that playing with objects aids the development of motor skills and improves hand-eye coordination. What’s not as obvious is that physical play also helps cognition and memory.\n\nHolding an object in hand stabilizes your child’s head and focuses his attention while he visually and manually explores the object. Have you ever noticed that a 2-year-old constantly looks all around , moving his head in all directions? But as soon as he’s engaged with a toy, all his attention is focused on that toy. Attention to objects is a positive thing, because when children focus on something, there is a better chance for them to learn its name and develop their language skills. But it’s not just about learning names — it’s about learning a whole lot about the world around them. Attending to objects, visually and manually exploring them, acting on them, and inspecting the results of our actions around us is the basis of all learning.\n\n   What’s important in learning is to engage all our senses. Take a circle as an example. When your child looks at a circle on a screen, she can see the shape. But when she grabs and holds a circular toy in hand, she also touches and feels the roundness of it. She notices that she can roll her circular toy but not her triangular one. She discovers that the circle looks the same when she spins it, but her triangle looks different as she rotates it. Manual interaction with physical blocks helps her understand that not only do a circle and triangle look different but they also have different properties and can be manipulated in different ways. It’s an early “aha moment”: “So that’s why wheels are round and not triangular!”\n\n        However, as great as a triangle or a circle block is, it can never speak to your child. Your child can play with a block for hours and hours, explore it in all directions and manipulate it in many ways, but may never know the name of its shape. It may take even longer for him to realize if he puts together two triangles he can make a square, or that he can draw a cow with two squares!\n\n            That’s where Tiggly’s educator-designed apps come in.\n\n           In our digital world, the sky is the limit for imagination. A child can catch stars or stamp circles in an ocean to make a seahorse or a dolphin. She can put together a circle and two squares to draw an elephant in a mysterious jungle. The triangle on the screen may jokingly say to her, “I’m a triangle! I bet you’re not!”\n\n                And that’s why we think there is an immense educational opportunity when physical play and digital play come together. Your child gets all the benefits of interacting with real objects while their imagination is stimulated in a digital context. They receive appropriate guidance in their learning and are given new challenges as their understanding advances. In this way, Tiggly is reimagining play— by bridging the gap between established educational standards and the new digital frontier.";
    
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

//                            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Tiggly" message:@"Do you want to try again?" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
//                              
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

#pragma mark- Pinterest Integration
-(void)signInWithPinterest:(id)sender
{
    _pinterest = [[Pinterest alloc] initWithClientId:@"1432658"];
    
    [_pinterest createPinWithImageURL:[NSURL URLWithString:@"http://placekitten.com/500/400"]
                            sourceURL:[NSURL URLWithString:@"http://placekitten.com"]
                          description:@"Pinning from Tiggly Application"];

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

#pragma mark - Hide Status Bar
- (BOOL)prefersStatusBarHidden
{
    return YES;
}

#pragma mark Webview Delegate
-(void)webViewDidStartLoad:(UIWebView *)webView
{
    [activityIndicator startAnimating];
}
-(void)webViewDidFinishLoad:(UIWebView *)webView
{
    [activityIndicator stopAnimating];
}
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    [activityIndicator stopAnimating];
}

@end
