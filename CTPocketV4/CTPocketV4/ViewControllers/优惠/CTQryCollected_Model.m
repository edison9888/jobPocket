//
//  CTQryCollected_Model.m
//  CTPocketV4
//
//  Created by liuruxian on 14-1-10.
//  Copyright (c) 2014年 广东亿迅科技有限公司. All rights reserved.
//

#import "CTQryCollected_Model.h"
#import "CTPrettyNumData.h"

NSString *const kQryCollected_ModePrettyNum = @"qryCollected";


@implementation CTQryCollected_Model


+ (CTQryCollected_Model *)modelObjectWityDictionary:(NSDictionary *)dict
{
    CTQryCollected_Model *instance = [[CTQryCollected_Model alloc]initWithDictionary:dict];
    return instance ;
}

- (instancetype)initWithDictionary:(NSDictionary *)dict
{
    self = [super init];
    if (self && [dict isKindOfClass:[NSDictionary class]]) {
        id obj = [dict objectForKey:kQryCollected_ModePrettyNum];
        if (obj) {
            if ([obj isKindOfClass:[NSArray class]]) {
                NSMutableArray *parseCollectedArray = [NSMutableArray new];
                if ([obj isKindOfClass:[NSArray class]]) {
                    for (NSDictionary *dictionary in obj) {
                        CTPrettyNumData *data = [CTPrettyNumData modelObjectWithDictionary:dictionary];
                        [parseCollectedArray addObject:data];
                    }
                } else if([obj isKindOfClass:[NSDictionary class]]) {
                    [parseCollectedArray addObject:[CTPrettyNumData modelObjectWithDictionary:(NSDictionary *)obj]];
                }
                
                self.collectedArray = [NSMutableArray arrayWithArray:parseCollectedArray];
            }
          
        }
    }

    return self;
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    NSMutableArray *tempArrayForNum = [NSMutableArray array];
    for (NSObject *subArrayObj in self.collectedArray) {
        if ([subArrayObj respondsToSelector:@selector(dictionaryRepresentation)]) {
            //the class is obj
            [tempArrayForNum addObject:[subArrayObj performSelector:@selector(dictionaryRepresentation)]];
        } else{
            [tempArrayForNum addObject:subArrayObj];
        }
    }
    
    [mutableDict setValue:tempArrayForNum forKey:kQryCollected_ModePrettyNum];
    return nil;
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"%@", [self dictionaryRepresentation]];
}

#pragma mark - Helper Method
- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict
{
    id object = [dict objectForKey:aKey];
    return [object isEqual:[NSNull null]] ? nil : object;
}

#pragma mark - NSCoding Methods

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    
    self.collectedArray = [aDecoder decodeObjectForKey:kQryCollected_ModePrettyNum];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.collectedArray forKey:kQryCollected_ModePrettyNum];
}



@end
