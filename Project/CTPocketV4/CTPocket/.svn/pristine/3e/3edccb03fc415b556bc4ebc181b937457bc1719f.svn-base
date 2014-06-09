//
//  PropertiesView.m
//  CTPocketV4
//
//  Created by 许忠洲 on 14-1-20.
//  Copyright (c) 2014年 广东亿迅科技有限公司. All rights reserved.
//

#import "PropertiesView.h"

@interface PropertiesView ()
@property (strong, nonatomic) UILabel *TS_YY;
@property (strong, nonatomic) UILabel *TS_LL;
@property (strong, nonatomic) UILabel *TS_DX;
@property (strong, nonatomic) UILabel *TS_WIFI;
@property (strong, nonatomic) UILabel *TS_TCWZF;
@property (strong, nonatomic) UIButton *arrowUp;
@property (strong, nonatomic) UIButton *arrowDown;
@property (strong, nonatomic) UIImageView *sepatator;
@property (strong, nonatomic) UIImageView *arrowUpBgImageView;

@end


@implementation PropertiesView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        CGRect rect = frame;
        rect.size.width = 280;
        rect.size.height = 52;
        self.frame = rect;
        
        self.clipsToBounds = YES;
        
        self.TS_YY = [[UILabel alloc] initWithFrame:CGRectMake(5, 0, 57, 40)];
        self.TS_YY.backgroundColor = [UIColor clearColor];
        self.TS_YY.font = [UIFont systemFontOfSize:13.0f];
        self.TS_YY.textColor = [UIColor blackColor];
        self.TS_YY.textAlignment = UITextAlignmentCenter;
        self.TS_YY.numberOfLines = 2;
        [self addSubview:self.TS_YY];
        
        self.TS_LL = [[UILabel alloc] initWithFrame:CGRectMake(62+5, 0, 57, 40)];
        self.TS_LL.backgroundColor = [UIColor clearColor];
        self.TS_LL.font = [UIFont systemFontOfSize:13.0f];
        self.TS_LL.textColor = [UIColor blackColor];
        self.TS_LL.textAlignment = UITextAlignmentCenter;
        self.TS_LL.numberOfLines = 2;
        [self addSubview:self.TS_LL];
        
        self.TS_DX = [[UILabel alloc] initWithFrame:CGRectMake(124+5, 0, 57, 40)];
        self.TS_DX.backgroundColor = [UIColor clearColor];
        self.TS_DX.font = [UIFont systemFontOfSize:13.0f];
        self.TS_DX.textColor = [UIColor blackColor];
        self.TS_DX.textAlignment = UITextAlignmentCenter;
        self.TS_DX.numberOfLines = 2;
        [self addSubview:self.TS_DX];
        
        self.TS_WIFI = [[UILabel alloc] initWithFrame:CGRectMake(186+5, 0, 57, 40)];
        self.TS_WIFI.backgroundColor = [UIColor clearColor];
        self.TS_WIFI.font = [UIFont systemFontOfSize:13.0f];
        self.TS_WIFI.textColor = [UIColor blackColor];
        self.TS_WIFI.textAlignment = UITextAlignmentCenter;
        self.TS_WIFI.numberOfLines = 2;
        [self addSubview:self.TS_WIFI];
        
        self.arrowDown = [UIButton buttonWithType:UIButtonTypeCustom];
        self.arrowDown.frame = CGRectMake(0, 5, 280, 30);
        [self.arrowDown setBackgroundImage:[UIImage imageNamed:@"LeXiangPackage_arrow_down@2x"] forState:UIControlStateNormal];
        [self.arrowDown addTarget:self
                           action:@selector(showAllContent)
                 forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.arrowDown];
        
        self.sepatator = [[UIImageView alloc] initWithFrame:CGRectMake(0, self.bounds.size.height-1, self.bounds.size.width, 1)];
        self.sepatator.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin;
        self.sepatator.image = [UIImage imageNamed:@"LeXiangPackage_Separator.png"];
        [self addSubview:self.sepatator];
        
        self.TS_TCWZF = [[UILabel alloc] initWithFrame:CGRectMake(8, 52, 214, 0)];
        self.TS_TCWZF.backgroundColor = [UIColor clearColor];
        self.TS_TCWZF.font = [UIFont systemFontOfSize:13.0f];
        self.TS_TCWZF.textColor = [UIColor blackColor];
        self.TS_TCWZF.numberOfLines = 0;
        self.TS_TCWZF.hidden = YES;
        [self addSubview:self.TS_TCWZF];
        
        
        UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"LeXiangPackage_arrow_up@2x"]];
        imageView.frame = CGRectMake(13, 52, 235, 8);
        [self addSubview:imageView];
        self.arrowUpBgImageView = imageView ;
        
        self.arrowUp = [UIButton buttonWithType:UIButtonTypeCustom];
        self.arrowUp.frame = CGRectMake(13, 52, 235, 30);
        self.arrowUp.backgroundColor = [UIColor clearColor];
