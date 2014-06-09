//
//  CTChangePasswordVCtler.m
//  CTPocketV4
//
//  Created by 许忠洲 on 13-11-14.
//  Copyright (c) 2013年 广东亿迅科技有限公司. All rights reserved.
//  忘记密码

#import "CTChangePasswordVCtler.h"
#import "AppDelegate.h"
#import "Utils.h"
#import "SIAlertView.h"
#import "SVProgressHUD.h"
#import "ToastAlertView.h"

@interface CTChangePasswordVCtler () <UITextFieldDelegate>

@property (nonatomic, strong) UITextField *phoneTF;
@property (nonatomic, strong) UITextField *verifyCodeTF;
@property (strong, nonatomic) UIButton *randomBtn;
@property (strong, nonatomic) UILabel *tipLabel;
@property (nonatomic, strong) UITextField *pwdTF1;
@property (nonatomic, strong) UITextField *pwdTF2;
@property (nonatomic, strong) UIScrollView *scrollView;
@end

@implementation CTChangePasswordVCtler

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
        self.navigationItem.title = @"修改密码";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    UIScrollView *scrollview = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:scrollview];
    self.scrollView = scrollview ;
    
    // 左按钮
    [self setLeftButton:[UIImage imageNamed:@"btn_back"]];
    
    // 隐藏键盘按钮
    {
        UIButton *tBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        tBtn.frame = self.view.bounds;
        tBtn.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        [tBtn addTarget:self action:@selector(hideAllKeyboard) forControlEvents:UIControlEventTouchUpInside];
        [scrollview addSubview:tBtn];
    }
    
    // phoneTF
    {
        self.phoneTF = [[UITextField alloc] initWithFrame:CGRectMake(30, 34, 260, 38)];
        self.phoneTF.backgroundColor = [UIColor whiteColor];
        self.phoneTF.placeholder = @"请输入电信手机号码";
        self.phoneTF.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        self.phoneTF.font = [UIFont systemFontOfSize:14.0f];
        self.phoneTF.borderStyle = UITextBorderStyleNone;
        self.phoneTF.clearButtonMode = UITextFieldViewModeWhileEditing;
        {
            UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 37, 21)];
            UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(8, 0, 16, 21)];
            imageView.image = [UIImage imageNamed:@"login_icon1"];
            [view addSubview:imageView];
            self.phoneTF.leftView = view;
        }
        self.phoneTF.leftViewMode = UITextFieldViewModeAlways;
        self.phoneTF.keyboardType = UIKeyboardTypeNumberPad;
        self.phoneTF.delegate = self;
        if ([Global sharedInstance].isLogin) {
            self.phoneTF.text = [Global sharedInstance].loginInfoDict[@"UserLoginName"];
        }
        
        [scrollview addSubview:self.phoneTF];
    }
    
    // verifyCodeTF
    {
        self.verifyCodeTF = [[UITextField alloc] initWithFrame:CGRectMake(30, 100, 260, 38)];
        self.verifyCodeTF.backgroundColor = [UIColor whiteColor];
        self.verifyCodeTF.placeholder = @"请输入验证码";
        self.verifyCodeTF.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        self.verifyCodeTF.font = [UIFont systemFontOfSize:14.0f];
        //self.verifyCodeTF.textColor
        self.verifyCodeTF.borderStyle = UITextBorderStyleNone;
        self.verifyCodeTF.clearButtonMode = UITextFieldViewModeWhileEditing;
        self.verifyCodeTF.clearsOnBeginEditing = YES;
        {
            UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 37, 21)];
            UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(8, 0, 16, 21)];
            imageView.image = [UIImage imageNamed:@"login_icon3"];
            [view addSubview:imageView];
            self.verifyCodeTF.leftView = view;
        }
        self.verifyCodeTF.leftViewMode = UITextFieldViewModeAlways;
        {
            UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 78, 38)];
            
            self.randomBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            self.randomBtn.frame = view.bounds;
            [self.randomBtn setBackgroundImage:[UIImage imageNamed:@"login_green"] forState:UIControlStateNormal];
            [self.randomBtn setBackgroundImage:[UIImage imageNamed:@"login_gray"] forState:UIControlStateDisabled];
            self.randomBtn.titleLabel.font = [UIFont systemFontOfSize:14.0f];
            [self.randomBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
            [self.randomBtn addTarget:self action:@selector(getRandomInfo) forControlEvents:UIControlEventTouchUpInside];
            [view addSubview:self.randomBtn];
            
            self.verifyCodeTF.rightView = view;
        }
        self.verifyCodeTF.rightViewMode = UITextFieldViewModeAlways;
        self.verifyCodeTF.keyboardType = UIKeyboardTypeNumberPad;
        self.verifyCodeTF.delegate = self;
        
        [scrollview addSubview:self.verifyCodeTF];
    }
    
    // 验证码提示语
    {
        self.tipLabel = [[UILabel alloc] initWithFrame:CGRectMake(30, 138, 260, 28)];
        self.tipLabel.backgroundColor = [UIColor clearColor];
        self.tipLabel.font = [UIFont systemFontOfSize:13.0f];
        self.tipLabel.textColor = [UIColor redColor];
        self.tipLabel.textAlignment = UITextAlignmentCenter;
        self.tipLabel.text = @"已发送验证码到您的手机，请注意查收！";
        [self.view addSubview:self.tipLabel];
        self.tipLabel.hidden = YES;
    }
    
    // 密码1
    {
        self.pwdTF1 = [[UITextField alloc] initWithFrame:CGRectMake(30, 166, 260, 38)];
        self.pwdTF1.backgroundColor = [UIColor whiteColor];
        self.pwdTF1.placeholder = @"请输入新密码";
        self.pwdTF1.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        self.pwdTF1.font = [UIFont systemFontOfSize:14.0f];
        //self.pwdTF1.textColor
        self.pwdTF1.borderStyle = UITextBorderStyleNone;
        self.pwdTF1.clearButtonMode = UITextFieldViewModeWhileEditing;
        self.pwdTF1.clearsOnBeginEditing = YES;
        {
            UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 37, 21)];
            UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(8, 0, 16, 21)];
            imageView.image = [UIImage imageNamed:@"login_icon2"];
            [view addSubview:imageView];
            self.pwdTF1.leftView = view;
        }
        self.pwdTF1.leftViewMode = UITextFieldViewModeAlways;
        self.pwdTF1.keyboardType = UIKeyboardTypeASCIICapable;
        self.pwdTF1.secureTextEntry = YES;
        self.pwdTF1.returnKeyType = UIReturnKeyNext;
        self.pwdTF1.delegate = self;
        
        [scrollview addSubview:self.pwdTF1];
    }
    
    // 密码2
    {
        self.pwdTF2 = [[UITextField alloc] initWithFrame:CGRectMake(30, 232, 260, 38)];
        self.pwdTF2.backgroundColor = [UIColor whiteColor];
        self.pwdTF2.placeholder = @"请再次输入新密码";
        self.pwdTF2.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        self.pwdTF2.font = [UIFont systemFontOfSize:14.0f];
        //self.pwdTF2.textColor
        self.pwdTF2.borderStyle = UITextBorderStyleNone;
        self.pwdTF2.clearButtonMode = UITextFieldViewModeWhileEditing;
        self.pwdTF2.clearsOnBeginEditing = YES;
        {
            UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 37, 21)];
            UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(8, 0, 16, 21)];
            imageView.image = [UIImage imageNamed:@"login_icon2"];
            [view addSubview:imageView];
            self.pwdTF2.leftView = view;
        }
        self.pwdTF2.leftViewMode = UITextFieldViewModeAlways;
        self.pwdTF2.keyboardType = UIKeyboardTypeASCIICapable;
        self.pwdTF2.secureTextEntry = YES;
        self.pwdTF2.returnKeyType = UIReturnKeyDone;
        self.pwdTF2.delegate = self;
        
        [scrollview addSubview:self.pwdTF2];
    }
    
    // 确定按钮
    {
        UIButton *tBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        tBtn.frame = CGRectMake(32, 298, 256, 42);
        [tBtn setBackgroundImage:[UIImage imageNamed:@"login_confirm_button"] forState:UIControlStateNormal];
        [tBtn setBackgroundImage:[UIImage imageNamed:@"login_confirm_button_hl"] forState:UIControlStateHighlighted];
        [tBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, 30, 0, 0)];
        [tBtn setTitle:@"确定" forState:UIControlStateNormal];
        [tBtn addTarget:self action:@selector(onConfirmAction) forControlEvents:UIControlEventTouchUpInside];
        [scrollview addSubview:tBtn];
    }
}

