//
//  TigglyStampUtils.m
//  TigglyStamp
//
//  Created by cuelogic on 16/07/13.
//  Copyright (c) 2013 cuelogic. All rights reserved.
//

#import "TigglyStampUtils.h"

#import <MessageUI/MessageUI.h>
#import <MessageUI/MFMailComposeViewController.h>


#define KEY_WRITE_KEYS_INCSV @"keyincsv"
#define KEY_IS_SEND_MAIL @"keyissendmail"
#define KEY_SHAPE_STORE_KEY @"keyshapestore"
#define KEY_FIRST_TIME_LAUNCH @"firsttimelaunch"
#define KEY_CURRENT_LANGUAGE @"currentlang"
#define KEY_SAVING_FILE_DATA @"saveFileData"


@implementation TigglyStampUtils

static TigglyStampUtils *sharedInstance = nil;


#pragma mark -
#pragma mark =======================================
#pragma mark Init
#pragma mark =======================================

// Get the shared instance and create it if necessary.
+ (TigglyStampUtils *)sharedInstance {
    if (sharedInstance == nil) {
        sharedInstance = [[TigglyStampUtils alloc]init];
        
    }
    
    return sharedInstance;
}
// We can still have a regular init method, that will get called the first time the Singleton is used.
- (id)init {
    
    self = [super init];    
    if (self) {
        // Work your initialising magic here as you normally would
        DebugLog(@"");
        
    }
    
    return self;
}


#pragma mark -
#pragma mark =======================================
#pragma mark App Settings Data
#pragma mark =======================================


-(void) setMusicStatus:(NSString *) status{
    DebugLog(@"");
    /*This function persists the value of Music settings */
    [[NSUserDefaults standardUserDefaults] setValue:status forKey:MUSIC];
}

-(NSString *) getMusicStatus {
    DebugLog(@"");
    
    return  [[NSUserDefaults standardUserDefaults] objectForKey:MUSIC];
}


-(void)setShapeMode:(BOOL) bVar{
    /*This function persists the value of Shape settings */
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setBool:bVar forKey:IS_WITH_SHAPE];
    
}

-(BOOL)getShapeMode{
     NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    BOOL isWithShape = [userDefaults boolForKey:IS_WITH_SHAPE];
    return isWithShape;
}

-(void)setCurrentLanguage:(NSString *)lang{
    
    /*This function persists the value of Language settings */
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setValue:lang forKey:KEY_CURRENT_LANGUAGE];
}

-(NSString *)getCurrentLanguage{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSString *lang = [userDefaults valueForKey:KEY_CURRENT_LANGUAGE];
    return lang;
}

-(BOOL) isAppUnlockedForShapes {
    DebugLog(@"");
    
    return [[NSUserDefaults standardUserDefaults] boolForKey:IS_UNLOCKED_FOR_SHAPES];
}

-(void)unlockAppForShapes:(BOOL) boolean{
    DebugLog(@"");
    
    /*This function persists the value of App's Shape/NoShape mode settings */
    [[NSUserDefaults standardUserDefaults] setBool:boolean forKey:IS_UNLOCKED_FOR_SHAPES];
    
}


-(BOOL) isSpaceAvailableOnDisk{
    DebugLog(@"");
    /* This functions checks if the available disk space is above 50mb*/
    
    if([self getFreeDiskspace] < 50)
        return NO;
    
    return YES;
}

#pragma mark -
#pragma mark =======================================
#pragma mark File Sysytem Handling
#pragma mark =======================================


- (NSString *) getDocumentDirPath {
    DebugLog(@"");
    /*This function returns the App's Document directory path*/
    NSString *docsDirectory = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    return docsDirectory;
}

#pragma mark -
#pragma mark =======================================
#pragma mark Artwork Names Handling
#pragma mark =======================================

- (NSArray *) getAllImagesAndMovies{
    DebugLog(@"");
    /*This function returns all the images and movie files stored in documents directory path*/
    
    NSMutableArray *dirArray = [[NSMutableArray alloc] initWithCapacity:1];
    
    NSString *path = [[TigglyStampUtils sharedInstance]getDocumentDirPath];
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSArray *directoryContents = [fileManager contentsOfDirectoryAtPath:path error:NULL];

    //Filter only the png and mov files
    for (NSString *file in directoryContents) {
        if([file hasPrefix:@"TigglyStamp"] && ([[[file lastPathComponent] pathExtension] isEqualToString:@"png"] ||[[[file lastPathComponent] pathExtension] isEqualToString:@"mov"] )){
            [dirArray addObject:[path stringByAppendingPathComponent:file]];
        }
    }
    
    return dirArray;
}


