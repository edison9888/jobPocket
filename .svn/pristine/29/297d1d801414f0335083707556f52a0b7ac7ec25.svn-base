//
//  IgOrderList.m
//  CTPocketV4
//
//  Created by Y W on 14-3-11.
//  Copyright (c) 2014年 广东亿迅科技有限公司. All rights reserved.
//

#import "IgOrderList.h"

@interface IgOrderList ()

@property (nonatomic, strong) CserviceOperation *cserviceOperation;

@end

@implementation IgOrderList

- (void)igOrderListWithPageIndex:(NSString *)PageIndex PageSize:(NSString *)PageSize DeviceNo:(NSString *)DeviceNo DeviceType:(NSString *)DeviceType ProvinceId:(NSString *)ProvinceId CustId:(NSString *)CustId OrderId:(NSString *)OrderId Status:(NSString *)Status DataType:(NSString *)DataType finishBlock:(RequestFinishBlock)finishBlock
{
    [self cancel];
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:PageIndex forKey:@"PageIndex"];
    [params setObject:PageSize forKey:@"PageSize"];
    [params setObject:DeviceNo forKey:@"DeviceNo"];
    [params setObject:DeviceType forKey:@"DeviceType"];
    [params setObject:ProvinceId forKey:@"ProvinceId"];
    [params setObject:CustId forKey:@"CustId"];
    if (OrderId.length > 0) {
        [params setObject:OrderId forKey:@"OrderId"];
    }
    [params setObject:Status forKey:@"Status"];
    [params setObject:DataType forKey:@"DataType"];
    
    self.cserviceOperation = [MyAppDelegate.cserviceEngine postXMLWithCode:@"igOrderList"
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
