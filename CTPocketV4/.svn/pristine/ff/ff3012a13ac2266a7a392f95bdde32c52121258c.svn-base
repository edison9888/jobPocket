//
//  CTPointQueryVCtler.m
//  CTPocketV4
//
//  Created by 许忠洲 on 13-11-22.
//  Copyright (c) 2013年 广东亿迅科技有限公司. All rights reserved.
//  积分查询

#import "CTPointQueryVCtler.h"

#import "AppDelegate.h"

#import "SIAlertView.h"
#import "CTPointExchangeCell.h"
#import "SVProgressHUD.h"

#import "CTPointExchangeVCtler.h"
#import "CTPointCommodityListVCtler.h"
#import "CTPointCommodityDetailVCtler.h"
#import "CTPointConfirmExchangeVCtler.h"

#import "UIColor+Category.h"

#import "IgUserInfo.h"
#import "IgOrderList.h" //交易记录查询
//积分消费记录 pointCosumeHistory 查询积分消费数额
#import "IgProdList.h"
#import "IgInfo.h"

#define KPOINTCELLTAG 1110
#define KPOINTLABELTAG 1111

NSString * const QryPointNotificaion = @"qryPoint";
@interface CTPointQueryVCtler () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UILabel *nowPointLabel; //可用积分
@property (nonatomic, strong) UILabel *usedPointLabel; //已用积分
@property (nonatomic, strong) UILabel *expirePointLabel; //即将到期积分
@property (nonatomic, strong) ThreeSubView *sectionHeaderView;
@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSArray *CommodityList; //返回的商品列表


@property (nonatomic, strong) IgOrderList *igOrderListNetworking;
@property (nonatomic, assign) BOOL igOrderListLoading;
@property (nonatomic, assign) BOOL igOrderListLoadSuccess;
@property (nonatomic, strong) IgProdList *igProdListNetworking;
@property (nonatomic, assign) BOOL igProdListLoading;
@property (nonatomic, assign) BOOL igProdListLoadSuccess;

@property (nonatomic, assign) int Integral; //可用积分

@end

