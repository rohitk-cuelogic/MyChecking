//
//  SettingsViewController.h
//  TigglyStamp
//
//  Created by Swpnil j. on 26/07/13.
//  Copyright (c) 2013 cuelogic. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TConstant.h"
#import <QuartzCore/QuartzCore.h>
#import "TigglyStampUtils.h"


#define TAG_SWITCH_MUSIC 1
#define TAG_SWITCH_ART 2
#define TAG_SWITCH_HAVE_SHAPES 3
#define TAG_SWITCH_MISS_SWITCH 4
#define TAG_SWITCH_LIMIT_GALLERY 5
#define TAG_BUTTON_CLOSE 6
#define TAG_SWITCH_DEBUG_MODE 9
#define TAG_SEND_MAIL 10

@interface SettingsViewController : UIViewController<UIPopoverControllerDelegate,UIPickerViewDataSource,UIPickerViewDelegate>
{
    UIPickerView *pickerView;
    UIPopoverController *popoverController;
    BOOL isShapePopView;
}

@property (nonatomic, strong) IBOutlet UISwitch *swtchMusic;
@property (nonatomic, strong) IBOutlet UISwitch *swtchArt;
@property (nonatomic, strong) IBOutlet UISwitch *swtchHaveShapes;
@property (nonatomic, strong) IBOutlet UISwitch *swtchNoShapes;
@property (nonatomic, strong) IBOutlet UISwitch *swtchLimitGallery;
@property (nonatomic, strong) IBOutlet UIButton *btnBuyShapes;
@property (nonatomic, strong) IBOutlet UIButton *btnClose;
@property (nonatomic,retain) NSMutableArray *arrLanguage;
@property (nonatomic, strong) IBOutlet UILabel *lblLunguage;
@property (nonatomic, strong) IBOutlet UIView *backgroundView;
@property (nonatomic, strong) IBOutlet UILabel *lblLunguageTest;
@property (nonatomic, strong) IBOutlet UILabel *lblSendMail;
@property (nonatomic, strong) IBOutlet UILabel *lblClearPrevData;

@property (nonatomic, strong) IBOutlet UILabel *lbl1;
@property (nonatomic, strong) IBOutlet UILabel *lbl2;
@property (nonatomic, strong) IBOutlet UILabel *lbl3;
@property (nonatomic, strong) IBOutlet UILabel *lbl4;
@property (nonatomic, strong) IBOutlet UILabel *lbl5;
@property (nonatomic, strong) IBOutlet UILabel *lbl6;

@property (nonatomic, strong) IBOutlet UIButton *btnClearData;
@property (nonatomic, strong) IBOutlet UISwitch *swtdebugMode;
@property (nonatomic, strong) IBOutlet UISwitch *swtSendMail;

-(IBAction)actionSwitchValueChanged:(id)sender;
-(IBAction)onButtonClicked:(id)sender;
-(IBAction)languageButtonClicked:(id)sender;
-(IBAction)buyShapesButtonClicked:(id)sender;
-(IBAction)actionclearData;
-(IBAction)shapeButtonClicked:(id)sender;

@end
