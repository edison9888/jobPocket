//
//  CTContractPayDoneVCterl.h
//  CTPocketV4
//
//  Created by Mac-Eshore-01 on 14-3-27.
//  Copyright (c) 2014年 广东亿迅科技有限公司. All rights reserved.
//
//百搭品支付成功订单确认

#import "CTBaseViewController.h"

@interface CTContractPayDoneVCterl : CTBaseViewController

@property (strong, nonatomic) NSString *pOrderId;
@property (strong, nonatomic) NSString *pOrderStatusDescription;
@property (strong, nonatomic) NSString *pComboName;
@property (nonatomic, strong) NSDictionary *info;
@property (nonatomic, strong) NSDictionary *salesProInfo;

@end
