//
//  Utils.m
//  CloudCity
//
//  Created by mjlee on 11-12-12.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import "Utils.h"
#import "NSDataAdditions.h"
#import <CommonCrypto/CommonDigest.h>
#import "Global.h"

@implementation Utils

/* * * * * * * * * * * * * * * * * * * * * * * * * * * * *
 *   MD5
 * * * * * * * * * * * * * * * * * * * * * * * * * * * * */
+ (NSString *) MD5:(NSString *)str
{
    if (str == nil || [str length] <= 0) {
        return nil;
    }
    
    const char *cStr = [str UTF8String];
	unsigned char result[32];
	CC_MD5( cStr, strlen(cStr), result);
	return [NSString stringWithFormat:@"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
			result[0], result[1], result[2], result[3],
			result[4], result[5], result[6], result[7],
			result[8], result[9], result[10], result[11],
			result[12], result[13], result[14], result[15]
			];
}

+(NSString*)MD5OfNSData:(NSData*)data
{
    return [data md5Hash];
}

/* * * * * * * * * * * * * * * * * * * * * * * * * * * * *
 *   base64
 * * * * * * * * * * * * * * * * * * * * * * * * * * * * */
+(NSString*)stringBase64Encode:(NSString*)str charset:(NSStringEncoding)charset
{
    NSData* data = [str dataUsingEncoding:charset];
    return [data base64EncodedString];
}

+(NSString*)dataBase64Encode:(NSData*)data
{
    return [data base64EncodedString];
}

// 正则判断手机号码地址格式
+ (BOOL)isMobileNumber:(NSString *)mobileNum
{
    /**
     * 手机号码
     * 移动：134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
     * 联通：130,131,132,152,155,156,185,186
     * 电信：133,1349,153,180,189
     */
    NSString * MOBILE = @"^1(3[0-9]|5[0-35-9]|8[025-9])\\d{8}$";
    /**
     10         * 中国移动：China Mobile
     11         * 134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
     12         */
    NSString * CM = @"^1(34[0-8]|(3[5-9]|5[017-9]|8[278])\\d)\\d{7}$";
    /**
     15         * 中国联通：China Unicom
     16         * 130,131,132,152,155,156,185,186
     17         */
    NSString * CU = @"^1(3[0-2]|5[256]|8[56])\\d{8}$";
    /**
     20         * 中国电信：China Telecom
     21         * 133,1349,153,180,189
     22         */
    NSString * CT = @"^1(3[3]|5[3]|8[019])\\d{8}$";//@"^1((33|53|8[019])[0-9]|349)\\d{7}$";
    /**
     25         * 大陆地区固话及小灵通
     26         * 区号：010,020,021,022,023,024,025,027,028,029
     27         * 号码：七位或八位
     28         */
    // NSString * PHS = @"^0(10|2[0-5789]|\\d{3})\\d{7,8}$";
    
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM];
    NSPredicate *regextestcu = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU];
    NSPredicate *regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT];
    
    if (([regextestmobile evaluateWithObject:mobileNum] == YES)
        || ([regextestcm evaluateWithObject:mobileNum] == YES)
        || ([regextestct evaluateWithObject:mobileNum] == YES)
        || ([regextestcu evaluateWithObject:mobileNum] == YES))
    {
        return YES;
    }
    else
    {
        return NO;
    }
}

+ (BOOL)isCTMobileNumber:(NSString *)mobileNum
{
    /**
     * 手机号码
     * 移动：134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
     * 联通：130,131,132,152,155,156,185,186
     * 电信：133,1349,153,180,189
     */
    
    /**
     20         * 中国电信：China Telecom
     21         * 133,1349,153,180,189
     22         */
    NSString * CT = @"^1(3[3]|5[3]|8[019])\\d{8}$";//@"^1((33|53|8[09])[0-9]|349)\\d{7}$";
    NSPredicate *regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT];
    if ([regextestct evaluateWithObject:mobileNum] == YES)
    {
        return YES;
    }
    else
    {
        return NO;
    }
}

+(BOOL)checkNewVersion:(NSString*)curversion newver:(NSString*)newver
{
    NSString* selfversion = curversion;
    selfversion = [selfversion  stringByReplacingOccurrencesOfString:@"V" withString:@""];
    selfversion = [selfversion  stringByReplacingOccurrencesOfString:@"." withString:@""];
    NSString* newVersion  = [newver  stringByReplacingOccurrencesOfString:@"V" withString:@""];
    newVersion  = [newVersion  stringByReplacingOccurrencesOfString:@"." withString:@""];
    
    int selfval = [selfversion intValue];
    int newVval = [newVersion  intValue];
    
    if (newVval > selfval)
    {
        return YES;
    }
    return NO;
}

