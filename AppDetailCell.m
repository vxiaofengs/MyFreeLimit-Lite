//
//  AppDetailCell.m
//  MyFreeLimit爱限免
//
//  Created by qianfeng on 14-9-3.
//  Copyright (c) 2014年 Qianfeng. All rights reserved.
//

#import "AppDetailCell.h"

#import "CONST.h"


@implementation AppDetailCell

- (void)awakeFromNib
{
    _scroll=[[UIScrollView alloc]init];
    _scroll.frame=CGRectMake(10, 145, 300, 150);
    
    UITapGestureRecognizer* tap=[[UITapGestureRecognizer alloc]init];
    [_scroll addGestureRecognizer:tap];
    [tap addTarget:self action:@selector(tapAct:)];
    [self addSubview:_scroll];
 
}



- (void)tapAct:(UITapGestureRecognizer*)tap
{
    SnapImageViewController* snapVC=[[SnapImageViewController alloc]init];
    snapVC.appId=_model.appID;
    [_delegate loadSnapImageVC:snapVC];
}



-(void)setModel:(SelectAppDetialModel *)Model
{
    _arrayImage=[[NSMutableArray alloc]init];
    _model=Model;
    _appName.text=Model.appName;
    _appSize.text=Model.appSize;
    
    _lastPrice.text=[NSString stringWithFormat:@"原价:%@元",Model.appLastPrice];
    _curPrice.text=[NSString stringWithFormat:@"现价:%@元",Model.appCurPrice];

    _appIcon.image=Model.imageIcon;
    _appCatogory.text=Model.appCategory;
    
    _strAppIDtemp=Model.appID;
    
    UILabel* labelInfo=[[UILabel alloc]init];
    NSString* strInfo=Model.appInfo;
    CGSize textSize=[strInfo sizeWithFont:[UIFont systemFontOfSize:14] constrainedToSize:CGSizeMake(300, 1000)];
    
    
    labelInfo.frame=CGRectMake(3, 0, textSize.width, textSize.height);
    labelInfo.text=strInfo;
    labelInfo.numberOfLines=0;
    labelInfo.font=[UIFont systemFontOfSize:14];
    
    
    _appInfoScroll.contentSize=textSize;
    _appInfoScroll.layer.borderWidth=0.5;
    
    _appInfoScroll.layer.borderColor=[UIColor grayColor].CGColor;
    
                                                           
    _appInfoScroll.layer.cornerRadius=5;
    
    [_appInfoScroll addSubview:labelInfo];
    
    
    NSString* priceState=Model.appPriceTrend;
    
    if ([priceState isEqualToString:@"limited"]) {
        _priceState.text=@"限免中";
    }
    else if([priceState isEqualToString:@"free"]){
        _priceState.text=@"免费";
        _curPrice.text=nil;
        _lastPrice.text=nil;
    }
    else
    {
        _priceState.text=@"促销中";
    }
    
    
  
    [self createStars];
    
    
    if (_strAppIDtemp!=nil) {
        [self createBtn];
    }
}

- (void)createBtn
{
    [_shareBtn setBtnState:@"分享" andNoSelectedImage:[UIImage imageNamed:@"6.应用详情_12.png"] andSelectedImage:[UIImage imageNamed:@"6.应用详情_12.png"]];

    
    NSUserDefaults* user=[NSUserDefaults standardUserDefaults];
    
    if ([user objectForKey:_strAppIDtemp] ) {
        if ([[user objectForKey:_strAppIDtemp] isEqualToString:@"1"]) {
            _likeBtn.isSelected=YES;
        }
        else{
            _likeBtn.isSelected=NO;
        }
    }
    
    [_likeBtn setBtnState:@"收藏" andNoSelectedImage:[UIImage imageNamed:@"6.应用详情_09.png"] andSelectedImage:[UIImage imageNamed:@"clickLike.png"]];
    [_likeBtn addTarget:self action:@selector(pressLike) forControlEvents:UIControlEventValueChanged];

    
    [_downloadBtn setBtnState:@"下载" andNoSelectedImage:[UIImage imageNamed:@"6.应用详情_15.png"] andSelectedImage:[UIImage imageNamed:@"6.应用详情_15.png"]];
 
}

- (void)pressLike
{
    NSUserDefaults* user=[NSUserDefaults standardUserDefaults];
    if ([user objectForKey:_strAppIDtemp]) {
        if ([[user objectForKey:_strAppIDtemp] isEqualToString:@"1"]) {
            [user setObject:@"0" forKey:_strAppIDtemp];
        }
        else
        {
            [user setObject:@"1" forKey:_strAppIDtemp];
        }
    }
    else
    {
        [user setObject:@"1" forKey:_strAppIDtemp];
    }
    
    [user synchronize];
}




- (void)createStars
{
    
    if (starForeView!=nil) {
        [starForeView removeFromSuperview];
    }
    if ((view!= nil)) {
        [view removeFromSuperview];
    }
    if (starBelowView!=nil) {
        [starBelowView removeFromSuperview];
    }
    
    
    CGFloat starNum=[(NSString*)_model.appStarNum floatValue];
    starBelowView=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"StarsBackground"]];
    starBelowView.frame=CGRectMake(106, 40, starBelowView.bounds.size.width, starBelowView.bounds.size.height);
    
    view=[[UIView alloc]initWithFrame:CGRectMake(106, 40, starNum*13, starBelowView.bounds.size.height)];
    view.clipsToBounds=YES;
    starForeView=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"StarsForeground"]];
    
    starForeView.frame=CGRectMake(0, 0,starBelowView.bounds.size.width, starBelowView.bounds.size.height);
    [view addSubview:starForeView];
   
    [self addSubview:starBelowView];
    [self addSubview:view];
}


- (void)setSnapImage:(NSMutableArray*)array
{
    _scroll.contentSize=CGSizeMake(103*array.count+10, 150);
    _scroll.contentOffset=CGPointMake(10, 0);
    
    for (int i=0; i<array.count; i++) {
        UIImageView* iView=[[UIImageView alloc]initWithFrame:CGRectMake(10+103*i, 0, 100, 150)];
        iView.image=array[i];
        [_scroll addSubview:iView];
    }
}





- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
