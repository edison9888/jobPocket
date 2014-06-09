//
//  UIImageView+mask.h
//  CTPocketV4
//
//  Created by quan on 14-6-6.
//  Copyright (c) 2014年 广东亿迅科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImageView (mask)

/*
 根据image创建imageview，反之为nil
 */
- (UIImageView *)initAccordingImageForImageView:(NSString *)imageName;
///*
// 没有图片把imageView赋值为nil
// */
//- (void)accordingImageForImageView:(NSString *)imageName;

/*
 判断imageView的图片是否为空
 */
- (UIImageView *)accordingImageForImageView:(UIImage *)image;

@end
