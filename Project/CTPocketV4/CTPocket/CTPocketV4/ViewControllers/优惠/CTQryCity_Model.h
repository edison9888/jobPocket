//
//  CTQryCity_Model.h
//  CTPocketV4
//
//  Created by liuruxian on 14-1-12.
//  Copyright (c) 2014年 广东亿迅科技有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

#define kQryCityModel_CityModel @"CityModel"

@interface CTQryCity_Model : NSObject

@property (nonatomic, strong) NSArray *citysArray;

+ (CTQryCity_Model *)modelObjectWithDictionary : (NSDictionary *)dict;

@end


