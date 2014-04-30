//
//  COQueryListVctler.m
//  CTPocketV4
//
//  Created by Mac-Eshore-01 on 14-1-21.
//  Copyright (c) 2014年 广东亿迅科技有限公司. All rights reserved.
//

#import "COQueryListVctler.h"
#import "CserviceEngine.h"
#import "AppDelegate.h"
#import "CTMyOrderCell.h"
#import "CTOrderDetailVCtler.h"
#import "SIAlertView.h"
#import "Utils.h"
#import "CTPPointExchangeVCtler.h"
#import "CTDeliverStatusVCtler.h"

@interface COQueryListVctler ()
{
    int  _curPage1;                   // 当前页
    int  _pageSize1;                  // 每页条数
    BOOL _endReached1;                // 是否到底，到底隐藏加载更多cell
}
@property (strong, nonatomic)CserviceOperation *_QryOperation;
@end

@implementation COQueryListVctler

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
        self.title = @"快速订单查询";
        orderItemList = [NSMutableArray new];
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(onPayAction:)
                                                     name:@"onPayAction" object:nil];       // added by zy, 2014-02-24
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(onExpressStatusAction:)
                                                     name:@"onExpressStatusAction" object:nil];       // added by zy, 2014-02-24
    }
    return self;
}

// added by zy, 2014-02-24
- (void)onPayAction:(NSNotification *)notification
{
    NSString *orderId = [notification object];
    NSString *userId = [Global sharedInstance].custInfoDict[@"UserId"] ? [Global sharedInstance].custInfoDict[@"UserId"] : @"FSD88888";
    
    NSString *payUrl = [NSString stringWithFormat:@"http://wapzt.189.cn/pay/onlinePay.do?method=getOrder&userid=%@&id=%@", userId, orderId];
    CTPPointExchangeVCtler *vctler = [CTPPointExchangeVCtler new];
    vctler.jumpUrl = payUrl;
    vctler.title = @"订单支付";
    vctler.fullScreen = YES;
    vctler.needBack2Rootview = NO;
    [self.navigationController pushViewController:vctler animated:YES];
}

// added by zy, 2014-02-24
- (void)onExpressStatusAction:(NSNotification *)notification
{
    NSString *orderId = [notification object];
    
    CTDeliverStatusVCtler *vc = [[CTDeliverStatusVCtler alloc] init];
    vc.orderId = orderId;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    {
        UIImage *image = [UIImage imageNamed:@"btn_back"];
        if (!image)
        {
            return;
        }
        
        int x = (image.size.width > 40 ? 0 : 10);
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(0, 0, image.size.width + x, image.size.height);
        [btn setImage:image forState:UIControlStateNormal];
        [btn setImageEdgeInsets:UIEdgeInsetsMake(0, x, 0, 0)];
        [btn addTarget:self action:@selector(onLeftBtnAction) forControlEvents:UIControlEventTouchUpInside];
        
        UIBarButtonItem *baritem = [[UIBarButtonItem alloc] initWithCustomView:btn];
        self.navigationItem.leftBarButtonItem = baritem;
    }
    
    self.tableView.delegate   = self;
    self.tableView.dataSource = self;

    _curPage1 = 1;
    _pageSize1 = 20;
    _endReached1 = YES;
    
    [self doQuery]; // added by zy, 2014-02-24
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    //[self doQuery];   // modified by zy, 2014-02-24
}

#pragma mark - Table view data source

#pragma mark - UITableViewDataSource

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
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
            [self loadNextPage];
            return cell;
        }
        
        static NSString *kCellIdentifier = @"MyOrderCellId1";
        CTMyOrderCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellIdentifier];
        if (cell == nil) {
            cell = [[CTMyOrderCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kCellIdentifier];
        }
        [cell setCellInfo:orderItemList[indexPath.row]];
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
        if (_endReached1) {
            return 0;
        }
        return 1;
    }
    return [orderItemList count];
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
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section == 0)
    {
        CTOrderDetailVCtler *vc = [[CTOrderDetailVCtler alloc] init];
        vc.ordrId = orderItemList[indexPath.row][@"OrderId"];
        
        NSDictionary *info = orderItemList[indexPath.row];
        NSString *SalesProdType = @"0";
        if ([info[@"Items"] isKindOfClass:[NSArray class]])
        {
            SalesProdType = info[@"Items"][1][@"SalesProdType"];
        }
        else if ([info[@"Items"] isKindOfClass:[NSDictionary class]])
        {
            SalesProdType = info[@"Items"][@"SalesProdType"];
        }
        if ((   ([info[@"OrderStatusCode"] intValue] == 11108)
             || ([info[@"OrderStatusCode"] intValue] == 11109))
             && ([SalesProdType isEqualToString:@"4"] ||
                 [SalesProdType isEqualToString:@"42"]))
        {
            [vc setcardInfo:0 cardType:[SalesProdType intValue]];
        }
        else
        {
            [vc setcardInfo:1 cardType:[SalesProdType intValue]];
        }
        
        [self.navigationController pushViewController:vc animated:YES];
    }
}

