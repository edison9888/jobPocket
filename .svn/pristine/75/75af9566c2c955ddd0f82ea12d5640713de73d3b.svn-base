//
//  CTPointCommodityListVCtler.m
//  CTPocketV4
//
//  Created by Y W on 14-3-11.
//  Copyright (c) 2014年 广东亿迅科技有限公司. All rights reserved.
//

#import "CTPointCommodityListVCtler.h"
#import "EGORefreshTableHeaderView2.h"
#import "SIAlertView.h"
#import "CTPointExchangeCell.h"
#import "CTLoadingCell.h"
#import "UIColor+Category.h"

#import "IgProdList.h"

#import "CTPointCommodityDetailVCtler.h"
#import "CTPointConfirmExchangeVCtler.h"

#import <SDWebImage/SDWebImageManager.h>

//@interface CTPointCommodityListVCtler () <UITableViewDataSource, UITableViewDelegate>
@interface CTPointCommodityListVCtler ()

@property (nonatomic, readwrite, strong) NSMutableArray *CommodityList;
@property (nonatomic, strong) IgProdList *igProdListNetworking;
@property (nonatomic, assign) BOOL loading;
@property (nonatomic, assign) BOOL reloading;
@property (nonatomic, assign) BOOL isfinished;
@property (nonatomic, strong) EGORefreshTableHeaderView2 *refreshHeaderView;
@property (nonatomic, strong) UIView *coverView;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) ThreeSubView *sectionHeaderView;
@property (nonatomic, strong) UIButton *bottomRefresh;

@end

@implementation CTPointCommodityListVCtler

- (id)init
{
    self = [super init];
    if (self) {
        self.CommodityList = [NSMutableArray array];
        self.isfinished = NO;
        self.reloading = NO;
        self.PageIndex = 1;
        self.PageSize = 20;
    }
    return self;
}

//- (void)loadView
//{
//    {
//        UITableView *tableView = [[UITableView alloc] initWithFrame:[[UIScreen mainScreen] applicationFrame]];
//        tableView.backgroundColor = [UIColor clearColor];
//        tableView.backgroundView = nil;
//        tableView.dataSource = self;
//        tableView.delegate = self;
//        tableView.rowHeight = 61;
//        tableView.sectionHeaderHeight = 30;
//        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
//        
//        self.view = tableView;
//        
//        self.tableView = tableView;
//    }
//}

- (UITableView *) tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds];
        _tableView.backgroundColor = [UIColor colorWithRed:239/255. green:239/255. blue:239/255. alpha:1];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight ;
        _tableView.dataSource = (id<UITableViewDataSource>)self;
        _tableView.delegate = (id<UITableViewDelegate>)self;
        _tableView.rowHeight = 61;
        _tableView.sectionHeaderHeight = 30;
        [self.view addSubview:_tableView];
        
        if (!_refreshHeaderView) {
            _refreshHeaderView = [[EGORefreshTableHeaderView2 alloc] initWithFrame:CGRectMake(0.0f, 0.0f-_tableView.frame.size.height, self.view.frame.size.width, _tableView.frame.size.height)];
            _refreshHeaderView.backgroundColor = [UIColor clearColor];
            _refreshHeaderView.delegate = (id<EGORefreshTableHeaderDelegate2>)self;
            [self.tableView addSubview:_refreshHeaderView];
        }
        
    }
    
    return _tableView;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
//    self.title = @"积分查询";
    self.title = @"我可兑换";
    // 左按钮
    [self setLeftButton:[UIImage imageNamed:@"btn_back"]];
    
    [self tableView];
    [self refreshHeaderView];
    [_refreshHeaderView refreshLastUpdatedDate];
}

#pragma mark - funcs

