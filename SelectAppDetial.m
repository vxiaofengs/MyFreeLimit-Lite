//
//  SelectAppDetial.m
//  MyFreeLimit爱限免
//
//  Created by qianfeng on 14-9-3.
//  Copyright (c) 2014年 Qianfeng. All rights reserved.
//

#import "SelectAppDetial.h"

#import "CONST.h"

#import "MMProgressHUD.h"

@interface SelectAppDetial ()

@end

@implementation SelectAppDetial

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _detailModelArr=[[NSMutableArray alloc]init];
    
    _arrAroundAppID=[[NSMutableArray alloc]init];
    _arrAroundIcon=[[NSMutableArray alloc]init];
    _arrAroundName=[[NSMutableArray alloc]init];
    
    _arrayConnect=[[NSMutableArray alloc]init];
    
    _arrayImage=[[NSMutableArray alloc]init];
    _arrayImageStr=[[NSMutableArray alloc]init];
    
    _arrAroundIconStr=[[NSMutableArray alloc]init];
    
    self.title=@"应用详情";
    
   
  
    _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, 320, 416) style:UITableViewStylePlain];
    _tableView.delegate=self;
    _tableView.dataSource=self;
    _tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    _tableView.backgroundColor=[UIColor groupTableViewBackgroundColor];
    
    [self.view addSubview:_tableView];
    
    UIBarButtonItem* btnBackToRoot=[[UIBarButtonItem alloc]initWithTitle:@"返回目录" style:UIBarButtonItemStyleDone target:self action:@selector(btnToRoot)];
    self.navigationItem.rightBarButtonItem=btnBackToRoot;
    
    for (int i=0; i<5; i++) {
        [_arrAroundIcon addObject:[UIImage imageNamed:@"123.png"]];
    }
    
    
    //下载app截图
    NSString* strUrl=DETAIL_URL(_appID);
    NetDownload* downloadAppSnap=[[NetDownload alloc]init];
    
    [_arrayConnect addObject:downloadAppSnap];
    
    [downloadAppSnap downloadWithstrUrl:strUrl];
    downloadAppSnap.delegate=self;
    downloadAppSnap.tag=10;
    
    
    
    //下载附近图
    NSString* strUrlAround=RECOMMENT_URL;
    NetDownload* downloadAround=[[NetDownload alloc]init];
    
    [_arrayConnect addObject:downloadAround];
    
    [downloadAround downloadWithstrUrl:strUrlAround];
    downloadAround.delegate=self;
    downloadAround.tag=400;
    
    
    [MMProgressHUD setPresentationStyle:MMProgressHUDPresentationStyleFade];
    [MMProgressHUD showWithStatus:@"Loading"];
}


- (void)btnToRoot
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0) {
        return 380;
    }
    else
        return 100;
}



-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString* strID=@"hu";
    if (indexPath.section==0) {
        AppDetailCell* cell=[tableView dequeueReusableCellWithIdentifier:strID];
        if (cell==nil) {
            cell=[[NSBundle mainBundle]loadNibNamed:@"AppDetailCell" owner:self options:nil][0];
            cell.backgroundView=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"大框.png"]];
            cell.backgroundColor=[UIColor groupTableViewBackgroundColor];
            cell.selectionStyle=UITableViewCellSelectionStyleNone;
        }

        cell.delegate=self;
        [cell setModel:_detailModel];
        
        AppDetailCell* cell_trans=(AppDetailCell*)cell;
        [cell_trans setSnapImage:_arrayImage];
        return cell;
    }
    
    else if (indexPath.section==1){
        AppDetailAroundCell * cell=[tableView dequeueReusableCellWithIdentifier:strID];
        cell.delegate=self;
        if (cell==nil) {
            cell=[[NSBundle mainBundle]loadNibNamed:@"AppDetailAroundCell" owner:self options:nil][0];
            cell.backgroundView=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"小框.png"]];
            cell.backgroundColor=[UIColor groupTableViewBackgroundColor];
            cell.selectionStyle=UITableViewCellSelectionStyleNone;
        }
        
        AppDetailAroundCell* cell_trans=(AppDetailAroundCell*)cell;
        [cell_trans setAroundIcons:_arrAroundIcon];
        [cell_trans setAroundNames:_arrAroundName andID:_arrAroundAppID];
        
        return cell;
    }
    return nil;
}



