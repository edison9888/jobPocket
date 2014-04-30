//
//  BaseModel.m
//  CTPocketV4
//
//  Created by Y W on 14-3-11.
//  Copyright (c) 2014年 广东亿迅科技有限公司. All rights reserved.
//

#import "BaseModel.h"


@implementation BaseModelObject

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict
{
    id object = [dict objectForKey:aKey];
    if ([object isKindOfClass:[NSString class]] && [object isEqualToString:@"null"]) {
        object = nil;
    }
    return [object isEqual:[NSNull null]] ? nil : object;
}

@end




@implementation BaseModel

- (void)cancel
{
    
}

@end
