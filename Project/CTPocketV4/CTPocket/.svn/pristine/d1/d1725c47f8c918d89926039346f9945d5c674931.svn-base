//
//  ABAddressBookDeleter.m
//  CTPocketV4
//
//  Created by apple on 14-3-27.
//  Copyright (c) 2014年 广东亿迅科技有限公司. All rights reserved.
//

#import "ABAddressBookDeleter.h"

@implementation ABAddressBookDeleter

- (BOOL)deleteAddressBook:(ABAddressBookRef)addrBookRef
{
    @autoreleasepool {
        // 全量删除本地通讯录
        DDLogInfo(@"************ %s start %@ ************", __func__, [NSDate date]);
        if (addrBookRef == NULL) {
            return NO;
        }
        
        BOOL success = NO;
        CFErrorRef error = NULL;
        
        {
            CFArrayRef groups = ABAddressBookCopyArrayOfAllGroups(addrBookRef);
            if (groups == NULL) {
                return NO;
            }
            
            CFIndex count = CFArrayGetCount(groups);
            for (int i = 0; i < count; i++) {
                ABRecordRef record = CFArrayGetValueAtIndex(groups, i);
                if (record == NULL) {
                    continue;
                }
                
                success = ABAddressBookRemoveRecord(addrBookRef, record, &error);
                if (!success) {
                    DDLogInfo(@"group ABAddressBookRemoveRecord error");
                    break;
                }
            }
            CFRelease(groups);
            
            if (count && !success) {
                ABAddressBookRevert(addrBookRef);
                return NO;
            }
        }
        
        {
            CFArrayRef persons = ABAddressBookCopyArrayOfAllPeople(addrBookRef);
            if (persons == NULL) {
                return NO;
            }
            
            CFIndex count = CFArrayGetCount(persons);
            for (int i = 0; i < count; i++) {
                ABRecordRef record = CFArrayGetValueAtIndex(persons, i);
                if (record == NULL) {
                    continue;
                }
                
                success = ABAddressBookRemoveRecord(addrBookRef, record, &error);
                if (!success) {
                    DDLogInfo(@"person ABAddressBookRemoveRecord error");
                    break;
                }
            }
            
            CFRelease(persons);
            if (count && !success) {
                ABAddressBookRevert(addrBookRef);
                return NO;
            }
        }
        
        success = ABAddressBookSave(addrBookRef, &error);
        if (!success) {
            ABAddressBookRevert(addrBookRef);
            DDLogInfo(@"group ABAddressBookSave error");
            return NO;
        }
        
        DDLogInfo(@"************ %s end %@ ************", __func__, [NSDate date]);
        return YES;
    }
}

@end
