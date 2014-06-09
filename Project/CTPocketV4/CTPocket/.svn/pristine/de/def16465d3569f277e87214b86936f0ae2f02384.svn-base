//
//  ThreeSubView.m
//  NewKYT
//
//  Created by Y W on 13-11-27.
//  Copyright (c) 2013年 Y W. All rights reserved.
//

#import "ThreeSubView.h"

@interface ThreeSubView ()

@property (nonatomic, copy) ButtonSelectBlock leftBlock;
@property (nonatomic, copy) ButtonSelectBlock centerBlock;
@property (nonatomic, copy) ButtonSelectBlock rightBlock;

@end

@implementation ThreeSubView

- (id)initWithFrame:(CGRect)frame leftButtonSelectBlock:(ButtonSelectBlock)leftButtonSelectBlock centerButtonSelectBlock:(ButtonSelectBlock)centerButtonSelectBlock  rightButtonSelectBlock:(ButtonSelectBlock)rightButtonSelectBlock
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setLeftButtonSelectBlock:leftButtonSelectBlock centerButtonSelectBlock:centerButtonSelectBlock rightButtonSelectBlock:rightButtonSelectBlock];
    }
    return self;
}


- (void)buttonAutoLayout:(UIButton *)button
{
    UIFont *titleFont = button.titleLabel.font;
    CGFloat imageWidth = 0, titleWidth = 0, backgroundImageWidth = 0;
    
    imageWidth = [button imageForState:UIControlStateNormal].size.width;
    titleWidth = [[button titleForState:UIControlStateNormal] sizeWithFont:titleFont].width;
    backgroundImageWidth = [button backgroundImageForState:UIControlStateNormal].size.width;
    
    imageWidth = MAX(imageWidth, [button imageForState:UIControlStateSelected].size.width);
    titleWidth = MAX(titleWidth, [[button titleForState:UIControlStateSelected] sizeWithFont:titleFont].width);
    backgroundImageWidth = MAX(backgroundImageWidth, [button backgroundImageForState:UIControlStateSelected].size.width);
    
    imageWidth = MAX(imageWidth, [button imageForState:UIControlStateDisabled].size.width);
    titleWidth = MAX(titleWidth, [[button titleForState:UIControlStateDisabled] sizeWithFont:titleFont].width);
    backgroundImageWidth = MAX(backgroundImageWidth, [button backgroundImageForState:UIControlStateDisabled].size.width);
    
    imageWidth = MAX(imageWidth, [button imageForState:UIControlStateHighlighted].size.width);
    titleWidth = MAX(titleWidth, [[button titleForState:UIControlStateHighlighted] sizeWithFont:titleFont].width);
    backgroundImageWidth = MAX(backgroundImageWidth, [button backgroundImageForState:UIControlStateHighlighted].size.width);
    
    imageWidth = MAX(imageWidth, [button imageForState:UIControlStateApplication].size.width);
    titleWidth = MAX(titleWidth, [[button titleForState:UIControlStateApplication] sizeWithFont:titleFont].width);
    backgroundImageWidth = MAX(backgroundImageWidth, [button backgroundImageForState:UIControlStateApplication].size.width);
    
    imageWidth = MAX(imageWidth, [button imageForState:UIControlStateReserved].size.width);
    titleWidth = MAX(titleWidth, [[button titleForState:UIControlStateReserved] sizeWithFont:titleFont].width);
    backgroundImageWidth = MAX(backgroundImageWidth, [button backgroundImageForState:UIControlStateReserved].size.width);
    
    button.frame = CGRectMake(0, 0, ceilf(MAX(imageWidth + titleWidth, backgroundImageWidth)) + 1, self.frame.size.height);
}

- (void)setLeftButtonSelectBlock:(ButtonSelectBlock)leftButtonSelectBlock centerButtonSelectBlock:(ButtonSelectBlock)centerButtonSelectBlock  rightButtonSelectBlock:(ButtonSelectBlock)rightButtonSelectBlock
{
    self.leftBlock = leftButtonSelectBlock;
    self.centerBlock = centerButtonSelectBlock;
    self.rightBlock = rightButtonSelectBlock;
    
    if (!self.leftButton) {
        self.leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    }
    
    if (!self.centerButton) {
        self.centerButton = [UIButton buttonWithType:UIButtonTypeCustom];
    }
    
    if (!self.rightButton) {
        self.rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    }
    
    if (!self.leftBlock) {
        self.leftButton.enabled = NO;
    }
    
    if (!self.centerBlock) {
        self.centerButton.enabled = NO;
    }
    
    if (!self.rightBlock) {
        self.rightButton.enabled = NO;
    }
    
    [self.leftButton addTarget:self action:@selector(leftAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.centerButton addTarget:self action:@selector(centerAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.rightButton addTarget:self action:@selector(rightAction:) forControlEvents:UIControlEventTouchUpInside];
    
    [self addSubview:self.leftButton];
    [self addSubview:self.centerButton];
    [self addSubview:self.rightButton];
}

- (void)autoLayout
{
    int xOffset = 0;
    CGRect rect = CGRectZero;
    
    [self buttonAutoLayout:self.leftButton];
    rect = self.leftButton.frame;
    rect.origin.x = 0;
    self.leftButton.frame = rect;
    xOffset += self.leftButton.frame.size.width;
    
    [self buttonAutoLayout:self.centerButton];
    rect = self.centerButton.frame;
    rect.origin.x = xOffset;
    self.centerButton.frame = rect;
    xOffset += self.centerButton.frame.size.width;
    
    [self buttonAutoLayout:self.rightButton];
    rect = self.rightButton.frame;
    rect.origin.x = xOffset;
    self.rightButton.frame = rect;
    xOffset += self.rightButton.frame.size.width;
    
    rect = self.frame;
    rect.size.width = xOffset;
    self.frame = rect;
}

- (void)leftAction:(UIButton *)button
{
    if (self.leftBlock) {
        self.leftBlock();
    }
}

- (void)centerAction:(UIButton *)button
{
    if (self.centerBlock) {
        self.centerBlock();
    }
}

- (void)rightAction:(UIButton *)button
{
    if (self.rightBlock) {
        self.rightBlock();
    }
}


- (void)autoFit
{
    CGRect rect = self.frame;
    int buttonWidth = ceilf(CGRectGetWidth(rect)/3.0);
    int buttonHeight = ceilf(CGRectGetHeight(rect));
    CGRect buttonFrame = CGRectMake(0, 0, buttonWidth, buttonHeight);
    self.leftButton.frame = buttonFrame;
    
    buttonFrame.origin.x = buttonWidth;
    self.centerButton.frame = buttonFrame;
    
    buttonFrame.origin.x = CGRectGetMaxX(buttonFrame);
    buttonFrame.size.width = ceilf(CGRectGetWidth(rect) - CGRectGetMinX(buttonFrame));
    self.rightButton.frame = buttonFrame;
}

@end
