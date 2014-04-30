//
//  HBZSNetworkEngine.h
//  CTPocketV4
//
//  Created by apple on 14-3-5.
//  Copyright (c) 2014年 广东亿迅科技有限公司. All rights reserved.
//

#import "MKNetworkEngine.h"
#import "HBZSNetworkOperation.h"

@interface HBZSNetworkEngine : MKNetworkEngine

- (instancetype)initWithDefaultSetting;
- (instancetype)initWithoutContentType:(NSString* )hostname;

- (HBZSNetworkOperation* )getRequestWithPath:(NSString* )path
                                  headerDict:(NSDictionary* )headerDict
                   onDownloadProgressChanged:(void(^)(double progress))downloadProgressChanged
                                 onSucceeded:(void(^)(NSData* responseData))succeededBlock
                                     onError:(ErrorBlock)errorBlock;

- (HBZSNetworkOperation* )postRequestWithData:(NSData* )reqData
                                   headerDict:(NSDictionary* )headerDict
                      onUploadProgressChanged:(void(^)(double progress))uploadProgressChanged
                                  onSucceeded:(void(^)(NSData* responseData))succeededBlock
                                      onError:(ErrorBlock)errorBlock;

@end
