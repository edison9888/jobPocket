//
//  IgOrderList.h
//  CTPocketV4
//
//  Created by Y W on 14-3-11.
//  Copyright (c) 2014年 广东亿迅科技有限公司. All rights reserved.
//

#import "BaseModel.h"

@interface IgOrderList : BaseModel

- (void)igOrderListWithPageIndex:(NSString *)PageIndex PageSize:(NSString *)PageSize DeviceNo:(NSString *)DeviceNo DeviceType:(NSString *)DeviceType ProvinceId:(NSString *)ProvinceId CustId:(NSString *)CustId OrderId:(NSString *)OrderId Status:(NSString *)Status DataType:(NSString *)DataType finishBlock:(RequestFinishBlock)finishBlock;

@end
