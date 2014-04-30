//
//  AddressBookAdpater.h
//  CTPocketV4
//
//  Created by apple on 14-3-11.
//  Copyright (c) 2014年 广东亿迅科技有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AddressBook/AddressBook.h>

@interface AddressBookAdpater : NSObject

@property (nonatomic, strong) NSMutableArray*       contactList;
@property (nonatomic, strong) NSMutableArray*       groupList;

// 解析下载联系人信息
- (void)parseDictionary:(NSDictionary* )srcdict
             completion:(void(^)(void))completion;

// 读取本地通讯录
- (void)readRecordsFromAB:(ABAddressBookRef)addrBookRef
               completion:(void(^)(BOOL success,BOOL hasPopedAlertMsg))completion;

// 写入本地通讯录
- (BOOL)writeAllRecords2AB:(ABAddressBookRef)addrBookRef
           progressChanged:(void(^)(double progress))progressChanged
               initPercent:(double)initPercent     // 初始占比
              totalPercent:(double)totalPercent;   // 总占比

// 全量删除本地通讯录
- (BOOL)deleteAddressBook:(ABAddressBookRef)addrBookRef;
- (BOOL)localBackupAddressBook:(ABAddressBookRef)addrBookRef;       // 本地备份通讯录

// 回滚本地备份的通讯录
- (void)rollbackLocalAddressBook:(ABAddressBookRef)addrBookRef
                 progressChanged:(void(^)(double progress))progressChanged
                      completion:(void(^)(BOOL success, int totalCnt, NSTimeInterval backupTimestamp))completion;
- (BOOL)localBackupCacheExist;
- (void)deleteLocalBackupCache; // 删除本地备份

@end
