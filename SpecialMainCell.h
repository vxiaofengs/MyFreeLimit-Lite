//
//  SpecialMainCell.h
//  MyFreeLimit爱限免
//
//  Created by qianfeng on 14-9-4.
//  Copyright (c) 2014年 Qianfeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SpecialMainModel.h"
#import "SelectAppDetial.h"

@protocol DetailCellClickedDelegate <NSObject>

- (void)detailCellClicked:(SelectAppDetial*)selector;

@end



@interface SpecialMainCell : UITableViewCell <UITableViewDelegate,UITableViewDataSource>

@property (retain,nonatomic) UIImageView* topicIcon;
@property (retain,nonatomic) UILabel* topicName;

@property (retain,nonatomic) UIImageView* editorHead;
@property (retain,nonatomic) UILabel* editorDes;

@property (retain,nonatomic) UITableView* tableView;

@property (retain,nonatomic) NSMutableArray* arrayData;

@property (assign,nonatomic)id <DetailCellClickedDelegate> delegate;


- (void)setData:(SpecialMainModel*)model;
@end
