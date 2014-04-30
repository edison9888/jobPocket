//
//  CTCloudCardVCtler.h
//  CTPocketV4
//
//  Created by 许忠洲 on 14-1-10.
//  Copyright (c) 2014年 广东亿迅科技有限公司. All rights reserved.
//  云卡

#import "CTBaseViewController.h"

@interface CTCloudCardVCtler : CTBaseViewController
@property (strong, nonatomic) NSString *salesProdid;
@property (nonatomic, strong) NSDictionary *combo;
@property (nonatomic, strong) NSDictionary *package;
@property (nonatomic, strong) NSDictionary *item;       // 号码信息，2014-02-17
@end
