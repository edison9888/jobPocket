//
//  EsUserVerify.m
//  xhgdzwyq
//
//  Created by Eshore on 13-11-12.
//  Copyright (c) 2013年 Eshore. All rights reserved.
//

#import "EsUserVerify.h"

@implementation EsUser

- (id)init
{
    self = [super init];
    if (self) {
        _token = @"";
        _phone = @"";   // added by zy, 2013-11-23
    }
    return self;
}

@end

@implementation EsUserVerify

- (id)init
{
    self = [super init];
    if (self) {
        _user = [[EsUser alloc] init];
    }
    return self;
}

- (NSString *)getToken
{
//    return self.user.token;
#warning wensj 用于测试 aa6U8RegsZ
    return @"aa6U8RegsZ";
}

@end
