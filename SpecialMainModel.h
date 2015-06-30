//
//  SpecialMainModel.h
//  MyFreeLimit爱限免
//
//  Created by qianfeng on 14-9-4.
//  Copyright (c) 2014年 Qianfeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SpecialMainModel : NSObject

@property (retain,nonatomic) UIImage* topicImage;
@property (retain,nonatomic) UIImage* editHead;
@property (retain,nonatomic) NSString* topicName;
//小编评论
@property (retain,nonatomic) NSString* desc;

@property (retain,nonatomic) NSMutableArray* arrayApps;

@end
