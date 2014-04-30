//
//  CTAccountInfoView.h
//  CTPocketV4
//
//  Created by 许忠洲 on 13-11-10.
//  Copyright (c) 2013年 广东亿迅科技有限公司. All rights reserved.
//  首页账号信息

#import <UIKit/UIKit.h>

@protocol CTAccountInfoViewDelegate <NSObject>
@optional
- (void)didSelectIconAtIndex:(NSInteger)index;
@end

@interface CTAccountInfoView : UIView
{
    UIImageView *icon1;
    UIImageView *icon2;
    UIImageView *icon3;
    UIImageView *icon4;
    
    UILabel *label1;
    UILabel *label2;
    UILabel *label3;
    UILabel *label4;
    
    UIButton *button1;
    UIButton *button2;
    UIButton *button3;
    UIButton *button4;
    
    BOOL isIcon1StopFlip;
    BOOL isIcon2StopFlip;
    BOOL isIcon3StopFlip;
    BOOL isIcon4StopFlip;
}

@property (weak, nonatomic) id<CTAccountInfoViewDelegate> delegate;

- (void)setAccountInfo:(NSString *)info atIndex:(NSInteger)index;

// 重置ＵＩ， added by zy, 2014-02-17
- (void)reset;

@end
