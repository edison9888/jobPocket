//
//  CTPointExchangeRecordVCtler.m
//  CTPocketV4
//
//  Created by Y W on 14-3-14.
//  Copyright (c) 2014年 广东亿迅科技有限公司. All rights reserved.
//

#import "CTPointExchangeRecordVCtler.h"

#import "SIAlertView.h"
#import "CTPointExchangeRecordCell.h"
#import "CTTextCenterCell.h"
#import "SVProgressHUD.h"

#import "UIView+RoundRect.h"
#import "UIImage+Category.h"
#import "UIColor+Category.h"

#import "IgUserInfo.h"
#import "IgOrderList.h"

#import "CTRedeemVCtler.h"
#import "CTPointCardCode.h"

typedef NS_ENUM(NSUInteger, ExchangeRecordMonth)
{
    ExchangeRecordMonthOne = 1,
    ExchangeRecordMonthThree = 2,
    ExchangeRecordMonthSix = 3
};

@interface CTPointExchangeRecordVCtler () <UITableViewDataSource, UITableViewDelegate>


@property (nonatomic, strong) NSMutableArray *oneMonthArray;
@property (nonatomic, assign) NSUInteger onePageIndex;


@property (nonatomic, strong) NSMutableArray *threeMonthArray;
@property (nonatomic, assign) NSUInteger threePageIndex;


@property (nonatomic, strong) NSMutableArray *sixMonthArray;
@property (nonatomic, assign) NSUInteger sixPageIndex;

@property (nonatomic, assign) NSUInteger pageSize;


@property (nonatomic, assign) ExchangeRecordMonth currentExchangeRecordMonth;
@property (nonatomic, weak) NSMutableArray *currentMonthArray;
@property (nonatomic, assign) NSUInteger currentPageIndex;
@property (nonatomic, strong) IgOrderList *igOrderListNetworking;
@property (nonatomic, assign) BOOL loading;

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIView *sectionHeaderView;
@property (nonatomic, strong) UIView *sectionFooterView;
@property (nonatomic, strong) ThreeSubView *monthControlView;

@end


@implementation CTPointExchangeRecordVCtler

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // 标题
        self.title = @"积分兑换记录";
        // 左按钮
        [self setLeftButton:[UIImage imageNamed:@"btn_back"]];
        
        self.oneMonthArray = [NSMutableArray array];  self.onePageIndex = 1;
        self.threeMonthArray = [NSMutableArray array];  self.threePageIndex = 1;
        self.sixMonthArray = [NSMutableArray array];  self.sixPageIndex = 1;
        
        self.pageSize = 20;
    }
    return self;
}

- (void)loadView
{
    UITableView *tableView = [[UITableView alloc] initWithFrame:[[UIScreen mainScreen] applicationFrame]];
    tableView.dataSource = self;
    tableView.delegate = self;
    tableView.rowHeight = 110;
    tableView.sectionHeaderHeight = 100;
    tableView.sectionFooterHeight = 50;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    self.view = tableView;
    
    self.tableView = tableView;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // 左右滑动手势
    {
        UISwipeGestureRecognizer *recognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleRecognizer:)];
        [recognizer setDirection:UISwipeGestureRecognizerDirectionLeft];
        [self.view addGestureRecognizer:recognizer];
    }
    
    {
        UISwipeGestureRecognizer *recognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleRecognizer:)];
        [recognizer setDirection:UISwipeGestureRecognizerDirectionRight];
        [self.view addGestureRecognizer:recognizer];
    }
    
    self.currentExchangeRecordMonth = ExchangeRecordMonthThree;
    [self loadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
    switch (self.currentExchangeRecordMonth) {
        case ExchangeRecordMonthOne:
            [self.threeMonthArray removeAllObjects]; self.threePageIndex = 1;
            [self.sixMonthArray removeAllObjects]; self.sixPageIndex = 1;
            break;
        case ExchangeRecordMonthThree:
            [self.oneMonthArray removeAllObjects]; self.onePageIndex = 1;
            [self.sixMonthArray removeAllObjects]; self.sixPageIndex = 1;
            break;
        case ExchangeRecordMonthSix:
            [self.threeMonthArray removeAllObjects]; self.threePageIndex = 1;
            [self.oneMonthArray removeAllObjects]; self.onePageIndex = 1;
            break;
        default:
            break;
    }
}

