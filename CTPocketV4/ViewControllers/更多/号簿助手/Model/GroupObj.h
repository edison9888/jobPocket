//
//  GroupObj.h
//  CTPocketV4
//
//  Created by apple on 14-3-10.
//  Copyright (c) 2014年 广东亿迅科技有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Contact_proto.pb.h"

@interface GroupObj : NSObject<NSCopying, NSMutableCopying>

@property (nonatomic, assign) int32_t   recordId;           // 通讯录ID，上传时为本地记录ID，下载时为服务器端返回的记录ID
@property (nonatomic, strong) NSString* serverVersion;      // 服务端版本号
@property (nonatomic, strong) NSString* groupName;          // 组名
@property (nonatomic, strong) NSArray*  memberIds;          // 本地包含的联系人信息

- (Group* )toGroup;
- (NSString* )jsonString;
- (instancetype)initWithDictionary:(NSDictionary*)dict;

@end
