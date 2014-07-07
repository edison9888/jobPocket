//
//  CserviceEngine2.m
//  CTPocketV4
//
//  Created by lipeng on 14-6-27.
//  Copyright (c) 2014年 广东亿迅科技有限公司. All rights reserved.
//

#import "CserviceEngine2.h"
#import "GDataXMLNode.h"
#import "Utils.h"
#import "XMLDictionary.h"
#import "NSString+Des3Util.h"

@implementation CserviceEngine2

static NSDateFormatter *timestampFormatter;

- (id)initWithHostName:(NSString *)hostName {
    self = [super initWithHostName:hostName];
    if (self) {
        [self registerOperationSubclass:[CserviceOperation class]];
        
        timestampFormatter = [[NSDateFormatter alloc] init];
        [timestampFormatter setDateFormat:@"yyyyMMddhhmmss"];
    }
    return self;
}

- (CserviceOperation *)postXMLWithCode:(NSString *)code
                                params:(NSDictionary *)params
                           onSucceeded:(DictionaryBlock)succeededBlock
                               onError:(ErrorBlock)errorBlock
{
    CserviceOperation *op = (CserviceOperation *)[self operationWithPath:nil
                                                                  params:nil
                                                              httpMethod:@"POST"];
    // 将params封装为XML
    NSString *postBody = [self buildPostBodyWithCode:code params:params];
    
    // 设置网络请求的发送内容
    [op setCustomPostDataEncodingHandler:^NSString *(NSDictionary *postDataDict) {
        //加密参数
        NSString *param=[postBody encodeByDesc3];
        return param;
    } forType:@"text/plain"];
    
    // 处理网络响应
    __weak typeof(self) wself = self;
    [op addCompletionHandler:^(MKNetworkOperation *completedOperation) {
        NSDictionary *responseDictionary = [wself parseXml:completedOperation];
        succeededBlock(responseDictionary);
    } errorHandler:^(MKNetworkOperation *errorOp, NSError* error) {
        errorBlock(error);
    }];
	
    // 加入网络队列
	[self enqueueOperation:op];
    return op;

}

