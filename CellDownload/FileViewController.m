//
//  FileViewController.m
//  CellDownload
//
//  Created by Zhang Yan on 12-9-18.
//  Copyright (c) 2012年 Zhang Yan. All rights reserved.
//

#import "FileViewController.h"

@interface FileViewController ()
@property (retain, nonatomic) UIWebView *web;
@end

@implementation FileViewController
@synthesize fileDocDirectory = _fileDocDirectory;
@synthesize web = _web;

-(UIWebView *)web
{
    if(_web == nil)
    {
        _web = [[UIWebView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
        [_web setScalesPageToFit:YES];
    }
    return _web;
}

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
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL fileURLWithPath:self.fileDocDirectory]];
    [self.web loadRequest:request];
    [self.view addSubview:self.web];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
