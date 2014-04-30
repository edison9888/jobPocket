//
//  PersonObj.m
//  CTPocketV4
//
//  Created by apple on 14-3-10.
//  Copyright (c) 2014年 广东亿迅科技有限公司. All rights reserved.
//

#import "PersonObj.h"

@implementation PersonObj

- (void)dealloc
{
    if (self.recordRef) {
        CFRelease(self.recordRef);
    }
}

- (NSString* )description
{
    NSMutableString* desc = [NSMutableString new];
    [desc appendFormat:@"<%@>; \r", [self class]];
    [desc appendFormat:@"recordId=%d; \r", self.recordId];
    [desc appendFormat:@"name=%@; \r", self.name];
    [desc appendFormat:@"nickName=%@; \r", self.nickName];
    [desc appendFormat:@"mobile=%@; \r", self.mobile];
    [desc appendFormat:@"tel=%@; \r", self.tel];
    [desc appendFormat:@"fax=%@; \r", self.fax];
    [desc appendFormat:@"birthday=%@; \r", self.birthday];
    [desc appendFormat:@"email=%@; \r", self.email];
    [desc appendFormat:@"personalHomepage=%@; \r", self.personalHomepage];
    [desc appendFormat:@"homeAddr=%@; \r", self.homeAddr];
    [desc appendFormat:@"homePostalCode=%@; \r", self.homePostalCode];
    [desc appendFormat:@"homeFax=%@; \r", self.homeFax];
    [desc appendFormat:@"homeTel=%@; \r", self.homeTel];
    [desc appendFormat:@"companyName=%@; \r", self.companyName];
    [desc appendFormat:@"companyAddr=%@; \r", self.companyAddr];
    [desc appendFormat:@"companyHomepage=%@; \r", self.companyHomepage];
    [desc appendFormat:@"companyEmail=%@; \r", self.companyEmail];
    [desc appendFormat:@"companyPostalCode=%@; \r", self.companyPostalCode];
    [desc appendFormat:@"companyFax=%@; \r", self.companyFax];
    [desc appendFormat:@"department=%@; \r", self.department];
    [desc appendFormat:@"jobTitle=%@; \r", self.jobTitle];
    [desc appendFormat:@"workEmail=%@; \r", self.workEmail];
    [desc appendFormat:@"workMobile=%@; \r", self.workMobile];
    [desc appendFormat:@"workTel=%@; \r", self.workTel];
    [desc appendFormat:@"qq=%@; \r", self.qq];
    [desc appendFormat:@"msn=%@; \r", self.msn];
    [desc appendFormat:@"notes=%@; \r", self.notes];
    [desc appendFormat:@"localGroupIds=%@;", self.localGroupIds];
    
    return desc;
}

