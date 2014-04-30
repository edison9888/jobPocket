//
//  ContactInfoParser.h
//  CTPocketV4
//
//  Created by apple on 14-3-27.
//  Copyright (c) 2014年 广东亿迅科技有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ContactInfoParser : NSObject

// 解析下载联系人信息
- (void)parseDictionary:(NSDictionary* )srcdict
             completion:(void(^)(NSArray* contacts, NSArray* groups))completion;

@end
