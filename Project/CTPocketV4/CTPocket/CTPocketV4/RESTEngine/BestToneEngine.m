//
//  BestToneEngine.m
//  CTPocketV4
//
//  Created by 许忠洲 on 13-10-29.
//  Copyright (c) 2013年 广东亿迅科技有限公司. All rights reserved.
//

#import "BestToneEngine.h"

@implementation BestToneEngine

- (id)initWithHostName:(NSString *)hostName {
    self = [super initWithHostName:hostName];
    if (self) {
        [self registerOperationSubclass:[BestToneOperation class]];
    }
    return self;
}

#pragma mark - Custom Methods

- (BestToneOperation *)postJSONWithParams:(NSDictionary *)params
                              onSucceeded:(DictionaryBlock)succeededBlock
                                  onError:(ErrorBlock) errorBlock
{
    BestToneOperation *op = (BestToneOperation *)[self operationWithPath:@"dataquery/query"
                                                                  params:params
                                                              httpMethod:@"POST"];
    DDLogInfo(@"poi: %@", op.url);
    DDLogInfo(@"params: %@", params);
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
