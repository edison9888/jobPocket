//
//  IgCreateOrder.h
//  CTPocketV4
//
//  Created by Y W on 14-3-13.
//  Copyright (c) 2014年 广东亿迅科技有限公司. All rights reserved.
//

#import "BaseModel.h"

/*
CustId       string  客户ID（根据igUserInfo接口返回的id！！！！！）
DeviceNo	 string  设备号（手机号）
CommodityId  string  商品ID（ 测试请使用47858或31599）
BuyNum       int     购买数量
PayVoucher   string  需支付抵用券总额（0在支付接口的时候会自动根据用户的抵用券、积分来拆分价格进行支付操作）
PayIntegral  string  需支付积分总额
*/

@interface IgCreateOrder : BaseModel

- (void)igCreateOrderWithCustId:(NSString *)CustId DeviceNo:(NSString *)DeviceNo CommodityId:(NSString *)CommodityId BuyNum:(NSUInteger)BuyNum PayVoucher:(NSString *)PayVoucher PayIntegral:(NSString *)PayIntegral finishBlock:(RequestFinishBlock)finishBlock;

@end
