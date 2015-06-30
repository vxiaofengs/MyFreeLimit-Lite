//
//  AppListCell.h
//  MyFreeLimit爱限免
//
//  Created by qianfeng on 14-9-6.
//  Copyright (c) 2014年 Qianfeng. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "GeneralCellModel.h"

@interface AppListCell : UITableViewCell

{
    NSMutableData* _dataImage;
    
    UIImageView* starBelowView;
    UIView* view;
    UIImageView* starForeView;
    NSTimer* _timer;
}



@property (weak, nonatomic) IBOutlet UIImageView *appIcon;
@property (weak, nonatomic) IBOutlet UILabel *appName;
@property (weak, nonatomic) IBOutlet UILabel *downloadCount;
@property (weak, nonatomic) IBOutlet UILabel *curPrice;
@property (weak, nonatomic) IBOutlet UILabel *appExpireTime;
@property (weak, nonatomic) IBOutlet UILabel *category;
@property (weak, nonatomic) IBOutlet UILabel *lastPrice;
@property (weak, nonatomic) IBOutlet UILabel *priceState;

@property (retain,nonatomic) NSString* catCName;

@property (retain,nonatomic) GeneralCellModel* Model;
@end