-(void)pushDetailViewFromAroundCell:(SelectAppDetial*)vc
{
    [self.navigationController pushViewController:vc animated:YES];
}



-(void)finishDownload:(NSData *)data andTag:(NSInteger)tag
{
    if (data==nil) {
        return;
    }
    
    
    NSDictionary* dic=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
    
    //图标
    if (tag==20) {
        UIImage* image=[UIImage imageWithData:data];
        _detailModel.imageIcon=image;
        [MMProgressHUD dismissWithSuccess:@"Done"];
    }
    
        //app截图
    if (tag==10) {
        _detailModel=[[SelectAppDetialModel alloc]init];
        _detailModel.appName=[dic objectForKey:@"name"];
        _detailModel.appInfo=[dic objectForKey:@"description"];
        _detailModel.appCategory=[dic objectForKey:@"categoryName"];
        _detailModel.appSize=[NSString stringWithFormat:@"%@MB",[dic objectForKey:@"fileSize"]];
        _detailModel.appLastPrice=[dic objectForKey:@"lastPrice"];
        _detailModel.appStarNum=[dic objectForKey:@"starCurrent"];
        _detailModel.appExpireTime=[dic objectForKey:@"expireDatetime"];
        
        _detailModel.appCurPrice=[dic objectForKey:@"currentPrice"];
        _detailModel.appPriceTrend=[dic objectForKey:@"priceTrend"];
        _detailModel.appID=[dic objectForKey:@"applicationId"];
        
        NSString* strIconUrl=[dic objectForKey:@"iconUrl"];
        NetDownload* dowmloadIcon=[[NetDownload alloc]init];
        dowmloadIcon.delegate=self;
        dowmloadIcon.tag=20;
        
        [_arrayConnect addObject:dowmloadIcon];
        
        [dowmloadIcon downloadWithstrUrl:strIconUrl];
        
        
        
        NSArray* arrayPhotos=[dic objectForKey:@"photos"];
        for (NSDictionary* dic in arrayPhotos) {
            NSString* strUrl=[dic objectForKey:@"smallUrl"];
            [_arrayImageStr addObject:strUrl];
        }
        
        for (int i=0; i<_arrayImageStr.count; i++) {
            NSString* strUrl=[_arrayImageStr objectAtIndex:i];
            NetDownload* downloadSnapImg=[[NetDownload alloc]init];
            
            [_arrayConnect addObject:downloadSnapImg];
            
            downloadSnapImg.tag=i+200;
            downloadSnapImg.delegate=self;
            [downloadSnapImg downloadWithstrUrl:strUrl];
        }
    }
    
    
    
    if (tag>=200 && tag<=300) {
        [_arrayImage addObject:[UIImage imageWithData:data]];
    }
    
    
    //附近的人
    if (tag==400) {
        NSArray* array=[dic objectForKey:@"applications"];
        for (NSDictionary* dicAround in array) {
            NSString* strName=[dicAround objectForKey:@"name"];
            NSString* strURL=[dicAround objectForKey:@"iconUrl"];
            NSString* strID=[dicAround objectForKey:@"applicationId"];
            [_arrAroundAppID addObject:strID];
            [_arrAroundName addObject:strName];
            [_arrAroundIconStr addObject:strURL];
        }
        
        
        for (int i=0; i<_arrAroundIconStr.count; i++) {
            NetDownload* downloadAroundImg=[[NetDownload alloc]init];
            [downloadAroundImg downloadWithstrUrl:_arrAroundIconStr[i]];
            
            [_arrayConnect addObject:downloadAroundImg];
            
            downloadAroundImg.delegate=self;
            downloadAroundImg.tag=420+i;
        }
    }
    
    
    if (tag>=420 && tag<=430) {
        int index=tag-420;
        UIImage* image=[UIImage imageWithData:data];
        if (image!=nil) {
            [_arrAroundIcon replaceObjectAtIndex:index withObject:image];
        }
    }
    [_tableView reloadData];
    
}





- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



-(void)viewWillDisappear:(BOOL)animated
{
    for (int i=0; i<_arrayConnect.count; i++) {
        NetDownload* net=[_arrayConnect objectAtIndex:i];
        net.delegate=nil;
    }
}

-(void)loadSnapImageVC:(SnapImageViewController *)vc
{
    [self presentViewController:vc animated:YES completion:nil];
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
