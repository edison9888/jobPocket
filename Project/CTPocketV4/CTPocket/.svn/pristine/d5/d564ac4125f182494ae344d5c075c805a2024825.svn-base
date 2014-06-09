//
//  CTPoints4RecordVCtler.m
//  CTPocketV4
//
//  Created by 许忠洲 on 13-11-22.
//  Copyright (c) 2013年 广东亿迅科技有限公司. All rights reserved.
//  积分兑换记录

#import "CTPoints4RecordVCtler.h"
#import "MBProgressHUD.h"
#import "AppDelegate.h"
#import "SIAlertView.h"
#import "CTPointExchangeVCtler.h"
#import "ToastAlertView.h"

@interface CTPoints4RecordVCtler ()
{
    MBProgressHUD *_hud;
    UIScrollView *_scrollView;
    UIButton *_lButton;
    UIButton *_rButton;
    UILabel *_monthLabel;
    UIView *_listView;
    UILabel *_tipLabel;
    UIButton *_exchangeBtn;
    
    NSArray *_monthList;
    int _currentIndex;
    
    CserviceOperation *_pointCosumeHistory;
}

@end

@implementation CTPoints4RecordVCtler

static NSDateFormatter *df;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
        // 标题
        self.title = @"积分兑换记录";
        // 左按钮
        [self setLeftButton:[UIImage imageNamed:@"btn_back"]];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    {
        df = [[NSDateFormatter alloc] init];
        [df setDateFormat:@"yyyyMM"];
        
        NSMutableArray *tList = [NSMutableArray array];
        [tList addObject:[df stringFromDate:[NSDate date]]];
        for (int i = 0; i < 5; i++)
        {
            NSString *yStr = [[tList lastObject] substringToIndex:4];
            NSString *mStr = [[tList lastObject] substringFromIndex:4];
            if ([mStr intValue] <= 1)
            {
                [tList addObject:[NSString stringWithFormat:@"%d12", [yStr intValue]-1]];
            }
            else
            {
                if (([mStr intValue]-1) < 10)
                {
                    [tList addObject:[NSString stringWithFormat:@"%@0%d", yStr, [mStr intValue]-1]];
                }
                else
                {
                    [tList addObject:[NSString stringWithFormat:@"%@%d", yStr, [mStr intValue]-1]];
                }
            }
        }
        _monthList = [NSArray arrayWithArray:tList];
        NSLog(@"最近六个月列表%@", _monthList);
        _currentIndex = 0;
    }
    
    // tip
    _tipLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 120+16, 320, 16)];
    _tipLabel.backgroundColor = [UIColor clearColor];
    _tipLabel.font = [UIFont systemFontOfSize:13.0f];
    _tipLabel.textColor = [UIColor blackColor];
    _tipLabel.textAlignment = UITextAlignmentCenter;
    _tipLabel.text = @"暂无积分兑换纪录！";
    _tipLabel.hidden = YES;
    [self.view addSubview:_tipLabel];
    
    _scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    _scrollView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
    _scrollView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_scrollView];
    
    NSDictionary *loginInfoDict = [Global sharedInstance].loginInfoDict;
    NSString *phoneNbr = loginInfoDict[@"UserLoginName"] ? loginInfoDict[@"UserLoginName"] : @"";
    // 查询号码
    UILabel *phoneLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 20, 280, 16)];
    phoneLabel.backgroundColor = [UIColor clearColor];
    phoneLabel.font = [UIFont systemFontOfSize:14.0f];
    phoneLabel.textColor = [UIColor blackColor];
    phoneLabel.text = [NSString stringWithFormat:@"查询号码：%@", phoneNbr];
    [_scrollView addSubview:phoneLabel];
    
#if 0 // modified by zy, 2014-02-19
    // 分割线
    UIView *separator = [[UIView alloc] initWithFrame:CGRectMake(0, 56, self.view.bounds.size.width, 1)];
    separator.backgroundColor = [UIColor colorWithRed:0.84f green:0.84f blue:0.84f alpha:1.00f];
    [_scrollView addSubview:separator];
