//
//  ABAddressBookRoller.m
//  CTPocketV4
//
//  Created by apple on 14-3-27.
//  Copyright (c) 2014年 广东亿迅科技有限公司. All rights reserved.
//

#import "ABAddressBookRoller.h"
#import "PersonObj.h"
#import "GroupObj.h"
#import "Utils.h"
#import "NSMutableDataAdditions.h"
#import "ABAddressBookReader.h"
#import "ABAddressBookWriter.h"
#import "ABAddressBookCache.h"
#import "RollbackABPerson.h"

/*
 说明：
 contact：保存联系人信息，AES加密，密钥为MD5(手机号码)
 group：保存分组信息，AES加密，密钥为MD5(手机号码)
 rid：保存联系人的id信息(vCard信息中没有保存recordId信息)
 关联信息的回滚：先回滚联系人信息（rollRecord），再回滚分组信息，memberIds-->rIdArr-->rollRecord
 */

NSString* const CTAddressBookContactCacheFile = @"contact";
NSString* const CTAddressBookGroupCacheFile = @"group";
NSString* const CTAddressBookRecordIDCacheFile = @"rid";
NSString* const CTAddressBookCacheFileTimestamp = @"timestamp";

@implementation ABAddressBookRoller

- (BOOL)localBackupAddressBook:(ABAddressBookRef)addrBookRef
{
    @autoreleasepool {
        // 本地备份通讯录
        return ([self localBackupABPersonFromAddressBook:addrBookRef] && [self localBackupABGroupFromAddressBook:addrBookRef]);
    }
}

- (BOOL)localBackupABPersonFromAddressBook:(ABAddressBookRef)addrBookRef
{
    if (!addrBookRef) {
        return NO;
    }
    
    BOOL success = YES;
    // 备份本地通讯录
    CFArrayRef contactRef = ABAddressBookCopyArrayOfAllPeople(addrBookRef);
    CFMutableArrayRef contactMutalRef = NULL;
    do {
        if (!contactRef) {
            break;
        }
        
        // 1. sort by first name
        contactMutalRef = CFArrayCreateMutableCopy(kCFAllocatorDefault, CFArrayGetCount(contactRef), contactRef);
        if (!contactMutalRef) {
            break;
        }
        
        CFArraySortValues(contactMutalRef,
                          CFRangeMake(0, CFArrayGetCount(contactMutalRef)),
                          (CFComparatorFunction)ABPersonComparePeopleByName,
                          kABPersonSortByFirstName);
        
        // 2. 提取id单独保存
        NSArray* recIDArr = [self getABRecordIds:contactMutalRef];
        NSString* recIDStr = @"";
        if (recIDArr.count) {
            recIDStr = [recIDArr componentsJoinedByString:@";"];
        }
        
        // 3. vCard
        CFDataRef contactVcard = ABPersonCreateVCardRepresentationWithPeople(contactMutalRef);
        if (!contactVcard) {
            break;
        }
        
        NSData* contactData = (NSData*)CFBridgingRelease(contactVcard);
        //if (!contactData.length) {
        if (!contactData) { // 允许保存空数据
            break;
        }
        
        // 4. encrypt-AES
        NSString* key = @"10000";
        NSDictionary* loginInfoDict = [Global sharedInstance].loginInfoDict;
        NSString* PhoneNumber = loginInfoDict[@"UserLoginName"];
        if (PhoneNumber.length) {
            key = [Utils MD5:PhoneNumber];
        }
        
        NSMutableData* encrypData = [[NSMutableData dataWithData:contactData] EncryptAES:key];
        //if (!encrypData.length) {
        if (!encrypData) {  // 允许保存空数据
            success = NO;
            break;
        }
        NSMutableData* encryptRIDData = [[NSMutableData dataWithData:[recIDStr dataUsingEncoding:NSUTF8StringEncoding]] EncryptAES:key];
        
        // 5. save
        NSString* filePath = kABAddressBookCachePath(key,CTAddressBookContactCacheFile);
        success = [encrypData writeToFile:filePath atomically:YES];
        success &= [encryptRIDData writeToFile:kABAddressBookCachePath(key, CTAddressBookRecordIDCacheFile) atomically:YES];
        
        // 6. timestamp
        NSTimeInterval timestamp = [[NSDate date] timeIntervalSince1970];
        filePath = kABAddressBookCachePath(key,CTAddressBookCacheFileTimestamp);
        success &= [[NSString stringWithFormat:@"%lf", timestamp] writeToFile:filePath
                                                                  atomically:YES encoding:NSUTF8StringEncoding error:nil];
        break;
        
    } while (0);
    
    if (contactRef) {
        CFRelease(contactRef);
    }
    if (contactMutalRef) {
        CFRelease(contactMutalRef);
    }
    
    return success;
}

