//
//  HostView.m
//  Ultimate Homestay
//
//  Created by alerikos on 6/10/14.
//  Copyright (c) 2014 CumuloNimbus. All rights reserved.
//

#import "HostView.h"

static NSString *const HostURL = @"https://docs.google.com/forms/d/1xr7eONvlnwBZCQdSBUD4nWrMssOUkIJD-7REgcKHZkA/viewform";

@interface HostView ()

@property (weak, nonatomic) IBOutlet UIWebView *HostProfile;


@end

@implementation HostView

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
	
	self.HostProfile.scalesPageToFit = YES;
	[self.HostProfile loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:HostURL]]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
