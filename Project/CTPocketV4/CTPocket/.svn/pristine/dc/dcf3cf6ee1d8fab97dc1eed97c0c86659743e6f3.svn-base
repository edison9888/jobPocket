//
//  NSString+Des3Util.m
//  CTPocketV4
//
//  Created by Gong Xintao on 14-3-26.
//  Copyright (c) 2014年 广东亿迅科技有限公司. All rights reserved.
//

#import "NSString+Des3Util.h"
#import "Des3UtilJ.h"
@implementation NSString (Des3Util)
#pragma mark 解密desc3密文
- (NSString*)decodeByDesc3
{
    return [Des3UtilJ doCipher:self enc:kCCDecrypt];
}
#pragma mark 用desc3加密
-(NSString*)encodeByDesc3
{
    return [Des3UtilJ doCipher:self enc:kCCEncrypt];
}
@end
