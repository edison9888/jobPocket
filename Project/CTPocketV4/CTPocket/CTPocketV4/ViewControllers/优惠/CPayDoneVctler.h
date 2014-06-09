//
//  CPayDoneVctler.h
//  CTPocketV4
//
//  Created by Mac-Eshore-01 on 14-1-17.
//  Copyright (c) 2014年 广东亿迅科技有限公司. All rights reserved.
//

// 靓号支付成功界面

#import <UIKit/UIKit.h>
#import "CTBaseViewController.h"

@interface CPayDoneVctler : CTBaseViewController
@property (strong, nonatomic) NSString *pOrderId;
@property (strong, nonatomic) NSString *pOrderStatusDescription;
@property (strong, nonatomic) NSString *pComboName;
@property (nonatomic, strong) NSDictionary *info;
@property (nonatomic, strong) NSDictionary *salesProInfo;
@end