@implementation CTPointQueryVCtler

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
        // 标题
        self.title = @"积分查询";
        // 左按钮
        [self setLeftButton:[UIImage imageNamed:@"btn_back"]];
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(qryPoint)
                                                     name:QryPointNotificaion object:nil];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    int xOffset = 0, yOffset = 10;
    
    // 可用积分
    {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(xOffset, yOffset, CGRectGetWidth(self.view.bounds)/2.0, 40)];
        label.backgroundColor = [UIColor clearColor];
        label.font = [UIFont systemFontOfSize:26.0f];
        label.textAlignment = UITextAlignmentCenter;
        label.textColor = [UIColor colorWithR:95 G:189 B:42 A:1];
        label.text = @"";
        [self.view addSubview:label];
        
        self.nowPointLabel = label;
        
        xOffset = CGRectGetMaxX(label.frame);
    }
    
    //可用积分下面的提示语
    {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.backgroundColor = [UIColor clearColor];
        button.frame = CGRectMake(0, CGRectGetMaxY(self.nowPointLabel.frame), CGRectGetWidth(self.nowPointLabel.frame), 20);
        [button setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        [button setTitle:@"可用积分" forState:UIControlStateNormal];
        [button.titleLabel setFont:[UIFont systemFontOfSize:13]];
        button.enabled = NO;
        [self.view addSubview:button];
    }
    
    //竖线
    {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(xOffset, yOffset, 1, CGRectGetHeight(self.nowPointLabel.frame) + 20)];
        view.backgroundColor = [UIColor colorWithRed:0.84f green:0.84f blue:0.84f alpha:1.00f];
        [self.view addSubview:view];
        
        xOffset = CGRectGetMidX(view.frame);
    }
    
    
    // 已用积分
    {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(xOffset, yOffset, CGRectGetWidth(self.view.bounds)/2.0, 40)];
        label.backgroundColor = [UIColor clearColor];
        label.font = [UIFont systemFontOfSize:26.0f];
        label.textAlignment = UITextAlignmentCenter;
        label.textColor = [UIColor colorWithR:233 G:80 B:62 A:1];
        label.text = @"";
        [self.view addSubview:label];
        
        self.usedPointLabel = label;
        
        xOffset = CGRectGetMaxX(label.frame);
    }
    
    //已用积分下面的提示语
    {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.backgroundColor = [UIColor clearColor];
        button.frame = CGRectMake(CGRectGetMinX(self.usedPointLabel.frame), CGRectGetMaxY(self.usedPointLabel.frame), CGRectGetWidth(self.usedPointLabel.frame), 20);
        [button setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        [button setTitle:@"近一月已用积分" forState:UIControlStateNormal];
        [button.titleLabel setFont:[UIFont systemFontOfSize:13]];
        button.enabled = NO;
        [self.view addSubview:button];
        
        yOffset = CGRectGetMaxY(self.usedPointLabel.frame) + 20 + 6;
    }
    
    {
        // 分割线
        UIView *separator = [[UIView alloc] initWithFrame:CGRectMake(0, yOffset, self.view.bounds.size.width, 1)];
        separator.backgroundColor = [UIColor colorWithRed:0.84f green:0.84f blue:0.84f alpha:1.00f];
        [self.view addSubview:separator];
        
        yOffset = CGRectGetMaxY(separator.frame);
    }
    
    
    xOffset = 18;
    float verticalDistance = 10, visibleWidth = CGRectGetWidth(self.view.bounds) - 2 * xOffset;
    yOffset += verticalDistance;
    
    {
        NSDictionary *loginInfoDict = [Global sharedInstance].loginInfoDict;
        NSString *phoneNbr = loginInfoDict[@"UserLoginName"] ? loginInfoDict[@"UserLoginName"] : @"";
        // 查询号码
        UILabel *phoneLabel = [[UILabel alloc] initWithFrame:CGRectMake(xOffset, yOffset, visibleWidth, 16)];
        phoneLabel.backgroundColor = [UIColor clearColor];
        phoneLabel.font = [UIFont systemFontOfSize:14.0f];
        phoneLabel.textColor = [UIColor blackColor];
        phoneLabel.text = [NSString stringWithFormat:@"查询号码：%@", phoneNbr];
        [self.view addSubview:phoneLabel];
        
        yOffset = CGRectGetMaxY(phoneLabel.frame) + verticalDistance;
    }
    
    // 即将到期积分
    {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(xOffset, yOffset, visibleWidth, 16)];
        label.backgroundColor = [UIColor clearColor];
        label.font = [UIFont systemFontOfSize:14.0f];
        label.textColor = [UIColor blackColor];
        label.text = @"年末到期积分：查询中...";
        [self.view addSubview:label];
        
        self.expirePointLabel = label;
        
        yOffset = CGRectGetMaxY(label.frame) + verticalDistance;
    }
    
    {
        NSDateFormatter *df = [[NSDateFormatter alloc] init];
        [df setDateFormat:@"yyyy年MM月dd日"];
        // 查询日期
        UILabel *dateLabel = [[UILabel alloc] initWithFrame:CGRectMake(xOffset, yOffset, visibleWidth, 16)];
        dateLabel.backgroundColor = [UIColor clearColor];
        dateLabel.font = [UIFont systemFontOfSize:14.0f];
        dateLabel.textColor = [UIColor blackColor];
        dateLabel.text = [NSString stringWithFormat:@"查询日期：%@", [df stringFromDate:[NSDate date]]];
        [self.view addSubview:dateLabel];
        
        yOffset = CGRectGetMaxY(dateLabel.frame) + 28;
    }
    
    {
        if (!iPhone5) {
            yOffset -= 25;
        }
        
        UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, yOffset, CGRectGetWidth(self.view.bounds), CGRectGetHeight(self.view.bounds) - yOffset)];
        //tableView.backgroundColor = [UIColor clearColor];
        tableView.backgroundColor = [UIColor colorWithRed:239/255. green:239/255. blue:239/255. alpha:1];
        tableView.backgroundView = nil;
        tableView.dataSource = self;
        tableView.delegate = self;
        tableView.scrollEnabled = NO;
        tableView.rowHeight = 61;
        tableView.sectionHeaderHeight = 30;
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self.view addSubview:tableView];
        
        self.tableView = tableView;
    }
    
    [self loadData];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void) dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


