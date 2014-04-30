//
//  CTComboItemBar.h
//  CTPocketV4
//
//  Created by 许忠洲 on 14-1-9.
//  Copyright (c) 2014年 广东亿迅科技有限公司. All rights reserved.
//  ComboItemBar

#import <UIKit/UIKit.h>

@protocol CTComboItemBarDelegate <NSObject>
@optional
- (void)didSelectFromIndex1:(NSUInteger)index1 ToIndex2:(NSUInteger)index2;
@end

@interface CTComboItemBar : UIView
@property (weak, nonatomic) id<CTComboItemBarDelegate> delegate;
@property (nonatomic) NSUInteger index;
- (instancetype)initWithArray:(NSArray *)array;
@end
