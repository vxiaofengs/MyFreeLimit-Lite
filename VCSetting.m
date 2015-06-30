//
//  VCSetting.m
//  MyFreeLimit爱限免
//
//  Created by qianfeng on 14-9-7.
//  Copyright (c) 2014年 Qianfeng. All rights reserved.
//

#import "VCSetting.h"

#import "FavoriteAppsViewController.h"

@interface VCSetting ()

@end

@implementation VCSetting

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
    
    self.view.backgroundColor=[UIColor groupTableViewBackgroundColor];
    UIButton* buttonFavo=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    buttonFavo.frame=CGRectMake(5, 5, 310, 50);
    [buttonFavo setTitle:@"收藏列表" forState:UIControlStateNormal];

    [buttonFavo addTarget:self action:@selector(pressFavBtn) forControlEvents:UIControlEventTouchUpInside];
    
    [buttonFavo setBackgroundImage:[UIImage imageNamed:@"6.应用详情_0.png"] forState:UIControlStateNormal];
    
    [buttonFavo setImage:[UIImage imageNamed:@"clickLike"] forState:UIControlStateNormal];
    
    buttonFavo.titleLabel.font=[UIFont boldSystemFontOfSize:25];
    [buttonFavo setTintColor:[UIColor whiteColor]];
    
//  buttonFavo.layer.masksToBounds=YES;
    
    buttonFavo.clipsToBounds=YES;

    
//    UIEdgeInsetsMake(CGFloat top, CGFloat left, CGFloat bottom, CGFloat right)
    [buttonFavo setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
    
    
    
    buttonFavo.layer.cornerRadius=6;
    
    
    [self.view addSubview:buttonFavo];
}



- (void)pressFavBtn
{
    FavoriteAppsViewController* fav=[[FavoriteAppsViewController alloc]init];
    [self.navigationController pushViewController:fav animated:YES];
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