- (Contact* )toContact
{
    Contact_Builder* contactBulder = [Contact builder];
    [contactBulder setServerId:self.recordId];          // 上传时将recordId字段做为serverId字段
    
    {
        Name_Builder* namebuilder = [Name builder];
        if (self.nickName) {
            [namebuilder setNickName:self.nickName];
        }
        
        if (self.name) {
            [namebuilder setFamilyName:self.name];
        }
        [contactBulder setName:[namebuilder build]];
    }
    
    {
        Phone_Builder* phoneBuilder = [Phone builder];
        
        if (self.mobile) {
            [phoneBuilder setPhoneValue:self.mobile];
            [contactBulder setMobilePhone:[phoneBuilder build]];
        }
        
        if (self.tel) {
            [phoneBuilder clear];
            [phoneBuilder setPhoneValue:self.tel];
            [contactBulder setTelephone:[phoneBuilder build]];
        }
        
        if (self.fax) {
            [phoneBuilder clear];
            [phoneBuilder setPhoneValue:self.fax];
            [contactBulder setFax:[phoneBuilder build]];
        }
        
        if (self.homeTel) {
            [phoneBuilder clear];
            [phoneBuilder setPhoneValue:self.homeTel];
            [contactBulder setHomeTelephone:[phoneBuilder build]];
        }
        
        if (self.homeFax) {
            [phoneBuilder clear];
            [phoneBuilder setPhoneValue:self.homeFax];
            [contactBulder setHomeFax:[phoneBuilder build]];
        }
        
        if (self.workMobile) {
            [phoneBuilder clear];
            [phoneBuilder setPhoneValue:self.workMobile];
            [contactBulder setWorkMobilePhone:[phoneBuilder build]];
        }
        
        if (self.workTel) {
            [phoneBuilder clear];
            [phoneBuilder setPhoneValue:self.workTel];
            [contactBulder setWorkTelephone:[phoneBuilder build]];
        }
        
        if (self.companyFax) {
            [phoneBuilder clear];
            [phoneBuilder setPhoneValue:self.companyFax];
            [contactBulder setWorkFax:[phoneBuilder build]];
        }
    }
    
    {
        Email_Builder* emailBuilder = [Email builder];
        if (self.email) {
            [emailBuilder setEmailValue:self.email];
            [contactBulder setEmail:[emailBuilder build]];
        }
        
        if (self.companyEmail) {
            [emailBuilder clear];
            [emailBuilder setEmailValue:self.companyEmail];
            [contactBulder setComEmail:[emailBuilder build]];
        }
        
        if (self.workEmail) {
            [emailBuilder clear];
            [emailBuilder setEmailValue:self.workEmail];
            [contactBulder setWorkEmail:[emailBuilder build]];
        }
    }
    
    if (self.birthday) {
        NSDateFormatter* formatter = [NSDateFormatter new];
        [formatter setDateFormat:@"yyyy-MM-dd"];
        NSString *dateString = [formatter stringFromDate:self.birthday];
        NSInteger year = [[dateString substringToIndex:4] integerValue];
        if (year < 1753) {
            // 小于1753年的全部用1753年替换，目前服务器日期字段最小值只能是1753年
            dateString = [dateString stringByReplacingCharactersInRange:NSMakeRange(0, 4) withString:@"1753"];
        }
        [contactBulder setBirthday:dateString];
    }
    
    {
        Website_Builder* urlBuilder = [Website builder];
        if (self.personalHomepage) {
            [urlBuilder setPageValue:self.personalHomepage];
            [contactBulder setPersonPage:[urlBuilder build]];
        }
        
        if (self.companyHomepage) {
            [urlBuilder clear];
            [urlBuilder setPageValue:self.companyHomepage];
            [contactBulder setComPage:[urlBuilder build]];
        }
    }
    
    {
        Address_Builder* addrBuilder = [Address builder];
        {
            if (self.homeAddr) {
                [addrBuilder setAddrValue:self.homeAddr];
            }
            if (self.homePostalCode) {
                [addrBuilder setAddrPostal:self.homePostalCode];
            }
            [contactBulder setHomeAddr:[addrBuilder build]];
        }
        
        {
            [addrBuilder clear];
            if (self.companyAddr) {
                [addrBuilder setAddrValue:self.companyAddr];
            }
            if (self.companyPostalCode) {
                [addrBuilder setAddrPostal:self.companyPostalCode];
            }
            [contactBulder setWorkAddr:[addrBuilder build]];
        }
    }
    
    {
        Employed_Builder* employedBuilder = [Employed builder];
        
        if (self.companyName) {
            [employedBuilder setEmpCompany:self.companyName];
        }
        if (self.department) {
            [employedBuilder setEmpDept:self.department];
        }
        if (self.jobTitle) {
            [employedBuilder setEmpTitle:self.jobTitle];
        }
        [contactBulder setEmployed:[employedBuilder build]];
    }
    
    {
        InstantMessage_Builder* imBuilder = [InstantMessage builder];
        if (self.qq) {
            [imBuilder setImValue:self.qq];
            [contactBulder setQq:[imBuilder build]];
        }
        
        if (self.msn) {
            [imBuilder clear];
            [imBuilder setImValue:self.msn];
            [contactBulder setMsn:[imBuilder build]];
        }
    }
    
    NSString *n=self.notes;
    if (n)
    {
        [contactBulder setComment:self.notes];
    }
    
    // 本地关联的分组ID
    if (self.localGroupIds.count) {
        [contactBulder setGroupIdArray:self.localGroupIds];
    }
    
    return [contactBulder build];
}

@end
