//
//  ViewController.m
//  CellDownload
//
//  Created by Zhang Yan on 12-9-17.
//  Copyright (c) 2012年 Zhang Yan. All rights reserved.
//

#import "ViewController.h"
#import "FileCell.h"
#import "FileViewController.h"

@interface ViewController ()
@property (retain, nonatomic) UITableView *table;
@end

@implementation ViewController
@synthesize table = _table;

-(void) dealloc
{
    [_table release];
    [super dealloc];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    self.table = [[UITableView alloc] initWithFrame:[[UIScreen mainScreen] bounds] style:UITableViewStylePlain];
    [self.table setDelegate:self];
    [self.table setDataSource:self];
    [self.view addSubview:self.table];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

#pragma mark TableView Datasource
-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 50;
}

-(UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellId = @"Download";
    FileCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if(!cell)
    {
        cell = [[[FileCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId] autorelease];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"Row %d",indexPath.row];
    return cell;
}

#pragma mark TableView Delegate

@end
