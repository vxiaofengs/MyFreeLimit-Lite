//
//  FavoriteAppsViewController.m
//  MyFreeLimit爱限免
//
//  Created by qianfeng on 14-9-7.
//  Copyright (c) 2014年 Qianfeng. All rights reserved.
//

#import "FavoriteAppsViewController.h"

@interface FavoriteAppsViewController ()

@end

@implementation FavoriteAppsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}


-(void)viewWillAppear:(BOOL)animated
{
    [_arrayData removeAllObjects];
    [self refreshFavorList];
}




- (void)refreshFavorList
{
    
    BOOL isEmpty=YES;
    NSUserDefaults* user=[NSUserDefaults standardUserDefaults];
    NSDictionary* userDic=[user dictionaryRepresentation];
    NSArray* arrayKeys=[userDic allKeys];

   
    
    
    for (NSString* strID in arrayKeys) {
        char c=[strID characterAtIndex:0];
        if (c>='0' && c<='9') {
            if ([[userDic objectForKey:strID] isEqualToString:@"1"]) {
                isEmpty=NO;
                NSString* strUrl=DETAIL_URL(strID);
                NetDownload* download=[[NetDownload alloc]init];
                download.delegate=self;
                
                [_connectArr addObject:download];
            
                [download downloadWithstrUrl:strUrl];
            }
        }
    }
    
    
    if (isEmpty==YES) {
        UIAlertView* alert=[[UIAlertView alloc]initWithTitle:@"提示" message:@"收藏夹为空" delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alert show];
        return;
    }
    else
    {
    [MMProgressHUD setPresentationStyle:MMProgressHUDPresentationStyleFade];
    [MMProgressHUD showWithStatus:@"Loading"];
    }
}

- (void)viewDidLoad
{
    _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, 320, 422) style:UITableViewStylePlain];
    _tableView.delegate=self;
    _tableView.dataSource=self;
    
    self.title=@"收藏列表";
    [self.view addSubview:_tableView];
}



-(void)finishDownload:(NSData *)data andTag:(NSInteger)tag
{
    if (data!=nil) {
        NSDictionary* dicApp=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        [self parseDicData:dicApp];
    }
}



- (void)parseDicData:(NSDictionary*)dicApp
{
    GeneralCellModel* model=[[GeneralCellModel alloc]init];
    
    //App ID
    NSString* appID=[dicApp objectForKey:@"applicationId"];
    
    //APP名称
    NSString* appName=[dicApp objectForKey:@"name"];
    
    //图标
    NSString* iconUrl=[dicApp objectForKey:@"iconUrl"];
    
    //下载次数
    NSString* appDownloads=[dicApp objectForKey:@"downloads"];
    
    
    //纠正download 为NSNUMBER值的解析错误
    if ([[[dicApp objectForKey:@"downloads"] class] isSubclassOfClass:[NSString class]]==NO) {
        appDownloads=[NSString stringWithFormat:@"%d",[[dicApp objectForKey:@"downloads"] intValue]];
    }
    
    
    //过期时间
    NSString* appExpireTime=[dicApp objectForKey:@"expireDatetime"];
    
    //现价
    NSString* appCurPrice=[dicApp objectForKey:@"currentPrice"];
    
    //原价
    NSString* lastPrice=[dicApp objectForKey:@"lastPrice"];
    
    
    //APPsize
    //NSString* appSize=[dicApp objectForKey:@"fileSize"];
    
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
    //        model.appSize=[NSString stringWithFormat:@"%@MB",appSize];
    model.appCategory=appCategory;
    model.appStarNum=appStarNum;
    
    [self downMyImage:iconUrl model:model];
    
    [_arrayData addObject:model];
    
    [_tableView reloadData];
    [MMProgressHUD dismissWithSuccess:@"Done"];
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
