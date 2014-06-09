//
//  EsLoginVCtler.m
//  xhgdzwyq
//
//  Created by apple on 13-11-23.
//  Copyright (c) 2013年 Eshore. All rights reserved.
//

#import "EsLoginVCtler.h"
#import "FlatButton.h"
#import "FlatTextField.h"

static NSString* __helpContext = @"MI+客户端是广东亿迅科技有限公司移动互联网产品部内部使用版本。面向全体 移动互联网产品部的伙伴，以VOMI、My Team、Scrum、Voice of the Custom的 几大模块形式，提炼当下移动互联网行业的最新资讯要闻，热点消息，客户对产 品的反馈等，同时打造移动终端的项目管理实时管理直通车。支持支持Android 等智能操作系统的手机客户端。";

@interface EsLoginVCtler ()
{
    UITextField*    _phoneTf;
    UITextField*    _verifyCodeTf;
    UIButton*       _loginBtn;
}

@end

@implementation EsLoginVCtler

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
//    [self setRightButton:[UIImage imageNamed:@"button_Help"]];
    {
        UIImage* img = [UIImage imageNamed:@"button_Help"];
        UIButton* btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(CGRectGetWidth(self.view.frame) - img.size.width - 30, 0, img.size.width + 30, 44);
        [btn setImage:img forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(onRightBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:btn];
    }
    self.title = @"登录";
    
    int originX = 15;
    int originY = 44;
    
    NSUserDefaults* defaults = [NSUserDefaults standardUserDefaults];
	NSString* phone = [defaults objectForKey:kPhoneNumber];
    
    {
        // 手机号码
        _phoneTf        = [self addTextField2View:CGRectMake(originX, originY, CGRectGetWidth(self.view.frame) - 2*originX, 34)
                                             text:phone
                                      placeholder:@"请输入手机号码"];
        originY         = CGRectGetMaxY(_phoneTf.frame) + 20;
        [_phoneTf becomeFirstResponder];
    }
    
    {
        // 验证码
        _verifyCodeTf   = [self addTextField2View:CGRectMake(originX, originY, CGRectGetWidth(self.view.frame) - 2*originX, 34)
                                             text:nil
                                      placeholder:@"请输入密码"];
        _verifyCodeTf.secureTextEntry = YES;
        originY         = CGRectGetMaxY(_verifyCodeTf.frame) + 20;
    }
    {
        // 登录
        UIImage* nimg   = [UIImage imageNamed:@"button_login"];
        UIImage* himg   = [UIImage imageNamed:@"button_login_highlight"];
        UIButton* btn   = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame       = CGRectMake((int)(CGRectGetWidth(self.view.frame) - nimg.size.width)/2,
                                     originY,
                                     nimg.size.width,
                                     nimg.size.height);
        [btn setBackgroundImage:nimg forState:UIControlStateNormal];
        [btn setBackgroundImage:himg forState:UIControlStateHighlighted];
        [btn setTitle:@"登录" forState:UIControlStateNormal];
        [btn setTitle:@"正在登录，请稍候..." forState:UIControlStateDisabled];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [btn.titleLabel setFont:[UIFont systemFontOfSize:15]];
        [btn addTarget:self action:@selector(onLoginBtn) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:btn];
        _loginBtn = btn;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark private

- (UITextField* )addTextField2View:(CGRect)frame
                              text:(NSString* )text
                       placeholder:(NSString* )placeholder
{
    UITextField* tf = [[FlatTextField alloc] initWithFrame:frame];
    tf.backgroundColor = RGB(0xad, 0xad, 0xad, 1);
    tf.font         = [UIFont systemFontOfSize:14];
    tf.textColor    = [UIColor grayColor];
    tf.placeholder  = (placeholder.length ? placeholder : @"");
    tf.text         = (text.length ? text : @"");
    tf.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    tf.keyboardType = UIKeyboardTypeNumberPad;
    tf.clearButtonMode = UITextFieldViewModeWhileEditing;
    tf.delegate     = (id<UITextFieldDelegate>)self;
    [self.view addSubview:tf];
    
    {
        UIView* v   = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 5, 10)];
        v.backgroundColor = [UIColor clearColor];
        tf.leftView = v;
        tf.leftViewMode = UITextFieldViewModeAlways;
    }
    
    return tf;
}

