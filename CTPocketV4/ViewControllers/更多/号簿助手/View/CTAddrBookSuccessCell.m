//
//  CTAddrBookSuccessCell.m
//  CTPocketV4
//
//  Created by apple on 14-3-27.
//  Copyright (c) 2014年 广东亿迅科技有限公司. All rights reserved.
//

#import "CTAddrBookSuccessCell.h"

@interface CTAddrBookSuccessCell()
{
    UIImageView*    _iconView;
    UILabel*        _titleLab;
}

@end

@implementation CTAddrBookSuccessCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        self.frame = CGRectMake(0, 0, kCTAddrBookSuccessTableCellWidth, kCTAddrBookSuccessTableCellHight);
        self.backgroundColor   = [UIColor clearColor];

        {
            UIView* v = [[UIView alloc] initWithFrame:self.bounds];
            v.backgroundColor = [UIColor colorWithRed:0.91 green:0.91 blue:0.91 alpha:1.00];
            self.selectedBackgroundView = v;
        }
        {
            UIImageView* iv = [[UIImageView alloc] initWithFrame:CGRectMake(15, 5, 0, 0)];
            [self addSubview:iv];
            _iconView = iv;
        }
        
        {
            UILabel* lab = [[UILabel alloc] initWithFrame:CGRectMake(65, 0, 200, kCTAddrBookSuccessTableCellHight)];
            lab.backgroundColor = [UIColor clearColor];
            lab.textAlignment = UITextAlignmentLeft;
            lab.font = [UIFont systemFontOfSize:13];
            lab.textColor = [UIColor darkGrayColor];
            [self addSubview:lab];
            _titleLab = lab;
        }
        
        {
            UIImage* arrow = [UIImage imageNamed:@"annotation_arrow"];
            UIImageView* iv = [[UIImageView alloc] initWithImage:arrow];
            iv.frame = CGRectMake(kCTAddrBookSuccessTableCellWidth - arrow.size.width - 10,
                                  (kCTAddrBookSuccessTableCellHight - arrow.size.height)/2,
                                  arrow.size.width, arrow.size.height);
            [self addSubview:iv];
        }
        
        {
            UIView * lineView        = [[UIView alloc] initWithFrame:CGRectMake(0, self.frame.size.height - 1, self.frame.size.width, 1)];
            lineView.backgroundColor = [UIColor colorWithRed:225/255. green:225/255. blue:225/255. alpha:1];
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
    
    _titleLab.text = self.title?self.title:@"";
    _iconView.image = self.icon;
    _iconView.frame = CGRectMake(CGRectGetMinX(_iconView.frame), CGRectGetMinY(_iconView.frame), self.icon.size.width, self.icon.size.height);
    _iconView.center = CGPointMake(_iconView.center.x, CGRectGetHeight(self.frame)/2);
}

@end