#pragma mark - self func

// 隐藏键盘
- (void)hideAllKeyboard
{
    [self.phoneTF resignFirstResponder];
    [self.verifyCodeTF resignFirstResponder];
    [self.pwdTF1 resignFirstResponder];
    [self.pwdTF2 resignFirstResponder];
}

// 获取验证码
- (void)getRandomInfo
{
    [self hideAllKeyboard];
    // 手机号码错误
    if (self.phoneTF.text.length != 11 ||
        ![Utils isNumber:self.phoneTF.text]) {
        
        SIAlertView *alertView = [[SIAlertView alloc] initWithTitle:nil
                                                         andMessage:@"手机号码是11位哦，请检查"];
        [alertView addButtonWithTitle:@"确定"
                                 type:SIAlertViewButtonTypeDefault
                              handler:^(SIAlertView *alertView) {
                                  NSLog(@"确定");
                              }];
        alertView.transitionStyle = SIAlertViewTransitionStyleBounce;
        [alertView show];
        
        return;
    }
    
    [self.verifyCodeTF becomeFirstResponder];
    
    // 获取验证码
    {
        NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
                                self.phoneTF.text, @"PhoneNbr",
                                @"2000004", @"AccountType", nil];
        
        [MyAppDelegate.cserviceEngine postXMLWithCode:@"getRandomInfo"
                                               params:params
                                          onSucceeded:^(NSDictionary *dict) {
                                              
//                                              ToastAlertView *alert = [ToastAlertView new];
//                                              [alert showAlertMsg:@"操作成功，验证码稍后发送到您的手机，请注意查收，若未收到，请重新获取，谢谢"];
                                              // 显示提示语
                                              self.tipLabel.hidden = NO;
                                              
                                              // 成功获取验证码，倒计时
                                              [self countDown:60];
                                              
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
                                                  [SVProgressHUD showErrorWithStatus:@"出错了，再试一次吧"];
                                              }
                                              
                                              [self countDown:0];
                                              
                                          }];
    }
    
    // 显示提示语
    self.tipLabel.hidden = NO;
    
    //add by liuruxian
    [self.verifyCodeTF becomeFirstResponder];
    
    // 成功获取验证码，倒计时
    [self countDown:60];
}

