//
//  IgRndCode.m
//  CTPocketV4
//
//  Created by Y W on 14-3-13.
//  Copyright (c) 2014年 广东亿迅科技有限公司. All rights reserved.
//

#import "IgRndCode.h"

@interface IgRndCode ()

@property (nonatomic, strong) CserviceOperation *cserviceOperation;

@end

@implementation IgRndCode

- (void)igRndCodeWithDeviceNo:(NSString *)DeviceNo finishBlock:(RequestFinishBlock)finishBlock
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:DeviceNo forKey:@"DeviceNo"];
    [params setObject:@"1" forKey:@"SmsCode"];
    
    self.cserviceOperation = [MyAppDelegate.cserviceEngine postXMLWithCode:@"igRndCode"
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