- (NSString *)buildPostBodyWithCode:(NSString *)code
                             params:(NSDictionary *)params
{
    NSString *postBodyStr = @"";
    
    GDataXMLElement *requestElement = [GDataXMLElement elementWithName:@"Request"];
    
    // HeaderInfos
    GDataXMLElement *headerInfosElement = [GDataXMLElement elementWithName:@"HeaderInfos"];
    // HeaderInfos中的元素
    {
        // Code
        NSString *aCode = code ? code : @"";
        [headerInfosElement addChild:[GDataXMLElement elementWithName:@"Code" stringValue:aCode]];
        
        // Source
        NSString *source = ESHORE_Source;
        [headerInfosElement addChild:[GDataXMLElement elementWithName:@"Source" stringValue:source]];
        
        // SourcePassword
        NSString * sourcePassword = ESHORE_SourcePwd;
        [headerInfosElement addChild:[GDataXMLElement elementWithName:@"SourcePassword" stringValue:sourcePassword]];
        
        // UserLoginName
        NSDictionary *loginDict = [Global sharedInstance].loginInfoDict;
        NSString *userLoginName = [loginDict objectForKey:@"UserLoginName"] ? [loginDict objectForKey:@"UserLoginName"] : @"";
        if ([userLoginName length] <= 0)
        {
            // userLoginName为空，取params里面传过来的号码
            static NSString *phonekey = @"";
            NSArray *keys = [params allKeys];
            [keys enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
                if ([obj isKindOfClass:[NSString class]] &&
                    ([obj caseInsensitiveCompare:@"PhoneNbr"] == NSOrderedSame ||
                     [obj caseInsensitiveCompare:@"PhoneNumber"] == NSOrderedSame))
                {
                    phonekey = obj;
                }
            }];
            if ([phonekey length])
            {
                userLoginName = [params objectForKey:phonekey];
            }
        }
        [headerInfosElement addChild:[GDataXMLElement elementWithName:@"UserLoginName" stringValue:userLoginName]];
        
        // ClientType
        /*
         集团_付迎鑫:  15:34:11
         还有新版的ClientType注意下，按照这个格式写。
         <ClientType>#3.0.3#channel1#HTC HTC 802d#</ClientType>
         <ClientType>#版本号#channel0#机型#</ClientType>
         
         你们固定写channel0
         */
        NSString *clientType = [NSString stringWithFormat:@"#%@#channel0#%@#",
                                [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"],
                                [Utils deviceName]];
        [headerInfosElement addChild:[GDataXMLElement elementWithName:@"ClientType" stringValue:clientType]];
        
        // Token
        NSString *token = [loginDict objectForKey:@"Token"] ? [loginDict objectForKey:@"Token"] : @"";
        [headerInfosElement addChild:[GDataXMLElement elementWithName:@"Token" stringValue:token]];
        
        // Timestamp
        [headerInfosElement addChild:[GDataXMLElement elementWithName:@"Timestamp" stringValue:[timestampFormatter stringFromDate:[NSDate date]]]];
    }
    [requestElement addChild:headerInfosElement];
    
    // HeaderInfos
    GDataXMLElement *contentElement = [GDataXMLElement elementWithName:@"Content"];
    // HeaderInfos中的元素
    {
        // Attach
        [contentElement addChild:[GDataXMLElement elementWithName:@"Attach" stringValue:@"iPhone"]];
        
        // FieldData
        GDataXMLElement *fieldDataElement = [GDataXMLElement elementWithName:@"FieldData"];
        // FieldData中的元素
        for (NSString *key in params) {
            if (![key isEqualToString:@"method"])
            {
                id val = [params objectForKey:key];
                if ([val isKindOfClass:[NSString class]] ||
                    [val isKindOfClass:[NSValue class]])
                {
                    [fieldDataElement addChild:[GDataXMLElement elementWithName:key stringValue:[NSString stringWithFormat:@"%@", val]]];
                }
                else if ([val isKindOfClass:[NSArray class]])
                {
                    GDataXMLElement *chdElement = [GDataXMLElement elementWithName:key];
                    for (id chdobj in val)
                    {
                        if ([chdobj isKindOfClass:[NSDictionary class]])
                        {
                            // 目前只支持字典格式
                            [self addDictionary:chdobj element:chdElement];
                        }
                    }
                    
                    [fieldDataElement addChild:chdElement];
                }
                else if ([val isKindOfClass:[NSDictionary class]])
                {
                    GDataXMLElement *chdElement = [GDataXMLElement elementWithName:key];
                    [self addDictionary:val element:chdElement];
                    [fieldDataElement addChild:chdElement];
                }
            }
        }
        [contentElement addChild:fieldDataElement];
    }
    [requestElement addChild:contentElement];
    
    postBodyStr = [requestElement XMLString];
    
    return postBodyStr;
}

// 递归构造XML
- (void)addDictionary:(NSDictionary *)data element:(GDataXMLElement *)pelement
{
    if (!pelement || [data count] <= 0)
	{
		return ;
	}
    
    for (NSString *chdkey in data)
	{
		id chdval = [data objectForKey:chdkey];
		if ([chdval isKindOfClass:[NSString class]] ||
			[chdval isKindOfClass:[NSValue class]])
		{
			[pelement addChild:[GDataXMLElement elementWithName:chdkey stringValue:[NSString stringWithFormat:@"%@", chdval]]];
		}
		else if ([chdval isKindOfClass:[NSDictionary class]])
		{
			GDataXMLElement *chdElement = [GDataXMLElement elementWithName:chdkey];
            [self addDictionary:chdval element:chdElement];
			[pelement addChild:chdElement];
		}
	}
}

- (id)parseXml:(MKNetworkOperation *)completedOperation
{
    if ([[completedOperation responseData] isKindOfClass:[NSData class]]) {
        if ([completedOperation responseData] == nil) { return nil; }
        
        NSString *rs=[completedOperation responseString];
        if (rs == nil) { return nil; }
        /*
         Author         :gongxt
         Description    :解密服务器返回的加密数据
         */
        NSString *decodeString=[rs decodeByDesc3];
        if (decodeString == nil) { return nil; }
        
#ifdef DEBUG
        NSError *error = nil;
        GDataXMLDocument *doc = [[GDataXMLDocument alloc] initWithXMLString:decodeString options:0 error:&error];
        if (doc != nil) { DDLogInfo(@"[response]\n%@\n", doc.rootElement.XMLString);
        }
#endif
        
        NSDictionary *responseData=[NSDictionary dictionaryWithXMLString:decodeString];
        return [responseData objectForKey:@"ResponseData"];
        
    }
    else {
        return [completedOperation responseData];
    }
}

@end