+(NSString*)htmlTagFilter:(NSString*)html
{
    if (html.length <= 0)
    {
        return nil;
    }
    
    // 去除html转义符
    html = [html stringByReplacingOccurrencesOfString:@"&nbsp;" withString:@""];    // space
    
    NSScanner *theScanner;
    NSString *text = nil;
    theScanner = [NSScanner scannerWithString:html];
    
    while ([theScanner isAtEnd] == NO) {
        // find start of tag
        [theScanner scanUpToString:@"<" intoString:NULL] ;
        NSInteger startLoc = [theScanner scanLocation];
        // find end of tag
        [theScanner scanUpToString:@">" intoString:&text] ;
        // replace the found tag with a space
        //(you can filter multi-spaces out later if you wish)
        
        NSInteger endloc = theScanner.scanLocation;
        if ([text hasPrefix:@"<p"])
        {
            BOOL hasFiltered = NO;
            html = [self checkPTagContainsImgTag:html scanLocation:startLoc hasFilted:&hasFiltered];
            if (hasFiltered)
            {
                theScanner = [NSScanner scannerWithString:html];
                [theScanner setScanLocation:startLoc];
                continue;
            }
            else
            {
                NSString* replacestr = @"<p class=\"content\">";
                html = [html stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@"%@>", text]
                                                       withString:replacestr];
                theScanner = [NSScanner scannerWithString:html];
                endloc -= text.length - replacestr.length;
            }
        }
        else if ([text hasPrefix:@"</p"])
        {
            continue;
        }
        else if ([text hasPrefix:@"<div"])
        {
            BOOL hasFiltered = NO;
            html = [self checkDivTagContainsImgTag:html scanLocation:startLoc hasFilted:&hasFiltered];
            if (hasFiltered)
            {
                theScanner = [NSScanner scannerWithString:html];
                [theScanner setScanLocation:startLoc];
                continue;
            }
            else
            {
                NSString* replacestr = @"<p class=\"content\">";
                html = [html stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@"%@>", text]
                                                       withString:replacestr];
                theScanner = [NSScanner scannerWithString:html];
                endloc -= text.length - replacestr.length;
            }
            
//            NSString* replacestr = @"<p class=\"content\">";
//            html = [html stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@"%@>", text]
//                                                   withString:replacestr];
//            theScanner = [NSScanner scannerWithString:html];
//            endloc -= text.length - replacestr.length;
        }
        else if ([text hasPrefix:@"</div"])
        {
            html = [html stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@"%@>", text]
                                                   withString:@"</p>"];
            theScanner = [NSScanner scannerWithString:html];
        }
        else if ([text hasPrefix:@"<img"])
        {
            NSString * url = [Utils getUrlStringFromImageTag:text];
            NSString* imgtext = [NSString stringWithFormat:@"<img src=\"%@\" style=\"max-width:270px; margin-left: 0px; margin-right:0px; text-indent: 0em; padding-top:3px;padding-bottom:3px;\"/>", url];
            html = [html stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@"%@>", text]
                                                   withString:imgtext];
            theScanner = [NSScanner scannerWithString:html];
            //相减的话，有何能负负得正，死循环。
            if (text.length > imgtext.length) {
                endloc -= text.length - imgtext.length;
            }
            
        }
        else
        {
            html = [html stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@"%@>", text]
                                                   withString:@""];
            theScanner = [NSScanner scannerWithString:html];
            endloc -= text.length;
        }
        
        if (endloc < html.length)
        {
            [theScanner setScanLocation:endloc];
        }
        else
        {
            [theScanner setScanLocation:startLoc];
        }
    }
    return html;
}

