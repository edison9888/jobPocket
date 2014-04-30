//
//  CTAccountInfoView.m
//  CTPocketV4
//
//  Created by 许忠洲 on 13-11-10.
//  Copyright (c) 2013年 广东亿迅科技有限公司. All rights reserved.
//  首页账号信息

#import "CTAccountInfoView.h"

@implementation CTAccountInfoView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        {
            button1 = [UIButton buttonWithType:UIButtonTypeCustom];
            button1.frame = CGRectMake(0, 1, 78, self.bounds.size.height);
            [button1 setBackgroundImage:[UIImage imageNamed:@"flip_button_hl"] forState:UIControlStateHighlighted];
            [button1 addTarget:self action:@selector(onSelectButton1) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:button1];
            
            label1 = [[UILabel alloc] initWithFrame:CGRectMake(0, 6, 80, 22)];
            label1.backgroundColor = [UIColor clearColor];
            label1.font = [UIFont systemFontOfSize:13.0f];
            label1.textColor = [UIColor blackColor];
            label1.textAlignment = UITextAlignmentCenter;
            label1.hidden = YES;
            [self addSubview:label1];
            
            icon1 = [[UIImageView alloc] initWithFrame:CGRectMake(27, 6, 25, 22)];
            icon1.image = [UIImage imageNamed:@"home_account_info1"];
            [self addSubview:icon1];
            
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 28, 80, self.bounds.size.height-28)];
            label.backgroundColor = [UIColor clearColor];
            label.font = [UIFont systemFontOfSize:13.0f];
            label.textColor = [UIColor blackColor];
            label.textAlignment = UITextAlignmentCenter;
            label.text = @"本月话费";
            [self addSubview:label];
            
            UIImageView *separatorV = [[UIImageView alloc] initWithFrame:CGRectMake(79, 5, 1, self.bounds.size.height-10)];
            separatorV.image = [UIImage imageNamed:@"custom_separatorV"];
            [self addSubview:separatorV];
        }
        
        {
            button2 = [UIButton buttonWithType:UIButtonTypeCustom];
            button2.frame = CGRectMake(80, 1, 78, self.bounds.size.height);
            [button2 setBackgroundImage:[UIImage imageNamed:@"flip_button_hl"] forState:UIControlStateHighlighted];
            [button2 addTarget:self action:@selector(onSelectButton2) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:button2];
            
            label2 = [[UILabel alloc] initWithFrame:CGRectMake(80, 6, 80, 22)];
            label2.backgroundColor = [UIColor clearColor];
            label2.font = [UIFont systemFontOfSize:13.0f];
            label2.textColor = [UIColor blackColor];
            label2.textAlignment = UITextAlignmentCenter;
            label2.hidden = YES;
            [self addSubview:label2];
            
            icon2 = [[UIImageView alloc] initWithFrame:CGRectMake(107, 6, 25, 22)];
            icon2.image = [UIImage imageNamed:@"home_account_info2"];
            [self addSubview:icon2];
            
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(80, 28, 80, self.bounds.size.height-28)];
            label.backgroundColor = [UIColor clearColor];
            label.font = [UIFont systemFontOfSize:13.0f];
            label.textColor = [UIColor blackColor];
            label.textAlignment = UITextAlignmentCenter;
            label.text = @"当前余额";
            [self addSubview:label];
            
            UIImageView *separatorV = [[UIImageView alloc] initWithFrame:CGRectMake(159, 5, 1, self.bounds.size.height-10)];
            separatorV.image = [UIImage imageNamed:@"custom_separatorV"];
            [self addSubview:separatorV];
        }
        
        {
            button3 = [UIButton buttonWithType:UIButtonTypeCustom];
            button3.frame = CGRectMake(160, 1, 78, self.bounds.size.height);
            [button3 setBackgroundImage:[UIImage imageNamed:@"flip_button_hl"] forState:UIControlStateHighlighted];
            [button3 addTarget:self action:@selector(onSelectButton3) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:button3];
            
            label3 = [[UILabel alloc] initWithFrame:CGRectMake(160, 6, 80, 22)];
            label3.backgroundColor = [UIColor clearColor];
            label3.font = [UIFont systemFontOfSize:13.0f];
            label3.textColor = [UIColor blackColor];
            label3.textAlignment = UITextAlignmentCenter;
            label3.hidden = YES;
            [self addSubview:label3];
            
            icon3 = [[UIImageView alloc] initWithFrame:CGRectMake(187, 6, 25, 22)];
            icon3.image = [UIImage imageNamed:@"home_account_info3"];
            [self addSubview:icon3];
            
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(160, 28, 80, self.bounds.size.height-28)];
            label.backgroundColor = [UIColor clearColor];
            label.font = [UIFont systemFontOfSize:13.0f];
            label.textColor = [UIColor blackColor];
            label.textAlignment = UITextAlignmentCenter;
            label.text = @"剩余通话";
            [self addSubview:label];
            
            UIImageView *separatorV = [[UIImageView alloc] initWithFrame:CGRectMake(239, 5, 1, self.bounds.size.height-10)];
            separatorV.image = [UIImage imageNamed:@"custom_separatorV"];
            [self addSubview:separatorV];
        }
        
        {
            button4 = [UIButton buttonWithType:UIButtonTypeCustom];
            button4.frame = CGRectMake(240, 1, 78, self.bounds.size.height);
            [button4 setBackgroundImage:[UIImage imageNamed:@"flip_button_hl"] forState:UIControlStateHighlighted];
            [button4 addTarget:self action:@selector(onSelectButton4) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:button4];
            
            label4 = [[UILabel alloc] initWithFrame:CGRectMake(240, 6, 80, 22)];
            label4.backgroundColor = [UIColor clearColor];
            label4.font = [UIFont systemFontOfSize:13.0f];
            label4.textColor = [UIColor blackColor];
            label4.textAlignment = UITextAlignmentCenter;
            label4.hidden = YES;
            [self addSubview:label4];
            
            icon4 = [[UIImageView alloc] initWithFrame:CGRectMake(267, 6, 25, 22)];
            icon4.image = [UIImage imageNamed:@"home_account_info4"];
            [self addSubview:icon4];
            
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(240, 28, 80, self.bounds.size.height-28)];
            label.backgroundColor = [UIColor clearColor];
            label.font = [UIFont systemFontOfSize:13.0f];
            label.textColor = [UIColor blackColor];
            label.textAlignment = UITextAlignmentCenter;
            label.text = @"我的积分";
            [self addSubview:label];
        }
        
        {
            isIcon1StopFlip = YES;
            isIcon2StopFlip = YES;
            isIcon3StopFlip = YES;
            isIcon4StopFlip = YES;
        }
    }
    return self;
}

