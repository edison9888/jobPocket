//
//  CTQryCity_Model.m
//  CTPocketV4
//
//  Created by liuruxian on 14-1-12.
//  Copyright (c) 2014年 广东亿迅科技有限公司. All rights reserved.
//

#import "CTQryCity_Model.h"
#import "CTCity.h"

// NSString *const kQryCityModel_CityModel = @"CityModel";

@implementation CTQryCity_Model

+ (CTQryCity_Model *)modelObjectWithDictionary : (NSDictionary *)dict
{
    CTQryCity_Model *instance = [[CTQryCity_Model alloc] initWithDictionary:dict];
    return instance ;
}

- (instancetype) initWithDictionary : (NSDictionary *) dict
{
    self = [super init];
    
    if (self && [dict isKindOfClass:[NSDictionary class]]) {
        NSObject *reveciveCitys = dict[kQryCityModel_CityModel];
        NSMutableArray *array = [NSMutableArray new];
        if ([reveciveCitys isKindOfClass:[NSArray class]]) {
            for (NSDictionary *dict in (NSArray *)reveciveCitys) {
                [array addObject:[CTCity modelObjectWithDictionary:dict]];
            }
        } else if([reveciveCitys isKindOfClass:[NSDictionary class]])
        {
            [array addObject:[CTCity modelObjectWithDictionary:dict]];
        }
        self.citysArray = [NSArray arrayWithArray:array];
    }
    
    return self;
}

- (NSDictionary *) dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    NSMutableArray *tempArrayForEndCitys = [NSMutableArray array];
    for (NSObject *subArrayObject in self.citysArray) {
        if([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForEndCitys addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForEndCitys addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForEndCitys] forKey:kQryCityModel_CityModel];
    
    return [NSDictionary dictionaryWithDictionary:mutableDict];
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

@end
