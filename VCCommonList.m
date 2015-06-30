//
//  VCCommonList.m
//  MyFreeLimit爱限免
//
//  Created by qianfeng on 14-9-5.
//  Copyright (c) 2014年 Qianfeng. All rights reserved.
//

#import "VCCommonList.h"
#import "MMProgressHUD.h"

#import "SearchResult.h"

@interface VCCommonList ()

@end

@implementation VCCommonList


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        _IconIndex=0;
        _arrayData=[[NSMutableArray alloc]init];
        _curPage=1;
        _pageNum=10;
        _connectArr=[[NSMutableArray alloc]init];
    }
    return self;
}

- (void)viewDidLoad
{
    [self configUI];
    [self loadCellFromHttp];
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}




-(void)viewWillDisappear:(BOOL)animated
{
    [_searchBar setShowsCancelButton:NO animated:NO];
    for (int i=0; i<_connectArr.count; i++) {
        if ([[_connectArr objectAtIndex:i] class]==[MyImageDownload class]) {
            MyImageDownload* net=[_connectArr objectAtIndex:i];
            net.delegate=nil;
        }
        else
        {
            NetDownload* net=[_connectArr objectAtIndex:i];
            net.delegate=nil;
        }
    }
}



- (void)configUI
{
    UIButton* butonCat=[UIButton buttonWithType:UIButtonTypeCustom];
    butonCat.bounds=CGRectMake(0, 0, 24, 24);
    [butonCat setImage:[UIImage imageNamed:@"btn_分类_正常@2x.png"] forState:UIControlStateNormal];
    [butonCat addTarget:self action:@selector(pressCategory) forControlEvents:UIControlEventTouchUpInside];
    _btnCategory=[[UIBarButtonItem alloc]initWithCustomView:butonCat];
    
    
    UIButton* butonSet=[UIButton buttonWithType:UIButtonTypeCustom];
    butonSet.bounds=CGRectMake(0, 0, 25, 25);
    [butonSet setImage:[UIImage imageNamed:@"btn_设置_正常@2x.png"] forState:UIControlStateNormal];
    [butonSet addTarget:self action:@selector(pressSetting) forControlEvents:UIControlEventTouchUpInside];
    _btnSetting=[[UIBarButtonItem alloc]initWithCustomView:butonSet];
    
    
    self.navigationItem.leftBarButtonItem=_btnCategory;
    self.navigationItem.rightBarButtonItem=_btnSetting;
    
    
    _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, 320, 422) style:UITableViewStylePlain];
    _tableView.delegate=self;
    _tableView.dataSource=self;
    
    
    self.edgesForExtendedLayout=UIRectEdgeNone;
    
    
    _searchBar=[[UISearchBar alloc]initWithFrame:CGRectMake(0, 0, 320, 44)];
    _searchBar.delegate=self;
    
    _searchDC=[[UISearchDisplayController alloc]initWithSearchBar:_searchBar contentsController:self];
    _searchDC.searchResultsDelegate=self;
    _searchDC.searchResultsDataSource=self;
    
    
    _loadMoreFooter=[[LoadMoreTableFooterView alloc]initWithFrame:CGRectMake(0, 0, 320, 55) arrowImageName:@"blackArrow" textColor:[UIColor blackColor]];
    
    _loadMoreFooter.delegate=self;
    
    _tableView.tableHeaderView=_searchBar;
    
    [self.view addSubview:_tableView];
}



- (void)pressCategory
{
    VCCategory* category=[[VCCategory alloc]init];
    category.title=@"分类";
    [self.navigationController pushViewController:category animated:YES];
}



- (void)pressSetting
{
    VCSetting* setting=[[VCSetting alloc]init];
    setting.title=@"设置";
    [self.navigationController pushViewController:setting animated:YES];
}



- (void)loadCellFromHttp
{
    _curPage++;
    NSString* strURL=[NSString stringWithFormat:_mDataURL,_curPage,_pageNum];
    NetDownload* _download=[[NetDownload alloc]init];
    [_connectArr addObject:_download];
    
    _download.delegate=self;
    
    [_download downloadWithstrUrl:strURL];
    _download.tag=101;
    
}



-(void)finishDownload:(NSData *)data andTag:(NSInteger)tag
{
    if (tag==101)
    {
        if (data!=nil) {
            NSDictionary* dic=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            [self parseDicData:dic];
        }
    }
    
    
    //Icon下载
    else if(tag>=102 && tag<=200)
    {
        if (data!=nil) {
            int index=tag-102;
            UIImage* image=[UIImage imageWithData:data];
            GeneralCellModel* model=[_arrayData objectAtIndex:index];
            model.image=image;
        }
    }
    
    [_tableView reloadData];
}





