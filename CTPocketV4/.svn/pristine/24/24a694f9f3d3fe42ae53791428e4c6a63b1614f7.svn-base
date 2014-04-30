//
//  CTSelectBar.m
//  CTPocketV4
//
//  Created by Y W on 14-3-24.
//  Copyright (c) 2014年 广东亿迅科技有限公司. All rights reserved.
//

#import "CTSelectBar.h"

#import "UIColor+Category.h"

#define DefaultSliderHeight 2

@interface CTSelectBar () <UIGestureRecognizerDelegate>

@end

@implementation CTSelectBar

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.sliderHeight = DefaultSliderHeight;
        {
            UIImageView *sliderView = [[UIImageView alloc] initWithFrame:CGRectMake(0, frame.size.height - self.sliderHeight, 1, self.sliderHeight)];
            sliderView.backgroundColor = [UIColor colorWithR:96 G:189 B:44 A:1];
            [self addSubview:sliderView];
            
            self.sliderView = sliderView;
        }
    }
    return self;
}

- (void)setItems:(NSArray *)items
{
    if (_items == items) {
        return;
    }
    _items = items;
    
    [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    CGFloat itemWidth = ceilf(CGRectGetWidth(self.frame)/items.count);
    CGFloat itemHeight = CGRectGetHeight(self.frame) - self.sliderHeight;
    
    for (UIView *itemView in items) {
        CGRect frame = CGRectMake(itemWidth * [items indexOfObject:itemView], 0, itemWidth, itemHeight);
        if (itemView == items.lastObject) {
            frame.size.width = CGRectGetWidth(self.frame) - CGRectGetMinX(frame);
        }
        itemView.frame = frame;
        [self addSubview:itemView];
        
        UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:nil];
        tapGestureRecognizer.delegate = self;
        [itemView addGestureRecognizer:tapGestureRecognizer];
        
        if ([items firstObject] == itemView) {
            [self selectView:itemView];
        }
    }
}

- (void)selectView:(UIView *)view
{
    if (self.selectBlock) {
        self.selectBlock(view);
    }
    
    if (self.sliderView.superview == nil) {
        [self addSubview:self.sliderView];
    }
    
    CGRect sliderFrame = self.sliderView.frame;
    sliderFrame.origin.x = CGRectGetMinX(view.frame);
    sliderFrame.size.width = CGRectGetWidth(view.frame);
    [UIView animateWithDuration:0.25 animations:^{
        self.sliderView.frame = sliderFrame;
    }];
}


#pragma mark - UIGestureRecognizerDelegate

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    CGPoint point = [gestureRecognizer locationInView:self];
    for (UIView *itemView in self.items) {
        if (point.x >= CGRectGetMinX(itemView.frame) && point.x <= CGRectGetMaxX(itemView.frame)) {
            [self selectView:itemView];
        }
    }
    return NO;
}

@end
