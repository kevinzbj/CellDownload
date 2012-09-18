//
//  DownLoad.m
//  CellDownload
//
//  Created by Zhang Yan on 12-9-17.
//  Copyright (c) 2012年 Zhang Yan. All rights reserved.
//

#import "DownLoad.h"
#import "ASIHTTPRequest.h"

@interface DownLoad()
@property (retain, nonatomic) ASIHTTPRequest *request;
@property (assign, nonatomic) NSString *fileDocDirectory;
@property (assign, nonatomic) NSString *fileTmpDocDirectory;
@end

@implementation DownLoad
@synthesize delegate;
@synthesize request = _request;
@synthesize fileDocDirectory = _fileDocDirectory;
@synthesize fileTmpDocDirectory = _fileTmpDocDirectory;

-(NSString *)fileDocDirectory
{
    if([self.delegate respondsToSelector:@selector(setFileDirectory)])
    {
        _fileDocDirectory = [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:[[DocumentDirectory stringByAppendingPathComponent:[self.delegate setFileDirectory]] stringByAppendingPathComponent:[self.delegate setFileName]]];
    }else{
        _fileDocDirectory = [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:[DocumentDirectory stringByAppendingPathComponent:[self.delegate setFileName]]];
    }
    return _fileDocDirectory;
}

-(ASIHTTPRequest *)request
{
    if(_request == nil)
    {
        _request = [[ASIHTTPRequest alloc] init];
        [_request setDelegate:self];
    }
    return _request;
}

-(void)dealloc
{
    [_request release];
    [super dealloc];
}

#pragma mark DownLoad Function
-(BOOL)makeDir
{
    NSArray *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = nil;
    NSString *documentsTempDirectory = nil;
    if([self.delegate respondsToSelector:@selector(setFileDirectory)])
    {
        self.fileTmpDocDirectory = [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:[[DocumentTempDirectory stringByAppendingPathComponent:[self.delegate setFileDirectory]] stringByAppendingPathComponent:[self.delegate setFileName]]];
        documentsDirectory = [[[path objectAtIndex:0] stringByAppendingPathComponent:DocumentDirectory] stringByAppendingPathComponent:[self.delegate setFileDirectory]];
        documentsTempDirectory = [[[path objectAtIndex:0] stringByAppendingPathComponent:DocumentTempDirectory] stringByAppendingPathComponent:[self.delegate setFileDirectory]];
    }else{
        self.fileTmpDocDirectory = [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:[DocumentTempDirectory stringByAppendingPathComponent:[self.delegate setFileName]]];
        
        documentsDirectory = [[path objectAtIndex:0] stringByAppendingPathComponent:DocumentDirectory];
        documentsTempDirectory = [[path objectAtIndex:0] stringByAppendingPathComponent:DocumentTempDirectory];
    }
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    return [fileManager createDirectoryAtPath:documentsDirectory withIntermediateDirectories:YES attributes:nil error:nil] && [fileManager createDirectoryAtPath:documentsTempDirectory withIntermediateDirectories:YES attributes:nil error:nil];
}

-(BOOL)checkFileIsExist
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    return [fileManager fileExistsAtPath:self.fileDocDirectory];
}


-(void)startDownload
{
    [self makeDir];
    if(![self checkFileIsExist])
    {
        self.request = [ASIHTTPRequest requestWithURL:[self.delegate setFileURL]];
        [self.request setDelegate:self];
        [self.request setDownloadDestinationPath:self.fileDocDirectory];
        [self.request setTemporaryFileDownloadPath:self.fileTmpDocDirectory];
        [self.request setDownloadProgressDelegate:[self.delegate setProgress]];
        [self.request setAllowResumeForFileDownloads:YES];
        [[self.delegate setProgress] setHidden:NO];
        [self.request startAsynchronous];
    }else
    {
        [self.delegate finishedDownload:self.fileDocDirectory];
    }
}

-(void)stopDownload
{
    [self.request clearDelegatesAndCancel];
}

-(NSString *)getDocument
{
    if([self checkFileIsExist])
    {
        return self.fileDocDirectory;
    }
    else
    {
        return nil;
    }
}

-(void)clearCache
{
    
}

-(void) deleteFile
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    [fileManager removeItemAtPath:self.fileDocDirectory error:nil];
    [fileManager removeItemAtPath:self.fileTmpDocDirectory error:nil];
}

#pragma mark ASIHTTPRequest Delegate
- (void)requestFinished:(ASIHTTPRequest *)request
{
    [[self.delegate setProgress] setHidden:YES];
    if([request responseStatusCode] == 404)
    {
        //删除文件
        [self deleteFile];
        UIAlertView* aview = [[UIAlertView alloc] initWithTitle:@"错误" message:@"文件不存在" delegate:self cancelButtonTitle:@"确认" otherButtonTitles:nil, nil];
        [aview show];
        [aview release];
    }
    else if([request responseStatusCode] == 200 || [request responseStatusCode] == 206)
    {
        [self.delegate finishedDownload:self.fileDocDirectory];
    }
}


-(void)requestFailed:(ASIHTTPRequest *)request
{
    [[self.delegate setProgress] setHidden:YES];
    if([[request error] code] == 1)
    {
        UIAlertView* aview = [[UIAlertView alloc] initWithTitle:@"错误" message:@"下载失败，无网络" delegate:self cancelButtonTitle:@"确认" otherButtonTitles:nil, nil];
        [aview show];
        [aview release];
    }
    
}


@end
