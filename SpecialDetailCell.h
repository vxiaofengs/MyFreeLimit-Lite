//
//  SpecialDetailCell.h
//  MyFreeLimit爱限免
//
//  Created by qianfeng on 14-9-4.
//  Copyright (c) 2014年 Qianfeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SpecialDetailModel.h"


@interface SpecialDetailCell : UITableViewCell

@property (retain,nonatomic) UIImageView* appIcon;
@property (retain,nonatomic) UILabel* appName;
@property (retain,nonatomic) UIView* appRate;
@property (retain,nonatomic) UILabel* appScore;
@property (retain,nonatomic) UILabel* appDownloadCounts;


- (void)setData:(SpecialDetailModel*)model;
@end
