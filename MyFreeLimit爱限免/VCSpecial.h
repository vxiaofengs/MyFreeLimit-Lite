//
//  VCSpecial.h
//  MyFreeLimit爱限免
//
//  Created by qianfeng on 14-9-2.
//  Copyright (c) 2014年 Qianfeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NetDownload.h"
#import "NetDownloadTwo.h"
#import "SpecialMainCell.h"
#import "LoadMoreTableFooterView.h"

@interface VCSpecial : UIViewController <UITableViewDataSource,UITableViewDelegate,NetDownloadDelegate,NetDownloadDelegate2,DetailCellClickedDelegate,LoadMoreTableFooterDelegate>
{
    UITableView* _tableView;
    NSMutableArray* _arrayData;
    NSInteger _curPage;
    
    LoadMoreTableFooterView* _loadMoreFooter;
}
@end
