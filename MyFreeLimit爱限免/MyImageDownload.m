//
//  MyImageDownload.m
//  MyFreeLimit爱限免
//
//  Created by qianfeng on 14-9-5.
//  Copyright (c) 2014年 Qianfeng. All rights reserved.
//

#import "MyImageDownload.h"
#import "NSString+Hashing.h"

@implementation MyImageDownload

- (NSString*)getFullPath:(NSString*) strImageURL
{
    NSString* strHome=[NSHomeDirectory() stringByAppendingString:@"/Library/Cache/QFCache"];
    
    NSString* strMD5=[strImageURL MD5Hash];
    
    NSString* strFullPath=[NSString stringWithFormat:@"%@/%@",strHome,strMD5];
    
    return strFullPath;
}


//是否存在相同图片
- (BOOL)isHasImageInCache:(NSString*)strImageURL
{
    NSString* strFullPath=[self getFullPath:strImageURL];
    
    BOOL isExit=[[NSFileManager defaultManager]fileExistsAtPath:strFullPath];
    
    return isExit;
}


//判断图片是否过期
- (BOOL) isTimeOut:(NSString*)strImageURL
{
    NSString* strFullPath=[self getFullPath:strImageURL];
    NSFileManager* fm=[NSFileManager defaultManager];
    NSDictionary* dicFile=[fm attributesOfItemAtPath:strFullPath error:nil];
    NSDate* dateFile=[dicFile objectForKey:NSFileModificationDate];
    NSTimeInterval curTime=[[NSDate date] timeIntervalSince1970];
    NSTimeInterval lasTime=[dateFile timeIntervalSince1970];
    if ((curTime-lasTime)>24*60*7*60) {
        return YES;
    }
    
    return NO;
}


//判断是否可使用缓存文件
- (BOOL)isUseCacheFile:(NSString*) strImageURL
{
    if ([self isHasImageInCache:strImageURL]) {
        if ([self isTimeOut:strImageURL]) {
            return YES;
        }
    }
    return NO;
}


-(void)downloadImage:(NSString *)strURL tag:(NSUInteger)tag ID:(NSString *)strID
{
    _strID=strID;
    _tag=tag;
    _strImageURL=strURL;
    
    if ([self isUseCacheFile:strURL]==YES) {
        UIImage* image=[self readFileFromCache:strURL];
        if (_delegate) {
            [_delegate finishImageDownload:image withTag:_tag andID:_strID];
        }
    }
    else
    {
        [self startConnect:strURL];
    }

}


- (void) startConnect:(NSString*) strImageURL
{
    NSURL* url=[NSURL URLWithString:strImageURL];
    _data=[[NSMutableData alloc]init];
    
    //超60s断开连接
    NSURLRequest* request=[NSURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:60];
    _connect=[NSURLConnection connectionWithRequest:request delegate:self];
//    _connect=[[NSURLConnection alloc]initWithRequest:request delegate:self];
}


- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [_data appendData:data];
}



- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    if (_delegate!=nil) {
        UIImage* image=[UIImage imageWithData:_data];
        [_delegate finishImageDownload:image withTag:_tag andID:_strID];
        
        //保存到本地
        [self saveImage:_data withURL:_strImageURL];
    }
}



- (void)saveImage:(NSData*)data withURL:(NSString*)imageURL
{
    
    NSString* strHome=[NSHomeDirectory() stringByAppendingString:@"/Library/Cache/QFCache"];
    
    NSFileManager* fm=[NSFileManager defaultManager];

    [fm createDirectoryAtPath:strHome withIntermediateDirectories:YES attributes:nil error:nil];

    NSString* strFullPath=[self getFullPath:imageURL];
    [data writeToFile:strFullPath atomically:YES];
}




- (UIImage*)readFileFromCache:(NSString*)strURL
{
    NSString* strPath=[self getFullPath:strURL];
    NSData* data=[NSData dataWithContentsOfFile:strPath];
    UIImage* image=[UIImage imageWithData:data];
    return image;
}




@end
