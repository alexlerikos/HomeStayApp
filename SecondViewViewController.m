//
//  SecondViewViewController.m
//  Ultimate Homestay
//
//  Created by alerikos on 6/10/14.
//  Copyright (c) 2014 CumuloNimbus. All rights reserved.
//

#import "SecondViewViewController.h"

#import "GTLDrive.h"
#import "GTMOAuth2ViewControllerTouch.h"


static NSString *const VistorURL = @"https://docs.google.com/forms/d/1umWfia61HSYxWObQ9vbwD5g1PJhHWjpJU6lkSxaZYsI/viewform";

@interface SecondViewViewController ()
@property (weak, nonatomic) IBOutlet UIWebView *Webform;


@end

@implementation SecondViewViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
	self.Webform.scalesPageToFit = YES;
		[self.Webform loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:VistorURL]]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


	
	

@end
