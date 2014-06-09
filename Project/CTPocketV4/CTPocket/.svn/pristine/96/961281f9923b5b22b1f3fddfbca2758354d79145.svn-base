//
//  CTFilterSalesCell.m
//  CTPocketV4
//
//  Created by Y W on 14-3-25.
//  Copyright (c) 2014年 广东亿迅科技有限公司. All rights reserved.
//

#import "CTFilterSalesCell.h"

#import "UIColor+Category.h"

#define ImageSize 90
#define DisImageSize 25
#define XStart 10
#define YStart 6
#define XDistance 15
#define LabelWidth 170
#define LabelHeight 18

@interface CTFilterSalesCell ()

@property (nonatomic, strong, readwrite) UIImageView *iconImageView;
@property (nonatomic, strong, readwrite) UIImageView *disIconImageView;
//@property (nonatomic, strong, readwrite) AutoScrollLabel *nameLabel;
//@property (nonatomic, strong, readwrite) AutoScrollLabel *disInfoLabel;
@property (nonatomic, strong, readwrite) ThreeSubView *priceThreeSubView;
@property (nonatomic, strong, readwrite) UIImageView *giftImageView;
@property (nonatomic, strong, readwrite) UILabel *giftLabel;
@property (nonatomic, strong, readwrite) UIView *separatorView;

@end


@implementation CTFilterSalesCell

+ (CGFloat)CellHeight
{
    return 102;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        {
            UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(XStart, YStart, ImageSize, ImageSize)];
            imageView.backgroundColor = [UIColor clearColor];
            [self.contentView addSubview:imageView];
            
            self.iconImageView = imageView;
        }
        
        
        {
            UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(ceilf(XStart + ImageSize - 3 * DisImageSize / 4.0), ceilf(YStart - DisImageSize / 4.0), DisImageSize, DisImageSize)];
            imageView.backgroundColor = [UIColor clearColor];
            [self.contentView addSubview:imageView];
            
            self.disIconImageView = imageView;
        }
        
        {
            UILabel *autoLB = [[UILabel alloc]initWithFrame:CGRectMake(XStart + ImageSize + XDistance, YStart, LabelWidth, LabelHeight*2)];
            autoLB.font = [UIFont boldSystemFontOfSize:14.0f];
            autoLB.backgroundColor = [UIColor clearColor];
            autoLB.textColor = [UIColor colorWithR:49 G:49 B:49 A:1];
            autoLB.textAlignment = UITextAlignmentLeft;
            autoLB.numberOfLines=2;
            [self.contentView addSubview:autoLB];
            
            self.nameLabel = autoLB;
        }
        
        {
            UILabel *autoLB = [[UILabel alloc]initWithFrame:CGRectMake(XStart + ImageSize + XDistance, YStart + LabelHeight*2, LabelWidth, LabelHeight)];
            autoLB.font = [UIFont boldSystemFontOfSize:14.0f];
            autoLB.backgroundColor = [UIColor clearColor];
            autoLB.textColor = [UIColor colorWithR:221 G:131 B:124 A:1];
            autoLB.textAlignment = UITextAlignmentLeft;
            [self.contentView addSubview:autoLB];
            
            self.disInfoLabel = autoLB;
        }
        
        UIColor *customGrayColor = [UIColor lightGrayColor];
        
        {
            ThreeSubView *threeSubView = [[ThreeSubView alloc] initWithFrame:CGRectMake(XStart + ImageSize + XDistance, YStart + LabelHeight * 3, 0, LabelHeight) leftButtonSelectBlock:nil centerButtonSelectBlock:nil rightButtonSelectBlock:nil];
            
            [threeSubView.leftButton.titleLabel setFont:[UIFont systemFontOfSize:12]];
            [threeSubView.leftButton setTitleColor:[customGrayColor copy] forState:UIControlStateNormal];
            [threeSubView.leftButton setTitle:@"特惠价：" forState:UIControlStateNormal];
            
            [threeSubView.centerButton.titleLabel setFont:[UIFont systemFontOfSize:16]];
            [threeSubView.centerButton setTitleColor:[UIColor colorWithR:233 G:71 B:53 A:1] forState:UIControlStateNormal];
            
            [threeSubView.rightButton.titleLabel setFont:[UIFont systemFontOfSize:12]];
            [threeSubView.rightButton setTitleColor:[customGrayColor copy] forState:UIControlStateNormal];
            [threeSubView.rightButton setTitle:@"元" forState:UIControlStateNormal];
            
            [self.contentView addSubview:threeSubView];
            
            self.priceThreeSubView = threeSubView;
        }
        
        {
            UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(XStart + ImageSize + XDistance, YStart + LabelHeight * 4, LabelHeight, LabelHeight)];
            imageView.backgroundColor = [UIColor clearColor];
            [self.contentView addSubview:imageView];
            
            self.giftImageView = imageView;
        }
        
        {
            UILabel *autoLB = [[UILabel alloc]initWithFrame:CGRectMake(XStart + ImageSize + XDistance + LabelHeight + 5, YStart + LabelHeight * 4, LabelWidth - LabelHeight - 5, LabelHeight)];
            autoLB.font = [UIFont boldSystemFontOfSize:14.0f];
            autoLB.backgroundColor = [UIColor clearColor];
            autoLB.textColor = [customGrayColor copy];
            autoLB.textAlignment = UITextAlignmentLeft;
            [self.contentView addSubview:autoLB];
            
            self.giftLabel = autoLB;
        }
        
        {
            UIView *mView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.frame), 1)];
            mView.backgroundColor = [customGrayColor copy];
            [self.contentView addSubview:mView];
            
            self.separatorView = mView;
        }
        {
            CGFloat imageW=16;
            CGFloat imageH=25;
            CGFloat imageX=CGRectGetWidth(self.contentView.bounds)-8-imageW;
            CGFloat imageY=([CTFilterSalesCell CellHeight]-imageH)/2;
            UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(imageX, imageY, imageW, imageH)];
            imageView.backgroundColor = [UIColor clearColor];
            imageView.image=[UIImage imageNamed:@"PhoneSearchIconArrowRight"];
            [self.contentView addSubview:imageView];
        }
    }
    return self;
}

-(void)prepareForReuse
{
    [super prepareForReuse];
//    [self.nameLabel scroll];
//    [self.disInfoLabel scroll];
//    [self.giftLabel scroll];
    
}
@end
