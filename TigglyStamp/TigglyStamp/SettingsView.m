//
//  SettingsView.m
//  TigglyStamp
//
//  Created by Sachin Patil on 24/09/13.
//  Copyright (c) 2013 cuelogic. All rights reserved.
//

#import "SettingsView.h"
#import "TConstant.h"
#import "TigglyStampUtils.h"

#ifdef GOOGLE_ANALYTICS_START
#import "GAITrackedViewController.h"
#import "GAI.h"
#import "GAIDictionaryBuilder.h"
#import "GAIFields.h"
#else
#endif
@implementation SettingsView

UISwitch *swtchMusic;
UISwitch *swtchGallery;
UISwitch *swtchShape;
UISwitch *swtchArt;
UIView *langView;
UITableView *tblView;
NSArray *langArr;
BOOL isLanguageScreenDisplayed;
UIButton *btnClose;

@synthesize delegate;

#pragma mark -
#pragma mark =======================================
#pragma mark Init
#pragma mark =======================================

- (id)initWithFrame:(CGRect)frame {
    DebugLog(@"");
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorWithRed:45.0f/255.0f green:116.0f/255.0f blue:210.0f/255.0f alpha:1.0f];
        self.layer.cornerRadius = 20.0f;
        self.userInteractionEnabled = YES;
        
        btnClose = [UIButton buttonWithType:UIButtonTypeCustom];
        [btnClose setBackgroundImage:[UIImage imageNamed:@"close_btn.png"] forState:UIControlStateNormal];
        [btnClose setBackgroundImage:[UIImage imageNamed:@"close_btn.png"] forState:UIControlStateSelected];
        [btnClose addTarget:self action:@selector(actionClose)forControlEvents:UIControlEventTouchUpInside];
        btnClose.frame = CGRectMake(730, 0, 70, 70);
        [self addSubview:btnClose];
        
        UILabel *lblLang = [[UILabel alloc] initWithFrame:CGRectMake(80, 75, 345, 32)];
        lblLang.textAlignment = UITextAlignmentRight;
        lblLang.backgroundColor = [UIColor clearColor];
        lblLang.text = @"Language";
        lblLang.textColor = [UIColor whiteColor];
        lblLang.font = [UIFont fontWithName:APP_FONT_BOLD size:28.0f];
        [self addSubview:lblLang];
        
        UIButton *btnLang = [UIButton buttonWithType:UIButtonTypeCustom];
        [btnLang setBackgroundImage:[UIImage imageNamed:@"btnNext.png"] forState:UIControlStateNormal];
        [btnLang setBackgroundImage:[UIImage imageNamed:@"btnNext.png"] forState:UIControlStateSelected];
        [btnLang addTarget:self action:@selector(actionLanguage)forControlEvents:UIControlEventTouchUpInside];
        btnLang.frame = CGRectMake(485, 65, 50, 50);
        [self addSubview:btnLang];
        
        UILabel *lblMusic= [[UILabel alloc] initWithFrame:CGRectMake(80, 130, 345, 32)];
        lblMusic.textAlignment = UITextAlignmentRight;
        lblMusic.backgroundColor = [UIColor clearColor];
        lblMusic.text = @"Music";
        lblMusic.textColor = [UIColor whiteColor];
        lblMusic.font = [UIFont fontWithName:APP_FONT_BOLD size:28.0f];
        [self addSubview:lblMusic];
        
        swtchMusic = [[UISwitch alloc] initWithFrame:CGRectMake(485,130,79,27)];
        [swtchMusic addTarget:self action:@selector(actionMusic) forControlEvents:UIControlEventValueChanged];
        [self addSubview:swtchMusic];
        
        UILabel *lblSaveArt = [[UILabel alloc] initWithFrame:CGRectMake(80, 185, 345, 32)];
        lblSaveArt.textAlignment = UITextAlignmentRight;
        lblSaveArt.backgroundColor = [UIColor clearColor];
        lblSaveArt.text = @"Save Art";
        lblSaveArt.textColor = [UIColor whiteColor];
        lblSaveArt.font = [UIFont fontWithName:APP_FONT_BOLD size:28.0f];
        [self addSubview:lblSaveArt];
        
        swtchArt = [[UISwitch alloc] initWithFrame:CGRectMake(485,185,79,27)];
        [swtchArt addTarget:self action:@selector(actionArt) forControlEvents:UIControlEventValueChanged];
        [self addSubview:swtchArt];
        
        UILabel *lblShape = [[UILabel alloc] initWithFrame:CGRectMake(80, 240, 345, 32)];
        lblShape.textAlignment = UITextAlignmentRight;
        lblShape.backgroundColor = [UIColor clearColor];
        lblShape.text = @"Play with Tiggly Shapes";
        lblShape.textColor = [UIColor whiteColor];
        lblShape.font = [UIFont fontWithName:APP_FONT_BOLD size:28.0f];
        [self addSubview:lblShape];
        
        swtchShape = [[UISwitch alloc] initWithFrame:CGRectMake(485,240,79,27)];
        [swtchShape addTarget:self action:@selector(actionShape) forControlEvents:UIControlEventValueChanged];
        [self addSubview:swtchShape];
        
        UILabel *lblGallery = [[UILabel alloc] initWithFrame:CGRectMake(80, 295, 345, 32)];
        lblGallery.textAlignment = UITextAlignmentRight;
        lblGallery.backgroundColor = [UIColor clearColor];
        lblGallery.text = @"Limit gallery to 60 items";
        lblGallery.textColor = [UIColor whiteColor];
        lblGallery.font = [UIFont fontWithName:APP_FONT_BOLD size:28.0f];
        [self addSubview:lblGallery];
        
        swtchGallery = [[UISwitch alloc] initWithFrame:CGRectMake(485,295,79,27)];
        [swtchGallery addTarget:self action:@selector(actionGallery) forControlEvents:UIControlEventValueChanged];
        [self addSubview:swtchGallery];
  
        if(![[TigglyStampUtils sharedInstance] isAppUnlockedForShapes]) {
                UILabel *lblBuyShapes = [[UILabel alloc] initWithFrame:CGRectMake(80, 350, 345, 32)];
                lblBuyShapes.textAlignment = UITextAlignmentRight;
                lblBuyShapes.backgroundColor = [UIColor clearColor];
                lblBuyShapes.text = @"Buy Shapes";
                lblBuyShapes.textColor = [UIColor whiteColor];
                lblBuyShapes.font = [UIFont fontWithName:APP_FONT_BOLD size:28.0f];
                [self addSubview:lblBuyShapes];
        

                UIButton *btnBuyShapes = [UIButton buttonWithType:UIButtonTypeCustom];
                [btnBuyShapes setBackgroundImage:[UIImage imageNamed:@"btnNext.png"] forState:UIControlStateNormal];
                [btnBuyShapes setBackgroundImage:[UIImage imageNamed:@"btnNext.png"] forState:UIControlStateSelected];
                [btnBuyShapes addTarget:self action:@selector(actionBuyShapes)forControlEvents:UIControlEventTouchUpInside];
                btnBuyShapes.frame = CGRectMake(485, 340, 50, 50);
                [self addSubview:btnBuyShapes];
        }
        
        if ([[[NSUserDefaults standardUserDefaults] valueForKey:MUSIC] isEqualToString:@"yes"]) {
            [swtchMusic setOn:YES];
        }else{
            [swtchMusic setOn:NO];
        }
        
        if ([[[NSUserDefaults standardUserDefaults] valueForKey:SAVE_ART] isEqualToString:@"yes"]) {
            [swtchArt setOn:YES];
        }else{
            [swtchArt setOn:NO];
        }
        
        if ([[TigglyStampUtils sharedInstance] getShapeMode] == YES) {
            [swtchShape setOn:YES];
        }else{
            [swtchShape setOn:NO];
        }
        
        if ([[[NSUserDefaults standardUserDefaults] valueForKey:LIMIT_GALLERY] isEqualToString:@"yes"]) {
            [swtchGallery setOn:YES];
        }else{
            [swtchGallery setOn:NO];
        }
        
    }
    return self;
}

