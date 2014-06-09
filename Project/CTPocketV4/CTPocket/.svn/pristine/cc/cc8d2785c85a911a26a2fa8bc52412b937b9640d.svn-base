//
//  Global.m
//  CTPocketV4
//
//  Created by 许忠洲 on 13-10-29.
//  Copyright (c) 2013年 广东亿迅科技有限公司. All rights reserved.
//

#import "Global.h"

#define kUseOtherPhoneNumber 0

@implementation Global

// 比较现代的单例模式实现，使用GCD+ARC
+ (Global *)sharedInstance
{
    static dispatch_once_t pred = 0;
    __strong static id _sharedObject = nil;
    dispatch_once(&pred, ^{
        _sharedObject = [[self alloc] init]; // or some other init method
    });
    return _sharedObject;
}

#if kUseOtherPhoneNumber

- (void)setLoginInfoDict:(NSDictionary *)loginInfoDict
{
    if (loginInfoDict == nil) {
        _loginInfoDict = nil;
        return;
    }
    NSMutableDictionary *loginInfo = [NSMutableDictionary dictionaryWithDictionary:loginInfoDict];
    [loginInfo setObject:@"18046522669" forKey:@"UserLoginName"];
    _loginInfoDict = loginInfo;
}

#endif

@end
