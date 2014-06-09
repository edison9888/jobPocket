/*--------------------------------------------
 *Name：EsMineContentViewCtrler.h
 *Desc：我的界面列表详情模块
 *Date：2014/06/09
 *Auth：shanhq
 *--------------------------------------------*/


#import "EsMineContentViewCtrler.h"
#import "EsNewsContentVCtler.h"
#import "EsUIStyle.h"
#import "EsNewsPageVCtler.h"
#import "ESActivityView.h"

@interface EsMineContentViewCtrler ()
{
    UIButton*   _btnFontSize;
    UIButton*   _btnFavor;
    UIButton*   _btnMode;
    UIButton*   _btnBrightness;
    UIView*     _titleView;
    EsNewsPageVCtler* _pageCtler;
    
    UISlider*   _sliderBrightness;
    UIView*     _sliderBackground;
    UIButton*   _sliderHideBtn;
    
    NSMutableArray*    _dataList;
}
@end

@implementation EsMineContentViewCtrler


- (void)onUIChangeFinishNotification
{
    _btnFontSize.userInteractionEnabled = YES;
    _btnMode.userInteractionEnabled = YES;
    
    _sliderBackground.backgroundColor = (_btnMode.selected ? RGB(0xc9, 0xc9, 0xc9, 1) : RGB(240, 240, 240, 1));
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.selectIdx = 0;
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(onUIChangeFinishNotification)
                                                     name:kMsgChangeUIFinish
                                                   object:nil];
    }
    return self;
}

- (void)dealloc
{
    [_pageCtler removeFromParentViewController];
    [_titleView removeFromSuperview];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setBackButton];
    
    _dataList = [NSMutableArray new];
    if (self.netAgent.newsHeadlines.count)
    {
        [_dataList addObjectsFromArray:self.netAgent.newsHeadlines];
    }
    if (self.netAgent.newsList.count)
    {
        [_dataList addObjectsFromArray:self.netAgent.newsList];
    }
    
    int originX = 0;
    {
        UIView* v = [[UIView alloc] initWithFrame:self.navigationController.navigationBar.bounds];
        v.backgroundColor = [UIColor clearColor];
        [self.navigationController.navigationBar addSubview:v];
        [self.navigationController.navigationBar sendSubviewToBack:v];
        _titleView = v;
    }
    
    int navbarH = 44;
    {
        originX = CGRectGetWidth(self.view.frame) - 4*navbarH + 30;
        UIButton* btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(originX, 0, navbarH, navbarH);
        [btn setImage:[UIImage imageNamed:@"Details-font-size+"] forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:@"Details-font-size-"] forState:UIControlStateSelected];
        [btn addTarget:self action:@selector(onZoomOutBtn) forControlEvents:UIControlEventTouchUpInside];
        [_titleView addSubview:btn];
        originX = CGRectGetMaxX(btn.frame) - 10;
        _btnFontSize = btn;
    }
    {
        UIImage* nimg = [UIImage imageNamed:@"icon_mode_day"];
        UIButton* btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(originX, 0, navbarH, navbarH);
        [btn setImage:nimg forState:UIControlStateSelected];
        [btn setImage:[UIImage imageNamed:@"icon_mode_night"] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(onModeBtn) forControlEvents:UIControlEventTouchUpInside];
        [_titleView addSubview:btn];
        originX = CGRectGetMaxX(btn.frame) - 10;
        _btnMode = btn;
    }
    {
        UIImage* nimg = [UIImage imageNamed:@"icon_brightness"];
        UIButton* btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(originX, 0, navbarH, navbarH);
        [btn setImage:nimg forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(onBrightnessBtn) forControlEvents:UIControlEventTouchUpInside];
        [_titleView addSubview:btn];
        originX = CGRectGetMaxX(btn.frame) - 10;
        _btnBrightness = btn;
        
        {
            UIView* v = [[UIView alloc] initWithFrame:CGRectMake(100, 0, 220, 50)];
            v.backgroundColor = RGB(240, 240, 240, 1);
            v.hidden = YES;
            [self.view addSubview:v];
            _sliderBackground = v;
            
            UISlider* slider = [[UISlider alloc] initWithFrame:CGRectMake(10, 15, 200, 20)];
            slider.value = [UIScreen mainScreen].brightness;
            [slider addTarget:self action:@selector(onBrightnessChange) forControlEvents:UIControlEventValueChanged];
            [_sliderBackground addSubview:slider];
            _sliderBrightness = slider;
        }
        
        {
            UIButton* btn = [UIButton buttonWithType:UIButtonTypeCustom];
            btn.frame = self.view.bounds;
            btn.hidden = YES;
            [btn addTarget:self action:@selector(onHideSlideView) forControlEvents:UIControlEventTouchUpInside];
            [self.view addSubview:btn];
            _sliderHideBtn = btn;
        }
    }
    {
        UIImage* nimg = [UIImage imageNamed:@"icon_favor_n"];
        UIButton* btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(originX, 0, navbarH, navbarH);
        [btn setImage:nimg forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:@"icon_favor_s"] forState:UIControlStateSelected];
        [btn addTarget:self action:@selector(onFavorBtn) forControlEvents:UIControlEventTouchUpInside];
        [_titleView addSubview:btn];
        btn.hidden = YES;
        originX = CGRectGetMaxX(btn.frame);
        _btnFavor = btn;
    }
    
    if (!self.isRemotePushNews)
    {
        [self addPageViewCtrler];
    }
    else
    {
        EsNewsItem* news = [EsNewsItem new];
        if (self.newsInfo[@"id"] != [NSNull null] &&
            self.newsInfo[@"id"] != nil)
        {
            news.newsId = self.newsInfo[@"id"];
        }
        EsNewsContentVCtler* vctler = [EsNewsContentVCtler new];
        vctler.newsInfo = news;
        vctler.newsDetail = self.newsDetail;
        vctler.view.frame = self.view.bounds;
        [self addChildViewController:vctler];
        [self.view addSubview:vctler.view];
    }
    
    [self.view bringSubviewToFront:_sliderHideBtn];
    [self.view bringSubviewToFront:_sliderBackground];
    
    _btnMode.selected = ([Global sharedSingleton].uiStyle.mode == UIStyleModeNight);
    _btnFontSize.selected = ([Global sharedSingleton].uiStyle.fontSize == 18);
}

