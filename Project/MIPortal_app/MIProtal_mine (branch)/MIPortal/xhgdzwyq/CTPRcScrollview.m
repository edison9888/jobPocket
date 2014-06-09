//
//  CTPRcScrollview.m
//  CTPocketv3
//
//  Created by mjlee on 13-4-11.
//  Copyright (c) 2013年 __MyCompanyName__. All rights reserved.
//

#import "CTPRcScrollview.h"

@interface CTPRcScrollview()

- (void)refresh;

@end

@implementation CTPRcScrollview

@synthesize scrollView = _scrollView;
@synthesize pageControl = _pageControl;
@synthesize currentPage = _curPage;
@synthesize datasource = _datasource;
@synthesize delegate = _delegate;

- (void)dealloc
{
    [self stopTimer];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor clearColor];
        _scrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
        _scrollView.backgroundColor = [UIColor clearColor];
        _scrollView.delegate = self;
        _scrollView.contentSize = CGSizeMake(self.bounds.size.width * 3, self.bounds.size.height);
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.contentOffset = CGPointMake(self.bounds.size.width, 0);
        _scrollView.pagingEnabled = YES;
        _scrollView.bounces = NO;
        [self addSubview:_scrollView];
        
        CGRect rect = self.bounds;
        rect.origin.y = rect.size.height - 30;
        rect.size.height = 30;
        _pageControl = [[UIPageControl alloc] initWithFrame:rect];
        _pageControl.userInteractionEnabled = NO;
        _pageControl.hidesForSinglePage = YES;
        
        [self addSubview:_pageControl];
        
        _curPage = 0;
    }
    return self;
}

- (void)setDataource:(id<CTPRcScrollViewDatasource>)datasource
{
    _datasource = datasource;
}

/*
- (int)validPageValue:(NSInteger)value {
    
    if(value == -1) value = _totalPages - 1;
    if(value == _totalPages) value = 0;
    
    return value;
    
}

- (void)getDisplayImagesWithCurpage:(int)page {
    
    if (!_datasource || [_datasource numberOfPages] <= 0)
    {
        return;
    }
    
    // 循环滚动
    int pre  = [self validPageValue:_curPage-1];
    int last = [self validPageValue:_curPage+1];
    
    if (!_curViews) {
        _curViews = [[NSMutableArray alloc] init];
    }
    
    [_curViews removeAllObjects];
    
    [_curViews addObject:[_datasource pageAtIndex:pre]];
    [_curViews addObject:[_datasource pageAtIndex:page]];
    [_curViews addObject:[_datasource pageAtIndex:last]];
}

- (void)loadData
{
    [self stopTimer];
    _pageControl.currentPage = _curPage;
    //从scrollView上移除所有的subview
    NSArray *subViews = [_scrollView subviews];
    if([subViews count] != 0) {
        [subViews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    }
    
    [self getDisplayImagesWithCurpage:_curPage];
    
    for (int i = 0; i < _curViews.count; i++) {
        UIView *v = [_curViews objectAtIndex:i];
        v.userInteractionEnabled = YES;
        v.frame = CGRectOffset(v.frame, v.frame.size.width * i, 0);
        [_scrollView addSubview:v];
        
        UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                    action:@selector(handleTap:)];
        [v addGestureRecognizer:singleTap];
    }
    
    _scrollView.contentSize = CGSizeMake((_totalPages <= 1 ? 0 : _curViews.count) * _scrollView.frame.size.width, 0);
    [_scrollView setContentOffset:CGPointMake(_scrollView.frame.size.width, 0)];
    
    if (_totalPages > 1)
    {
        [self performSelector:@selector(refresh) withObject:nil afterDelay:5.];
    }
}
- (void)reloadData
{
    [self stopTimer];
    _totalPages = [_datasource numberOfPages];
    if (_totalPages == 0) {
        return;
    }
    _pageControl.numberOfPages = _totalPages;
    [self loadData];
}

- (void)handleTap:(UITapGestureRecognizer *)tap {
    
    if ([_delegate respondsToSelector:@selector(didClickPage:atIndex:)]) {
        [_delegate didClickPage:self atIndex:_curPage];
    }
    
}

- (void)setViewContent:(UIView *)view atIndex:(NSInteger)index
{
    if (index == _curPage) {
        [_curViews replaceObjectAtIndex:1 withObject:view];
        for (int i = 0; i < 3; i++) {
            UIView *v = [_curViews objectAtIndex:i];
            v.userInteractionEnabled = YES;
            v.frame = CGRectOffset(v.frame, v.frame.size.width * i, 0);
            [_scrollView addSubview:v];
            
            UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                        action:@selector(handleTap:)];
            [v addGestureRecognizer:singleTap];
        }
    }
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)aScrollView {
    int x = aScrollView.contentOffset.x;
    
    if (_totalPages <= 1) {
        return;
    }
    
    //往下翻一张
    if(x >= (2*self.frame.size.width)) {
        _curPage = [self validPageValue:_curPage+1];
        [self loadData];
    }
    
    //往上翻
    if(x <= 0) {
        _curPage = [self validPageValue:_curPage-1];
        [self loadData];
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)aScrollView {
    
    [_scrollView setContentOffset:CGPointMake(_scrollView.frame.size.width, 0) animated:YES];
    
}

#pragma mark private
- (void)refresh
{
    [self stopTimer];
    
    if ([_curViews count] <= 1 ||
        _totalPages <= 1)
    {
		return;
	}
	
    _curPage = [self validPageValue:_curPage+1];
    [self loadData];
}

- (void)stopTimer
{
    [NSObject cancelPreviousPerformRequestsWithTarget:self];
//    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(refresh) object:nil];
}
*/

