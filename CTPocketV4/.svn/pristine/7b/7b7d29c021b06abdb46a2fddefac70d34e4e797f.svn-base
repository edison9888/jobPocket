//
//  CTPointExchangeCell.m
//  CTPocketV4
//
//  Created by Y W on 14-3-10.
//  Copyright (c) 2014年 广东亿迅科技有限公司. All rights reserved.
//

#import "CTPointExchangeCell.h"

#import "UIImage+Category.h"
#import "UIColor+Category.h"

static CGRect imageViewRect = {{10,10},{40,40}};

#define kOriginX 60 
#define kOriginY 10
@interface CTPointExchangeCell ()

@property (nonatomic, readwrite, strong) UILabel *titleLabel;
@property (nonatomic, readwrite, strong) ThreeSubView *subTitleLabel;
@property (nonatomic, strong) UIButton *exchangeButton;
@property (nonatomic, strong) UIView *separatorView;

@end

@implementation CTPointExchangeCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {

        self.backgroundColor = [UIColor clearColor];
        self.backgroundView = nil;
        
        {
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(kOriginX,
                                                                                       kOriginY,
                                                                                       180,
                                                                                       20)];
            label.backgroundColor = [UIColor clearColor];
            label.font = [UIFont systemFontOfSize:15];
            label.textColor = [UIColor colorWithR:49 G:49 B:49 A:1];
//            label.text = @"哈根达斯哈根萨斯";
            [self.contentView addSubview:label];
            
            self.titleLabel = label;
        }
        
        {
            ThreeSubView *threeSubView = [[ThreeSubView alloc] initWithFrame:CGRectZero leftButtonSelectBlock:nil centerButtonSelectBlock:nil rightButtonSelectBlock:nil];
            
            [threeSubView.centerButton.titleLabel setFont:[UIFont boldSystemFontOfSize:13]];
            [threeSubView.centerButton setTitleColor:[UIColor colorWithR:95 G:189 B:42 A:1] forState:UIControlStateNormal];
//            [threeSubView.centerButton setTitle:@"10000" forState:UIControlStateNormal];
            
            [threeSubView.rightButton.titleLabel setFont:[UIFont systemFontOfSize:13]];
            [threeSubView.rightButton setTitleColor:[UIColor colorWithR:49 G:49 B:49 A:1] forState:UIControlStateNormal];
            [threeSubView.rightButton setTitle:@"积分" forState:UIControlStateNormal];
            
            [self.contentView addSubview:threeSubView];
            
            self.subTitleLabel = threeSubView;
        }
        
        {
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            button.backgroundColor = [UIColor clearColor];
            [button setBackgroundImage:[UIImage imageWithColor:[UIColor colorWithR:95 G:189 B:42 A:1] cornerRadius:5] forState:UIControlStateNormal];
            [button setBackgroundImage:[UIImage imageWithColor:[UIColor colorWithR:95 G:189 B:42 A:1] cornerRadius:5] forState:UIControlStateDisabled];
            [button setTitle:@"兑换" forState:UIControlStateNormal];
            [button.titleLabel setFont:[UIFont systemFontOfSize:15]];
            [self.contentView addSubview:button];
            
            self.exchangeButton = button;
        }
        
        {
            UIView *view = [[UIView alloc] init];
            view.backgroundColor = [UIColor colorWithRed:0.84f green:0.84f blue:0.84f alpha:1.00f];
            [self.contentView addSubview:view];
            
            self.separatorView = view;
        }
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    int xOffset = 60, yOffset = 10;
    
    self.imageView.frame = imageViewRect;
    
    self.titleLabel.frame = CGRectMake(xOffset, yOffset, 180, 20);
    
    [self.subTitleLabel autoLayout];
    CGRect rect = self.subTitleLabel.frame;
    rect.origin.x = xOffset;
    rect.origin.y = CGRectGetMaxY(self.titleLabel.frame) + 15;
    self.subTitleLabel.frame = rect;
    
    rect = self.contentView.bounds;
    self.exchangeButton.frame = CGRectMake(rect.size.width - 10 - 60, ceilf((rect.size.height - 30)/2.0), 60, 30);
    
    xOffset = 10;
    self.separatorView.frame = CGRectMake(xOffset, CGRectGetHeight(rect) - 1, CGRectGetWidth(rect) - 2 * xOffset, 1);
}

@end
