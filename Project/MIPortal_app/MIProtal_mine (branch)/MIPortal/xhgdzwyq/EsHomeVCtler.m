//
//  EsHomeVCtler.m
//  xhgdzwyq
//
//  Created by apple on 13-11-28.
//  Copyright (c) 2013年 Eshore. All rights reserved.
//

#import "EsHomeVCtler.h"
#import "EsSettingVCtler.h"
#import "EsNewsColumn.h"
#import "EsNewsVCtler.h"
#import "EsColumnImageView.h"
#import "EsAddNewsViewCtler.h"
#import "EsChooseListViewCtler.h"
#import "EsMineViewCtler.h"
#import "EsReportViewCtler.h"
#import "EsNewsListVCtler.h"
@interface EsHomeVCtler ()
{
    UIScrollView*               _contentScroll;
    UIButton*                   _settingBtn;
    UIButton*                   _tipMsgBtn;
    UIButton*                   _cameraBtn;
    UIButton*                   _personBtn;
    UIButton*                   _reportBtn;
    UIActivityIndicatorView*    _inditorView;
}

@end

@implementation EsHomeVCtler

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
    
    {
        //this scrollview contains all models
        UIScrollView* v = [[UIScrollView alloc] initWithFrame:self.view.bounds];
        v.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
        v.backgroundColor = [UIColor clearColor];
        v.showsVerticalScrollIndicator = NO;
        [self.view addSubview:v];
        _contentScroll = v;
    }
    
    {
        UIActivityIndicatorView* v = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        v.center = self.view.center;
        v.hidesWhenStopped = YES;
        v.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleTopMargin;
        [self.view addSubview:v];
        _inditorView = v;
    }
    CGFloat iconY;
    CGFloat iconX;
    {
        // 设置按钮
        UIImage* nimg = [UIImage imageNamed:@"icon_setting"];
        UIImage* simg = [UIImage imageNamed:@"icon_setting_newversion"];
        int width     = nimg.size.width + 10;
        UIButton* btn = [UIButton buttonWithType:UIButtonTypeCustom];
        iconX = CGRectGetWidth(self.view.frame) - width - 10;
        iconY = CGRectGetHeight(self.view.frame) - width - 10;
        btn.frame     = CGRectMake(iconX, iconY , width, width);
        [btn setImage:nimg forState:UIControlStateNormal];
        [btn setImage:simg forState:UIControlStateSelected];
        [btn addTarget:self action:@selector(onSettingBtn) forControlEvents:UIControlEventTouchUpInside];
        [btn setAutoresizingMask:UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleTopMargin];
        [self.view addSubview:btn];
        _settingBtn   = btn;
    }
    
    {
        //照相按钮
        UIImage* nimg = [UIImage imageNamed:@"camera_home"];
        UIImage* simg = [UIImage imageNamed:@"camera_home_touch"];
        int width     = nimg.size.width;
        UIButton* btn = [UIButton buttonWithType:UIButtonTypeCustom];
        iconY         = iconY - width;
        btn.frame     = CGRectMake(iconX , iconY, width, width);
        [btn setImage:nimg forState:UIControlStateNormal];
        [btn setImage:simg forState:UIControlStateSelected];
        [btn addTarget:self action:@selector(onCameraBtn) forControlEvents:UIControlEventTouchUpInside];
        [btn setAutoresizingMask:UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleTopMargin];
        [self.view addSubview:btn];
        _cameraBtn  = btn;
    }
    
    {
        //个人按钮
        UIImage* nimg = [UIImage imageNamed:@"mine_home"];
        UIImage* simg = [UIImage imageNamed:@"mine_home_touch"];
        int width     = nimg.size.width;
        UIButton* btn = [UIButton buttonWithType:UIButtonTypeCustom];
        iconY         = iconY - width;
        btn.frame     = CGRectMake(iconX , iconY, width, width);
        [btn setImage:nimg forState:UIControlStateNormal];
        [btn setImage:simg forState:UIControlStateSelected];
        [btn addTarget:self action:@selector(onMineBtn) forControlEvents:UIControlEventTouchUpInside];
        [btn setAutoresizingMask:UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleTopMargin];
        [self.view addSubview:btn];
        _personBtn  = btn;
    }
