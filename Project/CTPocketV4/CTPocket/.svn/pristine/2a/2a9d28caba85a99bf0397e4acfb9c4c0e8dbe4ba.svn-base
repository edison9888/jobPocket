//
//  packageScrollView.m
//  CTPocketV4
//
//  Created by Mac-Eshore-01 on 14-4-17.
//  Copyright (c) 2014年 广东亿迅科技有限公司. All rights reserved.
//

#import "packageScrollView.h"

@implementation packageScrollView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect
 {
 // Drawing code
 }
 */

- (void)touchesBegan:(NSSet *)touches
           withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    self.touchTimer = [touch timestamp];
}

//touchesEnded，touch事件完成，根据此时时间点获取到touch事件的总时间，
- (void)touchesEnded:(NSSet *)touches
           withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    self.touchTimer = [touch timestamp] - self.touchTimer;
    
    NSUInteger tapCount = [touch tapCount];
    CGPoint touchPoint = [touch locationInView:self];
    
    //判断单击事件，touch时间和touch的区域
    if (tapCount == 1 && self.touchTimer <= 3)
    {
        //进行单击的跳转等事件
        [self.scrollGestureDelegate scrollViewtouch:touchPoint];
    }
    
}


@end