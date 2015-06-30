//
//  NetDownload.h
//  MyFreeLimit爱限免
//
//  Created by qianfeng on 14-9-3.
//  Copyright (c) 2014年 Qianfeng. All rights reserved.
//

#import <Foundation/Foundation.h>


@protocol NetDownloadDelegate <NSObject>

- (void)finishDownload:(NSData*)data andTag:(NSInteger)tag;

@end



@interface NetDownload : NSObject <NSURLConnectionDelegate,NSURLConnectionDataDelegate>
{
    NSMutableData* _mData;
}
@property (assign,nonatomic)NSInteger tag;
@property (assign,nonatomic)NSInteger viewTag;
@property (assign,nonatomic) id<NetDownloadDelegate> delegate;

- (void)downloadWithstrUrl:(NSString*)strUrl;
@end
