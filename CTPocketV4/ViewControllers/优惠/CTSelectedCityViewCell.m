//
//  CTSelectedCityViewCell.m
//  CTPocketV4
//
//  Created by liuruxian on 14-1-13.
//  Copyright (c) 2014年 广东亿迅科技有限公司. All rights reserved.
//

#import "CTSelectedCityViewCell.h"

@interface CTSelectedCityViewCell ()

@property (nonatomic, strong) UILabel *cityNameLabel;


@end

@implementation CTSelectedCityViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        // Initialization code
        CGRect rect = self.frame ;
        rect.size.width = 320-12;
        rect.size.height = 37;
        self.frame = rect ;
        
        UILabel *titleLable = [[UILabel alloc] initWithFrame:CGRectMake(16, 0, 200, self.bounds.size.height)];
        titleLable.backgroundColor = [UIColor clearColor];
        titleLable.text = @"";
        titleLable.textColor = [UIColor blackColor];
        titleLable.font = [UIFont boldSystemFontOfSize:14];
        self.cityNameLabel = titleLable ;
        [self addSubview:titleLable];
        
        UIView *bottomLine = [[UIView alloc] initWithFrame:CGRectMake(1, 0, self.frame.size.width-2, 1)];
        bottomLine.backgroundColor = [UIColor colorWithRed:209/255. green:209/255. blue:209/255. alpha:1];
        [self addSubview:bottomLine];
    }
    return self;
}

- (void) setTitle : (NSString *) title
{
    self.cityNameLabel.text = title ;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