- (NSArray*)getABRecordIds:(CFArrayRef)contactRef
{
    if (!contactRef) {
        return nil;
    }
    
    NSMutableArray* recordIDArr = [NSMutableArray new];
    CFIndex count = CFArrayGetCount(contactRef);
    for (int i = 0; i < count; i++) {
        ABRecordRef record = CFArrayGetValueAtIndex(contactRef, i);
        if (record == NULL) {
            continue;
        }
        
        ABRecordID rid = ABRecordGetRecordID(record);
        [recordIDArr addObject:[NSNumber numberWithInt:rid]];
    }
    
    return recordIDArr;
}

- (BOOL)localBackupABGroupFromAddressBook:(ABAddressBookRef)addrBookRef
{
    if (!addrBookRef) {
        return NO;
    }
    
    // 备份本地通讯录
    BOOL success = YES;
    CFArrayRef groupRef = ABAddressBookCopyArrayOfAllGroups(addrBookRef);
    do {
        if (!groupRef) {
            break;
        }
        
        CFIndex count = ABAddressBookGetGroupCount(addrBookRef);
        NSMutableArray* groups = [NSMutableArray new];
        for (int i = 0; i < count; i++) {
            ABRecordRef record = CFArrayGetValueAtIndex(groupRef, i);
            if (record == NULL) {
                continue;
            }
            
            ABRecordType recordtype = ABRecordGetRecordType(record);
            if (recordtype == kABGroupType) {
                GroupObj* obj = [ABAddressBookReader convertABRecord2GroupObj:record];
                if (obj) {
                    // 1. GroupObj-->json serialization
                    [groups addObject:[obj jsonString]];
                    if (obj.memberIds.count) {
                    }
                }
            }
        }
        CFRelease(groupRef);
        
        if (!groups.count) {
            break;
        }
        
        // 2. NSArray-->json serialization
        NSData* jsonData = [NSJSONSerialization dataWithJSONObject:groups options:0 error:nil];
        if (!jsonData.length) {
            success = NO;
            break;
        }
        
        // 3. encrypt-AES
        NSString* key = @"10000";
        NSDictionary* loginInfoDict = [Global sharedInstance].loginInfoDict;
        NSString* PhoneNumber = loginInfoDict[@"UserLoginName"];
        if (PhoneNumber.length) {
            key = [Utils MD5:PhoneNumber];
        }
        
        NSMutableData* encrypData = [[NSMutableData dataWithData:jsonData] EncryptAES:key];
        if (!encrypData.length) {
            success = NO;
            break;
        }
        
        // 4. save
        NSString* filePath = kABAddressBookCachePath(key,CTAddressBookGroupCacheFile);
        success = [encrypData writeToFile:filePath atomically:YES];
        break;
        
    } while (0);
    
    return success;
}

- (void)rollbackLocalAddressBook:(ABAddressBookRef)addrBookRef
                 progressChanged:(void(^)(double progress))progressChanged
                     initPercent:(double)initPercent        // 初始占比
                    totalPercent:(double)totalPercent       // 总占比
                      completion:(void(^)(BOOL success, int totalCnt, NSTimeInterval backupTimestamp))completion
{
    @autoreleasepool {
        // 回滚本地备份的通讯录
        BOOL success = NO;
        NSMutableArray* rollArr = [NSMutableArray new];
        int ret = [self rollbackABPerson2AddressBook:addrBookRef
                                     progressChanged:progressChanged
                                         initPercent:initPercent
                                        totalPercent:totalPercent
                                          rollRecord:rollArr];
        
        success = ((ret < 0 ? NO : YES) &[self rollbackABGroup2AddressBook:addrBookRef rollRecord:rollArr]);
        
        NSString* key = @"10000";
        NSDictionary* loginInfoDict = [Global sharedInstance].loginInfoDict;
        NSString* PhoneNumber = loginInfoDict[@"UserLoginName"];
        if (PhoneNumber.length) {
            key = [Utils MD5:PhoneNumber];
        }
        
        NSTimeInterval timestamp = 0;
        NSString* filePath = kABAddressBookCachePath(key,CTAddressBookCacheFileTimestamp);
        NSString* timestampString = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil];
        if (timestampString.length) {
            timestamp = [timestampString doubleValue];
        }
        
        if (completion) {
            completion(success, ret, timestamp);
        }
    }
}

