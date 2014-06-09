//
//  JsonModel.h
//  xhgdzwyq
//
//  Created by apple on 13-11-28.
//  Copyright (c) 2013年 Eshore. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JsonModel : NSObject<NSCopying, NSMutableCopying>

- (id)initWithDictionary:(NSDictionary* )dict;

@end