-(NSString *) getImagePathOfMovieThumbnailWithBorder:(NSString *) moveName {
    DebugLog(@"");
    /*This function takes the movie file name and forms a name that will give the image name of the movie's thumbnail with white border*/
    
    NSString *path = [[TigglyStampUtils sharedInstance]getDocumentDirPath];
    NSString *iName = [NSString stringWithFormat:@"%@_%@.png",[moveName stringByDeletingPathExtension],STR_WITH_MOVIE_BORDER];
    path = [path stringByAppendingPathComponent:iName];
    
    return path;
}

-(UIImage *) getMovieImageForMovieName:(NSString *) moviePath {
    DebugLog(@"");
    /*This function returns the thumbnail image of the movie*/
    
    NSString *movieName = [[moviePath lastPathComponent] stringByReplacingOccurrencesOfString:@"mov" withString:@"png"];
    NSString *fileName=[NSString stringWithFormat:@"%@/Movie%@",[[TigglyStampUtils sharedInstance]getDocumentDirPath],movieName];
    UIImage *img;
    
     if (![[NSFileManager defaultManager] fileExistsAtPath:fileName]) {
         //If MovieImage not found. Create a thumbnail from the movie file
         DebugLog(@"MovieImage not found. Create thumbnail");
        NSString *path = [[TigglyStampUtils sharedInstance]getDocumentDirPath];
        path = [path stringByAppendingPathComponent:moviePath];
        NSURL *url = [NSURL fileURLWithPath:path];
        AVURLAsset *asset = [[AVURLAsset alloc] initWithURL:url options:nil];
        AVAssetImageGenerator *gen = [[AVAssetImageGenerator alloc] initWithAsset:asset];
        gen.appliesPreferredTrackTransform = YES;
        CMTime time = CMTimeMakeWithSeconds(0.0, 30.0);
        NSError *error = nil;

        CGImageRef image = [gen copyCGImageAtTime:time actualTime:NULL error:&error];
        img= [[UIImage alloc] initWithCGImage:image];
        CGImageRelease(image);
     }else{
         DebugLog(@"MovieImage found.");
         img = [UIImage imageWithContentsOfFile:fileName];
     }
    return img;
}

-(NSString *) getMovieImagePathForMovieName:(NSString *) moviePath{
    DebugLog(@"");
    /*This function returns the path of movie's thumbnail image*/
    NSString *movieName = [[moviePath lastPathComponent] stringByReplacingOccurrencesOfString:@"mov" withString:@"png"];
    NSString *fileName=[NSString stringWithFormat:@"%@/Movie%@",[[TigglyStampUtils sharedInstance]getDocumentDirPath],movieName];
    return fileName;
}

#pragma mark -
#pragma mark =======================================
#pragma mark Localization
#pragma mark =======================================

-(NSString*) getLocalisedStringForKey:(NSString*) key {
    DebugLog(@"");
    /*This function returns the localised string for the given key */
    NSString *selectedLanguage = [self getCurrentLanguage];
	NSString *path;
    if([selectedLanguage isEqualToString:@"Portuguese"])
		path = [[NSBundle mainBundle] pathForResource:@"pt" ofType:@"lproj"];
    else if([selectedLanguage isEqualToString:@"Russian"])
		path = [[NSBundle mainBundle] pathForResource:@"ru" ofType:@"lproj"];
    else if([selectedLanguage isEqualToString:@"Spanish"])
		path = [[NSBundle mainBundle] pathForResource:@"es" ofType:@"lproj"];
    else if([selectedLanguage isEqualToString:@"English"])
		path = [[NSBundle mainBundle] pathForResource:@"en" ofType:@"lproj"];
    else if([selectedLanguage isEqualToString:@"French"])
		path = [[NSBundle mainBundle] pathForResource:@"fr" ofType:@"lproj"];
    else if([selectedLanguage isEqualToString:@"German"])
		path = [[NSBundle mainBundle] pathForResource:@"de" ofType:@"lproj"];
    else if([selectedLanguage isEqualToString:@"Italian"])
		path = [[NSBundle mainBundle] pathForResource:@"it" ofType:@"lproj"];
    else if([selectedLanguage isEqualToString:@"Chinese"])
		path = [[NSBundle mainBundle] pathForResource:@"zh-Hans" ofType:@"lproj"];
    else
        path = [[NSBundle mainBundle] pathForResource:@"en" ofType:@"lproj"];
    
	NSBundle* languageBundle = [NSBundle bundleWithPath:path];
	NSString* str=[languageBundle localizedStringForKey:key value:@"" table:nil];
	return str;
}

