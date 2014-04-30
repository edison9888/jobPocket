//
//  CTFeedbackVCtler.m
//  CTPocketV4
//
//  Created by 许忠洲 on 13-11-20.
//  Copyright (c) 2013年 广东亿迅科技有限公司. All rights reserved.
//  反馈

#import "CTFeedbackVCtler.h"
#import "CTFeedbackCell.h"
#import "AppDelegate.h"
#import "CTFeedbackDetailVCtler.h"

@interface CTFeedbackVCtler () <UITableViewDataSource, UITableViewDelegate>
{
    UITableView *_fbTableView;
    int _curPage;                    // 当前页
    int _pageSize;                   // 每页条数
    NSMutableArray *_feedbackList;   // 好友列表
    BOOL _endReached;                // 是否到底，到底隐藏加载更多cell
    
    UILabel *_tipLabel;
}
@property (assign, nonatomic) BOOL isLoadingMore;   // 是否正在加载更多，是的话不再请求数据

@end

@implementation CTFeedbackVCtler

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        // 标题
        self.title = @"用户吐槽";
        // 左按钮
        [self setLeftButton:[UIImage imageNamed:@"btn_back"]];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    // 初始化数据
    {
        _curPage = 1;
        _pageSize = 20;
        _feedbackList = [[NSMutableArray alloc] init];
        _endReached = NO;
        self.isLoadingMore = NO;
        _tipLabel = nil;
    }
    
    // tableView外框
    {
        CGFloat h = 367;
        if (iPhone5) {
            h = 455;
        }
        
        UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(29, 25, 262, h-135)];
        bgView.backgroundColor = [UIColor colorWithRed:0.85 green:0.85 blue:0.85 alpha:1.00];
        [self.view addSubview:bgView];
    }
    
    // tableView
    {
        CGFloat h = 367;
        if (iPhone5) {
            h = 455;
        }
        
        _fbTableView = [[UITableView alloc] initWithFrame:CGRectMake(30, 26, 260, h-137)
                                                    style:UITableViewStylePlain];
        _fbTableView.backgroundColor = [UIColor colorWithRed:0.94f green:0.94f blue:0.94f alpha:1.00f];
        _fbTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _fbTableView.delegate = self;
        _fbTableView.dataSource = self;
        [self.view addSubview:_fbTableView];
    }
    
    // 提示语
    {
        _tipLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 44, 260, 44)];
        _tipLabel.backgroundColor = [UIColor clearColor];
        _tipLabel.font = [UIFont systemFontOfSize:17.0f];
        _tipLabel.textColor = [UIColor blackColor];
        _tipLabel.textAlignment = UITextAlignmentCenter;
        _tipLabel.text = @"暂无反馈信息！";
        _tipLabel.hidden = YES;
        [_fbTableView addSubview:_tipLabel];
    }
    
    // 继续吐槽按钮
    {
        CGFloat h = 285;
        if (iPhone5) {
            h = 373;
        }
        
        UIButton *fbBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        fbBtn.frame = CGRectMake(32, h, 256, 42);
        [fbBtn setBackgroundImage:[UIImage imageNamed:@"feedback_btn1"] forState:UIControlStateNormal];
        [fbBtn setBackgroundImage:[UIImage imageNamed:@"feedback_btn1_hl"] forState:UIControlStateHighlighted];
        [fbBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, 30, 0, 0)];
        [fbBtn setTitle:@"继续吐槽" forState:UIControlStateNormal];
        [fbBtn addTarget:self action:@selector(onFeebackAction) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:fbBtn];
    }
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadFeedbackList) name:@"刷新用户反馈列表" object:nil];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - self func

- (void)reloadFeedbackList
{
    _curPage = 1;
    _pageSize = 20;
    [_feedbackList removeAllObjects];
    _endReached = NO;
    self.isLoadingMore = NO;
    _tipLabel.hidden = YES;
    [_fbTableView reloadData];
}

- (void)onFeebackAction
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)loadMore
{
    if (self.isLoadingMore == NO) {
        self.isLoadingMore = YES;
        // 获取数据
        [self queryByPhone];
    }
}

