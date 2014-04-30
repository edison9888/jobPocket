//
//  CTNavigationController.m
//  CTPocketV4
//
//  Created by apple on 14-2-28.
//  Copyright (c) 2014年 广东亿迅科技有限公司. All rights reserved.
//

#import "CTNavigationController.h"
#import <objc/runtime.h>

@interface CTNavigationController ()

@end

@implementation CTNavigationController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    __weak CTNavigationController *weakSelf = self;
    self.delegate = (id<UINavigationControllerDelegate>)weakSelf;
    self.animating = NO;
    
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 70000
    if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)])
    {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    
    if ([self respondsToSelector:@selector(interactivePopGestureRecognizer)])
    {
        self.interactivePopGestureRecognizer.delegate = (id<UIGestureRecognizerDelegate>)weakSelf;
    }
#endif
}

// added by zy, 2014-04-01，解决在tab首页时，滑动会导致其它页面无法加载
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    return (self.viewControllers.count > 1);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    DDLogInfo(@"%s %@", __func__, viewController);
    if (self.animating)
    {
        DDLogInfo(@"animating");
        return;
    }
    self.animating = YES;
    DDLogInfo(@"push vc");
    [super pushViewController:viewController animated:animated];
}

- (UIViewController *)popViewControllerAnimated:(BOOL)animated
{
    DDLogInfo(@"%s %@", __func__, self.viewControllers);
    if (self.viewControllers.count <= 1)
    {
        DDLogInfo(@"only one vc showed");
        return nil;
    }
    if (self.animating)
    {
        DDLogInfo(@"animating");
        return nil;
    }
    self.animating = YES;
    DDLogInfo(@"pop vc");
    return [super popViewControllerAnimated:animated];
}

- (NSArray *)popToViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    DDLogInfo(@"%s %@", __func__, viewController);
    if (self.viewControllers.count <= 1)
    {
        DDLogInfo(@"only one vc showed");
        return nil;
    }
    if (self.animating)
    {
        DDLogInfo(@"animating");
        return nil;
    }
    
    self.animating = YES;
    DDLogInfo(@"pop vc");
    return [super popToViewController:viewController animated:animated];
}

- (NSArray *)popToRootViewControllerAnimated:(BOOL)animated
{
    DDLogInfo(@"%s %@", __func__, self.viewControllers);
    if (self.viewControllers.count <= 1)
    {
        DDLogInfo(@"only one vc showed");
        return nil;
    }
    
    if (self.animating)
    {
        DDLogInfo(@"animating");
        return nil;
    }
    self.animating = YES;
    DDLogInfo(@"pop vc");
    return [super popToRootViewControllerAnimated:animated];
}

#pragma mark UINavigationControllerDelegate
- (void)navigationController:(UINavigationController *)navigationController
       didShowViewController:(UIViewController *)viewController
                    animated:(BOOL)animate
{
    DDLogInfo(@"%s %@", __func__, viewController);
    self.animating = NO;
}

@end

@implementation UINavigationController(NavigationAnimation)

static char const * const AnimatingKey = "AnimatingKey";
@dynamic animating;

- (BOOL)animating
{
    NSNumber * val = objc_getAssociatedObject(self, AnimatingKey);
    return [val boolValue];
}

- (void)setAnimating:(BOOL)animating
{
    NSNumber * val = [NSNumber numberWithBool:animating];
    objc_setAssociatedObject(self, AnimatingKey, val, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end
