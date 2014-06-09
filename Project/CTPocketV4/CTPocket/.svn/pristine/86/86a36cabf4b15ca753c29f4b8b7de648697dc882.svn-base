//
//  CTBaseViewController.h
//  CTPocketV4
//
//  Created by 许忠洲 on 13-10-25.
//  Copyright (c) 2013年 广东亿迅科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "SSLoadingView.h"
#import "CTNavigationController.h"  // added by zy, 2014-02-28
@protocol  OnLeftActionDelegate;
@interface CTBaseViewController : UIViewController
@property(weak,nonatomic)id<OnLeftActionDelegate> leftDelegate;
@property (strong, nonatomic) SSLoadingView *loadingView;
@property (strong, nonatomic) UIView *errorView;
@property (nonatomic) BOOL isDismissMVC;

- (void)showLoadingAnimated:(BOOL)animated;
- (void)hideLoadingViewAnimated:(BOOL)animated;
- (void)showErrorViewAnimated:(BOOL)animated;
- (void)hideErrorViewAnimated:(BOOL)animated;

/*
 *设置返回按钮，左侧显示
 */
- (void)setBackButton;

/*
 *设置左侧按钮
 */
- (void)setLeftButton:(UIImage *)image;

/*
 *设置右侧按钮
 */
- (void)setRightButton:(UIImage *)image;

/*
 点击按钮响应，左按钮默认返回
 */
- (void)onLeftBtnAction:(id)sender;
- (void)onRightBtnAction:(id)sender;

@end
