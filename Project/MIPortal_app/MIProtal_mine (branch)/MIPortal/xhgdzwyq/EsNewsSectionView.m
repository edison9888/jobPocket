//
//  EsNewsSectionView.m
//  xhgdzwyq
//
//  Created by apple on 13-12-1.
//  Copyright (c) 2013年 Eshore. All rights reserved.
//

#import "EsNewsSectionView.h"

@interface EsNewsSectionView()
{
    UILabel*    _titleLab;
    UILabel*    _dtLab;
}

@end

@implementation EsNewsSectionView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor = ([Global sharedSingleton].uiStyle.mode == UIStyleModeDay ? kBackgroundColor_D : kBackgroundColor_N);
        {
            UILabel* lab = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, CGRectGetWidth(frame) - 30, CGRectGetHeight(frame))];
            lab.backgroundColor = [UIColor clearColor];
            lab.textColor = ([Global sharedSingleton].uiStyle.mode == UIStyleModeDay ? kNewsListTextColor_D : kNewsListTextColor_N);
            lab.font = [UIFont systemFontOfSize:16];
            lab.textAlignment = UITextAlignmentLeft;
            [self addSubview:lab];
            _titleLab = lab;
        }
        
        {
            UILabel* lab = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, CGRectGetWidth(frame) - 30, CGRectGetHeight(frame))];
            lab.backgroundColor = [UIColor clearColor];
            lab.textColor = RGB(0x77, 0x77, 0x77, 1);
            lab.font = [UIFont systemFontOfSize:11];
            lab.textAlignment = UITextAlignmentRight;
            [self addSubview:lab];
            _dtLab = lab;
        }
        
        {
            UIView* v = [[UIView alloc] initWithFrame:CGRectMake(15, CGRectGetHeight(frame) - 1, 320 - 30, 1)];
            v.backgroundColor = RGB(255, 106, 40, 1);
            [self addSubview:v];
        }
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onUIChangeNotification:) name:kMsgChangeUIStyle object:nil];
    }
    return self;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    _dtLab.text = @"";
    if (self.verifyDate.length)
    {
        _dtLab.text = self.verifyDate;
    }
    
    _titleLab.text = @"";
    if (self.week.length)
    {
        _titleLab.text = self.week;
    }
}

#pragma mark notification
- (void)onUIChangeNotification:(id)sender
{
    self.backgroundColor = ([Global sharedSingleton].uiStyle.mode == UIStyleModeDay ? kBackgroundColor_D : kBackgroundColor_N);
    _titleLab.textColor = ([Global sharedSingleton].uiStyle.mode == UIStyleModeDay ? kNewsListTextColor_D : kNewsListTextColor_N);
}
@end
