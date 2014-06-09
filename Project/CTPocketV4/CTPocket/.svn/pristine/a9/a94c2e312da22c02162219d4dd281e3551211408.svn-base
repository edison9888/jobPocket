//
//  CTMyOrderListVCtler.m
//  CTPocketV4
//
//  Created by 许忠洲 on 13-11-26.
//  Copyright (c) 2013年 广东亿迅科技有限公司. All rights reserved.
//  订单列表

#import "CTMyOrderListVCtler.h"
#import "CTMyOrderCell.h"
#import "AppDelegate.h"
#import "NSDate+Extensions.h"
#import "CTPPointExchangeVCtler.h"
#import "CTOrderDetailVCtler.h"
#import "CTDeliverStatusVCtler.h"
#import "SIAlertView.h"
#import "SVProgressHUD.h"
#import "CTRechargeVCtler.h"
#import "ToastAlertView.h"
#import "CTOrderRechargeVCtler.h"
@interface CTMyOrderListVCtler () <UITableViewDataSource, UITableViewDelegate>
{
    UIButton *_monthBtn1;
    UIButton *_monthBtn2;
    UITableView *_monthTableView1;
    UITableView *_monthTableView2;
    
    int _curPage1;                    // 当前页
    int _pageSize1;                   // 每页条数
    BOOL _endReached1;                // 是否到底，到底隐藏加载更多cell
    NSMutableArray *_dataList1;
    int _curPage2;                    // 当前页
    int _pageSize2;                   // 每页条数
    BOOL _endReached2;                // 是否到底，到底隐藏加载更多cell
    NSMutableArray *_dataList2;
}
@property (assign, nonatomic) BOOL isLoadingMore1;   // 是否正在加载更多，是的话不再请求数据
@property (assign, nonatomic) BOOL isLoadingMore2;   // 是否正在加载更多，是的话不再请求数据

@end

@implementation CTMyOrderListVCtler

static NSDateFormatter *df;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
        // 标题
        self.title = @"我的订单";
        // 左按钮
        [self setLeftButton:[UIImage imageNamed:@"btn_back"]];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    //add by liuruxian 2014-03-21
    /*
        特殊埋点（多个页面共享的类）
    */
    
    NSString *name = @"";
    switch ([_orderType integerValue]) {
        case 0:
            name = [NSString stringWithFormat:@"所有订单%@",[self class]];
            break;
            
        case 3:
              name = [NSString stringWithFormat:@"待支付订单%@",[self class]];
            break;
        case 4:
              name = [NSString stringWithFormat:@"待收货订单%@",[self class]];
            break;
        case 5:
              name = [NSString stringWithFormat:@"已完成订单%@",[self class]];
            break;
    }
    
