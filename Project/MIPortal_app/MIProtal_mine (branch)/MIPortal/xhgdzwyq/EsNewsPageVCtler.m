//
//  EsNewsPageVCtler.m
//  xhgdzwyq
//
//  Created by apple on 13-12-2.
//  Copyright (c) 2013年 Eshore. All rights reserved.
//

#import "EsNewsPageVCtler.h"

@interface EsNewsPageVCtler ()
{
    UIViewController*   _tempViewCtrler;
    UIImageView*        _arrowImageView;
    
    BOOL                _hasAskedPage;
    BOOL                _need2ChangePage;
    CGPoint             _originPoint;
    BoundaryViewChangedDirection    _bounceDirect;
}

@end

@implementation EsNewsPageVCtler

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        _hasAskedPage = NO;
        _need2ChangePage = YES;
        _bounceDirect = BoundaryViewChangedDirectionNone;
    }
    return self;
}

- (void)dealloc
{
    NSLog(@"%s", __func__);
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    {
        UIPanGestureRecognizer* gesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(onPanGestureHandler:)];
        gesture.maximumNumberOfTouches = 1;
        [self.view addGestureRecognizer:gesture];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)onPanGestureHandler:(UIPanGestureRecognizer* )pan
{
    if (pan.state == UIGestureRecognizerStateBegan)
    {
        _hasAskedPage = NO;
        _originPoint = _currentVCtler.view.center;
        return;
    }
    else if (pan.state == UIGestureRecognizerStateEnded ||
             pan.state == UIGestureRecognizerStateCancelled ||
             pan.state == UIGestureRecognizerStateFailed)
    {
        [self didGestureFinish];
        [pan setTranslation:CGPointZero inView:self.view];
        return;
    }
    
    CGPoint location = [pan translationInView:self.view];
    [self didGestureChanging:location];
    [pan setTranslation:CGPointZero inView:self.view];
}

- (void)setLeftBoundaryView:(UIView *)leftBoundaryView
{
    [_leftBoundaryView removeFromSuperview];
    _leftBoundaryView = leftBoundaryView;
}

- (void)setRightBoundaryView:(UIView *)rightBoundaryView
{
    [_rightBoundaryView removeFromSuperview];
    _rightBoundaryView = rightBoundaryView;
}

- (void)setLeftBoundaryViewVisible
{
    self.leftBoundaryView.frame = CGRectMake(-CGRectGetWidth(self.leftBoundaryView.frame) + CGRectGetMinX(self.currentVCtler.view.frame),
                                             (CGRectGetHeight(self.view.frame) - CGRectGetHeight(self.leftBoundaryView.frame))/2,
                                             CGRectGetWidth(self.leftBoundaryView.frame),
                                             CGRectGetHeight(self.leftBoundaryView.frame));
    [self.view addSubview:self.leftBoundaryView];
    
    _arrowImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"newslist_rightarrow"]];
    _arrowImageView.frame = CGRectMake(CGRectGetMinX(self.leftBoundaryView.frame) - CGRectGetWidth(_arrowImageView.frame),
                                       (CGRectGetHeight(self.view.frame) - CGRectGetHeight(_arrowImageView.frame))/2,
                                       CGRectGetWidth(_arrowImageView.frame),
                                       CGRectGetHeight(_arrowImageView.frame));
    [self.view addSubview:_arrowImageView];
}

- (void)setRightBoundaryViewVisible
{
    self.rightBoundaryView.frame = CGRectMake(CGRectGetMaxX(self.currentVCtler.view.frame),
                                             (CGRectGetHeight(self.view.frame) - CGRectGetHeight(self.rightBoundaryView.frame))/2,
                                             CGRectGetWidth(self.rightBoundaryView.frame),
                                             CGRectGetHeight(self.rightBoundaryView.frame));
    [self.view addSubview:self.rightBoundaryView];
    
    _arrowImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"newslist_leftarrow"]];
    _arrowImageView.frame = CGRectMake(CGRectGetMaxX(self.rightBoundaryView.frame),
                                       (CGRectGetHeight(self.view.frame) - CGRectGetHeight(_arrowImageView.frame))/2,
                                       CGRectGetWidth(_arrowImageView.frame),
                                       CGRectGetHeight(_arrowImageView.frame));
    [self.view addSubview:_arrowImageView];
}

