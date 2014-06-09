//
//  CTOrderDetailVCtler.h
//  CTPocketV4
//
//  Created by 许忠洲 on 13-11-26.
//  Copyright (c) 2013年 广东亿迅科技有限公司. All rights reserved.
//  订单详情

#import "CTBaseViewController.h"
@class COQueryListVctler;
@interface CTOrderDetailVCtler : CTBaseViewController
@property(nonatomic,weak)COQueryListVctler *list;
@property (nonatomic, strong) NSString *ordrId;
@property (nonatomic, strong) NSMutableDictionary *orderInfo;//added by huangfq 2014-5-29 订单信息
- (void) setcardInfo: (int) showType cardType : (int) cardType;

@end
