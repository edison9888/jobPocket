//
//  CTYunView.h
//  CTPocketV4
//
//  Created by 许忠洲 on 14-1-15.
//  Copyright (c) 2014年 广东亿迅科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "packageScrollView.h"

@protocol CTYunViewDelegate <NSObject>
@optional
- (void)didScrollToIndex:(NSUInteger)inx;
- (void)scrollToNext:(NSInteger)inx;
@end

@interface CTYunView : UIView
@property (nonatomic) NSUInteger index;
@property (nonatomic, weak) id<CTYunViewDelegate> delegate;
@property (nonatomic, strong) packageScrollView *packageScrollView;
- (void)addPackage:(NSArray *)package;
@end
