//
//  FlatTextField.m
//  xhgdzwyq
//
//  Created by apple on 13-11-28.
//  Copyright (c) 2013年 Eshore. All rights reserved.
//

#import "FlatTextField.h"

@interface FlatTextField()

@property (strong, nonatomic) UIColor *originalBackgroundColor;

@end

@implementation FlatTextField

- (void)setBackgroundColor:(UIColor *)backgroundColor
{
    [super setBackgroundColor:[UIColor clearColor]];
    self.originalBackgroundColor = backgroundColor;
}

- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    [self setBackground:[self drawnBackgroundImageWithSize:self.frame.size color:self.originalBackgroundColor]];
}

- (UIImage *)drawnBackgroundImageWithSize:(CGSize)size color:(UIColor *)color
{
    UIImage *image = nil;
    UIGraphicsBeginImageContextWithOptions(size, NO, 0.0f);
    
    UIBezierPath* rectanglePath = [UIBezierPath bezierPathWithRect: CGRectMake(0, 0, size.width, size.height)];
    [color setStroke];
    rectanglePath.lineWidth = 2;
    [rectanglePath stroke];
    
    image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return [image resizableImageWithCapInsets:UIEdgeInsetsMake(1.0f, 1.0f, 1.0f, 1.0f)];
}

@end
