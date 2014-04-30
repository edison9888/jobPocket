//
//  HeaderView.m
//  CTPocketV4
//
//  Created by liuruxian on 14-1-13.
//  Copyright (c) 2014年 广东亿迅科技有限公司. All rights reserved.
//

#import "HeaderView.h"

@interface HeaderView ()

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) UILabel *cityNameLabel;

@end


@implementation HeaderView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        frame.size.width = 320;
        frame.size.height = [HeaderView headerHeight];
        frame.origin.x = 6;
        self.frame = frame;
        
        UIImage *image = [UIImage imageNamed:@"prettyNum_section_bg.png"];
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:self.bounds];
        imageView.backgroundColor = [UIColor clearColor];
        imageView.image = image ;
        [self addSubview:imageView];
        
        UIView *topLine = [[UIView alloc] initWithFrame:CGRectMake(1, 0, frame.size.width-2, 1)];
        topLine.backgroundColor = [UIColor colorWithRed:209/255. green:209/255. blue:209/255. alpha:1];
        [self addSubview:topLine];
        
        UILabel *titleLable = [[UILabel alloc] initWithFrame:CGRectMake(16, 0, 100, self.bounds.size.height)];
        titleLable.backgroundColor = [UIColor clearColor];
        titleLable.text = @"";
        titleLable.textColor = [UIColor blackColor];
        titleLable.font = [UIFont boldSystemFontOfSize:14];
        self.cityNameLabel = titleLable ;
        [self addSubview:titleLable];
        
//        UIView *bottomLine = [[UIView alloc] initWithFrame:CGRectMake(1, frame.size.height-1, frame.size.width-2, 1)];
//        bottomLine.backgroundColor = [UIColor colorWithRed:209/255. green:209/255. blue:209/255. alpha:1];
//        [self addSubview:bottomLine];
    }
    return self;
}

+ (CGFloat) headerHeight
{
    return 37;
}

- (void) setTitle : (NSString *) title
{
    self.cityNameLabel.text = title ;
//    self.cityNameLabel.textAlignment = UITextAlignmentCenter ;
//    self.cityNameLabel.numberOfLines = 0;
//    [self.cityNameLabel sizeToFit];
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
