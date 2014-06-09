//
//  ABAddressBookRoller.h
//  CTPocketV4
//
//  Created by apple on 14-3-27.
//  Copyright (c) 2014年 广东亿迅科技有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AddressBook/AddressBook.h>

@interface ABAddressBookRoller : NSObject

- (BOOL)localBackupAddressBook:(ABAddressBookRef)addrBookRef;       // 本地备份通讯录

// 回滚本地备份的通讯录
- (void)rollbackLocalAddressBook:(ABAddressBookRef)addrBookRef
                 progressChanged:(void(^)(double progress))progressChanged
                     initPercent:(double)initPercent     // 初始占比
                    totalPercent:(double)totalPercent    // 总占比
                      completion:(void(^)(BOOL success, int totalCnt, NSTimeInterval backupTimestamp))completion;

- (BOOL)localBackupCacheExist;
- (void)deleteLocalBackupCache; // 删除本地备份

@end
