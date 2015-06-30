//
//  NetDownloadTwo.m
//  MyFreeLimit爱限免
//
//  Created by qianfeng on 14-9-4.
//  Copyright (c) 2014年 Qianfeng. All rights reserved.
//

#import "NetDownloadTwo.h"

@implementation NetDownloadTwo
- (void)downloadWithstrUrl:(NSString*)strUrl
{
    NSURLRequest* request=[NSURLRequest requestWithURL:[NSURL URLWithString:strUrl]];
    NSURLConnection* connect=[[NSURLConnection alloc]initWithRequest:request delegate:self];
    [connect start];
}


- (void)downloadWithstrUrl:(NSString*)strUrl andSecondTag:(NSInteger)tag
{
    _secTag=tag;
    NSURLRequest* request=[NSURLRequest requestWithURL:[NSURL URLWithString:strUrl]];
    NSURLConnection* connect=[[NSURLConnection alloc]initWithRequest:request delegate:self];
    [connect start];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [_mData appendData:data];
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    NSHTTPURLResponse* res=(NSHTTPURLResponse*)response;
    if (res.statusCode==200) {
        _mData=[[NSMutableData alloc]init];
    }
}

-(void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    [_delegate finishDownload:_mData andFirstTag:self.tag andSecondTag:self.secTag];
}
@end

