//
//  CTAddrBookLogCell.m
//  CTPocketV4
//
//  Created by apple on 14-3-27.
//  Copyright (c) 2014年 广东亿迅科技有限公司. All rights reserved.
//

#import "CTAddrBookLogCell.h"
#import <QuartzCore/QuartzCore.h>

@interface CTAddrBookLogCell()
{
    UILabel*    _titleLab;
}

@end

@implementation CTAddrBookLogCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor   = [UIColor clearColor];
        {
            // 小绿点
            int width = 10;
            UIView* v = [[UIView alloc] initWithFrame:CGRectMake(0, (kCTAddrBookLogTableCellHight-10)/2, width, width)];
            v.backgroundColor = [UIColor colorWithRed:111/255. green:197/255. blue:55/255. alpha:1];
            v.clipsToBounds = YES;
            v.layer.cornerRadius = width/2;
            v.center = CGPointMake(21, v.center.y);
            [self addSubview:v];
        }
        
        {
            UILabel* lab = [[UILabel alloc] initWithFrame:CGRectMake(40, 0,CGRectGetWidth(self.frame) - 50, kCTAddrBookLogTableCellHight)];
            lab.backgroundColor = [UIColor clearColor];
            lab.textAlignment = UITextAlignmentLeft;
            lab.font = [UIFont systemFontOfSize:13];
            lab.textColor = [UIColor darkGrayColor];
            lab.numberOfLines = 2;
            [self addSubview:lab];
            _titleLab = lab;
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
    
    NSMutableString* text = [NSMutableString new];
    
    {
        NSDate* dt = [NSDate dateWithTimeIntervalSince1970:self.logInfo.time];
        NSDateFormatter* formatter = [NSDateFormatter new];
        [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        [text appendString:[formatter stringFromDate:dt]];
        [text appendString:@"   "];
    }
    
    if (self.logInfo.comment) {
        [text appendString:self.logInfo.comment];
    }
    
    _titleLab.text = text;
}

@end