+ (NSString* )checkPTagContainsImgTag:(NSString* )html scanLocation:(NSInteger)scanLocation hasFilted:(BOOL*)hasFilted
{
    *hasFilted = NO;
    if (html.length <= 0 ||
        scanLocation > html.length ||
        hasFilted == NULL)
    {
        return html;
    }
    
    NSLog(@"scanLocation %d len %d", scanLocation, html.length);
    NSScanner *theScanner;
    NSString *text = nil;
    theScanner = [NSScanner scannerWithString:html];
    [theScanner setScanLocation:scanLocation];
    [theScanner scanUpToString:@"<p" intoString:NULL];
    [theScanner scanUpToString:@">" intoString:NULL];
    NSLog(@"theScanner.scanLocation %d", theScanner.scanLocation);
    if (![theScanner isAtEnd])
    {
        [theScanner setScanLocation:theScanner.scanLocation+1];
        [theScanner scanUpToString:@"</p>" intoString:&text];
        
        NSString* originContext = text;
        text = [text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        text = [text stringByTrimmingCharactersInSet:[NSCharacterSet controlCharacterSet]];
        text = [text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
        
        if (text.length)
        {
            if ([text rangeOfString:@"<img"].location != NSIntegerMax)  
            {
                *hasFilted = YES;
                //最初的设计为什么要+4？会导致报错的
                NSUInteger rangeLen = ([theScanner scanLocation] - scanLocation + 4);
                NSRange range =NSMakeRange(scanLocation, scanLocation+rangeLen >= html.length? rangeLen - 4 : rangeLen);
                NSString* orignText = [html substringWithRange:range];
//
//                NSString* orignText = [html substringWithRange:NSMakeRange(scanLocation, [theScanner scanLocation] - scanLocation + 4)];
                html = [html stringByReplacingOccurrencesOfString:orignText withString:text];

            }
            else
            {
                html = [html stringByReplacingOccurrencesOfString:originContext
                                                       withString:text];
            }
        }
    }

    return html;
}

+ (NSString* )checkDivTagContainsImgTag:(NSString* )html scanLocation:(NSInteger)scanLocation hasFilted:(BOOL*)hasFilted
{
    *hasFilted = NO;
    if (html.length <= 0 ||
        scanLocation > html.length ||
        hasFilted == NULL)
    {
        return html;
    }
    
    NSLog(@"scanLocation %d len %d", scanLocation, html.length);
    NSScanner *theScanner;
    NSString *text = nil;
    theScanner = [NSScanner scannerWithString:html];
    [theScanner setScanLocation:scanLocation];
    [theScanner scanUpToString:@"<div" intoString:NULL];
    [theScanner scanUpToString:@">" intoString:NULL];
    NSLog(@"theScanner.scanLocation %d", theScanner.scanLocation);
    if (![theScanner isAtEnd])
    {
        [theScanner setScanLocation:theScanner.scanLocation+1];
        [theScanner scanUpToString:@"</div>" intoString:&text];
        
        NSString* originContext = text;
        text = [text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        text = [text stringByTrimmingCharactersInSet:[NSCharacterSet controlCharacterSet]];
        text = [text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
        
        if (text.length)
        {
            if ([text rangeOfString:@"<img"].location != NSIntegerMax)
            {
                *hasFilted = YES;
                NSString* orignText = [html substringWithRange:NSMakeRange(scanLocation, [theScanner scanLocation] - scanLocation + 6)];
                html = [html stringByReplacingOccurrencesOfString:orignText
                                                       withString:text];
            }
            else
            {
                html = [html stringByReplacingOccurrencesOfString:originContext
                                                       withString:text];
            }
        }
    }
    
    return html;
}

+ (NSString* )getUrlStringFromImageTag:(NSString* )imagetag
{
    if (imagetag.length <= 0)
    {
        return @"";
    }
    
    NSString * url = @"";
    NSScanner * theScanner = [NSScanner scannerWithString:imagetag];
    // find start of IMG tag
    [theScanner scanUpToString:@"<img" intoString:nil];
    if (![theScanner isAtEnd])
    {
        [theScanner scanUpToString:@"src" intoString:nil];
        NSCharacterSet *charset = [NSCharacterSet characterSetWithCharactersInString:@"\"'"];
        [theScanner scanUpToCharactersFromSet:charset intoString:nil];
        [theScanner scanCharactersFromSet:charset intoString:nil];
        [theScanner scanUpToCharactersFromSet:charset intoString:&url];
        // "url" now contains the URL of the img
        NSLog(@"img url %@", url);
    }
    
    return url;
}

+(NSString*)getDocumentPath
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
                                                         NSUserDomainMask,
                                                         YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    
    return documentsDirectory;
}

#define kNewsReadedList     @"newsReadedList"
+ (void)setNewsReadedByNewsId:(EsNewsItem* )item
{
    if (!item || !item.newsId)
    {
        return;
    }
    
    NSString* newid = [NSString stringWithFormat:@"%@", item.newsId];
    NSData* toSaveData = [newid dataUsingEncoding:NSUTF8StringEncoding];
    
    NSString* path = [Utils getDocumentPath];
    [path lastPathComponent];
    if ([Global sharedSingleton].userVerify.user.phone)
    {
        path = [path stringByAppendingPathComponent:[NSString stringWithFormat:@"%@_%@", kNewsReadedList, [Global sharedSingleton].userVerify.user.phone]];
    }
    else
    {
        path = [path stringByAppendingPathComponent:kNewsReadedList];
    }
    
    NSFileManager * filemgr = [NSFileManager defaultManager];
    if (![filemgr fileExistsAtPath:path])
    {
        [filemgr createFileAtPath:path contents:toSaveData attributes:nil];
    }
    else
    {
        NSFileHandle * filehandler = [NSFileHandle fileHandleForWritingAtPath:path];
        [filehandler seekToEndOfFile];
        [filehandler writeData:[@"\n" dataUsingEncoding:NSUTF8StringEncoding]];
        [filehandler writeData:toSaveData];
        [filehandler closeFile];
    }
}

+ (NSArray *)loadReadedNewsList
{
    NSMutableArray* results = [NSMutableArray new];
    NSString* path = [Utils getDocumentPath];
    [path lastPathComponent];
    if ([Global sharedSingleton].userVerify.user.phone)
    {
        path = [path stringByAppendingPathComponent:[NSString stringWithFormat:@"%@_%@", kNewsReadedList, [Global sharedSingleton].userVerify.user.phone]];
    }
    else
    {
        path = [path stringByAppendingPathComponent:kNewsReadedList];
    }
    
    NSString * newsStr = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
    if ([newsStr length])
    {
        NSArray * tmparr = [newsStr componentsSeparatedByCharactersInSet:[NSCharacterSet newlineCharacterSet]];
        for (NSString * newsid in tmparr)
        {
            [results addObject:newsid];
        }
    }
    
    return results;
}

@end
