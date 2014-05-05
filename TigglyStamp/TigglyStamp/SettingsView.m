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
#import "LanguageCustomCell.h"

#ifdef GOOGLE_ANALYTICS_START
#import "GAITrackedViewController.h"
#import "GAI.h"
#import "GAIDictionaryBuilder.h"
#import "GAIFields.h"
#else
#endif

#define TAG_LABEL_DATE_FORMAT 12
#define TAG_BTN_DATE_FORMAT_PREVIEW 13

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

UILabel *lblLang;
UILabel *lblMusic;
UILabel *lblSaveArt;
UILabel *lblShape;
UILabel *lblGallery;
UILabel *lblBuyShapes;
UILabel *lblDate;
UILabel *lblLangOneVal;
UILabel *lblDateVal;

OptionMenuType menuType;

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
        
        float fontSize = 0.0;
        if([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"English"]){
            fontSize = 28.0f;
        }else{
            fontSize = 20.0f;
        }
        
        btnClose = [UIButton buttonWithType:UIButtonTypeCustom];
        [btnClose setBackgroundImage:[UIImage imageNamed:@"close_btn.png"] forState:UIControlStateNormal];
        [btnClose setBackgroundImage:[UIImage imageNamed:@"close_btn.png"] forState:UIControlStateSelected];
        [btnClose addTarget:self action:@selector(actionClose)forControlEvents:UIControlEventTouchUpInside];
        btnClose.frame = CGRectMake(730, 0, 70, 70);
        [self addSubview:btnClose];
        
        lblLang = [[UILabel alloc] initWithFrame:CGRectMake(80, 75, 345, 32)];
        lblLang.textAlignment = UITextAlignmentRight;
        lblLang.backgroundColor = [UIColor clearColor];
        lblLang.text = [[TigglyStampUtils sharedInstance] getLocalisedStringForKey:@"kLanguage"];
        lblLang.textColor = [UIColor whiteColor];
        lblLang.font = [UIFont fontWithName:APP_FONT_BOLD size:fontSize];
        [self addSubview:lblLang];
        
        UIButton *btnLang = [UIButton buttonWithType:UIButtonTypeCustom];
        [btnLang setBackgroundImage:[UIImage imageNamed:@"btnNext.png"] forState:UIControlStateNormal];
        [btnLang setBackgroundImage:[UIImage imageNamed:@"btnNext.png"] forState:UIControlStateSelected];
        [btnLang addTarget:self action:@selector(actionLanguage)forControlEvents:UIControlEventTouchUpInside];
        btnLang.frame = CGRectMake(485, 65, 50, 50);
        [self addSubview:btnLang];
        
        lblLangOneVal = [[UILabel alloc] initWithFrame:CGRectMake(535, 75, 345, 32)];
        lblLangOneVal.textAlignment = UITextAlignmentLeft;
        lblLangOneVal.backgroundColor = [UIColor clearColor];
        lblLangOneVal.text =  [[TigglyStampUtils sharedInstance] getCurrentLanguage];
        lblLangOneVal.textColor = [UIColor whiteColor];
        lblLangOneVal.font = [UIFont fontWithName:FONT_ROCKWELL_BOLD size:28.0f];
        [self addSubview:lblLangOneVal];
        
        lblMusic = [[UILabel alloc] initWithFrame:CGRectMake(80, 130, 345, 32)];
        lblMusic.textAlignment = UITextAlignmentRight;
        lblMusic.backgroundColor = [UIColor clearColor];
        lblMusic.text =  [[TigglyStampUtils sharedInstance] getLocalisedStringForKey:@"kMusic"];
        lblMusic.textColor = [UIColor whiteColor];
        lblMusic.font = [UIFont fontWithName:APP_FONT_BOLD size:fontSize];
        [self addSubview:lblMusic];
        
        swtchMusic = [[UISwitch alloc] initWithFrame:CGRectMake(485,130,79,27)];
        [swtchMusic addTarget:self action:@selector(actionMusic) forControlEvents:UIControlEventValueChanged];
        [self addSubview:swtchMusic];
        
        lblSaveArt= [[UILabel alloc] initWithFrame:CGRectMake(80, 185, 345, 32)];
        lblSaveArt.textAlignment = UITextAlignmentRight;
        lblSaveArt.backgroundColor = [UIColor clearColor];
        lblSaveArt.text =  [[TigglyStampUtils sharedInstance] getLocalisedStringForKey:@"kSaveArt"];
        lblSaveArt.textColor = [UIColor whiteColor];
        lblSaveArt.font = [UIFont fontWithName:APP_FONT_BOLD size:fontSize];
        [self addSubview:lblSaveArt];
        
        swtchArt = [[UISwitch alloc] initWithFrame:CGRectMake(485,185,79,27)];
        [swtchArt addTarget:self action:@selector(actionArt) forControlEvents:UIControlEventValueChanged];
        [self addSubview:swtchArt];
        
        lblShape = [[UILabel alloc] initWithFrame:CGRectMake(20, 240, 405, 32)];
        lblShape.textAlignment = UITextAlignmentRight;
        lblShape.backgroundColor = [UIColor clearColor];
        lblShape.text =  [[TigglyStampUtils sharedInstance] getLocalisedStringForKey:@"kPlaywithTigglyShapes"];
        lblShape.textColor = [UIColor whiteColor];
        lblShape.font = [UIFont fontWithName:APP_FONT_BOLD size:fontSize];
        [self addSubview:lblShape];
        
        swtchShape = [[UISwitch alloc] initWithFrame:CGRectMake(485,240,79,27)];
        [swtchShape addTarget:self action:@selector(actionShape) forControlEvents:UIControlEventValueChanged];
        [self addSubview:swtchShape];
        
        lblGallery= [[UILabel alloc] initWithFrame:CGRectMake(20, 295, 405, 32)];
        lblGallery.textAlignment = UITextAlignmentRight;
        lblGallery.backgroundColor = [UIColor clearColor];
        lblGallery.text =  [[TigglyStampUtils sharedInstance] getLocalisedStringForKey:@"kLimitGallery"];
        lblGallery.textColor = [UIColor whiteColor];
        lblGallery.font = [UIFont fontWithName:APP_FONT_BOLD size:fontSize];
        [self addSubview:lblGallery];
        
        swtchGallery = [[UISwitch alloc] initWithFrame:CGRectMake(485,295,79,27)];
        [swtchGallery addTarget:self action:@selector(actionGallery) forControlEvents:UIControlEventValueChanged];
        [self addSubview:swtchGallery];
        
        lblDate= [[UILabel alloc] initWithFrame:CGRectMake(80, 350, 345, 32)];
        lblDate.textAlignment = UITextAlignmentRight;
        lblDate.text = [[TigglyStampUtils sharedInstance] getLocalisedStringForKey:@"kDateFormat"];
        lblDate.tag = TAG_LABEL_DATE_FORMAT;
        lblDate.font = [UIFont fontWithName:APP_FONT_BOLD size:fontSize];
        lblDate.adjustsFontSizeToFitWidth = YES;
        lblDate.backgroundColor = [UIColor clearColor];
        lblDate.textColor = [UIColor whiteColor];
        [self addSubview:lblDate];
        
        UIButton *btnDate = [UIButton buttonWithType:UIButtonTypeCustom];
        [btnDate setBackgroundImage:[UIImage imageNamed:@"btnNext.png"] forState:UIControlStateNormal];
        [btnDate setBackgroundImage:[UIImage imageNamed:@"btnNext.png"] forState:UIControlStateSelected];
        [btnDate addTarget:self action:@selector(actionDateFormat)forControlEvents:UIControlEventTouchUpInside];
        btnDate.frame = CGRectMake(485, 350, 50, 50);
        [self addSubview:btnDate];
        
        lblDateVal = [[UILabel alloc] initWithFrame:CGRectMake(535, 355, 450, 32)];
        NSString *dateFormat = [[TigglyStampUtils sharedInstance] getDateFromat];
        if([dateFormat isEqualToString:DATE_FORM_MM_DD_YYYY]){
            dateFormat = @"mm/dd/yyyy";
            [[TigglyStampUtils sharedInstance] setDateFromat:DATE_FORM_MM_DD_YYYY];
        }else if([dateFormat isEqualToString:DATE_FORM_DD_MM_YYYY]){
            dateFormat = @"dd/mm/yyyy";
            [[TigglyStampUtils sharedInstance] setDateFromat:DATE_FORM_DD_MM_YYYY];
        }
        lblDateVal.textAlignment = UITextAlignmentLeft;
        lblDateVal.backgroundColor = [UIColor clearColor];
        lblDateVal.text =  dateFormat;
        lblDateVal.textColor = [UIColor whiteColor];
        lblDateVal.font = [UIFont fontWithName:FONT_ROCKWELL_BOLD size:28.0f];
        [self addSubview:lblDateVal];

  
        if(![[TigglyStampUtils sharedInstance] isAppUnlockedForShapes]) {
                lblBuyShapes = [[UILabel alloc] initWithFrame:CGRectMake(80, 405, 345, 32)];
                lblBuyShapes.textAlignment = UITextAlignmentRight;
                lblBuyShapes.backgroundColor = [UIColor clearColor];
                lblBuyShapes.text =  [[TigglyStampUtils sharedInstance] getLocalisedStringForKey:@"kBuyshapes"];
                lblBuyShapes.textColor = [UIColor whiteColor];
                lblBuyShapes.font = [UIFont fontWithName:APP_FONT_BOLD size:fontSize];
                [self addSubview:lblBuyShapes];
        

                UIButton *btnBuyShapes = [UIButton buttonWithType:UIButtonTypeCustom];
                [btnBuyShapes setBackgroundImage:[UIImage imageNamed:@"btnNext.png"] forState:UIControlStateNormal];
                [btnBuyShapes setBackgroundImage:[UIImage imageNamed:@"btnNext.png"] forState:UIControlStateSelected];
                [btnBuyShapes addTarget:self action:@selector(actionBuyShapes)forControlEvents:UIControlEventTouchUpInside];
                btnBuyShapes.frame = CGRectMake(485, 405, 50, 50);
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

-(void)actionDateFormat{
    DebugLog(@"");
    
    menuType = kOptionMenuDateFormat;
    
    [self launchLanguageView];
   
    if (btnClose != nil){
        [btnClose setBackgroundImage:[UIImage imageNamed:@"green_check.png"] forState:UIControlStateNormal];
        [btnClose setBackgroundImage:[UIImage imageNamed:@"green_check.png"] forState:UIControlStateSelected];
    }
    
}

-(void) actionClose {
    DebugLog(@"");

    [self removeLanguageView];
    [self.delegate settingViewOnCloseButtonClick:self];
}

-(void) actionBuyShapes{
    DebugLog(@"");
//    NSString* launchUrl = @"http://tiggly.myshopify.com";
    NSString* launchUrl = @"http://tiggly.com/shop";
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString: launchUrl]];
}

