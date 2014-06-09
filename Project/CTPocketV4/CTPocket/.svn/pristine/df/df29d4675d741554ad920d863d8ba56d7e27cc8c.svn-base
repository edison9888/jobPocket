//
//  CTDistancePickerView.m
//  CTPocketV4
//
//  Created by apple on 13-11-15.
//  Copyright (c) 2013年 广东亿迅科技有限公司. All rights reserved.
//

#import "CTDistancePickerView.h"

@interface CTDistancePickerView()
{
    NSArray *           _distanceTexts;
    NSArray *           _distances;
    int                 _selectIndex;
    
    UIImageView *       _arrowImage;
    UIScrollView *      _contentScroll;
}

@end

@implementation CTDistancePickerView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor    = [UIColor clearColor];
        _distanceTexts          = @[@"300米", @"500米", @"800米", @"1公里", @"2公里", @"3公里", @"5公里", @"10公里"];
        _distances              = @[@"300", @"500", @"800", @"1000", @"2000", @"3000", @"5000", @"10000"];
        self.distance           = _distances[0];
        
        {
            UIScrollView* v     = [[UIScrollView alloc] initWithFrame:CGRectMake(30, 0, CGRectGetWidth(frame) - 60, CGRectGetHeight(frame))];
            v.backgroundColor   = [UIColor clearColor];
            v.showsHorizontalScrollIndicator = NO;
            v.delegate          = (id<UIScrollViewDelegate>)self;
            v.decelerationRate  = 0;
            v.bounces           = NO;
            [self addSubview:v];
            _contentScroll      = v;
        }
        {
            int originX         = 0;
            UIImage * nimg      = [UIImage imageNamed:@"kilometer_btn_normal"];
            UIImage * simg      = [UIImage imageNamed:@"kilometer_btn_selected"];
            
            for (int i = 0; i < _distanceTexts.count; i++)
            {
                UIButton * btn  = [UIButton buttonWithType:UIButtonTypeCustom];
                btn.tag         = i + 1;
                btn.frame       = CGRectMake(originX, 0, nimg.size.width, 60);
                [btn setImage:nimg forState:UIControlStateNormal];
                [btn setImage:simg forState:UIControlStateSelected];
                [btn setImageEdgeInsets:UIEdgeInsetsMake(10,
                                                         0,
                                                         CGRectGetHeight(btn.frame) - 10 - nimg.size.height,
                                                         0)];
                [btn setTitle:[_distanceTexts objectAtIndex:i] forState:UIControlStateNormal];
                [btn setTitleColor:[UIColor darkTextColor] forState:UIControlStateNormal];
                [btn setTitleEdgeInsets:UIEdgeInsetsMake(nimg.size.height + 15,
                                                         -nimg.size.width,
                                                         0,
                                                         0)];
                [btn.titleLabel setFont:[UIFont systemFontOfSize:10]];
                [btn addTarget:self action:@selector(onKilometerBtn:) forControlEvents:UIControlEventTouchUpInside];
                if (i == 0)
                {
                    btn.selected = YES;
                    _selectIndex = btn.tag;
                }
                [_contentScroll addSubview:btn];
                originX          = CGRectGetMaxX(btn.frame);
                
                if (i != _distanceTexts.count - 1)
                {
                    UIImageView * iv = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"kilometer_btn_div"]];
                    iv.frame         = CGRectMake(originX,
                                                  (CGRectGetHeight(btn.frame) - CGRectGetHeight(iv.frame))/2,
                                                  CGRectGetWidth(iv.frame),
                                                  CGRectGetHeight(iv.frame));
                    [_contentScroll addSubview:iv];
                    originX          = CGRectGetMaxX(iv.frame);
                }
            }
            _contentScroll.contentSize = CGSizeMake(originX, 0);
        }
        
        {
            UIImage * img   = [UIImage imageNamed:@"arrow_right"];
            UIImageView * v = [[UIImageView alloc] initWithImage:img];
            v.frame         = CGRectMake((CGRectGetWidth(frame) - v.frame.size.width)/2,
                                         CGRectGetHeight(frame) - 30,
                                         v.frame.size.width,
                                         v.frame.size.height);
            [self addSubview:v];
            _arrowImage     = v;
        }
    }
    return self;
}

- (void)onKilometerBtn:(id)sender
{
    UIButton * btn = (UIButton *)sender;
    if (btn.tag == _selectIndex)
    {
        return;
    }

    btn.selected = YES;
    UIButton* prevBtn = (UIButton* )[_contentScroll viewWithTag:_selectIndex];
    if (prevBtn)
    {
        prevBtn.selected = NO;
    }
    
    _selectIndex = btn.tag;
    if (_selectIndex >= 1 && _selectIndex <= _distances.count)
    {
        self.distance = _distances[_selectIndex - 1];
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    if (!decelerate)
    {
        [self ensureScrollViewPosition:scrollView];
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [self ensureScrollViewPosition:scrollView];
}

- (void)ensureScrollViewPosition:(UIScrollView *)scrollView
{
    CGFloat page = scrollView.contentOffset.x/scrollView.frame.size.width;
    if (page >= 0.5)
    {
        [scrollView setContentOffset:CGPointMake(scrollView.contentSize.width - scrollView.frame.size.width, 0) animated:YES];
    }
    else
    {
        [scrollView setContentOffset:CGPointZero animated:YES];
    }
    
    [_arrowImage setImage:[UIImage imageNamed:(page >= 0.5 ? @"arrow_left" : @"arrow_right")]];
}

@end
