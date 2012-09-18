//
//  FileCell.h
//  CellDownload
//
//  Created by Zhang Yan on 12-9-17.
//  Copyright (c) 2012年 Zhang Yan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DownLoad.h"

@interface FileCell : UITableViewCell<DownLoadDelegate>
@property (retain, nonatomic) UIProgressView *progress;
@property (assign, nonatomic) NSString *fileName;
@property (retain, nonatomic) NSURL *fileURL;
@property (assign, nonatomic) NSString *fileDocDirectory;

@property (nonatomic) BOOL isDownloaded;
@property (nonatomic) BOOL isDownloading;

-(void)initArg;

-(void)startDownload;
-(void)stopDownload;
-(NSString *)getDocument;

@end
