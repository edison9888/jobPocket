//
//  IgInfo.h
//  CTPocketV4
//
//  Created by Y W on 14-3-13.
//  Copyright (c) 2014年 广东亿迅科技有限公司. All rights reserved.
//

#import "BaseModel.h"

@interface IgInfo : BaseModel


- (void)igInfoWithDeviceNo:(NSString *)DeviceNo CustId:(NSString *)CustId QueryType:(NSString *)QueryType finishBlock:(RequestFinishBlock)finishBlock;


//以下静态方法，写死了QueryType = 2 指适用于用来查询
+ (instancetype)shareIgInfo;
- (void)igInfoWithDeviceNo:(NSString *)DeviceNo CustId:(NSString *)CustId finishBlock:(RequestFinishBlock)finishBlock;
- (void)clear;
@property (nonatomic, strong) NSDictionary *responseDictionary;

@end
