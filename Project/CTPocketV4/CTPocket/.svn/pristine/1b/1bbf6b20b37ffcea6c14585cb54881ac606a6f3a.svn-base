//
//  AppStoreEngine.m
//  CTPocketV4
//
//  Created by 许忠洲 on 13-10-29.
//  Copyright (c) 2013年 广东亿迅科技有限公司. All rights reserved.
//

#import "AppStoreEngine.h"

@implementation AppStoreEngine

- (id)initWithHostName:(NSString *)hostName {
    self = [super initWithHostName:hostName];
    if (self) {
        [self registerOperationSubclass:[AppStoreOperation class]];
    }
    return self;
}

#pragma mark - Custom Methods

- (AppStoreOperation *)getJSONWithId:(NSString *)AppId
                         onSucceeded:(DictionaryBlock)succeededBlock
                             onError:(ErrorBlock) errorBlock
{
    AppStoreOperation *op = (AppStoreOperation *)[self operationWithPath:@"lookup"
                                                                  params:@{@"id": AppId}];
    
    [op addCompletionHandler:^(MKNetworkOperation *completedOperation) {
        NSMutableDictionary *responseDictionary = [completedOperation responseJSON];
        succeededBlock(responseDictionary);
    } errorHandler:^(MKNetworkOperation *errorOp, NSError* error) {
        errorBlock(error);
    }];
	
	[self enqueueOperation:op];
    return op;
}

@end
