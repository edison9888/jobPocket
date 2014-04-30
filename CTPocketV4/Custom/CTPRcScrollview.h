//
//  CTPRcScrollview.h
//  CTPocketv3
//
//  Created by mjlee on 13-4-11.
//  Copyright (c) 2013年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol CTPRcScrollViewDelegate;
@protocol CTPRcScrollViewDatasource;


@interface CTPRcScrollview : UIView<UIScrollViewDelegate>{
    UIScrollView *_scrollView;
    UIPageControl *_pageControl;
    
    NSInteger _totalPages;
    NSInteger _curPage;
    
    NSMutableArray *_curViews;
    
    NSTimer         *_showTimer;
}

@property (nonatomic,readonly) UIScrollView *scrollView;
@property (nonatomic,readonly) UIPageControl *pageControl;
@property (nonatomic,assign) NSInteger currentPage;
@property (nonatomic,weak,setter = setDataource:) id<CTPRcScrollViewDatasource> datasource;
@property (nonatomic,weak,setter = setDelegate:)  id<CTPRcScrollViewDelegate> delegate;

- (void)reloadData;
- (void)setViewContent:(UIView *)view atIndex:(NSInteger)index;
- (void)stopTimer;

@end

@protocol CTPRcScrollViewDelegate <NSObject>

@optional
- (void)didClickPage:(CTPRcScrollview *)csView atIndex:(NSInteger)index;

@end

@protocol CTPRcScrollViewDatasource <NSObject>

@required
- (NSInteger)numberOfPages;
- (UIView *)pageAtIndex:(NSInteger)index;

@end
