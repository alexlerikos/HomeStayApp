//
//  HSMViewController.m
//  Ultimate Homestay
//
//  Created by alerikos on 6/10/14.
//  Copyright (c) 2014 CumuloNimbus. All rights reserved.
//

#import "HSMViewController.h"

#import "GTLDrive.h"
#import "GTMOAuth2ViewControllerTouch.h"

static NSString *const kKeychainItemName = @"iOSDriveSample: Google Drive";
static NSString *const kClientId = @"102893224315-u53l6sn63hsr9avmqvetilv20h0cgdm8.apps.googleusercontent.com";
static NSString *const kClientSecret = @"lsKxXH6IisgyLMDKmkaDTFEY";

@interface ViewController1 ()

//@property (weak, nonatomic) IBOutlet UIButton *authButton;

@property (weak, nonatomic) IBOutlet UIButton *Visitorbutton;
@property (weak, nonatomic) IBOutlet UIButton *Hostbutton;



@property BOOL isAuthorized;
@property (retain) NSMutableArray *driveFiles;

- (IBAction)authButtonClicked:(id)sender;
//- (IBAction)HostauthClicked:(id)sender;
//@property (weak, nonatomic) IBOutlet UIButton *VisitorButtonClicked;


- (IBAction)refreshButtonClicked:(id)sender;
- (void)loadProfileForm;
//- (void)toggleActionButtons:(BOOL)enabled;


@end

//@implementation DrEditFileEditViewController
//@synthesize driveService = _driveService;
//@synthesize driveFile = _driveFile;
//@synthesize delegate = _delegate;
//@synthesize saveButton = _saveButton;
//@synthesize textView = _textView;
//@synthesize originalContent = _originalContent;
//@synthesize updatedTitle = _updatedTitle;
//@synthesize fileIndex = _fileIndex;

@implementation ViewController1
//@synthesize authButton = _authButton;

- (void)viewDidLoad {
  [super viewDidLoad];
	
	
	
	
	
  // Check for authorization.
  GTMOAuth2Authentication *auth =
	[GTMOAuth2ViewControllerTouch authForGoogleFromKeychainForName:kKeychainItemName
																												clientID:kClientId
																										clientSecret:kClientSecret];
  if ([auth canAuthorize]) {
    [self isAuthorizedWithAuthentication:auth];
  }
	

		
	
}

- (GTLServiceDrive *)driveService {
  static GTLServiceDrive *service = nil;
  
  if (!service) {
    service = [[GTLServiceDrive alloc] init];
    
    // Have the service object set tickets to fetch consecutive pages
    // of the feed so we do not need to manually fetch them.
    service.shouldFetchNextPages = YES;
    
    // Have the service object set tickets to retry temporary error conditions
    // automatically.
    service.retryEnabled = YES;
  }
  return service;
}

- (IBAction)authButtonClicked:(id)sender {
  if (!self.isAuthorized) {
    // Sign in.
    SEL finishedSelector = @selector(viewController:finishedWithAuth:error:);
    GTMOAuth2ViewControllerTouch *authViewController =
		[[GTMOAuth2ViewControllerTouch alloc] initWithScope:kGTLAuthScopeDriveFile
																							 clientID:kClientId
																					 clientSecret:kClientSecret
																			 keychainItemName:kKeychainItemName
																							 delegate:self
																			 finishedSelector:finishedSelector];
    [self presentModalViewController:authViewController animated:YES];
		_Visitorbutton.titleLabel.text = @"Sign out";
		[_Visitorbutton setTitle:@"Sign out" forState:UIControlStateNormal];
		_Hostbutton.titleLabel.text = @"Sign out";
		[_Hostbutton setTitle:@"Sign out" forState:UIControlStateNormal];
//		while (!self.isAuthorized) {
//		//	[NSTimer scheduledTimerWithTimeInterval:.001];	}
//		}
//		NSLog(@"Is authourized set yes");
		
		
//		[UIView animateWithDuration:0.6f
//													delay:40.0f
//												options:UIViewAnimationOptionCurveEaseOut
//										 animations:^{
//											 [self presentModalViewController:authViewController animated:YES];
//											 NSLog(@"Finished Animation:but doesnt work");
//										 }
//										 completion:^(BOOL finished){
//											 if (finished) {
//												 NSLog(@"Finished Animation");
//                         _authButton.titleLabel.text = @"Sign out";
//												 [_authButton setTitle:@"Sign out" forState:UIControlStateNormal];
//												 [self loadProfileForm];
//											 }
//										 }];
		
		//[self loadProfileForm];
		
		
  } else {
    // Sign out
    [GTMOAuth2ViewControllerTouch removeAuthFromKeychainForName:kKeychainItemName];
    [[self driveService] setAuthorizer:nil];
    [_Visitorbutton setTitle:@"Visitor Login" forState:UIControlStateNormal];
		[_Hostbutton setTitle:@"Host Login" forState:UIControlStateNormal];
    self.isAuthorized = NO;
   // [self toggleActionButtons:NO];
    [self.driveFiles removeAllObjects];
    //[self.tableView reloadData];
  }
}

