//
//  CTPackageSelectVCtler.h
//  CTPocketV4
//
//  Created by Mac-Eshore-01 on 14-4-18.
//  Copyright (c) 2014年 广东亿迅科技有限公司. All rights reserved.
//

#import "CTBaseViewController.h"

@interface CTPackageSelectVCtler : CTBaseViewController
@property (nonatomic, strong) NSDictionary *item;
@property (nonatomic, strong) NSMutableArray *packages;
@property (nonatomic, strong) NSMutableArray *comboItems;  //  可选套餐总类，数据从qryComboType接口获得
@property (nonatomic) BOOL iSDefaultPackage;    // 是否有默认套餐的标识，影响到返回按钮回退到什么界面
@property (nonatomic, strong) NSDictionary *info;

@end