- (void)goExchangeVC:(UIButton *)button
{
    CTPointConfirmExchangeVCtler *vc = [[CTPointConfirmExchangeVCtler alloc] init];
    vc.Integral = self.Integral;
    vc.commodityInfo = [self.CommodityList objectAtIndex:button.tag];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)goCommodityDetailVCWithIndexPath:(NSIndexPath *)indexPath
{
    CTPointCommodityDetailVCtler *vc = [[CTPointCommodityDetailVCtler alloc] init];
    vc.Integral = self.Integral;
    vc.commodityInfo = [self.CommodityList objectAtIndex:indexPath.row];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - networking

//查询可兑换的商品列表，需传入用户当前所拥有的积分最大值
- (void)igProdList
{
    if (self.igProdListNetworking == nil) {
        self.igProdListNetworking = [[IgProdList alloc] init];
    }
    __weak typeof(self) weakSelf = self;
    [self.igProdListNetworking igProdListWith:self.PageIndex PageSize:self.PageSize Sort:2 MinPrice:0 MaxPrice:self.Integral CommdityId:@"08" KeyWord:nil CategoryId:nil SmallCategoryId:nil finishBlock:^(NSDictionary *resultParams, NSError *error) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        
        strongSelf.reloading = NO;
        
        if ([error.userInfo[@"ResultCode"] isEqualToString:@"X104"]) {
            // 取消掉全部请求和回调，避免出现多个弹框
            [MyAppDelegate.cserviceEngine cancelAllOperations];
            // 提示重新登录
            SIAlertView *alertView = [[SIAlertView alloc] initWithTitle:nil
                                                             andMessage:@"长时间未登录，请重新登录。"];
            [alertView addButtonWithTitle:@"确定"
                                     type:SIAlertViewButtonTypeDefault
                                  handler:^(SIAlertView *alertView) {
                                      [MyAppDelegate showReloginVC];
                                      if (strongSelf.navigationController != nil)
                                      {
                                          [strongSelf.navigationController popViewControllerAnimated:NO];
                                      }
                                  }];
            
            alertView.transitionStyle = SIAlertViewTransitionStyleBounce;
            [alertView show];
            
            return;
        }
        
        NSDictionary *data = resultParams[@"Data"];
        id CommodityList = [data objectForKey:@"CommodityList"];
        if ([CommodityList isKindOfClass:[NSArray class]] && [CommodityList count] > 0) {
            self.isfinished = YES;
            [strongSelf.CommodityList addObjectsFromArray:CommodityList];
            [strongSelf.tableView reloadData];
//            self.PageIndex++;
        } else if ([CommodityList isKindOfClass:[NSDictionary class]]){
            NSArray *ListItem = [CommodityList objectForKey:@"ListItem"];
            if ([ListItem isKindOfClass:[NSArray class]] && ListItem.count > 0) {
                self.isfinished = YES;
                [strongSelf.CommodityList addObjectsFromArray:ListItem];
                [strongSelf.tableView reloadData];
//                self.PageIndex++;
            } else {
                //无数据
            }
        } else {
            //无数据
        }
    }];
    
}


#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
//    if (self.isfinished) {
//        return 1;
//    }
    
    return 2;
}

//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
//{
//    return self.CommodityList.count;
//}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section==1) {
        
        return 1;
    }
    return self.CommodityList.count ;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 1) {
        static NSString *loadcell = @"loadcell";
        CTLoadingCell *cell = [tableView dequeueReusableCellWithIdentifier:loadcell];
        if (cell==nil) {
            cell = [[CTLoadingCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:loadcell];
        }
        if (self.reloading) {
            [cell setView:YES];

        } else {
            [cell setView:NO];
        }
        
        return  cell;
    }
    
    static NSString *cellIdentifier = @"Cell";
    CTPointExchangeCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[CTPointExchangeCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    if (indexPath.row == [tableView numberOfRowsInSection:indexPath.section] - 1) {
        cell.separatorView.hidden = YES;
    } else {
        cell.separatorView.hidden = NO;
    }
    
    if (self.CommodityList.count > indexPath.row) {
        NSDictionary *dictionary = [self.CommodityList objectAtIndex:indexPath.row];
        
        cell.titleLabel.text = [dictionary objectForKey:@"CommodityName"];
        [cell.subTitleLabel.centerButton setTitle:[dictionary objectForKey:@"IntegralPrice"] forState:UIControlStateNormal];
        [cell.subTitleLabel.centerButton setEnabled:YES];
        cell.exchangeButton.tag = indexPath.row;
        [cell.exchangeButton addTarget:self action:@selector(goExchangeVC:) forControlEvents:UIControlEventTouchUpInside];
        
        cell.imageView.image = [UIImage imageNamed:@"CommodityListDefault"];
        NSString *PicUrl = [dictionary objectForKey:@"PicUrl"];
        if (PicUrl.length > 0) {
            [cell.imageView setImageWithURL:[NSURL URLWithString:PicUrl] placeholderImage:[UIImage imageNamed:@"CommodityListDefault"]];
        }
    }
    
    return cell;
}


#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 1) {
        return 0;
    }
    return 30;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == 1) {
        return nil;
    }
    if (self.sectionHeaderView == nil) {
        
        int adaptDistance = 10;
        
        CGRect rect = CGRectZero;
        rect.size.height = tableView.sectionHeaderHeight - adaptDistance;
        
        ThreeSubView *threeSubView = [[ThreeSubView alloc] initWithFrame:rect leftButtonSelectBlock:nil centerButtonSelectBlock:nil rightButtonSelectBlock:nil];
        threeSubView.backgroundColor = self.view.backgroundColor;
        
        [threeSubView.leftButton.titleLabel setFont:[UIFont systemFontOfSize:13]];
        [threeSubView.leftButton setTitleColor:[UIColor colorWithR:49 G:49 B:49 A:1] forState:UIControlStateNormal];
        [threeSubView.leftButton setTitleEdgeInsets:UIEdgeInsetsMake(5, 0, 0, 0)];
        [threeSubView.leftButton setTitle:@" 积分" forState:UIControlStateNormal];
        
        [threeSubView.centerButton.titleLabel setFont:[UIFont boldSystemFontOfSize:18]];
        [threeSubView.centerButton setTitle:[NSString stringWithFormat:@"%d", self.Integral] forState:UIControlStateNormal];
        [threeSubView.centerButton setTitleColor:[UIColor colorWithR:95 G:189 B:42 A:1] forState:UIControlStateNormal];
        
        [threeSubView.rightButton.titleLabel setFont:[UIFont systemFontOfSize:13]];
        [threeSubView.rightButton setTitleColor:[UIColor colorWithR:49 G:49 B:49 A:1] forState:UIControlStateNormal];
        [threeSubView.rightButton setTitleEdgeInsets:UIEdgeInsetsMake(5, 0, 0, 0)];
        [threeSubView.rightButton setTitle:@"，我可兑换以下商品" forState:UIControlStateNormal];
        [threeSubView autoLayout];
        
        rect = threeSubView.frame;
        rect.origin = CGPointZero;
        rect.size.width = CGRectGetWidth(tableView.frame);
        rect.size.height = tableView.sectionHeaderHeight;
        threeSubView.frame = rect;
        
        int blueWidth = 5;
        for (UIView *view in threeSubView.subviews) {
            if ([view isKindOfClass:[UIButton class]]) {
                CGRect rect = view.frame;
                rect.origin.x += blueWidth;
                rect.origin.y += adaptDistance;
                view.frame = rect;
            }
        }
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, adaptDistance, blueWidth, CGRectGetHeight(threeSubView.frame) - adaptDistance)];
        view.backgroundColor = [UIColor colorWithR:95 G:189 B:42 A:1];
        [threeSubView addSubview:view];
        
        self.sectionHeaderView = threeSubView;
    }
    return self.sectionHeaderView;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    [self goCommodityDetailVCWithIndexPath:indexPath];
}

