//
//  AddressBookLogger.m
//  CTPocketV4
//
//  Created by apple on 14-3-27.
//  Copyright (c) 2014年 广东亿迅科技有限公司. All rights reserved.
//

#import "AddressBookLogger.h"
#import "Utils.h"
#import "ABAddressBookCache.h"

NSString* const CTAddressBookLoggerFile = @"ablog";
NSString* const CTAddressBookPlatformFile = @"platform";
NSString* const CTAddressBookLogChanged = @"AddressBookLogChanged";

@implementation AddressBookLogger

- (NSArray*)loadABLog
{
    NSMutableArray* logArr = [NSMutableArray new];
    
    NSString* key = @"10000";
    NSDictionary* loginInfoDict = [Global sharedInstance].loginInfoDict;
    NSString* PhoneNumber = loginInfoDict[@"UserLoginName"];
    if (PhoneNumber.length) {
        key = [Utils MD5:PhoneNumber];
    }
    
    NSString* filePath = kABAddressBookCachePath(key, CTAddressBookLoggerFile);
    NSString * loggerStr = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil];
    if ([loggerStr length])
    {
        NSArray* tmparr = [loggerStr componentsSeparatedByCharactersInSet:[NSCharacterSet newlineCharacterSet]];
        for (NSString* item in tmparr)
        {
            NSDictionary* dict = [NSJSONSerialization JSONObjectWithData:[item dataUsingEncoding:NSUTF8StringEncoding] options:0 error:nil];
            if ([dict isKindOfClass:[NSDictionary class]])
            {
                ABLogItem* ablog = [[ABLogItem alloc] initWithDictionary:dict];
                [logArr addObject:ablog];
            }
        }
    }
    
    return logArr;
}

- (void)saveLog:(ABLogItem*)log
{
    if (!log) {
        return;
    }
    
    NSString* jsonStr = [log jsonString];
    if (!jsonStr.length) {
        return;
    }
    NSData* toSaveData = [jsonStr dataUsingEncoding:NSUTF8StringEncoding];
    if ([toSaveData length] <= 0) return;
    
    NSString* key = @"10000";
    NSDictionary* loginInfoDict = [Global sharedInstance].loginInfoDict;
    NSString* PhoneNumber = loginInfoDict[@"UserLoginName"];
    if (PhoneNumber.length) {
        key = [Utils MD5:PhoneNumber];
    }
    
    NSString* filePath = kABAddressBookCachePath(key, CTAddressBookLoggerFile);
    NSFileManager * filemgr = [NSFileManager defaultManager];
    if (![filemgr fileExistsAtPath:filePath])
    {
        [filemgr createFileAtPath:filePath contents:toSaveData attributes:nil];
    }
    else
    {
        NSFileHandle * filehandler = [NSFileHandle fileHandleForWritingAtPath:filePath];
        [filehandler seekToEndOfFile];
        [filehandler writeData:[@"\n" dataUsingEncoding:NSUTF8StringEncoding]];
        [filehandler writeData:toSaveData];
        [filehandler closeFile];
    }
    
    // 本功能中的“上次使用终端型号”由客户端在用户使用“上传”功能时本地记录
    if (log.type == ABLogTypeUpload) {
        // 保存终端型号
        filePath = kABAddressBookCachePath(key, CTAddressBookPlatformFile);
        NSString* platstr = [Utils modelId];
        [platstr writeToFile:filePath atomically:YES encoding:NSUTF8StringEncoding error:nil];
    }
    
    [[NSNotificationCenter defaultCenter] postNotificationName:CTAddressBookLogChanged object:nil];
}

- (BOOL)checkIfSamePlatform
{
    NSString* key = @"10000";
    NSDictionary* loginInfoDict = [Global sharedInstance].loginInfoDict;
    NSString* PhoneNumber = loginInfoDict[@"UserLoginName"];
    if (PhoneNumber.length) {
        key = [Utils MD5:PhoneNumber];
    }
    
    NSString* filePath = kABAddressBookCachePath(key, CTAddressBookPlatformFile);
    NSString* lastPlatStr = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil];
    NSString* curPlatstr = [Utils modelId];
    
    return [curPlatstr isEqual:lastPlatStr];
}

@end
