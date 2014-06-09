//
//  BBCenterItemDataModel.m
//  CTPocketV4
//
//  Created by Gong Xintao on 14-6-6.
//  Copyright (c) 2014年 广东亿迅科技有限公司. All rights reserved.
//

#import "BBCenterItemDataModel.h"

@implementation BBCenterItemDataModel
-(instancetype)initWithDictionary:(NSDictionary*)dic
{
    self=[super init];
    if (self) {
        /*
         <ComAddress>蜀南庭苑21号</ComAddress>
         <FibreFlag>1</FibreFlag>
         <ComName>蜀南庭苑</ComName>
         <AreaId>120113</AreaId>
         <BroadFlag>1</BroadFlag>
         */
        self.ComAddress=dic[@"Freight_Area_Code"];
        self.ComName=dic[@"Freight_Area_Code"];
        self.AreaId=dic[@"Freight_Area_Code"];
        self.BroadFlag=[dic[@"Freight_Area_Code"] integerValue];
        self.FibreFlag=[dic[@"Freight_Area_Code"] integerValue];
    }
    return self;
}
@end
