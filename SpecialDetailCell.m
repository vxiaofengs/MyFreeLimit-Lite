//
//  SpecialDetailCell.m
//  MyFreeLimit爱限免
//
//  Created by qianfeng on 14-9-4.
//  Copyright (c) 2014年 Qianfeng. All rights reserved.
//

#import "SpecialDetailCell.h"

@implementation SpecialDetailCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        
        _appIcon=[[UIImageView alloc]initWithFrame:CGRectMake(5, 5, 30, 30)];
        _appIcon.backgroundColor=[UIColor blueColor];
        
        _appName=[[UILabel alloc]init];
        _appName.frame=CGRectMake(40, 10, 100, 15);
        _appName.font=[UIFont systemFontOfSize:12];
        _appName.textAlignment=NSTextAlignmentLeft;

        
        _appScore=[[UILabel alloc]init];
        _appScore.frame=CGRectMake(40, 28, 60, 20);
        _appScore.font=[UIFont systemFontOfSize:10];
        _appScore.textAlignment=NSTextAlignmentLeft;
        
        _appDownloadCounts=[[UILabel alloc]initWithFrame:CGRectMake(120, 28, 60, 20)];
        _appDownloadCounts.font=[UIFont systemFontOfSize:10];
        _appDownloadCounts.textAlignment=NSTextAlignmentLeft;
        
        UIImageView* iView=[[UIImageView alloc]initWithFrame:CGRectMake(100, 32, 10, 10)];
        iView.image=[UIImage imageNamed:@"123.png"];
        
        [self.contentView addSubview:iView];
        [self.contentView addSubview:_appDownloadCounts];
        [self.contentView addSubview:_appIcon];
        [self.contentView addSubview:_appName];
        [self.contentView addSubview:_appScore];
    }
    return self;
}


- (void)setData:(SpecialDetailModel*)model
{
    _appScore.text=[NSString stringWithFormat:@"评分:%@",model.appScore];
    _appIcon.image=model.appImage;
    _appName.text=model.appName;
    _appDownloadCounts.text=model.appDowmloadCounts;
}


- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
