//
//  FeedbackEngine.h
//  CTPocketV4
//
//  Created by 许忠洲 on 13-10-29.
//  Copyright (c) 2013年 广东亿迅科技有限公司. All rights reserved.
//

#import "MKNetworkEngine.h"
#import "FeedbackOperation.h"

//typedef void (^DictionaryBlock)(NSDictionary *dict);
//typedef void (^ErrorBlock)(NSError *engineError);

@interface FeedbackEngine : MKNetworkEngine

- (FeedbackOperation *)postJSONWithMethod:(NSString *)method
                                   params:(NSDictionary *)params
                              onSucceeded:(DictionaryBlock)succeededBlock
                                  onError:(ErrorBlock) errorBlock;

@end
