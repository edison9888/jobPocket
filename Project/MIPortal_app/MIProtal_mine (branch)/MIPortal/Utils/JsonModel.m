//
//  JsonModel.m
//  xhgdzwyq
//
//  Created by apple on 13-11-28.
//  Copyright (c) 2013年 Eshore. All rights reserved.
//

#import "JsonModel.h"

@implementation JsonModel

- (id)initWithDictionary:(NSDictionary* )dict
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
    // subclass implementation should do a deep mutable copy
    // this class doesn't have any ivars so this is ok
	JsonModel *newModel = [[JsonModel allocWithZone:zone] init];
	return newModel;
}

-(id) copyWithZone:(NSZone *)zone
{
    // subclass implementation should do a deep mutable copy
    // this class doesn't have any ivars so this is ok
	JsonModel *newModel = [[JsonModel allocWithZone:zone] init];
	return newModel;
}

- (id)valueForUndefinedKey:(NSString *)key
{
    // subclass implementation should provide correct key value mappings for custom keys
    NSLog(@"Undefined Key: %@", key);
    return nil;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    // subclass implementation should set the correct key value mappings for custom keys
    NSLog(@"Undefined Key: %@", key);
}

- (void)setValue:(id)value forKey:(NSString *)key
{
    [super setValue:value forKey:key];
}

@end
