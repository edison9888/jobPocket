//
//  GroupObj.m
//  CTPocketV4
//
//  Created by apple on 14-3-10.
//  Copyright (c) 2014年 广东亿迅科技有限公司. All rights reserved.
//

#import "GroupObj.h"

@implementation GroupObj

- (NSString* )description
{
    NSMutableString* desc = [NSMutableString new];
    [desc appendFormat:@"<%@>; \r", [self class]];
    [desc appendFormat:@"recordId=%d; \r", self.recordId];
    [desc appendFormat:@"name=%@; \r", self.groupName];
    [desc appendFormat:@"memberIds=%@;", self.memberIds];
    
    return desc;
}

- (Group* )toGroup
{
    Group_Builder* groupBuilder = [Group builder];
    [groupBuilder setServerId:self.recordId];       // 上传时将recordId字段做为serverId字段
    
    if (self.groupName) {
        [groupBuilder setName:self.groupName];
    }
    
    return [groupBuilder build];
}

- (NSString* )jsonString
{
    NSMutableDictionary* dict = [NSMutableDictionary dictionary];
    [dict setObject:[NSNumber numberWithInt:self.recordId] forKey:@"recordId"];
    if (self.groupName.length) {
        [dict setObject:self.groupName forKey:@"groupName"];
    }
    if (self.memberIds.count) {
        [dict setObject:self.memberIds forKey:@"memberIds"];
    }
    
    NSString* jsonStr = @"";
    NSData* jsonData = [NSJSONSerialization dataWithJSONObject:dict options:0 error:nil];
    if (jsonData.length) {
        jsonStr = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    }
    
    return jsonStr;
}

- (instancetype)initWithDictionary:(NSDictionary*)dict
{
    self = [super init];
    if (self)
    {
        [self setValuesForKeysWithDictionary:dict];
    }
    
    return self;
}

-(BOOL) allowsKeyedCoding
{
	return YES;
}

- (id)mutableCopyWithZone:(NSZone *)zone
{
	GroupObj *newModel = [[GroupObj allocWithZone:zone] init];
	return newModel;
}

-(id) copyWithZone:(NSZone *)zone
{
	GroupObj *newModel = [[GroupObj allocWithZone:zone] init];
	return newModel;
}

- (id)valueForUndefinedKey:(NSString *)key
{
    DDLogCInfo(@"Undefined Key: %@", key);
    return nil;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    DDLogCInfo(@"Undefined Key: %@", key);
}

- (void)setValue:(id)value forKey:(NSString *)key
{
    [super setValue:value forKey:key];
}

@end
