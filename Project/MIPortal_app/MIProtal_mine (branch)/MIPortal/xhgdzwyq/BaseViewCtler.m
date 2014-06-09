/*=================================
 *Desc：带导航背景的积累，
 *Date：2014/05/21
 *Auth：lip
 *=================================*/

#import "BaseViewCtler.h"
#import "EsNavigationCtler.h"

#define kNavBgColor kUIColorFromRGB(0xFF6D00)//导航栏背景色 灰色：RGB(240, 240, 240, 1) 橙色：kUIColorFromRGB(0xFF6D00)
@interface BaseViewCtler ()
{
}

@end

@implementation BaseViewCtler

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 70000
        if ( IOS7_OR_LATER )
        {
            self.edgesForExtendedLayout = UIRectEdgeNone;
            self.extendedLayoutIncludesOpaqueBars = NO;
            self.modalPresentationCapturesStatusBarAppearance = NO;
        }
#endif
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.view.backgroundColor = ([Global sharedSingleton].uiStyle.mode == UIStyleModeDay ? kBackgroundColor_D : kBackgroundColor_N);
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 70000
    if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)])
    {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
#endif
    
    if (self.navigationController != nil)
    {
        //设置导航的样式  RGB(0x77, 0x77, 0x77, 1)灰色字体
        NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:
                              [UIColor whiteColor],UITextAttributeTextColor,
                              [UIFont boldSystemFontOfSize:18],UITextAttributeFont,
                              [UIColor colorWithRed:0 green:0 blue:0 alpha:0],UITextAttributeTextShadowColor,
                              [NSValue valueWithUIOffset:UIOffsetMake(0,0)],UITextAttributeTextShadowOffset,nil];
        self.navigationController.navigationBar.titleTextAttributes = dict;
        //设置导航的背景颜色
        self.navigationController.navigationBar.backgroundColor = kNavBgColor;
        
        //调整标题的未知
        [self.navigationController.navigationBar setTitleVerticalPositionAdjustment:2 forBarMetrics:UIBarMetricsDefault];
        
        [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
        
        //继承的子类如有设置背景图，就设置背景图
        if ([self.navigationController.navigationBar respondsToSelector:@selector(setShadowImage:)])
        {
            [self.navigationController.navigationBar setShadowImage:[UIImage new]];
        }
        //默认隐藏返回按钮
        self.navigationItem.hidesBackButton = YES;
        
        //设置状态栏的颜色和背景栏的颜色一致
        {
            UIView* statusbarview = [[UIView alloc] initWithFrame:CGRectMake(0, -20, 320, 20)];
            statusbarview.backgroundColor = self.navigationController.navigationBar.backgroundColor;
            [self.navigationController.navigationBar addSubview:statusbarview];
        }
        
        //添加导航栏下面的一条线
        UIImageView * lineview = (UIImageView *)[self.navigationController.navigationBar viewWithTag:65533];
        if (!lineview)
        {
            lineview = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"headbar_line"]];
            lineview.frame = CGRectMake(0, 44, 320, 1);
            lineview.tag = 65533;
            [self.navigationController.navigationBar addSubview:lineview];
        }
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark titlebar button
/*
 *设置返回按钮，左侧显示
 */
- (void)setBackButton
{
    UIImage * img = [UIImage imageNamed:@"button_back_white"];
    UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 0, img.size.width + 40, img.size.height + 40);
    [btn setImage:img forState:UIControlStateNormal];
    [btn setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, CGRectGetWidth(btn.frame) - img.size.width)];
    [btn addTarget:self action:@selector(onLeftBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * baritem = [[UIBarButtonItem alloc] initWithCustomView:btn];
    self.navigationItem.leftBarButtonItem = baritem;
}

/*
 *设置左侧按钮
 */
- (void)setLeftButton:(UIImage *)image
{
    if (!image)
    {
        return;
    }
    
    int x = (image.size.width > 40 ? 0 : 10);
    UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 0, image.size.width + x, image.size.height);
    [btn setImage:image forState:UIControlStateNormal];
    [btn setImageEdgeInsets:UIEdgeInsetsMake(0, x, 0, 0)];
    [btn addTarget:self action:@selector(onLeftBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem * baritem = [[UIBarButtonItem alloc] initWithCustomView:btn];
    self.navigationItem.leftBarButtonItem = baritem;
}

/*
 *设置右侧按钮
 */
- (void)setRightButton:(UIImage *)image
{
    if (!image)
    {
        return;
    }
    
    int x = (image.size.width > 40 ? 0 : 10);
    UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 0, image.size.width + x, image.size.height);
    [btn setImage:image forState:UIControlStateNormal];
    [btn setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, x)];
    [btn addTarget:self action:@selector(onRightBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem * baritem = [[UIBarButtonItem alloc] initWithCustomView:btn];
    self.navigationItem.rightBarButtonItem = baritem;
}

/*
 *设置右侧按钮
 */
- (void)setRightButtonWidthTitle:(NSString *)csTitle
{
    if (!csTitle)
    {
        return;
    }
    
    UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 0, 60, 35);
    [btn setTitle:csTitle forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];//kUIColorFromRGB(0xFF6D00)橙色字体
    [btn addTarget:self action:@selector(onRightBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * baritem = [[UIBarButtonItem alloc] initWithCustomView:btn];
    self.navigationItem.rightBarButtonItem = baritem;
}


/*
 点击按钮响应，左按钮默认返回
 */
- (void)onLeftBtnAction:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)onRightBtnAction:(id)sender
{
    
}

@end
