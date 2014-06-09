//
//  CTOrderRechargeVCtler.m
//  CTPocketV4
//
//  Created by apple on 13-11-4.
//  Copyright (c) 2013年 广东亿迅科技有限公司. All rights reserved.
//

#import "CTOrderRechargeVCtler.h"
#import "AppDelegate.h"
#import "CserviceOperation.h"
#import "CTRechargeSucessVCtler.h"
#import "CTOrderConfirmVCtler.h"
#import "SVProgressHUD.h"
#import "ToastAlertView.h"
#import "SIAlertView.h"

@interface CTOrderRechargeVCtler ()
{
    
}

@property (nonatomic, strong) UIWebView *webView;
@property (nonatomic, strong) UIActivityIndicatorView *activityViewInfo;
@property (nonatomic, strong) CserviceOperation *rechargeQueryOpt;

@end

@implementation CTOrderRechargeVCtler

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
	// Do any additional setup after loading the view.
    self.title = @"订单支付";
    [self setLeftButton:[UIImage imageNamed:@"btn_back.png"]];
}

- (void) viewWillAppear:(BOOL)animated{
    {
        UIWebView * webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame))];
        webView.delegate = (id<UIWebViewDelegate>)self;
        webView.backgroundColor = [UIColor whiteColor];
        webView.scalesPageToFit = YES;
        [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:([self.jumpUrl length] ? self.jumpUrl : @"http://jf.189.cn/wap")]]];
        self.webView = webView ;
        [self.view addSubview:webView];
    }
    {
        UIActivityIndicatorView * activityview = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        activityview.frame = CGRectMake(100, 250, 14, 14);
//        activityview.center = self.view.center ;
        activityview.center = self.webView.center;
        activityview.hidesWhenStopped = YES;
        [self.view addSubview:activityview];
        self.activityViewInfo = activityview;
    }
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    [_webView stopLoading];
    _webView = nil;
    self.activityViewInfo = nil;
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - CTPNavBarDelegate
-(void)onleftBtnAction:(id)sender
{
    [_webView stopLoading];
    if (!self.needBack2Rootview)
    {
        [self.navigationController popViewControllerAnimated:YES];
    }
    else
    {
        [self.navigationController popToRootViewControllerAnimated:YES];
    }
}

#pragma mark
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request
                                                 navigationType:(UIWebViewNavigationType)navigationTyp
{    
    return YES ;
}

- (void) onLeftBtnAction:(id)sender
{
    if (self.rechargeQueryOpt) {
        [self.rechargeQueryOpt cancel];
        self.rechargeQueryOpt = nil;
    }
    NSString *OrderId = @"";
    OrderId =[self.orderInfo objectForKey:@"OrderId"];

    NSString *UserId = [Global sharedInstance].custInfoDict[@"UserId"] ? [Global sharedInstance].custInfoDict[@"UserId"] : @"bank888";
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
                            OrderId, @"OrderId",
                            UserId, @"UserId",nil];
    
    [SVProgressHUD showWithStatus:@"请稍候..." maskType:SVProgressHUDMaskTypeGradient];
    
    __block CTOrderRechargeVCtler *weakSelf = self;
    self.rechargeQueryOpt = [MyAppDelegate.cserviceEngine postXMLWithCode:@"qryOrderInfo"
                                                                   params:params
                                                              onSucceeded:^(NSDictionary *dict)
                             {
                                 //跳转到充值成功页
                                 NSLog(@"成功");
                                 /*
                                     10702	支付中	    10702	支付中（用户点击支付按钮到支付反馈）
                                     10101	已支付	    10101	支付成功（货到付款没有此状态）
                                     10102	订单待审核	10102	系统审核订单
                                     10103	订单已审核	10102	系统审核订单
                                     10104	订单不通过	10104	订单关闭（超时未支付）
                                     10701	已取消	    10701	已取消（用户取消）
                                     10105	备货中	    10105	开始备货
                                     10106	写卡	        10105	开始备货
                                     10107	打印协议	    10105	开始备货
                                     10108	配件准备	    10105	开始备货
                                     10109	发票打印	    10105	开始备货
                                     10110	备货完成	    10105	开始备货
                                     10111	物流配送	    10111	已发货（线上支付时有效）
                                     10120	物流配送	    10120	货物抵达自提点(上门自提时有效)
                                  
                                                          11104	充值中
                                                          11105	充值成功
                                                          11106	充值失败
                                                          11108	购买成功
                                                          11109	购买失败
                                                          11201	退款中
                                                          11202	退款成功
                                                          11203	退款失败
                                  */
                                 NSDictionary *data = [dict objectForKey:@"Data"];
                                 if (data && [data respondsToSelector:@selector(objectForKey:)]) {
                                     NSString *OrderStatusCode = [data objectForKey:@"OrderStatusCode"];
                                     NSString *OrderStatusDescription = [data objectForKey:@"OrderStatusDescription"];
                                     if (OrderStatusCode && OrderStatusCode.length>0) {
                                         { //充值成功
                                             
                                             //跳转充值成功页面 (跳转到确认页面 )
                                             CTOrderConfirmVCtler *rechargeSuceessVCtler = [CTOrderConfirmVCtler new] ;
                                             [self.orderInfo setObject:OrderStatusDescription forKey:@"OrderStatusDescription"]; //状态描述
                                             [self.orderInfo setObject:OrderStatusCode forKey:@"OrderStatusCode"];
//                                             [self.orderInfo setObject: forKey:OrderCreatedDate];
                                             rechargeSuceessVCtler.orderInfo = self.orderInfo;
                                             
                                             rechargeSuceessVCtler.rechargeInfoDict = [NSMutableDictionary dictionaryWithDictionary:data] ;
                                             rechargeSuceessVCtler.rechargeType = weakSelf.rechargeType;  //支付成功或者是失败
                                             
                                             NSString *pageType = [self.orderInfo objectForKey:@"PageType"];
                                             if ([pageType intValue] == 0) {
                                                  rechargeSuceessVCtler.pageType = 2;    // 0 确认  1 银行卡充值  2 购买卡密
                                             }else{
                                                  rechargeSuceessVCtler.pageType = 4;    // 跳转购买卡密的页面
                                             }
                                            
                                             [weakSelf.navigationController pushViewController:rechargeSuceessVCtler animated:YES];
                                         }
                                     }
                                 }else{
                                     //跳转充值失败页面 
                                 }
                                 
                                 [SVProgressHUD dismiss];
                             }onError:^(NSError *engineError) {
                                 DDLogInfo(@"%s--%@", __func__, engineError);
                                 [SVProgressHUD dismiss];
                                 if ([engineError.userInfo objectForKey:@"ResultCode"])
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
                                 else{
                                     [SVProgressHUD dismiss];
                                     ToastAlertView *alert = [ToastAlertView new];
                                     [alert showAlertMsg:@"系统繁忙，请稍后再试"];
                                 }
                             }];
    
    
}

- (void)webViewDidStartLoad:(UIWebView *)webView
{
    [self.activityViewInfo startAnimating];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    
    [self.activityViewInfo stopAnimating];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    [self.activityViewInfo stopAnimating];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
