//
//  ContactInfoParser.m
//  CTPocketV4
//
//  Created by apple on 14-3-27.
//  Copyright (c) 2014年 广东亿迅科技有限公司. All rights reserved.
//

#import "ContactInfoParser.h"
#import "GroupObj.h"
#import "PersonObj.h"

@implementation ContactInfoParser

- (void)parseDictionary:(NSDictionary* )srcdict
             completion:(void(^)(NSArray* contacts, NSArray* groups))completion
{
    @autoreleasepool {
        // 解析下载联系人信息
        NSMutableArray* groupList = [NSMutableArray new];
        NSMutableArray* contactList = [NSMutableArray new];
        if (srcdict == nil) {
            if (completion) {
                completion(nil, nil);
            }
            return;
        }
        
        // 设备最后同步的版本号
        NSString* serverVersion = @"";
        if (srcdict[@"V"] != [NSNull null] && srcdict[@"V"] != nil) {
            serverVersion = srcdict[@"V"];
        }
        
        // 分组
        {
            NSArray* groups = nil;
            if (srcdict[@"GL"] != [NSNull null] && srcdict[@"GL"] != nil) {
                NSDictionary* dict = srcdict[@"GL"];
                id g = nil;
                if (dict[@"G"] != [NSNull null] && dict[@"G"] != nil) {
                    g = dict[@"G"];
                }
                
                if ([g isKindOfClass:[NSArray class]]) {
                    groups = [NSArray arrayWithArray:g];
                } else if ([g isKindOfClass:[NSDictionary class]]) {
                    groups = [NSArray arrayWithObject:g];
                }
            }
            
            for (NSDictionary* dict in groups) {
                GroupObj* obj = [self parseGroup:dict];
                if (obj) {
                    [groupList addObject:obj];
                }
            }
        }
        
        // 联系人
        {
            NSArray* contacts = nil;
            if (srcdict[@"CL"] != [NSNull null] && srcdict[@"CL"] != nil) {
                NSDictionary* dict = srcdict[@"CL"];
                id c = nil;
                if (dict[@"C"] != [NSNull null] && dict[@"C"] != nil) {
                    c = dict[@"C"];
                }
                
                if ([c isKindOfClass:[NSArray class]]) {
                    contacts = [NSArray arrayWithArray:c];
                } else if ([c isKindOfClass:[NSDictionary class]]) {
                    contacts = [NSArray arrayWithObject:c];
                }
            }
            
            for (NSDictionary* dict in contacts) {
                PersonObj* obj = [self parseContact:dict];
                if (obj) {
                    [contactList addObject:obj];
                }
            }
        }
        
        if (completion) {
            completion(contactList, groupList);
        }
    }
}

- (GroupObj* )parseGroup:(NSDictionary* )srcdict
{
    if (!srcdict) {
        return nil;
    }
    
    GroupObj* obj = [GroupObj new];
    for (NSString* key in srcdict) {
        NSString* val = srcdict[key];
        if ([key isEqualToString:@"ID"]) {
            obj.recordId = [val intValue];
        } else if ([key isEqualToString:@"V"]) {
            obj.serverVersion = val;
        } else if ([key isEqualToString:@"N"]) {
            obj.groupName = val;
        }
    }
    
    return obj;
}

