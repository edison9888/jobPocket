//
//  ABAddressBookReader.m
//  CTPocketV4
//
//  Created by apple on 14-3-27.
//  Copyright (c) 2014年 广东亿迅科技有限公司. All rights reserved.
//

#import "ABAddressBookReader.h"
#import "PersonObj.h"
#import "ExternalFields.h"

/**
 @Author                gongxt
 @Description           用于处理相同的标签多个值时的模型
 */

@interface MultipleInfo:NSObject
@property(nonatomic,copy)NSString *value;
@property(nonatomic,copy)NSString *label;
@property(nonatomic,assign)BOOL isUsed;
@property(nonatomic,assign)int index;
@property(nonatomic,copy)NSString *labelDescription;
@end

@implementation MultipleInfo
-(NSString*)description
{
    return [NSString stringWithFormat:@"%@:%@",self.labelDescription,self.value];
}
@end
@interface MultipleAddressInfo:MultipleInfo
@property(nonatomic,copy)NSString *pcodeValue;
@property(nonatomic,copy)NSString *pcodeLabe;
@property(nonatomic,copy)NSString *pcodeDesc;
@end

@implementation MultipleAddressInfo
-(NSString*)description
{
    NSMutableString *des=[NSMutableString string];
    if (self.value==nil||self.value.length==0)
    {
        [des appendFormat:@"%@为空",self.labelDescription];
    }else
    {
        [des appendFormat:@"%@:%@",self.labelDescription,self.value];
    }
    if (self.pcodeValue==nil||self.pcodeValue.length==0)
    {
        [des appendFormat:@" %@为空",self.pcodeDesc];
    }else
    {
        [des appendFormat:@" %@:%@",self.pcodeDesc,self.pcodeValue];
    }
    return des;
}
@end

@implementation ABAddressBookReader

+ (GroupObj* )convertABRecord2GroupObj:(ABRecordRef)record
{
    ABAddressBookReader* reader = [ABAddressBookReader new];
    return [reader convertABRecord2GroupObj:record];
}

