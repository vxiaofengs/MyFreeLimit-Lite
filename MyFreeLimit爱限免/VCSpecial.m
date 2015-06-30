//
//  VCSpecial.m
//  MyFreeLimit爱限免
//
//  Created by qianfeng on 14-9-2.
//  Copyright (c) 2014年 Qianfeng. All rights reserved.
//

#import "VCSpecial.h"
#import "SpecialMainModel.h"
#import "SpecialDetailModel.h"


#import "CONST.h"

@interface VCSpecial ()

@end

@implementation VCSpecial

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
    // Do any additional setup after loading the view.
    _curPage=1;
    _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, 320, 422) style:UITableViewStylePlain];
    _tableView.delegate=self;
    _tableView.dataSource=self;
    
    _arrayData=[[NSMutableArray alloc]init];
    
    _loadMoreFooter=[[LoadMoreTableFooterView alloc]initWithFrame:CGRectMake(0, 0, 320, 55) arrowImageName:@"blackArrow" textColor:[UIColor blackColor]];
   
    _loadMoreFooter.delegate=self;
    
    
    [self.view addSubview:_tableView];
    
    NSString* strUrl=SPECIAL_URL(_curPage);
    NetDownload* net=[[NetDownload alloc]init];
    net.delegate=self;
    
    [net downloadWithstrUrl:strUrl ];
}



-(void)loadMoreTableFooterDidTriggerLoadMore:(LoadMoreTableFooterView *)view
{
    _curPage++;
    NSString* strUrl=SPECIAL_URL(_curPage);
    NetDownload* net=[[NetDownload alloc]init];
    net.delegate=self;
    [net downloadWithstrUrl:strUrl];
}


-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    [_loadMoreFooter loadMoreScrollViewDidEndDragging:scrollView];
}


-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [_loadMoreFooter loadMoreScrollViewDidScroll:scrollView];
}




-(void)finishDownload:(NSData *)data andTag:(NSInteger)tag
{
    if (data==nil) {
        return;
    }
    
    if (tag>=10 && tag<20) {
      
        int index=tag-10+5*(_curPage-1);
        UIImage* image=[UIImage imageWithData:data];
        SpecialMainModel*model= [_arrayData objectAtIndex:index];
        model.topicImage=image;
    }
    
    if (tag>=20 && tag<30) {
     
        int index=tag-20+5*(_curPage-1);
        UIImage* image=[UIImage imageWithData:data];
        SpecialMainModel*model= [_arrayData objectAtIndex:index];
        model.editHead=image;
    }
    
    NSArray* array=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
    
    for (int i=0; i<array.count; i++) {
        NSDictionary* dicTopic=array[i];
        
        NSArray* arrayApps=[dicTopic objectForKey:@"applications"];
        NSString* name=[dicTopic objectForKey:@"title"];
        
        NSString* imageURL=[dicTopic objectForKey:@"img"];
        NSString* desc=[dicTopic objectForKey:@"desc"];
        NSString* descHead=[dicTopic objectForKey:@"desc_img"];
        
        
        
        SpecialMainModel* model=[[SpecialMainModel alloc]init];
        model.arrayApps=[[NSMutableArray alloc]init];
        model.topicName=name;
        model.desc=desc;
        
        
        //大图标
        NetDownload* netDownTopicImg=[[NetDownload alloc]init];
        netDownTopicImg.tag=10+i;
        netDownTopicImg.delegate=self;
        [netDownTopicImg downloadWithstrUrl:imageURL];
        
      
        //小编头像
        NetDownload* netDownloadEditHead=[[NetDownload alloc]init];
        netDownloadEditHead.tag=20+i;
        netDownloadEditHead.delegate=self;
        [netDownloadEditHead downloadWithstrUrl:descHead];
        
        int detailIconCount=0;
        for (NSDictionary* dicApp in arrayApps) {
            SpecialDetailModel* dmodel=[[SpecialDetailModel alloc]init];
            
            dmodel.appName=[dicApp objectForKey:@"name"];
            dmodel.appScore=[dicApp objectForKey:@"starOverall"];
            dmodel.appDowmloadCounts=[dicApp objectForKey:@"downloads"];
            dmodel.appID=[dicApp objectForKey:@"applicationId"];
            
            NSString* urlIcon=[dicApp objectForKey:@"iconUrl"];
           
            NetDownloadTwo* netDownDetailIcon=[[NetDownloadTwo alloc]init];
            netDownDetailIcon.delegate=self;
            
            netDownDetailIcon.tag=50+detailIconCount;
            
            [netDownDetailIcon downloadWithstrUrl:urlIcon andSecondTag:i];
            
            UIImage* image=[[UIImage alloc]initWithData:data];
            dmodel.appImage=image;
            
            [model.arrayApps addObject:dmodel];
            detailIconCount++;
        }
        
        [_arrayData addObject:model];
    }
    
    [_tableView reloadData];
    
    [_loadMoreFooter loadMoreScrollViewDataSourceDidFinishedLoading:_tableView];
}

-(void)finishDownload:(NSData *)data andFirstTag:(NSInteger)tag0 andSecondTag:(NSInteger)tag1
{
    if (data==nil) {
        return;
    }
    UIImage* image=[UIImage imageWithData:data];
    SpecialMainModel* model=[_arrayData objectAtIndex:tag1+5*(_curPage-1)];
    SpecialDetailModel* dModel=[model.arrayApps objectAtIndex:tag0-50];
    
    dModel.appImage=image;

    [_tableView reloadData];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 300;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _arrayData.count;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString* strID=@"ID";
    SpecialMainCell* cell=[tableView dequeueReusableCellWithIdentifier:strID];
    if (cell==nil) {
        cell=[[SpecialMainCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:strID];
    }
    
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    SpecialMainModel* model=[_arrayData objectAtIndex:indexPath.row];
    cell.delegate=self;
    [cell setData:model];
    
    _tableView.tableFooterView=_loadMoreFooter;
    return cell;
}

-(void)detailCellClicked:(SelectAppDetial *)selector
{
    [self.navigationController pushViewController:selector animated:YES];
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
