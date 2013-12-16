//
//  GestureConfirmationView.m
//  TigglyStamp
//
//  Created by Sachin Patil on 24/09/13.
//  Copyright (c) 2013 cuelogic. All rights reserved.
//

#import "GestureConfirmationView.h"
#import "TConstant.h"
#import "TigglyStampUtils.h"

#ifdef GOOGLE_ANALYTICS_START
#import "GAITrackedViewController.h"
#import "GAI.h"
#import "GAIDictionaryBuilder.h"
#import "GAIFields.h"
#else
#endif

@implementation GestureConfirmationView {
    
    BOOL _isLanguageScreenDisplayed;
    UIView *langView;
    NSArray *langArr;
    UILabel *lblLang;
    UIButton *btnLang;
    
}
@synthesize swipeTxtCnt;

@synthesize delegate;

-(void)_initAllCommonDatawithFrame:(CGRect)frame {
    self.backgroundColor = [UIColor clearColor];
    self.userInteractionEnabled = YES;
    
    
    UIImageView *bkgImage = [[UIImageView alloc] initWithFrame:frame];
    bkgImage.image = [UIImage imageNamed:@"parent_gesture_black_bg.png"];
    bkgImage.layer.opacity = 0.5;
    [self addSubview:bkgImage];
    bkgImage.userInteractionEnabled  =YES;
    
    UIView *confirmationView = [[UIImageView alloc] initWithFrame:CGRectMake(230, 240, 570, 285)];
    confirmationView.backgroundColor = [UIColor colorWithRed:98.0f/255.0f green:173.0f/255.0f blue:1.0f/255.0f alpha:1.0f];
    [self addSubview:confirmationView];
    confirmationView.userInteractionEnabled  =YES;
    confirmationView.layer.cornerRadius = 20.0f;
    confirmationView.layer.masksToBounds = YES;
    
    UIButton *btnClose = [UIButton buttonWithType:UIButtonTypeCustom];
    [btnClose setBackgroundImage:[UIImage imageNamed:@"cross.png"] forState:UIControlStateNormal];
    [btnClose setBackgroundImage:[UIImage imageNamed:@"cross.png"] forState:UIControlStateSelected];
    [btnClose addTarget:self action:@selector(actionClose)forControlEvents:UIControlEventTouchUpInside];
    btnClose.frame = CGRectMake(500, 10, 70, 70);
    [confirmationView addSubview:btnClose];
    
    
    txtView = [[UITextView alloc] initWithFrame:CGRectMake(90, 80, 415, 160)];
    txtView.textAlignment = UITextAlignmentCenter;
    txtView.userInteractionEnabled = NO;
    txtView.font = [UIFont fontWithName:APP_FONT_BOLD size:35.0f];
    txtView.backgroundColor =[UIColor clearColor];
    [confirmationView addSubview:txtView];
    txtView.editable = NO;
    txtView.scrollEnabled = NO;
    
    swipeGesture = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swippedforConfirmation:)];
    [swipeGesture setNumberOfTouchesRequired:2];
    [self addGestureRecognizer:swipeGesture];
    
    [self showTextView];
}

