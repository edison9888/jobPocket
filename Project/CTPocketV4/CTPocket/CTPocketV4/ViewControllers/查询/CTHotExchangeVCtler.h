//
//  CTHotExchangeVCtler.h
//  CTPocketV4
//
//  Created by Mac-Eshore-01 on 14-3-12.
//  Copyright (c) 2014年 广东亿迅科技有限公司. All rights reserved.
//

#import "CTBaseViewController.h"

typedef enum _RefleshType
{
    pullUp=0,
    pullDown,//下拉
    nonStatus
}RefleshType;



@interface CTHotExchangeVCtler : CTBaseViewController
{
    NSString *cellIdentifier;
}
@property (nonatomic, assign) RefleshType refleshType;

@end