//    [TrackingHelper trackPageLoadedState:NSStringFromClass([self class])];
    
    _monthBtn1 = [UIButton buttonWithType:UIButtonTypeCustom];
    _monthBtn1.frame = CGRectMake(0, 0, 160, 40);
    [_monthBtn1 setBackgroundImage:[UIImage imageNamed:@"recharge_unselected_bg"] forState:UIControlStateNormal];
    [_monthBtn1 setBackgroundImage:[UIImage imageNamed:@"recharge_selected_bg"] forState:UIControlStateSelected];
    _monthBtn1.titleLabel.font = [UIFont systemFontOfSize:14.0f];
    [_monthBtn1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_monthBtn1 setTitle:@"近一个月的订单" forState:UIControlStateNormal];
    [_monthBtn1 addTarget:self action:@selector(onMonth1Action) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_monthBtn1];
    
    _monthBtn2 = [UIButton buttonWithType:UIButtonTypeCustom];
    _monthBtn2.frame = CGRectMake(160, 0, 160, 40);
    [_monthBtn2 setBackgroundImage:[UIImage imageNamed:@"recharge_unselected_bg"] forState:UIControlStateNormal];
    [_monthBtn2 setBackgroundImage:[UIImage imageNamed:@"recharge_selected_bg"] forState:UIControlStateSelected];
    _monthBtn2.titleLabel.font = [UIFont systemFontOfSize:14.0f];
    [_monthBtn2 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_monthBtn2 setTitle:@"一个月以前的订单" forState:UIControlStateNormal];
    [_monthBtn2 addTarget:self action:@selector(onMonth2Action) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_monthBtn2];
    
    _monthTableView1 = [[UITableView alloc] initWithFrame:CGRectMake(0, 40, self.view.bounds.size.width, self.view.bounds.size.height-40) style:UITableViewStylePlain];
    _monthTableView1.autoresizingMask = UIViewAutoresizingFlexibleHeight;
    _monthTableView1.separatorStyle = UITableViewCellSeparatorStyleNone;
    _monthTableView1.delegate = self;
    _monthTableView1.dataSource = self;
    [self.view addSubview:_monthTableView1];
    
    _monthTableView2 = [[UITableView alloc] initWithFrame:CGRectMake(0, 40, self.view.bounds.size.width, self.view.bounds.size.height-40) style:UITableViewStylePlain];
    _monthTableView2.autoresizingMask = UIViewAutoresizingFlexibleHeight;
    _monthTableView2.separatorStyle = UITableViewCellSeparatorStyleNone;
    _monthTableView2.delegate = self;
    _monthTableView2.dataSource = self;
    [self.view addSubview:_monthTableView2];
    
    // 设置初始状态
    _monthBtn1.selected = YES;
    _monthBtn2.selected = NO;
    _monthTableView1.hidden = NO;
    _monthTableView2.hidden = YES;
    
    df = [[NSDateFormatter alloc] init];
    [df setDateFormat:@"yyyy-MM-dd"];
    
    // 初始化数据
    {
        _curPage1 = 1;
        _pageSize1 = 20;
        _endReached1 = NO;
        _dataList1 = [NSMutableArray array];
        self.isLoadingMore1 = NO;
        
        _curPage2 = 1;
        _pageSize2 = 20;
        _endReached2 = NO;
        _dataList2 = [NSMutableArray array];
        self.isLoadingMore2 = NO;
    }
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onPayAction:) name:@"onPayAction" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onExpressStatusAction:) name:@"onExpressStatusAction" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onRechargeAction:) name:@"卡密充值" object:nil];
    // add by liuruxian 2014-04-15
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onCancelAction) name:@"onCancelAction" object:nil]; 
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - Custom

- (void)onMonth1Action
{
    if (_monthBtn1.selected == NO)
    {
        _monthBtn1.selected = YES;
        _monthBtn2.selected = NO;
        _monthTableView1.hidden = NO;
        _monthTableView2.hidden = YES;
    }
}

- (void)onMonth2Action
{
    if (_monthBtn2.selected == NO)
    {
        _monthBtn1.selected = NO;
        _monthBtn2.selected = YES;
        _monthTableView1.hidden = YES;
        _monthTableView2.hidden = NO;
    }
}

- (void)loadMore1
{
    if (self.isLoadingMore1 == NO) {
        self.isLoadingMore1 = YES;
        // 获取数据
        [self qryOrderList1];
    }
}

- (void)loadMore2
{
    if (self.isLoadingMore2 == NO) {
        self.isLoadingMore2 = YES;
        // 获取数据
        [self qryOrderList2];
    }
}

