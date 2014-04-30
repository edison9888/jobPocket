//
//  CTAddPackageVCtler.h
//  CTPocketV4
//
//  Created by Mac-Eshore-01 on 14-4-18.
//  Copyright (c) 2014年 广东亿迅科技有限公司. All rights reserved.
//

#import "CTBaseViewController.h"

@interface CTAddPackageVCtler : CTBaseViewController

@property (nonatomic, strong) NSDictionary *item;
@property (nonatomic, strong) NSDictionary *info;
@property (nonatomic) BOOL iSDefaultPackage;    // 是否有默认套餐的标识，影响到返回按钮回退到什么界面

- (void)initPackage;
@end
