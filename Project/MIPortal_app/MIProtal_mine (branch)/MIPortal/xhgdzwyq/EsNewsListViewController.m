//
//  EsNewsListViewController.m
//  xhgdzwyq
//
//  Created by Eshore on 13-11-10.
//  Copyright (c) 2013年 Eshore. All rights reserved.
//

#import "EsNewsListViewController.h"
#import "EsListPanViewController.h"
#import "EsLanmuViewController.h"

@interface EsNewsListViewController ()

@end

@implementation EsNewsListViewController

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
    // Do any additional setup after loading the view from its nib.
    //获取屏幕尺寸
    CGRect appRect = UIScreen.mainScreen.applicationFrame;
//    //根据屏幕设置view尺寸
//    self.view.frame = CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y, appRect.size.width, appRect.size.height);
    
    
    self.listPanViewController = [[EsListPanViewController alloc] initWithNibName:@"EsListPanViewController" bundle:[NSBundle mainBundle]];
    self.listPanViewController.delegate = self;
    self.listPanViewController.cprtDelegate = self;
    //注意，因为listPanViewController.view会调用viewDidLoad函数，而初始化时需要用到尺寸，所以在此之前制定尺寸
    self.listPanViewController.listPanFrame = CGRectMake(0, NLISTVIEW_HEADBAR_HEIGHT, appRect.size.width, appRect.size.height-NLISTVIEW_HEADBAR_HEIGHT-NLISTVIEW_BOTTOMEBAR_HEIGHT);
    
    [self.view addSubview:self.listPanViewController.view];
}

- (void)viewWillAppear:(BOOL)animated
{
    //标题
    self.categoryTitleLabel.text = self.szTitle;
    //设置scrollView的内容区域
    [self.listPanViewController setScrollviewContent:self.categoryNum curPage:self.categoryIndex];
    //配置底部pageControl指示器的属性
    self.pageCtrl.numberOfPages = self.categoryNum;
    self.pageCtrl.currentPage = self.categoryIndex;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)backBtn:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)viewDidUnload {
    [self setCategoryTitleLabel:nil];
    [self setPageCtrl:nil];
    [super viewDidUnload];
}

#pragma mark - EsChangeCategoryDelegate

- (void)categoryDidChanged: (NSInteger) categoryIndex
{
    self.categoryTitleLabel.text = [[self.father.lanmuBtns objectAtIndex:categoryIndex] titleText];
    self.pageCtrl.currentPage = categoryIndex;
    self.categoryIndex = categoryIndex;
}

#pragma mark - EsCorporationDelegate

- (void)pushViewCtrl: (UIViewController *)vCtrl currentViewCtrl:(UIViewController *)curVCtrl
{
    [self.navigationController pushViewController:vCtrl animated:YES];
}

- (void)popViewCtrlFromCurrentViewCtrl:(UIViewController *)curVCtrl
{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
