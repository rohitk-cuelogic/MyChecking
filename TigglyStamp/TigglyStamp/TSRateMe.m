//
//  TSRateMe.m
//  TigglySafari
//
//  Created by datta on 06/01/14.
//  Copyright (c) 2014 Sachin Patil. All rights reserved.
//

#import "TSRateMe.h"
#import "TConstant.h"

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
    viewRateMe.center = CGPointMake(512, 968);

    [self addSubview:self.view];

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
                         
                         viewRateMe.center = CGPointMake(512, 968);
                         
                     }
                     completion:^(BOOL finished){
                         
                         self.hidden = YES;

                     }];
    
    
}


/*============================================================================*/
@end
