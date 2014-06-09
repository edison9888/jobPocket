//
//  EsNewsCell.m
//  xhgdzwyq
//
//  Created by apple on 13-11-28.
//  Copyright (c) 2013年 Eshore. All rights reserved.
//

#import "EsNewsCell.h"

@interface EsNewsCell()
{
    UIButton*   _numBtn;
    UILabel*    _titleLab;
    UILabel*    _sumaryLab;
    UIView*     _lineView;
}

@end

@implementation EsNewsCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        int originX = 15;
        int originY = 16;
        self.backgroundColor = [UIColor clearColor];
        
        {
            UIImage* img = [UIImage imageNamed:@"Digital-color-list"];
            UIButton* btn = [UIButton buttonWithType:UIButtonTypeCustom];
            btn.frame = CGRectMake(originX, originY, img.size.width, img.size.height);
            [btn setBackgroundImage:img forState:UIControlStateNormal];
            btn.userInteractionEnabled = NO;
            [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [btn.titleLabel setFont:[UIFont systemFontOfSize:14]];
            [self addSubview:btn];
            _numBtn = btn;
            originX = CGRectGetMaxX(btn.frame) + 8;
        }
        
        {
            UILabel* lab = [[UILabel alloc] initWithFrame:CGRectMake(originX, originY, 320 - originX - 10, 40)];
            lab.backgroundColor = [UIColor clearColor];
            lab.font = [UIFont systemFontOfSize:16];
            lab.textAlignment = UITextAlignmentLeft;
            lab.numberOfLines = 2;
            lab.textColor = ([Global sharedSingleton].uiStyle.mode == UIStyleModeDay ? kNewsListTextColor_D : kNewsListTextColor_N);
            lab.lineBreakMode = NSLineBreakByWordWrapping;
            [self addSubview:lab];
            _titleLab = lab;
            originY = CGRectGetMaxY(lab.frame) + 10;
        }
        
        {
            UILabel* lab = [[UILabel alloc] initWithFrame:CGRectMake(originX, originY, 320 - originX - 10, 40)];
            lab.backgroundColor = [UIColor clearColor];
            lab.font = [UIFont systemFontOfSize:12];
            lab.textAlignment = UITextAlignmentLeft;
            lab.textColor = RGB(0x77, 0x77, 0x77, 1);
            lab.numberOfLines = 2;
            lab.lineBreakMode = NSLineBreakByCharWrapping;
            [self addSubview:lab];
            _sumaryLab = lab;
            originY = CGRectGetMaxY(lab.frame) + 16;
        }
        
        {
            originX = 15;
            UIView* v = [[UIView alloc] initWithFrame:CGRectMake(originX, originY, 320 - 2*originX, 1)];
            v.backgroundColor = ([Global sharedSingleton].uiStyle.mode == UIStyleModeNight ? kNewsListLineColor_N : kNewsListLineColor_D);
            [self addSubview:v];
            _lineView = v;
        }
        
        {
            UIView* v = [[UIView alloc] initWithFrame:CGRectZero];
            v.backgroundColor = RGB(0xd0, 0xd0, 0xd0, 1);
            v.autoresizingMask = UIViewAutoresizingFlexibleTopMargin;
            self.selectedBackgroundView = v;
            originY = CGRectGetMaxY(v.frame);
        }
        
        CGRect rc = self.frame;
        rc.size.height = originY;
        self.frame = rc;
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onUIChangeNotification:) name:kMsgChangeUIStyle object:nil];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (CGFloat)getCellHeight
{
    int originY = 0;
    CGSize sz = [self.newsInfo.newsTitle sizeWithFont:_titleLab.font
                                    constrainedToSize:CGSizeMake(320 - (CGRectGetMaxX(_numBtn.frame) + 8) - CGRectGetMinX(_numBtn.frame), 40)
                                        lineBreakMode:_titleLab.lineBreakMode];
    originY = CGRectGetMinY(_titleLab.frame) + sz.height + 10;
    
    sz = [self.newsInfo.newsSummary sizeWithFont:_sumaryLab.font
                               constrainedToSize:CGSizeMake(320 - (CGRectGetMaxX(_numBtn.frame) + 8) - CGRectGetMinX(_numBtn.frame), 40)
                                   lineBreakMode:_sumaryLab.lineBreakMode];
    originY += sz.height + 17;

    return originY;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    _titleLab.text = @"";
    if (self.newsInfo.newsTitle.length)
    {
        _titleLab.text = [NSString stringWithFormat:@"%@", self.newsInfo.newsTitle];
    }
    CGSize sz = [self.newsInfo.newsTitle sizeWithFont:_titleLab.font
                                    constrainedToSize:CGSizeMake(320 - (CGRectGetMaxX(_numBtn.frame) + 8) - CGRectGetMinX(_numBtn.frame), 40)
                                        lineBreakMode:_titleLab.lineBreakMode];
    _titleLab.frame = CGRectMake(CGRectGetMinX(_titleLab.frame),
                                 CGRectGetMinY(_titleLab.frame),
                                 sz.width,
                                 sz.height);
    
    _sumaryLab.text = @"";
    if (self.newsInfo.newsSummary.length)
    {
        _sumaryLab.text = [NSString stringWithFormat:@"%@", self.newsInfo.newsSummary];
    }
    sz = [self.newsInfo.newsSummary sizeWithFont:_sumaryLab.font
                               constrainedToSize:CGSizeMake(320 - (CGRectGetMaxX(_numBtn.frame) + 8) - CGRectGetMinX(_numBtn.frame), 40)
                                   lineBreakMode:_sumaryLab.lineBreakMode];
    _sumaryLab.frame = CGRectMake(CGRectGetMinX(_sumaryLab.frame),
                                  CGRectGetMaxY(_titleLab.frame) + 10,
                                  sz.width,
                                  sz.height);

    [_numBtn setTitle:[NSString stringWithFormat:@"%d", self.tag + 1] forState:UIControlStateNormal];
    
    if (self.newsInfo.readed)
    {
        // 已读
        _titleLab.textColor = ([Global sharedSingleton].uiStyle.mode == UIStyleModeDay ? kNewsListTextColor_N : RGB(0x66, 0x66, 0x66, 1));
        _sumaryLab.textColor = ([Global sharedSingleton].uiStyle.mode == UIStyleModeDay ? RGB(0x77, 0x77, 0x77, 1) : RGB(0x66, 0x66, 0x66, 1));
        [_numBtn setBackgroundImage:[UIImage imageNamed:@"Digital-color-list-2"] forState:UIControlStateNormal];
    }
    else
    {
        // 未读
        _titleLab.textColor = ([Global sharedSingleton].uiStyle.mode == UIStyleModeDay ? kNewsListTextColor_D : kNewsListTextColor_N);
        _sumaryLab.textColor = ([Global sharedSingleton].uiStyle.mode == UIStyleModeDay ? RGB(0x77, 0x77, 0x77, 1) : kNewsListTextColor_N);
        [_numBtn setBackgroundImage:[UIImage imageNamed:@"Digital-color-list"] forState:UIControlStateNormal];
    }
    
    _lineView.frame = CGRectMake(CGRectGetMinX(_lineView.frame),
                                  CGRectGetMaxY(_sumaryLab.frame) + 16,
                                  CGRectGetWidth(_lineView.frame),
                                  CGRectGetHeight(_lineView.frame));
    
    CGRect rc = self.frame;
    rc.size.height = CGRectGetMaxY(_lineView.frame);
    self.frame = rc;
}

#pragma mark notification
- (void)onUIChangeNotification:(id)sender
{
    _titleLab.textColor = ([Global sharedSingleton].uiStyle.mode == UIStyleModeDay ? kNewsListTextColor_D : kNewsListTextColor_N);
    _lineView.backgroundColor = ([Global sharedSingleton].uiStyle.mode == UIStyleModeNight ? kNewsListLineColor_N : kNewsListLineColor_D);
}

@end
