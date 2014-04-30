//
//  CTSelectButton.m
//  CTPocketV4
//
//  Created by Y W on 14-3-20.
//  Copyright (c) 2014年 广东亿迅科技有限公司. All rights reserved.
//

#import "CTSelectButton.h"

NSString * const CTSelectButtonSelectNotification = @"CTSelectButtonSelectNotification";

@interface CTSelectButton ()

@property (nonatomic, readwrite, copy) CTSelectButtonSelectBlock selectBlock;

@property (nonatomic, strong, readwrite) UIImage *normalImage;
@property (nonatomic, strong, readwrite) UIImage *selectImage;

@end


@implementation CTSelectButton

- (id)initWithFrame:(CGRect)frame selectBlock:(CTSelectButtonSelectBlock)selectBlock
{
    self = [super initWithFrame:frame];
    if (self) {
        self.selectBlock = selectBlock;
        UIImage *normalImage = [UIImage imageNamed:@"LeXiangPackage_Service"];
        UIImage *selectImage = [UIImage imageNamed:@"WriteOrderInfo_btn_selected"];
        
        self.normalImage = [normalImage resizableImageWithCapInsets:UIEdgeInsetsMake(5, 5, 5, 5)];
        self.selectImage = [selectImage resizableImageWithCapInsets:UIEdgeInsetsMake(5, 5, 5, 20)];
        
        [self setBackgroundImage:normalImage forState:UIControlStateNormal];
        
        [self addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(buttonSelectNotification:) name:CTSelectButtonSelectNotification object:nil];
    }
    return self;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)buttonAction:(UIButton *)button
{
    [[NSNotificationCenter defaultCenter] postNotificationName:CTSelectButtonSelectNotification object:self];
    if (self.selectBlock) {
        self.selectBlock(self.object);
    }
}

- (void)buttonSelectNotification:(NSNotification *)notification
{
    UIButton *button = [notification object];
    if ([button isKindOfClass:[UIButton class]]) {
        if (button == self) {
            [self setBackgroundImage:self.selectImage forState:UIControlStateNormal];
        } else {
            if (button.superview == self.superview) {
                [self setBackgroundImage:self.normalImage forState:UIControlStateNormal];
            }
        }
    }
}

@end