#pragma mark - funcs

- (void)goCommodityListVC
{
    
    CTPointCommodityListVCtler *vc = [[CTPointCommodityListVCtler alloc] init];
    vc.PageIndex = 1;
    vc.PageSize = 20;
    vc.Integral = self.Integral;
    [vc.CommodityList addObjectsFromArray:self.CommodityList];
    [self.navigationController pushViewController:vc
                                         animated:YES];
}

- (void)goExchangeVC:(UIButton *)button
{
    NSDictionary *dictionary =  [self.CommodityList objectAtIndex:button.tag];
    int IntegralPrice = [dictionary[@"IntegralPrice"] intValue];
    if (self.Integral<IntegralPrice) {
        NSString *less = [NSString stringWithFormat:@"亲，你还需要%d积分即可兑换此宝贝了喔！",IntegralPrice-self.Integral];
        SIAlertView *alertView = [[SIAlertView alloc] initWithTitle:nil
                                                         andMessage:less];
        [alertView addButtonWithTitle:@"确认"
                                 type:SIAlertViewButtonTypeDefault
                              handler:^(SIAlertView *alertView) {
                                  
                              }];
        alertView.transitionStyle = SIAlertViewTransitionStyleBounce;
        [alertView show];
    }else{
        CTPointConfirmExchangeVCtler *vc = [[CTPointConfirmExchangeVCtler alloc] init];
        vc.Integral = self.Integral;
        vc.commodityInfo = [self.CommodityList objectAtIndex:button.tag];
        [self.navigationController pushViewController:vc animated:YES];
    }
}

