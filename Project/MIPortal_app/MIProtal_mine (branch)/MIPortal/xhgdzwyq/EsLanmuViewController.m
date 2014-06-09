//
//  EsLanmuViewController.m
//  xhgdzwyq
//  栏目页面
//  Created by 温斯嘉 on 13-11-7.
//  Copyright (c) 2013年 Eshore. All rights reserved.
//

#import "EsLanmuViewController.h"
#import "EsNewsListViewController.h"

@interface EsLanmuViewController ()

- (void)showDefaultLanmus;
- (void)refreshLanmus;
- (CGRect)makeLanmuBtnRect:(NSInteger)vIndex;

@end

@implementation EsLanmuViewController

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
    
    //初始化
    self.mainScrollView.delegate = self;
    [self.mainScrollView setPagingEnabled:YES];
    self.lanmuBtns = [[NSMutableArray alloc] init];
    self.lanmuCtrler = [[EsLanmuCtrl alloc] init];
    
//    //初始化显示本地缓存的栏目
//    [self showDefaultLanmus];
    
    //对栏目进行观察
    self.lanmuCtrler.delegate = self;
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
//    //检查栏目更新
//    [self.lanmuCtrler getChanges];
    
    //刷新栏目显示
    [self refreshLanmus];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    [self setMainScrollView:nil];
    [super viewDidUnload];
}

#pragma mark - inner func
- (void)showDefaultLanmus
{
//    [self.lanmuCtrler getLanmus];
}

- (void)refreshLanmus
{
    NSArray *latestArr = [self.lanmuCtrler getLanmus];
    if (nil == latestArr) {
#warning wensj err log
        return;
    }
    
    NSInteger i = 0;
    for (i=0; i<latestArr.count; i++) {
        EsLanmuInfo *lanmuInfo = [latestArr objectAtIndex:i];
        if (i >= self.lanmuBtns.count) {
            //增加一个栏目
            UIImage *mainBgImg = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:lanmuInfo.bgImgUrl]]];
            EsLanmuBtn *lanmubtn = [[EsLanmuBtn alloc] initWithMainFrame:[self makeLanmuBtnRect: i] withMainBgImage:mainBgImg withTitle:lanmuInfo.titleText withTitleBgImg:nil atIndex:i];
            lanmubtn.delegate = self;
            [self.lanmuBtns addObject:lanmubtn];
            [self.mainScrollView addSubview:lanmubtn];
        }
        else {
            EsLanmuBtn *lanmubtn = [self.lanmuBtns objectAtIndex:i];
            if (![lanmubtn.titleText isEqualToString:lanmuInfo.titleText]) {
                lanmubtn.titleText = lanmuInfo.titleText;
            }
//            if (lanmubtn.index != lanmuInfo.index) {
//                lanmubtn.index = lanmuInfo.index;
//            }
#warning wensj 比较背景图元数据
        //...
        }
    }
    if (self.lanmuBtns.count > i) {
        for (NSInteger j=i; j<self.lanmuBtns.count; j++) {
            [[self.lanmuBtns objectAtIndex:j] removeFromSuperview];
        }
        [self.lanmuBtns removeObjectsInRange:NSMakeRange(i, self.lanmuBtns.count-i)];        
    }
}

- (CGRect)makeLanmuBtnRect:(NSInteger)vIndex
{
    NSInteger blockWidth_1 = self.view.bounds.size.width-LANMUVIEW_INSET_LEFT-LANMUVIEW_INSET_RIGHT;
    NSInteger blockWidth = (blockWidth_1 - LANMUVIEW_BLOCK_GAP)/2;
    NSInteger blockHeight = blockWidth;
    
    if (vIndex == 0) {
        return CGRectMake(LANMUVIEW_INSET_LEFT, LANMUVIEW_INSET_TOP, blockWidth_1, blockHeight);
    }
    else {
        EsLanmuBtn *lastBtn = [self.lanmuBtns objectAtIndex:(vIndex-1)];
        //判断是否要换一行
        if (lastBtn.frame.origin.x + lastBtn.frame.size.width + LANMUVIEW_BLOCK_GAP + blockWidth <= self.view.bounds.size.width-LANMUVIEW_INSET_RIGHT) {
            //不用换行
            return CGRectMake(lastBtn.frame.origin.x + lastBtn.frame.size.width + LANMUVIEW_BLOCK_GAP, lastBtn.frame.origin.y, blockWidth, blockHeight);
        }
        else {
            return CGRectMake(LANMUVIEW_INSET_LEFT, lastBtn.frame.origin.y + lastBtn.frame.size.height+LANMUVIEW_BLOCK_GAP, blockWidth, blockHeight);
//            //判断是否要换页
//            if (lastBtn.frame.origin.y + lastBtn.frame.size.height + LANMUVIEW_BLOCK_GAP + blockHeight <= self.view.bounds.size.height-LANMUVIEW_INSET_BOTTOM) {
//                //不用换页
//                return CGRectMake(LANMUVIEW_INSET_LEFT, lastBtn.frame.origin.y + lastBtn.frame.size.height+LANMUVIEW_BLOCK_GAP, blockWidth, blockHeight);
//            }
//            else {
//                NSInteger pages = lastBtn.frame.origin.x/self.view.bounds.size.width;
//                self.mainScrollView.bounds = CGRectMake(self.mainScrollView.bounds.origin.x, self.mainScrollView.bounds.origin.y, self.mainScrollView.bounds.size.width+self.view.bounds.size.width, self.view.bounds.size.height);
//                return CGRectMake(LANMUVIEW_INSET_LEFT + (pages+1) * self.view.bounds.size.width, LANMUVIEW_INSET_TOP, blockWidth, blockHeight);
                //暂时不考虑换页
//            }
        }
    }
}

