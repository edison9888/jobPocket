//
//  CserviceOperation.m
//  CTPocketV4
//
//  Created by 许忠洲 on 13-10-29.
//  Copyright (c) 2013年 广东亿迅科技有限公司. All rights reserved.
//

#import "CserviceOperation.h"
#import "XMLDictionary.h"
#import "NSString+Des3Util.h"
#define kRequestErrorDomain @"HTTP_ERROR"
#define kBusinessErrorDomain @"BIZ_ERROR"

@interface CserviceOperation ()

@property (nonatomic, copy) NSString *resultCode;
@property (nonatomic, copy) NSString *resultDesc;
@property (nonatomic, copy) NSError *restError;

@end

@implementation CserviceOperation

- (void)operationSucceeded
{
    // even when request completes without a HTTP Status code, it might be a benign error
    
    if ([[self responseData] isKindOfClass:[NSData class]])
    {
    	if ([self responseData] != nil)
    	{
            NSString *responseString=[NSString stringWithFormat:@"%@",[self responseString]];
            //解密
            NSString *decodeString=[NSString stringWithString:[responseString decodeByDesc3]];
            NSDictionary *xmlDict = [NSDictionary dictionaryWithXMLString:decodeString];
            
            if (((xmlDict != nil) &&
                 [xmlDict[@"ResponseData"][@"ResultCode"] isEqualToString:@"0000"]) &&
                ((xmlDict != nil) &&
                 [xmlDict[@"HeaderInfos"][@"Code"] isEqualToString:@"0000"]))
            {
                [super operationSucceeded];
            }
            else
            {
                if (xmlDict == nil)
                {
                    self.restError = [[NSError alloc] initWithDomain:kBusinessErrorDomain
                                                                code:-2013
                                                            userInfo:@{NSLocalizedDescriptionKey: @"解析后XML数据为空！"}];
                    [super operationFailedWithError:self.restError];
                }
                else
                {
                    NSDictionary *errorDict = nil;
                    id ResultDesc = xmlDict[@"ResponseData"][@"ResultDesc"]?xmlDict[@"ResponseData"][@"ResultDesc"]:@"";
                    id ResultCode = xmlDict[@"ResponseData"][@"ResultCode"]?xmlDict[@"ResponseData"][@"ResultCode"]:@"";
                    
                    errorDict = @{NSLocalizedDescriptionKey:ResultDesc,
                                                @"ResultCode":ResultCode};
                    self.restError = [[NSError alloc] initWithDomain:kBusinessErrorDomain
                                                                code:[xmlDict[@"ResponseData"][@"ResultCode"] intValue]
                                                            userInfo:errorDict];
                    [super operationFailedWithError:self.restError];
                }
            }
            
    	}
    }    
}

- (void)operationFailedWithError:(NSError *)theError
{
    [super operationFailedWithError:theError];
}

@end
