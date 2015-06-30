//
//  QFCustomButton.m
//  CustomUI
//
//  Created by qianfeng on 14-9-4.
//  Copyright (c) 2014年 Qianfeng. All rights reserved.
//

#import "QFCustomButton.h"

@implementation QFCustomButton


//常规加载初始化
- (id)initWithFrame:(CGRect)frame
{
    frame=CGRectMake(frame.origin.x, frame.origin.y, 80, 40);
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        _mIcon=[[UIImageView alloc]init];
        _mIcon.frame=CGRectMake(5, 5, 30, 30);
        
        _mTitle=[[UILabel alloc]init];
        _mTitle.frame=CGRectMake(40, 5, 45, 30);
        _mTitle.font=[UIFont boldSystemFontOfSize:18];
        _mTitle.textAlignment=NSTextAlignmentLeft;
        _mTitle.textColor=[UIColor whiteColor];
       
        
        _noselectedImage=[UIImage imageNamed:@"12.png"];
        _selectedImage=[UIImage imageNamed:@"22.png"];
        
        _mIcon.image=_noselectedImage;
        
        _isSelected=NO;
        
        
        [self addSubview:_mIcon];
        [self addSubview:_mTitle];
        self.backgroundColor=[UIColor greenColor];
    }
    return self;
}

- (void)setBtnState:(NSString*) title andNoSelectedImage:(UIImage*) noselectedImage andSelectedImage:(UIImage*)selectedImage
{
    _mTitle.text=title;
    _selectedImage=selectedImage;
    _noselectedImage=noselectedImage;
    if (_isSelected==YES) {
        _mIcon.image=_selectedImage;
    }
    else
    {
        _mIcon.image=_noselectedImage;
    }
}






//当此按钮为xib中的视图对象
//创建xib对象时会调用每一个子对象的如下的初始化函数
-(id)initWithCoder:(NSCoder *)aDecoder
{
    self=[super initWithCoder:aDecoder];
    
    _mIcon=[[UIImageView alloc]init];
    _mIcon.frame=CGRectMake(15, 6.5, 20, 20);
    
    _mTitle=[[UILabel alloc]init];
    _mTitle.frame=CGRectMake(50, 6.5, 45, 20);
    _mTitle.font=[UIFont boldSystemFontOfSize:17];
    _mTitle.textAlignment=NSTextAlignmentLeft;
    _mTitle.textColor=[UIColor whiteColor];
    
    _isSelected=NO;
    
    [self addSubview:_mIcon];
    [self addSubview:_mTitle];
    
    self.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"6.应用详情_0.png"]];
    
    return self;
}


- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    self.isSelected=!self.isSelected;
}


-(void)addTarget:(id)target action:(SEL)action forControlEvents:(UIControlEvents)controlEvents
{
    if (controlEvents & UIControlEventValueChanged) {
        _target=target;
        _action=action;
    }
}




- (void)setIsSelected:(BOOL)isSelected
{
    if (_isSelected!=isSelected) {
        _isSelected=isSelected;
        
        if (_isSelected==YES) {
            _mIcon.image=_selectedImage;
        }
        else
        {
            _mIcon.image=_noselectedImage;
        }
        
        
        if ([_target respondsToSelector:_action]==YES) {
            [_target performSelector:_action withObject:self afterDelay:0];
        }
    }

}






/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
