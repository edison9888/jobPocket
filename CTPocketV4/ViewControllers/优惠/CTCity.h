//
//  CTCity.h
//  CTPocketV4
//
//  Created by liuruxian on 14-1-12.
//  Copyright (c) 2014年 广东亿迅科技有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CTCity : NSObject

@property (nonatomic, strong) NSString *provincecode;
@property (nonatomic, strong) NSString *citycode;
@property (nonatomic, strong) NSString *cityname;
@property (nonatomic, strong) NSString *hbcitycode;
@property (nonatomic ,strong) NSString *hbprovincecode;
@property (nonatomic, strong) NSString *citynameAlph;//拼音简写
@property (nonatomic, strong) NSString *provincename;

+ (CTCity *)modelObjectWithDictionary : (NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;


@end
