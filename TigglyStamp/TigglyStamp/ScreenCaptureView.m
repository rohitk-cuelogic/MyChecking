#import "ScreenCaptureView.h"
#import <QuartzCore/QuartzCore.h>
#import <MobileCoreServices/UTCoreTypes.h>
#import <AssetsLibrary/AssetsLibrary.h>

@interface ScreenCaptureView(Private)
- (void) writeVideoFrameAtTime:(CMTime)time;
@end

@implementation ScreenCaptureView

@synthesize currentScreen, frameRate, delegate;
@synthesize exportUrl;

- (void) initialize {
    DebugLog(@"");
	// Initialization code
	self.clearsContextBeforeDrawing = YES;
	self.currentScreen = nil;
	self.frameRate = 10.0f;     //10 frames per seconds
	_recording = false;
	videoWriter = nil;
	videoWriterInput = nil;
	avAdaptor = nil;
	startedAt = nil;
	bitmapData = NULL;
}

- (id) initWithCoder:(NSCoder *)aDecoder {
    DebugLog(@"");
	self = [super initWithCoder:aDecoder];
	if (self) {
		[self initialize];
	}
	return self;
}

- (id) init {
    DebugLog(@"");
	self = [super init];
	if (self) {
		[self initialize];
	}
	return self;
}

- (id)initWithFrame:(CGRect)frame {
    DebugLog(@"");
	self = [super initWithFrame:frame];
	if (self) {
		[self initialize];
	}
	return self;
}

-(void)mixAudio:(NSString*)audio withVideo:(NSString*)video{
    DebugLog(@"");
    DebugLog(@"%@\n%@",audio,video);
    AVURLAsset* audioAsset = [[AVURLAsset alloc]initWithURL:[NSURL fileURLWithPath:audioPath] options:nil];
    AVURLAsset* videoAsset = [[AVURLAsset alloc]initWithURL:[NSURL fileURLWithPath:videoPath]  options:nil];
    
    AVMutableComposition* mixComposition = [AVMutableComposition composition];
    
    AVMutableCompositionTrack *compositionCommentaryTrack = [mixComposition addMutableTrackWithMediaType:AVMediaTypeAudio
                                                                                        preferredTrackID:kCMPersistentTrackID_Invalid];
    [compositionCommentaryTrack insertTimeRange:CMTimeRangeMake(kCMTimeZero, audioAsset.duration)
                                        ofTrack:[[audioAsset tracksWithMediaType:AVMediaTypeAudio] objectAtIndex:0]
                                         atTime:kCMTimeZero error:nil];
    
    AVMutableCompositionTrack *compositionVideoTrack = [mixComposition addMutableTrackWithMediaType:AVMediaTypeVideo
                                                                                   preferredTrackID:kCMPersistentTrackID_Invalid];
    [compositionVideoTrack insertTimeRange:CMTimeRangeMake(kCMTimeZero, videoAsset.duration)
                                   ofTrack:[[videoAsset tracksWithMediaType:AVMediaTypeVideo] objectAtIndex:0]
                                    atTime:kCMTimeZero error:nil];
    
    AVAssetExportSession* _assetExport = [[AVAssetExportSession alloc] initWithAsset:mixComposition presetName:AVAssetExportPresetPassthrough];
    
    NSDate* currentDate = [NSDate date];
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc]init];
    [dateFormat setDateFormat:@"MM-dd-yyyy_HH:mm:ss"];
    // convert it to a string
    NSString *dateString = [dateFormat stringFromDate:currentDate];
    NSString *videoName = [NSString stringWithFormat:@"TigglyStamp_%@.mov",dateString];
    DebugLog(@"Image Name : %@",videoName);

    NSString *exportPath = [[NSString alloc] initWithFormat:@"%@/%@", [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0], videoName];
    exportUrl = [NSURL fileURLWithPath:exportPath];
    
    if ([[NSFileManager defaultManager] fileExistsAtPath:exportPath])
    {
        [[NSFileManager defaultManager] removeItemAtPath:exportPath error:nil];
    }
    
    _assetExport.outputFileType = @"com.apple.quicktime-movie";
    
    _assetExport.outputURL = exportUrl;
    _assetExport.shouldOptimizeForNetworkUse = YES;
    [_assetExport exportAsynchronouslyWithCompletionHandler:^{
        switch ([_assetExport status]) {
            case AVAssetExportSessionStatusCompleted:
            {
                DebugLog(@"Completed video");
                [self.delegate recordingFinished:exportPath];

            }
        }}];

