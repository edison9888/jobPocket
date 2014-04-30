//
//  UIView+BounceAnimation.m
//  eMarketing
//
//  Created by apple on 12-11-22.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "UIView+BounceAnimation.h"


@implementation UIView (BounceAnimation)

static int __nBounceCnt = 5;

- (void)bounceStart
{
	__nBounceCnt--;
	if (__nBounceCnt < 0) 
	{
		__nBounceCnt = 5;
		return;
	}
	
	[UIView animateWithDuration:0.05 animations:^
	 {
		 [self setTransform:CGAffineTransformTranslate(CGAffineTransformIdentity, -5, 0)];
	 } completion:^(BOOL finished) 
	 {
		 [self bounceLeftAnimationStopped];
	 }];
}

- (void)bounceRightAnimationStopped
{
	[UIView animateWithDuration:0.05 animations:^
	 {
		 [self setTransform:CGAffineTransformTranslate(CGAffineTransformIdentity, 0, 0)];
	 } completion:^(BOOL finished) 
	 {
		 [self bounceStart];
	 }];
}

- (void)bounceLeftAnimationStopped
{
	[UIView animateWithDuration:0.05 animations:^
	 {
		 [self setTransform:CGAffineTransformTranslate(CGAffineTransformIdentity, 5, 0)];
	 } completion:^(BOOL finished) 
	 {
		 [self bounceRightAnimationStopped];
	 }];
}

@end
