//
//  ABAddressBookWriter.m
//  CTPocketV4
//
//  Created by apple on 14-3-27.
//  Copyright (c) 2014年 广东亿迅科技有限公司. All rights reserved.
//

#import "ABAddressBookWriter.h"
#import "PersonObj.h"
#import "GroupObj.h"
#import "ExternalFields.h"
@implementation ABAddressBookWriter

+ (void)setPropertyValue:(NSString*)value withProperty:(ABPropertyID)property toABRecord:(ABRecordRef)record
{
    ABAddressBookWriter* writer = [ABAddressBookWriter new];
    [writer setPropertyValue:value withProperty:property toABRecord:record];
}

- (BOOL)writeAllRecords2AB:(ABAddressBookRef)addressBook
               contactList:(NSArray* )contactList
                 groupList:(NSArray* )groupList
           progressChanged:(void(^)(double progress))progressChanged
               initPercent:(double)initPercent     // 初始占比
              totalPercent:(double)totalPercent    // 总占比
{
    @autoreleasepool {
        // 写入本地通讯录
        if (addressBook == NULL) {
            return NO;
        }
        
        BOOL success = YES;
        __block double percent = initPercent;
        double avgPer = (totalPercent)/(contactList.count + groupList.count);
        
        // 1. 写联系人
        {
            for (PersonObj* person in contactList) {
                [self addPersonObj:person toAddressBook:addressBook];
                
                if ([contactList indexOfObject:person] % 100 == 0 ||
                    [contactList indexOfObject:person] == contactList.count - 1) {
                    success = ABAddressBookSave(addressBook, NULL);
                    if (!success) {
                        break;
                    }
                }
                
                if (progressChanged) {
                    percent += avgPer;
                    progressChanged(percent);
                }
            }
            
            if (!success) {
                return NO;
            }
        }
        
        // 2. 写组
        {
            for (GroupObj* group in groupList) {
                [self addGroup:group toAddressBook:addressBook contactList:contactList];
                
                if (progressChanged) {
                    percent += avgPer;
                    progressChanged(percent);
                }
            }
        }
        
        return YES;
    }
}

