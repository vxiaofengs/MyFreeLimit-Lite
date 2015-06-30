//
//  GeneralCellModel.h
//  MyFreeLimit爱限免
//
//  Created by qianfeng on 14-9-7.
//  Copyright (c) 2014年 Qianfeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GeneralCellModel : NSObject

@property (retain,nonatomic) NSString* appName;
@property (retain,nonatomic) NSString* appID;
@property (retain,nonatomic) NSString* appCurPrice;
@property (retain,nonatomic) NSString* appLastPrice;
@property (retain,nonatomic) NSString* appIconUrl;
@property (retain,nonatomic) NSString* appExpireTime;
@property (retain,nonatomic) NSString* appDownloads;
@property (retain,nonatomic) NSString* appInfo;
@property (retain,nonatomic) NSString* appSize;
@property (retain,nonatomic) NSString* appCategory;
@property (retain,nonatomic) NSString* appStarNum;
@property (retain,nonatomic) NSString* priceState;

@property (retain,nonatomic) UIImage* image;
@property (retain,nonatomic) NSURLConnection* connect;
@property (retain,nonatomic) NSMutableData* mData;
@end
