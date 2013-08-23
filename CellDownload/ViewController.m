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
#import "FileModalPanel.h"

@interface ViewController ()
@property (retain, nonatomic) UITableView *table;
@property (retain, nonatomic) NSMutableArray *isDownloading;
@property (retain, nonatomic) NSArray *data;
@property (retain, nonatomic) FileModalPanel *modalPanel;
@end

@implementation ViewController
@synthesize table = _table;
@synthesize isDownloading = _isDownloading;
@synthesize data = _data;
@synthesize modalPanel = _modalPanel;

-(NSArray *)data
{
    if(_data == nil)
    {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"filelist" ofType:@"plist"];
        _data = [[NSArray alloc] initWithContentsOfFile:path];
    }
    return _data;
}

-(NSMutableArray *)isDownloading
{
    if(_isDownloading == nil)
    {
        _isDownloading = [[NSMutableArray alloc] init];
    }
    return _isDownloading;
}

-(void) dealloc
{
    [_table release];
    [_isDownloading release];
    [_data release];
    [super dealloc];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    self.table = [[UITableView alloc] initWithFrame:[[UIScreen mainScreen] bounds] style:UITableViewStylePlain];
    self.table.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleWidth;
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
    return [self.data count];
}

-(UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellId = @"Download";
    FileCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if(!cell)
    {
        cell = [[[FileCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId] autorelease];
    }
    //set select color
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    //load data
    cell.textLabel.text = [[self.data objectAtIndex:indexPath.row] objectForKey:@"filename"];
    cell.fileDocDirectory = [[self.data objectAtIndex:indexPath.row] objectForKey:@"filedirectory"];
    cell.fileName = [[self.data objectAtIndex:indexPath.row] objectForKey:@"filename"];
    cell.fileURL = [NSURL URLWithString:[[self.data objectAtIndex:indexPath.row] objectForKey:@"fileurl"]];
    //init argument
    [cell initArg];
    //solve the problem of redraw
    if ([self.isDownloading indexOfObject:indexPath] != NSNotFound) {
        if(cell.isDownloaded == NO)
        {
            [cell.progress setHidden:NO];
        }else
        {
            [cell.progress setHidden:YES];
            [self.isDownloading removeObject:indexPath];
        }
    }else{
        [cell.progress setHidden:YES];
    }
    //set accessoryType for downloaded
    if(cell.isDownloaded == YES)
    {
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    return cell;
}

#pragma mark TableView Delegate
-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    FileCell *cell = (FileCell *)[tableView cellForRowAtIndexPath:indexPath];
    if(cell.isDownloaded == NO)
    {
        if(cell.isDownloading == YES)
        {
            [cell stopDownload];
            [self.isDownloading removeObject:indexPath];
        }
        else
        {
            [cell startDownload];
            [self.isDownloading addObject:indexPath];
        }
    }else
    {
        if([cell getDocument] !=nil)
        {
//            FileViewController *fvc = [[FileViewController alloc] init];
//            fvc.fileDocDirectory = [cell getDocument];
//            [self.navigationController pushViewController:fvc animated:YES];
//            [fvc release];
            self.modalPanel = [[[FileModalPanel alloc] initWithFrame:self.view.bounds fileDirectory:[cell getDocument]] autorelease];
            [self.view addSubview:self.modalPanel];
            [self.modalPanel showFromPoint:[self.view center]];
        }else
        {
            [cell startDownload];
            [self.isDownloading addObject:indexPath];
        }
    }
}

@end
