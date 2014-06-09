//
//  BBCenterRepDataModel.h
//  CTPocketV4
//
//  Created by Gong Xintao on 14-6-6.
//  Copyright (c) 2014年 广东亿迅科技有限公司. All rights reserved.
//  小区宽带查询接口返回的数据模型

#import <Foundation/Foundation.h>

@interface BBCenterRepDataModel : NSObject
@property(assign,nonatomic)           int TotalCount;
@property(strong,nonatomic)NSMutableArray *DataList;//数组每个元素的模型是BBCenterItemDataModel

-(void)transformWithArray:(NSArray*)array;
@end
