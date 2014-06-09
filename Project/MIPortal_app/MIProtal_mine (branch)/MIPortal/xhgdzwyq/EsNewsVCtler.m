//
//  EsNewsVCtler.m
//  xhgdzwyq
//
//  Created by apple on 13-11-28.
//  Copyright (c) 2013年 Eshore. All rights reserved.
//

#import "EsNewsVCtler.h"
#import "EsNewsListVCtler.h"
#import "EsColumnTitleView.h"
#import "EsNewsPageVCtler.h"
#import "EsSettingVCtler.h"

@interface EsNewsVCtler ()
{
    EsColumnTitleView*          _titleView;
    EsNewsPageVCtler*           _pageCtler;
}

@property (nonatomic, strong) NSArray*      columnList;

@end

@implementation EsNewsVCtler

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.columnList = [Global sharedSingleton].columns;
        
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 70000
        if ( IOS7_OR_LATER )
            self.navigationController.interactivePopGestureRecognizer.enabled = NO;
#endif
    }
    return self;
}

- (void)dealloc
{
    NSLog(@"%s", __func__);
    [_titleView removeFromSuperview];
    [_pageCtler removeFromParentViewController];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    {
        EsColumnTitleView* v = [[EsColumnTitleView alloc] initWithFrame:CGRectZero columns:self.columnList];
        v.selectedIndex = self.selectColumn;
        [self.navigationController.navigationBar addSubview:v];
        [self.navigationController.navigationBar bringSubviewToFront:v];
        _titleView = v;
    }
        
    {
        EsNewsPageVCtler* v = [EsNewsPageVCtler new];
        v.view.frame = self.view.bounds;
        v.delegate = (id<EsNewsPageVCtlerDelegate>)self;
        [self addChildViewController:v];
        [self.view addSubview:v.view];
        _pageCtler = v;
        
        EsNewsListVCtler* vctler = [self newsListVCtlerAtIndex:self.selectColumn];
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
            lab.backgroundColor = [UIColor clearColor];
            v.leftBoundaryView = lab;
        }
        
        {
            UILabel* lab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 40, 20)];
            lab.text = @"设置 ";
            lab.textAlignment = UITextAlignmentRight;
            lab.textColor = [UIColor grayColor];
            lab.font = [UIFont systemFontOfSize:12];
            lab.backgroundColor = [UIColor clearColor];
            v.rightBoundaryView = lab;
        }
        
        __weak typeof (self) wself = self;
        __weak typeof (_pageCtler) wpageCtler = _pageCtler;
        _titleView.columnBlock = ^(NSInteger idx)
        {
            EsNewsListVCtler* vctler = [wself newsListVCtlerAtIndex:idx];
            if (vctler)
            {
                [wpageCtler setCurrentVCtler:vctler];
            }
        };
    }
}

- (void)viewWillAppear:(BOOL)animated
{
    NSLog(@"%s", __func__);
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

#pragma mark UIPageViewControllerDataSource
- (UIViewController *)pageViewController:(EsNewsPageVCtler *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController
{
    UIViewController* vctler = nil;
    do {
        if (![pageViewController.currentVCtler isKindOfClass:[EsNewsListVCtler class]])
        {
            break;
        }
        
        EsNewsListVCtler* curVCtler = (EsNewsListVCtler* )pageViewController.currentVCtler;
        NSInteger curIdx = [_columnList indexOfObject:curVCtler.columnInfo];
        vctler = [self newsListVCtlerAtIndex:curIdx - 1];
    } while (0);
    
    return vctler;
}

- (UIViewController *)pageViewController:(EsNewsPageVCtler *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController
{
    UIViewController* vctler = nil;
    do {
        if (![pageViewController.currentVCtler isKindOfClass:[EsNewsListVCtler class]])
        {
            break;
        }
        
        EsNewsListVCtler* curVCtler = (EsNewsListVCtler* )pageViewController.currentVCtler;
        NSInteger curIdx = [_columnList indexOfObject:curVCtler.columnInfo];
        vctler = [self newsListVCtlerAtIndex:curIdx + 1];
    } while (0);
    
    return vctler;
}

- (void)pageViewController:(EsNewsPageVCtler* )pageViewController transitionCompleted:(BOOL)transitionCompleted
{
    do {
        if (![pageViewController.currentVCtler isKindOfClass:[EsNewsListVCtler class]])
        {
            break;
        }
        
        EsNewsListVCtler* vctler = (EsNewsListVCtler* )pageViewController.currentVCtler;
        self.selectColumn = [_columnList indexOfObject:vctler.columnInfo];
        _titleView.selectedIndex = self.selectColumn;
    } while (0);
}

- (EsNewsListVCtler* )newsListVCtlerAtIndex:(NSInteger)index
{
    NSLog(@"%s %d", __func__, index);
    EsNewsListVCtler* vctler = nil;
    if (index < 0 || index >= self.columnList.count)
    {
        return vctler;
    }
    
    vctler = [EsNewsListVCtler new];
    vctler.columnInfo = self.columnList[index];
    
    return vctler;
}

- (void)pageViewController:(EsNewsPageVCtler *)pageViewController boundceDirection:(BoundaryViewChangedDirection)boundceDirection
{
    if (boundceDirection == BoundaryViewChangedDirectionLeft)
    {
        [self onLeftBtnAction:nil];
    }
    else if (boundceDirection == BoundaryViewChangedDirectionRight)
    {
        EsSettingVCtler* vctler = [EsSettingVCtler new];
        [self.navigationController pushViewController:vctler animated:YES];
    }
}

@end
