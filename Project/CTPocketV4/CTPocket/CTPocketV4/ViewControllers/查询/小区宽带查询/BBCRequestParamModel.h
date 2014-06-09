//
//  BBCRequestParamModel.h
//  CTPocketV4
//
//  Created by Gong Xintao on 14-6-6.
//  Copyright (c) 2014年 广东亿迅科技有限公司. All rights reserved.
//  小区宽带查询接口请求参数模型

#import <Foundation/Foundation.h>

@interface BBCRequestParamModel : NSObject
@property(copy,nonatomic)NSString *AreaId;
@property(copy,nonatomic)NSString *ComName;
@property(assign,nonatomic)   int PageIndex;
@property(assign,nonatomic)   int PageSize;
@end
