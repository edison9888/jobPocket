//
//  EsNoticeSettingCell.m
//  xhgdzwyq
//
//  Created by apple on 13-11-28.
//  Copyright (c) 2013年 Eshore. All rights reserved.
//

#import "EsNoticeSettingCell.h"

@implementation EsNoticeSettingCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = [UIColor clearColor];
        {
            UILabel* lab = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, self.frame.size.width - 40, self.frame.size.height)];
            lab.backgroundColor = [UIColor clearColor];
            lab.textAlignment = UITextAlignmentLeft;
            lab.font = [UIFont systemFontOfSize:14];
            lab.textColor = ([Global sharedSingleton].uiStyle.mode == UIStyleModeDay ? [UIColor blackColor] : RGB(0x99, 0x99, 0x99, 1));
            [self addSubview:lab];
            _titleLab = lab;
        }
        
        {
            UIView* v = [[UIView alloc] initWithFrame:CGRectMake(15, kNoticeSettingCellHeight - 1, self.frame.size.width, 1)];
            v.backgroundColor = ([Global sharedSingleton].uiStyle.mode == UIStyleModeDay ? RGB(0xc6, 0xc6, 0xc6, 1) : RGB(0x99, 0x99, 0x99, 1));
            [self addSubview:v];
        }
        {
            UIImage* nimg = [UIImage imageNamed:@"Set_switch_background_off"];
            UIImage* simg = [UIImage imageNamed:@"Set_switch_background_on"];
            UIButton* btn = [UIButton buttonWithType:UIButtonTypeCustom];
            btn.frame     = CGRectMake(CGRectGetWidth(self.frame) - nimg.size.width - 15,
                                       (kNoticeSettingCellHeight - nimg.size.height)/2,
                                       nimg.size.width,
                                       nimg.size.height);
            [btn setBackgroundImage:nimg forState:UIControlStateNormal];
            [btn setBackgroundImage:simg forState:UIControlStateSelected];
            [btn setImage:[UIImage imageNamed:@"Set_switch_icon"] forState:UIControlStateNormal];
            [btn addTarget:self action:@selector(onSwitchBtn) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:btn];
            _switchBtn    = btn;
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
    _titleLab.text = self.columnInfo.catalogName;
    [self setSwitchOn:self.columnInfo.receivedPushMsg];
}

- (void)setSwitchOn:(BOOL)val
{
    _switchBtn.selected = val;
    
    UIImage* img = [UIImage imageNamed:@"Set_switch_icon"];
    if (val)
    {
        [_switchBtn setImageEdgeInsets:UIEdgeInsetsMake((CGRectGetHeight(_switchBtn.frame) - img.size.height)/2 + 2,
                                                        CGRectGetWidth(_switchBtn.frame) - img.size.width,
                                                        (CGRectGetHeight(_switchBtn.frame) - img.size.height)/2 - 2,
                                                        0)];
    }
    else
    {
        [_switchBtn setImageEdgeInsets:UIEdgeInsetsMake((CGRectGetHeight(_switchBtn.frame) - img.size.height)/2 + 2,
                                                        0,
                                                        (CGRectGetHeight(_switchBtn.frame) - img.size.height)/2 - 2,
                                                        CGRectGetWidth(_switchBtn.frame) - img.size.width)];
    }
}

- (void)onSwitchBtn
{
    [self setSwitchOn:!_switchBtn.selected];
    self.columnInfo.receivedPushMsg = _switchBtn.selected;
}

@end
