//
//  CTPrettyNum_Model.m
//  CTPocketV4
//
//  Created by liuruxian on 14-1-9.
//  Copyright (c) 2014年 广东亿迅科技有限公司. All rights reserved.
//

#import "CTPrettyNumData.h"

NSString *const kPrettyNumPhoneNumber = @"PhoneNumber";
NSString *const kPrettyNumPrepayMent = @"PrepayMent";
NSString *const kPrettyNumStatus = @"Status";
NSString *const kPrettyNumMinAmount = @"MinAmount";
NSString *const kPrettyNumSalesProdId = @"SalesProdId";
NSString *const kPrettyNumLevel = @"Level";
NSString *const kPrettyNumTipText = @"TipText";
NSString *const kPrettyNumHlStart = @"HlStart";
NSString *const kPrettyNumHlEnd = @"HlEnd";
NSString *const kPrettyNumProvince = @"Province";
NSString *const kPrettyNumCity = @"City";
NSString *const kPrettyNumProvinceCode = @"ProvinceCode";
NSString *const kPrettyNumCityCode = @"CityCode";
NSString *const kPrettyNumCittIsCollected = @"isCollected";
NSString *const kPrettyNumTypeId = @"TypeId";
NSString *const kPrettyNumSpecialOffers = @"SpecialOffers";

@implementation CTPrettyNumData


+ (CTPrettyNumData *)modelObjectWithDictionary:(NSDictionary *)dict
{
    CTPrettyNumData *instance = [[CTPrettyNumData alloc] initWithDictionary:dict];
    return instance;
}

- (instancetype)initWithDictionary:(NSDictionary *)dict
{
    self = [super init];
    
    
    
//    City = "\U5e02\U8f96\U533a";
//    CityCode = 8110100;
//    HlEnd = 0;
//    HlStart = 0;
//    Level = 0;
//    MinAmount = "0.0";
//    PhoneNumber = 18101334024;
//    PrepayMent = "0.0";
//    Province = "\U5317\U4eac";
//    ProvinceCode = 609001;
//    SalesProdId = 00000000E84E70B6CB697E4AE043AE1410ACE51A;
//    Status = 2;
//    TipText = null;
//    Type = "";
//    isCollected = "";
    
    
    // This check serves to make sure that a non-NSDictionary object
    // passed into the model class doesn't break the parsing.
    if(self && [dict isKindOfClass:[NSDictionary class]]) {
        self.PhoneNumber = [self objectOrNilForKey:kPrettyNumPhoneNumber fromDictionary:dict];
        self.PrepayMent = [self objectOrNilForKey:kPrettyNumPrepayMent fromDictionary:dict];
        self.Status = [self objectOrNilForKey:kPrettyNumStatus fromDictionary:dict];
        self.MinAmount = [self objectOrNilForKey:kPrettyNumMinAmount fromDictionary:dict];
        self.SalesProdId = [self objectOrNilForKey:kPrettyNumSalesProdId fromDictionary:dict];
        self.Level = [self objectOrNilForKey:kPrettyNumLevel fromDictionary:dict];
        self.TipText = [self objectOrNilForKey:kPrettyNumTipText fromDictionary:dict];
        self.HlStart = [self objectOrNilForKey:kPrettyNumHlStart fromDictionary:dict];
        self.HlEnd = [self objectOrNilForKey:kPrettyNumHlEnd fromDictionary:dict];
        self.Province = [self objectOrNilForKey:kPrettyNumProvince fromDictionary:dict];
        self.City = [self objectOrNilForKey:kPrettyNumCity fromDictionary:dict];
        self.ProvinceCode = [self objectOrNilForKey:kPrettyNumProvinceCode fromDictionary:dict];
        self.CityCode = [self objectOrNilForKey:kPrettyNumCityCode fromDictionary:dict];
        self.isCollected = [self objectOrNilForKey:kPrettyNumCittIsCollected fromDictionary:dict];
        self.TypeId = [self objectOrNilForKey:kPrettyNumTypeId fromDictionary:dict];
        self.SpecialOffers = [self objectOrNilForKey:kPrettyNumSpecialOffers fromDictionary:dict];
    }
    
    return self;
    
}
//返回一个字典对象
- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    
    [mutableDict setValue:self.PhoneNumber forKey:kPrettyNumPhoneNumber];
    [mutableDict setValue:self.PrepayMent forKey:kPrettyNumPrepayMent];
    [mutableDict setValue:self.Status forKey:kPrettyNumStatus];
    [mutableDict setValue:self.MinAmount forKey:kPrettyNumMinAmount];
    [mutableDict setValue:self.SalesProdId forKey:kPrettyNumSalesProdId];
    [mutableDict setValue:self.Level forKey:kPrettyNumLevel];
    [mutableDict setValue:self.TipText forKey:kPrettyNumTipText];
    [mutableDict setValue:self.HlStart forKey:kPrettyNumHlStart];
    [mutableDict setValue:self.HlEnd forKey:kPrettyNumHlEnd];
    [mutableDict setValue:self.Province forKey:kPrettyNumProvince];
    [mutableDict setValue:self.City forKey:kPrettyNumCity];
    [mutableDict setValue:self.ProvinceCode forKey:kPrettyNumProvinceCode];
    [mutableDict setValue:self.CityCode forKey:kPrettyNumCityCode];
    [mutableDict setValue:self.isCollected forKey:kPrettyNumCittIsCollected];
    [mutableDict setValue:self.TypeId forKey:kPrettyNumTypeId];
    [mutableDict setValue:self.SpecialOffers forKey:kPrettyNumSpecialOffers];
    
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


