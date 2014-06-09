//
//  BBNWRequstProcess.h
//  CTPocketV4
//
//  Created by Gong Xintao on 14-6-6.
//  Copyright (c) 2014年 广东亿迅科技有限公司. All rights reserved.
//  网络处理

#import <Foundation/Foundation.h>

@class BBTopViewManager;
@class BBCenterViewManager;
@class BBTRequestParamModel;
@class BBCRequestParamModel;
@interface BBNWRequstProcess : NSObject
@property (weak,nonatomic) BBTopViewManager     *tManager;
-(void)requestTopWithParmaModel:(BBTRequestParamModel*)model;

@property (weak,nonatomic) BBCenterViewManager  *cManager;
-(void)requestSearch:(BBCRequestParamModel*)model;
@end
