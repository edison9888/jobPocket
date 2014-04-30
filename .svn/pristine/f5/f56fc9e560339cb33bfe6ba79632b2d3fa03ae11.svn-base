//
//  CTWifiLoadingView.m
//  CTPocketV4
//
//  Created by apple on 13-11-18.
//  Copyright (c) 2013年 广东亿迅科技有限公司. All rights reserved.
//

#import "CTWifiLoadingView.h"
#import "CTWifiCell.h"

@implementation CTWifiLoadingView

- (id)initWithFrame:(CGRect)frame
{
    frame.size.height = kCTWifiTableCellHight;
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor clearColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        {
            UIActivityIndicatorView * v = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
            v.frame                     = CGRectMake(60, (CGRectGetHeight(frame) - CGRectGetHeight(v.frame))/2, CGRectGetWidth(v.frame), CGRectGetHeight(v.frame));
            v.hidesWhenStopped          = YES;
            [v startAnimating];
            [self addSubview:v];
        }
        {
            UILabel * lab            = [[UILabel alloc] initWithFrame:self.bounds];
            lab.backgroundColor      = [UIColor clearColor];
            lab.font                 = [UIFont systemFontOfSize:14];
            lab.textColor            = [UIColor darkTextColor];
            lab.textAlignment        = UITextAlignmentCenter;
            lab.text                 = @"加载中...";
            lab.autoresizingMask     = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
            [self addSubview:lab];
        }
    }
    return self;
}

@end
