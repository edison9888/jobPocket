//
//  FlowCardValidata.h
//  CTPocketV4
//
//  Created by apple on 13-11-3.
//  Copyright (c) 2013年 广东亿迅科技有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^Finish) (NSDictionary *) ; //定义一个方法快

@interface FlowCardValidata : NSObject

+ (FlowCardValidata *) shareFlowCardValidata;
- (void)flowValidatePhoneNumber:(NSString *)phoneNumber finish:(void(^)(NSDictionary *resultDictionary))finish ;
@property (nonatomic,copy,readwrite) Finish finish;

@end