-(void)actionLanguage {
    DebugLog(@"");
    menuType = kOptionMenuLanguage;
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
   
    if(langView != nil){
        [langView removeFromSuperview];
        langView = nil;
    }
    
    
    if(menuType == kOptionMenuLanguage){
        langArr =[[NSArray alloc] initWithObjects:@"English",@"Portuguese",@"Russian",@"Spanish",@"French",@"German",@"Italian",@"Chinese", nil];
        langView = [[UIView alloc] initWithFrame:CGRectMake(200, 20, 275, 360)];
        tblView = [[UITableView alloc] initWithFrame:CGRectMake(20, 20, 235, 320)];
        langView.center = CGPointMake(self.frame.size.width/2, self.frame.size.height/2);
    }else if(menuType == kOptionMenuDateFormat){
        langArr =[[NSArray alloc] initWithObjects:@"dd/mm/yyyy",@"mm/dd/yyyy", nil];
        langView = [[UIView alloc] initWithFrame:CGRectMake(330, 300, 275, 110)];
        tblView = [[UITableView alloc] initWithFrame:CGRectMake(20, 20, 235, 80)];
        langView.center = CGPointMake(self.frame.size.width/2, self.frame.size.height/2);
    }
    
  
    
    langView.layer.cornerRadius = 20.0f;
    langView.backgroundColor = [UIColor colorWithRed:240.0f/255.0f green:210.0f/255.0f blue:50.0f/255.0f alpha:1.0];
    [self addSubview:langView];
    
    
    tblView.separatorColor = [UIColor lightGrayColor];
    [tblView setScrollEnabled:NO];
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
    if (menuType == kOptionMenuDateFormat){
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
        if (cell == nil) {
            cell = [[UITableViewCell alloc]  initWithStyle: UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
        }
        cell.textLabel.text = [langArr objectAtIndex:indexPath.row];
        cell.textLabel.textAlignment = UITextAlignmentCenter;
        cell.textLabel.font = [UIFont fontWithName:APP_FONT_BOLD size:20.0f];
        return cell;
    }else {
        LanguageCustomCell *cell =(LanguageCustomCell *) [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
        if (cell == nil) {
            cell = [[LanguageCustomCell alloc]  initWithStyle: UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
        }
        cell.textLabel.text = [langArr objectAtIndex:indexPath.row];
        cell.imgViewCell.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@_Flag",[langArr objectAtIndex:indexPath.row]]];
        return cell;
    }
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    DebugLog(@"");
    
    if(menuType == kOptionMenuLanguage){
    
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


            lblLangOneVal.text =[langArr objectAtIndex:indexPath.row];;
            
            
            [[TigglyStampUtils sharedInstance] setCurrentLanguage:[langArr objectAtIndex:indexPath.row]];

            [self removeLanguageView];
            
            [self resetAllLabels];
            
            [self.delegate settingViewOnLanguageSelected:self];
    
    }else if (menuType == kOptionMenuDateFormat){

        NSString *dateForm =[langArr objectAtIndex:indexPath.row];
        if([dateForm isEqualToString:@"dd/mm/yyyy"]){
            [[TigglyStampUtils sharedInstance] setDateFromat:DATE_FORM_DD_MM_YYYY];
        }else if([dateForm isEqualToString:@"mm/dd/yyyy"]){
            [[TigglyStampUtils sharedInstance] setDateFromat:DATE_FORM_MM_DD_YYYY];
        }
        float fontSize = 0.0;
        if([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"English"]){
            fontSize = 28.0f;
        }else{
            fontSize = 20.0f;
        }
        lblDateVal.text = dateForm;
        lblDateVal.font = [UIFont fontWithName:APP_FONT_BOLD size:fontSize];
        
         [self removeLanguageView];
    }

}

-(void) resetAllLabels{
    DebugLog(@"");
    
    lblLang.text = [[TigglyStampUtils sharedInstance] getLocalisedStringForKey:@"kLanguage"];
    lblMusic.text =  [[TigglyStampUtils sharedInstance] getLocalisedStringForKey:@"kMusic"];
    lblSaveArt.text =  [[TigglyStampUtils sharedInstance] getLocalisedStringForKey:@"kSaveArt"];
    lblShape.text =  [[TigglyStampUtils sharedInstance] getLocalisedStringForKey:@"kPlaywithTigglyShapes"];
    lblGallery.text =  [[TigglyStampUtils sharedInstance] getLocalisedStringForKey:@"kLimitGallery"];
    lblBuyShapes.text =  [[TigglyStampUtils sharedInstance] getLocalisedStringForKey:@"kBuyshapes"];
    lblDate.text = [[TigglyStampUtils sharedInstance] getLocalisedStringForKey:@"kDateFormat"];
    
    
    float fontSize = 0.0;
    if([[[TigglyStampUtils sharedInstance] getCurrentLanguage] isEqualToString:@"English"]){
        fontSize = 28.0f;
    }else{
        fontSize = 20.0f;
    }
    
    lblLang.font = [UIFont fontWithName:APP_FONT_BOLD size:fontSize];
    lblMusic.font = [UIFont fontWithName:APP_FONT_BOLD size:fontSize];
    lblSaveArt.font = [UIFont fontWithName:APP_FONT_BOLD size:fontSize];
    lblShape.font = [UIFont fontWithName:APP_FONT_BOLD size:fontSize];
    lblGallery.font = [UIFont fontWithName:APP_FONT_BOLD size:fontSize];
    lblBuyShapes.font = [UIFont fontWithName:APP_FONT_BOLD size:fontSize];
    lblDate.font = [UIFont fontWithName:APP_FONT_BOLD size:fontSize];
    lblLangOneVal.font = [UIFont fontWithName:APP_FONT_BOLD size:fontSize];
}

@end
