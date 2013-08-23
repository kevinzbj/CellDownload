//
//  UAModalExampleView.m
//  UAModalPanel
//
//  Created by Matt Coneybeare on 1/8/12.
//  Copyright (c) 2012 Urban Apps. All rights reserved.
//

#import "FileModalPanel.h"
@interface FileModalPanel()

@end


@implementation FileModalPanel

- (id)initWithFrame:(CGRect)frame fileDirectory:(NSString *)fileDirectory {
	if ((self = [super initWithFrame:frame])) {
		
		
		////////////////////////////////////
		// RANDOMLY CUSTOMIZE IT
		////////////////////////////////////

			// Funky time.
			UADebugLog(@"Showing a randomized panel for modalPanel: %@", self);
			
			// Margin between edge of container frame and panel. Default = {20.0, 20.0, 20.0, 20.0}
			self.margin = UIEdgeInsetsMake(12,12,12,12);
			
			// Margin between edge of panel and the content area. Default = {20.0, 20.0, 20.0, 20.0}
			self.padding = UIEdgeInsetsMake(10,10,10,10);
			
			// Border color of the panel. Default = [UIColor whiteColor]
			self.borderColor = [UIColor blackColor];
			
			// Border width of the panel. Default = 1.5f;
			self.borderWidth =  0.2f;
			
			// Corner radius of the panel. Default = 4.0f
			self.cornerRadius = 4.0f;
			
			// Color of the panel itself. Default = [UIColor colorWithWhite:0.0 alpha:0.8]
			self.contentColor = [UIColor whiteColor];
			
			// Shows the bounce animation. Default = YES
			self.shouldBounce = (arc4random() % 2);
			
			// Shows the actionButton. Default title is nil, thus the button is hidden by default
			//[self.actionButton setTitle:@"OK" forState:UIControlStateNormal];
            //[self.actionButton addTarget:self action:@selector(buttonPressed) forControlEvents:UIControlEventTouchUpInside];

			// Height of the title view. Default = 40.0f
			[self setTitleBarHeight:0];

	
		//////////////////////////////////////
		// SETUP RANDOM CONTENT
		//////////////////////////////////////
		
        UIWebView *web = [[[UIWebView alloc] initWithFrame:CGRectZero] autorelease];
        NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL fileURLWithPath:fileDirectory]];
        [web loadRequest:request];
        [web setScalesPageToFit:YES];

		v = [web retain];
		[self.contentView addSubview:v];
	}	
	return self;
}

- (void)dealloc {
    [v release];
    [super dealloc];
}

- (void)layoutSubviews {
	[super layoutSubviews];
	
	[v setFrame:self.contentView.bounds];
}






@end
