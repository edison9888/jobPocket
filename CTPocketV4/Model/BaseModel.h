//
//  BaseModel.h
//  CTPocketV4
//
//  Created by Y W on 14-3-11.
//  Copyright (c) 2014年 广东亿迅科技有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BaseModelObject : NSObject

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end



#import "AppDelegate.h"

typedef void(^RequestFinishBlock)(NSDictionary *resultParams, NSError *error);

@interface BaseModel : NSObject

- (void)cancel;

@end
