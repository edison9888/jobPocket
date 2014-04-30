//
//  IgCreateOrder.m
//  CTPocketV4
//
//  Created by Y W on 14-3-13.
//  Copyright (c) 2014年 广东亿迅科技有限公司. All rights reserved.
//

#import "IgCreateOrder.h"

@interface IgCreateOrder ()

@property (nonatomic, strong) CserviceOperation *cserviceOperation;

@end


@implementation IgCreateOrder

- (void)igCreateOrderWithCustId:(NSString *)CustId DeviceNo:(NSString *)DeviceNo CommodityId:(NSString *)CommodityId BuyNum:(NSUInteger)BuyNum PayVoucher:(NSString *)PayVoucher PayIntegral:(NSString *)PayIntegral finishBlock:(RequestFinishBlock)finishBlock
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:CustId forKey:@"CustId"];
    [params setObject:DeviceNo forKey:@"DeviceNo"];
    [params setObject:@"7" forKey:@"DeviceType"];
    [params setObject:@"35" forKey:@"ProvinceId"];
    [params setObject:CommodityId forKey:@"CommodityId"];
    [params setObject:[NSNumber numberWithUnsignedInt:BuyNum] forKey:@"BuyNum"];
    [params setObject:PayVoucher forKey:@"PayVoucher"];
    [params setObject:PayIntegral forKey:@"PayIntegral"];
    [params setObject:@"192.168.0.1" forKey:@"ClientIp"];
    
    self.cserviceOperation = [MyAppDelegate.cserviceEngine postXMLWithCode:@"igCreateOrder"
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
