//
//  CTScrollTopBtn.m
//  CTPocketV4
//
//  Created by Gong Xintao on 14-4-4.
//  Copyright (c) 2014年 广东亿迅科技有限公司. All rights reserved.
//

#import "CTScrollTopBtn.h"

@interface CTScrollTopBtn ()

@property(nonatomic,strong)BtnCTScrollToTopBlock selectBlock;

@end

@implementation CTScrollTopBtn

- (id)initWithFrame:(CGRect)frame selectBlock:(BtnCTScrollToTopBlock)selectBlock delegate:(id)delegate
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setBackgroundImage:[UIImage imageNamed:@"btn_scrolltotop_disable"] forState:UIControlStateNormal];
        self.selectBlock=selectBlock;
        [self addTarget:self action:@selector(action) forControlEvents:UIControlEventTouchUpInside];
        self.backgroundColor=[UIColor clearColor];
        
    }
    return self;
}

-(void)action
{
    self.selectBlock(self);
}

#pragma mark 使按钮失效
-(void)enable
{
    self.enabled=YES;
    [self setBackgroundImage:[UIImage imageNamed:@"btn_scrolltotop_enable"] forState:UIControlStateNormal];
}
#pragma mark 使按钮有效
-(void)disable
{
    self.enabled=NO;
    [self setBackgroundImage:[UIImage imageNamed:@"btn_scrolltotop_disable"] forState:UIControlStateNormal];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
