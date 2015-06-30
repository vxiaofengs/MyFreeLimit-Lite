//
//  CategoryApps.m
//  MyFreeLimit爱限免
//
//  Created by qianfeng on 14-9-6.
//  Copyright (c) 2014年 Qianfeng. All rights reserved.
//

#import "CategoryApps.h"
#import "AppListCell.h"

@interface CategoryApps ()

@end

@implementation CategoryApps

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
    NSString* strCatAppsUrl=APPCATE_ALL_CUSTOM(_interfaceStr,self.curPage,_catAppId);
    
    self.mDataURL=strCatAppsUrl;
    [super viewDidLoad];
    self.navigationItem.leftBarButtonItem=nil;
    _tableView.tableHeaderView=nil;
}



- (void)loadCellFromHttp
{
    self.curPage++;
    NSString* strCatAppsUrl=APPCATE_ALL_CUSTOM(_interfaceStr,self.curPage,_catAppId);
    
    NetDownload* _download=[[NetDownload alloc]init];
    
    [_connectArr addObject:_download];
    
    _download.delegate=self;
    [_download downloadWithstrUrl:strCatAppsUrl];
    _download.tag=101;
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