-(void)doQuery
{
    switch (_QStatusType) {
        case CQQ_Status_ByNetInfo:
        {
            // added by zy, 2014-02-24
            NSData* data = [_namestr dataUsingEncoding:NSUTF8StringEncoding];
            _namestr = [data base64EncodedString];
            _namestr = [Utils encodedURLParameterString:_namestr];
            // added by zy, 2014-02-24
            
            NSString* name        = _namestr;
            NSString* IdCardNbr   = _codestr;
            NSNumber* page        = [NSNumber numberWithInteger:_curPage1];
            NSNumber* pagesize    = [NSNumber numberWithInteger:_pageSize1];
            NSDictionary *params= [NSDictionary dictionaryWithObjectsAndKeys:
                                   name,@"Name",
                                   IdCardNbr,@"IdCardNbr",
                                   page,@"PageIndex",
                                   pagesize,@"PageSize",
                                   nil];
            self._QryOperation   =
            [MyAppDelegate.cserviceEngine postXMLWithCode:@"qryOrderByReginfo"
                                                   params:params
                                              onSucceeded:^(NSDictionary *dict) {
                                                  DLog(@"***qryOrderByReginfo\r\n%@",dict);
                                                  ++_curPage1;
                                                  [self qryOrderByReginfoBack:dict];
                                              } onError:^(NSError *engineError) {
                                                  DDLogInfo(@"%s--%@", __func__, engineError);
                                                  SIAlertView *alertView =
                                                  [[SIAlertView alloc] initWithTitle:nil
                                                                          andMessage:@"您输入的信息未找到订单，试试用其他信息查找"/*[engineError localizedDescription]*/];   // modified by zy, 20140214
                                                  
                                                  [alertView addButtonWithTitle:@"确定"
                                                                           type:SIAlertViewButtonTypeDefault
                                                                        handler:^(SIAlertView *alertView){
                                                                        }];
                                                  alertView.transitionStyle = SIAlertViewTransitionStyleBounce;
                                                  [alertView show];
                                              }];
        }break;
        case CQQ_Status_ByUseInfo:
        {
            NSData* data = [_namestr dataUsingEncoding:NSUTF8StringEncoding];
            _namestr = [data base64EncodedString];
#if 0       // modified by zy, 2014-02-24
            _namestr = [_namestr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
#else
            _namestr = [Utils encodedURLParameterString:_namestr];
#endif

            NSString* name        = _namestr;
            NSString* PhoneNumber = _codestr;
            NSNumber* page        = [NSNumber numberWithInteger:_curPage1];
            NSNumber* pagesize    = [NSNumber numberWithInteger:_pageSize1];
            NSDictionary *params= [NSDictionary dictionaryWithObjectsAndKeys:
                                   name,@"Name",
                                   PhoneNumber,@"PhoneNumber",
                                   page,@"PageIndex",
                                   pagesize,@"PageSize",
                                   nil];
            self._QryOperation   =
            [MyAppDelegate.cserviceEngine postXMLWithCode:@"qryOrderByAddress"
                                                   params:params
                                              onSucceeded:^(NSDictionary *dict) {
                                                  DLog(@"***qryOrderByAddress\r\n%@",dict);
                                                  ++_curPage1;
                                                  [self qryOrderByAddressBack:dict];
                                              } onError:^(NSError *engineError) {
                                                  // 取消掉全部请求和回调，避免出现多个弹框
                                                  [MyAppDelegate.cserviceEngine cancelAllOperations];
                                                  // 提示重新登录，
                                                  SIAlertView *alertView =
                                                  [[SIAlertView alloc] initWithTitle:nil
                                                                          andMessage:@"您输入的信息未找到订单，试试用其他信息查找"/*[engineError localizedDescription]*/];   // modified by zy, 20140214

                                                  [alertView addButtonWithTitle:@"确定"
                                                                           type:SIAlertViewButtonTypeDefault
                                                                        handler:^(SIAlertView *alertView){
                                                                        }];
                                                  alertView.transitionStyle = SIAlertViewTransitionStyleBounce;
                                                  [alertView show];
                                              }];
        }break;
        default:
            break;
    }
}

-(void)qryOrderByReginfoBack:(NSDictionary*)dict{
    
#if 0   // modified by zy, 2014-02-24
    NSDictionary* datadict = [dict objectForKey:@"Data"];
    if (!datadict) {
        return;
    }
    
    id dataList = [datadict objectForKey:@"DataList"];
    if (dataList == nil|| dataList == [NSNull null]
        || [dataList isEqualToString:@"null"])
    {
        UILabel *tipLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 44, 320, 44)];
        tipLabel.backgroundColor = [UIColor clearColor];
        tipLabel.font = [UIFont systemFontOfSize:17.0f];
        tipLabel.textColor = [UIColor blackColor];
        tipLabel.textAlignment = UITextAlignmentCenter;
        tipLabel.text = @"暂无订单！";
        [self.tableView addSubview:tipLabel];
    }
    // 刷新列表
    [self.tableView reloadData];
