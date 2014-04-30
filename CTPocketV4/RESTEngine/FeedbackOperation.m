//
//  FeedbackOperation.m
//  CTPocketV4
//
//  Created by 许忠洲 on 13-10-29.
//  Copyright (c) 2013年 广东亿迅科技有限公司. All rights reserved.
//

#import "FeedbackOperation.h"

#define kRequestErrorDomain @"HTTP_ERROR"
#define kBusinessErrorDomain @"BIZ_ERROR"

@interface FeedbackOperation ()

@property (nonatomic, strong) NSError *restError;

@end

@implementation FeedbackOperation

- (void)operationSucceeded
{
    // even when request completes without a HTTP Status code, it might be a benign error
    
    NSDictionary *responseDict = [self responseJSON];
    
    if ([[responseDict objectForKey:@"result"] intValue] == 1)
    {
        [super operationSucceeded];
    }
    else
    {
        self.restError = [[NSError alloc] initWithDomain:kBusinessErrorDomain
                                                    code:[[responseDict objectForKey:@"result"] intValue]
                                                userInfo:responseDict];
        [super operationFailedWithError:self.restError];
    }
}

- (void)operationFailedWithError:(NSError *)theError
{
    [super operationFailedWithError:theError];
}

@end