- (void)reloadData
{
    [self stopTimer];
    _totalPages = [_datasource numberOfPages];
    if (_totalPages == 0)
    {
        return;
    }
    _curPage = 0;
    _pageControl.numberOfPages = _totalPages;
    [self loadData];
}

- (void)loadData
{
    [self stopTimer];
    _pageControl.currentPage = _curPage;
    //从scrollView上移除所有的subview
    NSArray *subViews = [_scrollView subviews];
    if([subViews count] != 0)
    {
        [subViews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    }
    
    for (int i = 0; i < _totalPages; i++)
    {
        UIView *v = [_datasource pageAtIndex:i];
        v.userInteractionEnabled = YES;
        v.frame = CGRectOffset(v.frame, v.frame.size.width * i, 0);
        [_scrollView addSubview:v];
        
        UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                    action:@selector(handleTap:)];
        [v addGestureRecognizer:singleTap];
    }
    
    _scrollView.contentSize = CGSizeMake(_totalPages * _scrollView.frame.size.width, 0);
    [_scrollView setContentOffset:CGPointMake(_scrollView.frame.size.width*_curPage, 0)];
    
    [self startTimer];
}

- (void)handleTap:(UITapGestureRecognizer *)tap
{
    if ([_delegate respondsToSelector:@selector(didClickPage:atIndex:)])
    {
        [_delegate didClickPage:self atIndex:_curPage];
    }
}

#pragma mark private
- (void)refresh
{
    [self stopTimer];
    
    if (_totalPages <= 1)
    {
		return;
	}
	
    _curPage = [self validPageValue:_curPage+1];
    [self loadData];
}

- (int)validPageValue:(NSInteger)value
{
    if(value == -1) value = _totalPages - 1;
    if(value == _totalPages) value = 0;
    
    return value;
}

- (void)startTimer
{
    if (_totalPages > 1)
    {
        [self performSelector:@selector(refresh) withObject:nil afterDelay:5.];
    }
}

- (void)stopTimer
{
    [NSObject cancelPreviousPerformRequestsWithTarget:self];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [self stopTimer];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    if (!decelerate)
    {
        [self scrollViewDidEndDecelerating:scrollView];
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)aScrollView
{
    _curPage = aScrollView.contentOffset.x/aScrollView.frame.size.width;
    _pageControl.currentPage = _curPage;
    [self startTimer];
}

@end
