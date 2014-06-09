//
//  BBCRequestParamModel.m
//  CTPocketV4
//
//  Created by Gong Xintao on 14-6-6.
//  Copyright (c) 2014年 广东亿迅科技有限公司. All rights reserved.
//  小区宽带查询接口请求参数模型

#import "BBCRequestParamModel.h"

@implementation BBCRequestParamModel
#pragma mark 把模型转化为字典，用于网络请求
-(NSDictionary*)dictionaryWithModel
{
    /*
     <AreaId>120113</AreaId>
     <ComName>蜀南</ComName>
     <PageIndex>1</PageIndex>
     <PageSize>50</PageSize>
     **/
    NSString *areaId=self.AreaId?self.AreaId:@"";
    NSString *ComName=self.ComName?self.ComName:@"";
    NSString *PageIndex=[NSString stringWithFormat:@"%i",self.PageIndex];
    NSString *PageSize=[NSString stringWithFormat:@"%i",self.PageSize];
    return @{@"AreaId":areaId,@"ComName":ComName,@"PageIndex":PageIndex,@"PageSize":PageSize};
}
@end
