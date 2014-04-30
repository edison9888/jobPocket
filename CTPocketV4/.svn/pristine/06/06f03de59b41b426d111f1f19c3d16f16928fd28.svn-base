//
//  CTSimpleInfoView.m
//  CTPocketV4
//
//  Created by 许忠洲 on 13-11-11.
//  Copyright (c) 2013年 广东亿迅科技有限公司. All rights reserved.
//

#import "CTSimpleInfoView.h"
#import <QuartzCore/QuartzCore.h>

@implementation CTSimpleInfoView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        CGFloat y1 = 2;
        CGFloat y2 = 23;
        if (iPhone5) {
            y2 = 29;
        }
        
        // 用户名
        {
            _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(8, y1, 112, 22)];
            _titleLabel.backgroundColor = [UIColor clearColor];
            _titleLabel.font = [UIFont boldSystemFontOfSize:13.0f];
            _titleLabel.textColor = [UIColor blackColor];
            _titleLabel.text = @"－－，你好！";
            [self addSubview:_titleLabel];
        }
        
        // 剩余流量
        {
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(125, y1, 55, 22)];
            label.backgroundColor = [UIColor clearColor];
            label.font = [UIFont systemFontOfSize:13.0f];
            label.textColor = [UIColor blackColor];
            label.text = @"剩余流量";
            [self addSubview:label];
        }
        
        // 流量   // modified by zy, 2014-02-19
        {
            _usedFlowImage = [[UIView alloc] initWithFrame:CGRectMake(182, y1+5, 0, 10)]; //0~124
            _usedFlowImage.layer.cornerRadius = 5;
            _usedFlowImage.layer.masksToBounds = YES;
            _usedFlowImage.backgroundColor = [UIColor greenColor];
            [self addSubview:_usedFlowImage];
        }
        
        // 流量背景
        {
            UIImage *flowGray = [UIImage imageNamed:@"home_flow_gray"];
            UIImageView *flowGrayImageView = [[UIImageView alloc] initWithFrame:CGRectMake(180, y1+4, 128, 13)];
            flowGrayImageView.image = [flowGray resizableImageWithCapInsets:UIEdgeInsetsMake(flowGray.size.height, flowGray.size.width, flowGray.size.height, flowGray.size.width)];
            [self addSubview:flowGrayImageView];
            
            // added by zy, 2014-02-19
            [self sendSubviewToBack:flowGrayImageView];
            flowGrayImageView.center = CGPointMake(flowGrayImageView.center.x, _usedFlowImage.center.y);
        }
        
//        // 流量
//        {
//            _usedFlowImage = [[UIView alloc] initWithFrame:CGRectMake(182, y1+5, 0, 10)]; //0~124
//            _usedFlowImage.layer.cornerRadius = 5;
//            _usedFlowImage.layer.masksToBounds = YES;
//            _usedFlowImage.backgroundColor = [UIColor greenColor];
//            [self addSubview:_usedFlowImage];
//        }
        
        // 流量文本
        {
            _flowLabel = [[UILabel alloc] initWithFrame:CGRectMake(180, y1+4, 128, 13)];
            _flowLabel.backgroundColor = [UIColor clearColor];
            _flowLabel.font = [UIFont systemFontOfSize:13.0f];
            _flowLabel.textColor = [UIColor blackColor];
            _flowLabel.textAlignment = UITextAlignmentCenter;
            [self addSubview:_flowLabel];
        }
        
        // 本月话费
        {
            _benYueHuaFeiLabel = [[UILabel alloc] initWithFrame:CGRectMake(8, y2, 112, 22)];
            _benYueHuaFeiLabel.backgroundColor = [UIColor clearColor];
            _benYueHuaFeiLabel.font = [UIFont systemFontOfSize:13.0f];
            _benYueHuaFeiLabel.textColor = [UIColor blackColor];
            _benYueHuaFeiLabel.text = @"本月话费:";
            [self addSubview:_benYueHuaFeiLabel];
        }
        
        // 当前余额
        {
            _dangQianYuELabel = [[UILabel alloc] initWithFrame:CGRectMake(125, y2, 120, 22)];
            _dangQianYuELabel.backgroundColor = [UIColor clearColor];
            _dangQianYuELabel.font = [UIFont systemFontOfSize:13.0f];
            _dangQianYuELabel.textColor = [UIColor blackColor];
            _dangQianYuELabel.text = @"当前余额:";
            [self addSubview:_dangQianYuELabel];
        }
        
        // 加流量按钮
        {
            CGFloat height = 20;
            if (iPhone5) {
                height = 24;
            }
            
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            button.frame = CGRectMake(255, self.bounds.size.height-4-height, 52, height);
            [button setBackgroundImage:[UIImage imageNamed:@"home_flow_button"] forState:UIControlStateNormal];
            [button setTitle:@"加流量" forState:UIControlStateNormal];
            [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            button.titleLabel.font = [UIFont systemFontOfSize:13.0f];
            [button addTarget:self action:@selector(onFlowButtonAction) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:button];
        }
    }
    return self;
}

#pragma mark - self func

- (void)setUserName:(NSString *)userName
{
    _titleLabel.text = [NSString stringWithFormat:@"%@，你好！", userName];
}

- (void)setUsedFlow:(CGFloat)usedFlow allFlow:(CGFloat)allFlow
{
    CGRect rect = _usedFlowImage.frame;
    if (usedFlow <= 0)
    {
        rect.size.width = 0;
    }
    else
    {
        rect.size.width = usedFlow/allFlow*112+12;
    }
    _usedFlowImage.frame = rect;
    // 使用量<50%显示绿色，50%<=使用量<80%显示橘黄色，80%<=使用率显示红色
    if (usedFlow/allFlow < 0.5f)
    {
        _usedFlowImage.backgroundColor = [UIColor colorWithRed:0.44 green:0.77 blue:0.22 alpha:1.00];
    }
    else if (usedFlow/allFlow >= 0.8f)
    {
        _usedFlowImage.backgroundColor = [UIColor colorWithRed:0.94 green:0.40 blue:0.32 alpha:1.00];
    }
    else
    {
        _usedFlowImage.backgroundColor = [UIColor colorWithRed:0.96 green:0.69 blue:0.32 alpha:1.00];
    }
    
    _flowLabel.text = [NSString stringWithFormat:@"%.0fM/%.0fM", usedFlow, allFlow];
}

- (void)setBenYueHuaFei:(NSString *)benYueHuaFei
{
    _benYueHuaFeiLabel.text = [NSString stringWithFormat:@"本月话费:¥%@元", benYueHuaFei];
}

- (void)setDangQianYuE:(NSString *)dangQianYuE
{
    _dangQianYuELabel.text = [NSString stringWithFormat:@"当前余额:¥%@元", dangQianYuE];
}

- (void)onFlowButtonAction
{
    if ([self.delegate respondsToSelector:@selector(didSelectFlowButton)]) {
        [self.delegate didSelectFlowButton];
    }
}

@end
