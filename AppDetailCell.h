//
//  AppDetailCell.h
//  MyFreeLimit爱限免
//
//  Created by qianfeng on 14-9-3.
//  Copyright (c) 2014年 Qianfeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SelectAppDetialModel.h"
#import "NetDownload.h"
#import "QFCustomButton.h"
#import "SnapImageViewController.h"


@protocol snapImageDeledate <NSObject>

- (void)loadSnapImageVC:(SnapImageViewController*)vc;

@end




@interface AppDetailCell : UITableViewCell

{
    NSMutableArray* _arrayImage;
    UITableView* _tableView;
    NSMutableArray* _arrAroundIcon;
    UIScrollView* _scroll;
    NSString* _strAppIDtemp;
    
    UIImageView* starBelowView;
    UIView* view;
    UIImageView* starForeView;
}

@property (weak, nonatomic) IBOutlet UIImageView *appIcon;
@property (weak, nonatomic) IBOutlet UIScrollView *appInfoScroll;

@property (weak, nonatomic) IBOutlet UILabel *appName;
@property (weak, nonatomic) IBOutlet UILabel *appSize;
@property (weak, nonatomic) IBOutlet UILabel *appCatogory;
@property (weak, nonatomic) IBOutlet UILabel *lastPrice;
@property (weak, nonatomic) IBOutlet UILabel *curPrice;
@property (weak, nonatomic) IBOutlet UILabel *priceState;


@property (weak, nonatomic) IBOutlet QFCustomButton *shareBtn;
@property (weak, nonatomic) IBOutlet QFCustomButton *likeBtn;
@property (weak, nonatomic) IBOutlet QFCustomButton *downloadBtn;



@property (retain,nonatomic) SelectAppDetialModel* model;
@property (retain,nonatomic) NSMutableArray* arrayConnect;
@property (retain,nonatomic) NSMutableArray* arrAroundName;


@property (assign,nonatomic) id <snapImageDeledate> delegate;

- (void)setSnapImage:(NSMutableArray*)array;




@end