// 倒计时
- (void)countDown:(NSInteger)count
{
    if (count == 0) {
        self.randomBtn.enabled = YES;
        self.tipLabel.hidden = YES;
    }
    else
    {
        self.randomBtn.enabled = NO;
        [self.randomBtn setTitle:[NSString stringWithFormat:@"%d", count] forState:UIControlStateDisabled];
        
        __weak id wSelf = self;
        // 延迟一秒执行的内容
        double delayInSeconds = 1.0f;
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
            // code to be executed on the main queue after delay
            [wSelf countDown:count - 1];
        });
    }
}

- (void)onConfirmAction
{
    // 手机号码错误
    if (self.phoneTF.text.length != 11 ||
        ![Utils isNumber:self.phoneTF.text]) {
        
        SIAlertView *alertView = [[SIAlertView alloc] initWithTitle:nil
                                                         andMessage:@"手机号码是11位哦，请检查"];
        [alertView addButtonWithTitle:@"确定"
                                 type:SIAlertViewButtonTypeDefault
                              handler:^(SIAlertView *alertView) {
                                  NSLog(@"确定");
                              }];
        alertView.transitionStyle = SIAlertViewTransitionStyleBounce;
        [alertView show];
        
        [self.phoneTF becomeFirstResponder];
        
        return;
    }
    
    // 验证码错误
    if (self.verifyCodeTF.text.length != 6 ||
        ![Utils isNumber:self.verifyCodeTF.text]) {
        
        SIAlertView *alertView = [[SIAlertView alloc] initWithTitle:nil
                                                         andMessage:@"请输入正确的验证码"];
        [alertView addButtonWithTitle:@"确定"
                                 type:SIAlertViewButtonTypeDefault
                              handler:^(SIAlertView *alertView) {
                                  NSLog(@"确定");
                              }];
        alertView.transitionStyle = SIAlertViewTransitionStyleBounce;
        [alertView show];
        
        [self.verifyCodeTF becomeFirstResponder];
        
        return;
    }
    
    // 新密码错误
    if (self.pwdTF1.text.length != 6) {
        
        SIAlertView *alertView = [[SIAlertView alloc] initWithTitle:nil
                                                         andMessage:@"请输入正确的6位新密码"];
        [alertView addButtonWithTitle:@"确定"
                                 type:SIAlertViewButtonTypeDefault
                              handler:^(SIAlertView *alertView) {
                                  NSLog(@"确定");
                              }];
        alertView.transitionStyle = SIAlertViewTransitionStyleBounce;
        [alertView show];
        
        [self.pwdTF1 becomeFirstResponder];
        
        return;
    }
    
    // 新密码错误
    if (self.pwdTF2.text.length != 6) {
        
        SIAlertView *alertView = [[SIAlertView alloc] initWithTitle:nil
                                                         andMessage:@"请再次输入正确的6位新密码！"];
        [alertView addButtonWithTitle:@"确定"
                                 type:SIAlertViewButtonTypeDefault
                              handler:^(SIAlertView *alertView) {
                                  NSLog(@"确定");
                              }];
        alertView.transitionStyle = SIAlertViewTransitionStyleBounce;
        [alertView show];
        
        [self.pwdTF2 becomeFirstResponder];
        
        return;
    }
    
    if (![self.pwdTF1.text isEqualToString:self.pwdTF2.text]) {
        
        SIAlertView *alertView = [[SIAlertView alloc] initWithTitle:nil
                                                         andMessage:@"新密码和确认密码不一致"];
        [alertView addButtonWithTitle:@"确定"
                                 type:SIAlertViewButtonTypeDefault
                              handler:^(SIAlertView *alertView) {
                                  NSLog(@"确定");
                              }];
        alertView.transitionStyle = SIAlertViewTransitionStyleBounce;
        [alertView show];
        
        [self.pwdTF2 becomeFirstResponder];
        
        return;
    }
    
    [self hideAllKeyboard];
    [SVProgressHUD showWithStatus:@"密码重置中..." maskType:SVProgressHUDMaskTypeGradient];
    
    __weak CTChangePasswordVCtler *wSelf = self;
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
                            self.phoneTF.text, @"PhoneNbr",
                            @"2000004", @"AccountType",
                            self.pwdTF1.text, @"NewPassword",
                            self.verifyCodeTF.text, @"RandomCode",
                            @"01", @"PasswordType", nil];
    
    [MyAppDelegate.cserviceEngine postXMLWithCode:@"resetPswInfo"
                                           params:params
                                      onSucceeded:^(NSDictionary *dict) {
                                          
                                          [SVProgressHUD showSuccessWithStatus:@"密码修改成功，大功告成"];
                                          [wSelf.navigationController popViewControllerAnimated:YES];
                                          
                                      } onError:^(NSError *engineError) {
                                          
                                          [SVProgressHUD dismiss];
                                          
                                          SIAlertView *alertView = [[SIAlertView alloc] initWithTitle:nil
                                                                                           andMessage:engineError.localizedDescription];
                                          [alertView addButtonWithTitle:@"确定"
                                                                   type:SIAlertViewButtonTypeDefault
                                                                handler:^(SIAlertView *alertView) {
                                                                    NSLog(@"取消");
                                                                }];
                                          alertView.transitionStyle = SIAlertViewTransitionStyleBounce;
                                          [alertView show];
                                      }];
}

