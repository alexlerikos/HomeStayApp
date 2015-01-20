//
//  HSMViewController.h
//  Ultimate Homestay
//
//  Created by alerikos on 6/10/14.
//  Copyright (c) 2014 CumuloNimbus. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MobileCoreServices/MobileCoreServices.h>

#import "GTMOAuth2ViewControllerTouch.h"
#import "GTLDrive.h"
#import "HSMAppDelegate.h"

@interface ViewController1: UIViewController

//@property GTLServiceDrive *driveService;
//@property GTLDriveFile *driveFile;
////@property id<HSMAppDelegate> delegate;
//@property NSInteger fileIndex;

@property NSInteger fileIndex;
@property GTLServiceDrive *driveService;
@property GTLDriveFile *driveFile;

@end
