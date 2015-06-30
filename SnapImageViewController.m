//
//  SnapImageViewController.m
//  MyFreeLimit爱限免
//
//  Created by qianfeng on 14-9-5.
//  Copyright (c) 2014年 Qianfeng. All rights reserved.
//

#import "SnapImageViewController.h"

#import "CONST.h"
@interface SnapImageViewController ()

@end

@implementation SnapImageViewController

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
    imgNum=0;
    _arrayConnect=[[NSMutableArray alloc]init];
    _scrollView=[[UIScrollView alloc]init];
    _scrollView.frame=CGRectMake(0,0,320,480);
    _scrollView.backgroundColor=[UIColor groupTableViewBackgroundColor];
    
    
    UITapGestureRecognizer* tap=[[UITapGestureRecognizer alloc]init];
    [_scrollView addGestureRecognizer:tap];
    [tap addTarget:self action:@selector(tapAct)];
    
    
    NetDownload* net=[[NetDownload alloc]init];
    NSString* strUrl=DETAIL_URL(_appId);
    
    [_arrayConnect addObject:net];
    
    [net downloadWithstrUrl:strUrl];
    net.delegate=self;
    
    [self.view addSubview:_scrollView];
}


- (void)tapAct
{
    [self dismissViewControllerAnimated:YES completion:nil];
}


-(void)finishDownload:(NSData *)data andTag:(NSInteger)tag
{

    if (data==nil) {
        return;
    }
    
    if (tag==10) {
        UIImage* image=[UIImage imageWithData:data];
        UIImageView* iView=[[UIImageView alloc]initWithImage:image];
       
        iView.frame=CGRectMake(imgNum*(image.size.width+2), 0, image.size.width,480);
        _imageWidth=image.size.width;
        _imageHeight=image.size.height;
        imgNum++;
        [_scrollView addSubview:iView];
    }
    
    
    
    NSDictionary* dic=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
    NSArray* array=[dic objectForKey:@"photos"];
    for (NSDictionary* dicImg in array) {
        NSString* strImgUrl=[dicImg objectForKey:@"originalUrl"];
        
        NetDownload* downloadImg=[[NetDownload alloc]init];
        downloadImg.tag=10;
        downloadImg.delegate=self;
        [_arrayConnect addObject:downloadImg];
        [downloadImg downloadWithstrUrl:strImgUrl];
    }
    _scrollView.contentSize=CGSizeMake(imgNum*(_imageWidth+2), 480);
}


-(void)viewWillDisappear:(BOOL)animated
{
    for (NetDownload* net in _arrayConnect) {
        net.delegate=nil;
    }
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