-(void)_initLoadLanguageOption:(CGRect)frame  {
    DebugLog(@"");
    UIImageView *bkgImage = [[UIImageView alloc] initWithFrame:frame];
    bkgImage.image = [UIImage imageNamed:@"parent_gesture_black_bg.png"];
    bkgImage.layer.opacity = 0.5;
    [self addSubview:bkgImage];
    bkgImage.userInteractionEnabled  =YES;
    
    UIView *confirmationView = [[UIImageView alloc] initWithFrame:CGRectMake(230, 240, 570, 285)];
    confirmationView.backgroundColor = [UIColor colorWithRed:98.0f/255.0f green:173.0f/255.0f blue:1.0f/255.0f alpha:1.0f];
    [self addSubview:confirmationView];
    confirmationView.userInteractionEnabled  =YES;
    confirmationView.layer.cornerRadius = 20.0f;
    confirmationView.layer.masksToBounds = YES;
    
    UIButton *btnClose = [UIButton buttonWithType:UIButtonTypeCustom];
    [btnClose setBackgroundImage:[UIImage imageNamed:@"cross.png"] forState:UIControlStateNormal];
    [btnClose setBackgroundImage:[UIImage imageNamed:@"cross.png"] forState:UIControlStateSelected];
    [btnClose addTarget:self action:@selector(actionClose)forControlEvents:UIControlEventTouchUpInside];
    btnClose.frame = CGRectMake(500, 10, 70, 70);
    [confirmationView addSubview:btnClose];
    
    
    txtView = [[UITextView alloc] initWithFrame:CGRectMake(90, 80, 415, 160)];
    txtView.textAlignment = UITextAlignmentCenter;
    txtView.userInteractionEnabled = NO;
    txtView.font = [UIFont fontWithName:APP_FONT_BOLD size:35.0f];
    txtView.backgroundColor =[UIColor clearColor];
    [confirmationView addSubview:txtView];
    txtView.editable = NO;
    txtView.scrollEnabled = NO;
    
    swipeGesture = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swippedforConfirmation:)];
    [swipeGesture setNumberOfTouchesRequired:2];
    [self addGestureRecognizer:swipeGesture];
    
    [self showTextView];
    
    
    
    lblLang = [[UILabel alloc] initWithFrame:CGRectMake(230, 260, 100, 32)];
    lblLang.textAlignment = UITextAlignmentRight;
    lblLang.adjustsFontSizeToFitWidth = YES;
    lblLang.backgroundColor = [UIColor clearColor];
    lblLang.textColor = [UIColor whiteColor];
    [self addSubview:lblLang];
    
    lblLang.text = [[TigglyStampUtils sharedInstance] getLocalisedStringForKey:@"kLanguage"];
    lblLang.font = [UIFont fontWithName:APP_FONT_BOLD size:28.0f];
    
    
    
    btnLang = [UIButton buttonWithType:UIButtonTypeCustom];
    [btnLang setBackgroundImage:[UIImage imageNamed:@"btnNext.png"] forState:UIControlStateNormal];
    [btnLang setBackgroundImage:[UIImage imageNamed:@"btnNext.png"] forState:UIControlStateSelected];
    [btnLang addTarget:self action:@selector(actionLanguage)forControlEvents:UIControlEventTouchUpInside];
    btnLang.frame = CGRectMake(340, 256, 50, 50);
    [self addSubview:btnLang];
    
    
}

- (id)initWithFrame:(CGRect)frame {
    DebugLog(@"");
    self = [super initWithFrame:frame];
    if (self) {
        
        [self _initAllCommonDatawithFrame:frame];
        
    }
    return self;
}



- (id)initLoadLanguageOptionWithFrame:(CGRect)frame {
    DebugLog(@"");
    self = [super initWithFrame:frame];
    if (self) {
        
        [self _initLoadLanguageOption:frame];
        
        
    }
    return self;
}

-(void) showTextView{
    DebugLog(@"");
    
    swipeTxtCnt = arc4random()%4;
    
    NSString *lang = [[TigglyStampUtils sharedInstance] getCurrentLanguage];
    
    float fSize = 30.0;
    if ([lang isEqualToString:@"English"] ) {
        fSize = 40.0;
    }
    
    txtView.font = [UIFont fontWithName:APP_FONT_BOLD size:fSize];
    txtView.textColor = [UIColor whiteColor];
    
    switch (swipeTxtCnt)   {
        case 0:
            [txtView setText:[[TigglyStampUtils sharedInstance] getLocalisedStringForKey:@"kSwipeInstructionRight"]];
            [swipeGesture setDirection: UISwipeGestureRecognizerDirectionRight];
            [swipeGesture setNumberOfTouchesRequired: 2];
            break;
        case 1:
            [txtView setText:[[TigglyStampUtils sharedInstance] getLocalisedStringForKey:@"kSwipeInstructionLeft"]];
            [swipeGesture setDirection: UISwipeGestureRecognizerDirectionLeft];
            [swipeGesture setNumberOfTouchesRequired: 2];
            break;
        case 2:
            [txtView setText:[[TigglyStampUtils sharedInstance] getLocalisedStringForKey:@"kSwipeInstructionUp"]];
            [swipeGesture setDirection: UISwipeGestureRecognizerDirectionUp];
            [swipeGesture setNumberOfTouchesRequired: 2];
            break;
        case 3:
            [txtView setText:[[TigglyStampUtils sharedInstance] getLocalisedStringForKey:@"kSwipeInstructionDown"]];
            [swipeGesture setDirection: UISwipeGestureRecognizerDirectionDown];
            [swipeGesture setNumberOfTouchesRequired: 2];
            break;
       
        default:
            break;
    }
}

