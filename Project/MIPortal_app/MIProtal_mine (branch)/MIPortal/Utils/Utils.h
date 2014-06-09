/*********************************************************************
 * 版权所有:
 * 
 * 文件名称： Utils.h
 * 文件标识： 
 * 内容摘要： 常用功能函数的封装
 * 其它说明： 
 * 当前版本： 
 * 作   者： 
 * 完成日期： 
 
 * 修改记录1：    // 修改历史记录，包括修改日期、修改者及修改内容
 *    修改日期：
 *    版 本 号：  //或版本号
 *    修 改 人：
 *    修改内容：  //修改原因以及修改内容说明
 **********************************************************************/

#import <Foundation/Foundation.h>
#import "EsNewsItem.h"

@interface Utils : NSObject

// MD5
+(NSString*)MD5:(NSString *)str;
+(NSString*)MD5OfNSData:(NSData*)data;

// base64
// 加密
+(NSString*)stringBase64Encode:(NSString*)str charset:(NSStringEncoding)charset;
+(NSString*)dataBase64Encode:(NSData*)data;

/*检查是否是手机号码*/
+ (BOOL)isMobileNumber:(NSString *)mobileNum;
+ (BOOL)isCTMobileNumber:(NSString *)mobileNum;

+ (BOOL)checkNewVersion:(NSString*)curversion newver:(NSString*)newver;

// 过滤html标签
+ (NSString*)htmlTagFilter:(NSString*)html;

+ (void)setNewsReadedByNewsId:(EsNewsItem* )item;

+ (NSString*)getDocumentPath;
+ (NSArray *)loadReadedNewsList;

@end
