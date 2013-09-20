//
//  SeassonSelectionViewController.h
//  TigglyStamp
//
//  Created by Sagar Kudale on 25/07/13.
//  Copyright (c) 2013 cuelogic. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StampViewController.h"

@interface SeasonSelectionViewController : UIViewController
{
    
}
@property (nonatomic,strong) IBOutlet UIButton *winterSeasonBtn;
@property (nonatomic,strong) IBOutlet UIButton *fallSeasonBtn;
@property (nonatomic,strong) IBOutlet UIButton *SpringSeasonBtn;
@property (nonatomic,strong) IBOutlet UIButton *SummerSeasonBtn;
@property (nonatomic,strong) IBOutlet UIImageView *lockWinter;
@property (nonatomic,strong) IBOutlet UIButton *homeBtn;
@property (nonatomic,strong) IBOutlet UIButton *learnMoreBtn;

-(IBAction)onButtonTouched:(id)sender;
-(IBAction)actionHomeButtonClicked:(id)sender;
-(IBAction)actionLearnMore:(id)sender;
@end
