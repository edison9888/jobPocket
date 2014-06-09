//
//  BBTRequestParamModel.m
//  CTPocketV4
//
//  Created by Gong Xintao on 14-6-6.
//  Copyright (c) 2014年 广东亿迅科技有限公司. All rights reserved.
//  地区及编码查询请求请求参数模型

#import "BBTRequestParamModel.h"

@implementation BBTRequestParamModel
 -(instancetype)init
{
    self=[super init];
    if (self) {
        [self addObserver:self forKeyPath:@"ProvinceCode" options:NSKeyValueObservingOptionNew context:nil];
        [self addObserver:self forKeyPath:@"CityCode" options:NSKeyValueObservingOptionNew context:nil];
    }
    return self;
}
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if ([@"ProvinceCode" isEqualToString:keyPath])
    {
        self.cachePath=[NSString stringWithFormat:@"%@",self.ProvinceCode];
    }else if([@"CityCode" isEqualToString:keyPath])
    {
         self.cachePath=[NSString stringWithFormat:@"%@_%@",self.ProvinceCode,self.CityCode];
    }
        
}
@end