/*
    {
        {
            //上传汇报
            UIImage* nimg = [UIImage imageNamed:@""];
            UIImage* simg = [UIImage imageNamed:@""];
            int width     = nimg.size.width;
            width     = 51;
            UIButton* btn = [UIButton buttonWithType:UIButtonTypeCustom];
            iconY         = iconY - width;
            btn.frame     = CGRectMake(iconX , iconY, width, width);
            [btn setImage:nimg forState:UIControlStateNormal];
            [btn setImage:simg forState:UIControlStateSelected];
            [btn setTitle:@"汇报" forState:UIControlStateNormal];
            [btn setTitleColor:[UIColor brownColor] forState:UIControlStateNormal];
            [btn addTarget:self action:@selector(onReportBtn) forControlEvents:UIControlEventTouchUpInside];
            [btn setAutoresizingMask:UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleTopMargin];
            [self.view addSubview:btn];
            _personBtn  = btn;
        }
    }
*/
    if ([Global sharedSingleton].columns.count <= 0)
    {
        __weak typeof(self) wself = self;
        [[Global sharedSingleton] getNewsColumn:^(BOOL success)
        {
            if (!success)
            {
                ToastAlertView * alert = [ToastAlertView new];
                [alert performSelector:@selector(showAlertMsg:) onThread:[NSThread mainThread] withObject:@"对不起，栏目列表获取失败" waitUntilDone:NO];
            }
            else
            {
                [wself performSelector:@selector(resetUI) onThread:[NSThread mainThread] withObject:nil waitUntilDone:YES];
            }
        }];
    }
    else
    {
        [self resetUI];
    }
    
    //检查是否有新的版本
    __weak typeof(_settingBtn) wbtn = _settingBtn;
    [[Global sharedSingleton] checkVersion:^(BOOL hasNewVersion)
     {
         wbtn.selected = hasNewVersion;
     }];
}

- (void)viewWillAppear:(BOOL)animated
{
    NSLog(@"%s", __func__);
    [super viewWillAppear:animated];
    //wensj set status bar
    [[[UIApplication sharedApplication]delegate]window].backgroundColor = [UIColor whiteColor];
    
    _inditorView.activityIndicatorViewStyle = ([Global sharedSingleton].uiStyle.mode == UIStyleModeDay ? UIActivityIndicatorViewStyleGray : UIActivityIndicatorViewStyleWhite);
    [_inditorView startAnimating];
}

