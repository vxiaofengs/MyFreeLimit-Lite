//
//  SpecialMainCell.m
//  MyFreeLimit爱限免
//
//  Created by qianfeng on 14-9-4.
//  Copyright (c) 2014年 Qianfeng. All rights reserved.
//

#import "SpecialMainCell.h"
#import "SpecialDetailCell.h"
#import "SelectAppDetial.h"

@implementation SpecialMainCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        
        _topicIcon=[[UIImageView alloc]init];
        _topicIcon.frame=CGRectMake(5, 30, 150, 215);
      
        
        _topicName=[[UILabel alloc]init];
        _topicName.frame=CGRectMake(5, 5, 320, 20);
        _topicName.font=[UIFont boldSystemFontOfSize:18];
        _topicName.textAlignment=NSTextAlignmentLeft;
        
        
        _editorHead=[[UIImageView alloc]initWithFrame:CGRectMake(5, 250, 50, 50)];
        
        
        _editorDes=[[UILabel alloc]initWithFrame:CGRectMake(60, 250, 260, 50)];
        _editorDes.numberOfLines=0;
        _editorDes.font=[UIFont systemFontOfSize:10];
        
        
        _tableView=[[UITableView alloc]initWithFrame:CGRectMake(156, 30, 150, 220) style:UITableViewStylePlain];
        _tableView.delegate=self;
        _tableView.dataSource=self;
        _tableView.scrollEnabled=NO;
        
        
        [self.contentView addSubview:_editorDes];
        [self.contentView addSubview:_editorHead];
        [self.contentView addSubview:_topicIcon];
        [self.contentView addSubview:_topicName];
        [self.contentView addSubview:_tableView];
    }
    return self;
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _arrayData.count;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    SpecialDetailModel* model=[_arrayData objectAtIndex:indexPath.row];
    SelectAppDetial* select=[[SelectAppDetial alloc]init];
    select.appID=model.appID;
    
    [_delegate detailCellClicked:select];
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString* strID=@"ID";
    SpecialDetailCell* cell=[tableView dequeueReusableCellWithIdentifier:strID];
    if (cell==nil) {
        cell=[[SpecialDetailCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:strID];
    }
    
    SpecialDetailModel* model=[_arrayData objectAtIndex:indexPath.row];
    
    [cell setData:model];
    
    return cell;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 54;
}


- (void)setData:(SpecialMainModel*)model
{
    _topicIcon.image=model.topicImage;
    _topicName.text=model.topicName;
    _editorHead.image=model.editHead;
    _editorDes.text=model.desc;
    
    _arrayData=model.arrayApps;
    [_tableView reloadData];
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
