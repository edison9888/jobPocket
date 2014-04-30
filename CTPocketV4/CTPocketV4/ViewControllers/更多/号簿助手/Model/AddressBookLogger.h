//
//  AddressBookLogger.h
//  CTPocketV4
//
//  Created by apple on 14-3-27.
//  Copyright (c) 2014年 广东亿迅科技有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ABLogItem.h"

extern NSString* const CTAddressBookLogChanged;

@interface AddressBookLogger : NSObject

- (void)saveLog:(ABLogItem*)log;
- (NSArray*)loadABLog;

- (BOOL)checkIfSamePlatform;

@end