-(NSString*) getCurrentLanguageCode {
    DebugLog(@"");
    
    NSString *selectedLanguage = [self getCurrentLanguage];
    
	NSString *languageCode;
    if([selectedLanguage isEqualToString:@"English"])
		languageCode = @"1";
    else if([selectedLanguage isEqualToString:@"Italian"])
        languageCode = @"2";
    else if([selectedLanguage isEqualToString:@"French"])
        languageCode = @"3";
    else if([selectedLanguage isEqualToString:@"Portuguese"])
        languageCode = @"4";
    else if([selectedLanguage isEqualToString:@"Spanish"])
		languageCode = @"5";
    else if([selectedLanguage isEqualToString:@"German"])
		languageCode = @"6";
    else if([selectedLanguage isEqualToString:@"Russian"])
		languageCode = @"7";
    else if([selectedLanguage isEqualToString:@"Chinese"])
		languageCode = @"8";
    else
		languageCode = @"1";
    
	return languageCode;
}

- (NSString *) platformString {
    size_t size;
    sysctlbyname("hw.machine", NULL, &size, NULL, 0);
    char *machine = malloc(size);
    sysctlbyname("hw.machine", machine, &size, NULL, 0);
    NSString *platform = [NSString stringWithCString:machine encoding:NSUTF8StringEncoding];
    free(machine);
    
    DebugLog(@"Platform : %@",platform);
    
    return platform;
}

-(NSString *)getStringNameForShapeType:(ShapeType)sType {
    NSString *shpName = NULL;
    switch (sType) {
        case kShapeTypeNone:
            shpName = [NSString stringWithFormat:@"None"];
            break;
        case kShapeTypeCircle:
            shpName = [NSString stringWithFormat:@"circle"];
            break;
        case kShapeTypeTriangle:
            shpName = [NSString stringWithFormat:@"triangle"];
            break;
        case kShapeTypeSquare:
            shpName = [NSString stringWithFormat:@"square"];
            break;
        case kShapeTypeStar:
            shpName = [NSString stringWithFormat:@"star"];
            break;
        default:
            shpName = [NSString stringWithFormat:@"None"];
            
            break;
    }
    return shpName;
}


#pragma mark -
#pragma mark =============================================
#pragma mark Debugging Shape Detection
#pragma mark =============================================

-(void)setDebugModeForWriteKeyInCsvOn:(BOOL) isOn{
    DebugLog(@"setDebugModeForWriteKeyInCsvOn :%d",isOn);
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setBool:isOn forKey:KEY_WRITE_KEYS_INCSV];
    
}
-(BOOL)getDebugModeForWriteKeyInCsvOn{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSString *strfirstTime = [userDefaults stringForKey:KEY_FIRST_TIME_LAUNCH];
    if (strfirstTime==NULL||[strfirstTime isEqualToString:@""] ) {
        [self setDebugModeForWriteKeyInCsvOn:NO];
        [self setSendMailOn:NO];
        [userDefaults setObject:@"YES" forKey:KEY_FIRST_TIME_LAUNCH];
    }
    BOOL isWithShape = [userDefaults boolForKey:KEY_WRITE_KEYS_INCSV];
    DebugLog(@"getDebugModeForWriteKeyInCsvOn :%d",isWithShape);

    return isWithShape;
}

-(void)setSendMailOn:(BOOL) isOn{
    DebugLog(@"setsendMailOn :%d",isOn);
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setBool:isOn forKey:KEY_IS_SEND_MAIL];
    
}
-(BOOL)getSendMailOn{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    BOOL isWithShape = [userDefaults boolForKey:KEY_IS_SEND_MAIL];
    DebugLog(@"getsendMailOn :%d",isWithShape);
    return isWithShape;
}


