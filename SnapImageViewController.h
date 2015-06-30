//
//  SnapImageViewController.h
//  MyFreeLimit爱限免
//
//  Created by qianfeng on 14-9-5.
//  Copyright (c) 2014年 Qianfeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NetDownload.h"
@interface SnapImageViewController : UIViewController <NetDownloadDelegate>
{
    UIScrollView* _scrollView;
    NSInteger imgNum;
    NSInteger _imageWidth;
    NSInteger _imageHeight;
    NSMutableArray* _arrayConnect;
}

@property (retain,nonatomic)NSString* appId;
@end
