//
//  ViewController.m
//  CellDownload
//
//  Created by Zhang Yan on 12-9-17.
//  Copyright (c) 2012年 Zhang Yan. All rights reserved.
//

#import "ViewController.h"
#import "FileViewController.h"

@interface ViewController ()
@property (retain, nonatomic) UITableView *table;
@property (retain, nonatomic) NSMutableArray *isDownloading;
@property (retain, nonatomic) NSArray *data;
@end

@implementation ViewController
@synthesize table = _table;
@synthesize isDownloading = _isDownloading;
@synthesize data = _data;

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
    }else{
        // 删除cell中的子对象,刷新覆盖问题。
        while ([cell.contentView.subviews lastObject] != nil) {
            [(UIView*)[cell.contentView.subviews lastObject] removeFromSuperview];
        }
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell setDelegate:self];
    cell.textLabel.text = [[self.data objectAtIndex:indexPath.row] objectForKey:@"filename"];
    cell.fileDocDirectory = [[self.data objectAtIndex:indexPath.row] objectForKey:@"filedirectory"];
    cell.fileName = [[self.data objectAtIndex:indexPath.row] objectForKey:@"filename"];
    cell.fileURL = [NSURL URLWithString:[[self.data objectAtIndex:indexPath.row] objectForKey:@"fileurl"]];
    if ([self.isDownloading indexOfObject:indexPath] != NSNotFound) {
        [cell.progress setHidden:NO];
    }else{
        [cell.progress setHidden:YES];
    }
    [cell initArg];
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
            FileViewController *fvc = [[FileViewController alloc] init];
            fvc.fileDocDirectory = [cell getDocument];
            [self.navigationController pushViewController:fvc animated:YES];
            [fvc release];
        }else
        {
            [cell startDownload];
            [self.isDownloading addObject:indexPath];
        }
    }
}
#pragma mark FileCell Delegate
-(void)finishedDownload:(NSString *)fileDirectory
{
    FileViewController *fvc = [[FileViewController alloc] init];
    fvc.fileDocDirectory = fileDirectory;
    [self.navigationController pushViewController:fvc animated:YES];
    [fvc release];
}

@end