-(void)setCurrentSahpeForStoringKeys:(ShapeType)sType {
    DebugLog(@"setCurrentSahpeForStoringKeys :%d",sType);
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setInteger:sType forKey:KEY_SHAPE_STORE_KEY];
}
-(ShapeType)getCurrentSahpeForStoringKeys {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    ShapeType sType = [userDefaults integerForKey:KEY_SHAPE_STORE_KEY];
    DebugLog(@"getCurrentSahpeForStoringKeys :%d",sType);
    return sType;
}


- (void) saveCSVFileData {
    DebugLog(@"");
    
    NSString *filename = NULL;

    filename = [NSString stringWithFormat:@"ShapeTouchPoints.csv"];
	NSString *path = [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"]
					  stringByAppendingPathComponent:filename];
	[strCsvKyes writeToFile:path atomically:NO encoding:NSStringEncodingConversionAllowLossy error:NULL];

	DebugLog(@"File saved at path : %@", path);
}

- (void) deleteCSVFile{
    DebugLog(@"");

    NSString *path = [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"]
                              stringByAppendingPathComponent:@"ShapeTouchPoints.csv"];
    NSError *error = nil;
    [[NSFileManager defaultManager] removeItemAtPath:path error:&error];
    if (error != nil) {
        DebugLog(@"Error deleting file: %@ withError:%@", path, [error localizedDescription]);
    }
    strCsvKyes = NULL;
}

-(void)appendKeyDatatoString:(NSString *)str {
    if ([self getDebugModeForWriteKeyInCsvOn]==NO) {
        return;
    }
    if (strCsvKyes==NULL) {
        strCsvKyes = [[NSMutableString alloc]initWithString:@"SingleTouch,D1,D2,D3,SHAPE\n"];
    }
    [strCsvKyes appendString:str];
    DebugLog(@"Final Key Data String is :\n%@",strCsvKyes);
    [self saveCSVFileData];
}
- (BOOL) isMailSupported {
	Class mailClass = (NSClassFromString(@"MFMailComposeViewController"));
	if (mailClass != nil) {
		// We must always check whether the current device is configured for sending emails
		if ([mailClass canSendMail]) {
			return YES;
		}
		else {
			return NO;
		}
	}
	else {
		return NO;
	}
}

-(NSString *)getCsvKeys {
    return strCsvKyes;
}



-(BOOL) isItemCountBelowTheLimit{
    DebugLog(@"");

    NSArray *directoryContents = [self getAllImagesAndMovies];
    DebugLog(@"Gallery Intems Count : %d",directoryContents.count);
    if(directoryContents.count < GALLERY_LIMIT){        
            return YES;
    }else{
        if([[[NSUserDefaults standardUserDefaults]valueForKey:LIMIT_GALLERY] isEqualToString:@"yes"]){
            return NO;
        }
    }
    
    return YES;
    
}

-(uint64_t)getFreeDiskspace {
    uint64_t totalSpace = 0;
    uint64_t totalFreeSpace = 0;
    NSError *error = nil;
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSDictionary *dictionary = [[NSFileManager defaultManager] attributesOfFileSystemForPath:[paths lastObject] error: &error];
    
    if (dictionary) {
        NSNumber *fileSystemSizeInBytes = [dictionary objectForKey: NSFileSystemSize];
        NSNumber *freeFileSystemSizeInBytes = [dictionary objectForKey:NSFileSystemFreeSize];
        totalSpace = [fileSystemSizeInBytes unsignedLongLongValue];
        totalFreeSpace = [freeFileSystemSizeInBytes unsignedLongLongValue];
        DebugLog(@"Memory Capacity of %llu MiB with %llu MiB Free memory available.", ((totalSpace/1024ll)/1024ll), ((totalFreeSpace/1024ll)/1024ll));
    } else {
        DebugLog(@"Error Obtaining System Memory Info: Domain = %@, Code = %d", [error domain], [error code]);
    }
    
    return totalFreeSpace;
}

#pragma mark -
#pragma mark =======================================
#pragma mark Temp Data
#pragma mark =======================================

