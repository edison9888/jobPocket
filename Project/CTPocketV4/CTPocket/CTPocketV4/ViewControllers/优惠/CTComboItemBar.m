//
//  CTComboItemBar.m
//  CTPocketV4
//
//  Created by 许忠洲 on 14-1-9.
//  Copyright (c) 2014年 广东亿迅科技有限公司. All rights reserved.
//  ComboItemBar

#import "CTComboItemBar.h"

@implementation CTComboItemBar

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (instancetype)initWithArray:(NSArray *)array
{
    self = [super init];
    if (self) {
        self.frame = CGRectMake(0, 0, 320, 42);
        
        CGFloat bWidth = 320/[array count];
        int i = 0;
        for (NSDictionary *dict in array)
        {
            if (i==0) {
                UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
                [btn setFrame:CGRectMake(bWidth * i, 0, bWidth, 42)];
                [btn setBackgroundImage:[UIImage imageNamed:@"recharge_unselected_bg"] forState:UIControlStateNormal];
                [btn setBackgroundImage:[UIImage imageNamed:@"recharge_selected_bg"] forState:UIControlStateHighlighted];
                [btn setBackgroundImage:[UIImage imageNamed:@"recharge_selected_bg.png"] forState:UIControlStateSelected];
                btn.titleLabel.font = [UIFont systemFontOfSize:15.0f];
                [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
                // add by liuruxian 2014-02-25
                if ([dict[@"ComboType"] isEqualToString:@"883"]) {
                    [btn setTitle:@"飞Young纯流量套餐" forState:UIControlStateNormal];
                } else {
                    [btn setTitle:dict[@"ComboName"] forState:UIControlStateNormal];
                }
                btn.tag = i + 1;
                [btn addTarget:self
                        action:@selector(selectBtn:)
              forControlEvents:UIControlEventTouchUpInside];
                [self addSubview:btn];
            }
            if (i>0 && i<array.count-1) {
                UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
                [btn setFrame:CGRectMake(bWidth * i, 0, bWidth, 42)];
                [btn setBackgroundImage:[UIImage imageNamed:@"recharge_unselected_bg"] forState:UIControlStateNormal];
                [btn setBackgroundImage:[UIImage imageNamed:@"recharge_selected_bg"] forState:UIControlStateHighlighted];
                [btn setBackgroundImage:[UIImage imageNamed:@"recharge_middle_icon.png"] forState:UIControlStateSelected];
                btn.titleLabel.font = [UIFont systemFontOfSize:15.0f];
                [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
                // add by liuruxian 2014-02-25
                if ([dict[@"ComboType"] isEqualToString:@"883"]) {
                    [btn setTitle:@"飞Young纯流量套餐" forState:UIControlStateNormal];
                } else {
                    [btn setTitle:dict[@"ComboName"] forState:UIControlStateNormal];
                }
                btn.tag = i + 1;
                [btn addTarget:self
                        action:@selector(selectBtn:)
              forControlEvents:UIControlEventTouchUpInside];
                [self addSubview:btn];
            }
            
            if (i==array.count-1 && i>0) {
                UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
                [btn setFrame:CGRectMake(bWidth * i, 0, bWidth, 42)];
                [btn setBackgroundImage:[UIImage imageNamed:@"recharge_unselected_bg"] forState:UIControlStateNormal];
                [btn setBackgroundImage:[UIImage imageNamed:@"recharge_selected_bg"] forState:UIControlStateHighlighted];
                [btn setBackgroundImage:[UIImage imageNamed:@"recharge_selected_right.png"] forState:UIControlStateSelected];
                btn.titleLabel.font = [UIFont systemFontOfSize:15.0f];
                [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
                // add by liuruxian 2014-02-25
                if ([dict[@"ComboType"] isEqualToString:@"883"]) {
                    [btn setTitle:@"飞Young纯流量套餐" forState:UIControlStateNormal];
                } else {
                    [btn setTitle:dict[@"ComboName"] forState:UIControlStateNormal];
                }
                btn.tag = i + 1;
                [btn addTarget:self
                        action:@selector(selectBtn:)
              forControlEvents:UIControlEventTouchUpInside];
                [self addSubview:btn];
            }
            i++;
        }
        
        self.index = 1;
        UIButton *btn1 = (UIButton *)[self viewWithTag:1];
        btn1.selected = YES;
    }
    return self;
}

#pragma mark - Custom Methods
- (void)selectBtn:(UIButton *)btn
{
    if (self.index != btn.tag)
    {
        if ([self.delegate respondsToSelector:@selector(didSelectFromIndex1:ToIndex2:)])
        {
            [self.delegate didSelectFromIndex1:self.index ToIndex2:btn.tag];
            
            UIButton *btn1 = (UIButton *)[self viewWithTag:self.index];
            btn1.selected = NO;
            UIButton *btn2 = (UIButton *)[self viewWithTag:btn.tag];
            btn2.selected = YES;
            
            self.index = btn.tag;
        }
    }
}

@end