- (PersonObj* )parseContact:(NSDictionary* )srcdict
{
    if (!srcdict) {
        return nil;
    }
    
    PersonObj* obj = [PersonObj new];
    
    if (srcdict[@"ID"] != [NSNull null] && srcdict[@"ID"] != nil) {
        obj.serverId = [srcdict[@"ID"] intValue];   // 服务器端的ID
    }
    
    if (srcdict[@"V"] != [NSNull null] && srcdict[@"V"] != nil) {
        obj.serverVersion = srcdict[@"V"];
    }
    
    {
        NSArray* xmlIDs = nil;
        if (srcdict[@"GIDL"] != [NSNull null] && srcdict[@"GIDL"] != nil) {
            id GIDL = srcdict[@"GIDL"];
            if ([GIDL isKindOfClass:[NSArray class]]) {
                xmlIDs = [NSArray arrayWithArray:GIDL];
            } else if ([GIDL isKindOfClass:[NSDictionary class]]) {
                xmlIDs = [NSArray arrayWithObject:GIDL];
            }
        }
        
        NSMutableArray* groupIDs = [NSMutableArray new];
        for (NSDictionary* dict in xmlIDs) {
            id val = dict[@"ID"];
            if ([val isKindOfClass:[NSArray class]]) {
                [groupIDs addObjectsFromArray:val];
            } else {
                [groupIDs addObject:[NSNumber numberWithInt:[val intValue]]];
            }
        }
        obj.serverGroupIds = groupIDs;  // 服务器端的关联分组信息
    }
    
    {
        NSArray* attributes = nil;
        if (srcdict[@"AT"] != [NSNull null] && srcdict[@"AT"] != nil) {
            
            NSDictionary* dict = srcdict[@"AT"];
            id a = nil;
            if (dict[@"a"] != [NSNull null] && dict[@"a"]) {
                a = dict[@"a"];
            }
            
            if ([a isKindOfClass:[NSArray class]]) {
                attributes = [NSArray arrayWithArray:a];
            } else if ([a isKindOfClass:[NSDictionary class]]) {
                attributes = [NSArray arrayWithObject:a];
            }
        }
        
        for (NSDictionary* dict in attributes) {
            
            NSString* key = @"";
            NSString* val = @"";
            if (dict[@"_n"] != [NSNull null] && dict[@"_n"] != nil) {
                key = dict[@"_n"];
            }
            if (dict[@"_v"] != [NSNull null] && dict[@"_v"] != nil) {
                val = dict[@"_v"];
            }
            
            if (key.length <= 0 || val.length <= 0) {
                continue;
            }
            
            if ([key isEqualToString:@"BD"]) {
                val = [val stringByReplacingOccurrencesOfString:@"1753" withString:@"1604"];    // 将所有1753年转成1604，不显示年份
                NSDateFormatter* formatter = [NSDateFormatter new];
                [formatter setDateFormat:@"yyyy-MM-dd"];
                [formatter setTimeZone:[NSTimeZone timeZoneWithName:@"UTC"]];
                obj.birthday = [formatter dateFromString:val];
            } else if ([key isEqualToString:@"BT"]) {
                obj.bloodType = [val intValue];
            } else if ([key isEqualToString:@"BE"]) {
                obj.companyEmail = val;
            } else if ([key isEqualToString:@"CW"]) {
                obj.companyHomepage = val;
            } else if ([key isEqualToString:@"CS"]) {
                obj.constellationType = [val intValue];
            } else if ([key isEqualToString:@"EM"]) {
                obj.email = val;
            } else if ([key isEqualToString:@"CP"]) {
                obj.companyName = val;
            } else if ([key isEqualToString:@"D"]) {
                obj.department = val;
            } else if ([key isEqualToString:@"T"]) {
                obj.jobTitle = val;
            } else if ([key isEqualToString:@"FA"]) {
                obj.fax = val;
            } else if ([key isEqualToString:@"GD"]) {
                obj.gender = [val intValue];
            } else if ([key isEqualToString:@"HA"]) {
                obj.homeAddr = val;
            } else if ([key isEqualToString:@"HZ"]) {
                obj.homePostalCode = val;
            } else if ([key isEqualToString:@"HF"]) {
                obj.homeFax = val;
            } else if ([key isEqualToString:@"HPN"]) {
                obj.homeTel = val;
            } else if ([key isEqualToString:@"BD1"]) {
                obj.lunarBirthday = val;
            } else if ([key isEqualToString:@"M"]) {
                obj.mobile = val;
            } else if ([key isEqualToString:@"MSN"]) {
                obj.msn = val;
            } else if ([key isEqualToString:@"FN"]) {
                obj.name = val;
            } else if ([key isEqualToString:@"NN"]) {
                obj.nickName = val;
            } else if ([key isEqualToString:@"C"]) {
                obj.notes = val;
            } else if ([key isEqualToString:@"PW"]) {
                obj.personalHomepage = val;
            } else if ([key isEqualToString:@"QQ"]) {
                obj.qq = val;
            } else if ([key isEqualToString:@"PN"]) {
                obj.tel = val;
            } else if ([key isEqualToString:@"CA"]) {
                obj.companyAddr = val;
            } else if ([key isEqualToString:@"CZ"]) {
                obj.companyPostalCode = val;
            } else if ([key isEqualToString:@"EM1"]) {
                obj.workEmail = val;
            } else if ([key isEqualToString:@"M1"]) {
                obj.workMobile = val;
            } else if ([key isEqualToString:@"BP"]) {
                obj.workTel = val;
            } else if ([key isEqualToString:@"BF"]) {
                obj.companyFax = val;
            } else if ([key isEqualToString:@"V"]) {
                obj.vpn = val;
            } else if ([key isEqualToString:@"EP"]) {
                obj.eNumber = val;
            } else if ([key isEqualToString:@"PH"]) {
                obj.PHS = val;
            } else if ([key isEqualToString:@"EH"]) {
                obj.eLive = val;
            } else if ([key isEqualToString:@"F"]) {
                obj.favor = [val intValue];
            }
        }
    }
    
    return obj;
}

@end
