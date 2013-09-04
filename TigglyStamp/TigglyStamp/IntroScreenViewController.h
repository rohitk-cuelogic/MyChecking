//
//  IntroScreenViewController.h
//  TigglyStamp
//
//  Created by cuelogic on 01/07/13.
//  Copyright (c) 2013 cuelogic. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KTViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "TConstant.h"

@interface IntroScreenViewController:KTViewController<UIPopoverControllerDelegate,UIPickerViewDataSource,UIPickerViewDelegate>
{
//    IBOutlet UIButton *winterScene;
//    IBOutlet UIButton *springScene;
//    IBOutlet UIButton *summerScene;
//    IBOutlet UIButton *fallScene;
    UIPickerView *pickerView;
    UIPopoverController *popoverController;
    BOOL isLanguageScreenDisplayed;
}
@property (nonatomic,strong) IBOutlet UIButton *btnWithShape;
@property (nonatomic,strong) IBOutlet UIButton *btnWithoutShape;
@property (nonatomic, assign) BOOL isShowLogo;
@property (nonatomic,strong) IBOutlet UIView *languageView;
@property (nonatomic,strong) IBOutlet UIView *languageSubView;
@property (nonatomic,retain) NSMutableArray *arrLanguage;
@property (nonatomic, strong) IBOutlet UILabel *lblLunguage;
@property (nonatomic, strong) IBOutlet UILabel *lblLunguageTest;
@property (nonatomic, strong) IBOutlet UIImageView *bkgImageView;
@property (nonatomic, strong) IBOutlet UIImageView *bkgImageViewlang;
@property (nonatomic, strong) IBOutlet UITableView *tblView;
@property (nonatomic, strong) IBOutlet UIView *gameTypeView;

-(IBAction)onButtonTouched:(id)sender;
-(IBAction)languageButtonClicked:(id)sender;
-(IBAction)closeButtonClicked:(id)sender;

@end
