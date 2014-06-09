//
//  RightRootVCtler.h
//  CTPocketV4
//
//  Created by Gong Xintao on 14-5-26.
//  Copyright (c) 2014年 广东亿迅科技有限公司. All rights reserved.
//window的根界面

#import "CTBaseViewController.h"
@protocol OnLeftActionDelegate<NSObject>
-(void)onLeft:(CTBaseViewController*)controller;
@end
@interface RightRootVCtler : CTBaseViewController<OnLeftActionDelegate>
-(UINavigationController*)navigationController;
-(void)removePush;
-(void)pushRightViewController:(CTBaseViewController*)viewController;
@end