- (void)addPageViewCtrler
{
    EsNewsPageVCtler* v = [EsNewsPageVCtler new];
    v.view.frame = self.view.bounds;
    v.delegate = (id<EsNewsPageVCtlerDelegate>)self;
    [self addChildViewController:v];
    [self.view addSubview:v.view];
    _pageCtler = v;
    
    EsNewsContentVCtler* vctler = [self newsContentVCtlerAtIndex:self.selectIdx];
    vctler.newsDetail = self.newsDetail;
    if (vctler)
    {
        v.currentVCtler = vctler;
    }
    
    {
        UILabel* lab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 40, 20)];
        lab.text = @" 返回";
        lab.textAlignment = UITextAlignmentLeft;
        lab.textColor = [UIColor grayColor];
        lab.font = [UIFont systemFontOfSize:12];
        lab.adjustsFontSizeToFitWidth = YES;
        lab.minimumFontSize = 10;
        lab.backgroundColor = [UIColor clearColor];
        v.leftBoundaryView = lab;
    }
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    _titleView.hidden = NO;
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    _titleView.hidden = YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    //    [self setContentWebView:nil];
    [super viewDidUnload];
}

- (IBAction)btnBack:(id)sender
{
    [self.cprtDelegate popViewCtrlFromCurrentViewCtrl:self];
}

- (void)onLeftBtnAction:(id)sender
{
    [self onHideSlideView];
    
    if (!self.isRemotePushNews)
    {
        [super onLeftBtnAction:sender];
    }
    else
    {
        [[NSNotificationCenter defaultCenter] postNotificationName:kMsgBack2NewsList object:self.newsInfo];
    }
}

- (void)onZoomOutBtn
{
    [self onHideSlideView];
    //    [_btnFontSize setImage:_btnFontSize.currentImage forState:UIControlStateDisabled];
    //    [_btnMode setImage:_btnMode.currentImage forState:UIControlStateDisabled];
    _btnMode.userInteractionEnabled = NO;
    _btnFontSize.userInteractionEnabled = NO;
    
    _btnFontSize.selected = !_btnFontSize.selected;
    [Global sharedSingleton].uiStyle.fontSize = (_btnFontSize.selected ? 18 : 14);
    [[NSNotificationCenter defaultCenter] postNotificationName:kMsgChangeUIStyle object:nil];
}

- (void)onFavorBtn
{
    [self onHideSlideView];
    _btnFavor.selected = !_btnFavor.selected;
    // TODO: 究竟是本地收藏还是服务器收藏？
}