- (BOOL) createFolderForProject: (NSString *) folder {
    DebugLog(@"");
    
    //Create a path for new mtally folder
    NSString *docsDirectory = [self getDocumentDirPath];
    NSString *path = [docsDirectory stringByAppendingPathComponent:folder];
    DebugLog(@"Project saved at Path: %@", path);
    NSError *error = nil;
    
    //Create the folder
    if (![[NSFileManager defaultManager] fileExistsAtPath:path]) {
        
        [[NSFileManager defaultManager] createDirectoryAtPath:path withIntermediateDirectories:NO attributes:nil error:&error];
        
        if(error != nil) {
            DebugLog(@"Error creating the folder: %@",[error localizedDescription]);
        } else {
            DebugLog(@"Folder created sucessfully");
        }
    }
    return YES;
}

-(BOOL) packTempData:(TSTempData *) pInfo toFolder:(NSString *) folder{
    
    //Encode the project info object into NSData
    NSMutableData *data = [[NSMutableData alloc]init];
    NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc]initForWritingWithMutableData:data];
    [archiver encodeObject:pInfo];
    [archiver finishEncoding];
    
    //Save the data to the specified file
    NSString *path = [self getDocumentDirPath];
    [self createFolderForProject:folder] ;
    NSString *directory = [path stringByAppendingPathComponent:folder];
    DebugLog(@"Directory after adding project name: %@",directory);
    NSString *datapath = [directory stringByAppendingPathComponent:[NSString stringWithFormat:@"%@%d.tiggly",folder,[self getTempFilesCountInFolder:folder]]];
    DebugLog(@"Metadata file saved at path: %@",datapath);
    [data writeToFile:datapath atomically:YES];
    
    return YES;
}

- (NSMutableArray *) getAllTempDataFromFolder:(NSString *)folder {
    DebugLog(@"");
    
    NSMutableArray *arr = [[NSMutableArray alloc] initWithCapacity:1];
    NSString *path = [self getDocumentDirPath];
    NSString *directory = [path stringByAppendingPathComponent:folder];
    DebugLog(@"directory : %@",directory);
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSArray *directoryContents = [fileManager contentsOfDirectoryAtPath:directory error:NULL];
    
    for (NSString *file in directoryContents) {
        DebugLog(@"FFile : %@",file);
        NSMutableData *data = [[NSMutableData alloc]initWithContentsOfFile:[directory stringByAppendingPathComponent:file]];
        NSKeyedUnarchiver *unarchiver = [[NSKeyedUnarchiver alloc] initForReadingWithData:data];
        TSTempData *tempData = (TSTempData *)[unarchiver decodeObject];
        
        if(tempData != nil)
            [arr addObject:tempData];
    }
    
    return arr;
}

-(void) deleteTempFileDataFromFolder:(NSString *) folder{
    DebugLog(@"");
    NSString *path = [self getDocumentDirPath];
    NSString *directory = [path stringByAppendingPathComponent:folder];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSError *error = nil;

        [fileManager removeItemAtPath:directory error:&error];
        if(error == nil){
            DebugLog(@"File deleted successfully");
        }else{
            DebugLog(@"File deletion failed");
        }

}

-(BOOL) shouldRestrictSavingDataFile{
    
    return [[NSUserDefaults standardUserDefaults] boolForKey:KEY_SAVING_FILE_DATA];
}

-(void)setShouldRestrictSavingDataFile:(BOOL) status{
    
    [[NSUserDefaults standardUserDefaults] setBool:status forKey:KEY_SAVING_FILE_DATA];
}


-(int) getTempFilesCountInFolder:(NSString *) folder {
    DebugLog(@"");
    
    NSString *path = [self getDocumentDirPath];
    NSString *directory = [path stringByAppendingPathComponent:folder];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSArray *directoryContents = [fileManager contentsOfDirectoryAtPath:directory error:NULL];
    
    return directoryContents.count;
}

#pragma mark -
#pragma mark =======================================
#pragma mark iPad mini device versions
#pragma mark =======================================
-(void) setiPadMiniDeviceVersion:(NSMutableArray *) deviceArray
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:deviceArray forKey:IPADMINI_DEVICE_ARRAY];
    [userDefaults synchronize];
}


-(NSMutableArray *) getiPadMiniDeviceVersion
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSMutableArray *deviceArr = [userDefaults objectForKey:IPADMINI_DEVICE_ARRAY];
    NSMutableArray *deviceStaticarr;
    
    if ([deviceArr count]!=0 || deviceArr!=nil) {
        deviceStaticarr = [[NSMutableArray alloc]initWithArray:deviceArr];
        return deviceStaticarr;
        
    }else{
        deviceStaticarr = [[NSMutableArray alloc] initWithObjects:@"iPad2,5",@"iPad2,6",@"iPad2,7",@"iPad4,4",@"iPad4,5", nil];
        return deviceStaticarr;
    }
}

