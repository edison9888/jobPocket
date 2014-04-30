//
//  UIView+RoundRect.m
//  CTPocketv3
//
//  Created by Y W on 13-4-17.
//
//

#import "UIView+RoundRect.h"
#import <QuartzCore/QuartzCore.h>

@implementation UIView (BottomRound)

- (void)dwMakeBottomRoundCornerWithRadius:(CGFloat)radius
{
    CGSize size = self.frame.size;
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    [shapeLayer setFillColor:[[UIColor whiteColor] CGColor]];
    
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL, size.width - radius, size.height);
    CGPathAddArc(path, NULL, size.width-radius, size.height-radius, radius, M_PI/2, 0.0, YES);
    CGPathAddLineToPoint(path, NULL, size.width, 0.0);
    CGPathAddLineToPoint(path, NULL, 0.0, 0.0);
    CGPathAddLineToPoint(path, NULL, 0.0, size.height - radius);
    CGPathAddArc(path, NULL, radius, size.height - radius, radius, M_PI, M_PI/2, YES);
    CGPathCloseSubpath(path);
    [shapeLayer setPath:path];
    CFRelease(path);
    
    self.layer.mask = shapeLayer;//layer的mask，顾名思义，是种位掩蔽，在shapeLayer的填充区域中，alpha值不为零的部分，self会被绘制；alpha值为零的部分，self不会被绘制，甚至不会响应touch
}

@end



@implementation UIView (LeftRound)

- (void)dwMakeLeftRoundCornerWithRadius:(CGFloat)radius
{
    CGSize size = self.frame.size;
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    [shapeLayer setFillColor:[[UIColor whiteColor] CGColor]];
    
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL, radius, 0.0);
    CGPathAddLineToPoint(path, NULL, size.width, 0.0);
    CGPathAddLineToPoint(path, NULL, size.width, size.height);
    CGPathAddLineToPoint(path, NULL, radius, size.height);
    CGPathAddArc(path, NULL, radius, size.height-radius, radius, M_PI/2, M_PI, NO);
    CGPathAddLineToPoint(path, NULL, 0, radius);
    CGPathAddArc(path, NULL, radius, radius, radius, M_PI, M_PI*3/2, NO);
    CGPathCloseSubpath(path);
    [shapeLayer setPath:path];
    CFRelease(path);
    
    
    self.layer.mask = shapeLayer;
}

@end


@implementation UIView (RightRound)

- (void)dwMakeRightRoundCornerWithRadius:(CGFloat)radius
{
    CGSize size = self.frame.size;
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    [shapeLayer setFillColor:[[UIColor whiteColor] CGColor]];
    
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL, 0.0, 0.0);
    CGPathAddLineToPoint(path, NULL, size.width-radius, 0);
    CGPathAddArc(path, NULL, size.width-radius, radius, radius, M_PI*3/2, 0.0, NO);
    CGPathAddLineToPoint(path, NULL, size.width, size.height-radius);
    CGPathAddArc(path, NULL, size.width-radius, size.height-radius, radius, 0, M_PI/2, NO);
    CGPathAddLineToPoint(path, NULL, 0, size.height);
    CGPathAddLineToPoint(path, NULL, 0, 0);
    CGPathCloseSubpath(path);
    [shapeLayer setPath:path];
    CFRelease(path);
    
    self.layer.mask = shapeLayer;
}

@end


@implementation UIView (HeaderRound)

- (void)dwMakeHeaderRoundCornerWithRadius:(CGFloat)radius
{
    CGSize size = self.frame.size;
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    [shapeLayer setFillColor:[[UIColor whiteColor] CGColor]];
    
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL, size.width - radius, 0.0);
    CGPathAddArc(path, NULL, size.width-radius, radius, radius, M_PI*3/2, 0.0, NO);
    CGPathAddLineToPoint(path, NULL, size.width, size.height);
    CGPathAddLineToPoint(path, NULL, 0, size.height);
    CGPathAddLineToPoint(path, NULL, 0, radius);
    CGPathAddArc(path, NULL, radius, radius, radius, M_PI, M_PI*3/2, NO);
    CGPathCloseSubpath(path);
    [shapeLayer setPath:path];
    CFRelease(path);
    
    self.layer.mask = shapeLayer;//layer的mask，顾名思义，是种位掩蔽，在shapeLayer的填充区域中，alpha值不为零的部分，self会被绘制；alpha值为零的部分，self不会被绘制，甚至不会响应touch
}

@end



@implementation UIView (RoundRect)

- (void)dwMakeRoundCornerWithRadius:(CGFloat)radius
{
    self.layer.cornerRadius = radius;
    self.clipsToBounds = YES;
}

@end

