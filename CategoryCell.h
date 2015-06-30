//
//  CategoryCell.h
//  MyFreeLimit爱限免
//
//  Created by qianfeng on 14-9-6.
//  Copyright (c) 2014年 Qianfeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CategoryModel.h"
@interface CategoryCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *catagoryIcon;
@property (weak, nonatomic) IBOutlet UILabel *categoryName;
@property (weak, nonatomic) IBOutlet UILabel *allApps;
@property (weak, nonatomic) IBOutlet UILabel *limitFreeApps;


@property (retain,nonatomic)CategoryModel* model;
@end
