//
//  CTRechargeSucessVCtler.h
//  CTPocketV4
//
//  Created by apple on 13-11-1.
//  Copyright (c) 2013年 广东亿迅科技有限公司. All rights reserved.
//

#import "CTBaseViewController.h"

@interface CTRechargeSucessVCtler : CTBaseViewController

@property (nonatomic, strong) NSMutableDictionary *rechargeInfoDict;

@property (nonatomic, strong) NSMutableDictionary *callsDict;
@property (nonatomic, strong) NSMutableDictionary *flowDcit;



@property (nonatomic, assign) int channelByRecharge; //充值卡类型   银行卡充值   充值卡充值

@end