-(void)swippedforConfirmation:(UISwipeGestureRecognizer *)sender
{
    DebugLog(@"");
    
    [self.delegate gestureViewOnGestureConfirmed:self];
    [self removeFromSuperview];
    [self removeGestureRecognizer:swipeGesture];
}

-(void)swippedforConfirmationView
{
    
}

-(void) actionClose{
    DebugLog(@"");
    [self.delegate gestureViewOnCancel:self];
    [self removeGestureRecognizer:swipeGesture];
    [self removeFromSuperview];
}

#pragma mark -
#pragma mark ==============================
#pragma mark Helper Classes
#pragma mark ==============================

-(void)actionLanguage {
    DebugLog(@"");
    
    if(_isLanguageScreenDisplayed){
        [self removeLanguageView];
    }else{
        [self launchLanguageView];
    }
    
}


-(void) removeLanguageView {
    DebugLog(@"");
    _isLanguageScreenDisplayed = NO;
    
    if(langView != nil){
        [langView removeFromSuperview];
        langView = nil;
    }
    
    
}


-(void) launchLanguageView {
    DebugLog(@"");
    _isLanguageScreenDisplayed = YES;
    
    langArr =[[NSArray alloc] initWithObjects:@"English",@"Portuguese",@"Russian",@"Spanish",@"French",@"German",@"Italian", nil];
    
    if(langView != nil){
        [langView removeFromSuperview];
        langView = nil;
    }
    
    
    langView = [[UIView alloc] initWithFrame:CGRectMake(230, 310, 275, 275)];
    langView.layer.cornerRadius = 20.0f;
    langView.backgroundColor = [UIColor colorWithRed:240.0f/255.0f green:210.0f/255.0f blue:50.0f/255.0f alpha:1.0];
    [self addSubview:langView];
    
    tblView = [[UITableView alloc] initWithFrame:CGRectMake(20, 20, 235, 235)];
    tblView.separatorColor = [UIColor lightGrayColor];
    tblView.backgroundColor = [UIColor whiteColor];
    tblView.delegate = self;
    tblView.dataSource = self;
    tblView.layer.cornerRadius = 20.0f;
    [langView addSubview:tblView];
    
    
    NSString *str = [[TigglyStampUtils sharedInstance] getCurrentLanguage];
    int count=0;
    for(int i=0; i< langArr.count;i++){
        NSString *lang = [langArr objectAtIndex:i];
        if([str isEqualToString:lang]) {
            count = i;
        }
    }
    
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:count inSection:0];
    [tblView selectRowAtIndexPath:indexPath animated:NO scrollPosition: UITableViewScrollPositionNone];
}

-(void)setAllLabelsToLanguage:(NSString*)lang{
    DebugLog(@"");
    
    lblLang.text = [[TigglyStampUtils sharedInstance] getLocalisedStringForKey:@"kLanguage"];
    lblLang.font = [UIFont fontWithName:APP_FONT_BOLD size:28.0f];
    
    [self showTextView];
    
    
}


#pragma mark -
#pragma mark =======================================
#pragma mark TableView Delegates
#pragma mark =======================================

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    DebugLog(@"");
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    DebugLog(@"");
    
    return langArr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 40.0f;
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    //DebugLog(@"");
    NSString *reuseIdentifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
    
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc]  initWithStyle: UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
    }
    
    cell.textLabel.text = [langArr objectAtIndex:indexPath.row];
    cell.textLabel.textAlignment = UITextAlignmentCenter;
    cell.textLabel.font = [UIFont fontWithName:APP_FONT_BOLD size:20.0f];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    DebugLog(@"");
    
    NSMutableDictionary *event =
    [[GAIDictionaryBuilder createEventWithCategory:@"Language"
                                            action:@"Language Selected"
                                             label:[langArr objectAtIndex:indexPath.row]
                                             value:nil] build];
    [[GAI sharedInstance].defaultTracker send:event];
    [[GAI sharedInstance] dispatch];
    
    [[TigglyStampUtils sharedInstance] setCurrentLanguage:[langArr objectAtIndex:indexPath.row]];
    
    [self removeLanguageView];
    
    [self setAllLabelsToLanguage:[langArr objectAtIndex:indexPath.row]];
    [self.delegate gestureViewOnChangeLanguage];
    
}




@end
