//
//  UIView+RoundRect.h
//  CTPocketv3
//
//  Created by Y W on 13-4-17.
//
//

#import <UIKit/UIKit.h>

@interface UIView (BottomRound)

- (void)dwMakeBottomRoundCornerWithRadius:(CGFloat)radius;

@end


@interface UIView (LeftRound)

- (void)dwMakeLeftRoundCornerWithRadius:(CGFloat)radius;

@end


@interface UIView (RightRound)

- (void)dwMakeRightRoundCornerWithRadius:(CGFloat)radius;

@end


@interface  UIView (HeaderRound)

- (void)dwMakeHeaderRoundCornerWithRadius:(CGFloat)radius;

@end


@interface UIView  (RoundRect)

- (void)dwMakeRoundCornerWithRadius:(CGFloat)radius;

@end