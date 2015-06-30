//
//  SelectAppDetial.h
//  MyFreeLimit爱限免
//
//  Created by qianfeng on 14-9-3.
//  Copyright (c) 2014年 Qianfeng. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "GeneralCellModel.h"
#import "NetDownload.h"
#import "SelectAppDetialModel.h"
#import "AppDetailCell.h"
#import "AppDetailAroundCell.h"

@interface SelectAppDetial : UIViewController <NetDownloadDelegate,UITableViewDataSource,UITableViewDelegate,snapImageDeledate,AroundCellDelegate>
{
    NSMutableArray* _arrayImageStr;
    NSMutableArray* _arrayImage;
    
   
    
    
    UITableView* _tableView;
    NSMutableArray* _arrayConnect;
    
    NSMutableArray* _arrAroundName;
    NSMutableArray* _arrAroundIcon;
    NSMutableArray* _arrAroundIconStr;
    NSMutableArray* _arrAroundAppID;
    
    NSMutableArray* _detailModelArr;
    
}


@property (retain,nonatomic) SelectAppDetialModel* detailModel;
@property (retain,nonatomic) NSString* appID;
@end
