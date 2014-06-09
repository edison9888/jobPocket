//
//  BBTopItemDataModel.m
//  CTPocketV4
//
//  Created by Gong Xintao on 14-6-6.
//  Copyright (c) 2014年 广东亿迅科技有限公司. All rights reserved.
//

#import "BBTopItemDataModel.h"
@interface BBTopItemDataModel()<NSCoding>

@end
@implementation BBTopItemDataModel
- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.Freight_Area_Code forKey:@"Freight_Area_Code"];
    [aCoder encodeObject:self.Freight_Area_Name forKey:@"Freight_Area_Name"];
}
- (id)initWithCoder:(NSCoder *)aDecoder
{
    self=[super init];
    if (self) {
        self.Freight_Area_Code=[aDecoder decodeObjectForKey:@"Freight_Area_Code"];
        self.Freight_Area_Name=[aDecoder decodeObjectForKey:@"Freight_Area_Name"];
    }
    return self;
}
-(NSData*)archive
{
    return [NSKeyedArchiver archivedDataWithRootObject:self];
}
+(instancetype)unarchiveWithData:(NSData*)data
{
   return  [NSKeyedUnarchiver unarchiveObjectWithData:data];
}
-(instancetype)initWithDictionary:(NSDictionary*)dic
{
    self=[super init];
    if (self) {
        self.Freight_Area_Code=dic[@"Freight_Area_Code"];
        self.Freight_Area_Name=dic[@"Freight_Area_Name"];
    }
    return self;
}
@end
