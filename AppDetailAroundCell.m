//
//  AppDetailAroundCell.m
//  MyFreeLimit爱限免
//
//  Created by qianfeng on 14-9-3.
//  Copyright (c) 2014年 Qianfeng. All rights reserved.
//

#import "AppDetailAroundCell.h"
#import "SelectAppDetial.h"

@implementation AppDetailAroundCell

- (void)awakeFromNib
{
    _AroundShowLabel.layer.cornerRadius=2;
    _AroundShowLabel.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"6.应用详情_0.png"]];
    [self addSubview:_AroundShowLabel];
}


- (void)setAroundIcons:(NSMutableArray*)array
{
    NSArray* arrayImg=[NSArray arrayWithObjects:_appImage0,_appImage1,_appImage2,_appImage3,_appImage4, nil];
    if ([array count]) {
        for (int i=0; i<array.count; i++) {
            ((UIImageView*)arrayImg[i]).image=array[i];
            ((UIImageView*)arrayImg[i]).tag=i;
            UITapGestureRecognizer* tap=[[UITapGestureRecognizer alloc]init];
            [tap addTarget:self action:@selector(tapAct:)];
            [((UIImageView*)arrayImg[i]) addGestureRecognizer:tap];
            ((UIImageView*)arrayImg[i]).userInteractionEnabled=YES;
        }
    }
}


- (void)setAroundNames:(NSMutableArray*)arrayName andID:(NSMutableArray*)arrayID
{
    _arrayAppID=arrayID;
    NSArray* arrayImg=[NSArray arrayWithObjects:_appName0,_appName1,_appName2,_appName3,_appName4,nil];
    if ([arrayName count]) {
        for (int i=0; i<arrayName.count; i++) {
            ((UILabel*)arrayImg[i]).text=arrayName[i];
        }
    }
}

- (void)tapAct:(UITapGestureRecognizer*)tap
{
    SelectAppDetial* detail=[[SelectAppDetial alloc]init];
    detail.appID=[_arrayAppID objectAtIndex:tap.view.tag];
    [_delegate pushDetailViewFromAroundCell:detail];
}






- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