- (void)onRightBtnAction:(id)sender
{
    [self onHelpBtn];
}

- (void)onHelpBtn
{
    UIAlertView*  alert = [[UIAlertView alloc] initWithTitle:@"帮助"
                                                     message:__helpContext
                                                    delegate:nil
                                           cancelButtonTitle:@"确定"
                                           otherButtonTitles:nil];
    [alert show];
}

- (void)onLoginBtn
{
    NSString* phone = _phoneTf.text;
    if (![Utils isMobileNumber:phone])
    {
        ToastAlertView* alert = [ToastAlertView new];
        [alert showAlertMsg:@"帐号格式不正确，请输入正确的手机号"];
        return;
    }
    
    NSString* identifyCode = _verifyCodeTf.text;
    if (!identifyCode.length)
    {
        ToastAlertView* alert = [ToastAlertView new];
        [alert showAlertMsg:@"密码不能为空"];
        return;
    }
    
    NSDictionary* params = @{@"phone" : phone,
                             @"pw" : identifyCode,
                             @"loginStyle" : @"1",      // 登陆类型 1：手动登陆 2：自动登陆
                             @"token" : @""};
    
    [_verifyCodeTf resignFirstResponder];
    [_phoneTf resignFirstResponder];
    self.view.userInteractionEnabled = NO;
    _loginBtn.enabled = NO;
    __weak typeof(self) wself = self;
    BaseDataSource* net = [BaseDataSource new];
    [net startGetRequestWithParams:params method:@"loginWithPw" completion:^(id responsedict)
     {
         [wself onLoginFinish:net response:responsedict];
     }];
}

- (void)onLoginFinish:(BaseDataSource* )net response:(NSDictionary* )response
{
    [_verifyCodeTf resignFirstResponder];
    [_phoneTf resignFirstResponder];
    self.view.userInteractionEnabled = YES;
    _loginBtn.enabled = YES;
    
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
        NSString* errMsg = @"对不起，登录失败";
        //wensj 处理有黑点的问题
//        if (net.errorMsg)
        if (net.errorMsg && net.errorMsg.length>0)
        {
            errMsg = net.errorMsg;
        }
        
        NSString* errorCode = net.errorCode;
        if ([errorCode isEqualToString:NETWORK_VERIFYERR])      errMsg = @"登录失败，请重试";
        if ([errorCode isEqualToString:NETWORK_NOPHONENUM])     errMsg = @"该号码尚未开通订阅服务，请联系办理业务的客户经理";
        
        ToastAlertView* alert = [ToastAlertView new];
        [alert showAlertMsg:errMsg];
        return ;
    }
    
    {
        // 保存手机号码与验证码
        NSUserDefaults* def = [NSUserDefaults standardUserDefaults];
        [def setObject:_phoneTf.text forKey:kPhoneNumber];
        
        // 对验证码进行加密
        NSString* code = _verifyCodeTf.text;
        // 加密 AES
        NSMutableData* objNSData = [NSMutableData dataWithData:[code dataUsingEncoding:NSUTF16StringEncoding]];
        objNSData = [objNSData EncryptAES:kAES256Key];
        // 加密 BASE64
        NSString* encode = [objNSData base64EncodedString];
        [def setObject:encode forKey:kVerifyCode];
        
        if (token.length)
        {
            [def setObject:token forKey:kLoginToken];
        }
        
        [def synchronize];
    }
    
    NSUserDefaults* defaults = [NSUserDefaults standardUserDefaults];
    EsUser* user = [EsUser new];
    user.phone = [defaults objectForKey:kPhoneNumber];
    user.token = [defaults objectForKey:kLoginToken];
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

#pragma mark UITextfieldDelegate
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (textField == _phoneTf)
    {
        return ([string length] <= 0 || [textField.text length] < 11);
    }
    else if (textField == _verifyCodeTf)
    {
        return (string.length <= 0 || textField.text.length < 6);
    }
    
    return YES;
}

@end