#pragma self func

- (void)onSelectButton1
{
    if ([Global sharedInstance].isLogin) {
        [button1 setEnabled:NO];
        isIcon1StopFlip = YES;
        [self flipIcon1];
    }
    
    if ([self.delegate respondsToSelector:@selector(didSelectIconAtIndex:)]) {
        [self.delegate didSelectIconAtIndex:1];
    }
}

- (void)flipIcon1
{
    if (isIcon1StopFlip) {
        __weak id wSelf = self;
        [UIView transitionWithView:icon1
                          duration:0.8f
                           options:UIViewAnimationOptionTransitionFlipFromLeft
                        animations:^{
                        }
                        completion:^(BOOL finished){
                            [wSelf flipIcon1];
                        }];
    }
}

- (void)onSelectButton2
{
    if ([Global sharedInstance].isLogin) {
        [button2 setEnabled:NO];
        isIcon2StopFlip = YES;
        [self flipIcon2];
    }
    
    if ([self.delegate respondsToSelector:@selector(didSelectIconAtIndex:)]) {
        [self.delegate didSelectIconAtIndex:2];
    }
}

- (void)flipIcon2
{
    if (isIcon2StopFlip) {
        __weak id wSelf = self;
        [UIView transitionWithView:icon2
                          duration:0.8f
                           options:UIViewAnimationOptionTransitionFlipFromLeft
                        animations:^{
                        }
                        completion:^(BOOL finished){
                            [wSelf flipIcon2];
                        }];
    }
}

