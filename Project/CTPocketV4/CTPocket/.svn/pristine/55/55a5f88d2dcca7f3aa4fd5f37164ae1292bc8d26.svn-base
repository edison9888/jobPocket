//
//  CTServiceHallCell.m
//  CTPocketV4
//
//  Created by apple on 13-11-19.
//  Copyright (c) 2013年 广东亿迅科技有限公司. All rights reserved.
//

#import "CTServiceHallCell.h"

static NSString * charArrayString = @"ABCDEFGHIJKLMNOPQRSTUVWXYZ";

@interface CTServiceHallCell()
{
    UILabel *       _nameLab;
    UILabel *       _addrLab;
    UIButton *      _distanceBtn;
}

@end

@implementation CTServiceHallCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        self.frame = CGRectMake(0, 0, kCTServiceHallTableCellWidth, kCTServiceHallTableCellHight);
        self.selectionStyle = UITableViewCellSelectionStyleGray;
        
        int originX = 10;
        int originY = 10;
        {
            UILabel * lab            = [[UILabel alloc] initWithFrame:CGRectMake(originX, originY, 150, 20)];
            lab.backgroundColor      = [UIColor clearColor];
            lab.font                 = [UIFont systemFontOfSize:14];
            lab.textColor            = [UIColor darkTextColor];
            lab.textAlignment        = UITextAlignmentLeft;
            lab.text                 = @"A 营业厅";
            [self addSubview:lab];
            _nameLab                 = lab;
        }
        {
            UILabel * lab            = [[UILabel alloc] initWithFrame:CGRectMake(originX + 16, CGRectGetMaxY(_nameLab.frame) + 10, 210, 20)];
            lab.backgroundColor      = [UIColor clearColor];
            lab.font                 = [UIFont systemFontOfSize:12];
            lab.textColor            = [UIColor darkTextColor];
            lab.textAlignment        = UITextAlignmentLeft;
            lab.text                 = @"地址";
            [self addSubview:lab];
            _addrLab                 = lab;
        }
        {
            UIImage * icon           = [UIImage imageNamed:@"annotation_list"];
            UIButton * btn           = [UIButton buttonWithType:UIButtonTypeCustom];
            btn.frame                = CGRectMake(CGRectGetMaxX(_nameLab.frame) + 10, CGRectGetMinY(_nameLab.frame), 70, 20);
            btn.userInteractionEnabled = NO;
            [btn setImage:icon forState:UIControlStateNormal];
            [btn setImageEdgeInsets:UIEdgeInsetsMake((CGRectGetHeight(btn.frame) - icon.size.height)/2,
                                                     0,
                                                     (CGRectGetHeight(btn.frame) - icon.size.height)/2,
                                                     CGRectGetWidth(btn.frame) - icon.size.width)];
            [btn setTitle:@"300米" forState:UIControlStateNormal];
            [btn setTitleEdgeInsets:UIEdgeInsetsMake(0, 5, 0, 0)];
            [btn setTitleColor:[UIColor darkTextColor] forState:UIControlStateNormal];
            [btn.titleLabel setFont:[UIFont systemFontOfSize:13]];
            [btn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
            [self addSubview:btn];
            _distanceBtn = btn;
        }
        {
            UIImageView * iv         = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"annotation_arrow"]];
            iv.frame                 = CGRectMake(CGRectGetWidth(self.frame) - iv.frame.size.width - 10,
                                                  (CGRectGetHeight(self.frame) - CGRectGetHeight(iv.frame))/2,
                                                  CGRectGetWidth(iv.frame),
                                                  CGRectGetHeight(iv.frame));
            [self addSubview:iv];
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
    
    NSMutableString * name = [NSMutableString string];
    if (self.tag < charArrayString.length)
    {
        [name appendFormat:@"%c ", [charArrayString characterAtIndex:self.tag]];
    }
    else
    {
        [name appendFormat:@"%d ", self.tag];
    }
    if ([self.serviceHallInfo objectForKey:@"name"])
    {
        [name appendString:[self.serviceHallInfo objectForKey:@"name"]];
    }
    _nameLab.text = name;
    
    _addrLab.text = @"";
    if ([self.serviceHallInfo objectForKey:@"addr"])
    {
        _addrLab.text    = [NSString stringWithFormat:@"地址: %@", [self.serviceHallInfo objectForKey:@"addr"]];
    }
    
    id distance = [self.serviceHallInfo objectForKey:@"distance"];
    [_distanceBtn setTitle:@"未知" forState:UIControlStateNormal];
    if (distance && [distance respondsToSelector:@selector(floatValue)])
    {
        if ([distance floatValue] < 1000)
        {
            [_distanceBtn setTitle:[NSString stringWithFormat:@"%@米", [self.serviceHallInfo objectForKey:@"distance"]] forState:UIControlStateNormal];
        }
        else
        {
            [_distanceBtn setTitle:[NSString stringWithFormat:@"%.2f公里", [[self.serviceHallInfo objectForKey:@"distance"] floatValue]/1000] forState:UIControlStateNormal];
        }
    }
}

@end
