//
//  EsNewsListVCtler.m
//  xhgdzwyq
//
//  Created by apple on 13-11-28.
//  Copyright (c) 2013年 Eshore. All rights reserved.
//

#import "EsNewsListVCtler.h"
#import "EsNewsItem.h"
#import "EsNewsCell.h"
#import "EsNewsDetailViewController.h"
#import "CTPRcScrollview.h"
#import "UIImageView+WebCache.h"
#import "EsLoadingMoreCell.h"
#import "EsNewsSectionView.h"
#import "EsNewsListNetAgent.h"
#import "ODRefreshControl.h"

@interface EsNewsListVCtler ()
{
    UITableView*    _contentTable;
    CTPRcScrollview* _headlineView;
    
    EsNewsListNetAgent*     _netAgent;
}

@end

@implementation EsNewsListVCtler

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)dealloc
{
    NSLog(@"%s", __func__);
    [_headlineView stopTimer];
    [[NSNotificationCenter defaultCenter] removeObserver:_contentTable];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    //设置返回按钮和标题
    [self setBackButton];
    [self setTitle:_columnInfo.catalogName];
    
    {
//        UITableView* v = [[UITableView alloc] initWithFrame:CGRectMake(0, 8, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame) - 8)];
        UITableView* v = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame))];
        v.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
        v.delegate     = (id<UITableViewDelegate>)self;
        v.dataSource   = (id<UITableViewDataSource>)self;
        v.separatorStyle = UITableViewCellSeparatorStyleNone;
        v.backgroundColor = [UIColor clearColor];
        [self.view addSubview:v];
        _contentTable = v;
        
        ODRefreshControl* refreshView = [[ODRefreshControl alloc] initInScrollView:v];
        [refreshView addTarget:self action:@selector(onRefreshAction:) forControlEvents:UIControlEventValueChanged];
    }
    
    {
        CTPRcScrollview* v = [[CTPRcScrollview alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), 150)];
        v.datasource = (id<CTPRcScrollViewDatasource>)self;
        v.delegate = (id<CTPRcScrollViewDelegate>)self;
        _headlineView = v;
    }
    
    [[NSNotificationCenter defaultCenter] addObserver:_contentTable
                                             selector:@selector(reloadData)
                                                 name:kMsgNewsListRefresh
                                               object:nil];
    
    _netAgent = [EsNewsListNetAgent new];
    _netAgent.columnInfo = self.columnInfo;
    _netAgent.loadingType = NewsTableLoadingTypeRefresh;
    
    __weak typeof(_contentTable) wtable = _contentTable;
    [_netAgent getNewsList:1 completion:^
    {
        [wtable reloadData];
    }];
    
    __weak typeof(_headlineView) wheadline = _headlineView;
    [_netAgent getHeadLines:1 completion:^(EsNewsListNetAgent* sender)
    {
        if (sender.newsHeadlines.count)
        {
            [wheadline reloadData];
            wtable.tableHeaderView = wheadline;
        }
        else
        {
            wtable.tableHeaderView = nil;
        }
    }];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [_contentTable reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)onRefreshAction:(ODRefreshControl* )sender
{
    __weak typeof(sender) wrefresh = sender;
    __weak typeof(_contentTable) wtable = _contentTable;
    __weak typeof(_headlineView) wheadline = _headlineView;
    [_netAgent refreshNewsList:^
    {
        [wrefresh endRefreshing];
        [wtable reloadData];
    } headlineCompletion:^(EsNewsListNetAgent *sender)
    {
        if (sender.newsHeadlines.count)
        {
            [wheadline reloadData];
            wtable.tableHeaderView = wheadline;
        }
        else
        {
            wtable.tableHeaderView = nil;
        }
    }];
}