- (void)qryOrderList1
{
    
    NSString *userId = [Global sharedInstance].custInfoDict[@"UserId"] ? [Global sharedInstance].custInfoDict[@"UserId"] : @"FSD88888";
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
                            userId, @"UserId",
                            [NSString stringWithFormat:@"%d", _curPage1], @"PageIndex",
                            [NSString stringWithFormat:@"%d", _pageSize1], @"PageSize",
                            self.orderType, @"Type",
                            [df stringFromDate:[[NSDate date] dateBySubtractingDays:30]], @"StartTime",
                            [df stringFromDate:[NSDate date]], @"EndTime", nil];
    
    [MyAppDelegate.cserviceEngine postXMLWithCode:@"qryOrderList"
                                           params:params
                                      onSucceeded:^(NSDictionary *dict) {
                                          
                                          _curPage1++;
                                          if ([dict[@"Data"][@"DataList"] isKindOfClass:[NSArray class]])
                                          {
                                              [_dataList1 addObjectsFromArray:dict[@"Data"][@"DataList"]];
                                              if ([dict[@"Data"][@"DataList"] count] < 20)
                                              {
                                                  _endReached1 = YES;
                                              }
                                          }
                                          else if ([dict[@"Data"][@"DataList"] isKindOfClass:[NSDictionary class]])
                                          {
                                              [_dataList1 addObject:dict[@"Data"][@"DataList"]];
                                              _endReached1 = YES;
                                          }
                                          else if (dict[@"Data"][@"DataList"] == nil)
                                          {
                                              _endReached1 = YES;
                                          }
                                          self.isLoadingMore1 = NO;
                                          [_monthTableView1 reloadData];
                                          
                                          if ([_dataList1 count] <= 0)
                                          {
                                              UILabel *tipLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 44, 320, 44)];
                                              tipLabel.backgroundColor = [UIColor clearColor];
                                              tipLabel.font = [UIFont systemFontOfSize:17.0f];
                                              tipLabel.textColor = [UIColor blackColor];
                                              tipLabel.textAlignment = UITextAlignmentCenter;
                                              tipLabel.text = @"暂无订单！";
                                              [_monthTableView1 addSubview:tipLabel];
                                          }
                                          
                                      } onError:^(NSError *engineError) {
                                          self.isLoadingMore1 = NO;
                                          [_monthTableView1 reloadData];
                                          DDLogInfo(@"%s--%@", __func__, engineError);
                                          if (engineError.userInfo[@"ResultCode"])
                                          {
                                              if ([engineError.userInfo[@"ResultCode"] isEqualToString:@"X104"])
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
                                      }];
}

- (void)qryOrderList2
{
    NSString *userId = [Global sharedInstance].custInfoDict[@"UserId"] ? [Global sharedInstance].custInfoDict[@"UserId"] : @"FSD88888";
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
                            userId, @"UserId",
                            [NSString stringWithFormat:@"%d", _curPage2], @"PageIndex",
                            [NSString stringWithFormat:@"%d", _pageSize2], @"PageSize",
                            self.orderType, @"Type",
                            @"", @"StartTime",
                            [df stringFromDate:[[NSDate date] dateBySubtractingDays:31]], @"EndTime", nil];
    
    [MyAppDelegate.cserviceEngine postXMLWithCode:@"qryOrderList"
                                           params:params
                                      onSucceeded:^(NSDictionary *dict) {
                                          
                                          _curPage2++;
                                          if ([dict[@"Data"][@"DataList"] isKindOfClass:[NSArray class]])
                                          {
                                              [_dataList2 addObjectsFromArray:dict[@"Data"][@"DataList"]];
                                              if ([dict[@"Data"][@"DataList"] count] < 20)
                                              {
                                                  _endReached2 = YES;
                                              }
                                          }
                                          else if ([dict[@"Data"][@"DataList"] isKindOfClass:[NSDictionary class]])
                                          {
                                              [_dataList2 addObject:dict[@"Data"][@"DataList"]];
                                              _endReached2 = YES;
                                          }
                                          else if (dict[@"Data"][@"DataList"] == nil)
                                          {
                                              _endReached2 = YES;
                                          }
                                          
                                          self.isLoadingMore2 = NO;
                                          [_monthTableView2 reloadData];
                                          
                                          if ([_dataList2 count] <= 0)
                                          {
                                              UILabel *tipLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 44, 320, 44)];
                                              tipLabel.backgroundColor = [UIColor clearColor];
                                              tipLabel.font = [UIFont systemFontOfSize:17.0f];
                                              tipLabel.textColor = [UIColor blackColor];
                                              tipLabel.textAlignment = UITextAlignmentCenter;
                                              tipLabel.text = @"暂无订单！";
                                              [_monthTableView2 addSubview:tipLabel];
                                          }
                                          
                                      } onError:^(NSError *engineError) {
                                          self.isLoadingMore2 = NO;
                                          [_monthTableView2 reloadData];
                                          DDLogInfo(@"%s--%@", __func__, engineError);
                                          if (engineError.userInfo[@"ResultCode"])
                                          {
                                              if ([engineError.userInfo[@"ResultCode"] isEqualToString:@"X104"])
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
                                      }];
}

