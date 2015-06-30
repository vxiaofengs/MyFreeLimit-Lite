//
//  SearchResult.m
//  MyFreeLimit爱限免
//
//  Created by qianfeng on 14-9-9.
//  Copyright (c) 2014年 Qianfeng. All rights reserved.
//

#import "SearchResult.h"

@interface SearchResult ()

@end

@implementation SearchResult

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
    self.navigationItem.leftBarButtonItem=nil;
    _tableView.tableHeaderView=nil;
}


- (void)loadCellFromHttp
{
    self.curPage++;
    NSString* strURL=SEARCH_GENERAL(self.categoryVCFromEName, self.curPage, self.searchStr);
    NetDownload* _download=[[NetDownload alloc]init];
    [_connectArr addObject:_download];
    
    _download.delegate=self;
    
    [_download downloadWithstrUrl:strURL];
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