#pragma mark -
#pragma mark =======================================
#pragma mark Action Handling
#pragma mark =======================================

-(void) actionClose {
    DebugLog(@"");

    [self removeLanguageView];
    [self.delegate settingViewOnCloseButtonClick:self];
}

-(void) actionBuyShapes{
    DebugLog(@"");
    NSString* launchUrl = @"http://tiggly.myshopify.com";
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString: launchUrl]];
}

-(void)actionLanguage {
    DebugLog(@"");
    
    if(isLanguageScreenDisplayed){
        [self removeLanguageView];
    }else{
        [self launchLanguageView];
    }
    
    [btnClose setBackgroundImage:[UIImage imageNamed:@"green_check.png"] forState:UIControlStateNormal];
    [btnClose setBackgroundImage:[UIImage imageNamed:@"green_check.png"] forState:UIControlStateSelected];
}

-(void)actionGallery {
    DebugLog(@"");
    
    if ([swtchGallery isOn] == YES) {
        [[NSUserDefaults standardUserDefaults] setValue:@"yes" forKey:LIMIT_GALLERY];
    }else{
        [[NSUserDefaults standardUserDefaults] setValue:@"no" forKey:LIMIT_GALLERY];
    }
    
    [btnClose setBackgroundImage:[UIImage imageNamed:@"green_check.png"] forState:UIControlStateNormal];
    [btnClose setBackgroundImage:[UIImage imageNamed:@"green_check.png"] forState:UIControlStateSelected];
}