- (void)goCommodityDetailVCWithIndexPath:(NSIndexPath *)indexPath
{
    CTPointCommodityDetailVCtler *vc = [[CTPointCommodityDetailVCtler alloc] init];
    vc.commodityInfo = [self.CommodityList objectAtIndex:indexPath.row];
    vc.Integral = self.Integral;
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - 重新更新个人积分

- (void)qryPoint
{
    [[IgInfo shareIgInfo] clear]; //清空信息
    
    NSDictionary *loginInfoDict = [Global sharedInstance].loginInfoDict;
    NSString *DeviceNo = loginInfoDict[@"UserLoginName"];
    
    [[IgUserInfo shareIgUserInfo] igUserInfoWithDeviceNo:DeviceNo finishBlock:^(NSDictionary *resultParams, NSError *error) {
        if (!error) {
            NSDictionary *data = resultParams[@"Data"];
            NSString *CustId = [data objectForKey:@"CustId"];
            if (CustId) {
                [self igOrderListWithDeviceNo:DeviceNo CustId:CustId]; // 已用积分
//                [self pointCosumeHistory:DeviceNo];
                [[IgInfo shareIgInfo] igInfoWithDeviceNo:DeviceNo CustId:CustId finishBlock:^(NSDictionary *resultParams, NSError *error) {
                    if (error) {
                        [self checkError:error];
                        self.igProdListLoading = NO;
                        [self endLoadData];
                        return;
                    }
                    NSDictionary *data = resultParams[@"Data"];
                    NSString *Integral = data[@"Integral"];
                    NSString *ExpireIntegral = data[@"ExpireIntegral"];
                    
                    self.expirePointLabel.text = [NSString stringWithFormat:@"即将到期积分：%@分", ExpireIntegral];
                    self.nowPointLabel.text = Integral;  // 可用积分
                    self.Integral = (NSUInteger)[Integral integerValue];
                }];
            } else {
                self.igOrderListLoading = NO;
                self.igProdListLoading = NO;
                [self endLoadData];
            }
        } else {
            self.igOrderListLoading = NO;
            self.igProdListLoading = NO;
            [self endLoadData];
        }
    }];
}

#pragma mark - network

- (void)loadData
{
    self.igOrderListLoading = YES;
    self.igProdListLoading = YES;
    
    self.igOrderListLoadSuccess = NO;
    self.igProdListLoadSuccess = NO;
    
    [SVProgressHUD showWithStatus:@"加载中..." maskType:SVProgressHUDMaskTypeGradient];
    
    NSDictionary *loginInfoDict = [Global sharedInstance].loginInfoDict;
    NSString *DeviceNo = loginInfoDict[@"UserLoginName"];
    
    [[IgUserInfo shareIgUserInfo] igUserInfoWithDeviceNo:DeviceNo finishBlock:^(NSDictionary *resultParams, NSError *error) {
        if (!error) {
            NSDictionary *data = resultParams[@"Data"];
            NSString *CustId = [data objectForKey:@"CustId"];
            if (CustId) {
                [self igOrderListWithDeviceNo:DeviceNo CustId:CustId]; //已用积分
//                [self pointCosumeHistory:DeviceNo];
                [[IgInfo shareIgInfo] igInfoWithDeviceNo:DeviceNo CustId:CustId finishBlock:^(NSDictionary *resultParams, NSError *error) {
                    if (error) {
                        [self checkError:error];
                        self.igProdListLoading = NO;
                        [self endLoadData];
                        return;
                    }
                    NSDictionary *data = resultParams[@"Data"];
                    NSString *Integral = data[@"Integral"];
                    NSString *ExpireIntegral = data[@"ExpireIntegral"];
                    
                    self.expirePointLabel.text = [NSString stringWithFormat:@"即将到期积分：%@分", ExpireIntegral];
                    self.nowPointLabel.text = Integral;
                    self.Integral = (NSUInteger)[Integral integerValue];
                    
                    [self igProdListWithMaxPrice:(NSUInteger)[Integral integerValue]];
                }];
            } else {
                self.igOrderListLoading = NO;
                self.igProdListLoading = NO;
                [self endLoadData];
            }
        } else {
            self.igOrderListLoading = NO;
            self.igProdListLoading = NO;
            [self endLoadData];
        }
    }];
}

- (void)endLoadData
{
    if ((!self.igOrderListLoading) && (!self.igProdListLoading)) {
        [SVProgressHUD dismiss];
        
        if (self.igOrderListLoadSuccess && self.igProdListLoadSuccess) {
            self.view.hidden = NO;
        }
    }
}

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

// 已用积分查询
- (void)igOrderListWithDeviceNo:(NSString *)DeviceNo CustId:(NSString *)CustId
{
    if (self.igOrderListNetworking == nil) {
        self.igOrderListNetworking = [[IgOrderList alloc] init];
    }
    __weak typeof(self) weakSelf = self;
    [self.igOrderListNetworking igOrderListWithPageIndex:@"1" PageSize:@"1000" DeviceNo:DeviceNo DeviceType:@"7" ProvinceId:@"35" CustId:CustId OrderId:nil Status:@"1" DataType:@"1" finishBlock:^(NSDictionary *resultParams, NSError *error) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        
        strongSelf.igOrderListLoading = NO;
        [strongSelf endLoadData];
        
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
        id OrderList = [data objectForKey:@"OrderList"];
        CGFloat usedPoint = 0.0f;
        if ([OrderList isKindOfClass:[NSArray class]]) {
            for (NSDictionary *order in OrderList) {
                NSString *IntegralPrice = [order objectForKey:@"IntegralPrice"];
                NSString *BuyNum = [order objectForKey:@"BuyNum"];
                usedPoint += [IntegralPrice floatValue]*[BuyNum floatValue];
            }
        } else if ([OrderList isKindOfClass:[NSDictionary class]]) {
//            NSString *IntegralPrice = [OrderList objectForKey:@"IntegralPrice"];
            //modified by shallow 2014-04-09
            NSArray *ListItem = [OrderList objectForKey:@"ListItem"];
            for (NSDictionary *item in ListItem) {
                NSString *IntegralPrice = [item objectForKey:@"IntegralPrice"];
                NSString *BuyNum = [item objectForKey:@"BuyNum"];
                
                usedPoint += [IntegralPrice floatValue]*[BuyNum floatValue];
            }
            
        }
        
        strongSelf.usedPointLabel.text = [NSString stringWithFormat:@"%d", (int)usedPoint];
        strongSelf.igOrderListLoadSuccess = YES;
        [strongSelf endLoadData];
    }];
}