- (void)onModeBtn
{
    [self onHideSlideView];
    //    [_btnFontSize setImage:_btnFontSize.currentImage forState:UIControlStateDisabled];
    //    [_btnMode setImage:_btnMode.currentImage forState:UIControlStateDisabled];
    _btnMode.userInteractionEnabled = NO;
    _btnFontSize.userInteractionEnabled = NO;
    
    _btnMode.selected = !_btnMode.selected;
    self.view.backgroundColor = (_btnMode.selected ? kBackgroundColor_N : kBackgroundColor_D);
    [Global sharedSingleton].uiStyle.mode = (_btnMode.selected ? UIStyleModeNight : UIStyleModeDay);
    [[NSNotificationCenter defaultCenter] postNotificationName:kMsgChangeUIStyle object:nil];
}

- (void)onBrightnessBtn
{
    if (!_sliderBackground.hidden)
    {
        return;
    }
    
    _sliderBackground.hidden = NO;
    _sliderHideBtn.hidden = NO;
}

- (void)onHideSlideView
{
    _sliderBackground.hidden = YES;
    _sliderHideBtn.hidden = YES;
}

- (void)onBrightnessChange
{
    [UIScreen mainScreen].brightness = _sliderBrightness.value;
    [Global sharedSingleton].uiStyle.brightness = [UIScreen mainScreen].brightness;
}

#pragma mark UIPageViewControllerDataSource
- (UIViewController *)pageViewController:(EsNewsPageVCtler *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController
{
    UIViewController* vctler = nil;
    do {
        if (![viewController isKindOfClass:[EsNewsContentVCtler class]]) break;
        EsNewsContentVCtler* curVctler = (EsNewsContentVCtler* )viewController;
        vctler = [self newsContentVCtlerAtIndex:[_dataList indexOfObject:curVctler.newsInfo] - 1];
    } while (0);
    
    return vctler;
}

- (UIViewController *)pageViewController:(EsNewsPageVCtler *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController
{
    UIViewController* vctler = nil;
    do {
        if (![viewController isKindOfClass:[EsNewsContentVCtler class]]) break;
        EsNewsContentVCtler* curVctler = (EsNewsContentVCtler* )viewController;
        vctler = [self newsContentVCtlerAtIndex:[_dataList indexOfObject:curVctler.newsInfo] + 1];
    } while (0);
    
    return vctler;
}

- (void)pageViewController:(EsNewsPageVCtler *)pageViewController boundceDirection:(BoundaryViewChangedDirection)boundceDirection
{
    if (boundceDirection == BoundaryViewChangedDirectionLeft)
    {
        [self onLeftBoundary];
    }
    else if (boundceDirection == BoundaryViewChangedDirectionRight)
    {
        [self onRightBoundary];
    }
}

- (void)onLeftBoundary
{
    [self onLeftBtnAction:nil];
}

- (void)onRightBoundary
{
    ;
}

- (EsNewsContentVCtler* )newsContentVCtlerAtIndex:(NSInteger)index
{
    EsNewsContentVCtler* vctler = nil;
    if (index < 0 || index >= _dataList.count)
    {
        return vctler;
    }
    
    vctler = [EsNewsContentVCtler new];
    vctler.newsInfo = _dataList[index];
    if (_netAgent.reportList.count>0) {
        
        vctler.newsDetail = _netAgent.reportList[index];
    }
    if (self.netAgent.currentPage < self.netAgent.totalPage &&
        index+1 == _dataList.count)
    {
        __weak typeof(self) wself = self;
//        [self.netAgent getNewsList:self.netAgent.currentPage+1 completion:^
//         {
//             [wself onFinishGetNewsList];
//         }];
        [self.netAgent setParams:nil andSetMethod:nil completion:^{
            [wself onFinishGetNewsList];
        }];
    }
    
    return vctler;
}

- (void)onFinishGetNewsList
{
    NSLog(@"%s", __func__);
    _dataList = [NSMutableArray new];
    if (self.netAgent.newsHeadlines.count)
    {
        [_dataList addObjectsFromArray:self.netAgent.newsHeadlines];
    }
    if (self.netAgent.newsList.count)
    {
        [_dataList addObjectsFromArray:self.netAgent.newsList];
    }
    
    [[NSNotificationCenter defaultCenter] postNotificationName:kMsgNewsListRefresh object:nil];
}

@end