#pragma mark - EsLanmuBtnDelegate

- (void)lanmuDidTapped:(EsLanmuBtn *)lanmuBtn
{
#warning wensj 写这里写这里
    NSLog(@"点击栏目项");
    if (nil == self.newsListViewCtrl) {
        self.newsListViewCtrl = [[EsNewsListViewController alloc] init];
        self.newsListViewCtrl.father = self;
    }
    
    //将栏目信息穿进去
    //栏目数量、当前栏目序号、栏目id、栏目标题
    self.newsListViewCtrl.categoryNum = self.lanmuBtns.count;
    self.newsListViewCtrl.szTitle = lanmuBtn.titleText;
    self.newsListViewCtrl.categoryIndex = lanmuBtn.index;
//    self
    //...
    
    [self.navigationController pushViewController:self.newsListViewCtrl animated:YES];
    
}

#pragma mark - lanmuArrayChangedDelegate
//每检测到一个有变化的栏目，对view进行相应调整
- (void)lanmuItemDidChanged:(EsLanmuInfo *)lanmuItem atViewIndex:(NSInteger)vIndex
{
#if 0
    //当栏目index没超过当前栏目数量时，替换／删除该栏目
    //当栏目index超过当前栏目数量时，增加栏目
    EsLanmuBtn *lanmuBtn = [[EsLanmuBtn alloc] initWithMainFrame:CGRectMake(20, 20, 100, 100) withMainBgImage:lanmuItem.bgImg withTitle:lanmuItem.titleText withTitleBgImg:nil atIndex:lanmuItem.index];
    lanmuBtn.delegate = self;
    
    [self.mainScrollView addSubview:lanmuBtn];
    
    
    ////
    
//    addbutton = [[BJGridItem alloc] initWithTitle:@"Add" withImageName:@"blueButton.jpg" atIndex:0 editable:NO];
//    
//    [addbutton setFrame:CGRectMake(20, 20, 100, 100)];
//    addbutton.delegate = self;
//    [scrollview addSubview: addbutton];
//    gridItems = [[NSMutableArray alloc] initWithCapacity:6];
//    [gridItems addObject:addbutton];
//    scrollview.delegate = self;
//    [scrollview setPagingEnabled:YES];
//    singletap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSingleTap:)];
//    [singletap setNumberOfTapsRequired:1];
//    singletap.delegate = self;
//    [scrollview addGestureRecognizer:singletap];
    
#endif

}

#pragma mark - userVerifyDelegate
- (void)tokenErr
{
    //当发生token错误时的处理
    //1.页面跳转
    //2.晴空本地缓存
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
//    CGRect frame = self.backgoundImage.frame;
//    
//    frame.origin.x = preFrame.origin.x + (preX - scrollView.contentOffset.x)/10 ;
//    
//    
//    if (frame.origin.x <= 0 && frame.origin.x > scrollView.frame.size.width - frame.size.width ) {
//        self.backgoundImage.frame = frame;
//    }
//    NSLog(@"offset:%f",(scrollView.contentOffset.x - preX));
//    NSLog(@"origin.x:%f",frame.origin.x);
    NSLog(@"划了一下");
    
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
//    preX = scrollView.contentOffset.x;
//    preFrame = backgoundImage.frame;
//    NSLog(@"prex:%f",preX);
    NSLog(@"开始划了一下");
}

@end
