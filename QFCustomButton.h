//
//  QFCustomButton.h
//  CustomUI
//
//  Created by qianfeng on 14-9-4.
//  Copyright (c) 2014年 Qianfeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QFCustomButton : UIControl
{
    id _target;
    SEL _action;
}


@property (retain,nonatomic)UIImageView* mIcon;

@property (retain,nonatomic)UILabel* mTitle;

@property (retain,nonatomic) UIImage* noselectedImage;
@property (retain,nonatomic) UIImage* selectedImage;
@property (assign,nonatomic) BOOL isSelected;

- (void)addTarget:(id)target action:(SEL)action forControlEvents:(UIControlEvents)controlEvents;
- (void)setBtnState:(NSString*) title andNoSelectedImage:(UIImage*) noselectedImage andSelectedImage:(UIImage*)selectedImage;

@end
