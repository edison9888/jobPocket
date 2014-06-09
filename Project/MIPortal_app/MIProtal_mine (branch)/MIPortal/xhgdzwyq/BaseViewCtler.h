/*=================================
 *Name：BaseViewCtler.m
 *Desc：带导航背景的积累，
 *Date：2014/05/21
 *Auth：lip
 *=================================*/


#import <UIKit/UIKit.h>

@interface BaseViewCtler : UIViewController

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
 *设置右侧按钮
 */
- (void)setRightButtonWidthTitle:(NSString *)csTitle;

/*
 点击按钮响应，左按钮默认返回
 */
- (void)onLeftBtnAction:(id)sender;
- (void)onRightBtnAction:(id)sender;

@end