- (IBAction)HostauthClicked:(id)sender {
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewController:(GTMOAuth2ViewControllerTouch *)viewController
      finishedWithAuth:(GTMOAuth2Authentication *)auth
                 error:(NSError *)error {
  [self dismissModalViewControllerAnimated:YES];
  if (error == nil) {
    [self isAuthorizedWithAuthentication:auth];
  }
}

- (void)loadProfileForm{
	
	GTLQueryDrive *query = [GTLQueryDrive queryForFilesList];
  query.q = @"mimeType = 'text/plain'";
	
	[self.driveService executeQuery:query completionHandler:^(GTLServiceTicket *ticket,
                                                            GTLDriveFileList *files,
                                                            NSError *error) {
    //[alert dismissWithClickedButtonIndex:0 animated:YES];
    if (error == nil) {
      if (self.driveFiles == nil) {
        self.driveFiles = [[NSMutableArray alloc] init];
      }
      [self.driveFiles removeAllObjects];
      [self.driveFiles addObjectsFromArray:files.items];
     // [self.tableView reloadData];
    } else {
      NSLog(@"An error1 occurred: %@", error);
//      [DrEditUtilities showErrorMessageWithTitle:@"Unable to load files"
//                                         message:[error description]
//                                        delegate:self];
    }
  }];
	
	int i;
	int size = [_driveFiles count];
	BOOL filefound = NO;
	GTLDriveFile *file;
	GTMHTTPFetcher *fetcher;
	
	
	for (i=0; i<size; i++) {

	file = [self.driveFiles objectAtIndex:i];
	
	
	fetcher =
	[self.driveService.fetcherService fetcherWithURLString:self.driveFile.downloadUrl];
		if ([file.title  isEqual: @"Host"]) {
			filefound = YES;
			break;
		}
	}
	if	(!filefound){
		NSLog(@"file not foundsdfadf\n");
		NSLog(file.title);
		return;
	}
	
	[fetcher beginFetchWithCompletionHandler:^(NSData *data, NSError *error){
		
		NSString* fileContent = [[NSString alloc] initWithData:data
																									encoding:NSUTF8StringEncoding];
		NSLog(fileContent);
		
	}];


	
	
}

- (IBAction)refreshButtonClicked:(id)sender {
	if (self.isAuthorized){
  //[self loadProfileForm];
	}
}

- (void)isAuthorizedWithAuthentication:(GTMOAuth2Authentication *)auth {
  [[self driveService] setAuthorizer:auth];
	self.Hostbutton.titleLabel.text = @"Sign out";
	[_Hostbutton setTitle:@"Sign out" forState:UIControlStateNormal];
	self.Visitorbutton.titleLabel.text = @"Sign out";
	[_Visitorbutton setTitle:@"Sign out" forState:UIControlStateNormal];
  self.isAuthorized = YES;
	//[self loadProfileForm];
  //[self toggleActionButtons:YES];
 // [self loadDriveFiles];
}

@end
