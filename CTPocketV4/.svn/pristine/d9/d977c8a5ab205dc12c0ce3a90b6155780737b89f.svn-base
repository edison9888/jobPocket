//
//  IgInfo.m
//  CTPocketV4
//
//  Created by Y W on 14-3-13.
//  Copyright (c) 2014年 广东亿迅科技有限公司. All rights reserved.
//

#import "IgInfo.h"

@interface IgInfo ()

@property (nonatomic, strong) CserviceOperation *cserviceOperation;
@property (nonatomic, strong) NSMutableArray *requestCallBackBlocks;


@end

@implementation IgInfo

+ (instancetype)shareIgInfo
{
    static IgInfo *shareIgInfo = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shareIgInfo = [[IgInfo alloc] init];
    });
    return shareIgInfo;
}

- (id)init
{
    self = [super init];
    if (self) {
        self.requestCallBackBlocks = [NSMutableArray array];
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

- (void)igInfoWithDeviceNo:(NSString *)DeviceNo CustId:(NSString *)CustId finishBlock:(RequestFinishBlock)finishBlock
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
    assert(CustId != nil);
#endif
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:DeviceNo forKey:@"DeviceNo"];
    [params setObject:@"7" forKey:@"DeviceType"];
    [params setObject:@"35" forKey:@"ProvinceId"];
    [params setObject:@"2" forKey:@"QueryType"];
    [params setObject:CustId forKey:@"CustId"];
    
    __weak typeof(self) weakSelf = self;
    self.cserviceOperation = [MyAppDelegate.cserviceEngine postXMLWithCode:@"igInfo"
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


- (void)igInfoWithDeviceNo:(NSString *)DeviceNo CustId:(NSString *)CustId QueryType:(NSString *)QueryType finishBlock:(RequestFinishBlock)finishBlock
{
    
#if DEBUG
    assert(DeviceNo != nil);
    assert(CustId != nil);
    assert(QueryType != nil);
#endif
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:DeviceNo forKey:@"DeviceNo"];
    [params setObject:@"7" forKey:@"DeviceType"];
    [params setObject:@"35" forKey:@"ProvinceId"];
    [params setObject:QueryType forKey:@"QueryType"];
    [params setObject:CustId forKey:@"CustId"];
    
    self.cserviceOperation = [MyAppDelegate.cserviceEngine postXMLWithCode:@"igInfo"
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
