//
//  FeedbackEngine.m
//  CTPocketV4
//
//  Created by 许忠洲 on 13-10-29.
//  Copyright (c) 2013年 广东亿迅科技有限公司. All rights reserved.
//

#import "FeedbackEngine.h"

@implementation FeedbackEngine

- (id)initWithHostName:(NSString *)hostName {
    self = [super initWithHostName:hostName];
    if (self) {
        [self registerOperationSubclass:[FeedbackOperation class]];
    }
    return self;
}

#pragma mark - Custom Methods

- (FeedbackOperation *)postJSONWithMethod:(NSString *)method
                                   params:(NSDictionary *)params
                              onSucceeded:(DictionaryBlock)succeededBlock
                                  onError:(ErrorBlock) errorBlock
{
    FeedbackOperation *op = (FeedbackOperation *)[self operationWithPath:[NSString stringWithFormat:@"/service/%@.php", method]
                                                                  params:params];
    
    [op addCompletionHandler:^(MKNetworkOperation *completedOperation) {
        DDLogInfo(@"[response]\n%@\n", [[NSString alloc] initWithData:[completedOperation responseData] encoding:NSUTF8StringEncoding]);
        NSMutableDictionary *responseDictionary = [completedOperation responseJSON];
        succeededBlock(responseDictionary);
    } errorHandler:^(MKNetworkOperation *errorOp, NSError* error) {
        errorBlock(error);
    }];
	
	[self enqueueOperation:op];
    return op;
}

@end