- (int)rollbackABPerson2AddressBook:(ABAddressBookRef)addrBookRef
                    progressChanged:(void(^)(double progress))progressChanged
                        initPercent:(double)initPercent        // 初始占比
                       totalPercent:(double)totalPercent       // 总占比
                         rollRecord:(NSMutableArray* )rollRecord
{
    int ret = 0;
    if (!addrBookRef) {
        return ret;
    }
    
    do {
        double percent = initPercent;
        // 1. read
        NSString* key = @"10000";
        NSDictionary* loginInfoDict = [Global sharedInstance].loginInfoDict;
        NSString* PhoneNumber = loginInfoDict[@"UserLoginName"];
        if (PhoneNumber.length) {
            key = [Utils MD5:PhoneNumber];
        }
        
        NSString* filePath = kABAddressBookCachePath(key,CTAddressBookContactCacheFile);
        NSMutableData* encrypData = [NSMutableData dataWithContentsOfFile:filePath];
        //if (!encrypData.length) {
        if (!encrypData) {  // 允许保存空数据
            break;
        }
        
        ret = -1;   // 失败标志
        // 2. decrypt-AES
        NSMutableData* decryptData = [encrypData DecryptAES:key andForData:encrypData];
        //if (!decryptData.length) {
        if (!decryptData) { // 允许保存空数据
            break;
        }
        
        // 3. vCard
        CFDataRef contactVcard = CFBridgingRetain(decryptData);
        if (!contactVcard) {
            break;
        }
        
        // 4. ABPerson，占比：0.1
        CFArrayRef contactRef = ABPersonCreatePeopleInSourceWithVCardRepresentation(NULL,contactVcard);
        if (!contactRef) {
            if (!decryptData.length) {  // 空数据
                ret = 0;
            }
            CFRelease(contactVcard);
            break;
        }
        percent += 0.1;
        if (progressChanged) {
            progressChanged(percent);
        }
        
        // 5. sort by first name
        CFMutableArrayRef contactMutalRef = CFArrayCreateMutableCopy(kCFAllocatorDefault, CFArrayGetCount(contactRef), contactRef);
        if (!contactMutalRef) {
            CFRelease(contactVcard);
            break;
        }
        CFArraySortValues(contactMutalRef,
                          CFRangeMake(0, CFArrayGetCount(contactMutalRef)),
                          (CFComparatorFunction)ABPersonComparePeopleByName,
                          kABPersonSortByFirstName);
        
        // 6. save
        CFIndex count = CFArrayGetCount(contactMutalRef);
        double avgper = count?(totalPercent-percent)/count:0;
        BOOL success = NO;
        
        for (CFIndex index = 0; index < count; index++) {
            ABRecordRef person = CFArrayGetValueAtIndex(contactMutalRef, index);
            success = ABAddressBookAddRecord(addrBookRef, person, NULL);
            
            RollbackABPerson* roll = [RollbackABPerson new];
            roll.recordRef = CFRetain(person);
            roll.recordIdInRollCacheFile = ABRecordGetRecordID(person);
            [rollRecord addObject:roll];
            
            if (index % 100 == 0 ||
                index == count - 1) {
                success &= ABAddressBookSave(addrBookRef, NULL);
            }
            
            if (!success) {
                break;
            }
            
            percent += avgper;
            if (progressChanged) {
                progressChanged(percent);
            }
        }
        
        CFRelease(contactRef);
        CFRelease(contactMutalRef);
        CFRelease(contactVcard);
        ret = count;
        break;
        
    } while (0);
    
    return ret;
}

- (BOOL)rollbackABGroup2AddressBook:(ABAddressBookRef)addrBookRef
                         rollRecord:(NSMutableArray* )rollRecord
{
    if (!addrBookRef) {
        return NO;
    }
    
    BOOL success = YES;
    do {
        // 1. read
        NSString* key = @"10000";
        NSDictionary* loginInfoDict = [Global sharedInstance].loginInfoDict;
        NSString* PhoneNumber = loginInfoDict[@"UserLoginName"];
        if (PhoneNumber.length) {
            key = [Utils MD5:PhoneNumber];
        }
        
        NSString* filePath = kABAddressBookCachePath(key,CTAddressBookGroupCacheFile);
        NSMutableData* encrypData = [NSMutableData dataWithContentsOfFile:filePath];
        if (!encrypData.length) {
            break;
        }
        
        // 2. decrypt-AES
        NSMutableData* decryptData = [encrypData DecryptAES:key andForData:encrypData];
        if (!decryptData.length) {
            success = NO;
            break;
        }
        
        // 3. json serialization-->NSArray
        NSArray* groups = [NSJSONSerialization JSONObjectWithData:decryptData options:0 error:nil];
        if (![groups isKindOfClass:[NSArray class]] ||
            groups.count <= 0) {
            success = NO;
            break;
        }
        
        // 4. 读取RID
        NSArray* ridArr = nil;
        NSMutableData* encryptRIDData = [NSMutableData dataWithContentsOfFile:kABAddressBookCachePath(key,CTAddressBookRecordIDCacheFile)];
        if (encryptRIDData.length) {
            NSMutableData* decryptRIDData = [encryptRIDData DecryptAES:key andForData:encryptRIDData];
            if (decryptRIDData.length) {
                NSString* ridStr = [[NSString alloc] initWithData:decryptRIDData encoding:NSUTF8StringEncoding];
                if (ridStr.length) {
                    ridArr = [ridStr componentsSeparatedByString:@";"];
                }
            }
        }
        
        // 5. GroupObj
        for (int i = 0; i < groups.count; i++) {
            NSDictionary* dict = [NSJSONSerialization JSONObjectWithData:[groups[i] dataUsingEncoding:NSUTF8StringEncoding] options:0 error:nil];
            if (![dict isKindOfClass:[NSDictionary class]]) {
                continue;
            }
            
            GroupObj* groupobj = [[GroupObj alloc] initWithDictionary:dict];
            [self rollbackGroupObj:groupobj toAddressBook:addrBookRef rollRecord:rollRecord rIdArr:ridArr];
        }
        break;
        
    } while (0);
    
    return success;
}

