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

- (void)dealloc
{
    [self stopTimer];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        _scrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
        _scrollView.delegate = self;
        _scrollView.contentSize = CGSizeMake(self.bounds.size.width * 3, self.bounds.size.height);
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.contentOffset = CGPointMake(self.bounds.size.width, 0);
        _scrollView.pagingEnabled = YES;
        [self addSubview:_scrollView];
        
        CGRect rect = self.bounds;
        rect.origin.y = rect.size.height - 30;
        rect.size.height = 30;
        _pageControl = [[UIPageControl alloc] initWithFrame:rect];
        _pageControl.userInteractionEnabled = NO;
        
        [self addSubview:_pageControl];
        
        _curPage = 0;
    }
    return self;
}

- (int)validPageValue:(NSInteger)value {
    
    if(value == -1) value = _totalPages - 1;
    if(value == _totalPages) value = 0;
    
    return value;
    
}

- (void)getDisplayImagesWithCurpage:(int)page {
    
    int pre  = [self validPageValue:_curPage-1];
    int last = [self validPageValue:_curPage+1];
    
    if (!_curViews) {
        _curViews = [[NSMutableArray alloc] init];
    }
    
    [_curViews removeAllObjects];
    
    if (!_datasource) {
        return;
    }
    [_curViews addObject:[_datasource pageAtIndex:pre]];
    [_curViews addObject:[_datasource pageAtIndex:page]];
    [_curViews addObject:[_datasource pageAtIndex:last]];
}

- (void)loadData
{
    _pageControl.currentPage = _curPage;
    
    //从scrollView上移除所有的subview
    NSArray *subViews = [_scrollView subviews];
    if([subViews count] != 0) {
        [subViews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    }
    
    [self getDisplayImagesWithCurpage:_curPage];
    
    if (_curViews.count > 0) {
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
    
    [_scrollView setContentOffset:CGPointMake(_scrollView.frame.size.width, 0)];
    
    if (_totalPages > 1)
    {
        [self startTimer];
    } else {
        [self stopTimer];
    }
}
- (void)reloadData
{
    _totalPages = [_datasource numberOfPages];
    if (_totalPages == 0) {
        return;
    }
    _pageControl.numberOfPages = _totalPages;
    _curPage=0;
    [self loadData];
}

- (void)handleTap:(UITapGestureRecognizer *)tap {
    
    if ([self.delegate respondsToSelector:@selector(didClickPage:atIndex:)]) {
        [self.delegate didClickPage:self atIndex:_curPage];
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
    if (_showTimer != nil)
    {
		[_showTimer invalidate];
        _showTimer= nil;
	}
}

- (void)startTimer
{
    if (_showTimer) {
        return;
    }
    _showTimer = [NSTimer scheduledTimerWithTimeInterval:5. target:self selector:@selector(refresh) userInfo:nil repeats:YES];
}

@end
