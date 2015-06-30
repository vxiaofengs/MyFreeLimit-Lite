//
//  VCCategory.m
//  MyFreeLimit爱限免
//
//  Created by qianfeng on 14-9-5.
//  Copyright (c) 2014年 Qianfeng. All rights reserved.
//

#import "VCCategory.h"

#import "CategoryCell.h"
#import "CategoryModel.h"
#import "CONST.h"
#import "CategoryApps.h"


@interface VCCategory ()

@end

@implementation VCCategory

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        isLoading=NO;
    }
    return self;
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _arrayData.count;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 71;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    CategoryModel* model=[_arrayData objectAtIndex:indexPath.row];
    NSString* strCatId=model.catId;
    
    CategoryApps* catApps=[[CategoryApps alloc]init];
    
    catApps.catAppId=strCatId;
    
    //传入接口字符串
    catApps.interfaceStr=self.categoryVCPushInterface;
    
    //传入中文类别名
    catApps.catCName=self.categoryVCFromCName;
    
    catApps.title=model.categoryName;
    [self.navigationController pushViewController:catApps animated:YES];
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString* strID=@"ALL";
    CategoryCell* cell=[tableView dequeueReusableCellWithIdentifier:strID];
    if (cell==nil) {
        cell=[[NSBundle mainBundle]loadNibNamed:@"CategoryCell" owner:self options:nil][0];
    }
    CategoryModel* model=[_arrayData objectAtIndex:indexPath.row];
    [cell setModel:model];

    return cell;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _arrayConnect=[[NSMutableArray alloc]init];
    _arrayData=[[NSMutableArray alloc]init];
    _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, 320, 416) style:UITableViewStylePlain];
    _tableView.delegate=self;
    _tableView.dataSource=self;
        
    
    NSString* strCatUrl=APPCATE;
    
    NetDownload* net=[[NetDownload alloc]init];
    net.delegate=self;
    [_arrayConnect addObject:net];
    [net downloadWithstrUrl:strCatUrl];
    
    [self.view addSubview:_tableView];
    
    [MMProgressHUD setPresentationStyle:MMProgressHUDPresentationStyleFade];
    [MMProgressHUD showWithStatus:@"Loading"];
}

-(void)finishDownload:(NSData *)data andTag:(NSInteger)tag
{
    if (data!=nil) {
        NSArray* array=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
      
        for (NSDictionary* dic in array) {
            CategoryModel* model=[[CategoryModel alloc]init];
            
            NSString* strCatName=[dic objectForKey:@"categoryCname"];
            NSString* strAppsNum=[NSString stringWithFormat:@"共%@款应用",[dic objectForKey:@"categoryCount"]];
        
            NSString* strCName=self.categoryVCFromCName;
            NSString* strEName=self.categoryVCFromEName;
            
            NSString* strLimitAppsNum=[NSString stringWithFormat:@"其中%@%@款",strCName,[dic objectForKey:strEName]];
            
            NSString* strIconUrl=[dic objectForKey:@"picUrl"];
            NSString* strCatId=[dic objectForKey:@"categoryId"];
            
            model.categoryName=strCatName;
            model.allAPPsNum=strAppsNum;
            model.limitFreeAppsNum=strLimitAppsNum;
            model.catId=strCatId;
            
            MyImageDownload* downloadImg=[[MyImageDownload alloc]init];
            downloadImg.delegate=self;
            [_arrayConnect addObject:downloadImg];
            [downloadImg downloadImage:strIconUrl tag:[strCatId intValue] ID:strCatId];
            
            [_arrayData addObject:model];
        }
    }
    
    [_tableView reloadData];
}

BOOL isLoading=NO;
-(void)finishImageDownload:(UIImage *)image withTag:(NSUInteger)tag andID:(NSString *)ID
{
    
    for (CategoryModel* model in _arrayData) {
        if ([model.catId isEqualToString:ID]==YES) {
            model.categoryIcon=image;
            break;
        }
    }
    if (isLoading==NO) {
     [MMProgressHUD dismissWithSuccess:@"Done"];
        isLoading=YES;
    }
    [_tableView reloadData];
}


-(void)viewWillDisappear:(BOOL)animated
{
    for (int i=0; i<_arrayConnect.count; i++) {
        if ([[_arrayConnect objectAtIndex:i] class]==[MyImageDownload class]) {
            MyImageDownload* net=[_arrayConnect objectAtIndex:i];
            net.delegate=nil;
        }
        else
        {
            NetDownload* net=[_arrayConnect objectAtIndex:i];
            net.delegate=nil;
        }
    }
}


-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    NSLog(@"click");
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
