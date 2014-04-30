//
//  BestToneOperation.m
//  CTPocketV4
//
//  Created by 许忠洲 on 13-10-29.
//  Copyright (c) 2013年 广东亿迅科技有限公司. All rights reserved.
//

#import "BestToneOperation.h"

#define kRequestErrorDomain @"HTTP_ERROR"
#define kBusinessErrorDomain @"BIZ_ERROR"

@interface BestToneOperation ()

@property (nonatomic, strong) NSError *restError;

@end

@implementation BestToneOperation

- (void)operationSucceeded
{
    // even when request completes without a HTTP Status code, it might be a benign error
    [super operationSucceeded];
}

- (void)operationFailedWithError:(NSError *)theError
{
    [super operationFailedWithError:theError];
}

@end
