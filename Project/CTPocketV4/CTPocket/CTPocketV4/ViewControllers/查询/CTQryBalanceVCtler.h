//
//  CTQryBalanceVCtler.h
//  CTPocketV4
//
//  Created by Mac-Eshore-01 on 13-11-5.
//  Copyright (c) 2013年 广东亿迅科技有限公司. All rights reserved.
//  当月话费

#import <UIKit/UIKit.h>
#import "CTBaseViewController.h"


@interface CTQryBalanceVCtler : CTBaseViewController
{
    CGFloat _canUse;    // 可用
    CGFloat _hadUse;    // 已用
    CGFloat _hadOwn;    // 欠费
    
    int     _queryType; // 用户级：1  账户级：2；用户级和账户级的区别在当前话费、可用余额上的数据调用同接口
}
@end
