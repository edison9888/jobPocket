//
//  ABLogItem.m
//  CTPocketV4
//
//  Created by apple on 14-3-27.
//  Copyright (c) 2014年 广东亿迅科技有限公司. All rights reserved.
//

#import "ABLogItem.h"

@implementation ABLogItem

- (NSString* )jsonString
{
    NSMutableDictionary* dict = [NSMutableDictionary dictionary];
    [dict setObject:[NSNumber numberWithDouble:self.time] forKey:@"time"];
    [dict setObject:[NSNumber numberWithInt:self.type] forKey:@"type"];
    [dict setObject:[NSNumber numberWithInt:self.totalContact] forKey:@"totalContact"];
    [dict setObject:[NSNumber numberWithBool:self.success] forKey:@"success"];
    if (self.comment.length) {
        [dict setObject:self.comment forKey:@"comment"];
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
	ABLogItem *newModel = [[ABLogItem allocWithZone:zone] init];
	return newModel;
}

-(id) copyWithZone:(NSZone *)zone
{
	ABLogItem *newModel = [[ABLogItem allocWithZone:zone] init];
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
    if ([key isEqualToString:@"time"]) {
        self.time = [value doubleValue];
    } else if ([key isEqualToString:@"type"]) {
        self.type = [value intValue];
    } else if ([key isEqualToString:@"totalContact"]) {
        self.totalContact = [value intValue];
    } else if ([key isEqualToString:@"success"]) {
        self.success = [value boolValue];
    } else {
        [super setValue:value forKey:key];
    }
}

@end
