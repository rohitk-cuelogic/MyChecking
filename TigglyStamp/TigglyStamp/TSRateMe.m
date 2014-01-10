//
//  TSRateMe.m
//  TigglySafari
//
//  Created by datta on 06/01/14.
//  Copyright (c) 2014 Sachin Patil. All rights reserved.
//

#import "TSRateMe.h"
#import "TConstant.h"
#import "TigglyStampUtils.h"

@implementation TSRateMe

@synthesize view, delegate;

/*============================================================================*/

- (id)initWithFrame:(CGRect)frame
{
    DebugLog(@"");
    
    self = [super initWithFrame:frame];
    if (self)
    {
        // Initialization code.
        //
        [[NSBundle mainBundle] loadNibNamed:@"TSRateMe" owner:self options:nil];
        [self addSubview:self.view];
        
    }
    
    return self;
}

/*============================================================================*/

- (void) awakeFromNib
{
    DebugLog(@"");
    
    [super awakeFromNib];
    
    [[NSBundle mainBundle] loadNibNamed:@"TSRateMe" owner:self options:nil];
    
    imgBkg.layer.opacity = 0.5;
    
    viewRateMe.userInteractionEnabled  =YES;
    viewRateMe.center = CGPointMake(512, 1068);
    [self updateTextLabels];
    
    [self addSubview:self.view];

}

-(void)updateTextLabels{
    DebugLog(@"");
    
    
    lblHalpUs.text = [[TigglyStampUtils sharedInstance] getLocalisedStringForKey:@"kIfYouEnjoy"];
    
    
   
    
    [btnRateMe setTitle:[[TigglyStampUtils sharedInstance] getLocalisedStringForKey:@"kRateIt"] forState:UIControlStateNormal];
    [btnRateMe setTitle:[[TigglyStampUtils sharedInstance] getLocalisedStringForKey:@"kRateIt"] forState:UIControlStateSelected];
     btnRateMe.titleLabel.adjustsFontSizeToFitWidth = YES;
    
    [btnLater setTitle:[[TigglyStampUtils sharedInstance] getLocalisedStringForKey:@"kRemindMe"] forState:UIControlStateSelected];
    [btnLater setTitle:[[TigglyStampUtils sharedInstance] getLocalisedStringForKey:@"kRemindMe"] forState:UIControlStateNormal];
    btnLater.titleLabel.adjustsFontSizeToFitWidth = YES;

    
    [btnDismiss setTitle:[[TigglyStampUtils sharedInstance] getLocalisedStringForKey:@"kDismiss"] forState:UIControlStateNormal];
    [btnDismiss setTitle:[[TigglyStampUtils sharedInstance] getLocalisedStringForKey:@"kDismiss"] forState:UIControlStateSelected];
    btnDismiss.titleLabel.adjustsFontSizeToFitWidth = YES;

}

- (IBAction)actionCancel:(id)sender {
    DebugLog(@"");
    
    [self.delegate rateMeCancelButtonCLicked:self];
    
}
- (IBAction)actionOK:(id)sender {
    DebugLog(@"");
    
    [self.delegate rateMeOkButtonClicked:self];
    
}

-(void)showPopUp{
    DebugLog(@"");
    
    self.hidden = NO;
    [self updateTextLabels];

    [UIView animateWithDuration:1
                     animations:^(void){
                         
                         viewRateMe.center = CGPointMake(512, 384);
                         
                     }
                     completion:^(BOOL finished){
                         
                     }];
    
    
}

-(void)hidePopUp{
    DebugLog(@"");
    
    [UIView animateWithDuration:1
                     animations:^(void){
                         
                         viewRateMe.center = CGPointMake(512, 1068);
                         
                     }
                     completion:^(BOOL finished){
                         
                         self.hidden = YES;

                     }];
    
    
}


/*============================================================================*/
@end
