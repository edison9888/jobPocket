//
//  PersonObj.h
//  CTPocketV4
//
//  Created by apple on 14-3-10.
//  Copyright (c) 2014年 广东亿迅科技有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Contact_proto.pb.h"
#import <AddressBook/AddressBook.h>

@interface PersonObj : NSObject

/*说明： 上传时关联的分组信息保存在联系人结构中的localGroupIds数组中(分组ID为本地记录ID)，上传的联系人ID也为本地记录ID(recordId)；
        下载时关联的分组信息也是从联系人结构中的serverGroupIds数组中获取(分组ID为服务器端记录ID)，下载的联系人ID也为服务器端记录ID(serverId)
        读取时，关联信息在分组中。先读取分组信息，将关联信息存入memberIds数组中(联系人的本地记录ID)；再读取联系人联系，手动将关联的分组比对存入localGroupIds
        写入时，关联信息在联系人中。先写入联系人信息，获取到联系人本地记录ID；再写入分组信息，手动将关联的联系人信息写入分组关联字段*/
@property (nonatomic, assign) ABRecordRef recordRef;        // 记录本地联系人指针，用于下载时查找关联联系人信息：通过联系人中的serverGroupIds中的ID值与分组的recordId比对
@property (nonatomic, assign) int32_t   recordId;           // 本地记录ID，上传时将此字段做为serverId字段
@property (nonatomic, strong) NSArray*  localGroupIds;      // 所属组id，分组的本地ID，读取本地时使用,因为上传接口需要数组，所以定义NSArray
@property (nonatomic, assign) int32_t   serverId;           // 服务器记录ID，下载时用于保存服务器端记录的ID，方便与goupID关联
@property (nonatomic, strong) NSArray*  serverGroupIds;     // 所属组id，分组的服务器ID，下载服务器端时使用
@property (nonatomic, strong) NSString* serverVersion;      // 服务端版本号

@property (nonatomic, strong) NSString* name;               // 姓名
@property (nonatomic, strong) NSString* nickName;           // 昵称
@property (nonatomic, strong) NSString* mobile;             // 手机号
@property (nonatomic, strong) NSString* tel;                // 固话
@property (nonatomic, strong) NSString* fax;                // 传真
@property (nonatomic, strong) NSDate*   birthday;           // 生日
@property (nonatomic, strong) NSString* lunarBirthday;      // 农历生日，本地没有该字段
@property (nonatomic, strong) NSString* email;              // 邮箱
@property (nonatomic, strong) NSString* personalHomepage;   // 个人主页
@property (nonatomic, assign) int       gender;             // 性别，本地没有该字段，男性:1 女性:2
@property (nonatomic, assign) int       bloodType;          // 血型，本地没有该字段，/*A 型血:1 B 型血:2 AB 型血:3 O 型血:4*/
@property (nonatomic, assign) int       constellationType;  // 星座，本地没有该字段，/*牡羊座:1 金牛座:2 双子座:3 巨蟹座:4 狮子座:5 处女座:6 天秤座:7 天蝎座:8 射手座:9 魔羯座:10 水瓶座:11 双鱼座:12*/

@property (nonatomic, strong) NSString* homeTel;            // 家庭固话
@property (nonatomic, strong) NSString* homeAddr;           // 家庭地址
@property (nonatomic, strong) NSString* homePostalCode;     // 家庭邮编
@property (nonatomic, strong) NSString* homeFax;            // 家庭传真

@property (nonatomic, strong) NSString* companyName;        // 公司名称
@property (nonatomic, strong) NSString* companyAddr;        // 公司地址
@property (nonatomic, strong) NSString* companyHomepage;    // 公司主页
@property (nonatomic, strong) NSString* companyEmail;       // 公司邮箱
@property (nonatomic, strong) NSString* companyPostalCode;  // 公司邮编
@property (nonatomic, strong) NSString* companyFax;         // 公司传真
@property (nonatomic, strong) NSString* department;         // 部门
@property (nonatomic, strong) NSString* jobTitle;           // 职位
@property (nonatomic, strong) NSString* workEmail;          // 商务邮箱
@property (nonatomic, strong) NSString* workMobile;         // 商务手机
@property (nonatomic, strong) NSString* workTel;            // 商务固话

@property (nonatomic, strong) NSString* qq;                 // qq
@property (nonatomic, strong) NSString* msn;                // msn
@property (nonatomic, strong) NSString* vpn;                // vpn号码，本地没有该字段
@property (nonatomic, strong) NSString* eNumber;            // e家号码，本地没有该字段
@property (nonatomic, strong) NSString* eLive;              // elive，本地没有该字段
@property (nonatomic, strong) NSString* PHS;                // 小灵通，本地没有该字段
@property (nonatomic, strong) NSString* notes;              // 备注
@property (nonatomic, assign) int       favor;              // 是否收藏，本地没有该字段，收藏:1

- (Contact* )toContact;

@end
