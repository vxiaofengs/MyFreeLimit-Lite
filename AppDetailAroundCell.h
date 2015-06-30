//
//  AppDetailAroundCell.h
//  MyFreeLimit爱限免
//
//  Created by qianfeng on 14-9-3.
//  Copyright (c) 2014年 Qianfeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SelectAppDetial;

@protocol AroundCellDelegate <NSObject>

- (void)pushDetailViewFromAroundCell:(SelectAppDetial*)vc;

@end



@interface AppDetailAroundCell : UITableViewCell
{
    NSMutableArray* _arrayAppID;
}

@property (weak, nonatomic) IBOutlet UIImageView *appImage0;
@property (weak, nonatomic) IBOutlet UIImageView *appImage1;
@property (weak, nonatomic) IBOutlet UIImageView *appImage2;
@property (weak, nonatomic) IBOutlet UIImageView *appImage3;
@property (weak, nonatomic) IBOutlet UIImageView *appImage4;



@property (weak, nonatomic) IBOutlet UILabel *AroundShowLabel;

@property (weak, nonatomic) IBOutlet UILabel *appName0;
@property (weak, nonatomic) IBOutlet UILabel *appName1;
@property (weak, nonatomic) IBOutlet UILabel *appName2;
@property (weak, nonatomic) IBOutlet UILabel *appName3;
@property (weak, nonatomic) IBOutlet UILabel *appName4;


- (void)setAroundIcons:(NSMutableArray*)array;
- (void)setAroundNames:(NSMutableArray*)arrayName andID:(NSMutableArray*)arrayID;

@property (assign,nonatomic) id<AroundCellDelegate>delegate;


@end
