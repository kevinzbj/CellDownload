//
//  FileCell.m
//  CellDownload
//
//  Created by Zhang Yan on 12-9-17.
//  Copyright (c) 2012年 Zhang Yan. All rights reserved.
//

#import "FileCell.h"
@interface FileCell()
@property (nonatomic) BOOL isDownloading;
@end


@implementation FileCell
@synthesize progress = _progress;
@synthesize isDownloading = _isDownloading;
@synthesize fileDocDirectory;
@synthesize fileName;
@synthesize fileURL;

-(void)dealloc
{
    [_progress release];
    [super dealloc];
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        self.progress = [[UIProgressView alloc] initWithFrame:CGRectMake(230, 18, 50, 10)];
        [self addSubview:self.progress];
        [self.progress setHidden:YES];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    if(self.isDownloading == NO)
    {
        //不在下载则判断文件是否存在
    }else{
        //判断是否在下载,如果是则取消
    }

    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

#pragma mark DownLoad Delegate
-(NSString *)fileName
{
    return self.fileName;
}

-(NSString *)fileDocDirectory
{
    return self.fileDocDirectory;
}

-(NSURL *)fileURL
{
    return self.fileURL;
}

-(UIProgressView *)setProgress
{
    return self.progress;
}

-(void)finishedDownload:(NSString *)fileDirectory
{
    
}

@end