//    ^(void ) {
//        
//        NSString *path = [NSString stringWithString:[exportUrl path]];
//        if (UIVideoAtPathIsCompatibleWithSavedPhotosAlbum (path)) {
//            UISaveVideoAtPathToSavedPhotosAlbum (path, nil, nil, nil);
//        }
//    }
    
}


- (CGContextRef) createBitmapContextOfSize:(CGSize) size {
    
	CGContextRef    context = NULL;
	CGColorSpaceRef colorSpace;
	int             bitmapByteCount;
	int             bitmapBytesPerRow;
	
	bitmapBytesPerRow   = (size.width * 4);
	bitmapByteCount     = (bitmapBytesPerRow * size.height);
	colorSpace = CGColorSpaceCreateDeviceRGB();
	if (bitmapData != NULL) {
		free(bitmapData);
	}
	bitmapData = malloc( bitmapByteCount );
	if (bitmapData == NULL) {
		fprintf (stderr, "Memory not allocated!");
		return NULL;
	}
	
	context = CGBitmapContextCreate (bitmapData,
									 size.width,
									 size.height,
									 8,      // bits per component
									 bitmapBytesPerRow,
									 colorSpace,
									 kCGImageAlphaNoneSkipFirst);
	
	CGContextSetAllowsAntialiasing(context,NO);
	if (context== NULL) {
		free (bitmapData);
		fprintf (stderr, "Context not created!");
		return NULL;
	}
	CGColorSpaceRelease( colorSpace );
	
	return context;
}


- (void) drawRect:(CGRect)rect {
    DebugLog(@"");
	if (_recording) {
        NSDate* start = [NSDate date];
        CGContextRef context = [self createBitmapContextOfSize:self.frame.size];
        
        //	//not sure why this is necessary...image renders upside-down and mirrored
        CGAffineTransform flipVertical =  CGAffineTransformMake(1, 0, 0, -1,0, self.frame.size.height);
        CGContextConcatCTM(context, flipVertical);
        
        if ([UIScreen instancesRespondToSelector:@selector(scale)])
        {
            CGFloat scale = [[UIScreen mainScreen] scale];
            
            if (scale > 1.0)
            {
                // iPad retina
                
            }
            else
            {
                //iPad screen                
                
            }
        }
        
        CGContextSetInterpolationQuality(context, kCGInterpolationNone);
        
        [[self.layer presentationLayer]  renderInContext:context];
        
        CGImageRef cgImage = CGBitmapContextCreateImage(context);
        UIImage* background = [UIImage imageWithCGImage: cgImage];
        
       // UIImage* background = [UIImage imageWithCGImage:cgImage scale:1.0f orientation:UIImagePickerControllerQualityTypeLow];

        CGImageRelease(cgImage);
        
        
      
        
        
        
        self.currentScreen = background;
        background = nil;
        
        
        float millisElapsed = [[NSDate date] timeIntervalSinceDate:startedAt] * 1000.0;
        [self writeVideoFrameAtTime:CMTimeMake((int)millisElapsed, 1000)];
        
        
        float processingSeconds = [[NSDate date] timeIntervalSinceDate:start];
        float delayRemaining = (1.0 / self.frameRate) - processingSeconds;
        
        CGContextRelease(context);
        
        //redraw at the specified framerate
        [self performSelector:@selector(setNeedsDisplay) withObject:nil afterDelay:delayRemaining > 0.0 ? delayRemaining : 0.01];
    }
}

//------------------------------------------------------------------------------------------------------------

