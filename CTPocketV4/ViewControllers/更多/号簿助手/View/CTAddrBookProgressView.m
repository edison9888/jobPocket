//
//  CTAddrBookProgressView.m
//  CTPocketV4
//
//  Created by apple on 14-3-24.
//  Copyright (c) 2014年 广东亿迅科技有限公司. All rights reserved.
//

#import "CTAddrBookProgressView.h"

@interface CTAddrBookProgressView()
{
    UILabel*    _titleLab;
    UILabel*    _percentLab;
    UIImageView* _progressBgView;
    UIImageView* _progressTrackView;
    UILabel*    _percentCountLab;
}

@end

@implementation CTAddrBookProgressView

- (id)initWithFrame:(CGRect)frame
{
    frame = [UIScreen mainScreen].bounds;
    frame.size.height = (iPhone5 ? 320 : 230);
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"addrbook_progress"]];
        self.autoresizingMask = UIViewAutoresizingFlexibleTopMargin;
        
        {
            UILabel* lab = [[UILabel alloc] initWithFrame:CGRectMake(15, 25, CGRectGetWidth(self.frame) - 30, 20)];
            lab.backgroundColor = [UIColor clearColor];
            lab.text = @"正在上传通讯录";
            lab.textAlignment = UITextAlignmentLeft;
            lab.textColor = [UIColor blackColor];
            lab.font = [UIFont systemFontOfSize:12];
            [lab sizeToFit];
            [self addSubview:lab];
            _titleLab = lab;
        }
        {
            UILabel* lab = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_titleLab.frame) + 5, 25, CGRectGetWidth(self.frame) - 30, 30)];
            lab.backgroundColor = [UIColor clearColor];
            lab.text = @"0%";
            lab.textAlignment = UITextAlignmentLeft;
            lab.textColor = [UIColor blackColor];
            lab.font = [UIFont systemFontOfSize:18];
            lab.center = CGPointMake(lab.center.x, _titleLab.center.y);
            [self addSubview:lab];
            _percentLab = lab;
        }
        {
            UIImage* img = [UIImage imageNamed:@"addrbook_progress_bg"];
            UIImageView* iv = [[UIImageView alloc] initWithImage:[img resizableImageWithCapInsets:UIEdgeInsetsMake(img.size.height/2, img.size.width/2, img.size.height/2, img.size.width/2)]];
            iv.frame = CGRectMake(CGRectGetMinX(_titleLab.frame), CGRectGetMaxY(_percentLab.frame) + 10,
                                  CGRectGetWidth(self.frame) - 2*CGRectGetMinX(_titleLab.frame), CGRectGetHeight(iv.frame));
            [self addSubview:iv];
            _progressBgView = iv;
        }
        {
            UIImage* img = [UIImage imageNamed:@"addrbook_progress_track"];
            UIImageView* iv = [[UIImageView alloc] initWithImage:[img resizableImageWithCapInsets:UIEdgeInsetsMake(img.size.height/2, img.size.width/2, img.size.height/2, img.size.width/2)]];
            iv.frame = CGRectMake(CGRectGetMinX(_titleLab.frame), CGRectGetMaxY(_percentLab.frame) + 10,
                                  0, CGRectGetHeight(iv.frame));
            iv.center = CGPointMake(iv.center.x, _progressBgView.center.y);
            [self addSubview:iv];
            _progressTrackView = iv;
        }
        {
            UILabel* lab = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMinX(_progressTrackView.frame),
                                                                     CGRectGetMaxY(_progressTrackView.frame)+5,
                                                                     CGRectGetWidth(self.frame) - 30, 20)];
            lab.backgroundColor = [UIColor clearColor];
            lab.text = @"";
            lab.textAlignment = UITextAlignmentRight;
            lab.textColor = [UIColor blackColor];
            lab.font = [UIFont systemFontOfSize:12];
            [self addSubview:lab];
            _percentCountLab = lab;
        }
        
        {
            int height = 50, offsetX = 50;
            UIButton* btn = [UIButton buttonWithType:UIButtonTypeCustom];
            btn.userInteractionEnabled = NO;
            btn.frame = CGRectMake(offsetX, CGRectGetHeight(self.frame) - height, CGRectGetWidth(self.frame) - offsetX, height);
            btn.autoresizingMask = UIViewAutoresizingFlexibleTopMargin;
            [btn setImage:[UIImage imageNamed:@"addrbook_logo"] forState:UIControlStateNormal];
            [btn setTitle:@"与号簿助手使用相同的云端存储\r\n电脑登入pim.189.cn管理云端通讯录" forState:UIControlStateNormal];
            [btn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
            [btn setTitleEdgeInsets:UIEdgeInsetsMake(0, 10, 0, 0)];
            [btn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
            [btn.titleLabel setFont:[UIFont systemFontOfSize:10]];
            btn.titleLabel.numberOfLines = 2;
            [btn.titleLabel sizeToFit];
            [self addSubview:btn];
        }
    }
    return self;
}

- (void)setProgress:(double)progress
{
    _progress = MIN(progress, 1.);
    [self performSelectorOnMainThread:@selector(refreshUI) withObject:nil waitUntilDone:YES];
}

- (void)refreshUI
{
    _progressTrackView.frame = CGRectMake(CGRectGetMinX(_progressTrackView.frame), CGRectGetMinY(_progressTrackView.frame),
                                          _progress*CGRectGetWidth(_progressBgView.frame), CGRectGetHeight(_progressTrackView.frame));
    _percentLab.text = [NSString stringWithFormat:@"%.0lf%%", _progress*100.];
    _percentCountLab.text = [NSString stringWithFormat:@"%d/%d", (int)(_progress*self.total), self.total];
}

- (void)setTitle:(NSString *)title
{
    _titleLab.text = title?title:@"";
}

@end
