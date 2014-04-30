//
//  CTPackageView.h
//  CTPocketV4
//
//  Created by 许忠洲 on 14-1-13.
//  Copyright (c) 2014年 广东亿迅科技有限公司. All rights reserved.
//  实现一个套餐UIScrollView

#import <UIKit/UIKit.h>
#import "packageScrollView.h"

@protocol CTPackageViewDelegate <NSObject>
@optional
- (void)didScrollToIndex:(NSUInteger)inx;
- (void)scrollToNext:(NSInteger)inx;

@end

@interface CTPackageView : UIView
@property (nonatomic) NSUInteger index;
@property (nonatomic, weak) id<CTPackageViewDelegate> delegate;
@property (nonatomic, strong) packageScrollView *packageScrollView;

- (void)addPackage:(NSArray *)package;

@end
