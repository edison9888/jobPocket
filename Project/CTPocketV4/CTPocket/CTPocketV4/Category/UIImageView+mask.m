//
//  UIImageView+mask.m
//  CTPocketV4
//
//  Created by quan on 14-6-6.
//  Copyright (c) 2014年 广东亿迅科技有限公司. All rights reserved.
//

#import "UIImageView+mask.h"

@implementation UIImageView (mask)

/*
 根据image创建imageview，反之为nil
 */
- (UIImageView *)initAccordingImageForImageView:(NSString *)imageName{
    
    if (self == [super init]) {
        
        if ([imageName length] != 0 && imageName) {
            
            UIImage *image = [UIImage imageNamed:imageName];
            
            if (image) {
                
                return self;
            }
            
            return nil;
        }
    }
    
    return nil;
    
}
/*
 判断imageView的图片是否为空
 */

- (UIImageView *)accordingImageForImageView:(UIImage *)image
{
    
    if (image) {
        
        return self;
    }
    return nil;
    
}
@end
