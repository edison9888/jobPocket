//
//  CanDoView.m
//  CTPocketV4
//
//  Created by 许忠洲 on 14-1-20.
//  Copyright (c) 2014年 广东亿迅科技有限公司. All rights reserved.
//

#import "CanDoView.h"

@interface CanDoView ()
@property (strong, nonatomic) UIButton *arrowDown;
@property (strong, nonatomic) UIButton *arrowUp;
@property (nonatomic) NSUInteger showAllHeight;
@property (strong, nonatomic) UIImageView *sepatator;
@property (nonatomic, strong) UIImageView *BgImageView;
@end

@implementation CanDoView

- (NSUInteger)showAllHeight
{
    if (!_showAllHeight) {
        _showAllHeight = 54;
    }
    return _showAllHeight;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        CGRect rect = frame;
        rect.size.width = 280;
        rect.size.height = 54;
        self.frame = rect;
        
        self.clipsToBounds = YES;
        
        UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(5, 0, 208, 54)];
        title.backgroundColor = [UIColor clearColor];
        title.font = [UIFont systemFontOfSize:15.0f];
        title.textColor = [UIColor blackColor];
        title.text = @"这个套餐能做什么";
        [self addSubview:title];
        
        self.arrowDown = [UIButton buttonWithType:UIButtonTypeCustom];
        self.arrowDown.frame = CGRectMake(0, 12, 280, 30);
        [self.arrowDown setBackgroundImage:[UIImage imageNamed:@"LeXiangPackage_arrow_down@2x"] forState:UIControlStateNormal];
        [self.arrowDown addTarget:self
                           action:@selector(showAllContent)
                 forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.arrowDown];
        
        self.sepatator = [[UIImageView alloc] initWithFrame:CGRectMake(0, self.bounds.size.height-1, self.bounds.size.width, 1)];
        self.sepatator.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin;
        self.sepatator.image = [UIImage imageNamed:@"LeXiangPackage_Separator.png"];
        [self addSubview:self.sepatator];
    }
    return self;
}