//积分消费记录(已用积分)
- (void)pointCosumeHistory:(NSString *)DeviceNo
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:@"202211" forKey:@"CondItemValue"];
    [params setObject:DeviceNo forKey:@"PhoneNbr"];
    [params setObject:@"11" forKey:@"CodeType"];

    
    [MyAppDelegate.cserviceEngine postXMLWithCode:@"pointCosumeHistory"
                                           params:params
                                      onSucceeded:^(NSDictionary *dict) {
                                          [SVProgressHUD dismiss];
                                           }
                                          onError:^(NSError *engineError) {
                                               [SVProgressHUD showErrorWithStatus:engineError.localizedDescription];
                                           }];
}

//查询可兑换的商品列表，需传入用户当前所拥有的积分最大值
- (void)igProdListWithMaxPrice:(NSUInteger)MaxPrice
{
    if (self.igProdListNetworking == nil) {
        self.igProdListNetworking = [[IgProdList alloc] init];
    }
    __weak typeof(self) weakSelf = self;
    [self.igProdListNetworking igProdListWith:1 PageSize:20 Sort:2 MinPrice:0 MaxPrice:MaxPrice CommdityId:nil KeyWord:nil CategoryId:nil SmallCategoryId:nil finishBlock:^(NSDictionary *resultParams, NSError *error) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        
        strongSelf.igProdListLoading = NO;
        [strongSelf endLoadData];
        
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
        NSArray *ListItem = [CommodityList objectForKey:@"ListItem"];
        if ([ListItem isKindOfClass:[NSArray class]] && ListItem.count > 0) {
            strongSelf.CommodityList = ListItem;
            [strongSelf.tableView reloadData];
        } else if ([ListItem isKindOfClass:[NSDictionary class]]) {
            strongSelf.CommodityList = [NSArray arrayWithObject:ListItem];
            [strongSelf.tableView reloadData];
        }
        strongSelf.igProdListLoadSuccess = YES;
        [strongSelf endLoadData];
    }];
    
    if (MaxPrice == 0) {
        
        UILabel *label = (UILabel*)[self.view viewWithTag:KPOINTLABELTAG];
        label.text = @"亲，您的积分暂时没有可以兑换的商品哟~~";
    }
}

