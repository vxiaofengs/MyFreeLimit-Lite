//
//  SalesViewController.m
//  MyFreeLimit爱限免
//
//  Created by qianfeng on 14-9-5.
//  Copyright (c) 2014年 Qianfeng. All rights reserved.
//

#import "SalesViewController.h"
#import "AppListCell.h"

@interface SalesViewController ()

@end

@implementation SalesViewController

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
    NSString* strURL=REDUCE_URL_MAIN;
    self.mDataURL=strURL;
    self.cellShowCName=@"促销";
    self.categoryVCFromEName=@"reduce";
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}


- (void)pressCategory
{
    VCCategory* category=[[VCCategory alloc]init];
    category.categoryVCPushInterface=@"reduce";
    category.categoryVCFromCName=@"促销";
    category.categoryVCFromEName=@"down";
    [self.navigationController pushViewController:category animated:YES];
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
