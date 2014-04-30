//
//  CTSelectPhoneNumberCell.m
//  CTPocketV4
//
//  Created by Y W on 14-3-19.
//  Copyright (c) 2014年 广东亿迅科技有限公司. All rights reserved.
//

#import "CTSelectPhoneNumberCell.h"

#import "UIColor+Category.h"

#define HorizonButtonStart 45
#define HorizonButtonDistance 10

@interface CTSelectPhoneNumberCell ()

@property (nonatomic, strong, readwrite) CTSelectButton *button;

@end


@implementation CTSelectPhoneNumberCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        {
            self.textLabel.text = @"号码";
            self.textLabel.textColor = [UIColor colorWithR:49 G:49 B:49 A:1];
            self.textLabel.font = [UIFont systemFontOfSize:12];
            self.textLabel.numberOfLines = 0;
            
            CGRect rect = self.contentView.bounds;
            rect.origin.x = HorizonButtonDistance;
            self.textLabel.textAlignment = NSTextAlignmentLeft;
            self.textLabel.frame = rect;
            
        }
        
       
        
        {
        
            
            __weak typeof(self)weakSelf = self;
            
            CTSelectButton *selectButton = [[CTSelectButton alloc] initWithFrame:CGRectMake(HorizonButtonStart, 1, 130, CGRectGetHeight(self.bounds)-2) selectBlock:^(id object) {
                __strong typeof(weakSelf)strongSelf = weakSelf;
                [strongSelf selectButtonAction];
            }];
            [selectButton setBackgroundImage:nil forState:UIControlStateSelected];
            [selectButton setTitleColor:[UIColor colorWithR:49 G:49 B:49 A:1] forState:UIControlStateNormal];
            [selectButton.titleLabel setFont:[UIFont systemFontOfSize:12]];
            [selectButton setTitle:@"去选号码" forState:UIControlStateNormal];
            [self.contentView addSubview:selectButton];
            
            
            self.button = selectButton;
            
        }
    }
    return self;
}

- (void)selectButtonAction
{
    [self.button setBackgroundImage:self.button.normalImage forState:UIControlStateNormal];
    if (self.selectBlock) {
        self.selectBlock(nil);
    }
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGRect rect = self.contentView.bounds;
    rect.origin.x = HorizonButtonDistance;
    rect.size.width = HorizonButtonStart - HorizonButtonDistance;
    self.textLabel.frame = rect;
    
    rect = self.button.frame;
    rect.origin.y=1;
    rect.size.height=CGRectGetHeight(self.bounds)-2;
    self.button.frame = rect;
}

@end
