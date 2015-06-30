//
//  HotViewController.m
//  MyFreeLimit爱限免
//
//  Created by qianfeng on 14-9-7.
//  Copyright (c) 2014年 Qianfeng. All rights reserved.
//

#import "HotViewController.h"

@interface HotViewController ()

@end

@implementation HotViewController

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
    NSString* strURL=HOT_URL_MAIN;
    self.mDataURL=strURL;
    self.categoryVCFromEName=@"hot";
    [self configUI];
    [super viewDidLoad];
}


- (void)pressCategory
{
    VCCategory* category=[[VCCategory alloc]init];
    category.categoryVCPushInterface=@"hot";
    category.categoryVCFromCName=@"热榜";
    category.categoryVCFromEName=@"same";
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
