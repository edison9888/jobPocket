//
//  UIColor+Category.m
//  CTPocketV4
//
//  Created by Y W on 14-3-10.
//  Copyright (c) 2014年 广东亿迅科技有限公司. All rights reserved.
//

#import "UIColor+Category.h"

@implementation UIColor (Category)

+ (instancetype)colorWithR:(CGFloat)red G:(CGFloat)green B:(CGFloat)blue A:(CGFloat)alpha
{
    return [UIColor colorWithRed:red/255.0 green:green/255.0 blue:blue/255.0 alpha:alpha];
}

@end