- (void)queryByPhone
{
    
    NSString* str_application_id = @"12";     // 应用编号为12
    NSString* str_app_version = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    NSString* str_client_imei = [[Global sharedInstance].loginInfoDict objectForKey:@"UserLoginName"];
    NSString* str_client_mdn  = [[Global sharedInstance].loginInfoDict objectForKey:@"UserLoginName"];
    
    // 上报周期:用户反馈日期时间戳
    NSString* str_reply_date = [[NSString alloc]initWithFormat:@"%lld", (long long)[[NSDate date] timeIntervalSince1970]];
    
    // MD5加密:效验合法性 规则：time+key做md5加密
    NSString* key = @"0c07b128fca8195eb6513ba7162bed86";
    NSString* str = [NSString stringWithFormat:@"%@%@", str_reply_date,key];
    NSString* str_sig = [[str md5] lowercaseString];
    
    // 当前的时间戳:效验参数
    NSString* str_time = [[NSString alloc]initWithFormat:@"%lld", (long long)[[NSDate date] timeIntervalSince1970]];
    
    NSDictionary * params = [NSDictionary dictionaryWithObjectsAndKeys:
                             str_application_id, @"application_id",
                             str_app_version, @"app_version",
                             str_client_imei, @"client_imei",
                             str_client_mdn, @"client_mdn",
                             str_sig, @"sig",
                             str_time, @"time",
                             [NSString stringWithFormat:@"%d", _pageSize], @"page_count",
                             [NSString stringWithFormat:@"%d", _curPage], @"page",
                             nil];
    
    // 请求数据：
    [MyAppDelegate.feedbackEngine postJSONWithMethod:@"queryByPhone"
                                              params:params
                                         onSucceeded:^(NSDictionary *dict) {
                                             
                                             _curPage++;
                                             [_feedbackList addObjectsFromArray:dict[@"list_arr"]];
                                             if ([dict[@"list_arr"] count] < 20) {
                                                 _endReached = YES;
                                             }
                                             self.isLoadingMore = NO;
                                             [_fbTableView reloadData];
                                             
                                             if ([_feedbackList count] <= 0)
                                             {
                                                 _tipLabel.hidden = NO;
                                             }
                                             else
                                             {
                                                 _tipLabel.hidden = YES;
                                             }
                                             
                                         } onError:^(NSError *engineError) {
                                             self.isLoadingMore = NO;
                                             [_fbTableView reloadData];
                                             DDLogInfo(@"%s--%@", __func__, engineError);
                                         }];
    
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([_feedbackList count] > 0)
    {
        //calc cell height
        CGFloat h = 0;
        
        id user_reply_message = [[_feedbackList objectAtIndex:indexPath.row] objectForKey:@"user_reply_message"];
        if (user_reply_message && [user_reply_message isKindOfClass:[NSString class]]) {
            
            UILabel *askLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 16+16, 180, 16)];
            askLabel.font = [UIFont systemFontOfSize:13.0f];
            askLabel.text = [user_reply_message stringByReplacingPercentEscapesUsingEncoding:NSUTF16StringEncoding];
            askLabel.numberOfLines = 0;
            [askLabel sizeToFit];
            
            h = askLabel.bounds.size.height - 16;
        }
        
        return 88+h;
    }
    else
    {
        return 0;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    CTFeedbackDetailVCtler *vc = [[CTFeedbackDetailVCtler alloc] init];
    vc.info = _feedbackList[indexPath.row];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - UITableViewDataSource

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 1) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LoadMoreCell"];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"LoadMoreCell"];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            UIActivityIndicatorView *spin = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
            [spin setFrame:CGRectMake(100, 12, 20, 20)];
            [spin setTag:1];
            [cell.contentView addSubview:spin];
            
            cell.textLabel.font = [UIFont systemFontOfSize:14];
            cell.textLabel.textColor = [UIColor blackColor];
            cell.textLabel.textAlignment = UITextAlignmentCenter;
            cell.textLabel.text = @"加载中...";
        }
        
        UIActivityIndicatorView *spin = (UIActivityIndicatorView *)[cell.contentView viewWithTag:1];
        [spin startAnimating];
        
        [self loadMore];
        return cell;
    }
    
    static NSString *kCellIdentifier = @"FeedbackCellId";
    CTFeedbackCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellIdentifier];
    if (cell == nil) {
        cell = [[CTFeedbackCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kCellIdentifier];
    }
    [cell setCellInfo:_feedbackList[indexPath.row]];
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // 1个对话的Sections+1个Load More Section
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 1) {
        if (_endReached) {
            return 0;
        }
        return 1;
    }
    
    return [_feedbackList count];
}

@end