#else
    // div line
    UIImageView* divLine = [[UIImageView alloc] initWithFrame:CGRectMake(0,48, 320, 1)];
    divLine.image = [UIImage imageNamed:@"recharge_horline_bg.png"];
    [self.view addSubview:divLine];
#endif
    
    // 左侧按钮
    _lButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _lButton.frame = CGRectMake(0, 70, 79, 37);
    [_lButton setBackgroundImage:[UIImage imageNamed:@"his_mth_01.png"] forState:UIControlStateNormal];
    int preMonth = [[[_monthList objectAtIndex:_currentIndex] substringFromIndex:4] intValue];
    if (preMonth <= 1) {
        preMonth = 12;
    }
    else {
        preMonth--;
    }
    [_lButton setTitle:[NSString stringWithFormat:@"%d月", preMonth] forState:UIControlStateNormal];
    [_lButton addTarget:self action:@selector(onLeftBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [_scrollView addSubview:_lButton];
    
    // 右侧按钮
    _rButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _rButton.frame = CGRectMake(241, 70, 79, 37);
    [_rButton setBackgroundImage:[UIImage imageNamed:@"his_mth_02.png"] forState:UIControlStateNormal];
    int nextMonth = [[[_monthList objectAtIndex:_currentIndex] substringFromIndex:4] intValue];
    if (nextMonth >= 12) {
        nextMonth = 1;
    }
    else {
        nextMonth++;
    }
    [_rButton setTitle:[NSString stringWithFormat:@"%d月", nextMonth] forState:UIControlStateNormal];
    [_rButton setEnabled:NO];
    [_rButton addTarget:self action:@selector(onLeftBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [_scrollView addSubview:_rButton];
    
    // 年、月份
    _monthLabel = [[UILabel alloc] initWithFrame:CGRectMake(80, 70, 160, 37)];
    _monthLabel.backgroundColor = [UIColor clearColor];
    _monthLabel.font = [UIFont /*systemFontOfSize:17.0f*/boldSystemFontOfSize:18];  // modified by zy, 2014-02-19
    _monthLabel.textColor = [UIColor colorWithRed:0.44f green:0.77f blue:0.21f alpha:1.00f];
    _monthLabel.textAlignment = UITextAlignmentCenter;
    _monthLabel.text = [NSString stringWithFormat:@"%@年%@月", [[_monthList objectAtIndex:_currentIndex] substringToIndex:4], [[_monthList objectAtIndex:_currentIndex] substringFromIndex:4]];
    [_scrollView addSubview:_monthLabel];
    
    // 兑换列表
    _listView = [[UIView alloc] initWithFrame:CGRectMake(0, 120, self.view.bounds.size.width, 90)];
    _listView.backgroundColor = [UIColor clearColor];
    [_scrollView addSubview:_listView];
    
    // 继续兑换按钮
    _exchangeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _exchangeBtn.frame = CGRectMake(23, 120+_listView.bounds.size.height+16, 274, 38);
    [_exchangeBtn setBackgroundImage:[UIImage imageNamed:@"pointExchange"] forState:UIControlStateNormal];
    [_exchangeBtn setBackgroundImage:[UIImage imageNamed:@"pointExchange_hl"] forState:UIControlStateHighlighted];
    [_exchangeBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, 30, 0, 0)];
    [_exchangeBtn setTitle:@"继续兑换" forState:UIControlStateNormal];
    [_exchangeBtn addTarget:self action:@selector(onExchangeAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_exchangeBtn];
    
    // 初始化hud
    _hud = [[MBProgressHUD alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:_hud];
    _hud.labelText = @"正在载入...";
    
    [self getPointCosumeHistory];
    
    // 左右滑动手势
    {
        UISwipeGestureRecognizer *recognizer1 = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleRecognizer:)];
        [recognizer1 setDirection:UISwipeGestureRecognizerDirectionLeft];
        [self.view addGestureRecognizer:recognizer1];
        UISwipeGestureRecognizer *recognizer2 = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleRecognizer:)];
        [recognizer2 setDirection:UISwipeGestureRecognizerDirectionRight];
        [self.view addGestureRecognizer:recognizer2];
    }
}

