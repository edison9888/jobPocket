//
//  COrderComfirmVctler.h
//  CTPocketV4
//
//  Created by Mac-Eshore-01 on 14-1-17.
//  Copyright (c) 2014年 广东亿迅科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CTBaseViewController.h"

@interface COrderComfirmVctler : CTBaseViewController
@property(nonatomic,strong)NSDictionary* selRecipientDict;
@property(nonatomic,strong)NSString* uName;
@property(nonatomic,strong)NSString* uID;
@property(nonatomic,strong)NSString* uAddress;
@property(nonatomic,strong)NSString* uPostCode;
@property (nonatomic, strong) NSDictionary *info;
@end