- (void)onExchangeAction
{
    CTPointExchangeVCtler *vc = [[CTPointExchangeVCtler alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - 判断可兑换积分
- (void)getPointExchange //判断可兑换的积分
{
    NSMutableArray *CommodityListTmp = [NSMutableArray new];
    
    for (int i = 0; i<self.CommodityList.count; i++) {
        NSDictionary *dictionary =  [self.CommodityList objectAtIndex:i];
        int IntegralPrice = [dictionary[@"IntegralPrice"] intValue];
        if (self.Integral >= IntegralPrice) {
            [CommodityListTmp addObject:dictionary];
        }
    }
    self.CommodityList = CommodityListTmp;
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    [self getPointExchange];
    
    NSInteger count = 0;
    if (iPhone5) {
        count = 4;
    } else {
        count = 3;
    }
    if (self.CommodityList) {
        if (count > self.CommodityList.count) {
            count = self.CommodityList.count;
        }
    }
    if (self.CommodityList.count == 0) {
        count = 1;
    }
    return count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
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
        cell.exchangeButton.tag = indexPath.row;
        [cell.exchangeButton addTarget:self action:@selector(goExchangeVC:) forControlEvents:UIControlEventTouchUpInside];
        cell.imageView.image = [UIImage imageNamed:@"CommodityListDefault"];
        NSString *PicUrl = [dictionary objectForKey:@"PicUrl"];
        if (PicUrl.length > 0) {
            [cell.imageView setImageWithURL:[NSURL URLWithString:PicUrl] placeholderImage:[UIImage imageNamed:@"CommodityListDefault"]];
        }
    }
    
    
    if (self.CommodityList.count == 0) {
        
        cell.tag = KPOINTCELLTAG;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell sizeToFit];
        cell.subTitleLabel.hidden = YES;
        cell.exchangeButton.hidden = YES;
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(20,
                                                                   10,
                                                                   300,
                                                                   20)];
        label.backgroundColor = [UIColor clearColor];
        label.font = [UIFont systemFontOfSize:15];
        label.textColor = [UIColor colorWithR:49 G:49 B:49 A:1];
        //label.text = @"亲，您的积分暂时没有可以兑换的商品哟~~";
        label.tag = KPOINTLABELTAG;
        [cell addSubview:label];
    }else
    {
        cell.titleLabel.font = [UIFont systemFontOfSize:15];
        cell.selectionStyle = UITableViewCellSelectionStyleBlue;
        cell.subTitleLabel.hidden = NO;
        cell.exchangeButton.hidden = NO;
        UILabel *label = (UILabel*)[self.view viewWithTag:KPOINTLABELTAG];
        [label removeFromSuperview];
    }
    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (self.CommodityList.count == 0) {
        return;
    }else
    {
        [self goCommodityDetailVCWithIndexPath:indexPath];
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (1) {
        
        CGRect rect = CGRectZero;
        rect.size.height = tableView.sectionHeaderHeight;
        
        ThreeSubView *threeSubView = nil;
        BOOL needGoMore = NO;
        if ([tableView numberOfRowsInSection:section] < self.CommodityList.count) {
            __weak typeof(self) weakSelf = self;
            threeSubView = [[ThreeSubView alloc] initWithFrame:rect leftButtonSelectBlock:nil centerButtonSelectBlock:nil rightButtonSelectBlock:^{
                __strong typeof(weakSelf) strongSelf = self;
                
                [strongSelf goCommodityListVC];
            }];
            needGoMore = YES;
        } else {
            threeSubView = [[ThreeSubView alloc] initWithFrame:rect leftButtonSelectBlock:nil centerButtonSelectBlock:nil rightButtonSelectBlock:nil];
        }
        
        [threeSubView.leftButton.titleLabel setFont:[UIFont boldSystemFontOfSize:14]];
        [threeSubView.leftButton setTitle:@" " forState:UIControlStateNormal];
        [threeSubView.leftButton setBackgroundColor:[UIColor colorWithR:95 G:189 B:42 A:1]];
        
        [threeSubView.centerButton.titleLabel setFont:[UIFont systemFontOfSize:13]];
        NSString *soMuchWhiteSpace = @"                        ";
        [threeSubView.centerButton setTitle:[NSString stringWithFormat:@"  我可兑换%@%@", soMuchWhiteSpace, soMuchWhiteSpace] forState:UIControlStateNormal];
        [threeSubView.centerButton setTitleColor:[UIColor colorWithR:49 G:49 B:49 A:1] forState:UIControlStateNormal];
        
        [threeSubView.rightButton.titleLabel setFont:[UIFont systemFontOfSize:13]];
        [threeSubView.rightButton setTitleColor:[UIColor colorWithR:49 G:49 B:49 A:1] forState:UIControlStateNormal];
        if (needGoMore) {
            [threeSubView.rightButton setTitle:@"      更多>    " forState:UIControlStateNormal];
        } else {
            [threeSubView.rightButton setTitle:@"            " forState:UIControlStateNormal];
        }
        [threeSubView autoLayout];
        
        rect = threeSubView.frame;
        rect.origin = CGPointZero;
        rect.size.width = CGRectGetWidth(tableView.frame);
        threeSubView.frame = rect;
        
        self.sectionHeaderView = threeSubView;
    }
    return self.sectionHeaderView;
}

@end