#pragma mark - self func

- (void)getPointCosumeHistory
{
    [_hud show:YES];
    
    NSDictionary *loginInfoDict = [Global sharedInstance].loginInfoDict;
    NSString *phoneNbr = loginInfoDict[@"UserLoginName"];
    
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
                            [_monthList objectAtIndex:_currentIndex], @"CondItemValue",
                            phoneNbr, @"PhoneNbr",
                            @"11", @"CodeType", nil];
    
    _pointCosumeHistory = [MyAppDelegate.cserviceEngine postXMLWithCode:@"pointCosumeHistory"
                                                                 params:params
                                                            onSucceeded:^(NSDictionary *dict)
    {
        dict = [Utils objFormatArray:dict path:@"Data/PointCosumeHistory"];
        
        [_hud hide:YES];
        [self reloadListView:dict[@"PointCosumeHistory"]];
        
    } onError:^(NSError *engineError) {
        
        [_hud hide:YES];
        
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
        else
        {
            ToastAlertView *alert = [ToastAlertView new];
            [alert showAlertMsg:engineError.localizedDescription];
        }
    }];
}
/*
- (void)getigOrderList:(int)dataType
{
    [_hud show:YES];
    
    NSString *PageIndex = @"1";
    NSString *PageSize = @"20";
    NSString *DeviceNo = @"";
    NSString *DeviceType = @"";
    NSString *ProvinceId = @"";
    NSString *CustId = @"";
    NSString *OrderId = @"";
    NSString *Status = @"";
    NSString *DataType = [NSString stringWithFormat:@"%d",dataType];
    
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
                            PageIndex,@"PageIndex",
                            PageSize,@"PageSize",
                            DeviceNo,@"DeviceNo",
                            DeviceType,@"DeviceType",
                            ProvinceId,@"ProvinceId",
                            CustId,@"CustId",
                            OrderId,@"OrderId",
                            Status,@"Status",
                            DataType,@"DataType",
                            nil];
}

*/
- (void)reloadListView:(NSArray *)list
{
    // 移除所有子视图
    [_listView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    CGFloat originY = 0;
    for (NSDictionary *dict in list) {
        
        UILabel *pointLabel = [[UILabel alloc] initWithFrame:CGRectMake(24, originY, 272, 30)];
        pointLabel.backgroundColor = [UIColor clearColor];
        pointLabel.font = [UIFont systemFontOfSize:13.0f];
        pointLabel.textColor = [UIColor blackColor];
        pointLabel.text = [NSString stringWithFormat:@"兑换积分：%@分", dict[@"Point"]];
        [_listView addSubview:pointLabel];
        
        UILabel *giftDesLabel = [[UILabel alloc] initWithFrame:CGRectMake(24, originY+30, 272, 30)];
        giftDesLabel.backgroundColor = [UIColor clearColor];
        giftDesLabel.font = [UIFont systemFontOfSize:13.0f];
        giftDesLabel.textColor = [UIColor blackColor];
        giftDesLabel.text = [NSString stringWithFormat:@"兑换礼品：%@", dict[@"GiftDes"]];
        [_listView addSubview:giftDesLabel];
        
        UILabel *giftAmountLabel = [[UILabel alloc] initWithFrame:CGRectMake(24, originY+60, 272, 30)];
        giftAmountLabel.backgroundColor = [UIColor clearColor];
        giftAmountLabel.font = [UIFont systemFontOfSize:13.0f];
        giftAmountLabel.textColor = [UIColor blackColor];
        giftAmountLabel.text = [NSString stringWithFormat:@"礼品数量：%@", dict[@"GiftAmount"]];
        [_listView addSubview:pointLabel];
        
        originY = originY + 90;
    }
    
    _listView.frame = CGRectMake(0, 120, self.view.bounds.size.width, 90*[list count]);
    _exchangeBtn.frame = CGRectMake(23, 120+_listView.bounds.size.height+16+16+8, 274, 38);
    _scrollView.contentSize = CGSizeMake(self.view.bounds.size.width, _exchangeBtn.frame.origin.y+_exchangeBtn.frame.size.height+24);
    if ([list count] <= 0) {
        _tipLabel.hidden = NO;
    }
    else
    {
        _tipLabel.hidden = YES;
    }
}

- (void)onLeftBtnAction
{
    if (_currentIndex >= 5) {
        return;
    }
    
    _currentIndex++;
    
    // 左按钮
    int preMonth = [[[_monthList objectAtIndex:_currentIndex] substringFromIndex:4] intValue];
    if (preMonth <= 1) {
        preMonth = 12;
    }
    else {
        preMonth--;
    }
    [_lButton setTitle:[NSString stringWithFormat:@"%d月", preMonth] forState:UIControlStateNormal];
    if (_currentIndex >= 5) {
        [_lButton setEnabled:NO];
    }
    else {
        [_lButton setEnabled:YES];
    }
    
    // 标题
    _monthLabel.text = [NSString stringWithFormat:@"%@年%@月", [[_monthList objectAtIndex:_currentIndex] substringToIndex:4], [[_monthList objectAtIndex:_currentIndex] substringFromIndex:4]];
    
    // 右按钮
    int nextMonth = [[[_monthList objectAtIndex:_currentIndex] substringFromIndex:4] intValue];
    if (nextMonth >= 12) {
        nextMonth = 1;
    }
    else {
        nextMonth++;
    }
    [_rButton setTitle:[NSString stringWithFormat:@"%d月", nextMonth] forState:UIControlStateNormal];
    if (_currentIndex <= 0) {
        [_rButton setEnabled:NO];
    }
    else {
        [_rButton setEnabled:YES];
    }
    
    [self reloadListView:nil];
    
    if (_pointCosumeHistory) {
        [_pointCosumeHistory cancel];
        _pointCosumeHistory = nil;
        [_hud hide:YES];
    }
    [self getPointCosumeHistory];
}

- (void)onRightBtnAction
{
    if (_currentIndex <= 0) {
        return;
    }
    
    _currentIndex--;
    
    // 左按钮
    int preMonth = [[[_monthList objectAtIndex:_currentIndex] substringFromIndex:4] intValue];
    if (preMonth <= 1) {
        preMonth = 12;
    }
    else {
        preMonth--;
    }
    [_lButton setTitle:[NSString stringWithFormat:@"%d月", preMonth] forState:UIControlStateNormal];
    if (_currentIndex >= 5) {
        [_lButton setEnabled:NO];
    }
    else {
        [_lButton setEnabled:YES];
    }
    
    // 标题
    _monthLabel.text = [NSString stringWithFormat:@"%@年%@月", [[_monthList objectAtIndex:_currentIndex] substringToIndex:4], [[_monthList objectAtIndex:_currentIndex] substringFromIndex:4]];
    
    // 右按钮
    int nextMonth = [[[_monthList objectAtIndex:_currentIndex] substringFromIndex:4] intValue];
    if (nextMonth >= 12) {
        nextMonth = 1;
    }
    else {
        nextMonth++;
    }
    [_rButton setTitle:[NSString stringWithFormat:@"%d月", nextMonth] forState:UIControlStateNormal];
    if (_currentIndex <= 0) {
        [_rButton setEnabled:NO];
    }
    else {
        [_rButton setEnabled:YES];
    }
    
    [self reloadListView:nil];
    
    if (_pointCosumeHistory) {
        [_pointCosumeHistory cancel];
        _pointCosumeHistory = nil;
        [_hud hide:YES];
    }
    [self getPointCosumeHistory];
}

- (void)onExchangeAction
{
    NSLog(@"继续兑换");
    CTPointExchangeVCtler *vc= [[CTPointExchangeVCtler alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)handleRecognizer:(UISwipeGestureRecognizer *)recognizer
{
    if (recognizer.direction == UISwipeGestureRecognizerDirectionLeft)
    {
        if (_rButton.enabled)
        {
            [self onRightBtnAction];
        }
    }
    else if (recognizer.direction == UISwipeGestureRecognizerDirectionRight)
    {
        if (_lButton.enabled)
        {
            [self onLeftBtnAction];
        }
    }
}

@end
