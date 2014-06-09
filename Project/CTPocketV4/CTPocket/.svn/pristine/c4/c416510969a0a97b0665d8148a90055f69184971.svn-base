//
//  CTOrderRechargeVCtlerTableViewCell.h
//  CTPocketV4
//
//  Created by quan on 14-5-27.
//  Copyright (c) 2014年 广东亿迅科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CTOrderRechargeVCtlerTableViewCell;

@protocol CTOrderRechargeVCtlerTableViewCellDelegate <NSObject>

- (void)setSelectBtn:(CTOrderRechargeVCtlerTableViewCell *)cell;

@end

@interface CTOrderRechargeVCtlerTableViewCell : UITableViewCell

@property (nonatomic ,strong)UIImageView *iconImageView;
@property (nonatomic ,strong)UILabel     *payTypeLabel;
@property (nonatomic ,strong)UIButton    *selectBtn;
@property (nonatomic ,weak) id <CTOrderRechargeVCtlerTableViewCellDelegate> delegate;
- (void)setData:(NSDictionary*)dict;

@end
