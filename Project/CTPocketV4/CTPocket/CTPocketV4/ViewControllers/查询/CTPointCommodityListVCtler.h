//
//  CTPointCommodityListVCtler.h
//  CTPocketV4
//
//  Created by Y W on 14-3-11.
//  Copyright (c) 2014年 广东亿迅科技有限公司. All rights reserved.
//  积分查询的商品列表

#import "CTBaseViewController.h"

@interface CTPointCommodityListVCtler : CTBaseViewController

@property (nonatomic, assign) NSUInteger Integral; //用户拥有的积分数额，从积分查询页传入
@property (nonatomic, readonly, strong) NSMutableArray *CommodityList; //将积分查询页查出来的结果存入此数组，避免重复查询一次
//传入积分查询页面的pageIndex和PageSize
@property (nonatomic, assign) NSUInteger PageIndex;
@property (nonatomic, assign) NSUInteger PageSize;

@end
