//
//  RechargeTypeView.h
//  CTPocketV4
//
//  Created by apple on 13-10-31.
//  Copyright (c) 2013年 广东亿迅科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@class RechargeTypeView;
@protocol rechargeTypeDelegate <NSObject>

@optional

- (void) rechargeType : (int)Type ;

@end

@interface RechargeTypeView : UIView

@property (nonatomic, assign) int curChargeType ;
@property (nonatomic, assign) id<rechargeTypeDelegate> delegate;
@property (nonatomic, assign) int count;
@property (nonatomic, strong) NSArray *titleAry ;
@property (nonatomic, strong) NSArray *imageAry ;
@property (nonatomic, strong) UILabel *numLab;
@property (nonatomic, strong) UIImageView *numMarkImageView;
@property (nonatomic, strong) UIImageView *curSelectedImageView;
@property (nonatomic, strong) NSArray *msgAry;

- (void) selectedChargeType : (int) type;
- (void) setMsg : (NSDictionary *)dictionary;
- (void) initView : (NSArray *) imageArray title : (NSArray *) titleArray xOriginal : (float) xOriginal msgMark : (BOOL) mark;
@end
