//
//  CategoryCell.m
//  MyFreeLimit爱限免
//
//  Created by qianfeng on 14-9-6.
//  Copyright (c) 2014年 Qianfeng. All rights reserved.
//

#import "CategoryCell.h"

@implementation CategoryCell

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


- (void)setModel:(CategoryModel *)model
{
    _allApps.text=model.allAPPsNum;
    _limitFreeApps.text=model.limitFreeAppsNum;
    _catagoryIcon.image=model.categoryIcon;
    _categoryName.text=model.categoryName;
}

@end
