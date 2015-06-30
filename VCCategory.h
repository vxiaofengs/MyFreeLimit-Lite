//
//  VCCategory.h
//  MyFreeLimit爱限免
//
//  Created by qianfeng on 14-9-5.
//  Copyright (c) 2014年 Qianfeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NetDownload.h"
#import "MyImageDownload.h"

@interface VCCategory : UIViewController <UITableViewDataSource,UITableViewDelegate,NetDownloadDelegate,MyImageDownloadDelegate>
{
    UITableView* _tableView;
    NSMutableArray* _arrayData;
    NSMutableArray* _arrayConnect;
}


@property (retain,nonatomic) NSString* categoryVCPushInterface;
@property (retain,nonatomic) NSString* categoryVCFromCName;
@property (retain,nonatomic) NSString* categoryVCFromEName;

@end
