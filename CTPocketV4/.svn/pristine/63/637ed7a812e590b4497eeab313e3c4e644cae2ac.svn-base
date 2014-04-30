//
//  CTCustomIcon.m
//  CTPocketV4
//
//  Created by 许忠洲 on 13-11-6.
//  Copyright (c) 2013年 广东亿迅科技有限公司. All rights reserved.
//

#import "CTCustomIcon.h"

@implementation CTCustomIcon

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (id)initWithOrigin:(CGPoint)origin image:(UIImage *)iconImage hlImage:(UIImage *)iconImagehl title:(NSString *)title
{
    self = [super init];
    if (self) {
        // Initialization code
        
        self.frame = CGRectMake(origin.x, origin.y, 90, 70);
        
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 50, 90, 20)];
        titleLabel.backgroundColor = [UIColor clearColor];
        titleLabel.font =[UIFont systemFontOfSize:13.0f];
        titleLabel.textColor = [UIColor blackColor];
        titleLabel.textAlignment = UITextAlignmentCenter;
        titleLabel.text = title;
        [self addSubview:titleLabel];
        
        self.iconButton = [UIButton buttonWithType:UIButtonTypeCustom];
        self.iconButton.frame = CGRectMake(22, 4, 46, 46);
        [self.iconButton setBackgroundImage:iconImage forState:UIControlStateNormal];
        [self.iconButton setBackgroundImage:iconImagehl forState:UIControlStateHighlighted];
        [self addSubview:self.iconButton];
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
