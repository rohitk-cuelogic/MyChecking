//
//  ImageAnimatorView.h
//  PNGAnimatorDemo
//
//  Created by Moses DeJong on 2/5/09.
//

#import <UIKit/UIKit.h>

#define ImageAnimator25FPS (1.0/25)
#define ImageAnimator20FPS (1.0/20)
#define ImageAnimator15FPS (1.0/15)
#define ImageAnimator12FPS (1.0/12)
#define ImageAnimator10FPS (1.0/10)
#define ImageAnimator5FPS (1.0/5)

#define ImageAnimatorDidStartNotification @"ImageAnimatorDidStartNotification"
#define ImageAnimatorDidStopNotification @"ImageAnimatorDidStopNotification"

@class AVAudioPlayer;

@interface ImageAnimatorView : UIView {

@public

	NSArray *animationURLs;
	NSTimeInterval animationFrameDuration;
	NSInteger animationNumFrames;
	NSInteger animationRepeatCount;
	UIImageOrientation animationOrientation;
	NSURL *animationAudioURL;
	AVAudioPlayer *avAudioPlayer;

@private
	
	UIImageView *imageView;
	NSArray *animationData;
	NSTimer *animationTimer;
	NSInteger animationStep;
	NSTimeInterval animationDuration;
	NSTimeInterval lastReportedTime;
}

// public properties

@property (nonatomic, copy) NSArray *animationURLs;
@property (nonatomic, assign) NSTimeInterval animationFrameDuration;
@property (nonatomic, readonly) NSInteger animationNumFrames;
@property (nonatomic, assign) NSInteger animationRepeatCount;
@property (nonatomic, assign) UIImageOrientation animationOrientation;
@property (nonatomic, retain) NSURL *animationAudioURL;
@property (nonatomic, retain) AVAudioPlayer *avAudioPlayer;

// private properties

@property (nonatomic, retain) UIImageView *imageView;
@property (nonatomic, copy) NSArray *animationData;
@property (nonatomic, retain) NSTimer *animationTimer;
@property (nonatomic, assign) NSInteger animationStep;
@property (nonatomic, assign) NSTimeInterval animationDuration;

+ (ImageAnimatorView*) ImageAnimatorView;

- (void) startAnimating;
- (void) stopAnimating;
- (BOOL) isAnimating;
- (void)loadView;
- (void) LoadAnimationData;
- (void) animationShowFrame: (NSInteger) frame;

- (void) rotateToPortrait;

- (void) rotateToLandscape;

- (void) rotateToLandscapeRight;

+ (NSArray*) arrayWithNumberedNames:(NSString*)filenamePrefix
						 rangeStart:(NSInteger)rangeStart
						   rangeEnd:(NSInteger)rangeEnd
					   suffixFormat:(NSString*)suffixFormat;

+ (NSArray*) arrayWithResourcePrefixedURLs:(NSArray*)inNumberedNames;

@end
