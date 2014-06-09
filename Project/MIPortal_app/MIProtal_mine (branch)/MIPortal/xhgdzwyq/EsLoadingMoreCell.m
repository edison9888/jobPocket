//
//  EsLoadingMoreCell.m
//  xhgdzwyq
//
//  Created by apple on 13-12-1.
//  Copyright (c) 2013年 Eshore. All rights reserved.
//

#import "EsLoadingMoreCell.h"

@implementation EsLoadingMoreCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor clearColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        {
            UIActivityIndicatorView * v = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:([Global sharedSingleton].uiStyle.mode == UIStyleModeDay ? UIActivityIndicatorViewStyleGray : UIActivityIndicatorViewStyleWhite)];
            v.frame                     = CGRectMake(60, (CGRectGetHeight(self.frame) - CGRectGetHeight(v.frame))/2, CGRectGetWidth(v.frame), CGRectGetHeight(v.frame));
            v.hidesWhenStopped          = YES;
            v.autoresizingMask          = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin;
            [v startAnimating];
            [self addSubview:v];
        }
        {
            UILabel * lab            = [[UILabel alloc] initWithFrame:self.bounds];
            lab.backgroundColor      = [UIColor clearColor];
            lab.font                 = [UIFont systemFontOfSize:14];
            lab.textColor            = ([Global sharedSingleton].uiStyle.mode == UIStyleModeDay ? [UIColor darkTextColor] : RGB(0x99, 0x99, 0x99, 1));
            lab.textAlignment        = UITextAlignmentCenter;
            lab.text                 = @"加载中...";
            lab.autoresizingMask     = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
            [self addSubview:lab];
        }
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
