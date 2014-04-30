//
//  CTSelectBar.h
//  CTPocketV4
//
//  Created by Y W on 14-3-24.
//  Copyright (c) 2014年 广东亿迅科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^CTSelectBarSelectViewBlock)(UIView *view);


@interface CTSelectBar : UIView

@property (nonatomic, readwrite, copy) CTSelectBarSelectViewBlock selectBlock;

@property (nonatomic, strong) NSArray *items;

@property (nonatomic, assign) CGFloat sliderHeight;
@property (nonatomic, strong) UIImageView *sliderView;

@end
