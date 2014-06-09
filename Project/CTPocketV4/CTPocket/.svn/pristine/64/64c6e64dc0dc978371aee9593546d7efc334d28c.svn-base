//
//  AddressBookAdpater.m
//  CTPocketV4
//
//  Created by apple on 14-3-11.
//  Copyright (c) 2014年 广东亿迅科技有限公司. All rights reserved.
//

#import "AddressBookAdpater.h"
#import "ContactInfoParser.h"
#import "ABAddressBookReader.h"
#import "ABAddressBookWriter.h"
#import "ABAddressBookRoller.h"
#import "ABAddressBookDeleter.h"

@implementation AddressBookAdpater

#pragma mark parse server data
- (void)parseDictionary:(NSDictionary* )srcdict completion:(void(^)(void))completion
{
    // 解析下载联系人信息
    __weak typeof(self) wself = self;
    ContactInfoParser* parser = [ContactInfoParser new];
    [parser parseDictionary:srcdict completion:^(NSArray *contacts, NSArray *groups) {
        wself.contactList = [NSMutableArray arrayWithArray:contacts];
        wself.groupList = [NSMutableArray arrayWithArray:groups];
        
        if (completion) {
            completion();
        }
    }];
}

#pragma mark read addressbook functions
- (void)readRecordsFromAB:(ABAddressBookRef)addrBookRef completion:(void(^)(BOOL success, BOOL hasPopedAlertMsg))completion
{
    // 读取本地通讯录
    __weak typeof(self) wself = self;
    ABAddressBookReader* reader = [ABAddressBookReader new];
    [reader readRecordsFromAB:addrBookRef completion:^(NSArray *contacts, NSArray *groups, BOOL success, BOOL hasPopedAlertMsg) {
        wself.contactList = [NSMutableArray arrayWithArray:contacts];
        wself.groupList = [NSMutableArray arrayWithArray:groups];
        
        if (completion) {
            completion(success, hasPopedAlertMsg);
        }
    }];
}

#pragma mark write addressbook functions
- (BOOL)writeAllRecords2AB:(ABAddressBookRef)addressBook
           progressChanged:(void(^)(double progress))progressChanged
               initPercent:(double)initPercent     // 初始占比
              totalPercent:(double)totalPercent    // 总占比
{
    // 写入本地通讯录
    ABAddressBookWriter* writer = [ABAddressBookWriter new];
    return [writer writeAllRecords2AB:addressBook
                          contactList:self.contactList
                            groupList:self.groupList
                      progressChanged:progressChanged
                          initPercent:initPercent
                         totalPercent:totalPercent];
}

#pragma mark delete
- (BOOL)deleteAddressBook:(ABAddressBookRef)addrBookRef
{
    // 全量删除本地通讯录
    ABAddressBookDeleter* deleter = [ABAddressBookDeleter new];
    return [deleter deleteAddressBook:addrBookRef];
}

#pragma mark 本地备份与回滚
- (BOOL)localBackupAddressBook:(ABAddressBookRef)addrBookRef
{
    // 本地备份通讯录
    ABAddressBookRoller* roller = [ABAddressBookRoller new];
    return [roller localBackupAddressBook:addrBookRef];
}

- (void)rollbackLocalAddressBook:(ABAddressBookRef)addrBookRef
                 progressChanged:(void(^)(double progress))progressChanged
                      completion:(void(^)(BOOL success, int totalCnt, NSTimeInterval backupTimestamp))completion
{
    // 回滚本地备份的通讯录
    ABAddressBookRoller* roller = [ABAddressBookRoller new];
    [roller rollbackLocalAddressBook:addrBookRef
                     progressChanged:progressChanged
                         initPercent:0
                        totalPercent:1
                          completion:completion];
}

- (BOOL)localBackupCacheExist
{
    ABAddressBookRoller* roller = [ABAddressBookRoller new];
    return [roller localBackupCacheExist];
}

- (void)deleteLocalBackupCache // 删除本地备份
{
    ABAddressBookRoller* roller = [ABAddressBookRoller new];
    [roller deleteLocalBackupCache];
}

@end