- (void)viewWillDisappear:(BOOL)animated
{
    NSLog(@"%s", __func__);
    [super viewWillDisappear:animated];
    
#if 0 // modified by zy, 2014-01-03
    //wensj set status bar
    [[[UIApplication sharedApplication]delegate]window].backgroundColor = [UIColor redColor];
#endif
    
    [self.navigationController setNavigationBarHidden:NO];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self.navigationController setNavigationBarHidden:YES];
    [self resetUI];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [_contentScroll.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - 跳到上传汇报界面
//- (void)onReportBtn
//{
//    EsReportViewCtler *vctrler = [EsReportViewCtler new];
//    [self.navigationController pushViewController:vctrler animated:YES];
//}

#pragma mark - 跳到我的界面
- (void)onMineBtn
{
    EsMineViewCtler *vctrler = [EsMineViewCtler new];
    [self.navigationController pushViewController:vctrler animated:YES];
}

- (void)onCameraBtn
{
    EsAddNewsViewCtler *vctler = [EsAddNewsViewCtler new];
    [self.navigationController pushViewController:vctler animated:YES];
}

- (void)onSettingBtn
{
    EsSettingVCtler* vctler = [EsSettingVCtler new];
    [self.navigationController pushViewController:vctler animated:YES];
}

// 首页栏目列表，排列
- (void)resetUI
{
    //先把原来的干掉
    [_contentScroll.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    int originX = 15;
    int originY = 24;
    int page = 0;
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 70000
    if ( IOS7_OR_LATER )
    {
        originY += 20;
    }
#endif
    int initY = originY;
    NSArray* columns = [Global sharedSingleton].columns;
    __block NSInteger finishCount = columns.count;
    __weak typeof(self) wself = self;
    BOOL isHeadLine = YES;
    for (EsNewsColumn* column in columns)
    {
        EsColumnImageView* btn = [[EsColumnImageView alloc] initWithFrame:CGRectMake(originX, originY, 0, 0)
                                                               columnInfo:column
                                                               isHeadLine:isHeadLine
                                                               completion:^(EsColumnImageView *sender) {
                                                                   finishCount--;
                                                                   if (finishCount == 1)
                                                                   {
                                                                       [wself onImageLoadFinish];
                                                                   }
                                                               }];
        btn.tag = [columns indexOfObject:column];
        [btn addTarget:self action:@selector(onColumnBtn:) forControlEvents:UIControlEventTouchUpInside];
        [_contentScroll addSubview:btn];
        //计算下一个图形的位置
        if (CGRectGetMaxX(btn.frame) + CGRectGetWidth(btn.frame) > CGRectGetWidth(self.view.frame)) {
            //换行
            originX = 15;
            originY = CGRectGetMaxY(btn.frame) + 8;
        }
        else
        {
            originX = CGRectGetMaxX(btn.frame) + 8;
            if ([columns indexOfObject:column] == columns.count - 1)
            {
                originY = CGRectGetMaxY(btn.frame) + 18;
            }
        }
        //如果已经达到本页最大可容纳数，设置翻页
        isHeadLine = NO;
        if ((originY + CGRectGetHeight(btn.frame))> CGRectGetHeight(wself.view.frame)
                && [columns lastObject]!=column) {
            //当下一个按钮超出可是范围的高度时，把它设置到下一页
            originY = initY;
            page ++;
            isHeadLine = YES;//不设置的话，第一个会不拉开
        }
        originX = originX + page * CGRectGetWidth(wself.view.frame);
    }
        _contentScroll.contentSize = CGSizeMake((page+1)*CGRectGetWidth(self.view.frame), 0);
}

- (void)onImageLoadFinish
{
    [_inditorView stopAnimating];
}

- (void)onColumnBtn:(id)sender
{
    //无需通过EsNewsVCtler封装了，直接进入相应的子模块
#if 0
    if ([self.navigationController.topViewController isKindOfClass:[EsNewsVCtler class]])
    {
        // ios7在某些极端的情况下，当用两个手指快速切换栏目时，两个不同按钮的触摸事件会同时响应
        return;
    }

    EsNewsVCtler* vctler = [EsNewsVCtler new];
    vctler.selectColumn = ((UIButton* )sender).tag;
#endif
    //需要进入不同的业务类型，UI设计不一样，目前通过ID区分，后续需要改进
    EsNewsColumn *columnInfo = [[Global sharedSingleton].columns objectAtIndex:((UIButton* )sender).tag];
    if ([columnInfo.catalogId intValue] == -1)
    {
        //工作汇报
        EsReportViewCtler *vctler = [EsReportViewCtler new];
        [self.navigationController pushViewController:vctler animated:YES];
        
    }else{
        EsNewsListVCtler* vctler = [EsNewsListVCtler new];
        vctler.columnInfo = [[Global sharedSingleton].columns objectAtIndex:((UIButton* )sender).tag];
        [self.navigationController pushViewController:vctler animated:YES];

        
    }
    
}

@end
