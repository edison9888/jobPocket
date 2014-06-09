//
//  FlowCardValidata.m
//  CTPocketV4
//
//  Created by apple on 13-11-3.
//  Copyright (c) 2013年 广东亿迅科技有限公司. All rights reserved.
//
#import <Foundation/Foundation.h>
#import "FlowCardValidata.h"
#import "CserviceOperation.h"
#import "CserviceEngine.h"
#import "AppDelegate.h"
#import "SIAlertView.h"
#import "SVProgressHUD.h"
@interface FlowCardValidata() 
{
    
}

@property (strong, nonatomic)CserviceOperation *flowCardValiteOpt;

@end

@implementation FlowCardValidata

+ (FlowCardValidata *) shareFlowCardValidata
{
    static FlowCardValidata *sharedFlowValidate = nil;
    static dispatch_once_t onceToken;    //只执行一次的线程
    dispatch_once(&onceToken, ^{
        sharedFlowValidate = [[FlowCardValidata alloc] init];
    });
    return sharedFlowValidate; 
}

- (void)flowValidatePhoneNumber:(NSString *)phoneNumber finish:(void(^)(NSDictionary *resultDictionary))finish
{
    self.finish = finish;
    
    if (phoneNumber == nil || ![phoneNumber isKindOfClass:[NSString class]]) {
        if (finish) {
            finish(nil);
        }
    }
    
    if (self.flowCardValiteOpt ) {
        [self.flowCardValiteOpt  cancel];
        self.flowCardValiteOpt = nil;
    }
    
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:phoneNumber, @"PhoneNumber", ESHORE_ShopId, @"ShopId", nil];
    
    
    [SVProgressHUD showWithStatus:@"请稍候..." maskType:SVProgressHUDMaskTypeGradient];
    __block FlowCardValidata *weakSelf = self ;
    self.flowCardValiteOpt = [MyAppDelegate.cserviceEngine postXMLWithCode:@"FlowValidate"
                                                                params:params
                                                           onSucceeded:^(NSDictionary *dict) {
                                                               DDLogInfo(@"%s--%@", __func__, dict.description);
//                                                               [SVProgressHUD dismiss];
                                                               weakSelf.finish(dict);
                                                               
                                                           } onError:^(NSError *engineError) {
                                                               [SVProgressHUD dismiss];
                                                               if (engineError.userInfo[@"ResultCode"])
                                                               {
                                                                   if ([engineError.userInfo[@"ResultCode"] isEqualToString:@"X104"])
                                                                   {
                                                                       // 取消掉全部请求和回调，避免出现多个弹框
                                                                       [MyAppDelegate.cserviceEngine cancelAllOperations];
                                                                       // 提示重新登录
                                                                       SIAlertView *alertView = [[SIAlertView alloc] initWithTitle:nil
                                                                                                                        andMessage:@"长时间未登录，请重新登录。"];
                                                                       [alertView addButtonWithTitle:@"确定"
                                                                                                type:SIAlertViewButtonTypeDefault
                                                                                             handler:^(SIAlertView *alertView) {
                                                                                                 [MyAppDelegate showReloginVC];
                                                                                             }];
                                                                       alertView.transitionStyle = SIAlertViewTransitionStyleBounce;
                                                                       [alertView show];
                                                                   }
                                                               }
                                                               
                                                           }];
    
}

@end
