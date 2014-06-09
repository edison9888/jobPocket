//
//  EsLoadingVCtler.m
//  xhgdzwyq
//
//  Created by apple on 13-11-23.
//  Copyright (c) 2013年 Eshore. All rights reserved.
//  启动页面

#import "EsLoadingVCtler.h"
#import "Reachability.h"
#import "NSMutableDataAdditions.h"

@interface EsLoadingVCtler ()
{
    UILabel*    _tipmsgLab;
    UIButton*   _tipmsgBtn;
}

@property (nonatomic, strong) Reachability* reachability;

@end

@implementation EsLoadingVCtler

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
    [NSObject cancelPreviousPerformRequestsWithTarget:self];
    [self.reachability stopNotifier];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    {
        UIImage* img = [UIImage imageNamed:@"Default"];
        if (__iPhone5__)
        {
            img = [UIImage imageNamed:@"Default-568h"];
        }
        UIImageView* v = [[UIImageView alloc] initWithImage:img];
        v.frame = CGRectMake(0, -20, v.frame.size.width, v.frame.size.height);
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 70000
        if ( IOS7_OR_LATER )
        {
            v.frame = CGRectMake(0, 0, v.frame.size.width, v.frame.size.height);
        }
#endif
        [self.view addSubview:v];
    }
    {
        UILabel * lab = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetHeight(self.view.frame) - 140, CGRectGetWidth(self.view.frame), 30)];
        lab.text      = @"";
        lab.backgroundColor = [UIColor clearColor];
        lab.textColor = [UIColor whiteColor];
        lab.textAlignment = UITextAlignmentCenter;
        lab.font      = [UIFont systemFontOfSize:15];
        lab.autoresizingMask = UIViewAutoresizingFlexibleTopMargin;
        [self.view addSubview:lab];
        _tipmsgLab = lab;
    }
    {
        UILabel * lab = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetHeight(self.view.frame) - 60, CGRectGetWidth(self.view.frame), 30)];
        lab.text      = [NSString stringWithFormat:@"v%@", [[NSBundle mainBundle] infoDictionary][@"CFBundleShortVersionString"]];
        lab.backgroundColor = [UIColor clearColor];
        lab.textColor = [UIColor whiteColor];
        lab.textAlignment = UITextAlignmentCenter;
        lab.font      = [UIFont systemFontOfSize:12];
        lab.autoresizingMask = UIViewAutoresizingFlexibleTopMargin;
        [self.view addSubview:lab];
    }
    {
        UIButton* btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = self.view.bounds;
        btn.enabled = NO;
        [btn addTarget:self action:@selector(onTipmsgBtn) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:btn];
        _tipmsgBtn = btn;
        [self performSelector:@selector(onTipmsgBtn) withObject:nil afterDelay:5];
    }
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(reachabilityChanged:)
                                                 name:kReachabilityChangedNotification
                                               object:nil];
    //检查网络
    Reachability* reachable = [Reachability reachabilityWithHostname:@"app.xhzwyq.com"];
    [reachable performSelector:@selector(startNotifier) withObject:nil afterDelay:2];
    self.reachability = reachable;
}

- (void)reachabilityChanged:(NSNotification*)note
{
    [NSObject cancelPreviousPerformRequestsWithTarget:self];
    Reachability * reach = [note object];
    if([reach isReachable])
    {
        [self.reachability stopNotifier];
        _tipmsgLab.text = @"登录中，请稍候...";
        [self performSelector:@selector(autoLogin) onThread:[NSThread mainThread] withObject:nil waitUntilDone:YES];
    }
    else
    {
        _tipmsgLab.text = @"网络连接失败，请检查后点击屏幕重试";
        _tipmsgBtn.selected = YES;
        _tipmsgBtn.enabled = YES;
    }
}

- (void)onTipmsgBtn
{
    [NSObject cancelPreviousPerformRequestsWithTarget:self];
    _tipmsgBtn.selected = !_tipmsgBtn.selected;
    _tipmsgBtn.enabled = NO;
    if (_tipmsgBtn.selected)
    {
        _tipmsgLab.text = @"网络连接失败，请检查后点击屏幕重试";
        _tipmsgBtn.enabled = YES;
    }
    else
    {
        _tipmsgLab.text = @"正在重新登录中，请稍候";
        [self performSelector:@selector(onTipmsgBtn) withObject:nil afterDelay:5];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)autoLogin
{
    NSUserDefaults* defaults = [NSUserDefaults standardUserDefaults];
	NSString* phone = [defaults objectForKey:kPhoneNumber];
    NSString* pwd = [defaults objectForKey:kVerifyCode];
    
    if ([pwd length])
    {
        // base64解密
        NSData*pdata  = [NSData dataFromBase64String:pwd];
        // AES解密
        NSMutableData* mulDecode     = [NSMutableData dataWithData:pdata];
        NSMutableData *dataAftdecode = [mulDecode DecryptAES:kAES256Key andForData:mulDecode];
        pwd  = [[NSString alloc] initWithData:dataAftdecode encoding:NSUTF16StringEncoding];
    }
    
    if (!phone.length ||
        !pwd.length)
    {
        [[NSNotificationCenter defaultCenter] postNotificationName:kMsgAutoLoginFail object:nil];
        return;
    }
    
    NSDictionary* params = @{@"phone" : phone,
                             @"pw" : pwd,
                             @"loginStyle" : @"1",      // 登陆类型 1：手动登陆 2：自动登陆
                             @"token" : @""};
    
    __weak typeof(self) wself = self;
    BaseDataSource* net = [BaseDataSource new];
    [net startGetRequestWithParams:params method:@"loginWithPw" completion:^(id responsedict)
     {
         [wself onLoginFinish:net response:responsedict];
     }];
}

- (void)onLoginFinish:(BaseDataSource* )net response:(NSDictionary* )response
{
    NSString* token = @"";
    BOOL isErr = YES;
    
    do {
        if (response[@"token"] != [NSNull null] &&
            response[@"token"] != nil)
        {
            token = response[@"token"];
            isErr = NO;
            break;
        }
        
        if ([net.errorCode isEqualToString:NETWORK_OK])
        {
            isErr = NO;
            break;
        }
    } while (0);
    
    if (isErr)
    {
        [[NSNotificationCenter defaultCenter] postNotificationName:kMsgAutoLoginFail object:nil];
        ToastAlertView* alert = [ToastAlertView new];
        [alert performSelector:@selector(showAlertMsg:) withObject:@"登录失败，请重新登录" afterDelay:1];
        return;
    }

    NSUserDefaults* defaults = [NSUserDefaults standardUserDefaults];
    if (token.length)
    {
        [defaults setObject:token forKey:kLoginToken];
    }
    [defaults synchronize];
    
    EsUser* user = [EsUser new];
    user.phone = [defaults objectForKey:kPhoneNumber];
    user.token = token;
    NSDictionary *dic = response;
    if ([dic respondsToSelector:@selector(objectForKey:)]) {
        user.clientId = [dic objectForKey:@"clientId"];
        user.clientName = [dic objectForKey:@"clientName"];
        user.department = [dic objectForKey:@"department"];
        user.email = [dic objectForKey:@"email"];
        user.weixinNum = [dic objectForKey:@"weixinNum"];
        user.workplace = [dic objectForKey:@"workplace"];
        
    }
    
    EsUserVerify * userVerify = [EsUserVerify new];
    userVerify.user = user;
    
    [Global sharedSingleton].userVerify = userVerify;
    
    [[NSNotificationCenter defaultCenter] postNotificationName:kMsgLoginSuccess object:nil];
}

@end
