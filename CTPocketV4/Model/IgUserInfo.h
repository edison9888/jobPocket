//
//  IgUserInfo.h
//  CTPocketV4
//
//  Created by Y W on 14-3-13.
//  Copyright (c) 2014年 广东亿迅科技有限公司. All rights reserved.
//

#import "BaseModel.h"

@interface IgUserInfo : BaseModel

+ (instancetype)shareIgUserInfo;
- (void)clear;
@property (nonatomic, strong) NSDictionary *responseDictionary;
- (void)igUserInfoWithDeviceNo:(NSString *)DeviceNo finishBlock:(RequestFinishBlock)finishBlock;

@end
