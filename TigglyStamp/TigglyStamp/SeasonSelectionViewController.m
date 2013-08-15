//
//  SeassonSelectionViewController.m
//  TigglyStamp
//
//  Created by Sagar Kudale on 25/07/13.
//  Copyright (c) 2013 cuelogic. All rights reserved.
//

#import "SeasonSelectionViewController.h"
#import "WinterSceneViewController.h"
#import "FallSceneViewController.h"

#define TAG_FALL_BTN 1
#define TAG_WINTER_BTN 2
#define TAG_SUMMER_BTN 3
#define TAG_SPRING_BTN 4

@interface SeasonSelectionViewController ()

@end
//============================================================================================
@implementation SeasonSelectionViewController

@synthesize winterSeasonBtn,SummerSeasonBtn,SpringSeasonBtn,fallSeasonBtn;

//============================================================================================

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

//============================================================================================
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    
//    [winterSeasonBtn setTag:TAG_WINTER_BTN];
//    [fallSeasonBtn setTag:TAG_FALL_BTN];
//    [SpringSeasonBtn setTag:TAG_SPRING_BTN];
//    [SummerSeasonBtn setTag:TAG_SUMMER_BTN];
    
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return UIInterfaceOrientationIsLandscape(interfaceOrientation);
}
-(BOOL)shouldAutorotate
{
    return YES;
}

-(NSUInteger)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskLandscape;
}

//============================================================================================
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//============================================================================================


-(IBAction) onButtonTouched:(id)sender{
    DebugLog(@"");
    UIButton *btn = (UIButton *) sender;
    DebugLog(@"Btn Tag : %d",btn.tag);
    
    if (btn.tag == TAG_WINTER_BTN) {
        WinterSceneViewController *winterViewController = [[WinterSceneViewController alloc]initWithNibName:@"WinterSceneViewController" bundle:nil];
        [self.navigationController pushViewController:winterViewController animated:YES];
    }else if (btn.tag == TAG_FALL_BTN){         
        FallSceneViewController *winterViewController = [[FallSceneViewController alloc]initWithNibName:@"FallSceneViewController" bundle:nil];
        [self.navigationController pushViewController:winterViewController animated:YES];
    }
    

}
@end
