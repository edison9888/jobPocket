//
//  CTFlowView.h
//  CTPocketV4
//
//  Created by 许忠洲 on 13-11-10.
//  Copyright (c) 2013年 广东亿迅科技有限公司. All rights reserved.
//  首页流量圆环

#import <UIKit/UIKit.h>

@interface CTFlowView : UIView
{
    NSString *userName;
    CGFloat usedFlow;
    CGFloat allFlow;
}

- (void)setUserName:(NSString *)name usedFlow:(CGFloat)flow1 allFlow:(CGFloat)flow2;

@end
