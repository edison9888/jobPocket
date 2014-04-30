//
//  CTShakeNumberVCtler.h
//  CTPocketV4
//
//  Created by liuruxian on 14-1-13.
//  Copyright (c) 2014年 广东亿迅科技有限公司. All rights reserved.
//

#import "CTBaseViewController.h"
#import "CTCity.h"

@interface CTShakeNumberVCtler : CTBaseViewController

@property (nonatomic, strong) NSDictionary *attributeInfo;
@property (nonatomic, strong) CTCity *selectedCity;
@property (nonatomic, assign) int jumpType; // 0 靓号  1 合约机

@end