- (void)rollbackGroupObj:(GroupObj *)groupObj
           toAddressBook:(ABAddressBookRef)addrBookRef
              rollRecord:(NSMutableArray* )rollRecord
                  rIdArr:(NSArray*)rIdArr
{
    if (addrBookRef == NULL || groupObj == nil) {
        return;
    }
    
    ABRecordRef newGroup = ABGroupCreate();
    if (newGroup == NULL) {
        return;
    }
    
    [ABAddressBookWriter setPropertyValue:groupObj.groupName withProperty:kABGroupNameProperty toABRecord:newGroup];
    ABAddressBookAddRecord(addrBookRef,newGroup,NULL);
    ABAddressBookSave(addrBookRef, NULL);
    
    // 查找关联联系人信息: memberIds-->rIdArr-->rollRecord
    for (NSString* memId in groupObj.memberIds) {
        [rIdArr enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            if ([obj isKindOfClass:[NSString class]]) {
                
                do {
                    if ([obj intValue] != [memId intValue]) {
                        break;
                    }
                    
                    *stop = YES;
                    if (idx >= rollRecord.count) {
                        break;
                    }
                    
                    RollbackABPerson* person = rollRecord[idx];
                    if (person.recordRef != NULL) {
                        ABGroupAddMember(newGroup, person.recordRef,NULL);
                        ABAddressBookSave(addrBookRef, NULL);
                    }
                } while (0);
                
            }
        }];
    }
    
    CFRelease(newGroup);
}

- (BOOL)localBackupCacheExist
{
    NSString* key = @"10000";
    NSDictionary* loginInfoDict = [Global sharedInstance].loginInfoDict;
    NSString* PhoneNumber = loginInfoDict[@"UserLoginName"];
    if (PhoneNumber.length) {
        key = [Utils MD5:PhoneNumber];
    }
    
    BOOL exist = NO;
    NSString* filePath = kABAddressBookCachePath(key,CTAddressBookContactCacheFile);
    NSFileManager * filemgr = [NSFileManager defaultManager];
    exist = [filemgr fileExistsAtPath:filePath];
    
    filePath = kABAddressBookCachePath(key,CTAddressBookGroupCacheFile);
    exist |= [filemgr fileExistsAtPath:filePath];
    
    return exist;
}

- (void)deleteLocalBackupCache
{
    NSString* key = @"10000";
    NSDictionary* loginInfoDict = [Global sharedInstance].loginInfoDict;
    NSString* PhoneNumber = loginInfoDict[@"UserLoginName"];
    if (PhoneNumber.length) {
        key = [Utils MD5:PhoneNumber];
    }
    
    // delete group
    NSString* filePath = kABAddressBookCachePath(key,CTAddressBookGroupCacheFile);
    NSFileManager * filemgr = [NSFileManager defaultManager];
    if ([filemgr fileExistsAtPath:filePath])
    {
        [filemgr removeItemAtPath:filePath error:nil];
    }
    
    // delete person
    filePath = kABAddressBookCachePath(key,CTAddressBookContactCacheFile);
    if ([filemgr fileExistsAtPath:filePath])
    {
        [filemgr removeItemAtPath:filePath error:nil];
    }
    
    // delete rid
    filePath = kABAddressBookCachePath(key,CTAddressBookRecordIDCacheFile);
    if ([filemgr fileExistsAtPath:filePath])
    {
        [filemgr removeItemAtPath:filePath error:nil];
    }
    
    // delete timestamp
    filePath = kABAddressBookCachePath(key,CTAddressBookCacheFileTimestamp);
    if ([filemgr fileExistsAtPath:filePath])
    {
        [filemgr removeItemAtPath:filePath error:nil];
    }
}

@end
