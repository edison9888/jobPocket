//
//  CTLoadMoreCell.m
//  CTPocketV4
//
//  Created by apple on 13-11-12.
//  Copyright (c) 2013年 广东亿迅科技有限公司. All rights reserved.
//

#import "CTLoadMoreCell.h"

@implementation CTLoadMoreCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor clearColor];
        
        
        
        self.spin = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        [self.spin setFrame:CGRectMake(90,12, 20, 20)];
        [self.spin startAnimating];
        [self addSubview:self.spin];
        
        self.textLabel.font = [UIFont systemFontOfSize:14];
        self.textLabel.textColor = [UIColor grayColor];
        self.textLabel.textAlignment = UITextAlignmentCenter;
        self.textLabel.text = @"加载中...";
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setCellHeight:(CGFloat)height
{
    // 调整UIActivityIndicatorView位置
    [self.spin setFrame:CGRectMake(100, (height-20)/2, 20, 20)];
}

@end
