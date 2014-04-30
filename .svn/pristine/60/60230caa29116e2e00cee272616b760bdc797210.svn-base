//
//  packageScrollView.h
//  CTPocketV4
//
//  Created by Mac-Eshore-01 on 14-4-17.
//  Copyright (c) 2014年 广东亿迅科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@class packageScrollView;
@protocol ScrollviewGestureDelegate <NSObject>

@optional
- (void)scrollViewtouch:(CGPoint)point ;

@end


@interface packageScrollView : UIScrollView

@property(nonatomic, assign) NSTimeInterval touchTimer; //记录touch时间,来控制点击和滑动判断
@property(nonatomic, assign) id<ScrollviewGestureDelegate> scrollGestureDelegate;

@end