#pragma mark - UITextFieldDelegate

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    if (!iPhone5)
    {
        if ([textField isEqual:self.pwdTF1])
        {
            [UIView beginAnimations:@"Move Up" context:nil];
            [UIView setAnimationDuration:0.2];
            [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];;
            self.scrollView.frame = CGRectMake(0, -10, self.view.bounds.size.width, self.view.bounds.size.height);
            [UIView commitAnimations];
        }
        else if ([textField isEqual:self.pwdTF2])
        {
            [UIView beginAnimations:@"Move Up" context:nil];
            [UIView setAnimationDuration:0.5];
            [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
            self.scrollView.frame = CGRectMake(0, -72, self.view.bounds.size.width, self.view.bounds.size.height);
            [UIView commitAnimations];;
        }
    }
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    if (!iPhone5)
    {
        if ([textField isEqual:self.pwdTF1])
        {
            [UIView beginAnimations:@"Move Down" context:nil];
            [UIView setAnimationDuration:0.2];
            [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
//            self.view.transform = CGAffineTransformIdentity;
            self.scrollView.frame = CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height);
            [UIView commitAnimations];
        }
        else if ([textField isEqual:self.pwdTF2])
        {
            [UIView beginAnimations:@"Move Down" context:nil];
            [UIView setAnimationDuration:0.5];
            [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
            self.scrollView.frame = CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height);
            [UIView commitAnimations];
        }
    }
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (textField==self.phoneTF && range.location>=11) {
        return NO;
    }
    else if (textField==self.verifyCodeTF && range.location>=6) {
        return NO;
    }
    else if (textField==self.pwdTF1 && range.location>=6) {
        return NO;
    }
    else if (textField==self.pwdTF2 && range.location>=6) {
        return NO;
    }
    else {
        return YES;
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField == self.pwdTF1)
    {
        [self.pwdTF2 becomeFirstResponder];
    }
    else if (textField == self.pwdTF2)
    {
        [self onConfirmAction];
    }
    return YES;
}

#pragma mark - Nav

- (void)onLeftBtnAction:(id)sender
{
    [self hideAllKeyboard];
    if (self.isDismissMVC && [self respondsToSelector:@selector(dismissModalViewControllerAnimated:)])
    {
        [self dismissModalViewControllerAnimated:YES];
    }
    else
    {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

@end
