/*=================================
 *Desc：导航条基类，
 *Date：2014/05/21
 *Auth：lip
 *=================================*/

#import "EsNavigationCtler.h"
#import <objc/runtime.h>

@interface EsNavigationCtler ()

@end

@implementation EsNavigationCtler

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
    __weak EsNavigationCtler *weakSelf = self;
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
    if (self.animating)
    {
        CLog(@"animating");
        return;
    }
    self.animating = YES;
    CLog(@"push vc");
    [super pushViewController:viewController animated:animated];
}

- (UIViewController *)popViewControllerAnimated:(BOOL)animated
{
    CLog(@"%s %@", __func__, self.viewControllers);
    if (self.viewControllers.count <= 1)
    {
        CLog(@"only one vc showed");
        return nil;
    }
    if (self.animating)
    {
        CLog(@"animating");
        return nil;
    }
    self.animating = YES;
    CLog(@"pop vc");
    return [super popViewControllerAnimated:animated];
}

- (NSArray *)popToViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    CLog(@"%s %@", __func__, viewController);
    if (self.viewControllers.count <= 1)
    {
        CLog(@"only one vc showed");
        return nil;
    }
    if (self.animating)
    {
        CLog(@"animating");
        return nil;
    }
    
    self.animating = YES;
    CLog(@"pop vc");
    return [super popToViewController:viewController animated:animated];
}

- (NSArray *)popToRootViewControllerAnimated:(BOOL)animated
{
    CLog(@"%s %@", __func__, self.viewControllers);
    if (self.viewControllers.count <= 1)
    {
        CLog(@"only one vc showed");
        return nil;
    }
    
    if (self.animating)
    {
        CLog(@"animating");
        return nil;
    }
    self.animating = YES;
    CLog(@"pop vc");
    return [super popToRootViewControllerAnimated:animated];
}

#pragma mark UINavigationControllerDelegate
- (void)navigationController:(UINavigationController *)navigationController
       didShowViewController:(UIViewController *)viewController
                    animated:(BOOL)animate
{
    CLog(@"%s %@", __func__, viewController);
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
