//
//  BBCenterRepDataModel.m
//  CTPocketV4
//
//  Created by Gong Xintao on 14-6-6.
//  Copyright (c) 2014年 广东亿迅科技有限公司. All rights reserved.
//  小区宽带查询接口返回的数据模型

#import "BBCenterRepDataModel.h"
#import "BBCenterItemDataModel.h"
@implementation BBCenterRepDataModel
-(instancetype)init
{
    self=[super init];
    if (self) {
        self.DataList=[NSMutableArray array];
    }
    return self;
}
-(void)transformWithArray:(NSArray*)array
{
    [array enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop){
        if ([obj isKindOfClass:[NSDictionary class]]) {
            BBCenterItemDataModel *item=[[BBCenterItemDataModel alloc] initWithDictionary:obj];
            [self.DataList addObject:item];
        }
        
    }];
}
@end