- (void)addPersonObj:(PersonObj*)person toAddressBook:(ABAddressBookRef)addressBook
{
    if (!person || addressBook == NULL) {
        return;
    }
    
    ABRecordRef newPerson = ABPersonCreate();
    if (newPerson == NULL) {
        return;
    }
    
    // 姓名
    {
#if 0   // 下载时统统保存在姓字段
        /*
         Amir  17:19:44
         你把family_name 和given_name  上传的时候 合并，中间以空格分隔
         Amir  17:19:59
         因为返回的时候只返回family_name
         */
        NSString* lastName = nil;
        NSString* firstName = nil;
        NSArray* arr = [person.name componentsSeparatedByCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
        if (arr.count) {
            lastName = arr[0];
        }
        if (arr.count >= 2) {
            firstName = arr[1];
        }
        
        [self setPropertyValue:lastName withProperty:kABPersonLastNameProperty toABRecord:newPerson];
        [self setPropertyValue:firstName withProperty:kABPersonFirstNameProperty toABRecord:newPerson];
#else
        [self setPropertyValue:person.name withProperty:kABPersonLastNameProperty toABRecord:newPerson];
#endif
    }
    
    // 昵称
    [self setPropertyValue:person.nickName withProperty:kABPersonNicknameProperty toABRecord:newPerson];
    
    // 电话
    ABMultiValueRef phoneValue = [self copyPhoneValueFromPersonObj:person];
    if (phoneValue) {
        ABRecordSetValue(newPerson,kABPersonPhoneProperty,phoneValue,NULL);
        CFRelease(phoneValue);
    }
    
    // 公司名称
    [self setPropertyValue:person.companyName withProperty:kABPersonOrganizationProperty toABRecord:newPerson];
    
    // 部门
    [self setPropertyValue:person.department withProperty:kABPersonDepartmentProperty toABRecord:newPerson];
    
    // 职位
    [self setPropertyValue:person.jobTitle withProperty:kABPersonJobTitleProperty toABRecord:newPerson];
    
    // emails
    ABMultiValueRef emailValue = [self copyEmailValueFromPersonObj:person];
    if (emailValue) {
        ABRecordSetValue(newPerson,kABPersonEmailProperty,emailValue,NULL);
        CFRelease(emailValue);
    }
    
    // 地址：参照android做法，填入街道字段
    ABMutableMultiValueRef addrValue = [self copyAddressValueFromPersonObj:person];
    if (addrValue) {
        ABRecordSetValue(newPerson,kABPersonAddressProperty,addrValue,NULL);
        CFRelease(addrValue);
    }
    
    // url
    ABMutableMultiValueRef urlValue = [self copyUrlValueFromPersonObj:person];
    if (urlValue) {
        ABRecordSetValue(newPerson,kABPersonURLProperty,urlValue,NULL);
        CFRelease(urlValue);
    }
    
    // IM
    ABMutableMultiValueRef imValue = [self copyIMValueFromPersonObj:person];
    if (imValue) {
        ABRecordSetValue(newPerson,kABPersonInstantMessageProperty,imValue,NULL);
        CFRelease(imValue);
    }
    
    // birthday
    if (person.birthday) {
        CFDateRef newDtRef = CFBridgingRetain(person.birthday);
        ABRecordSetValue(newPerson, kABPersonBirthdayProperty, newDtRef, NULL);
        CFBridgingRelease(newDtRef);
    }
    
    // 备注
    [self setPropertyValue:person.notes withProperty:kABPersonNoteProperty toABRecord:newPerson];
    
    ABAddressBookAddRecord(addressBook, newPerson, NULL);
    person.recordRef = CFRetain(newPerson);
    
    CFRelease(newPerson);
}

- (void)setPropertyValue:(NSString*)value withProperty:(ABPropertyID)property toABRecord:(ABRecordRef)record
{
    if (value.length <= 0 || record == NULL) {
        return;
    }
    
    CFStringRef newValue = CFBridgingRetain(value);
    if (newValue != NULL) {
        ABRecordSetValue(record,property,newValue,NULL);
        CFRelease(newValue);
    }
}

- (void)setMultiValue:(NSString*)value withLabel:(CFStringRef)label toMultiValue:(ABMultiValueRef)multiValueRef
{
    if (value.length <= 0 || multiValueRef == NULL || label == NULL) {
        return;
    }
    
    CFStringRef newValRef = CFBridgingRetain(value);
    if (newValRef != NULL) {
        ABMultiValueAddValueAndLabel(multiValueRef, newValRef, label, NULL);
        CFRelease(newValRef);
    }
}

- (ABMultiValueRef)copyPhoneValueFromPersonObj:(PersonObj*)person
{
    if (!person) {
        return NULL;
    }
    
    // 使用kABPersonPhoneProperty会有警告：Can't return type callbacks for 3
    ABMultiValueRef multiValRef = ABMultiValueCreateMutable(/*kABPersonPhoneProperty*/kABMultiStringPropertyType);
    if (multiValRef == NULL) {
        return NULL;
    }
    
    [self setMultiValue:person.mobile withLabel:kABPersonPhoneMobileLabel toMultiValue:multiValRef];
    [self setMultiValue:person.workMobile withLabel:kABPersonPhoneIPhoneLabel toMultiValue:multiValRef];
    [self setMultiValue:person.tel withLabel:kABHomeLabel toMultiValue:multiValRef];
    [self setMultiValue:person.workTel withLabel:kABWorkLabel toMultiValue:multiValRef];
    [self setMultiValue:person.homeTel withLabel:kABPersonPhoneMainLabel toMultiValue:multiValRef];
    [self setMultiValue:person.homeFax?person.homeFax:person.fax withLabel:kABPersonPhoneHomeFAXLabel toMultiValue:multiValRef];
    [self setMultiValue:person.companyFax withLabel:kABPersonPhoneWorkFAXLabel toMultiValue:multiValRef];
  
    CFStringRef newValRef = CFBridgingRetain(person.vpn); 
    if (newValRef != NULL) {
         CFStringRef label =CFBridgingRetain(VPNHaoMa);
        ABMultiValueAddValueAndLabel(multiValRef, newValRef, label, NULL);;
        CFRelease(newValRef);
        CFRelease(label);
    }
    
    CFStringRef phs = CFBridgingRetain(person.PHS);
    if (phs != NULL) {
        CFStringRef label =CFBridgingRetain(XiaoLingTong);
        ABMultiValueAddValueAndLabel(multiValRef,phs, label, NULL);;
        CFRelease(phs);
        CFRelease(label);
    }
    
    
    
    return multiValRef;
}

- (ABMultiValueRef)copyEmailValueFromPersonObj:(PersonObj*)person
{
    if (!person) {
        return NULL;
    }
    
    ABMultiValueRef multiValRef = ABMultiValueCreateMutable(kABPersonEmailProperty);
    if (multiValRef == NULL) {
        return NULL;
    }
    
    [self setMultiValue:person.email withLabel:kABHomeLabel toMultiValue:multiValRef];
    [self setMultiValue:person.workEmail withLabel:kABWorkLabel toMultiValue:multiValRef];
    [self setMultiValue:person.companyEmail withLabel:kABOtherLabel toMultiValue:multiValRef];
    
    CFStringRef newValRef = CFBridgingRetain(person.msn);
    if (newValRef != NULL) {
        CFStringRef label =CFBridgingRetain(OtherEmail1);
        ABMultiValueAddValueAndLabel(multiValRef, newValRef, label, NULL);;
        CFRelease(newValRef);
        CFRelease(label);
    }
    
    CFStringRef phs = CFBridgingRetain(person.eNumber);
    if (phs != NULL) {
        CFStringRef label =CFBridgingRetain(OtherEmail2);
        ABMultiValueAddValueAndLabel(multiValRef,phs, label, NULL);;
        CFRelease(phs);
        CFRelease(label);
    }
    
    
    return multiValRef;
}

- (ABMultiValueRef)copyAddressValueFromPersonObj:(PersonObj*)person
{
    if (!person) {
        return NULL;
    }
    
    ABMultiValueRef multiValRef = ABMultiValueCreateMutable(kABPersonAddressProperty);
    if (multiValRef == NULL) {
        return NULL;
    }
    
    CFMutableDictionaryRef homeAddrDictRef = CFDictionaryCreateMutable(kCFAllocatorDefault, 0, &kCFTypeDictionaryKeyCallBacks, &kCFTypeDictionaryValueCallBacks);
    if (homeAddrDictRef) {
        if (person.homePostalCode.length) {
            CFStringRef newValue = CFBridgingRetain(person.homePostalCode);
            if (newValue != NULL) {
                CFDictionarySetValue(homeAddrDictRef, kABPersonAddressZIPKey, newValue);
                CFRelease(newValue);
            }
        }
        
        // 地址：参照android做法，填入待道字段
        if (person.homeAddr.length) {
            CFStringRef newValue = CFBridgingRetain(person.homeAddr);
            if (newValue != NULL) {
                CFDictionarySetValue(homeAddrDictRef, kABPersonAddressStreetKey, newValue);
                CFRelease(newValue);
            }
        }
        
        if (CFDictionaryGetCount(homeAddrDictRef)) {
            ABMultiValueAddValueAndLabel(multiValRef, homeAddrDictRef, kABHomeLabel, NULL);
        }
        CFRelease(homeAddrDictRef);
    }
    
    CFMutableDictionaryRef compAddrDictRef = CFDictionaryCreateMutable(kCFAllocatorDefault, 0, &kCFTypeDictionaryKeyCallBacks, &kCFTypeDictionaryValueCallBacks);
    if (compAddrDictRef) {
        if (person.companyPostalCode.length) {
            CFStringRef newValue = CFBridgingRetain(person.companyPostalCode);
            if (newValue != NULL) {
                CFDictionarySetValue(compAddrDictRef, kABPersonAddressZIPKey, newValue);
                CFRelease(newValue);
            }
        }
        
        // 地址：参照android做法，填入街道字段
        if (person.companyAddr.length) {
            CFStringRef newValue = CFBridgingRetain(person.companyAddr);
            if (newValue != NULL) {
                CFDictionarySetValue(compAddrDictRef, kABPersonAddressStreetKey, newValue);
                CFRelease(newValue);
            }
        }
        
        if (CFDictionaryGetCount(compAddrDictRef)) {
            ABMultiValueAddValueAndLabel(multiValRef, compAddrDictRef, kABWorkLabel, NULL);
        }
        CFRelease(compAddrDictRef);
    }
    
    return multiValRef;
}

- (ABMultiValueRef)copyUrlValueFromPersonObj:(PersonObj*)person
{
    if (!person) {
        return NULL;
    }
    
    ABMultiValueRef multiValRef = ABMultiValueCreateMutable(kABPersonURLProperty);
    if (multiValRef == NULL) {
        return NULL;
    }
    
    [self setMultiValue:person.personalHomepage withLabel:kABPersonHomePageLabel toMultiValue:multiValRef];
    [self setMultiValue:person.companyHomepage withLabel:kABWorkLabel toMultiValue:multiValRef];
    
    return multiValRef;
}

- (ABMultiValueRef)copyIMValueFromPersonObj:(PersonObj*)person
{
    if (!person) {
        return NULL;
    }
    
    ABMultiValueRef multiValRef = ABMultiValueCreateMutable(kABPersonInstantMessageProperty);
    if (multiValRef == NULL) {
        return NULL;
    }
    
    if (person.qq.length) {
        CFMutableDictionaryRef dictRef = CFDictionaryCreateMutable(kCFAllocatorDefault, 0, &kCFTypeDictionaryKeyCallBacks, &kCFTypeDictionaryValueCallBacks);
        if (dictRef != NULL && person.qq.length > 0) {
            CFStringRef newValue = CFBridgingRetain(person.qq);
            if (newValue != NULL) {
                CFDictionarySetValue(dictRef, kABPersonInstantMessageServiceKey, kABPersonInstantMessageServiceQQ);
                CFDictionarySetValue(dictRef, kABPersonInstantMessageUsernameKey, newValue);
                ABMultiValueAddValueAndLabel(multiValRef, dictRef, kABPersonInstantMessageServiceKey, NULL);
                CFRelease(newValue);
            }
            CFRelease(dictRef);
        }
    }
    
    if (person.msn.length) {
        CFMutableDictionaryRef dictRef = CFDictionaryCreateMutable(kCFAllocatorDefault, 0, &kCFTypeDictionaryKeyCallBacks, &kCFTypeDictionaryValueCallBacks);
        if (dictRef != NULL && person.msn.length > 0) {
            CFStringRef newValue = CFBridgingRetain(person.msn);
            if (newValue != NULL) {
                CFDictionarySetValue(dictRef, kABPersonInstantMessageServiceKey, kABPersonInstantMessageServiceMSN);
                CFDictionarySetValue(dictRef, kABPersonInstantMessageUsernameKey, newValue);
                ABMultiValueAddValueAndLabel(multiValRef, dictRef, kABPersonInstantMessageServiceKey, NULL);
                CFRelease(newValue);
            }
            CFRelease(dictRef);
        }
    }
    
    
    if (person.eLive.length) {
        CFMutableDictionaryRef dictRef = CFDictionaryCreateMutable(kCFAllocatorDefault, 0, &kCFTypeDictionaryKeyCallBacks, &kCFTypeDictionaryValueCallBacks);
        if (dictRef != NULL && person.eLive.length > 0) {
            CFStringRef newValue = CFBridgingRetain(person.eLive);
            if (newValue != NULL) {
                CFStringRef label =CFBridgingRetain(TianYiLive);
                CFDictionarySetValue(dictRef, kABPersonInstantMessageServiceKey, label);
                CFDictionarySetValue(dictRef, kABPersonInstantMessageUsernameKey, newValue);
                ABMultiValueAddValueAndLabel(multiValRef, dictRef, kABPersonInstantMessageServiceKey, NULL);
                CFRelease(newValue);
                CFRelease(label);
            }
            CFRelease(dictRef);
        }
    }
    
    
    
    
    return multiValRef;
}

- (void)addGroup:(GroupObj *)groupObj toAddressBook:(ABAddressBookRef)addrBookRef contactList:(NSArray* )contactList
{
    if (addrBookRef == NULL || groupObj == nil) {
        return;
    }
    
    ABRecordRef newGroup = ABGroupCreate();
    if (newGroup == NULL) {
        return;
    }
    
    [self setPropertyValue:groupObj.groupName withProperty:kABGroupNameProperty toABRecord:newGroup];
    ABAddressBookAddRecord(addrBookRef,newGroup,NULL);
    ABAddressBookSave(addrBookRef, NULL);
    
    // 查找关联联系人信息：通过联系人中的serverGroupIds中的ID值与分组的recordId比对
    for (PersonObj* person in contactList) {
        if ([person.serverGroupIds containsObject:[NSNumber numberWithInt:groupObj.recordId]] &&
            person.recordRef) {
            ABRecordRef contactRef = person.recordRef;
            if (contactRef != NULL) {
                ABGroupAddMember(newGroup, contactRef,NULL);
                ABAddressBookSave(addrBookRef, NULL);
            }
        }
    }
    CFRelease(newGroup);
}

@end
