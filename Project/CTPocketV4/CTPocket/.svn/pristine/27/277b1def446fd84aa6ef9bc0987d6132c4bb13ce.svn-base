//
//  MineRightCVtler.h
//  CTPocketV4
//
//  Created by Gong Xintao on 14-5-26.
//  Copyright (c) 2014年 广东亿迅科技有限公司. All rights reserved.
//工厂类

#import "MMDrawerController.h"
@class CTBaseViewController;
@class CTHomeVCtler;
@protocol  ChangeRightDelegate;
@interface MineRightManager : NSObject
+(instancetype)instance;
@property(strong,nonatomic)CTHomeVCtler *homeVctler;
@property(strong,nonatomic)id<ChangeRightDelegate> changeRightDelegate;
-(CTBaseViewController*)currentController;
-(void)login;
-(void)loginOut;
-(void)showDingdang;
-(void)showScore;
-(void)showTaoCanYuE;
-(void)showOrder; 
@end
