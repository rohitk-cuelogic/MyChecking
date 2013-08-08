//
//  TSThumbnailEditController.h
//  ivyApplication
//
//  Created by Dattatraya Anarase on 25/07/13.
//
//

#import <UIKit/UIKit.h>
#import "TConstant.h"
#import <QuartzCore/QuartzCore.h>
#import "UIView+Genie.h"
#import "TigglyStampUtils.h"
#import <MediaPlayer/MediaPlayer.h>

@interface TSThumbnailEditController : UIViewController{
    IBOutlet UIButton *homeBtn;
    IBOutlet UIButton *saveImageBtn;
    IBOutlet UIButton *confirmSaveBtn;
    IBOutlet UIButton *deleteBtn;
    IBOutlet UIView *confirmationView;
    IBOutlet UITextView *textView;
    IBOutlet UIButton *notConfirm;
    IBOutlet UIButton *playBtn;
    UIImageView *editorImgView;
    MPMoviePlayerController *moviePlayer;
}

- (id) initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil withImage:(UIImage *)img imageName:(NSString *)imgName;
-(IBAction) goToHomeScreen:(id)sender;
-(IBAction) saveImageToGallary:(id)sender;
-(IBAction)saveImageConfirmed:(id)sender;
-(IBAction) deleteImage:(id)sender;
-(IBAction)noConfirmation:(id)sender;
-(IBAction)actionPlayVideo;

@end
