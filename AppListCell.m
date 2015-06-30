//
//  AppListCell.m
//  MyFreeLimit爱限免
//
//  Created by qianfeng on 14-9-6.
//  Copyright (c) 2014年 Qianfeng. All rights reserved.
//

#import "AppListCell.h"

@implementation AppListCell


- (void)awakeFromNib
{
    self.backgroundColor=[UIColor groupTableViewBackgroundColor];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}



- (void)remainingTime
{
    if (_timer!=nil) {
        [_timer invalidate];
        _timer=nil;
    }
    _timer=[NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(updateTimer) userInfo:nil repeats:YES];
}


- (void)updateTimer
{
    [self timeAct];
}


- (void)timeAct
{
    NSDateFormatter* formatter=[[NSDateFormatter alloc]init];
    
    [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss.S"];
    
    NSDate* curDate=[formatter dateFromString:_Model.appExpireTime];
    NSInteger seconds=[curDate timeIntervalSinceNow];
    NSInteger day_temp=seconds/(60*60*24);
    NSInteger hour_temp=seconds/(60*60)-day_temp*24;
    NSInteger minute_temp=seconds/60-day_temp*24*60-hour_temp*60;
    NSInteger seconds_temp=seconds-day_temp*24*60*60-hour_temp*60*60-minute_temp*60;
    NSString* strTime=[NSString stringWithFormat:@"%d天%d小时%d分%d秒",day_temp,hour_temp,minute_temp,seconds_temp];
    
    if (curDate==nil) {
        _appExpireTime.text=nil;
    }
    else
    {
        _appExpireTime.text=strTime;
    }
}


- (void)createStarView
{
    //解决复用cell图层添加bug
    //cell只会从nib中awake一次就会不被再创建而多次复用
    
    NSLog(@"starBelow=====%@",starBelowView);
    if (starForeView!=nil) {
        [starForeView removeFromSuperview];
    }
    if ((view!= nil)) {
        [view removeFromSuperview];
    }
    if (starBelowView!=nil) {
        [starBelowView removeFromSuperview];
    }
    
    CGFloat starNum=[(NSString*)_Model.appStarNum floatValue];
    starBelowView=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"StarsBackground"]];
    starBelowView.frame=CGRectMake(85, 30, starBelowView.bounds.size.width, starBelowView.bounds.size.height);
    
    view=[[UIView alloc]initWithFrame:CGRectMake(85, 30, starNum*13,starBelowView.bounds.size.height )];
    
    view.clipsToBounds=YES;
    starForeView=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"StarsForeground"]];
    
    starForeView.frame=CGRectMake(0, 0, starBelowView.bounds.size.width, starBelowView.bounds.size.height);
    
    [view addSubview:starForeView];
    [self addSubview:starBelowView];
    [self addSubview:view];
    
}




-(void)setModel:(GeneralCellModel*)Model

{
    _Model=Model;
    
    _appName.text=Model.appName;
    _downloadCount.text=Model.appDownloads;
    
    _appIcon.image=Model.image;
    _category.text=Model.appCategory;
    
    
    if ([Model.priceState isEqualToString:@"free"]) {
        _priceState.text=@"免费";
    }
    else if ([Model.priceState isEqualToString:@"limited"]) {
        _priceState.text=@"限免";
    }
    else if ([Model.priceState isEqualToString:@"sales"]) {
        _priceState.text=@"降价";
    }
    else
        _priceState.text=nil;
    
    
    
    [self createStarView];
    
    
    //是否存在原价
    if (Model.appLastPrice!=nil) {
        _lastPrice.text=[NSString stringWithFormat:@"原价:%@",Model.appLastPrice];
    }
    else
    {
        _lastPrice.text=nil;
    }
    
    //是否存在现价
    if (Model.appCurPrice!=nil) {
        _curPrice.text=[NSString stringWithFormat:@"现价:  %@",Model.appCurPrice];
    }
    else
    {
        _curPrice.text=nil;
    }
    
    
    //限时(显示倒计时)
    
    if (_appExpireTime.text!=nil) {
        _appExpireTime.text=nil;
    }
    
    if (_timer!=nil) {
        [_timer invalidate];
        _timer=nil;
    }
    
    if ([Model.priceState isEqualToString:@"limited"]==YES) {
        [self timeAct];
        [self remainingTime];
    }
    
    else
    {
        _appExpireTime.text=nil;
    }
    
    
    
    //免费
    if ([Model.priceState isEqualToString:@"free"]) {
        _curPrice.text=nil;
        _lastPrice.text=nil;
    }
    
    
}

@end
