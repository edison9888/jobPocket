//
//  CTFilterSalesCell.h
//  CTPocketV4
//
//  Created by Y W on 14-3-25.
//  Copyright (c) 2014年 广东亿迅科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ThreeSubView.h"
#import "AutoScrollLabel.h"

@interface CTFilterSalesCell : UITableViewCell

@property (nonatomic, strong, readonly) UIImageView *iconImageView;
@property (nonatomic, strong, readonly) UIImageView *disIconImageView;
//@property (nonatomic, strong, readonly) AutoScrollLabel *nameLabel;
//@property (nonatomic, strong, readonly) AutoScrollLabel *disInfoLabel;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *disInfoLabel;

@property (nonatomic, strong, readonly) ThreeSubView *priceThreeSubView;
@property (nonatomic, strong, readonly) UIImageView *giftImageView;
@property (nonatomic, strong, readonly) UILabel *giftLabel;
@property (nonatomic, strong, readonly) UIView *separatorView;

+ (CGFloat)CellHeight;

@end
