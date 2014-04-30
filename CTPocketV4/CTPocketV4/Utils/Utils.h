//
//  Utils.h
//  CTPocketV4
//
//  Created by 许忠洲 on 13-10-28.
//  Copyright (c) 2013年 广东亿迅科技有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <CommonCrypto/CommonCryptor.h>
#import <CommonCrypto/CommonDigest.h>

@interface Utils : NSObject

// 获取设备型号
+ (NSString *)modelId;

// 获取设备名称
+ (NSString *)deviceName;

// 利用正则表达式验证email
+ (BOOL)isValidateEmail:(NSString *)email;

// 判断是否有效身份证号码
+(BOOL)isIDNumberValid:(NSString*)idnumber;

// 利用正则表达式验证手机号码
+ (BOOL)isMobileNumber:(NSString *)mobileNum;

// 利用正则表达式验证电信手机号码
+ (BOOL)isCTMobileNumber:(NSString *)mobileNum;

// 利用正则表达式判断是否全数字
+ (BOOL)isNumber:(NSString *)mobileNum;

+ (NSString *)getNetMessageByCode:(NSString *)code;

// 根据给定区域的宽度计算字符串显示的高度
+ (CGSize) measureFrame: (CGRect)rc text:(NSAttributedString*)text;

//  3DES
+ (NSString *)tripleDES:(NSString *)plainText encryptOrDecrypt:(CCOperation)encryptOrDecrypt key:(NSString *)key;

//  保存，读取用户名、密码
+ (void)savePhone:(NSString *)phone andPwd:(NSString *)pwd;
+ (NSString *)getPhone;
+ (NSString *)getPwd;
+ (void)clearPhoneAndPwd;

// 保存，读取首页显示模式  0为圆环，1为简介模式
+ (void)saveDisplayMode:(NSString *)mode;
+ (NSString *)getDisplayMode;

// 保存，读取首页自定义列表
+ (void)saveCustomIconList:(NSArray *)array;
+ (NSArray *)getCustomIconList;

// 获取2个日期的相差的天数
+ (NSInteger)getDayCountBetween:(NSDate *)star end:(NSDate *)end;

+ (UIImage *)imageWithView:(UIView *)view;

//  MD5加密
+ (NSString *)MD5:(NSString *)str;

+ (NSString*)getDocumentPath;
+ (NSString*)getDocumentFolderByName:(NSString *)foldername;

+ (NSString*)encodedURLParameterString:(NSString* )text;    // added by zy, 2014-02-24

//将字符转换为价格
+ (NSString *)smartNumberStringWithFloat:(float)number;     // added by yw, 2014-03-24

@end
