//
//  MyImageDownload.h
//  MyFreeLimit爱限免
//
//  Created by qianfeng on 14-9-5.
//  Copyright (c) 2014年 Qianfeng. All rights reserved.
//

#import <Foundation/Foundation.h>


@protocol MyImageDownloadDelegate <NSObject>

- (void)finishImageDownload:(UIImage*)image withTag:(NSUInteger)tag andID:(NSString*)ID;

@end



@interface MyImageDownload : NSObject <NSURLConnectionDelegate,NSURLConnectionDataDelegate>
{
    NSURLConnection* _connect;
    
    NSMutableData* _data;
}


//tag来识别下载的对象源
@property (assign,nonatomic) NSUInteger tag;

//字符串ID设定对象标志
@property (retain,nonatomic) NSString* strID;

@property (retain,nonatomic) NSString* strImageURL;

- (void)downloadImage:(NSString*)strURL tag:(NSUInteger)tag ID:(NSString*)strID;

@property (assign,nonatomic)id <MyImageDownloadDelegate> delegate;
@end