#pragma 通知消息 取消订单

- (void)onCancelAction
{
    if (!_monthTableView1.hidden)
    {
        [_dataList1 removeAllObjects];
        //重新请求数据
        _curPage1 = 1;
        _pageSize1 = 20;
        self.isLoadingMore1 = NO;
        _endReached1 = NO ;
        [_monthTableView1 reloadData];
        [self qryOrderList1];
    }else
    {
        [_dataList2 removeAllObjects];
        //重新请求数据
        _curPage2 = 1;
        _pageSize2 = 20;
        self.isLoadingMore2 = NO;
        _endReached2 = NO ;
        [_monthTableView2 reloadData];
        [self qryOrderList2];
    }
}


//modified by huangfq 2014-5-28
- (void)onPayAction:(NSNotification *)notification
{
//    NSString *orderId = [notification object];
//    NSString *userId = [Global sharedInstance].custInfoDict[@"UserId"] ? [Global sharedInstance].custInfoDict[@"UserId"] : @"FSD88888";
//    
//    NSString *payUrl = [NSString stringWithFormat:@"http://wapzt.189.cn/pay/onlinePay.do?method=getOrder&userid=%@&id=%@", userId, orderId];
//    CTPPointExchangeVCtler *vctler = [CTPPointExchangeVCtler new];
//    vctler.jumpUrl = payUrl;
//    vctler.title = @"订单支付";
//    vctler.fullScreen = YES;
//    vctler.needBack2Rootview = NO;
//    [self.navigationController pushViewController:vctler animated:YES];
    
    NSMutableDictionary *info = [NSMutableDictionary dictionaryWithDictionary:[notification userInfo]];
    NSLog(@"info:%@",info);
    
    NSMutableDictionary *orderInfo = nil;
    if ([info[@"Items"] isKindOfClass:[NSArray class]])
    {
        orderInfo = [info[@"Items"][0] mutableCopy];
    }
    else if ([info[@"Items"] isKindOfClass:[NSDictionary class]])
    {
       orderInfo = [info[@"Items"] mutableCopy];
    }

    
    [orderInfo setObject:info[@"OrderType"] forKey:@"Type"];
    //1 为购买手机
    if ([info[@"OrderType"] isEqualToString:@"1"]) {
        
        [orderInfo setObject:@"6" forKey:@"Type"];
    }
    else if ([info[@"OrderType"] isEqualToString:@"4"])
    {
        [orderInfo setObject:@"1" forKey:@"Type"];
        
    }
    [orderInfo setObject:info[@"OrderId"] forKey:@"OrderId"];
    
    NSString *OrderId = info[@"OrderId"];
    NSString *userId = [Global sharedInstance].custInfoDict[@"UserId"] ? [Global sharedInstance].custInfoDict[@"UserId"] : @"FSD88888";
    
    NSString *payUrl = [NSString stringWithFormat:@"http://wapzt.189.cn/pay/onlinePay.do?method=getOrder&userid=%@&id=%@", userId, OrderId];
    
    CTOrderRechargeVCtler * vctler = [CTOrderRechargeVCtler new];
    vctler.jumpUrl = payUrl;
    vctler.title = @"订单支付";
    vctler.fullScreen = YES;
    vctler.orderInfo = orderInfo ;
    vctler.comeType  = 1;
    
    [self.navigationController pushViewController:vctler animated:YES];

//    id OrderId = [[dict objectForKey:@"Data"]objectForKey:@"OrderId"];
//    if (OrderId) {
//        NSString *payUrl = [NSString stringWithFormat:@"http://wapzt.189.cn/pay/onlinePay.do?method=getOrder&userid=%@&id=%@", self.UserId, OrderId];
//        NSLog(@"%@",payUrl) ;
//        
//        NSMutableDictionary *dictionary = [[NSMutableDictionary alloc]initWithDictionary:par];
//        [dictionary setObject:payUrl forKey:@"payUrl"];  //跳转web
//        [dictionary setObject:@"0" forKey:@"PageType"];
//        
//        [dictionary setObject:OrderId forKey:@"OrderId"];
//        NSString *realPrice = [[dict objectForKey:@"Data"]objectForKey:@"OrderPrice"];// 选择充值金额
//        [dictionary setObject:realPrice forKey:@"RealPrice"];   //实际付款金额  当前金额假如有折扣的话 没有则和实际相同
//        [dictionary setObject:[par objectForKey:@"PayAmount"] forKey:@"OrderPrice"];
//        NSString * flow = @"";
//        flow = [flow stringByAppendingString:@"M"];
//        [dictionary setObject:flow forKey:@"Flow"];
//        [dictionary setObject:[[dict objectForKey:@"Data"]objectForKey:@"Flow"] forKey:@"Flow"];
//        
//        [dictionary setObject:[[dict objectForKey:@"Data"]objectForKey:@"OrderCreatedDate"] forKey:@"OrderCreatedDate"];
//        [dictionary setObject:@"" forKey:@"OrderPayedDate"];
//        
//        [dictionary setObject:@"未支付" forKey:@"OrderStatusDescription"];
//        [dictionary setObject:@"10010" forKey:@"OrderStatusCode"];
//        [dictionary setObject:weakSelf.UserId forKey:@"UserId"];
//        
//        //充值卡所需的参数
//        [dictionary setObject:@"-1" forKey:@"CardType"];    //充值卡类型  话费卡  流量卡
//        [dictionary setObject:@"-1" forKey:@"AmountOpts"];  //选择充值的金额
//        
//        [[NSNotificationCenter defaultCenter]postNotificationName:CTP_MSG_RECHARGE_BANK object:dictionary];
//        
//    }

}

