//
//  ABLogItem.h
//  CTPocketV4
//
//  Created by apple on 14-3-27.
//  Copyright (c) 2014年 广东亿迅科技有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum ABLogType__ {
    ABLogTypeUpload = 0,
    ABLogTypeDownload = 1,
    ABLogTypeRollback
}ABLogType;

@interface ABLogItem : NSObject<NSCopying, NSMutableCopying>

@property (nonatomic, assign) NSTimeInterval    time;
@property (nonatomic, assign) ABLogType         type;
@property (nonatomic, assign) int               totalContact;
@property (nonatomic, strong) NSString*         comment;
@property (nonatomic, assign) BOOL              success;

- (NSString* )jsonString;
- (instancetype)initWithDictionary:(NSDictionary*)dict;

@end