- (void)didGestureFinish
{
    BOOL bounced = NO;
    if (_hasAskedPage &&
        !_tempViewCtrler &&
        _bounceDirect != BoundaryViewChangedDirectionNone &&
        [self.delegate respondsToSelector:@selector(pageViewController:boundceDirection:)])
    {
        bounced = YES;
    }
    
    [[UIApplication sharedApplication] beginIgnoringInteractionEvents];
    [UIView animateWithDuration:0.3 animations:^
    {
        _hasAskedPage = NO;
        self.currentVCtler = _tempViewCtrler;
        _tempViewCtrler = nil;
        
        [self.leftBoundaryView removeFromSuperview];
        [self.rightBoundaryView removeFromSuperview];
        [_arrowImageView removeFromSuperview];
        _arrowImageView = nil;
    } completion:^(BOOL finished)
    {
        if (bounced)
        {
            [self.delegate pageViewController:self boundceDirection:_bounceDirect];
        }
        [[UIApplication sharedApplication] endIgnoringInteractionEvents];
    }];
    
}

- (void)didGestureChanging:(CGPoint)changedloc
{
    if (_hasAskedPage && !_tempViewCtrler)
    {
        // boundary view
        if (ABS(_originPoint.x - (_currentVCtler.view.center.x + changedloc.x)) > 120)
        {
            return;
        }
        
        int bounceDelta = 4;        // 加权系数，当滚到边界时，滚动不要太顺溜
        changedloc.x /= bounceDelta;
        if (_originPoint.x - _currentVCtler.view.center.x < 0 &&
            self.leftBoundaryView)
        {
            // show left boundary view
            if (![self.leftBoundaryView isDescendantOfView:self.view])
            {
                [self setLeftBoundaryViewVisible];
            }
            
            self.leftBoundaryView.center = CGPointMake(self.leftBoundaryView.center.x + changedloc.x, self.leftBoundaryView.center.y);
            _arrowImageView.center = CGPointMake(_arrowImageView.center.x + changedloc.x, _arrowImageView.center.y);
            
            if (CGRectGetMinX(_arrowImageView.frame) >= 10)
            {
                [UIView animateWithDuration:0.15 animations:^{
                    _arrowImageView.transform = CGAffineTransformMakeRotation(M_PI);
                }];
                _bounceDirect = BoundaryViewChangedDirectionLeft;
            }
            else
            {
                [UIView animateWithDuration:0.15 animations:^{
                    _arrowImageView.transform = CGAffineTransformIdentity;
                }];
                _bounceDirect = BoundaryViewChangedDirectionNone;
            }
        }
        else if (_originPoint.x - _currentVCtler.view.center.x > 0 &&
                 self.rightBoundaryView)
        {
            // show right boundary view
            if (![self.rightBoundaryView isDescendantOfView:self.view])
            {
                [self setRightBoundaryViewVisible];
            }
            
            self.rightBoundaryView.center = CGPointMake(self.rightBoundaryView.center.x + changedloc.x, self.rightBoundaryView.center.y);
            _arrowImageView.center = CGPointMake(_arrowImageView.center.x + changedloc.x, _arrowImageView.center.y);
            
            if (CGRectGetWidth(self.view.frame) - CGRectGetMaxX(_arrowImageView.frame) >= 10)
            {
                [UIView animateWithDuration:0.15 animations:^{
                    _arrowImageView.transform = CGAffineTransformMakeRotation(M_PI);
                }];
                _bounceDirect = BoundaryViewChangedDirectionRight;
            }
            else
            {
                [UIView animateWithDuration:0.15 animations:^{
                    _arrowImageView.transform = CGAffineTransformIdentity;
                }];
                _bounceDirect = BoundaryViewChangedDirectionNone;
            }
        }
    }
    
    _currentVCtler.view.center = CGPointMake(_currentVCtler.view.center.x + changedloc.x, _currentVCtler.view.center.y);
    _tempViewCtrler.view.center = CGPointMake(_tempViewCtrler.view.center.x + changedloc.x, _tempViewCtrler.view.center.y);
    if (_originPoint.x - _currentVCtler.view.center.x >= 5 && !_hasAskedPage)
    {
        // ask for next page
        if ([self.delegate respondsToSelector:@selector(pageViewController:viewControllerAfterViewController:)])
        {
            _hasAskedPage = YES;
            
            [_tempViewCtrler removeFromParentViewController];
            [_tempViewCtrler.view removeFromSuperview];
            _tempViewCtrler = [self.delegate pageViewController:self viewControllerAfterViewController:self.currentVCtler];
            if (_tempViewCtrler)
            {
                _tempViewCtrler.view.frame = CGRectMake(CGRectGetMaxX(self.currentVCtler.view.frame),
                                                        0,
                                                        CGRectGetWidth(_tempViewCtrler.view.frame),
                                                        CGRectGetHeight(_tempViewCtrler.view.frame));
                [self.view addSubview:_tempViewCtrler.view];
                [self addChildViewController:_tempViewCtrler];
            }
        }
    }
    else if (_originPoint.x - _currentVCtler.view.center.x <= -5  && !_hasAskedPage)
    {
        // ask for previous page
        if ([self.delegate respondsToSelector:@selector(pageViewController:viewControllerBeforeViewController:)])
        {
            _hasAskedPage = YES;
            
            [_tempViewCtrler removeFromParentViewController];
            [_tempViewCtrler.view removeFromSuperview];
            _tempViewCtrler = [self.delegate pageViewController:self viewControllerBeforeViewController:self.currentVCtler];
            if (_tempViewCtrler)
            {
                _tempViewCtrler.view.frame = CGRectMake(-CGRectGetWidth(self.view.frame) + CGRectGetMinX(self.currentVCtler.view.frame),
                                                        0,
                                                        CGRectGetWidth(_tempViewCtrler.view.frame),
                                                        CGRectGetHeight(_tempViewCtrler.view.frame));
                [self.view addSubview:_tempViewCtrler.view];
                [self addChildViewController:_tempViewCtrler];
            }
        }
    }
    
    if (ABS(_currentVCtler.view.center.x - _originPoint.x) >= 100)
    {
        _need2ChangePage = YES;
    }
    else
    {
        _need2ChangePage = NO;
    }
}