- (void)onExpressStatusAction:(NSNotification *)notification
{
    NSString *orderId = [notification object];
    
    CTDeliverStatusVCtler *vc = [[CTDeliverStatusVCtler alloc] init];
    vc.orderId = orderId;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)onRechargeAction:(NSNotification *)notification
{
    [SVProgressHUD showWithStatus:@"查询卡密中..." maskType:SVProgressHUDMaskTypeBlack];
    
    NSString *orderId = [[notification object] objectForKey:@"orderId"];
    NSInteger tag = [[[notification object] objectForKey:@"tag"] integerValue];
    NSString *userId = [Global sharedInstance].custInfoDict[@"UserId"] ? [Global sharedInstance].custInfoDict[@"UserId"] : @"FSD88888";
    
    // 查询卡密
    NSDictionary *params = @{@"UserId": userId,
                             @"OrderId": orderId};
    
    [MyAppDelegate.cserviceEngine postXMLWithCode:@"CardBuyInfo"
                                           params:params
                                      onSucceeded:^(NSDictionary *dict) {
                                          
                                          [SVProgressHUD dismiss];
                                          CTRechargeVCtler *vc = [[CTRechargeVCtler alloc] init];
                                          if (tag == 4)
                                          {
                                              // 话费卡
                                              [vc recharge:0 cardPsdWord:dict[@"Data"][@"CardPwd"] rechageNum:YES];
                                          }
                                          else if (tag == 42)
                                          {
                                              // 流量卡
                                              [vc recharge:1 cardPsdWord:dict[@"Data"][@"CardPwd"] rechageNum:YES];
                                          }
                                          else
                                          {
                                              [vc recharge:0 cardPsdWord:@"" rechageNum:NO];
                                          }
                                          [vc setLeftButton:[UIImage imageNamed:@"btn_back.png"]];
                                          [self.navigationController pushViewController:vc animated:YES];
                                          
                                      } onError:^(NSError *engineError) {
                                          
                                          if (engineError.userInfo[@"ResultCode"])
                                          {
                                              if ([engineError.userInfo[@"ResultCode"] isEqualToString:@"X104"])
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
                                                                        }];
                                                  alertView.transitionStyle = SIAlertViewTransitionStyleBounce;
                                                  [alertView show];
                                              }
                                              else
                                              {
                                                  [SVProgressHUD showErrorWithStatus:@"卡密查询失败！"];
                                              }
                                          }
                                          
                                      }];
}

