//
//  NetDownload.m
//  MyFreeLimit爱限免
//
//  Created by qianfeng on 14-9-3.
//  Copyright (c) 2014年 Qianfeng. All rights reserved.
//

#import "NetDownload.h"

@implementation NetDownload

- (void)downloadWithstrUrl:(NSString*)strUrl
{
    NSURLRequest* request=[NSURLRequest requestWithURL:[NSURL URLWithString:strUrl]];
    NSURLConnection* connect=[[NSURLConnection alloc]initWithRequest:request delegate:self];
    
    UIApplication* app=[UIApplication sharedApplication];
    [app setNetworkActivityIndicatorVisible:YES];
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
    [_delegate finishDownload:_mData andTag:self.tag];
    
    UIApplication* app=[UIApplication sharedApplication];
    [app setNetworkActivityIndicatorVisible:NO];
}
@end