//        [self.arrowUp setBackgroundImage:[UIImage imageNamed:@"LeXiangPackage_arrow_up@2x"] forState:UIControlStateNormal];
        [self.arrowUp addTarget:self
                         action:@selector(hideSomeContent)
               forControlEvents:UIControlEventTouchUpInside];
        self.arrowUp.hidden = YES;
        [self addSubview:self.arrowUp];
    }
    return self;
}

- (void)setContent:(NSDictionary *)Properties
{
    if (Properties[@"TS_YY"]) {
        if ([Properties[@"TS_YY"] hasPrefix:@"BD:"]) {
            self.TS_YY.text = [NSString stringWithFormat:@"本地语音\n%@分钟", [Properties[@"TS_YY"] stringByReplacingOccurrencesOfString:@"BD:" withString:@""]];
        }
        else if ([Properties[@"TS_YY"] hasPrefix:@"GN:"]) {
            self.TS_YY.text = [NSString stringWithFormat:@"国内语音\n%@分钟", [Properties[@"TS_YY"] stringByReplacingOccurrencesOfString:@"GN:" withString:@""]];
        }
    }
    else {
        self.TS_YY.text = @"语音\n0分钟";
    }
    
    NSString *ll = Properties[@"TS_LL"] ? Properties[@"TS_LL"] : @"";
    self.TS_LL.text = [NSString stringWithFormat:@"3G流量\n%@", ll];
    
    NSString *dx = Properties[@"TS_DX"] ? Properties[@"TS_DX"] : @"";
    NSString *cx = Properties[@"TS_CX"] ? Properties[@"TS_CX"] : @"";
    self.TS_DX.text = [NSString stringWithFormat:@"短/彩信\n%@/%@条", dx, cx];
    
    NSString *wifi = Properties[@"TS_WIFI"] ? Properties[@"TS_WIFI"] : @"";
    self.TS_WIFI.text = [NSString stringWithFormat:@"WIFI时长\n%@小时", wifi];
    
    NSString *tcwzf = Properties[@"TS_TCWZF"] ? Properties[@"TS_TCWZF"] : @"";
    self.TS_TCWZF.text = tcwzf;
    self.TS_TCWZF.numberOfLines = 0;
    [self.TS_TCWZF sizeToFit];
    
    self.arrowUp.frame = CGRectMake(13, self.TS_TCWZF.frame.origin.y+self.TS_TCWZF.frame.size.height+8, 235, 20);
    self.arrowUpBgImageView.frame = CGRectMake(13, self.TS_TCWZF.frame.origin.y+self.TS_TCWZF.frame.size.height+10, 235, 8);
}

- (void)showAllContent
{
    self.arrowDown.hidden = YES;
    
    self.TS_TCWZF.hidden = NO;
    self.arrowUp.hidden = NO;
    CGRect rect = self.frame;
    rect.size.height = self.arrowUp.frame.origin.y + self.arrowUp.frame.size.height;
    self.frame = rect;
    
    self.sepatator.frame = CGRectMake(0, self.bounds.size.height-1, self.bounds.size.width, 1);
    
    if ([self.delegate respondsToSelector:@selector(resetPropertiesContent)]) {
        [self.delegate resetPropertiesContent];
    }
}

- (void)hideSomeContent
{
    self.arrowDown.hidden = NO;
    
    self.TS_TCWZF.hidden = YES;
    self.arrowUp.hidden = YES;
    CGRect rect = self.frame;
    rect.size.height = 52;
    self.frame = rect;
    
    self.sepatator.frame = CGRectMake(0, self.bounds.size.height-1, self.bounds.size.width, 1);
    
    if ([self.delegate respondsToSelector:@selector(resetPropertiesContent)]) {
        [self.delegate resetPropertiesContent];
    }
}

@end