#pragma mark UITableView
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (_netAgent.loadingType == NewsTableLoadingTypeLoadingMore)
    {
        return _netAgent.dayNewsList.count + 1;
    }
    else if (_netAgent.loadingType == NewsTableLoadingTypeRefresh)
    {
        return 1;
    }
    else if (_netAgent.loadingType == NewsTableLoadingTypeNone)
    {
        return _netAgent.dayNewsList.count;
    }
    
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 40;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    BOOL needLoadingView = NO;
    if (_netAgent.loadingType == NewsTableLoadingTypeRefresh)
    {
        needLoadingView = YES;
    }
    else if (_netAgent.loadingType == NewsTableLoadingTypeLoadingMore && _netAgent.dayNewsList.count == section)
    {
        needLoadingView = YES;
        __weak typeof(_contentTable) wtable = _contentTable;
        [_netAgent getNewsList:_netAgent.currentPage+1 completion:^
        {
            [wtable reloadData];
        }];
    }
    
    if (needLoadingView)
    {
        EsLoadingMoreCell * cell = [[EsLoadingMoreCell alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(tableView.frame), 40)];
        return cell;
    }
    else
    {
        EsNewsSectionView* v = [[EsNewsSectionView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(tableView.frame), 40)];
        EsDayNews* news = _netAgent.dayNewsList[section];
        v.verifyDate = news.verifyDate;
        v.week = news.week;
        return v;
    }
    
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [(EsNewsCell* )[self tableView:tableView cellForRowAtIndexPath:indexPath] getCellHeight];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (_netAgent.loadingType == NewsTableLoadingTypeLoadingMore && section != _netAgent.dayNewsList.count)
    {
        EsDayNews* news = _netAgent.dayNewsList[section];
        return news.news.count;
    }
    else if (_netAgent.loadingType == NewsTableLoadingTypeNone)
    {
        EsDayNews* news = _netAgent.dayNewsList[section];
        return news.news.count;
    }
    
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString* identifierStr = @"cell";
    EsNewsCell* cell = [tableView dequeueReusableCellWithIdentifier:identifierStr];
    if (!cell)
    {
        cell = [[EsNewsCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifierStr];
    }
    
    EsDayNews* news = _netAgent.dayNewsList[indexPath.section];
    cell.newsInfo = news.news[indexPath.row];
    cell.tag = indexPath.row;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"%s %d", __func__, indexPath.row);
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if ([self.navigationController.topViewController isKindOfClass:[EsNewsDetailViewController class]])
    {
        // ios7在某些极端的情况下，当用两个手指快速切换栏目时，两个不同按钮的触摸事件会同时响应
        return;
    }
          
    int count = indexPath.row + _netAgent.newsHeadlines.count;
    for (int i = 0; i < indexPath.section; i++)
    {
        EsDayNews* news = _netAgent.dayNewsList[i];
        count+= news.news.count;
    }
    
    EsNewsDetailViewController* vctler = [EsNewsDetailViewController new];
    vctler.netAgent = _netAgent;
    vctler.selectIdx = count;
    [self.navigationController pushViewController:vctler animated:YES];
    NSLog(@"%s %d end", __func__, indexPath.row);
}

#pragma mark CTPRcScrollview
- (NSInteger)numberOfPages
{
    return MIN(3, _netAgent.newsHeadlines.count);
}

- (UIView *)pageAtIndex:(NSInteger)index
{
    if (index < 0 || index >= _netAgent.newsHeadlines.count)
    {
        return nil;
    }
    
    UIImageView* v = [[UIImageView alloc] initWithFrame:_headlineView.bounds];
    EsNewsItem* item = _netAgent.newsHeadlines[index];
    if (item.headPicUrl)
    {
        [v setImageWithURL:[NSURL URLWithString:item.headPicUrl]];
    }
    
    UIButton* btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, CGRectGetHeight(_headlineView.frame) - 50, CGRectGetWidth(v.frame), 50);
    btn.backgroundColor = RGB(0, 0, 0, 0.4);
    btn.userInteractionEnabled = NO;
    [v addSubview:btn];
    
    {
        UILabel* lab = [[UILabel alloc] initWithFrame:CGRectInset(btn.bounds, 15, 0)];
        lab.backgroundColor = [UIColor clearColor];
        lab.textAlignment = UITextAlignmentLeft;
        lab.textColor = [UIColor whiteColor];
        lab.font = [UIFont systemFontOfSize:17];
        lab.numberOfLines = 2;
        lab.clipsToBounds = NO;
        [lab.layer setShadowOpacity:1];
        [lab.layer setShadowRadius:2];
        [lab.layer setShadowColor:[UIColor blackColor].CGColor];
        [lab.layer setShadowOffset:CGSizeMake(1, 1)];
        [btn addSubview:lab];
        
        if (item.newsTitle.length)
        {
            lab.text = item.newsTitle;
        }
    }
    
    return v;
}

- (void)didClickPage:(CTPRcScrollview *)csView atIndex:(NSInteger)index
{
    NSLog(@"%s %d", __func__, index);
    if ([self.navigationController.topViewController isKindOfClass:[EsNewsDetailViewController class]])
    {
        // ios7在某些极端的情况下，当用两个手指快速切换栏目时，两个不同按钮的触摸事件会同时响应
        return;
    }
    
    EsNewsDetailViewController* vctler = [EsNewsDetailViewController new];
    vctler.netAgent = _netAgent;
    vctler.selectIdx = index;
    [self.navigationController pushViewController:vctler animated:YES];
    NSLog(@"%s %d end", __func__, index);
}

@end