-(void)actionShape {
    DebugLog(@"");
    if ([swtchShape isOn] == YES) {
        if(![[TigglyStampUtils sharedInstance] isAppUnlockedForShapes]) {
            [self.delegate settingViewOnShapeSwitchClick:self];
            [self removeFromSuperview];
        }else{
            [[TigglyStampUtils sharedInstance] setShapeMode:YES];
        }
    }else{
        [[TigglyStampUtils sharedInstance] setShapeMode:NO];
    }
    
    [btnClose setBackgroundImage:[UIImage imageNamed:@"green_check.png"] forState:UIControlStateNormal];
    [btnClose setBackgroundImage:[UIImage imageNamed:@"green_check.png"] forState:UIControlStateSelected];
}

-(void)actionMusic {
    DebugLog(@"");
    
    if ([swtchMusic isOn] == YES) {
        [[NSUserDefaults standardUserDefaults] setValue:@"yes" forKey:MUSIC];
    }else{
        [[NSUserDefaults standardUserDefaults] setValue:@"no" forKey:MUSIC];
    }
    
    [btnClose setBackgroundImage:[UIImage imageNamed:@"green_check.png"] forState:UIControlStateNormal];
    [btnClose setBackgroundImage:[UIImage imageNamed:@"green_check.png"] forState:UIControlStateSelected];
}

-(void) actionArt{
    DebugLog(@"");
    if ([swtchArt isOn] == YES) {
        [[NSUserDefaults standardUserDefaults] setValue:@"yes" forKey:SAVE_ART];
    }else{
        [[NSUserDefaults standardUserDefaults] setValue:@"no" forKey:SAVE_ART];
    }
    
    [btnClose setBackgroundImage:[UIImage imageNamed:@"green_check.png"] forState:UIControlStateNormal];
    [btnClose setBackgroundImage:[UIImage imageNamed:@"green_check.png"] forState:UIControlStateSelected];
}

-(void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    DebugLog(@"");
    
    [self removeLanguageView];
}

#pragma mark -
#pragma mark =======================================
#pragma mark Helpers
#pragma mark =======================================

-(void) removeLanguageView {
    DebugLog(@"");
    isLanguageScreenDisplayed = NO;
    
    if(langView != nil){
        [langView removeFromSuperview];
        langView = nil;
    }
    
    
}


-(void) launchLanguageView {
    DebugLog(@"");
     isLanguageScreenDisplayed = YES;
    
    langArr =[[NSArray alloc] initWithObjects:@"English",@"Portuguese",@"Russian",@"Spanish",@"French",@"German",@"Italian", nil];
    
    if(langView != nil){
        [langView removeFromSuperview];
        langView = nil;
    }
    
   
    langView = [[UIView alloc] initWithFrame:CGRectMake(330, 115, 275, 275)];
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
#ifdef GOOGLE_ANALYTICS_START
    NSMutableDictionary *event =
    [[GAIDictionaryBuilder createEventWithCategory:@"Language"
                                            action:@"Language Selected"
                                             label:[langArr objectAtIndex:indexPath.row]
                                             value:nil] build];
    [[GAI sharedInstance].defaultTracker send:event];
    [[GAI sharedInstance] dispatch];
#else
#endif

    
    
    [[TigglyStampUtils sharedInstance] setCurrentLanguage:[langArr objectAtIndex:indexPath.row]];

    [self removeLanguageView];
    
}

@end
