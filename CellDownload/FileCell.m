//
//  FileCell.m
//  CellDownload
//
//  Created by Zhang Yan on 12-9-17.
//  Copyright (c) 2012年 Zhang Yan. All rights reserved.
//

#import "FileCell.h"
#import "DownLoad.h"

@interface FileCell()
@property (retain, nonatomic) DownLoad *down;
@end


@implementation FileCell
@synthesize progress = _progress;
@synthesize isDownloading = _isDownloading;
@synthesize isDownloaded = _isDownloaded;
@synthesize fileURL=_fileURL;
@synthesize down = _down;
@synthesize fileDocDirectory;
@synthesize fileName;


-(void)dealloc
{
    [_progress release];
    [_fileURL release];
    [_down release];
    [super dealloc];
}

-(DownLoad *)down
{
    if(_down == nil)
    {
        _down = [[DownLoad alloc] init];
        [_down setDelegate:self];
    }
    return _down;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        self.progress = [[UIProgressView alloc] initWithFrame:CGRectMake(230, 18, 50, 10)];
        [self addSubview:self.progress];
        [self.progress setHidden:YES];
    }
    return self;
}


-(void)initArg
{
    if([self.down getDocument] != nil)
    {
        self.isDownloaded = YES;
    }
    
}

-(void)startDownload
{
    self.isDownloading = YES;
    [self.down startDownload];
}

-(void)stopDownload
{
    [self.down stopDownload];
    [self.progress setHidden:YES];
    self.isDownloading = NO;
}

-(NSString *)getDocument
{
    return [self.down getDocument];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}

#pragma mark DownLoad Delegate
-(NSString *)setFileName
{
    return self.fileName;
}

-(NSString *)setFileDirectory
{
    return self.fileDocDirectory;
}

-(NSURL *)setFileURL
{
    return self.fileURL;
}

-(UIProgressView *)setProgress
{
    return self.progress;
}

-(void)finishedDownload:(NSString *)fileDirectory
{
    self.isDownloaded = YES;
    self.isDownloading = NO;
    self.accessoryType = UITableViewCellAccessoryCheckmark;
}

@end