-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    NSString* strUrl=SEARCH_GENERAL(self.categoryVCFromEName, _curPage, _searchBar.text);
    
    SearchResult* result=[[SearchResult alloc]init];
    
    result.title=[NSString stringWithFormat:@"[ %@ ]搜索结果",_searchBar.text];
    
    result.searchStr=_searchBar.text;
    
    result.categoryVCFromEName=self.categoryVCFromEName;
    result.mDataURL=strUrl;
    [self.navigationController pushViewController:result animated:YES];
    
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _arrayData.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 72;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    SelectAppDetial* appInfo=[[SelectAppDetial alloc]init];
    GeneralCellModel* model=[_arrayData objectAtIndex:indexPath.row];
    appInfo.appID=model.appID;
    [self.navigationController pushViewController:appInfo animated:YES];
}


- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString* strID=@"ALL";
    AppListCell* cell=[tableView dequeueReusableCellWithIdentifier:strID];
    if (cell==nil) {
        cell=[[NSBundle mainBundle]loadNibNamed:@"AppListCell" owner:self options:nil][0];
    }
    cell.catCName=self.cellShowCName;
    
    GeneralCellModel* model=[_arrayData objectAtIndex:indexPath.row];
    
    [cell setModel:model];
    _tableView.tableFooterView=_loadMoreFooter;
    return cell;
}



-(void)loadMoreTableFooterDidTriggerLoadMore:(LoadMoreTableFooterView *)view
{
    [self loadCellFromHttp];
}

-(void)egoRefreshTableHeaderDidTriggerRefresh:(EGORefreshTableHeaderView *)view
{
    [self loadCellFromHttp];
}

-(NSDate *)egoRefreshTableHeaderDataSourceLastUpdated:(EGORefreshTableHeaderView *)view
{
    return [NSDate date];
}




-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    [_loadMoreFooter loadMoreScrollViewDidEndDragging:scrollView];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [_loadMoreFooter loadMoreScrollViewDidScroll:scrollView];
}




- (void)parseDicData:(NSDictionary*)dicData
{
    NSArray* arrApps=[dicData objectForKey:@"applications"];
    for (NSDictionary* dicApp in arrApps) {
        GeneralCellModel* model=[[GeneralCellModel alloc]init];
        //App ID
        NSString* appID=[dicApp objectForKey:@"applicationId"];
        
        //APP名称
        NSString* appName=[dicApp objectForKey:@"name"];
        
        //图标
        NSString* iconUrl=[dicApp objectForKey:@"iconUrl"];
        
        //下载次数
        NSString* appDownloads=[dicApp objectForKey:@"downloads"];
        
        //过期时间
        NSString* appExpireTime=[dicApp objectForKey:@"expireDatetime"];
        
        //现价
        NSString* appCurPrice=[dicApp objectForKey:@"currentPrice"];
        
        //原价
        NSString* lastPrice=[dicApp objectForKey:@"lastPrice"];
        
        //App 简介
        NSString* appInfo=[dicApp objectForKey:@"description_long"];
        
        //APP size
        NSString* appSize=[dicApp objectForKey:@"fileSize"];
        
        //分类
        NSString* appCategory=[dicApp objectForKey:@"categoryName"];
        
        //星数
        NSString* appStarNum=[dicApp objectForKey:@"starCurrent"];
        
        NSString* priceState=[dicApp objectForKey:@"priceTrend"];
        
        //一页面
        model.appName=[NSString stringWithFormat:@"%d.%@",_arrayData.count+1,appName];
        model.appLastPrice=lastPrice;
        model.appIconUrl=iconUrl;
        model.appDownloads=appDownloads;
        model.appExpireTime=appExpireTime;
        model.appCurPrice=appCurPrice;
        model.priceState=priceState;
        
        
        //软件详情页面
        model.appID=appID;
        model.appInfo=appInfo;
        model.appSize=[NSString stringWithFormat:@"%@MB",appSize];
        model.appCategory=appCategory;
        model.appStarNum=appStarNum;
        
        
        NetDownload* netDownload=[[NetDownload alloc]init];
        [_connectArr addObject:netDownload];
        netDownload.delegate=self;
        netDownload.tag=102+_IconIndex;
        [netDownload downloadWithstrUrl:iconUrl];
        
        
        _IconIndex++;
        
        // [self downMyImage:iconUrl model:model];
        
        
        [_arrayData addObject:model];
    }
    
    
    [_loadMoreFooter loadMoreScrollViewDataSourceDidFinishedLoading:_tableView];
    
    [_tableView reloadData];
}




- (void)downMyImage:(NSString*)url model:(GeneralCellModel*)model
{
    MyImageDownload* imageDown=[[MyImageDownload alloc]init];
    imageDown.delegate=self;
    
    [imageDown downloadImage:url tag:[model.appID intValue] ID:model.appID];
}


-(void)finishImageDownload:(UIImage *)image withTag:(NSUInteger)tag andID:(NSString *)ID
{
    for (GeneralCellModel* model in _arrayData) {
        if ([model.appID isEqualToString:ID]==YES) {
            model.image=image;
            break;
        }
    }
    
    [_tableView reloadData];
}




- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
 {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
