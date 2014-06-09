//
//  CTPOnlineServiceVCtler.m
//  CTPocketv3
//
//  Created by lyh on 13-4-17.
//
//

#import "CTPOnlineServiceVCtler.h"
#import "AppDelegate.h"
#import "Utils.h"
#import "NSString+MKNetworkKitAdditions.h"
#import "SIAlertView.h"
#import "MBProgressHUD.h"

#define kOnlineServiceKey @"zhangting01"   // 加密密钥

@interface CTPOnlineServiceVCtler ()
@property (strong, nonatomic) MBProgressHUD *hud;
@end

@implementation CTPOnlineServiceVCtler
@synthesize _wvOnlineService;

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
    [self setTitle:@"在线客服"];
    // 左按钮
    [self setLeftButton:[UIImage imageNamed:@"btn_back"]];
    
    //[self.view setBackgroundColor:[UIColor whiteColor]];
    
    if (_wvOnlineService)
    {
        _wvOnlineService = nil;
    }
    _wvOnlineService = [[UIWebView alloc] initWithFrame:self.view.bounds];
    _wvOnlineService.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [_wvOnlineService setDelegate:self];
    [_wvOnlineService setBackgroundColor:[UIColor whiteColor]];
    [_wvOnlineService setOpaque:NO];
    _wvOnlineService.scalesPageToFit =YES;
    
    [self.view addSubview:_wvOnlineService];
//    NSString *urlAddress = [NSString stringWithFormat:@"http://im.189.cn/cw/?cid=%@&uan=%@&k=%@&t=%@&cf=%@&manId=866",strCid,strUan,strKey,strTime,strCf];
//    NSLog(@"%@", urlAddress);
//    [self._wvOnlineService loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:urlAddress]]];
//    [self.view addSubview:_wvOnlineService];
    [self custServiceAreaCode];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    if (_activeIndicatorView) {
        [_activeIndicatorView stopAnimating];
        _activeIndicatorView = nil;
    }
    [_wvOnlineService stopLoading];
    _wvOnlineService = nil;
    
    [super viewDidUnload];
}

-(void)dealloc
{
    if (_activeIndicatorView) {
        [_activeIndicatorView stopAnimating];
        _activeIndicatorView = nil;
    }
    [_wvOnlineService setDelegate:nil];
    [_wvOnlineService stopLoading];
}

#pragma mark -
#pragma mark UIWebViewDelegate
- (void)webViewDidStartLoad:(UIWebView *)webView
{
    //[webView setAlpha:0.0];
    // 系统圆形进度条
    if (_activeIndicatorView) {
        [_activeIndicatorView stopAnimating];
        _activeIndicatorView = nil;
    }
    _activeIndicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    _activeIndicatorView.center = CGPointMake(self.view.bounds.size.width / 2, self.view.bounds.size.height / 2);
    [self.view addSubview:_activeIndicatorView];
    [_activeIndicatorView startAnimating];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    NSLog(@"webViewDidFinishLoad");
    if (_activeIndicatorView) {
        [_activeIndicatorView stopAnimating];
    }
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    NSLog(@"didFailLoadWithError");
    if (_activeIndicatorView) {
        [_activeIndicatorView stopAnimating];
    }
    
#ifdef ENV_TEST
	NSLog(@"%@",NSStringFromSelector(_cmd));
    NSLog(@"%d",[error code]);
	NSLog(@"%@%@",[error localizedDescription],[error localizedFailureReason]);
#endif
	
    NSString *message = @"";
	if ([error code]==-1001) {
		message = @"连接超时，请稍后重试！";
	}else if ([error code]==-1004) {
		message = @"未能连接服务器！";
	}else if ([error code]==-1009) {
		message = @"网络连接已经断开，请稍后重试！";
	}else {
		message = [error localizedFailureReason];
	}
    
    NSLog(@"%@", message);
    if ([message length]){
    }
	return;
}


