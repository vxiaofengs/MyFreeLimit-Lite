//
//  FreeLimitViewController.m
//  MyFreeLimit爱限免
//
//  Created by qianfeng on 14-9-5.
//  Copyright (c) 2014年 Qianfeng. All rights reserved.
//

#import "FreeLimitViewController.h"

#import "CONST.h"

@interface FreeLimitViewController ()

@end

@implementation FreeLimitViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}


- (void)viewDidLoad
{
    NSString* strURL=LIMIT_URL_MAIN;
    self.mDataURL=strURL;
    self.categoryVCFromEName=@"limited";
    [super viewDidLoad];
  
    // Do any additional setup after loading the view.
}



- (void)pressCategory
{
    VCCategory* category=[[VCCategory alloc]init];
    category.categoryVCPushInterface=@"limited";
    category.categoryVCFromCName=@"限免";
    category.categoryVCFromEName=@"limited";
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
