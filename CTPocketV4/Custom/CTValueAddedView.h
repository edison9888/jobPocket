//
//  CTValueAddedView.h
//  CTPocketV4
//
//  Created by 许忠洲 on 13-11-25.
//  Copyright (c) 2013年 广东亿迅科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CTValueAddedViewDelegate;
@interface CTValueAddedView : UIView
@property (nonatomic, weak) id<CTValueAddedViewDelegate> delegate;
@property (nonatomic, strong) UIButton *orderBtn;
- (void)setContent:(NSDictionary *)dict AndTag:(int)tag;
- (void)setOrderBtnTitle:(NSString *)title;
@end

@protocol CTValueAddedViewDelegate <NSObject>
@optional
- (void)didSelectOrderButton:(int)tag;
- (void)layoutAllViews:(CTValueAddedView *)view;
@end