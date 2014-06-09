//
//  CTValueAddedView.m
//  CTPocketV4
//
//  Created by 许忠洲 on 13-11-25.
//  Copyright (c) 2013年 广东亿迅科技有限公司. All rights reserved.
//

#import "CTValueAddedView.h"

@interface CTValueAddedView ()
{
    UIImageView *_iconImage;
    UILabel *_prodName;
    UILabel *_price;
    UILabel *_detial;
    UIButton *_upDownBtn;
    BOOL _isShowAll;
}

@end

@implementation CTValueAddedView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor whiteColor];
        //self.bounds = CGRectMake(0, 0, 284, 104);
        
        _iconImage = [[UIImageView alloc] initWithFrame:CGRectMake(9, 16, 52, 52)];
        [self addSubview:_iconImage];
        
        _prodName = [[UILabel alloc] initWithFrame:CGRectMake(68, 12, 158, 24)];
        _prodName.backgroundColor = [UIColor clearColor];
        _prodName.font = [UIFont systemFontOfSize:13.0f];
        _prodName.textColor = [UIColor blackColor];
        [self addSubview:_prodName];
        
        _price = [[UILabel alloc] initWithFrame:CGRectMake(68, 36, 158, 24)];
        _price.backgroundColor = [UIColor clearColor];
        _price.font = [UIFont systemFontOfSize:13.0f];
        _price.textColor = [UIColor blackColor];
        [self addSubview:_price];
        
        self.orderBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        self.orderBtn.frame = CGRectMake(225, 12, 47, 25);
        [self.orderBtn setBackgroundImage:[UIImage imageNamed:@"valueAddedOrder"] forState:UIControlStateNormal];
        [self.orderBtn setTitle:@"订购" forState:UIControlStateNormal];
        [self.orderBtn addTarget:self action:@selector(onOrderAction) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.orderBtn];
        
        _detial = [[UILabel alloc] initWithFrame:CGRectMake(14, 76, 235, 16)];
        _detial.backgroundColor = [UIColor clearColor];
        _detial.font = [UIFont systemFontOfSize:13.0f];
        _detial.textColor = [UIColor blackColor];
        _detial.numberOfLines = 1;
        [self addSubview:_detial];
        
        _upDownBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _upDownBtn.frame = CGRectMake(253, 77, 24, 24);
        [_upDownBtn setBackgroundImage:[UIImage imageNamed:@"valueAddedDown"] forState:UIControlStateNormal];
        [_upDownBtn addTarget:self action:@selector(onUpDownAction) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_upDownBtn];
        
        _isShowAll = NO;
    }
    return self;
}

#pragma mark - Custom Methods

- (void)setContent:(NSDictionary *)dict AndTag:(int)tag
{
    self.tag = tag;
    
    int t = tag%3;
    switch (t) {
        case 0:
            _iconImage.image = [UIImage imageNamed:@"valueAddedIcon3"];
            break;
        case 1:
            _iconImage.image = [UIImage imageNamed:@"valueAddedIcon1"];
            break;
        case 2:
            _iconImage.image = [UIImage imageNamed:@"valueAddedIcon2"];
            break;
        default:
            break;
    }
    
    _prodName.text = dict[@"ProdName"];
    
    _price.text = dict[@"Price"];
    
    _detial.text = dict[@"Detial"];
}

- (void)setOrderBtnTitle:(NSString *)title
{
    [self.orderBtn setTitle:title forState:UIControlStateNormal];
}

- (void)onOrderAction
{
    if ([self.delegate respondsToSelector:@selector(didSelectOrderButton:)]) {
        [self.delegate didSelectOrderButton:self.tag];
    }
}

- (void)onUpDownAction
{
    if (_isShowAll)
    {
        // 收缩
        _isShowAll = NO;
        
        _detial.frame = CGRectMake(14, 76, 235, 16);
        _detial.numberOfLines = 1;
        
        CGRect rect = self.bounds;
        rect.size.height = 104;
        self.bounds = rect;
        
        [_upDownBtn setBackgroundImage:[UIImage imageNamed:@"valueAddedDown"] forState:UIControlStateNormal];
    }
    else
    {
        // 展开
        _isShowAll = YES;
        
        _detial.numberOfLines = 0;
        [_detial sizeToFit];
        
        CGRect rect = self.bounds;
        rect.size.height = 104+_detial.bounds.size.height-16;
        self.bounds = rect;
        
        [_upDownBtn setBackgroundImage:[UIImage imageNamed:@"valueAddedUp"] forState:UIControlStateNormal];
    }
    
    if ([self.delegate respondsToSelector:@selector(layoutAllViews:)]) {
        [self.delegate layoutAllViews:self];
    }
}

@end
