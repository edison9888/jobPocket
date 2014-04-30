//
//  ABAddressBookReader.h
//  CTPocketV4
//
//  Created by apple on 14-3-27.
//  Copyright (c) 2014年 广东亿迅科技有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AddressBook/AddressBook.h>
#import "GroupObj.h"

@interface ABAddressBookReader : NSObject

// 读取本地通讯录
- (void)readRecordsFromAB:(ABAddressBookRef)addrBookRef
               completion:(void(^)(NSArray* contacts, NSArray* groups, BOOL success, BOOL hasPopedAlertMsg))completion;

+ (GroupObj* )convertABRecord2GroupObj:(ABRecordRef)record;

@end
