//
//  EsUserVerify.h
//  xhgdzwyq
//
//  Created by Eshore on 13-11-12.
//  Copyright (c) 2013年 Eshore. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EsUser : NSObject

@property (nonatomic, strong) NSString *token;
@property (nonatomic, strong) NSString *phone;  // added by zy, 2013-11-23
@property (nonatomic, strong) NSString *clientId;   // added by shanhq, 2014-6-3
@property (nonatomic, strong) NSString *clientName;
@property (nonatomic, strong) NSString *department;
@property (nonatomic, strong) NSString *email;
@property (nonatomic, strong) NSString *weixinNum;
@property (nonatomic, strong) NSString *workplace;

@end

@interface EsUserVerify : NSObject

@property (nonatomic, strong) EsUser *user;

- (NSString *)getToken;

@end