#pragma mark -
#pragma mark =======================================
#pragma mark- Get Device ID
#pragma mark =======================================

-(NSString *) getDeviceIDMacAddres{
    DebugLog(@"");
    NSString *_deviceID;
    
    _deviceID =[NSString stringWithFormat:@"%@",
                [[UIDevice currentDevice] uniqueGlobalDeviceIdentifier]];
    
    DebugLog(@"DeviceID New %@", _deviceID);
    
    return _deviceID;
}
#pragma mark -
#pragma mark =======================================
#pragma mark Network Connection
#pragma mark =======================================

-(BOOL)isNetworkAvailable {
    DebugLog(@"");
    //    UIAlertView *errorView;
    NetworkStatus internetStatus = [[Reachability reachabilityForInternetConnection] currentReachabilityStatus];
    
    if(internetStatus== NotReachable){
        
        //        errorView = [[UIAlertView alloc]
        //                     initWithTitle: @"Tiggly"
        //                     message: @"It seems that your internet connection is not working. Please check your internet connection."
        //                     delegate: nil
        //                     cancelButtonTitle: @"Ok" otherButtonTitles: nil];
        //        [errorView show];
        return NO;
    }
    
    return YES;
}
#pragma mark -
#pragma mark =======================================
#pragma mark Unzip and Save File
#pragma mark =======================================
- (void)unzipAndSaveFile:(NSString *)strFileName
{
    ZipArchive* za = [[ZipArchive alloc] init];
    
    NSString *filePth =[[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:strFileName];
    if ([[NSFileManager defaultManager] fileExistsAtPath:filePth])
    {
       	if([za UnzipOpenFile:filePth])
        {
            NSString *strPath=[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
            
            //Delete the previous files
            NSFileManager *filemanager=[[NSFileManager alloc] init];
            if ([filemanager fileExistsAtPath:filePth]) {
                
                NSError *error;
                NSURL *fileURL = [[NSURL alloc] initFileURLWithPath:filePth];
                [filemanager removeItemAtURL:fileURL error:&error];
            }
            //[filemanager release];
            filemanager=nil;
            //start unzip
            BOOL ret = [za UnzipFileTo:[NSString stringWithFormat:@"%@/",strPath] overWrite:YES];
            
            if( NO==ret ){
                // error handler here
                UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"Error"
                                                              message:@"An unknown error occured"
                                                             delegate:self
                                                    cancelButtonTitle:@"OK"
                                                    otherButtonTitles:nil];
                [alert show];
                //[alert release];
                alert=nil;
            }
            [za UnzipCloseFile];
        }
        //[za release];
    }
}
#pragma mark -
#pragma mark =======================================
#pragma mark Reset Rate Me and Get Rate Me Count
#pragma mark =======================================
-(void)setRateMeCount{
    DebugLog(@"");
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setInteger:0 forKey:RATE_ME_COUNT];
    
}


-(int)getRateMeCount{
    DebugLog(@"");
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    int cnt = [userDefaults integerForKey:RATE_ME_COUNT];
    
    cnt++;
    if(cnt == 5){
        cnt = 0;
    }
    
    [userDefaults setInteger:cnt forKey:RATE_ME_COUNT];
    
    return cnt;
}
-(void)setShouldStopShowingRateMePopUp:(BOOL)bShoulShow{
    DebugLog(@"");
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setBool:bShoulShow forKey:SHOW_RATE_ME_POP_UP];
    
}

-(BOOL)shouldStopShowingRateMePopUp{
    DebugLog(@"");
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    return [userDefaults boolForKey:SHOW_RATE_ME_POP_UP];
}

-(void) setDateFromat:(NSString *) dateForm{
    DebugLog(@"");
    
    [[NSUserDefaults standardUserDefaults] setObject:dateForm forKey:DATE_FORMAT];
}

-(NSString*)getDateFromat{
    DebugLog(@"");
    NSString *dateformat = [[NSUserDefaults standardUserDefaults] valueForKey:DATE_FORMAT];
    
    if (dateformat==NULL||[dateformat isEqualToString:@""] || dateformat ==  nil) {
        dateformat = DATE_FORM_DD_MM_YYYY;
    }
    return dateformat;
}

@end
