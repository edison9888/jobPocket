//
//  ABAddressBookWriter.h
//  CTPocketV4
//
//  Created by apple on 14-3-27.
//  Copyright (c) 2014年 广东亿迅科技有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AddressBook/AddressBook.h>

@interface ABAddressBookWriter : NSObject

// 写入本地通讯录
- (BOOL)writeAllRecords2AB:(ABAddressBookRef)addressBook
               contactList:(NSArray* )contactList
                 groupList:(NSArray* )groupList
           progressChanged:(void(^)(double progress))progressChanged
               initPercent:(double)initPercent     // 初始占比
              totalPercent:(double)totalPercent;   // 总占比

+ (void)setPropertyValue:(NSString*)value withProperty:(ABPropertyID)property toABRecord:(ABRecordRef)record;

@end
