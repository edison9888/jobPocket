//
//  AppDelegate.h
//  CTPocketV4
//
//  Created by 许忠洲 on 13-10-25.
//  Copyright (c) 2013年 广东亿迅科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "CserviceEngine.h"
#import "BestToneEngine.h"
#import "FeedbackEngine.h"
#import "AppStoreEngine.h"
#import "CustomTabBarVCtler.h"

#define MyAppDelegate ((AppDelegate *)[UIApplication sharedApplication].delegate)

#define  CTZFBOnPaySucessed  @"CTZFBOnPaySucessed"
#define  CTZFBOnPayFailed    @"CTZFBOnPayFailed"

typedef void(^SuccessGenerationSingle)();
typedef void(^FailureGenerationSingle)();
@interface AppDelegate : UIResponder <UIApplicationDelegate, UITabBarControllerDelegate>

@property (strong, nonatomic) UIWindow *window; 

@property (strong, nonatomic) CustomTabBarVCtler *tabBarController;

@property (strong, nonatomic) CserviceEngine *cserviceEngine;
@property (strong, nonatomic) BestToneEngine *bestToneEngine;
@property (strong, nonatomic) FeedbackEngine *feedbackEngine;
@property (strong, nonatomic) AppStoreEngine *appStoreEngine;
@property (strong, nonatomic) NSDictionary *jumpInfo;
@property (strong, nonatomic) NSDictionary *jumpDict;
//用于类型5的单点跳转,因为类型5的跳转需要调用两次的jumpPage方法，所以特殊处理 create by gongxt
@property (strong, nonatomic) NSDictionary *jumpDict4Type5;
@property (strong, nonatomic) NSDictionary *notificationInfo;
@property (weak, nonatomic) UIViewController *Controller4modal;

//added by wensj 20140303 定时刷新数据
@property (strong, atomic) NSTimer *refreshTimer;

- (void)showTabBarCtler;
- (void)custIdInfo;
- (void)showReloginVC;
- (void)generationSingleWithSuccessBlock:(SuccessGenerationSingle)sucess failureBlock:(FailureGenerationSingle)failure;
//- (void)gotoSomeViewAfterLogin:(NSDictionary *)userInfo;
- (void) jumpPage : (NSDictionary *) dictionary;
@end