#pragma mark - NSCoding Methods
//序列化
- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    
    self.PhoneNumber = [aDecoder decodeObjectForKey:kPrettyNumPhoneNumber];
    self.PrepayMent = [aDecoder decodeObjectForKey:kPrettyNumPrepayMent];
    self.Status = [aDecoder decodeObjectForKey:kPrettyNumStatus];
    self.MinAmount = [aDecoder decodeObjectForKey:kPrettyNumMinAmount];
    self.SalesProdId = [aDecoder decodeObjectForKey:kPrettyNumSalesProdId];
    self.Level = [aDecoder decodeObjectForKey:kPrettyNumLevel];
    self.TipText = [aDecoder decodeObjectForKey:kPrettyNumTipText];
    self.HlStart = [aDecoder decodeObjectForKey:kPrettyNumHlStart];
    self.HlEnd = [aDecoder decodeObjectForKey:kPrettyNumHlEnd];
    self.Province = [aDecoder decodeObjectForKey:kPrettyNumProvince];
    self.City = [aDecoder decodeObjectForKey:kPrettyNumCity];
    self.ProvinceCode = [aDecoder decodeObjectForKey:kPrettyNumProvinceCode];
    self.CityCode = [aDecoder decodeObjectForKey:kPrettyNumCityCode];
    self.TypeId = [aDecoder decodeObjectForKey:kPrettyNumTypeId];
    self.SpecialOffers = [aDecoder decodeObjectForKey:kPrettyNumSpecialOffers];
    
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:_PhoneNumber forKey:kPrettyNumPhoneNumber];
    [aCoder encodeObject:_PrepayMent forKey:kPrettyNumPrepayMent];
    [aCoder encodeObject:_Status forKey:kPrettyNumStatus];
    [aCoder encodeObject:_MinAmount forKey:kPrettyNumMinAmount];
    [aCoder encodeObject:_SalesProdId forKey:kPrettyNumSalesProdId];
    [aCoder encodeObject:_Level forKey:kPrettyNumLevel];
    [aCoder encodeObject:_TipText forKey:kPrettyNumTipText];
    [aCoder encodeObject:_HlStart forKey:kPrettyNumHlStart];
    [aCoder encodeObject:_HlEnd forKey:kPrettyNumHlEnd];
    [aCoder encodeObject:_Province forKey:kPrettyNumProvince];
    [aCoder encodeObject:_City forKey:kPrettyNumCity];
    [aCoder encodeObject:_ProvinceCode forKey:kPrettyNumProvinceCode];
    [aCoder encodeObject:_CityCode forKey:kPrettyNumCityCode];
    [aCoder encodeObject:_TypeId forKey:kPrettyNumTypeId];
    [aCoder encodeObject:_SpecialOffers forKey:kPrettyNumSpecialOffers];
}

@end