- (void)setContent:(NSDictionary *)Properties
{
    int originY = 54;
    
    UILabel *yyLabel = [[UILabel alloc] initWithFrame:CGRectMake(45, originY, 40, 14.0f)];
    yyLabel.backgroundColor = [UIColor clearColor];
    yyLabel.font = [UIFont systemFontOfSize:13.0f];
    yyLabel.textColor = [UIColor colorWithRed:0.44 green:0.77 blue:0.21 alpha:1];
    yyLabel.text = @"语音";
    [self addSubview:yyLabel];
    
    UILabel *yyCanDoLabel = [[UILabel alloc] initWithFrame:CGRectMake(109, originY, 120, 14.0f)];
    yyCanDoLabel.backgroundColor = [UIColor clearColor];
    yyCanDoLabel.font = [UIFont systemFontOfSize:13.0f];
    yyCanDoLabel.textColor = [UIColor blackColor];
    yyCanDoLabel.numberOfLines = 0;
    NSString *yy = Properties[@"TC_YY_CANDO"] ? Properties[@"TC_YY_CANDO"] : @" ";
    yyCanDoLabel.text = yy;
    [yyCanDoLabel sizeToFit];
    [self addSubview:yyCanDoLabel];
    
    originY = originY + yyCanDoLabel.frame.size.height + 8;
    
    UIImageView *separator1 = [[UIImageView alloc] initWithFrame:CGRectMake(16, originY, 280, 1)];
    separator1.image = [UIImage imageNamed:@"LeXiangPackage_Separator.png"];
//    [self addSubview:separator1];
    
    originY = originY + 9;
    
    //
    UILabel *llLabel = [[UILabel alloc] initWithFrame:CGRectMake(45, originY, 40, 14.0f)];
    llLabel.backgroundColor = [UIColor clearColor];
    llLabel.font = [UIFont systemFontOfSize:13.0f];
    llLabel.textColor = [UIColor colorWithRed:0.44 green:0.77 blue:0.21 alpha:1];
    llLabel.text = @"流量";
    [self addSubview:llLabel];
    
    UILabel *llCanDoLabel = [[UILabel alloc] initWithFrame:CGRectMake(109, originY, 120, 14.0f)];
    llCanDoLabel.backgroundColor = [UIColor clearColor];
    llCanDoLabel.font = [UIFont systemFontOfSize:13.0f];
    llCanDoLabel.textColor = [UIColor blackColor];
    llCanDoLabel.numberOfLines = 0;
    NSString *ll = Properties[@"TC_LL_CANDO"] ? Properties[@"TC_LL_CANDO"] : @" ";
    NSString *lll = [ll stringByReplacingOccurrencesOfString:@"<br>" withString:@"\n"];
    llCanDoLabel.text = lll;
    [llCanDoLabel sizeToFit];
    [self addSubview:llCanDoLabel];
    
    originY = originY + llCanDoLabel.frame.size.height + 8;
    
    UIImageView *separator2 = [[UIImageView alloc] initWithFrame:CGRectMake(16, originY, 280, 1)];
    separator2.image = [UIImage imageNamed:@"LeXiangPackage_Separator.png"];
//    [self addSubview:separator2];
    
    originY = originY + 9;
    
    //
    UILabel *dxLabel = [[UILabel alloc] initWithFrame:CGRectMake(45, originY, 40, 14.0f)];
    dxLabel.backgroundColor = [UIColor clearColor];
    dxLabel.font = [UIFont systemFontOfSize:13.0f];
    dxLabel.textColor = [UIColor colorWithRed:0.44 green:0.77 blue:0.21 alpha:1];
    dxLabel.text = @"短信";
    [self addSubview:dxLabel];
    
    UILabel *dxCanDoLabel = [[UILabel alloc] initWithFrame:CGRectMake(109, originY, 120, 14.0f)];
    dxCanDoLabel.backgroundColor = [UIColor clearColor];
    dxCanDoLabel.font = [UIFont systemFontOfSize:13.0f];
    dxCanDoLabel.textColor = [UIColor blackColor];
    dxCanDoLabel.numberOfLines = 0;
    NSString *dx = Properties[@"TC_DX_CANDO"] ? Properties[@"TC_DX_CANDO"] : @" ";
    dxCanDoLabel.text = dx;
    [dxCanDoLabel sizeToFit];
    [self addSubview:dxCanDoLabel];
    
    originY = originY + dxCanDoLabel.frame.size.height + 8;
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(13, originY, 280, 8)];
    imageView.image = [UIImage imageNamed:@"LeXiangPackage_arrow_up@2x"];
    [self addSubview:imageView];
    self.BgImageView = imageView ;
    
    
    self.arrowUp = [UIButton buttonWithType:UIButtonTypeCustom];
    self.arrowUp.frame = CGRectMake(13, originY, 235, 25);
    self.arrowUp.backgroundColor = [UIColor clearColor];
//    [self.arrowUp setBackgroundImage:[UIImage imageNamed:@"LeXiangPackage_arrow_up@2x"] forState:UIControlStateNormal];
    [self.arrowUp addTarget:self
                     action:@selector(hideSomeContent)
           forControlEvents:UIControlEventTouchUpInside];
    self.arrowUp.hidden = YES;
    [self addSubview:self.arrowUp];
    
    originY = originY + 8 + 8;
    self.showAllHeight = originY;
    //add by liuruxian 2014-02-25
//    [self showAllContent];
}

- (void)showAllContent
{
    self.arrowDown.hidden = YES;
    
    self.arrowUp.hidden = NO;
    
    CGRect rect = self.frame;
    rect.size.height = self.showAllHeight;
    self.frame = rect;
    
    self.sepatator.frame = CGRectMake(0, self.bounds.size.height-1, self.bounds.size.width, 1);
    
    if ([self.delegate respondsToSelector:@selector(resetCanDoContent)]) {
        [self.delegate resetCanDoContent];
    }
}

- (void)hideSomeContent
{
    self.arrowDown.hidden = NO;
    
    self.arrowUp.hidden = YES;
    
    CGRect rect = self.frame;
    rect.size.height = 54;
    self.frame = rect;
    
    self.sepatator.frame = CGRectMake(0, self.bounds.size.height-1, self.bounds.size.width, 1);
    
    if ([self.delegate respondsToSelector:@selector(resetCanDoContent)]) {
        [self.delegate resetCanDoContent];
    }
}

@end
