//
//  IgPay.m
//  CTPocketV4
//
//  Created by Y W on 14-3-14.
//  Copyright (c) 2014年 广东亿迅科技有限公司. All rights reserved.
//

#import "IgPay.h"

@interface IgPay ()

@property (nonatomic, strong) CserviceOperation *cserviceOperation;

@end


@implementation IgPay

- (void)igPayWithOrderId:(NSString *)OrderId RndCode:(NSString *)RndCode finishBlock:(RequestFinishBlock)finishBlock
{
    
#ifdef DEBUG
    assert(OrderId != nil);
    assert(RndCode != nil);
#endif
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:OrderId forKey:@"OrderId"];
    [params setObject:RndCode forKey:@"RndCode"];
    
    self.cserviceOperation = [MyAppDelegate.cserviceEngine postXMLWithCode:@"igPay"
                                                                    params:params
                                                               onSucceeded:^(NSDictionary *dict) {
                                                                   if (finishBlock) {
                                                                       finishBlock(dict, nil);
                                                                   }
                                                               } onError:^(NSError *engineError) {
                                                                   if (finishBlock) {
                                                                       finishBlock(nil, engineError);
                                                                   }
                                                               }];
}

- (void)cancel
{
    if (self.cserviceOperation) {
        [self.cserviceOperation cancel];
        self.cserviceOperation = nil;
    }
}

@end
