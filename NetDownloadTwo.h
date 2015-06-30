//
//  NetDownloadTwo.h
//  MyFreeLimit爱限免
//
//  Created by qianfeng on 14-9-4.
//  Copyright (c) 2014年 Qianfeng. All rights reserved.
//

#import <Foundation/Foundation.h>


@protocol NetDownloadDelegate2 <NSObject>

- (void)finishDownload:(NSData*)data andFirstTag:(NSInteger)tag0 andSecondTag:(NSInteger)tag1;

@end

@interface NetDownloadTwo : NSObject
{
    NSMutableData* _mData;
}
@property (assign,nonatomic)NSInteger tag;
@property (assign,nonatomic)NSInteger secTag;
@property (assign,nonatomic) id<NetDownloadDelegate2> delegate;

- (void)downloadWithstrUrl:(NSString*)strUrl;
- (void)downloadWithstrUrl:(NSString*)strUrl andSecondTag:(NSInteger)tag;
@end
