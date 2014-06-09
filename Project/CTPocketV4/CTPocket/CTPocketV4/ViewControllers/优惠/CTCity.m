//
//  CTCity.m
//  CTPocketV4
//
//  Created by liuruxian on 14-1-12.
//  Copyright (c) 2014年 广东亿迅科技有限公司. All rights reserved.
//

#import "CTCity.h"

NSString *const kCityscityname = @"cityname";
NSString *const kCityscitycode = @"citycode";
NSString *const kCitysprovincecode = @"provincecode";
NSString *const kCityscitynameAlph = @"citynameAlph";
NSString *const kCitysprovincename = @"provincename";
NSString *const kCityshbcitycode = @"hbcitycode";
NSString *const kCityshbprovincecode = @"hbprovincecode";

//@property (nonatomic, strong) NSString *hbcitycode;
//@property (nonatomic ,strong) NSString *hbprovincecode;
@implementation CTCity

+ (CTCity *)modelObjectWithDictionary : (NSDictionary *)dict
{
    CTCity *instance = [[CTCity alloc] initWithDictionary:dict];
    return instance ;
}

- (instancetype) initWithDictionary : (NSDictionary *)dict
{
    self = [super init];
    
    // This check serves to make sure that a non-NSDictionary object
    // passed into the model class doesn't break the parsing.
    if (self && [dict isKindOfClass:[NSDictionary class]]) {
        self.provincecode = [self objectOrNilForKey:kCitysprovincecode fromDictionary:dict];
//        self.citycode = [self objectOrNilForKey:kCityshbcitycode fromDictionary:dict];
        self.citycode = [self objectOrNilForKey:kCityscitycode fromDictionary:dict];
        self.cityname = [self objectOrNilForKey:kCityscityname fromDictionary:dict];
        self.citynameAlph = [self objectOrNilForKey:kCityscitynameAlph fromDictionary:dict];
        self.hbcitycode = [self objectOrNilForKey:kCityshbcitycode fromDictionary:dict];
        self.hbprovincecode = [self objectOrNilForKey:kCityshbprovincecode fromDictionary:dict];
        self.provincename = [self objectOrNilForKey:kCitysprovincename fromDictionary:dict];
    }
    
    return self;
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    
    [mutableDict setValue:self.citycode forKey:kCityscitycode];
    [mutableDict setValue:self.cityname forKey:kCityscityname];
     [mutableDict setValue:self.citynameAlph forKey:kCityscitynameAlph];
    [mutableDict setValue:self.provincecode forKey:kCitysprovincecode];
    [mutableDict setValue:self.hbcitycode forKey:kCityshbcitycode];
    [mutableDict setValue:self.hbprovincecode forKey:kCityshbprovincecode];
    [mutableDict setValue:self.provincename forKey:kCitysprovincename];
    
    return [NSDictionary dictionaryWithDictionary:mutableDict];
}

#pragma mark - Helper Method

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict
{
    id object = [dict objectForKey:aKey];
    return [object isEqual:[NSNull null]] ? nil : object;
}

#pragma mark - NSCoding Methods
//序列化
- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    
    self.citycode = [aDecoder decodeObjectForKey:kCityscitycode];
    self.cityname = [aDecoder decodeObjectForKey:kCityscityname];
    self.citynameAlph = [aDecoder decodeObjectForKey:kCityscitynameAlph];
    self.provincecode = [aDecoder decodeObjectForKey:kCitysprovincecode];
    self.hbcitycode = [aDecoder decodeObjectForKey:kCityshbcitycode];
    self.hbprovincecode = [aDecoder decodeObjectForKey:kCityshbprovincecode];
    self.provincename = [aDecoder decodeObjectForKey:kCitysprovincename];

    
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:_citycode forKey:kCityscitycode];
    [aCoder encodeObject:_cityname forKey:kCityscityname];
    [aCoder encodeObject:_citynameAlph forKey:kCityscitynameAlph];
    [aCoder encodeObject:_hbcitycode forKey:kCityshbcitycode];
    [aCoder encodeObject:_hbprovincecode forKey:kCityshbprovincecode];
    [aCoder encodeObject:_provincecode forKey:kCitysprovincecode];
    [aCoder encodeObject:_provincename forKey:kCitysprovincename];
}

- (NSString *)smartCityName
{
    if (self.cityname) {
        return self.cityname;
    } else {
        return self.cityname;
    }
}

// added by zy, 2014-02-21
- (id)mutableCopyWithZone:(NSZone *)zone
{
    // subclass implementation should do a deep mutable copy
    // this class doesn't have any ivars so this is ok
	CTCity *obj = [CTCity modelObjectWithDictionary:self.dictionaryRepresentation];
	return obj;
}

// added by zy, 2014-02-21
-(id) copyWithZone:(NSZone *)zone
{
    // subclass implementation should do a deep mutable copy
    // this class doesn't have any ivars so this is ok
    CTCity *obj = [CTCity modelObjectWithDictionary:self.dictionaryRepresentation];
	return obj;
}

@end