- (void)onSelectButton3
{
    if ([Global sharedInstance].isLogin) {
        [button3 setEnabled:NO];
        isIcon3StopFlip = YES;
        [self flipIcon3];
    }
    
    if ([self.delegate respondsToSelector:@selector(didSelectIconAtIndex:)]) {
        [self.delegate didSelectIconAtIndex:3];
    }
}

- (void)flipIcon3
{
    if (isIcon3StopFlip) {
        __weak id wSelf = self;
        [UIView transitionWithView:icon3
                          duration:0.8f
                           options:UIViewAnimationOptionTransitionFlipFromLeft
                        animations:^{
                        }
                        completion:^(BOOL finished){
                            [wSelf flipIcon3];
                        }];
    }
}

- (void)onSelectButton4
{
    if ([Global sharedInstance].isLogin) {
        [button4 setEnabled:NO];
        isIcon4StopFlip = YES;
        [self flipIcon4];
    }
    
    if ([self.delegate respondsToSelector:@selector(didSelectIconAtIndex:)]) {
        [self.delegate didSelectIconAtIndex:4];
    }
}

- (void)flipIcon4
{
    if (isIcon4StopFlip) {
        __weak id wSelf = self;
        [UIView transitionWithView:icon4
                          duration:0.8f
                           options:UIViewAnimationOptionTransitionFlipFromLeft
                        animations:^{
                        }
                        completion:^(BOOL finished){
                            [wSelf flipIcon4];
                        }];
    }
}

- (void)setAccountInfo:(NSString *)info atIndex:(NSInteger)index
{
    switch (index) {
        case 1:
        {
            isIcon1StopFlip = NO;
            
            if (info) {
                [button1 setEnabled:NO];
                icon1.hidden = YES;
                label1.text = [NSString stringWithFormat:@"¥%@元", info];
                label1.hidden = NO;
            }
            else {
                [button1 setEnabled:YES];
            }
        }
            break;
        case 2:
        {
            isIcon2StopFlip = NO;
            
            if (info) {
                [button2 setEnabled:NO];
                icon2.hidden = YES;
                label2.text = [NSString stringWithFormat:@"¥%@元", info];
                label2.hidden = NO;
            }
            else {
                [button2 setEnabled:YES];
                
                // added by zy, 2014-02-17
                icon2.hidden = NO;
                label2.text = @"";
                label2.hidden = YES;
                // added by zy, 2014-02-17
            }
        }
            break;
        case 3:
        {
            isIcon3StopFlip = NO;
            
            if (info) {
                [button3 setEnabled:NO];
                icon3.hidden = YES;
                label3.text = [NSString stringWithFormat:@"%@分钟", info];
                label3.hidden = NO;
            }
            else {
                [button3 setEnabled:YES];
            }
        }
            break;
        case 4:
        {
            isIcon4StopFlip = NO;
            
            if (info) {
                [button4 setEnabled:NO];
                icon4.hidden = YES;
                label4.text = [NSString stringWithFormat:@"%@分", info];
                label4.hidden = NO;
            }
            else {
                [button4 setEnabled:YES];
            }
        }
            break;
        default:
            break;
    }
}

// 重置ＵＩ， added by zy, 2014-02-17
- (void)reset
{
    isIcon1StopFlip = YES;
    [button1 setEnabled:YES];
    icon1.hidden = NO;
    label1.text = @"";
    label1.hidden = YES;
    
    isIcon2StopFlip = YES;
    [button2 setEnabled:YES];
    icon2.hidden = NO;
    label2.text = @"";
    label2.hidden = YES;
    
    isIcon3StopFlip = YES;
    [button3 setEnabled:YES];
    icon3.hidden = NO;
    label3.text = @"";
    label3.hidden = YES;
    
    isIcon4StopFlip = YES;
    [button4 setEnabled:YES];
    icon4.hidden = NO;
    label4.text = @"";
    label4.hidden = YES;
}

@end
