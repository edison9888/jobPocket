//
//  IgUserInfo.m
//  CTPocketV4
//
//  Created by Y W on 14-3-13.
//  Copyright (c) 2014年 广东亿迅科技有限公司. All rights reserved.
//

#import "IgUserInfo.h"

@interface IgUserInfo ()

@property (nonatomic, strong) CserviceOperation *cserviceOperation;
@property (nonatomic, strong) NSMutableArray *requestCallBackBlocks;
//@property (nonatomic, strong) NSDictionary *responseDictionary;

@end


@implementation IgUserInfo

+ (instancetype)shareIgUserInfo
{
    static IgUserInfo *shareIgUserInfo = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shareIgUserInfo = [[IgUserInfo alloc] init];
    });
    return shareIgUserInfo;
}

- (id)init
{
    self = [super init];
    if (self) {
        self.requestCallBackBlocks = [NSMutableArray array];
        // 登录成功返回消息
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(clear)
                                                     name:@"ReloadMsg" object:nil];
        
        
    }
    return self;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)clear
{
    self.responseDictionary = nil;
    [self.cserviceOperation cancel];
    self.cserviceOperation = nil;
    [self.requestCallBackBlocks removeAllObjects];
}

- (void)igUserInfoWithDeviceNo:(NSString *)DeviceNo finishBlock:(RequestFinishBlock)finishBlock
{
    if (self.responseDictionary) {
        if (finishBlock) {
            finishBlock(self.responseDictionary, nil);
        }
        return;
    } else if (self.cserviceOperation) {
        if (finishBlock) {
            [self.requestCallBackBlocks addObject:finishBlock];
        }
        return;
    } else {
        if (finishBlock) {
            [self.requestCallBackBlocks addObject:finishBlock];
        }
    }
    
#if DEBUG
    assert(DeviceNo != nil);
#endif
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:DeviceNo forKey:@"DeviceNo"];
    [params setObject:@"7" forKey:@"DeviceType"];
    [params setObject:@"35" forKey:@"ProvinceId"];
    
    __weak typeof(self) weakSelf = self;
    self.cserviceOperation = [MyAppDelegate.cserviceEngine postXMLWithCode:@"igUserInfo"
                                                                    params:params
                                                               onSucceeded:^(NSDictionary *dict) {
                                                                   __strong typeof(weakSelf) strongSelf = weakSelf;
                                                                   strongSelf.responseDictionary = dict;
                                                                   while (strongSelf.requestCallBackBlocks.count > 0) {
                                                                       RequestFinishBlock callBackBlock = [strongSelf.requestCallBackBlocks objectAtIndex:0];
                                                                       callBackBlock(dict, nil);
                                                                       [strongSelf.requestCallBackBlocks removeObject:callBackBlock];
                                                                   }
                                                                   strongSelf.cserviceOperation = nil;
                                                               } onError:^(NSError *engineError) {
                                                                   __strong typeof(weakSelf) strongSelf = weakSelf;
                                                                   while (strongSelf.requestCallBackBlocks.count > 0) {
                                                                       RequestFinishBlock callBackBlock = [strongSelf.requestCallBackBlocks objectAtIndex:0];
                                                                       callBackBlock(nil, engineError);
                                                                       [strongSelf.requestCallBackBlocks removeObject:callBackBlock];
                                                                   }
                                                                   strongSelf.cserviceOperation = nil;
                                                               }];
}

@end
