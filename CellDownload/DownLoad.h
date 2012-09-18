//
//  DownLoad.h
//  CellDownload
//
//  Created by Zhang Yan on 12-9-17.
//  Copyright (c) 2012年 Zhang Yan. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol DownLoadDelegate
-(NSString *)setFileName;
-(NSURL *)setFileURL;
-(UIProgressView *)setProgress;
-(void)finishedDownload:(NSString *)fileDirectory;
@optional
-(NSString *)setFileDirectory;

@end

#define DocumentDirectory @"DownloadFile"
#define DocumentTempDirectory @"TmpDownloadFile"

@interface DownLoad : NSObject
@property (assign, nonatomic) id<DownLoadDelegate> delegate;
-(void) startDownload;
-(void) stopDownload;
-(void) clearCache;
-(NSString *) getDocument;

@end
