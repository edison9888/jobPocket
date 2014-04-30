//
//  CTCustomPagesCell.m
//  CTPocketV4
//
//  Created by 许忠洲 on 13-11-4.
//  Copyright (c) 2013年 广东亿迅科技有限公司. All rights reserved.
//

#import "CTCustomPagesCell.h"

#define CTCustomPagesCellHeight 49.0f

@interface CTCustomPagesCell ()

@property (strong, nonatomic) UIImageView *icon;
@property (strong, nonatomic) UILabel *title;
@property (strong, nonatomic) UIImageView *customIcon;

@end

@implementation CTCustomPagesCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = [UIColor clearColor];
        
#if 0
        // separatorV
        UIImageView *separatorV = [[UIImageView alloc] initWithFrame:CGRectMake(34, 0, 1, 48)];
        separatorV.image = [UIImage imageNamed:@"custom_separatorV"];
        [self.contentView addSubview:separatorV];
#endif
        
        // icon
        self.icon = [[UIImageView alloc] initWithFrame:CGRectMake(20, 10, 28, 28)];
        [self.contentView addSubview:self.icon];
        
        // title
        self.title = [[UILabel alloc] initWithFrame:CGRectMake(58, 0, 200, 48)];
        self.title.backgroundColor = [UIColor clearColor];
        self.title.font = [UIFont systemFontOfSize:15.0f];
        self.title.textColor = [UIColor blackColor];
        [self.contentView addSubview:self.title];
        
        // button
        self.customIcon = [[UIImageView alloc] initWithFrame:CGRectMake(275, 12, 25, 25)];
        self.customIcon.image = [UIImage imageNamed:@"custom_Icon_add"];
        [self.contentView addSubview:self.customIcon];
        
        // separator
        UIImageView *separator = [[UIImageView alloc] initWithFrame:CGRectMake(10, 48, 300, 1)];
        separator.image = [UIImage imageNamed:@"custom_separator"];
        [self.contentView addSubview:separator];
    }
    return self;
}

- (void)setCellInfo:(NSDictionary *)info selectedIconsArray:(NSArray *)array
{
    self.icon.image = [UIImage imageNamed:info[@"icon"]];
    self.title.text = info[@"title"];
    
    BOOL isSelectd = NO;
    for (NSDictionary *dict in array) {
        if ([dict[@"title"] isEqualToString:info[@"title"]]) {
            isSelectd = YES;
            break;
        }
    }
    if (isSelectd) {
        self.customIcon.image = [UIImage imageNamed:@"custom_Icon_delete"];
    }
    else
    {
        self.customIcon.image = [UIImage imageNamed:@"custom_Icon_add"];
    }
}

@end
