//
//  ThreeSubView.h
//  NewKYT
//
//  Created by Y W on 13-11-27.
//  Copyright (c) 2013年 Y W. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ButtonSelectBlock)(void);

@interface ThreeSubView : UIView

@property (nonatomic, strong) UIButton *leftButton;
@property (nonatomic, strong) UIButton *centerButton;
@property (nonatomic, strong) UIButton *rightButton;

- (id)initWithFrame:(CGRect)frame leftButtonSelectBlock:(ButtonSelectBlock)leftButtonSelectBlock centerButtonSelectBlock:(ButtonSelectBlock)centerButtonSelectBlock  rightButtonSelectBlock:(ButtonSelectBlock)rightButtonSelectBlock;

- (void)setLeftButtonSelectBlock:(ButtonSelectBlock)leftButtonSelectBlock centerButtonSelectBlock:(ButtonSelectBlock)centerButtonSelectBlock  rightButtonSelectBlock:(ButtonSelectBlock)rightButtonSelectBlock;

- (void)autoLayout;
- (void)autoFit;

@end
