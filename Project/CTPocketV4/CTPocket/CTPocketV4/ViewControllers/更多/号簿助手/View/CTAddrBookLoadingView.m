//
//  CTAddrBookLoadingView.m
//  CTPocketV4
//
//  Created by apple on 14-3-26.
//  Copyright (c) 2014年 广东亿迅科技有限公司. All rights reserved.
//

#import "CTAddrBookLoadingView.h"

@interface CTAddrBookLoadingView()
{
    UIActivityIndicatorView*    _activityView;
}

@end

@implementation CTAddrBookLoadingView

- (id)initWithFrame:(CGRect)frame
{
    frame = [UIScreen mainScreen].bounds;
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
        _activityView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
        _activityView.center = self.center;
        _activityView.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin;
        _activityView.hidesWhenStopped = YES;
        [self addSubview:_activityView];
    }
    return self;
}

- (void)startAnimate
{
    [_activityView startAnimating];
}

- (void)stopAnimate
{
    [_activityView stopAnimating];
}

@end