- (UIImage *)imageWithImage:(UIImage *)image scaledToSize:(CGSize)newSize {
    //UIGraphicsBeginImageContext(newSize);
    UIGraphicsBeginImageContextWithOptions(newSize, NO, 0.0);
    [image drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}



//------------------------------------------------------------------------------------------------------------*/

- (void) cleanupWriter {
    DebugLog(@"");
	avAdaptor = nil;
	videoWriterInput = nil;
	videoWriter = nil;
	startedAt = nil;
    
    [_audioRecorder stop];
	
	if (bitmapData != NULL) {
		free(bitmapData);
		bitmapData = NULL;
	}
    
    [self mixAudio:audioPath withVideo:videoPath];
}


- (NSURL*) tempFileURL {
    DebugLog(@"");
	NSString* outputPath = [[NSString alloc] initWithFormat:@"%@/%@", [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0], @"output.mov"];
	NSURL* outputURL = [[NSURL alloc] initFileURLWithPath:outputPath];
	NSFileManager* fileManager = [NSFileManager defaultManager];
	if ([fileManager fileExistsAtPath:outputPath]) {
		NSError* error;
		if ([fileManager removeItemAtPath:outputPath error:&error] == NO) {
			DebugLog(@"Could not delete old recording file at path:  %@", outputPath);
		}
	}
    
	return outputURL;
}

- (void)setupAudio {
    DebugLog(@"");
    
    // Setup to be able to record global sounds (preexisting app sounds)
	NSError *sessionError = nil;
    if ([[AVAudioSession sharedInstance] respondsToSelector:@selector(setCategory:withOptions:error:)])
        [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayAndRecord withOptions:AVAudioSessionCategoryOptionDuckOthers error:&sessionError];
    else
        [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayAndRecord error:&sessionError];
    
    // Set the audio session to be active
	[[AVAudioSession sharedInstance] setActive:YES error:&sessionError];
    
    NSDictionary *audioSettings =[NSDictionary dictionaryWithObjectsAndKeys:
                                  [NSNumber numberWithInt:kAudioFormatLinearPCM], AVFormatIDKey,
                                  [NSNumber numberWithInt:AVAudioQualityMin], AVEncoderAudioQualityKey,
                                  [NSNumber numberWithInt:16], AVEncoderBitRateKey,
                                  [NSNumber numberWithInt: 2], AVNumberOfChannelsKey,
                                  [NSNumber numberWithFloat:44100.0], AVSampleRateKey,
                                   nil]; //[NSNumber numberWithInt:1], AVLinearPCMBitDepthKey,
    
    
    // Initialize the audio recorder
    // Set output path of the audio file
    NSError *error = nil;
    audioPath = [[NSString alloc] initWithFormat:@"%@/%@", [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0], @"audio.caf"];
    NSFileManager* fileManager = [NSFileManager defaultManager];
	if ([fileManager fileExistsAtPath:audioPath]) {
		NSError* error;
		if ([fileManager removeItemAtPath:audioPath error:&error] == NO) {
			DebugLog(@"Could not delete old recording file at path:  %@", audioPath);
		}
	}
    NSAssert((audioPath != nil), @"Audio out path cannot be nil!");
    _audioRecorder = [[AVAudioRecorder alloc] initWithURL:[NSURL fileURLWithPath:audioPath] settings:audioSettings error:&error];
    if (error) {
        _audioRecorder = nil;
        return;
    }
    
    [_audioRecorder setDelegate:self];
    [_audioRecorder prepareToRecord];
    
    // Start recording :P
    [_audioRecorder record];
    
}


-(BOOL) setUpWriter {
    DebugLog(@"");
	NSError* error = nil;
    videoPath = [[NSString alloc] initWithFormat:@"%@/%@", [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0], @"output.mp4"];
    NSFileManager* fileManager = [NSFileManager defaultManager];
	if ([fileManager fileExistsAtPath:videoPath]) {
		NSError* error;
		if ([fileManager removeItemAtPath:videoPath error:&error] == NO) {
			DebugLog(@"Could not delete old recording file at path:  %@", videoPath);
		}
	}
	videoWriter = [[AVAssetWriter alloc] initWithURL:[NSURL  fileURLWithPath: videoPath] fileType:AVFileTypeQuickTimeMovie error:&error];
	NSParameterAssert(videoWriter);
    
    //    // Get the screen rect and scale
    //    CGRect screenRect = [UIScreen mainScreen].bounds;
    //    float scale = [UIScreen mainScreen].scale;
    //
    //    // iPad frame buffer is Landscape
    //    int  _width = screenRect.size.height * scale;
    //    int _height = screenRect.size.width * scale;
	
	//Configure video
	NSDictionary* videoCompressionProps = [NSDictionary dictionaryWithObjectsAndKeys:
										   [NSNumber numberWithDouble:1024.0*768.0], AVVideoAverageBitRateKey,
										   nil ];
    
    //    NSMutableDictionary* videoCompressionProps = [NSMutableDictionary dictionary];
    //    [videoCompressionProps setObject: [NSNumber numberWithInt: 1024 * 1024] forKey: AVVideoAverageBitRateKey];
    ////    [videoCompressionProps setObject: [NSNumber numberWithInt: 24] forKey: AVVideoMaxKeyFrameIntervalKey];
    ////    [videoCompressionProps setObject: AVVideoProfileLevelH264Main41 forKey: AVVideoProfileLevelKey];
	
	NSDictionary* videoSettings = [NSDictionary dictionaryWithObjectsAndKeys:
								   AVVideoCodecH264, AVVideoCodecKey,
								   [NSNumber numberWithInt:self.frame.size.width], AVVideoWidthKey,
								   [NSNumber numberWithInt:self.frame.size.height], AVVideoHeightKey,
								   videoCompressionProps, AVVideoCompressionPropertiesKey,
								   nil];
	
	videoWriterInput = [AVAssetWriterInput assetWriterInputWithMediaType:AVMediaTypeVideo outputSettings:videoSettings];
	
    
    
    
	NSParameterAssert(videoWriterInput);
	videoWriterInput.expectsMediaDataInRealTime = YES;
	NSDictionary* bufferAttributes =  [NSDictionary dictionaryWithObjectsAndKeys:
                                       [NSNumber numberWithInt:kCVPixelFormatType_32ARGB], kCVPixelBufferPixelFormatTypeKey, nil];
    
	avAdaptor = [AVAssetWriterInputPixelBufferAdaptor assetWriterInputPixelBufferAdaptorWithAssetWriterInput:videoWriterInput sourcePixelBufferAttributes:bufferAttributes];
	
	//add input
	[videoWriter addInput:videoWriterInput];
	[videoWriter startWriting];
	[videoWriter startSessionAtSourceTime:CMTimeMake(0, 1000)];
	
	return YES;
}

- (void) completeRecordingSession {
	DebugLog(@"");
    
	[videoWriterInput markAsFinished];
	
	// Wait for the video
	int status = videoWriter.status;
	while (status == AVAssetWriterStatusUnknown) {
		DebugLog(@"Waiting...");
		[NSThread sleepForTimeInterval:0.5f];
		status = videoWriter.status;
	}
	
	@synchronized(self) {
        [videoWriter finishWriting];
        [self cleanupWriter];
	}
    
}

- (bool) startRecording {
    DebugLog(@"");
    
	bool result = NO;
	@synchronized(self) {
		if (! _recording) {
			result = [self setUpWriter];
			startedAt = [NSDate date];
			_recording = true;
            
            [self setupAudio];
		}
	}
	
	return result;
    
    
}

- (void) stopRecording {
    
    DebugLog(@"");
	@synchronized(self) {
		if (_recording) {
			_recording = false;
			[self completeRecordingSession];
		}
	}
    
}

/*- (void) stopThreadButtonPressed {
 [NSThread detachNewThreadSelector:@selector(makeMyBackgroundRecordingStore) toTarget:self withObject:nil];
 }
 
 - (void)stopTheBackgroundJob {
 
 [self performSelectorOnMainThread:@selector(makeMyBackgroundRecordingStore) withObject:nil waitUntilDone:NO];
 }
 
 - (bool)makeMyBackgroundRecordingStore
 {
 
 }*/



-(void) writeVideoFrameAtTime:(CMTime)time {
    //    DebugLog(@"");
	if (![videoWriterInput isReadyForMoreMediaData]) {
		DebugLog(@"Not ready for video data");
	}
	else {
		@synchronized (self) {
			UIImage* newFrame = self.currentScreen;
			CVPixelBufferRef pixelBuffer = NULL;
			CGImageRef cgImage = CGImageCreateCopy([newFrame CGImage]);
			CFDataRef image = CGDataProviderCopyData(CGImageGetDataProvider(cgImage));
			
			int status = CVPixelBufferPoolCreatePixelBuffer(kCFAllocatorDefault, avAdaptor.pixelBufferPool, &pixelBuffer);
			if(status != 0){
				//could not get a buffer from the pool
				DebugLog(@"Error creating pixel buffer:  status=%d", status);
			}
			// set image data into pixel buffer
			CVPixelBufferLockBaseAddress( pixelBuffer, 0 );
			uint8_t* destPixels = CVPixelBufferGetBaseAddress(pixelBuffer);
			CFDataGetBytes(image, CFRangeMake(0, CFDataGetLength(image)), destPixels);  //XXX:  will work if the pixel buffer is contiguous and has the same bytesPerRow as the input data
			
			if(status == 0){
				BOOL success = [avAdaptor appendPixelBuffer:pixelBuffer withPresentationTime:time];
				if (!success)
					DebugLog(@"Warning:  Unable to write buffer to video");
			}
			
			//clean up
			CVPixelBufferUnlockBaseAddress( pixelBuffer, 0 );
			CVPixelBufferRelease( pixelBuffer );
			CFRelease(image);
			CGImageRelease(cgImage);
            
		}
		
	}
	
}

@end