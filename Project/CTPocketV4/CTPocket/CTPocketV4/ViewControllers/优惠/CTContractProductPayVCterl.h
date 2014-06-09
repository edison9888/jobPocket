//
//  CTContractProductPayVCterl.h
//  CTPocketV4
//
//  Created by Mac-Eshore-01 on 14-3-27.
//  Copyright (c) 2014年 广东亿迅科技有限公司. All rights reserved.
//
//百搭品支付页面

#import "CTBaseViewController.h"

@interface CTContractProductPayVCterl : CTBaseViewController

@property (nonatomic, strong) NSString *orderId;
@property (nonatomic, strong) NSString *payUrl;
@property (nonatomic, strong) NSString *comboName;
@property (nonatomic, strong) NSDictionary *info;
@property (nonatomic, strong) NSDictionary *salesProInfo;

@end