- (void)readRecordsFromAB:(ABAddressBookRef)addrBookRef
               completion:(void(^)(NSArray* contacts, NSArray* groups, BOOL success, BOOL hasPopedAlertMsg))completion
{
    @autoreleasepool {
        
        // 读取本地通讯录
        NSMutableArray* groupList = [NSMutableArray new];
        NSMutableArray* contactList = [NSMutableArray new];
        
        if (addrBookRef == NULL) {
            if (completion) {
                completion(nil, nil, NO, NO);
            }
            return;
        }
        
        {
            // 1.读取群组信息
            CFArrayRef groups = ABAddressBookCopyArrayOfAllGroups(addrBookRef);
            if (groups) {
                CFIndex count = ABAddressBookGetGroupCount(addrBookRef);
                for (int i = 0; i < count; i++) {
                    ABRecordRef record = CFArrayGetValueAtIndex(groups, i);
                    if (record == NULL) {
                        continue;
                    }
                    
                    ABRecordType recordtype = ABRecordGetRecordType(record);
                    if (recordtype == kABGroupType) {
                        GroupObj* obj = [self convertABRecord2GroupObj:record];
                        if (obj) {
                            [groupList addObject:obj];
                        }
                    }
                }
                CFRelease(groups);
            }
        }
        
        {
            // 2.读取联系人信息
            CFArrayRef contacts = ABAddressBookCopyArrayOfAllPeople(addrBookRef);
            if (contacts) {
                CFIndex count = ABAddressBookGetPersonCount(addrBookRef);
                for (int i = 0; i < count; i++) {
                    ABRecordRef record = CFArrayGetValueAtIndex(contacts, i);
                    if (record == NULL) {
                        continue;
                    }
                    
                    ABRecordType recordtype = ABRecordGetRecordType(record);
                    if (recordtype == kABPersonType) {
                        PersonObj* obj = [self convertABRecord2PersonObj:record groupList:groupList];
                        if (obj) {
                            [contactList addObject:obj];
                        }
                    }
                }
                CFRelease(contacts);
            }
        }
        
        if (completion) {
            completion(contactList, groupList, YES, NO);
        }
    }
}
-(void)prossNotes:(NSString*)value person:(PersonObj* )person
{
    if (value==nil||value.length==0)
    {
        return;
    }
  NSString *ns=[person.notes stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
  int len=ns.length;
  if (len==0||[@";" isEqualToString:ns])
  {
      ns=[NSString stringWithFormat:@"%@",value];
  }else
  {
      
      NSString *suffix=[ns substringWithRange:NSMakeRange(len-1, 1)];
      if ([@";" isEqualToString:suffix])
      {
          ns=[NSString stringWithFormat:@"%@%@",ns,value];
      }else
      {
          ns=[NSString stringWithFormat:@"%@;%@",ns,value];
      }
  }
    person.notes=ns;
}
#pragma mark - 工具method
- (PersonObj* )convertABRecord2PersonObj:(ABRecordRef)record groupList:(NSArray* )groupList
{
    if (record == NULL) {
        return nil;
    }
    
    PersonObj* obj = [PersonObj new];
    obj.recordId = ABRecordGetRecordID(record);
    
    {
        /*
         Amir  17:19:44
         你把family_name 和given_name  上传的时候 合并，中间以空格分隔
         Amir  17:19:59
         因为返回的时候只返回family_name
         */
        // 姓名
        NSString* lastName = (NSString*)CFBridgingRelease(ABRecordCopyValue(record, kABPersonLastNameProperty));
#warning todo 特殊符号及表情符号处理
        
        NSString* firstName = (NSString*)CFBridgingRelease(ABRecordCopyValue(record, kABPersonFirstNameProperty));
        NSMutableString* name = [NSMutableString new];
        if (lastName.length) {
            [name appendFormat:@"%@ ", lastName];
        }
        if (firstName) {
            [name appendString:firstName];
        }
        obj.name = name;
    }
  
    // 前缀
    NSString *prefix = (NSString*)CFBridgingRelease(ABRecordCopyValue(record, kABPersonPrefixProperty));
    if (prefix&&prefix.length>0)
    {
        [self prossNotes:[NSString stringWithFormat:@"名字前缀:%@",prefix] person:obj];
    }
    //名字拼音音标
    NSString *firstphonetic = (NSString*)CFBridgingRelease(ABRecordCopyValue(record, kABPersonFirstNamePhoneticProperty));
    if (firstphonetic&&firstphonetic.length>0)
    {
        [self prossNotes:[NSString stringWithFormat:@"名名字拼音音标:%@",firstphonetic] person:obj];
    }
    //中间名
    NSString *middleName = (NSString*)CFBridgingRelease(ABRecordCopyValue(record, kABPersonMiddleNameProperty));
    if (middleName&&middleName.length>0)
    {
        [self prossNotes:[NSString stringWithFormat:@"中间名:%@",middleName] person:obj];
    }
    //中间名拼音音标
    NSString *middlephonetic = (NSString*)CFBridgingRelease(ABRecordCopyValue(record, kABPersonMiddleNamePhoneticProperty));
    if (middlephonetic&&middlephonetic.length>0)
    {
        [self prossNotes:[NSString stringWithFormat:@"中间名拼音音标:%@",middlephonetic] person:obj];
    }
    // 姓氏拼音音标
    NSString *lastphonetic = (NSString*)CFBridgingRelease(ABRecordCopyValue(record, kABPersonLastNamePhoneticProperty));
    if (lastphonetic&&lastphonetic.length>0)
    {
        [self prossNotes:[NSString stringWithFormat:@"姓氏拼音音标:%@",lastphonetic] person:obj];
    }
    //后缀
    NSString *suffix = (NSString*)CFBridgingRelease(ABRecordCopyValue(record, kABPersonSuffixProperty));
    if (suffix&&suffix.length>0)
    {
        [self prossNotes:[NSString stringWithFormat:@"后缀:%@",suffix] person:obj];
    }
    
    
    // 电话
    ABMultiValueRef phoneValue = ABRecordCopyValue(record, kABPersonPhoneProperty);
    [self convertPhoneRecord2PersonObj:phoneValue person:obj];
    if (phoneValue) {
        CFRelease(phoneValue);
    }
    
    // 公司名称
    obj.companyName = (NSString*)CFBridgingRelease(ABRecordCopyValue(record, kABPersonOrganizationProperty));
    
    // 部门
    obj.department = (NSString*)CFBridgingRelease(ABRecordCopyValue(record, kABPersonDepartmentProperty));
    
    // 职位
    obj.jobTitle = (NSString*)CFBridgingRelease(ABRecordCopyValue(record, kABPersonJobTitleProperty));
    
    // emails
    ABMutableMultiValueRef emailValue = ABRecordCopyValue(record, kABPersonEmailProperty);
    [self convertEmailRecord2PersonObj:emailValue person:obj];
    if (emailValue) {
        CFRelease(emailValue);
    }
    
    // 地址
    ABMutableMultiValueRef addrValue = ABRecordCopyValue(record, kABPersonAddressProperty);
    [self convertAddrRecord2PersonObj:addrValue person:obj];
    if (addrValue) {
        CFRelease(addrValue);
    }
    
    // url
    ABMutableMultiValueRef urlValue = ABRecordCopyValue(record, kABPersonURLProperty);
    [self convertUrlRecord2PersonObj:urlValue person:obj];
    if (urlValue) {
        CFRelease(urlValue);
    }
    
    // IM
    ABMutableMultiValueRef imValue = ABRecordCopyValue(record, kABPersonInstantMessageProperty);
    [self convertIMRecord2PersonObj:imValue person:obj];
    if (imValue) {
        CFRelease(imValue);
    }
    
    // birthday
    obj.birthday = (NSDate*)CFBridgingRelease(ABRecordCopyValue(record, kABPersonBirthdayProperty));
    
    // 备注
    NSString *notes=(NSString*)CFBridgingRelease(ABRecordCopyValue(record, kABPersonNoteProperty));
    [self prossNotes:notes person:obj];
    
    // 记录本地关联的分组信息
    [self checkLocalGroupIds:obj groupList:groupList];
    
    return obj;
}

 #pragma mark  把相同的标签值保存起来
-(void)addInfoToArray:(NSMutableArray*)array label:(NSString*)label description:(NSString*)description
                index:(int)index value:(NSString*)value
{
    MultipleInfo *info=[[MultipleInfo alloc] init];
    info.label=label;
    info.index=index;
    info.isUsed=NO;
    info.value=value;
    info.labelDescription=description;
    [array addObject:info];
}

 #pragma mark  处理同个标签多个值
-(void)processMultiple:(NSMutableArray*)localValues properties:(NSMutableArray*)properties person:(PersonObj* )person
{
    int count=properties.count;//person还未被填充的字段
    int localCount=localValues.count;//本地读取的还未用来填充的数据
    for (int i=0;i<localCount;i++)//循环值还为空的person的字段
    {
        if (i>=count)break;
        NSString *property=[properties objectAtIndex:i];
        MultipleInfo *info=[localValues objectAtIndex:i];
        info.isUsed=YES;
        [person setValue:info.value forKey:property];
        
    }
    if (localCount> count)//表示已经把person的相对应字段填充完，还有本地读取的数据
    {
        //通过Range删除已经赋值的本地数据local_personPhones
        if (count>0)
        {
            [localValues removeObjectsInRange:NSMakeRange(0,count)];
        }
        NSArray *personPhones=[localValues sortedArrayUsingComparator:
                               ^NSComparisonResult(id obj1,id obj2)
                               {
                                   MultipleInfo *info1=(MultipleInfo *)obj1;
                                   MultipleInfo *info2=(MultipleInfo *)obj2;
                                   return [info1.labelDescription compare:info2.labelDescription];
                               }
                               ];
        NSMutableString *notes=[NSMutableString string];
        NSString *commonLabel=[personPhones[0] valueForKey:@"labelDescription"];
        int commonIndex=0;
        for (int j=0;j<personPhones.count;j++)
        {
            MultipleInfo *info=personPhones[j];
            NSString *ld=info.labelDescription;
            if ([commonLabel isEqualToString:ld]&&j!=0)//从1开始，因为0已经赋值给commonLabel
            {
                commonIndex+=1;
                info.labelDescription=[NSString stringWithFormat:@"%@%i",ld,commonIndex];
            }else
            {
                commonIndex=0;
            }
            commonLabel=[ NSString stringWithString:ld];
            [notes appendFormat:@"%@;",info];
        }
        [self prossNotes:notes person:person];
    }
}
#pragma mark - 处理标签
 #pragma mark  处理电话标签
- (void)convertPhoneRecord2PersonObj:(ABMultiValueRef)phoneValue person:(PersonObj* )person
{
    if (phoneValue == NULL ||
        person == nil) {
        return;
    }
    /**
     person.mobile,person.workMobile,person.tel,person.workTel, person.homeTel,person.homeFax,person.companyFax
     //
     */
    NSMutableArray *local_personPhones=[NSMutableArray array];
    NSMutableArray *personPhoneProterties=[NSMutableArray arrayWithObjects:
                                           @"mobile",
                                           @"workMobile",
                                           @"tel",
                                           @"workTel",
                                           @"homeTel",
                                           @"homeFax",
                                           @"companyFax",
                                           @"vpn",
                                           @"PHS", nil];
    
    CFIndex count = ABMultiValueGetCount(phoneValue);
    for (int i = 0; i < count; i++) {
        CFStringRef key = ABMultiValueCopyLabelAtIndex(phoneValue, i);
        if (key == NULL) {
            continue;
        }
        NSString *phoneLabel=(NSString*)CFBridgingRelease(ABAddressBookCopyLocalizedLabel(key));
        
        CFStringRef val = ABMultiValueCopyValueAtIndex(phoneValue, i);
        if (val == NULL) {
            CFRelease(key);
            continue;
        }
        
        /**
         移动电话——常用手机(kABPersonPhoneMobileLabel) -- (MobilePhone)
         
         iphone——商务手机(kABPersonPhoneIPhoneLabel) —— (WorkMobilePhone)
         
         住宅——常用固话(kABHomeLabel) —— (Telephone)
         
         工作——商务固话(kABWorkLabel) —— (WorkTelephone)
         
         主要——家庭固话(kABPersonPhoneMainLabel) —— (HomeTelephone)
         
         住宅传真——家庭传真(kABPersonPhoneHomeFAXLabel) —— (HomeFax)
         
         工作传真——常用传真(kABPersonPhoneWorkFAXLabel) —— (WorkFax)
         */
        if (CFEqual(key,kABPersonPhoneMobileLabel) == TRUE) {
            if (person.mobile&&person.mobile.length>0)
            {
                [self addInfoToArray:local_personPhones
                               label:@"mobile"
                         description:[phoneLabel stringByAppendingString:@"号码"]
                               index:i
                               value:(NSString*)CFBridgingRelease(val)];
            }
            else
            {
                person.mobile = (NSString*)CFBridgingRelease(val);
                [personPhoneProterties removeObject:@"mobile"];
            }
            
        } else if (CFEqual(key, kABPersonPhoneIPhoneLabel) == TRUE) {
            
            if (person.workMobile&&person.workMobile.length>0)
            {
                [self addInfoToArray:local_personPhones
                               label:@"workMobile"
                         description:[phoneLabel stringByAppendingString:@"号码"]
                               index:i
                               value:(NSString*)CFBridgingRelease(val)];
            }
            else
            {
                person.workMobile = (NSString*)CFBridgingRelease(val);
                [personPhoneProterties removeObject:@"workMobile"];
            }
            
        } else if (CFEqual(key,kABHomeLabel) == TRUE) {
            
            if (person.tel&&person.tel.length>0)
            {
                [self addInfoToArray:local_personPhones
                               label:@"tel"
                         description:[phoneLabel stringByAppendingString:@"号码"]
                               index:i
                               value:(NSString*)CFBridgingRelease(val)];
            }
            else
            {
                person.tel = (NSString*)CFBridgingRelease(val);
                [personPhoneProterties removeObject:@"tel"];
            }
            
        } else if (CFEqual(key,kABWorkLabel) == TRUE) {
            if (person.workTel&&person.workTel.length>0)
            {
                [self addInfoToArray:local_personPhones
                               label:@"workTel"
                         description:[phoneLabel stringByAppendingString:@"号码"]
                               index:i
                               value:(NSString*)CFBridgingRelease(val)];
            }
            else
            {
                person.workTel = (NSString*)CFBridgingRelease(val);
                [personPhoneProterties removeObject:@"workTel"];
            }
            
        } else if (CFEqual(key,kABPersonPhoneMainLabel) == TRUE) {
            if (person.homeTel&&person.homeTel.length>0)
            {
                [self addInfoToArray:local_personPhones
                               label:@"homeTel"
                         description:[phoneLabel stringByAppendingString:@"号码"]
                                index:i
                               value:(NSString*)CFBridgingRelease(val)];
            }
            else
            {
                person.homeTel = (NSString*)CFBridgingRelease(val);
                [personPhoneProterties removeObject:@"homeTel"];
            }
            
        } else if (CFEqual(key,kABPersonPhoneHomeFAXLabel) == TRUE) {
            if (person.homeFax&&person.homeFax.length>0)
            {
                [self addInfoToArray:local_personPhones
                               label:@"homeFax"
                         description:[phoneLabel stringByAppendingString:@"号码"]
                               index:i
                               value:(NSString*)CFBridgingRelease(val)];
            }
            else
            {
                NSString *value=(NSString*)CFBridgingRelease(val);
                person.fax=value;
                person.homeFax = value;
                [personPhoneProterties removeObject:@"homeFax"];
            }
            
        } else if (CFEqual(key,kABPersonPhoneWorkFAXLabel) == TRUE) {
            if (person.companyFax&&person.companyFax.length>0)
            {
                [self addInfoToArray:local_personPhones
                               label:@"companyFax"
                         description:[phoneLabel stringByAppendingString:@"号码"]
                               index:i
                               value:(NSString*)CFBridgingRelease(val)];
            }
            else
            {
                person.companyFax = (NSString*)CFBridgingRelease(val);
                [personPhoneProterties removeObject:@"companyFax"];
            }
        }
        else if ([VPNHaoMa isEqualToString:phoneLabel])
        {
            if (person.vpn&&person.vpn.length>0)
            {
                [self addInfoToArray:local_personPhones
                               label:@"vpn"
                         description:[phoneLabel stringByAppendingString:@"号码"]
                               index:i
                               value:(NSString*)CFBridgingRelease(val)];
            }
            else
            {
                person.vpn = (NSString*)CFBridgingRelease(val);
                [personPhoneProterties removeObject:@"vpn"];
            }
        }
        else if ([XiaoLingTong isEqualToString:phoneLabel])
        {
            if (person.PHS&&person.PHS.length>0)
            {
                [self addInfoToArray:local_personPhones
                               label:@"PHS"
                         description:[phoneLabel stringByAppendingString:@"号码"]
                               index:i
                               value:(NSString*)CFBridgingRelease(val)];
            }
            else
            {
                person.PHS = (NSString*)CFBridgingRelease(val);
                [personPhoneProterties removeObject:@"PHS"];
            }
        } else {
            [self addInfoToArray:local_personPhones
                           label:@"others"
                     description:[phoneLabel stringByAppendingString:@"号码"]
                           index:i
                           value:(NSString*)CFBridgingRelease(val)];
        }

        CFRelease(key);
    }
    
    [self processMultiple:local_personPhones properties:personPhoneProterties person:person];
    
}
#pragma mark  处理email标签
- (void)convertEmailRecord2PersonObj:(ABMultiValueRef)emailValue person:(PersonObj* )person
{
    if (emailValue == NULL ||
        person == nil) {
        return;
    }
    /**
     
     邮箱类：(kABPersonEmailProperty)
     
     住宅——常用邮箱(kABHomeLabel) —— (email)
     
     工作——商务邮箱(kABWorkLabel) —— (workEmail)
     
     其他——公司邮箱(kABOtherLabel) —— (comEmail)
     */
    NSMutableArray *local_personEmails=[NSMutableArray array];
    NSMutableArray *personEmailProterties=[NSMutableArray arrayWithObjects:
                                           @"email",
                                           @"workEmail",
                                           @"companyEmail",
                                           @"msn",
                                           @"eNumber",nil];
    //
    CFIndex count = ABMultiValueGetCount(emailValue);
    for (int i = 0; i < count; i++) {
        
        CFStringRef key = ABMultiValueCopyLabelAtIndex(emailValue, i);
        if (key == NULL) {
            continue;
        }
        NSString *emailLabel=(NSString*)CFBridgingRelease(ABAddressBookCopyLocalizedLabel(key));
        CFStringRef val = ABMultiValueCopyValueAtIndex(emailValue, i);
        if (val == NULL) {
            CFRelease(key);
            continue;
        }
        
        if (CFEqual(key,kABHomeLabel) == TRUE) {
            if (person.email&&person.email.length>0)
            {
                [self addInfoToArray:local_personEmails
                               label:@"email"
                         description:[emailLabel stringByAppendingString:@"邮箱"]
                               index:i
                               value:(NSString*)CFBridgingRelease(val)];
            }
            else
            {
                person.email = (NSString*)CFBridgingRelease(val);
                [personEmailProterties removeObject:@"email"];
            }
            
        } else if (CFEqual(key,kABWorkLabel) == TRUE) {
            if (person.workEmail&&person.workEmail.length>0)
            {
                [self addInfoToArray:local_personEmails
                               label:@"workEmail"
                         description:[emailLabel stringByAppendingString:@"邮箱"]
                               index:i
                               value:(NSString*)CFBridgingRelease(val)];
            }
            else
            {
                person.workEmail = (NSString*)CFBridgingRelease(val);
                [personEmailProterties removeObject:@"workEmail"];
            }
        } else if (CFEqual(key,kABOtherLabel) == TRUE) {
            if (person.companyEmail&&person.companyEmail.length>0)
            {
                [self addInfoToArray:local_personEmails
                               label:@"companyEmail"
                         description:[emailLabel stringByAppendingString:@"邮箱"]
                               index:i
                               value:(NSString*)CFBridgingRelease(val)];
            }
            else
            {
                person.companyEmail = (NSString*)CFBridgingRelease(val);
                [personEmailProterties removeObject:@"companyEmail"];
            }
        } else if ([emailLabel isEqualToString:OtherEmail1])
        {
            if (person.msn&&person.msn.length>0)
            {
                [self addInfoToArray:local_personEmails
                               label:@"msn"
                         description:emailLabel
                               index:i
                               value:(NSString*)CFBridgingRelease(val)];
            }
            else
            {
                person.msn = (NSString*)CFBridgingRelease(val);
                [personEmailProterties removeObject:@"msn"];
            }
        } else if ([emailLabel isEqualToString:OtherEmail2])
        {
            if (person.eNumber&&person.eNumber.length>0)
            {
                [self addInfoToArray:local_personEmails
                               label:@"eNumber"
                         description:emailLabel
                               index:i
                               value:(NSString*)CFBridgingRelease(val)];
            }
            else
            {
                person.eNumber = (NSString*)CFBridgingRelease(val);
                [personEmailProterties removeObject:@"eNumber"];
            }
        }else
        {
            [self addInfoToArray:local_personEmails
                           label:@"other"
                     description:[emailLabel stringByAppendingString:@"邮箱"]
                           index:i
                           value:(NSString*)CFBridgingRelease(val)];
        }
        CFRelease(key);
    }
    
    [self processMultiple:local_personEmails properties:personEmailProterties person:person];
}
#pragma mark  处理url标签
- (void)convertUrlRecord2PersonObj:(ABMultiValueRef)urlValue person:(PersonObj* )person
{
    if (urlValue == NULL ||
        person == nil) {
        return;
    }
    /*
     
     (kABPersonHomePageLabel) 首页 —— 个人主页 (personPage)
     
     (kABWorkLabel) 工作 －－ 公司主页 (comPage)
     **/
    
    NSMutableArray *local_personUrls=[NSMutableArray array];
    NSMutableArray *personUrlProterties=[NSMutableArray arrayWithObjects:
                                           @"personalHomepage",
                                           @"companyHomepage",  nil];
    CFIndex count = ABMultiValueGetCount(urlValue);
    for (int i = 0; i < count; i++) {
        
        CFStringRef key = ABMultiValueCopyLabelAtIndex(urlValue, i);
        if (key == NULL) {
            continue;
        }
        
        NSString *urlLabel=(NSString*)CFBridgingRelease(ABAddressBookCopyLocalizedLabel(key));
        CFStringRef val = ABMultiValueCopyValueAtIndex(urlValue, i);
        if (val == NULL) {
            CFRelease(key);
            continue;
        }
        
        if (CFEqual(key,kABPersonHomePageLabel) == TRUE) {
            
            if (person.personalHomepage&&person.personalHomepage.length>0)
            {
                [self addInfoToArray:local_personUrls
                               label:@"personalHomepage"
                         description:[urlLabel stringByAppendingString:@"主页"]
                               index:i
                               value:(NSString*)CFBridgingRelease(val)];
            }
            else
            {
                [personUrlProterties removeObject:@"personalHomepage"];
                person.personalHomepage = (NSString*)CFBridgingRelease(val);
            }
            
        } else if (CFEqual(key,kABWorkLabel) == TRUE) {
            if (person.companyHomepage&&person.companyHomepage.length>0)
            {
                [self addInfoToArray:local_personUrls
                               label:@"companyHomepage"
                         description:[urlLabel stringByAppendingString:@"主页"]
                               index:i
                               value:(NSString*)CFBridgingRelease(val)];
            }
            else
            {
                [personUrlProterties removeObject:@"companyHomepage"];
                person.companyHomepage = (NSString*)CFBridgingRelease(val);
            }
            
        } else {
            [self addInfoToArray:local_personUrls
                           label:@"other"
                     description:[urlLabel stringByAppendingString:@"主页"]
                           index:i
                           value:(NSString*)CFBridgingRelease(val)];
        }
        
        CFRelease(key);
    }
      [self processMultiple:local_personUrls properties:personUrlProterties person:person];
}

#pragma mark 对地址标签的值特殊处理
-(void)addAddressInfoToArray:(NSMutableArray*)array   description:(NSString*)description   index:(int)index
                pcodeLabel:(NSString*)pcodeLabel pcodeValue:(NSString*)pcodeValue
                 addressLabel:(NSString*)addressLabel addressValue:(NSString*)addressValue
{
    MultipleAddressInfo *info=[[MultipleAddressInfo alloc] init];
    info.index=index;
    info.isUsed=NO;
    info.labelDescription=description;
    info.label=addressLabel;
    info.value=addressValue;
    info.pcodeLabe=pcodeLabel;
    info.pcodeValue=pcodeValue;
    [array addObject:info];
}

#pragma mark 处理地址标签多个值
-(void)processAddressMultiple:(NSMutableArray*)localValues properties:(NSMutableArray*)properties person:(PersonObj* )person
{
    int count=properties.count;//person还未被填充的字段
    int localCount=localValues.count;//本地读取的还未用来填充的数据
    for (int i=0;i<localCount;i++)//循环值还为空的person的字段
    {
        if (i>=count)break;
        NSString *property=[properties objectAtIndex:i];
        NSArray *pro=[property componentsSeparatedByString:@"_"];
        //homeAddr_homePostalCode
        MultipleAddressInfo *info=[localValues objectAtIndex:i];
        info.isUsed=YES;
        
        [person setValue:info.value forKey:pro[0]];
        [person setValue:info.pcodeValue forKey:pro[1]];
        
    }
    if (localCount> count)//表示已经把person的相对应字段填充完，还有本地读取的数据
    {
        //通过Range删除已经赋值的本地数据local_personPhones
        if (count>0)
        {
            [localValues removeObjectsInRange:NSMakeRange(0,count)];
        }
        NSArray *personPhones=[localValues sortedArrayUsingComparator:
                               ^NSComparisonResult(id obj1,id obj2)
                                   {
                                       MultipleAddressInfo *info1=(MultipleAddressInfo *)obj1;
                                       MultipleAddressInfo *info2=(MultipleAddressInfo *)obj2;
                                       return [info1.labelDescription compare:info2.labelDescription];
                                   }
                               ];
        NSMutableString *notes=[NSMutableString string];
        NSString *commonLabel=@"";
        int commonIndex=0;
        for (int j=0;j<personPhones.count;j++)
        {
            MultipleAddressInfo *info=personPhones[j];
            NSString *ld=info.labelDescription;
            if (j==0)
            {
                info.labelDescription=[NSString stringWithFormat:@"%@地址",ld];
                info.pcodeDesc=[NSString stringWithFormat:@"%@邮政编码",ld];
            }
            if ([commonLabel isEqualToString:ld]&&j!=0)//从1开始，因为0已经赋值给commonLabel
            {
                commonIndex+=1;//地址:%@  %@
                info.labelDescription=[NSString stringWithFormat:@"%@地址%i",ld,commonIndex];
                info.pcodeDesc=[NSString stringWithFormat:@"%@邮政编码%i",ld,commonIndex];
            }else
            {
                info.labelDescription=[NSString stringWithFormat:@"%@地址",ld];
                info.pcodeDesc=[NSString stringWithFormat:@"%@邮政编码",ld];
                commonIndex=0;
            }
            commonLabel=[ NSString stringWithString:ld];
            [notes appendFormat:@"%@;",info];
        }
         [self prossNotes:notes person:person];
    }
}
#pragma mark  处理地址标签
- (void)convertAddrRecord2PersonObj:(ABMultiValueRef)addrValue person:(PersonObj* )person
{
    if (addrValue == NULL ||
        person == nil) {
        return;
    } 
    NSMutableArray *local_personAddress=[NSMutableArray array];
    NSMutableArray *personAddressProterties=[NSMutableArray arrayWithObjects:
                                           @"homeAddr_homePostalCode",
                                           @"companyAddr_companyPostalCode",  nil];
    
    CFIndex count = ABMultiValueGetCount(addrValue);
    for (int i = 0; i < count; i++) {
        
        CFStringRef key = ABMultiValueCopyLabelAtIndex(addrValue, i);
        if (key == NULL) {
            continue;
        }
        
        NSString *addressLabel=(NSString*)CFBridgingRelease(ABAddressBookCopyLocalizedLabel(key));
        CFDictionaryRef val = ABMultiValueCopyValueAtIndex(addrValue, i);
        if (val == NULL) {
            CFRelease(key);
            continue;
        }
        
        if (CFEqual(key,kABHomeLabel) == TRUE) {
            if (person.homeAddr&&person.homeAddr.length>0)
            {
                [self addAddressInfoToArray:local_personAddress description:addressLabel index:i
                                 pcodeLabel:@"homePostalCode"
                                 pcodeValue: (__bridge NSString*)CFDictionaryGetValue(val, kABPersonAddressZIPKey)
                               addressLabel:@"homeAddr" addressValue:[self getAddressFromDictionary:val]];

            }
            else
            {
                person.homeAddr = [self getAddressFromDictionary:val];
                person.homePostalCode = (__bridge NSString*)CFDictionaryGetValue(val, kABPersonAddressZIPKey);
                [personAddressProterties removeObject:@"homeAddr_homePostalCode"];
            }
            
            
        } else if (CFEqual(key, kABWorkLabel) == TRUE) {
            
            
            if (person.companyAddr&&person.companyAddr.length>0)
            {
                [self addAddressInfoToArray:local_personAddress description:addressLabel index:i
                                 pcodeLabel:@"companyPostalCode"
                                 pcodeValue: (__bridge NSString*)CFDictionaryGetValue(val, kABPersonAddressZIPKey)
                               addressLabel:@"companyAddr" addressValue:[self getAddressFromDictionary:val]];
                
            }
            else
            {
                person.companyAddr = [self getAddressFromDictionary:val];
                person.companyPostalCode = (__bridge NSString*)CFDictionaryGetValue(val, kABPersonAddressZIPKey);
                [personAddressProterties removeObject:@"companyAddr_companyPostalCode"];
            }
        }else {
            [self addAddressInfoToArray:local_personAddress description:addressLabel index:i
                             pcodeLabel:@"addr"
                             pcodeValue: (__bridge NSString*)CFDictionaryGetValue(val, kABPersonAddressZIPKey)
                           addressLabel:@"postalCode" addressValue:[self getAddressFromDictionary:val]];
        }
        CFRelease(key);
        CFRelease(val);
    }
    [self processAddressMultiple:local_personAddress properties:personAddressProterties person:person];
}

- (NSString* )getAddressFromDictionary:(CFDictionaryRef)addrDict
{
    if (addrDict == NULL) {
        return @"";
    }
    
    NSMutableString* addrString = [NSMutableString new];
    
    NSString* street = (__bridge NSString*)CFDictionaryGetValue(addrDict, kABPersonAddressStreetKey);
    NSString* city = (__bridge NSString*)CFDictionaryGetValue(addrDict, kABPersonAddressCityKey);
    NSString* state = (__bridge NSString*)CFDictionaryGetValue(addrDict, kABPersonAddressStateKey);
    NSString* country = (__bridge NSString*)CFDictionaryGetValue(addrDict, kABPersonAddressCountryKey);
    
    if (country.length) {
        [addrString appendFormat:@"%@", country];
    }
    
    if (state.length) {
        [addrString appendFormat:@"%@", state];
    }
    
    if (city.length) {
        [addrString appendFormat:@"%@", city];
    }
    
    if (street.length) {
        [addrString appendFormat:@"%@", street];
    }
    
    return addrString;
}

#pragma mark  处理即时通信标签
- (void)convertIMRecord2PersonObj:(ABMultiValueRef)addrValue person:(PersonObj* )person
{
    if (addrValue == NULL ||
        person == nil) {
        return;
    }
    
    CFIndex count = ABMultiValueGetCount(addrValue);
    for (int i = 0; i < count; i++) {
        
        CFDictionaryRef dict = ABMultiValueCopyValueAtIndex(addrValue, i);
        if (dict == NULL) {
            continue;
        }
        CFStringRef serviceKey = CFDictionaryGetValue(dict, kABPersonInstantMessageServiceKey);
        if (serviceKey == NULL) {
            CFRelease(dict);
            continue;
        }
        NSString *key=(__bridge NSString *)serviceKey;
        if (CFEqual(serviceKey,kABPersonInstantMessageServiceQQ) == TRUE) {
            person.qq = (__bridge NSString*)CFDictionaryGetValue(dict, kABPersonInstantMessageUsernameKey);
        } else if (CFEqual(serviceKey,kABPersonInstantMessageServiceMSN) == TRUE) {
            person.msn = (__bridge NSString*)CFDictionaryGetValue(dict, kABPersonInstantMessageUsernameKey);
        }else if ([TianYiLive isEqualToString:key])
        {
            person.eLive = (__bridge NSString*)CFDictionaryGetValue(dict, kABPersonInstantMessageUsernameKey);
        }
        
        CFRelease(dict);
    }
}

- (void)checkLocalGroupIds:(PersonObj* )person groupList:(NSArray* )groupList
{
    // 记录本地关联的分组信息
    if (!person ||
        !groupList) {
        return;
    }
    
    NSMutableArray* arr = [NSMutableArray new];
    for (GroupObj* group in groupList) {
        if ([group.memberIds containsObject:[NSNumber numberWithInt:person.recordId]]) {
            [arr addObject:[NSNumber numberWithInt:group.recordId]];
        }
    }
    person.localGroupIds = arr;
}

- (GroupObj* )convertABRecord2GroupObj:(ABRecordRef)record
{
    if (record == NULL) {
        return nil;
    }
    
    GroupObj* obj = [GroupObj new];
    obj.recordId = ABRecordGetRecordID(record);
    obj.groupName = (NSString* )CFBridgingRelease(ABRecordCopyValue(record, kABGroupNameProperty));
    
    NSMutableArray* arr = [NSMutableArray new];
    CFArrayRef members = ABGroupCopyArrayOfAllMembers(record);
    if (members != NULL) {
        CFIndex count = CFArrayGetCount(members);
        for (int i = 0; i < count; i++) {
            ABRecordRef member = CFArrayGetValueAtIndex(members, i);
            if (member) {
                [arr addObject:[NSNumber numberWithInt:ABRecordGetRecordID(member)]];
            }
        }
        
        CFRelease(members);
    }
    obj.memberIds = [NSArray arrayWithArray:arr];
    
    return obj;
}

@end
