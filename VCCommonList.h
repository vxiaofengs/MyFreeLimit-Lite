//
//  VCCommonList.h
//  MyFreeLimit爱限免
//
//  Created by qianfeng on 14-9-5.
//  Copyright (c) 2014年 Qianfeng. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "NetDownload.h"
#import "LoadMoreTableFooterView.h"
#import "VCCategory.h"
#import "VCSetting.h"
#import "CONST.h"
#import "SelectAppDetial.h"
#import "AppListCell.h"
#import "MyImageDownload.h"
#import "EGORefreshTableHeaderView.h"


#import "MMProgressHUD.h"


@interface VCCommonList : UIViewController <UITableViewDataSource,UITableViewDelegate,NetDownloadDelegate,LoadMoreTableFooterDelegate,MyImageDownloadDelegate,UISearchBarDelegate,UISearchDisplayDelegate>
{
    NSMutableArray* _arrayData;
    UITableView* _tableView;
    
    UIBarButtonItem* _btnSetting;
    //分类按钮
    UIBarButtonItem* _btnCategory;
    
    NSMutableArray* _connectArr;
    
    UISearchBar* _searchBar;
    UISearchDisplayController* _searchDC;
    
    NSMutableArray* _searchResultArr;

    EGORefreshTableHeaderView* _refreshHeader;
    LoadMoreTableFooterView* _loadMoreFooter;
    
}

- (void)configUI;
- (void)pressCategory;

- (void)downMyImage:(NSString*)url model:(GeneralCellModel*)model;

//数据源地址
@property (retain,nonatomic) NSString* mDataURL;

@property (assign,nonatomic) NSInteger IconIndex;
@property (assign,nonatomic)  NSInteger curPage;
@property (assign,nonatomic)  NSInteger pageNum;

@property (retain,nonatomic) NSString* categoryVCFromEName;

@property (retain,nonatomic) NSString* cellShowCName;

@end