#pragma mark - UIScrollViewDelegate

//- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
//{
//    if (self.CommodityList.count < self.PageIndex * self.PageSize) {
//        return;
//    }
//    
//    if (self.loading) {
//        return;
//    }
//    
//	if((scrollView.contentOffset.y > 0)) {
//        if (scrollView.contentSize.height > scrollView.frame.size.height) {
//            if (scrollView.contentOffset.y > scrollView.contentSize.height - scrollView.frame.size.height + 50) {
//                [self igProdList];
//            }
//        } else if (scrollView.contentOffset.y > 50) {
//            [self igProdList];
//        }
//    }
//}

#pragma mark -
#pragma mark UIScrollViewDelegate Methods

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
	CGPoint offset = scrollView.contentOffset;
    if (offset.y<0) {
        if (!self.reloading) {
            [_refreshHeaderView egoRefreshScrollViewDidScroll:scrollView];
        }
    }else
    {
        if (self.CommodityList && self.CommodityList.count>0 &&
            self.PageIndex >= 1){
            //判断是否到达底部
            CGRect bounds = scrollView.bounds;
            CGSize size = scrollView.contentSize;
            UIEdgeInsets inset = scrollView.contentInset;
            float y = offset.y + bounds.size.height - inset.bottom;
            float h = size.height;
            
            float reload_distance = 5;
            if(y > h + reload_distance) {
                
                if (!self.reloading) {
//                    if (self.isfinished) {
//                        return;
//                    }
                    
                    self.PageIndex++;
                    self.reloading = YES ;
                    [self.tableView reloadData];
                    [self igProdList];
                }
            }
        }
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
	
    [_refreshHeaderView egoRefreshScrollViewDidEndDragging:scrollView];
}

#pragma mark -refresh-
- (void)reloadTableViewDataSource
{
    NSLog(@"==开始加载数据");
    [self.tableView reloadData];//这里tableview要reloadData
}

- (void)doneLoadingTableViewData
{
    NSLog(@"===加载完数据");
    [_refreshHeaderView egoRefreshScrollViewDataSourceDidFinishedLoading:self.tableView];//这里要改成自己定义的tableview
}

#pragma mark -
#pragma mark EGORefreshTableHeaderDelegate Methods
- (void)egoRefreshTableHeaderDidTriggerRefresh:(EGORefreshTableHeaderView2*)view{
    
    [self reloadTableViewDataSource];
    [self performSelector:@selector(doneLoadingTableViewData) withObject:nil afterDelay:3.0];
    
}

- (BOOL)egoRefreshTableHeaderDataSourceIsLoading:(EGORefreshTableHeaderView2*)view{
    
    return _reloading; // should return if data source model is reloading
    
}

- (NSDate*)egoRefreshTableHeaderDataSourceLastUpdated:(EGORefreshTableHeaderView2*)view{
    
    return [NSDate date]; // should return date data source was last changed
    
}


@end