#else
    NSDictionary* datadict = [dict objectForKey:@"Data"];
    if (!datadict)
    {
        return;
    }
    
    id dataList = [datadict objectForKey:@"DataList"];
    id totalcount = [datadict objectForKey:@"TotalCount"];
    if ([dataList isKindOfClass:[NSArray class]])
    {
        [orderItemList addObjectsFromArray:dataList];
        if ([dataList count] < 20)
        {
            _endReached1 = YES;
        }
    }else if ([dataList isKindOfClass:[NSDictionary class]])
    {
        [orderItemList addObject:dataList];
        if ([orderItemList count] >= [totalcount intValue])
        {
            _endReached1 = YES;
        }else{
            _endReached1 = NO;
        }
    }else if (dataList == nil|| dataList == [NSNull null]
              || [dataList isEqual:@"null"])
    {
        _endReached1 = YES;
    }
    
    if ([orderItemList count] <= 0)
    {
        UILabel *tipLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 44, 320, 44)];
        tipLabel.backgroundColor = [UIColor clearColor];
        tipLabel.font = [UIFont systemFontOfSize:13.0f];
        tipLabel.textColor = [UIColor blackColor];
        tipLabel.textAlignment = UITextAlignmentCenter;
        tipLabel.text = @"您输入的信息未找到订单，试试用其他信息查找";//@"暂无订单！";    // modified by zy, 2014-02-13
        tipLabel.numberOfLines = 0; // added by zy, 2014-02-13
        [self.tableView addSubview:tipLabel];
    }else
    {
        [self.tableView reloadData];
    }
#endif
};


-(void)qryOrderByAddressBack:(NSDictionary*)dict{
    NSDictionary* datadict = [dict objectForKey:@"Data"];
    if (!datadict) {
        return;
    }
    
    id dataList   = [datadict objectForKey:@"DataList"];
    id totalcount = [datadict objectForKey:@"TotalCount"];
    if ([dataList isKindOfClass:[NSArray class]])
    {
        [orderItemList addObjectsFromArray:dict[@"Data"][@"DataList"]];
        if ([dict[@"Data"][@"DataList"] count] < 20)
        {
            _endReached1 = YES;
        }
    }else if ([dataList isKindOfClass:[NSDictionary class]])
    {
        [orderItemList addObject:dict[@"Data"][@"DataList"]];
        if ([orderItemList count] >= [totalcount intValue])
        {
            _endReached1 = YES;
        }else{
            _endReached1 = NO;
        }
    }else if (dataList == nil|| dataList == [NSNull null]
              || [dataList isEqualToString:@"null"])
    {
        _endReached1 = YES;
    }
    
    if ([orderItemList count] <= 0)
    {
        UILabel *tipLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 44, 320, 44)];
        tipLabel.backgroundColor = [UIColor clearColor];
        tipLabel.font = [UIFont systemFontOfSize:13.0f];
        tipLabel.textColor = [UIColor blackColor];
        tipLabel.textAlignment = UITextAlignmentCenter;
        tipLabel.text = @"您输入的信息未找到订单，试试用其他信息查找";//@"暂无订单！";    // modified by zy, 2014-02-13
        tipLabel.numberOfLines = 0; // added by zy, 2014-02-13
        [self.tableView addSubview:tipLabel];
    }else
    {
        [self.tableView reloadData];
    }
};

- (void)loadNextPage
{
    if (_endReached1 == NO) {
        [self doQuery];
    }
}

- (void)onLeftBtnAction
{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
