//
//  CTLoadingCell.m
//  CTPocketV4
//
//  Created by liuruxian on 14-2-11.
//  Copyright (c) 2014年 广东亿迅科技有限公司. All rights reserved.
//

#import "CTLoadingCell.h"

@implementation CTLoadingCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor clearColor];
        
        UIView *loadingView = [[UIView alloc] initWithFrame:self.bounds];
        loadingView.backgroundColor = [UIColor clearColor];
        [self addSubview:loadingView];
        loadingView.hidden = YES ;
        self.LoadingView = loadingView ;
        {
            self.spin = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
            [self.spin setFrame:CGRectMake(125,15, 20, 15)];
            [self.spin startAnimating];
            [self.LoadingView addSubview:self.spin];
            
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.spin.frame), (CGRectGetHeight(self.LoadingView.frame)-16)/2, 165, 16)];
            label.font = [UIFont systemFontOfSize:14];
            label.textColor = [UIColor grayColor];
            label.text = @"加载中...";
            label.backgroundColor = [UIColor clearColor];
            [self.LoadingView addSubview:label];
        }
    
        UIView *pushView = [[UIView alloc] initWithFrame:self.bounds];
        pushView.backgroundColor = [UIColor clearColor];
        [self addSubview:pushView];
        pushView.hidden = NO ;
        self.pushView = pushView ;
        {
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(115, (CGRectGetHeight(self.LoadingView.frame)-16)/2, 100, 16)];
            
            label.font = [UIFont systemFontOfSize:14];
            label.textColor = [UIColor grayColor];
            label.backgroundColor = [UIColor clearColor];
            label.text = @"上拉加载更多";
            [self.pushView addSubview:label];
        }
    }
    return self;
}

- (void) setView : (BOOL) isLoad
{
    if (isLoad) {
        self.LoadingView.hidden = NO;
        [self.spin startAnimating];
        self.pushView.hidden = YES ;
    } else {
        self.LoadingView.hidden = YES;
        self.pushView.hidden = NO ;
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setCellHeight:(CGFloat)height
{
    
}

@end