#pragma mark -
#pragma mark - CTPNavBarDelegate
-(void)onleftBtnAction:(id)sender
{
    [_wvOnlineService stopLoading];
    _wvOnlineService = nil;
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)onrightBtnAction:(id)sender
{    
}

#pragma mark - Custom Method

- (void)custServiceAreaCode
{
    if (!self.hud) {
        self.hud = [[MBProgressHUD alloc] initWithView:self.view];
        [self.view addSubview:self.hud];
    }
    [self.hud show:NO];
    
    NSDictionary *loginInfoDict = [Global sharedInstance].loginInfoDict;
    NSString *phoneNbr = loginInfoDict[@"UserLoginName"];
    
    NSDictionary *params = @{@"PhoneNbr": phoneNbr};
    
    [MyAppDelegate.cserviceEngine postXMLWithCode:@"custServiceAreaCode"
                                           params:params
                                      onSucceeded:^(NSDictionary *dict) {
                                          [self.hud hide:YES];
                                          DDLogInfo(@"CityId:%@\n", dict[@"Data"][@"CityId"]);
                                          
                                          NSString* strCid = dict[@"Data"][@"CityId"] ? dict[@"Data"][@"CityId"] : @"1020&manId=866";
                                          NSString* strUan = [Utils getPhone];
                                          NSString* strKey = @"";                 //@"eec7a98e7f";
                                          NSString* strTime= [NSString stringWithFormat:@"%.0f", [[NSDate date] timeIntervalSince1970]];//@"1364453418354";//
                                          NSString* strCf  = @"1";
                                          
                                          /*
                                           1、Key(密钥)
                                           密钥由IM平台与掌厅客户端协商确定，用以防止IM平台开放接口被恶意攻击
                                           2、k的加密规则
                                           k=MD5. (uan+key+time,”utf-8”)获取后10位长度的字符串
                                           */
                                          strKey = [[NSString stringWithFormat:@"%@%@%@", strUan, kOnlineServiceKey, strTime] md5];
                                          strKey = [[strKey substringFromIndex:[strKey length] - 10] lowercaseString];
                                          
                                          NSString *urlAddress = [NSString stringWithFormat:@"http://im.189.cn/cw/?cid=%@&uan=%@&k=%@&t=%@&cf=%@",strCid,strUan,strKey,strTime,strCf];
                                          NSLog(@"%@", urlAddress);
                                          [self._wvOnlineService loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:urlAddress]]];

                                          
                                      } onError:^(NSError *engineError) {
                                          
                                          [self.hud hide:YES];
                                          
                                          NSString* strCid = @"1020";             //@"3501";
                                          NSString* strUan = [Utils getPhone];
                                          NSString* strKey = @"";                 //@"eec7a98e7f";
                                          NSString* strTime= [NSString stringWithFormat:@"%.0f", [[NSDate date] timeIntervalSince1970]];//@"1364453418354";//
                                          NSString* strCf  = @"1";
                                          
                                          /*
                                           1、Key(密钥)
                                           密钥由IM平台与掌厅客户端协商确定，用以防止IM平台开放接口被恶意攻击
                                           2、k的加密规则
                                           k=MD5. (uan+key+time,”utf-8”)获取后10位长度的字符串
                                           */
                                          strKey = [[NSString stringWithFormat:@"%@%@%@", strUan, kOnlineServiceKey, strTime] md5];
                                          strKey = [[strKey substringFromIndex:[strKey length] - 10] lowercaseString];
                                          
                                          NSString *urlAddress = [NSString stringWithFormat:@"http://im.189.cn/cw/?cid=%@&uan=%@&k=%@&t=%@&cf=%@&manId=866",strCid,strUan,strKey,strTime,strCf];
                                          NSLog(@"%@", urlAddress);
                                          [self._wvOnlineService loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:urlAddress]]];

                                          
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
                                          }
                                      }];
}

@end