- (void)setCurrentVCtler:(UIViewController *)currentVCtler
{
    _hasAskedPage = NO;
    if (!currentVCtler)
    {
        [[UIApplication sharedApplication] beginIgnoringInteractionEvents];
        [UIView animateWithDuration:0.3 animations:^{
            _currentVCtler.view.frame = self.view.bounds;
        } completion:^(BOOL finished) {
            if ([self.delegate respondsToSelector:@selector(pageViewController:transitionCompleted:)])
            {
                [self.delegate pageViewController:self transitionCompleted:YES];
            }
            [[UIApplication sharedApplication] endIgnoringInteractionEvents];
        }];
        
        return;
    }
    
    if (![self.childViewControllers containsObject:currentVCtler])
    {
        [self addChildViewController:currentVCtler];
        [self.view addSubview:currentVCtler.view];
        currentVCtler.view.frame = self.view.bounds;
        
        [_currentVCtler removeFromParentViewController];
        [_currentVCtler.view removeFromSuperview];
        _currentVCtler = currentVCtler;
        
        if ([self.delegate respondsToSelector:@selector(pageViewController:transitionCompleted:)])
        {
            [self.delegate pageViewController:self transitionCompleted:YES];
        }
        
        return;
    }
    
    if (_need2ChangePage)
    {
        [[UIApplication sharedApplication] beginIgnoringInteractionEvents];
        [UIView animateWithDuration:0.3 animations:^
         {
             if (self.currentVCtler.view.frame.origin.x < 0)
             {
                 self.currentVCtler.view.frame = CGRectMake(-CGRectGetWidth(self.view.frame),
                                                            0,
                                                            CGRectGetWidth(self.currentVCtler.view.frame),
                                                            CGRectGetHeight(self.currentVCtler.view.frame));
             }
             else
             {
                 self.currentVCtler.view.frame = CGRectMake(CGRectGetWidth(self.view.frame),
                                                            0,
                                                            CGRectGetWidth(self.currentVCtler.view.frame),
                                                            CGRectGetHeight(self.currentVCtler.view.frame));
             }
             currentVCtler.view.frame = self.view.bounds;
         } completion:^(BOOL finished)
         {
             [_currentVCtler removeFromParentViewController];
             [_currentVCtler.view removeFromSuperview];
             _currentVCtler = currentVCtler;
             if ([self.delegate respondsToSelector:@selector(pageViewController:transitionCompleted:)])
             {
                 [self.delegate pageViewController:self transitionCompleted:YES];
             }
             [[UIApplication sharedApplication] endIgnoringInteractionEvents];
         }];
        
        _need2ChangePage = NO;
    }
    else
    {
        [[UIApplication sharedApplication] beginIgnoringInteractionEvents];
        [UIView animateWithDuration:0.3 animations:^{
            _currentVCtler.view.center = _originPoint;
            
            if (currentVCtler.view.frame.origin.x < 0)
            {
                currentVCtler.view.frame = CGRectMake(-CGRectGetWidth(self.view.frame),
                                                      0,
                                                      CGRectGetWidth(currentVCtler.view.frame),
                                                      CGRectGetHeight(currentVCtler.view.frame));
            }
            else
            {
                currentVCtler.view.frame = CGRectMake(CGRectGetWidth(self.view.frame),
                                                      0,
                                                      CGRectGetWidth(currentVCtler.view.frame),
                                                      CGRectGetHeight(currentVCtler.view.frame));
            }
        } completion:^(BOOL finished)
         {
             if ([self.delegate respondsToSelector:@selector(pageViewController:transitionCompleted:)])
             {
                 [self.delegate pageViewController:self transitionCompleted:YES];
             }
             
             [[UIApplication sharedApplication] endIgnoringInteractionEvents];
         }];
    }
}

@end
