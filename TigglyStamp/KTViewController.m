//
//  KTViewController.m
//
//
//  Created by Philip Hayes on 8/9/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "KTViewController.h"
#import "AppDelegate.h"

@implementation KTViewController
int volumeFadeInCnt;

-(AppDelegate *)appDelegate{
    //DebugLog(@"");
    return [UIApplication sharedApplication].delegate;
    
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
	return (interfaceOrientation == UIInterfaceOrientationLandscapeLeft || interfaceOrientation == UIInterfaceOrientationLandscapeRight);
}


-(void) sendEmail {
    DebugLog(@"");
    if ([[TigglyStampUtils sharedInstance]getSendMailOn]==NO) {
        DebugLog(@"getSendMailOn mode is Off");
        return;
    }
    if ([[TigglyStampUtils sharedInstance]getDebugModeForWriteKeyInCsvOn]==NO) {
        DebugLog(@"getDebugModeForWriteKeyInCsvOn mode is Off");
        return;
    }
    if([[TigglyStampUtils sharedInstance] isMailSupported] == YES) {
        [self dismissModalViewControllerAnimated:NO];
        
        //Shows the email composer view
        MFMailComposeViewController *picker = [[MFMailComposeViewController alloc] init];
        picker.mailComposeDelegate = self;
        [picker setToRecipients:[[NSArray alloc]initWithObjects:@"rohit.kale@cuelogic.co.in",@"amarsinh.asagekar@cuelogic.co.in",@"phyl@tiggly.com", nil]];
//        [picker setToRecipients:[[NSArray alloc]initWithObjects:@"ninad@cuelogic.co.in",@"amarsinh.asagekar@cuelogic.co.in",@"azi@tiggly.com",@"phyl@tiggly.com", nil]];
//        [picker setToRecipients:[[NSArray alloc]initWithObjects:@"rohit.kale@cuelogic.co.in", nil]];

        NSString *sub;
        NSString *body;
        NSString *filename = NULL;
//        ShapeType sType = [[TigglyStampUtils sharedInstance] getCurrentSahpeForStoringKeys];
//        if (sType == kShapeTypeCircle) {
//            filename = [NSString stringWithFormat:@"CircleShape.csv"];
//            sub = [NSString stringWithFormat:@"[Tiggly]: Circle touch points"];
//            body =  [NSString stringWithFormat:@"In this we have attached the file which contains distance of circle shape from shape detection algorithm"];
//        }
//        if (sType == kShapeTypeSquare) {
//            filename = [NSString stringWithFormat:@"SquareShape.csv"];
//            sub = [NSString stringWithFormat:@"[Tiggly]: Square touch points"];
//            body =  [NSString stringWithFormat:@"In this we have attached the file which contains distance of square shape from shape detection algorithm"];
//        }
//        if (sType == kShapeTypeStar) {
//            filename = [NSString stringWithFormat:@"StarShape.csv"];
//            sub = [NSString stringWithFormat:@"[Tiggly]: Star touch points"];
//            body =  [NSString stringWithFormat:@"In this we have attached the file which contains distance of star shape from shape detection algorithm"];
//        }
//        if (sType == kShapeTypeTriangle) {
//            filename = [NSString stringWithFormat:@"TriangleShape.csv"];
//            sub = [NSString stringWithFormat:@"[Tiggly]: Triangle touch points"];
//            body =  [NSString stringWithFormat:@"In this we have attached the file which contains distance of triangle shape from shape detection algorithm"];
//        }
            filename = [NSString stringWithFormat:@"ShapeTouchPoints.csv"];
            sub = [NSString stringWithFormat:@"[Tiggly]: Touch points in debug mode"];
            body =  [NSString stringWithFormat:@"Please find the attachment for the file containing points of shape detection algorithm"];
        
        DebugLog(@"Email Subject: %@",sub);
        DebugLog(@"Email Body: %@",body);
        
        [picker setSubject:sub];

        
        [picker addAttachmentData: [[[TigglyStampUtils sharedInstance]getCsvKeys] dataUsingEncoding: NSUTF8StringEncoding]
                         mimeType:@"text/csv" fileName:filename];
        [picker setMessageBody:body isHTML:NO];
        [self presentModalViewController:picker animated:YES];
        
    }else if([[TigglyStampUtils sharedInstance] isMailSupported] == NO){
        NSString *alertTitle = @"Email Error!";
        NSString *alertMsg = @"Configure the Mail Account on your device to send email";
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:alertTitle message:alertMsg
                                                       delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil,nil];
        [alert show];
        
    }
}
- (void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error {
	// Notifies users about errors associated with the interface
	switch (result)
	{
		case MFMailComposeResultCancelled:
			break;
		case MFMailComposeResultSaved:
			break;
		case MFMailComposeResultSent:
        {
            NSString *alertTitle = @"Email Sent";
            NSString *alertMsg = @"Report has been mailed successfully";
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:alertTitle message:alertMsg
                                                           delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil,nil];
            [alert show];
			
        }
            break;
		case MFMailComposeResultFailed:
        {
            NSString *alertTitle = @"Email Sending Failed";
            NSString *alertMsg = @"Email sending failed, please try again";
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:alertTitle message:alertMsg
                                                           delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil,nil];
            [alert show];
        }
			break;
		default:
			break;
	}
	[self dismissModalViewControllerAnimated:YES];
}



@end