#pragma mark - action

- (void)nowExchange
{
    CTRedeemVCtler *vc = [[CTRedeemVCtler alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)handleRecognizer:(UISwipeGestureRecognizer *)recognizer
{
    switch (recognizer.direction) {
        case UISwipeGestureRecognizerDirectionLeft:
        {
            if (self.currentExchangeRecordMonth == ExchangeRecordMonthThree) {
                
                self.monthControlView.rightButton.hidden = YES;
                self.monthControlView.rightButton.enabled = NO;
                [self.monthControlView.rightButton setBackgroundColor:[UIColor colorWithR:169 G:169 B:169 A:1]];
                [self.monthControlView.leftButton setBackgroundColor:[UIColor colorWithR:95 G:189 B:42 A:1]];
                [self.monthControlView.centerButton setTitle:@"近6个月" forState:UIControlStateNormal];
                [self.monthControlView.centerButton.titleLabel setTextAlignment:UITextAlignmentCenter];
                [self.monthControlView.leftButton setTitle:@"     近3个月   " forState:UIControlStateNormal];
                
                self.currentExchangeRecordMonth = ExchangeRecordMonthSix;
                
                [self loadData];
            }
            else if (self.currentExchangeRecordMonth == ExchangeRecordMonthOne)
            {
                self.monthControlView.leftButton.hidden = NO;
                self.monthControlView.rightButton.hidden = NO;
                self.monthControlView.leftButton.enabled = YES;
                [self.monthControlView.leftButton setBackgroundColor:[UIColor colorWithR:95 G:189 B:42 A:1]];
                [self.monthControlView.rightButton setBackgroundColor:[UIColor colorWithR:95 G:189 B:42 A:1]];
                [self.monthControlView.leftButton setTitle:@"   近1个月     " forState:UIControlStateNormal];
//                [self.monthControlView.centerButton setTitle:@"             近3个月             " forState:UIControlStateNormal];
                [self.monthControlView.centerButton setTitle:@"近3个月" forState:UIControlStateNormal];
                [self.monthControlView.centerButton.titleLabel setTextAlignment:UITextAlignmentCenter];
                [self.monthControlView.rightButton setTitle:@"     近6个月             " forState:UIControlStateNormal];
                
                self.currentExchangeRecordMonth = ExchangeRecordMonthThree;
                
                [self loadData];
            }
        }
            break;
        case UISwipeGestureRecognizerDirectionRight:
        {
            if (self.currentExchangeRecordMonth == ExchangeRecordMonthThree)
            {
                
                self.monthControlView.leftButton.hidden = YES;
                self.monthControlView.leftButton.enabled = NO;
                [self.monthControlView.rightButton setBackgroundColor:[UIColor colorWithR:95 G:189 B:42 A:1]];
                [self.monthControlView.leftButton setBackgroundColor:[UIColor colorWithR:169 G:169 B:169 A:1]];
                [self.monthControlView.centerButton setTitle:@"近1个月" forState:UIControlStateNormal];
                [self.monthControlView.centerButton.titleLabel setTextAlignment:UITextAlignmentCenter];
                [self.monthControlView.rightButton setTitle:@"近3个月          " forState:UIControlStateNormal];
                
                self.currentExchangeRecordMonth = ExchangeRecordMonthOne;
                
                [self loadData];
            }
            else if (self.currentExchangeRecordMonth == ExchangeRecordMonthSix)
            {
                self.monthControlView.leftButton.hidden = NO;
                self.monthControlView.rightButton.hidden = NO;
                self.monthControlView.rightButton.enabled = YES;
                [self.monthControlView.leftButton setBackgroundColor:[UIColor colorWithR:95 G:189 B:42 A:1]];
                [self.monthControlView.rightButton setBackgroundColor:[UIColor colorWithR:95 G:189 B:42 A:1]];
                [self.monthControlView.leftButton setTitle:@"   近1个月     " forState:UIControlStateNormal];
//                [self.monthControlView.centerButton setTitle:@"     近3个月             " forState:UIControlStateNormal];
                [self.monthControlView.centerButton setTitle:@"近3个月" forState:UIControlStateNormal];
                [self.monthControlView.centerButton.titleLabel setTextAlignment:UITextAlignmentCenter];
                [self.monthControlView.rightButton setTitle:@"     近6个月             " forState:UIControlStateNormal];
                
                self.currentExchangeRecordMonth = ExchangeRecordMonthThree;
                
                [self loadData];
            }
        }
            break;
        default:
            break;
    }
}

#pragma mark - funcs

- (void)loadData
{
    switch (self.currentExchangeRecordMonth) {
        case ExchangeRecordMonthOne:
            self.currentMonthArray = self.oneMonthArray;
            self.currentPageIndex = self.onePageIndex;
            break;
        case ExchangeRecordMonthThree:
            self.currentMonthArray = self.threeMonthArray;
            self.currentPageIndex = self.threePageIndex;
            break;
        case ExchangeRecordMonthSix:
            self.currentMonthArray = self.sixMonthArray;
            self.currentPageIndex = self.sixPageIndex;
            break;
        default:
            break;
    }
    
    if (self.currentMonthArray.count == 0) {
        [self loadMore];
    } else {
        [self.tableView reloadData];
    }
    [self.tableView reloadData];
}

- (void)gotoCardCodeVC:(UIButton *)button
{
    NSDictionary *dictionary = [self.currentMonthArray objectAtIndex:button.tag];
    
    CTPointCardCode *cardCodeVC = [CTPointCardCode new];
    cardCodeVC.orderId = [dictionary objectForKey:@"OrderId"];  //订单id
    cardCodeVC.commodityName = [dictionary objectForKey:@"CommodityName"]; //商品名称
    [self.navigationController pushViewController:cardCodeVC animated:YES];
}

#pragma mark - networking

- (void)checkError:(NSError *)error
{
    if (error.userInfo[@"ResultCode"])
    {
        if ([error.userInfo[@"ResultCode"] isEqualToString:@"X104"])
        {
            // 取消掉全部请求和回调，避免出现多个弹框
            [MyAppDelegate.cserviceEngine cancelAllOperations];
            // 提示重新登录
            SIAlertView *alertView = [[SIAlertView alloc] initWithTitle:nil
                                                             andMessage:@"长时间未登录，请重新登录。"];
            [alertView addButtonWithTitle:@"确定"
                                     type:SIAlertViewButtonTypeDefault
                                  handler:^(SIAlertView *alertView) {
                                      [MyAppDelegate showReloginVC];
                                      if (self.navigationController != nil)
                                      {
                                          [self.navigationController popViewControllerAnimated:NO];
                                      }
                                  }];
            
            alertView.transitionStyle = SIAlertViewTransitionStyleBounce;
            [alertView show];
        }
    }
}

- (void)loadMore
{
    self.loading = YES;
    
    if (self.igOrderListNetworking == nil) {
        self.igOrderListNetworking = [[IgOrderList alloc] init];
    } else {
        [self.igOrderListNetworking cancel];
    }
    
    
    NSDictionary *loginInfoDict = [Global sharedInstance].loginInfoDict;
    NSString *DeviceNo = loginInfoDict[@"UserLoginName"];
    
    [SVProgressHUD showWithStatus:@"加载中..." maskType:SVProgressHUDMaskTypeGradient];
    
    __weak typeof(self) weakSelf = self;
    [[IgUserInfo shareIgUserInfo] igUserInfoWithDeviceNo:DeviceNo finishBlock:^(NSDictionary *resultParams, NSError *error) {
        __weak typeof(weakSelf) strongSelf = weakSelf;
        if (error) {
            [strongSelf checkError:error];
            strongSelf.loading = NO;
            [SVProgressHUD dismiss];
            return;
        }
        
        NSDictionary *data = resultParams[@"Data"];
        NSString *CustId = [data objectForKey:@"CustId"];
        if (CustId) {
            [strongSelf.igOrderListNetworking igOrderListWithPageIndex:[NSString stringWithFormat:@"%d", strongSelf.currentPageIndex] PageSize:[NSString stringWithFormat:@"%d", strongSelf.pageSize] DeviceNo:DeviceNo DeviceType:@"7" ProvinceId:@"35" CustId:CustId OrderId:nil Status:@"1" DataType:[NSString stringWithFormat:@"%d", strongSelf.currentExchangeRecordMonth] finishBlock:^(NSDictionary *resultParams, NSError *error) {
                strongSelf.loading = NO;
                [SVProgressHUD dismiss];
                if (error) {
                    [strongSelf checkError:error];
                    return;
                }
                
                NSDictionary *data = resultParams[@"Data"];
                NSDictionary *OrderList = [data objectForKey:@"OrderList"];
                id ListItem = [OrderList objectForKey:@"ListItem"];
                if ([ListItem isKindOfClass:[NSArray class]]) {
                    [strongSelf.currentMonthArray addObjectsFromArray:ListItem];
                } else if ([ListItem isKindOfClass:[NSDictionary class]]) {
                    [strongSelf.currentMonthArray addObject:ListItem];
                }
                [strongSelf.tableView reloadData];
            }];
        } else {
            self.loading = NO;
            [SVProgressHUD dismiss];
        }
    }];
}



#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if ( 0 == self.currentMonthArray.count) {
        return 1;
    }
    return self.currentMonthArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.currentMonthArray.count > 0) {
        static NSString *cellIdentifier = @"Cell";
        CTPointExchangeRecordCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if (cell == nil) {
            cell = [[CTPointExchangeRecordCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
            cell.backgroundColor = [UIColor clearColor];
            cell.contentView.backgroundColor = [UIColor clearColor];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        
        if (indexPath.row == [tableView numberOfRowsInSection:indexPath.section] - 1) {
            cell.separatorView.hidden = YES;
        } else {
            cell.separatorView.hidden = NO;
        }
        
        if (self.currentMonthArray.count > indexPath.row) {
            NSDictionary *dictionary = [self.currentMonthArray objectAtIndex:indexPath.row];
            
            NSString *dateString = [dictionary objectForKey:@"CreateTime"];
            NSRange range = [dateString rangeOfString:@" "];
            if (range.location != NSNotFound) {
                dateString = [dateString substringToIndex:range.location];
                dateString = [dateString stringByReplacingOccurrencesOfString:@"/" withString:@"-"];
            }
            NSString *pointString = [dictionary objectForKey:@"IntegralPrice"];
            NSString *nameString = [dictionary objectForKey:@"CommodityName"];
            NSString *countString = [dictionary objectForKey:@"BuyNum"];
            
            [cell.dateView.centerButton setTitle:dateString forState:UIControlStateNormal];
            [cell.dateView.centerButton setEnabled:YES];
            [cell.pointView.centerButton setTitle:pointString forState:UIControlStateNormal];
            [cell.pointView.centerButton setEnabled:YES];
            [cell.nameView.centerButton setTitle:nameString forState:UIControlStateNormal];
            [cell.nameView.centerButton setEnabled:YES];
            [cell.countView.centerButton setTitle:countString forState:UIControlStateNormal];
            [cell.countView.centerButton setEnabled:YES];
            
            cell.cardCodeButton.hidden = YES;
            cell.cardCodeButton.tag = indexPath.row;
            [cell.cardCodeButton addTarget:self action:@selector(gotoCardCodeVC:) forControlEvents:UIControlEventTouchUpInside];
            NSString *typeId = [dictionary objectForKey:@"TypeId"];
            if ([typeId integerValue]==2) {
                cell.cardCodeButton.hidden = NO;
            }
        }
        return cell;
    } else {
        static NSString *centerCellIdentifier = @"centerCell";
        CTTextCenterCell *cell = [tableView dequeueReusableCellWithIdentifier:centerCellIdentifier];
        if (cell == nil) {
            cell = [[CTTextCenterCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:centerCellIdentifier];
            cell.backgroundColor = [UIColor clearColor];
            cell.contentView.backgroundColor = [UIColor clearColor];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.textLabel.text = @"";
            cell.textLabel.textColor = [UIColor colorWithR:49 G:49 B:49 A:1];
        }
        
        if (!self.loading) {
            cell.textLabel.text = @"暂无积分兑换纪录";
        } else {
            cell.textLabel.text = @"";
        }
        
        return cell;
    }
}


#pragma mark - UITableViewDelegate


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (self.sectionHeaderView == nil) {
        
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(tableView.frame), 0)];
        view.backgroundColor = self.view.backgroundColor;
        
        int yOffset = 15.0;
        {
            NSDictionary *loginInfoDict = [Global sharedInstance].loginInfoDict;
            NSString *phoneNbr = loginInfoDict[@"UserLoginName"] ? loginInfoDict[@"UserLoginName"] : @"";
            // 查询号码
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(20, 20, 280, 14)];
            label.backgroundColor = [UIColor clearColor];
            label.font = [UIFont systemFontOfSize:14.0f];
            label.textColor = [UIColor colorWithR:49 G:49 B:49 A:1];
            label.text = [NSString stringWithFormat:@"查询号码：%@", phoneNbr];
            [view addSubview:label];
            
            yOffset = CGRectGetMaxY(label.frame) + 15;
        }
        
        {
            UIView *separator = [[UIView alloc] initWithFrame:CGRectMake(0, yOffset, CGRectGetWidth(tableView.frame), 1)];
            separator.backgroundColor = [UIColor colorWithRed:0.84f green:0.84f blue:0.84f alpha:1.00f];
            [view addSubview:separator];
            
            yOffset = CGRectGetMaxY(separator.frame) + 8;
        }
        
        {
            CGRect rect = CGRectZero;
            rect.origin.y = yOffset;
            rect.size.height = 38;
            
            __weak typeof(self) weakSelf = self;
            ThreeSubView *threeSubView = [[ThreeSubView alloc] initWithFrame:rect];
            self.monthControlView = threeSubView;
            [threeSubView setLeftButtonSelectBlock:^{
                //相当于往右滑动
                __strong typeof(weakSelf) strongSelf = weakSelf;
                UISwipeGestureRecognizer *recognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:nil action:nil];
                [recognizer setDirection:UISwipeGestureRecognizerDirectionRight];
                [strongSelf handleRecognizer:recognizer];
            } centerButtonSelectBlock:^{
            } rightButtonSelectBlock:^{
                //相当于往左滑动
                __strong typeof(weakSelf) strongSelf = weakSelf;
                UISwipeGestureRecognizer *recognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:nil action:nil];
                [recognizer setDirection:UISwipeGestureRecognizerDirectionLeft];
                [strongSelf handleRecognizer:recognizer];
            }];
            
            threeSubView.backgroundColor = self.view.backgroundColor;
            
            [threeSubView.leftButton.titleLabel setFont:[UIFont boldSystemFontOfSize:14]];
            [threeSubView.leftButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [threeSubView.leftButton setTitle:@"   近1个月     " forState:UIControlStateNormal];
            [threeSubView.leftButton setTitle:@"" forState:UIControlStateDisabled];
            [threeSubView.leftButton setBackgroundColor:[UIColor colorWithR:95 G:189 B:42 A:1]];
//            [threeSubView.leftButton setBackgroundImage:[UIImage imageNamed:@"his_mth_01.png"]
//                                                forState:UIControlStateNormal];
            
            [threeSubView.centerButton.titleLabel setFont:[UIFont boldSystemFontOfSize:14]];
            [threeSubView.centerButton setTitleColor:[UIColor colorWithR:95 G:189 B:42 A:1] forState:UIControlStateNormal];
            [threeSubView.centerButton setTitle:@"             近3个月             " forState:UIControlStateNormal];
            
            [threeSubView.rightButton.titleLabel setFont:[UIFont boldSystemFontOfSize:14]];
            [threeSubView.rightButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [threeSubView.rightButton setTitle:@"     近6个月             " forState:UIControlStateNormal];
            [threeSubView.rightButton setTitle:@"" forState:UIControlStateDisabled];
            [threeSubView.rightButton setBackgroundColor:[UIColor colorWithR:95 G:189 B:42 A:1]];
//            [threeSubView.rightButton setBackgroundImage:[UIImage imageNamed:@"his_mth_02.png"]
//                                                forState:UIControlStateNormal];
            
            [threeSubView autoLayout];
            
            [threeSubView.leftButton dwMakeRightRoundCornerWithRadius:19];
            [threeSubView.rightButton dwMakeLeftRoundCornerWithRadius:19];
            
            [view addSubview:threeSubView];
        }
        
        CGRect rect = view.frame;
        rect.size.height = yOffset;
        view.frame = rect;
        
        self.sectionHeaderView = view;
    }
    return self.sectionHeaderView;
}


- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    if (self.sectionFooterView == nil) {
        UIView *mView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(tableView.frame), 50)];
        mView.backgroundColor = self.view.backgroundColor;
        
        {
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            button.backgroundColor = [UIColor clearColor];
            button.frame = CGRectMake(ceilf((CGRectGetWidth(mView.frame) - 270)/2.0), ceilf((CGRectGetHeight(mView.frame) - 40)/2.0), 270, 40);
            button.titleLabel.font = [UIFont boldSystemFontOfSize:15];
            [button addTarget:self action:@selector(nowExchange) forControlEvents:UIControlEventTouchUpInside];
            [button setBackgroundImage:[UIImage imageNamed:@"pointExchange"] forState:UIControlStateNormal];
            [button setBackgroundImage:[UIImage imageNamed:@"pointExchange_hl"] forState:UIControlStateHighlighted];
            [button setTitleEdgeInsets:UIEdgeInsetsMake(0, 30, 0, 0)];
            [button setTitle:@"继续兑换" forState:UIControlStateNormal];
            [mView addSubview:button];
        }
        
        self.sectionFooterView = mView;
    }
    return self.sectionFooterView;
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    if (self.currentMonthArray.count < self.currentPageIndex * self.pageSize) {
        return;
    }
    
    if (self.loading) {
        return;
    }
    
	if((scrollView.contentOffset.y > 0)) {
        if (scrollView.contentSize.height > scrollView.frame.size.height) {
            if (scrollView.contentOffset.y > scrollView.contentSize.height - scrollView.frame.size.height + 50) {
                self.currentPageIndex++;
                switch (self.currentExchangeRecordMonth) {
                    case ExchangeRecordMonthOne:
                        self.onePageIndex++;
                        break;
                    case ExchangeRecordMonthThree:
                        self.threePageIndex++;
                        break;
                    case ExchangeRecordMonthSix:
                        self.sixPageIndex++;
                        break;
                    default:
                        break;
                }
                [self loadMore];
            }
        }
        else if (scrollView.contentOffset.y > 50) {
            self.currentPageIndex++;
            switch (self.currentExchangeRecordMonth) {
                case ExchangeRecordMonthOne:
                    self.onePageIndex++;
                    break;
                case ExchangeRecordMonthThree:
                    self.threePageIndex++;
                    break;
                case ExchangeRecordMonthSix:
                    self.sixPageIndex++;
                    break;
                default:
                    break;
            }
            [self loadMore];
        }
    }
}

@end
