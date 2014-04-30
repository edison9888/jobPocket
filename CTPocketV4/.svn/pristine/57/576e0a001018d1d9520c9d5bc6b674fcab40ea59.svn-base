//
//  CTFlowRemainingCell.m
//  CTPocketV4
//
//  Created by apple on 13-12-6.
//  Copyright (c) 2013年 广东亿迅科技有限公司. All rights reserved.
//

#import "CTFlowRemainingCell.h"

@interface CTFlowRemainingCell()
{
    UIButton*   _titleBtn;
    UILabel*    _durationLab;
}

@end

@implementation CTFlowRemainingCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        self.frame = CGRectMake(0, 0, kCTFlowRemainingTableCellWidth, kCTFlowRemainingTableCellHight);
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        {
            UIView* line = [[UIView alloc] initWithFrame:CGRectMake(20, 0, 1, kCTFlowRemainingTableCellHight)];
            line.backgroundColor = [UIColor lightGrayColor];
            line.autoresizingMask = UIViewAutoresizingFlexibleHeight;
            [self addSubview:line];
        }
        
        {
            UIButton* btn = [UIButton buttonWithType:UIButtonTypeCustom];
            btn.frame = CGRectInset(self.bounds, 6, 0);
            btn.userInteractionEnabled = NO;
            btn.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
            [btn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
            [btn.titleLabel setFont:[UIFont systemFontOfSize:14]];
            [btn setTitleEdgeInsets:UIEdgeInsetsMake(0, 6, 0, 0)];
            btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
            [btn setImage:[UIImage imageNamed:@"flow_icon_new"] forState:UIControlStateNormal];
            [self addSubview:btn];
            _titleBtn = btn;
        }
        
        {
            UILabel* lab = [[UILabel alloc] initWithFrame:CGRectInset(self.bounds, 10, 0)];
            lab.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
            lab.font = [UIFont systemFontOfSize:14];
            lab.textColor = [UIColor darkGrayColor];
            lab.backgroundColor = [UIColor clearColor];
            lab.textAlignment = UITextAlignmentRight;
            [self addSubview:lab];
            _durationLab = lab;
        }
        
        {
            UIView * lineView        = [[UIView alloc] initWithFrame:CGRectMake(0, self.frame.size.height - 1, self.frame.size.width, 1)];
            lineView.backgroundColor = [UIColor lightGrayColor];
            [self addSubview:lineView];
        }
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    [_titleBtn setImage:[UIImage imageNamed:@"flow_icon_new"] forState:UIControlStateNormal];
    [_titleBtn setTitle:@"看新闻" forState:UIControlStateNormal];
    _durationLab.text = @"";
    
    float AccAmount = 0;
    float UsedAmount = 0;
    
    if (self.flowInfoDict[@"AccAmount"] != [NSNull null] &&
        self.flowInfoDict[@"AccAmount"] != nil)
    {
        AccAmount = [self.flowInfoDict[@"AccAmount"] floatValue];
    }
    
    if (self.flowInfoDict[@"UsedAmount"] != [NSNull null] &&
        self.flowInfoDict[@"UsedAmount"] != nil)
    {
        UsedAmount = [self.flowInfoDict[@"UsedAmount"] floatValue];
    }
    
    AccAmount /= 1024.;
    UsedAmount /= 1024.;
    float leftAmount = (AccAmount - UsedAmount);

    switch (self.tag)
    {
        case 0: // 看新闻
        {
            [_titleBtn setTitle:@"看新闻" forState:UIControlStateNormal];
            [_titleBtn setImage:[UIImage imageNamed:@"flow_icon_new"] forState:UIControlStateNormal];
            
            float duration = 3 * leftAmount;
            if (duration > 60)
            {
                int hour    = duration / 60;
                _durationLab.text = [NSString stringWithFormat:@"约%d小时%.0f分钟", hour, duration - hour * 60];
            }
            else
            {
                _durationLab.text = [NSString stringWithFormat:@"约%.0f分钟", duration];
            }
        }break;
        case 1: // 微信
        {
            [_titleBtn setTitle:@"聊微信/QQ" forState:UIControlStateNormal];
            [_titleBtn setImage:[UIImage imageNamed:@"flow_icon_qq"] forState:UIControlStateNormal];
            
            float duration = 9 * leftAmount;
            if (duration > 60)
            {
                int hour    = duration / 60;
                _durationLab.text = [NSString stringWithFormat:@"约%d小时%.0f分钟", hour, duration - hour * 60];
            }
            else
            {
                _durationLab.text = [NSString stringWithFormat:@"约%.0f分钟", duration];
            }
        }break;
        case 2: // music
        {
            [_titleBtn setTitle:@"听音乐" forState:UIControlStateNormal];
            [_titleBtn setImage:[UIImage imageNamed:@"flow_icon_music"] forState:UIControlStateNormal];
            
            float duration = .25 * leftAmount;
            _durationLab.text = [NSString stringWithFormat:@"约%.0f首", duration];
        }break;
        case 3: // weibo
        {
            [_titleBtn setTitle:@"刷微博" forState:UIControlStateNormal];
            [_titleBtn setImage:[UIImage imageNamed:@"flow_icon_weibo"] forState:UIControlStateNormal];
            
            float duration = 200 * leftAmount;
            _durationLab.text = [NSString stringWithFormat:@"约%.0f条", duration];
        }break;
        case 4: // vedio
        {
            [_titleBtn setTitle:@"看视频" forState:UIControlStateNormal];
            [_titleBtn setImage:[UIImage imageNamed:@"flow_icon_vedio"] forState:UIControlStateNormal];
            
            float duration = .4 * leftAmount;
            if (duration > 60)
            {
                int hour    = duration / 60;
                _durationLab.text = [NSString stringWithFormat:@"约%d小时%.0f分钟", hour, duration - hour * 60];
            }
            else
            {
                _durationLab.text = [NSString stringWithFormat:@"约%.0f分钟", duration];
            }
        }break;
        default:
            break;
    }
}

@end