#pragma mark - UITableViewDataSource

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([tableView isEqual:_monthTableView1])
    {
        if (indexPath.section == 1) {
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LoadMoreCell1"];
            if (cell == nil) {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"LoadMoreCell1"];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                
                UIActivityIndicatorView *spin = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
                [spin setFrame:CGRectMake(100, 12, 20, 20)];
                [spin setTag:1];
                [cell.contentView addSubview:spin];
                
                cell.textLabel.font = [UIFont systemFontOfSize:14];
                cell.textLabel.textColor = [UIColor grayColor];
                cell.textLabel.textAlignment = UITextAlignmentCenter;
                cell.textLabel.text = @"加载中...";
            }
            
            UIActivityIndicatorView *spin = (UIActivityIndicatorView *)[cell.contentView viewWithTag:1];
            [spin startAnimating];
            
            [self loadMore1];
            return cell;
        }
        
        static NSString *kCellIdentifier = @"MyOrderCellId1";
        CTMyOrderCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellIdentifier];
        if (cell == nil) {
            cell = [[CTMyOrderCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kCellIdentifier];
        }
        [cell setCellInfo:_dataList1[indexPath.row]];
        return cell;
    }
    else
    {
        if (indexPath.section == 1) {
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LoadMoreCell2"];
            if (cell == nil) {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"LoadMoreCell2"];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                
                UIActivityIndicatorView *spin = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
                [spin setFrame:CGRectMake(100, 12, 20, 20)];
                [spin setTag:1];
                [cell.contentView addSubview:spin];
                
                cell.textLabel.font = [UIFont systemFontOfSize:14];
                cell.textLabel.textColor = [UIColor grayColor];
                cell.textLabel.textAlignment = UITextAlignmentCenter;
                cell.textLabel.text = @"加载中...";
            }
            
            UIActivityIndicatorView *spin = (UIActivityIndicatorView *)[cell.contentView viewWithTag:1];
            [spin startAnimating];
            
            [self loadMore2];
            return cell;
        }
        
        static NSString *kCellIdentifier = @"MyOrderCellId2";
        CTMyOrderCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellIdentifier];
        if (cell == nil) {
            cell = [[CTMyOrderCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kCellIdentifier];
        }
        [cell setCellInfo:_dataList2[indexPath.row]];
        return cell;
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // 1个对话的Sections+1个Load More Section
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if ([tableView isEqual:_monthTableView1])
    {
        if (section == 1) {
            if (_endReached1) {
                return 0;
            }
            return 1;
        }
        
        return [_dataList1 count];
    }
    else
    {
        if (section == 1) {
            if (_endReached2) {
                return 0;
            }
            return 1;
        }
        
        return [_dataList2 count];
    }
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 1)
    {
        return 44.0f;
    }
    else
    {
        return 206.0f;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([tableView isEqual:_monthTableView1])
    {
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
        if (indexPath.section == 0)
        {
            CTOrderDetailVCtler *vc = [[CTOrderDetailVCtler alloc] init];
            vc.ordrId = _dataList1[indexPath.row][@"OrderId"];
    
            NSDictionary *info = _dataList1[indexPath.row];
            NSString *SalesProdType = @"0";
            if ([info[@"Items"] isKindOfClass:[NSArray class]])
            {
                SalesProdType = info[@"Items"][1][@"SalesProdType"];
            }
            else if ([info[@"Items"] isKindOfClass:[NSDictionary class]])
            {
                SalesProdType = info[@"Items"][@"SalesProdType"];
            }
            if ((([info[@"OrderStatusCode"] intValue] == 11108) || ([info[@"OrderStatusCode"] intValue] == 11109)) &&
                ([SalesProdType isEqualToString:@"4"] || [SalesProdType isEqualToString:@"42"]))
            {
                [vc setcardInfo:0 cardType:[SalesProdType intValue]];
            }
            else
            {
                [vc setcardInfo:1 cardType:[SalesProdType intValue]];
            }
            
            NSLog(@"info111:%@",info);
            //added by huangfq 2014-5-29
            NSMutableDictionary *orderInfo = nil;
            if ([info[@"Items"] isKindOfClass:[NSArray class]])
            {
                orderInfo = [info[@"Items"][0] mutableCopy];
            }
            else if ([info[@"Items"] isKindOfClass:[NSDictionary class]])
            {
                orderInfo = [info[@"Items"] mutableCopy];
            }
            
            
            [orderInfo setObject:info[@"OrderType"] forKey:@"Type"];
            //1 为购买手机
            if ([info[@"OrderType"] isEqualToString:@"1"]) {
                
                [orderInfo setObject:@"6" forKey:@"Type"];
            }
            else if ([info[@"OrderType"] isEqualToString:@"4"])
            {
                [orderInfo setObject:@"1" forKey:@"Type"];
                
            }
            [orderInfo setObject:info[@"OrderId"] forKey:@"OrderId"];
            vc.orderInfo = orderInfo;
            
            
            [self.navigationController pushViewController:vc animated:YES];
        }
    }
    else if ([tableView isEqual:_monthTableView2])
    {
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
        if (indexPath.section == 0)
        {
            CTOrderDetailVCtler *vc = [[CTOrderDetailVCtler alloc] init];
            vc.ordrId = _dataList2[indexPath.row][@"OrderId"];
            
            NSDictionary *info = _dataList2[indexPath.row];
            NSString *SalesProdType = @"0";
            if ([info[@"Items"] isKindOfClass:[NSArray class]])
            {
                SalesProdType = info[@"Items"][1][@"SalesProdType"];
            }
            else if ([info[@"Items"] isKindOfClass:[NSDictionary class]])
            {
                SalesProdType = info[@"Items"][@"SalesProdType"];
            }
            if ((([info[@"OrderStatusCode"] intValue] == 11108) || ([info[@"OrderStatusCode"] intValue] == 11109)) &&
                ([SalesProdType isEqualToString:@"4"] || [SalesProdType isEqualToString:@"42"]))
            {
                [vc setcardInfo:0 cardType:[SalesProdType intValue]];
            }
            else
            {
                [vc setcardInfo:1 cardType:[SalesProdType intValue]];
            }
            
            NSLog(@"info111:%@",info);
            //added by huangfq 2014-5-29
            NSMutableDictionary *orderInfo = nil;
            if ([info[@"Items"] isKindOfClass:[NSArray class]])
            {
                orderInfo = [info[@"Items"][0] mutableCopy];
            }
            else if ([info[@"Items"] isKindOfClass:[NSDictionary class]])
            {
                orderInfo = [info[@"Items"] mutableCopy];
            }
            
            
            [orderInfo setObject:info[@"OrderType"] forKey:@"Type"];
            //1 为购买手机
            if ([info[@"OrderType"] isEqualToString:@"1"]) {
                
                [orderInfo setObject:@"6" forKey:@"Type"];
            }
            else if ([info[@"OrderType"] isEqualToString:@"4"])
            {
                [orderInfo setObject:@"1" forKey:@"Type"];
                
            }
            [orderInfo setObject:info[@"OrderId"] forKey:@"OrderId"];
            vc.orderInfo = orderInfo;

            
            [self.navigationController pushViewController:vc animated:YES];
        }
    }
}

@end
