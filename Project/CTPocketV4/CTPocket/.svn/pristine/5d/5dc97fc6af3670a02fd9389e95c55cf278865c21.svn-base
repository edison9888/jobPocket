//
//  StatisticsObj.m
//  CTPocketV4
//
//  Created by Mac-Eshore-01 on 14-3-21.
//  Copyright (c) 2014年 广东亿迅科技有限公司. All rights reserved.
//

#import "StatisticsObj.h"

@interface StatisticsObj()

@end

@implementation StatisticsObj

+(StatisticsObj *)shareInstance
{
    static StatisticsObj *statisticObj = nil;
    static dispatch_once_t onceToken ;
    dispatch_once(&onceToken,^(){
        statisticObj = [[StatisticsObj alloc] init];
    });
    
    return statisticObj ;
}

- (NSArray *)adaptArray
{
    if (!_adaptArray) {
        // 适配类名
        _adaptArray = [[NSArray alloc] initWithObjects:
                       @"CTDetailVCtler",
                       @"CTOrderDetailVCtler",
                       @"CTAnnouncementVCtler",
                       @"CTMessageVCtler",
                       @"CustomTabBarVCtler",
                       @"CTLoginLoadingVCtler",
                       nil];
    }
    
    return _adaptArray ;
}

@end
