//
//  CTUserFeedbackVCtler.m
//  CTPocketV4
//
//  Created by 许忠洲 on 13-11-21.
//  Copyright (c) 2013年 广东亿迅科技有限公司. All rights reserved.
//  用户反馈

#import "CTUserFeedbackVCtler.h"
#import "SVProgressHUD.h"
#import "Utils.h"
#import "AppDelegate.h"
#import "SIAlertView.h"
#import "CTFeedbackVCtler.h"

@interface CTUserFeedbackVCtler () <UITextViewDelegate>
{
    UIView *_tipView;
    UITextView* _fbTextView;
}

@end

@implementation CTUserFeedbackVCtler

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
        // 标题
        self.title = @"用户吐槽";
        // 左按钮
        [self setLeftButton:[UIImage imageNamed:@"btn_back"]];
        // 右按钮
        [self setRightButton:[UIImage imageNamed:@"icon_list"]];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    UIButton *hkBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    hkBtn.frame = self.view.bounds;
    hkBtn.autoresizingMask = UIViewAutoresizingFlexibleHeight;
    [hkBtn addTarget:self
              action:@selector(onHideKeyboardAction)
    forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:hkBtn];
    
    UIImageView *fbImageView = [[UIImageView alloc] initWithFrame:CGRectMake(30, 32, 260, 155)];
    fbImageView.image = [UIImage imageNamed:@"userFeedbackBg"];
    [self.view addSubview:fbImageView];
    
    _tipView = [[UIView alloc] initWithFrame:CGRectMake(42, 37, 260-15, 20)];
    _tipView.backgroundColor = [UIColor clearColor];
    {
        UIImageView *tipImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
        tipImage.image = [UIImage imageNamed:@"feedback_editor"];
        [_tipView addSubview:tipImage];
        
        UILabel *tipLabel = [[UILabel alloc] initWithFrame:CGRectMake(24, 0, 200, 20)];
        tipLabel.backgroundColor = [UIColor clearColor];
        tipLabel.font = [UIFont systemFontOfSize:13.0f];
        tipLabel.textColor = [UIColor lightGrayColor];
        tipLabel.text = @"如有不爽，请尽情吐槽......";
        [_tipView addSubview:tipLabel];
    }
    [self.view addSubview:_tipView];
    
    _fbTextView = [[UITextView alloc] initWithFrame:CGRectMake(32, 39, 270-15, 122)];
    _fbTextView.backgroundColor = [UIColor clearColor];
    _fbTextView.delegate = self;
    [self.view addSubview:_fbTextView];
    
    //
    UIButton *fbBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    fbBtn.frame = CGRectMake(32, 198, 256, 42);
    [fbBtn setBackgroundImage:[UIImage imageNamed:@"feedback_btn2"] forState:UIControlStateNormal];
    [fbBtn setBackgroundImage:[UIImage imageNamed:@"feedback_btn2_hl"] forState:UIControlStateHighlighted];
    [fbBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, 20, 0, 0)];
    [fbBtn setTitle:@"吐槽" forState:UIControlStateNormal];
    [fbBtn addTarget:self action:@selector(onFeebackAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:fbBtn];
}

#pragma mark - Nav

- (void)onRightBtnAction:(id)sender
{
    CTFeedbackVCtler *vc = [[CTFeedbackVCtler alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - self func

- (void)onHideKeyboardAction
{
    [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
}

- (void)onFeebackAction
{
    if (_fbTextView.text.length <= 0) {
        
        SIAlertView *alertView = [[SIAlertView alloc] initWithTitle:nil
                                                         andMessage:@"请输入吐槽内容！"];
        [alertView addButtonWithTitle:@"确定"
                                 type:SIAlertViewButtonTypeDefault
                              handler:^(SIAlertView *alertView) {
                                  NSLog(@"取消");
                              }];
        alertView.transitionStyle = SIAlertViewTransitionStyleBounce;
        [alertView show];
        
        return;
    }
    
    if (_fbTextView.text.length > 0 &&
        [[_fbTextView.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] length] == 0) {
        
        _fbTextView.text = @"";
        
        SIAlertView *alertView = [[SIAlertView alloc] initWithTitle:nil
                                                         andMessage:@"请输入正确的吐槽内容！"];
        [alertView addButtonWithTitle:@"确定"
                                 type:SIAlertViewButtonTypeDefault
                              handler:^(SIAlertView *alertView) {
                                  NSLog(@"取消");
                              }];
        alertView.transitionStyle = SIAlertViewTransitionStyleBounce;
        [alertView show];
        
        return;
    }
    
    [_fbTextView resignFirstResponder];
    
    // 应用编号为12
    NSString* str_application_id = @"12";
    
    // 应用版本
    NSString* str_app_version = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    
    NSDictionary* loginInfoDict = [Global sharedInstance].loginInfoDict;
    
    // IMEI编码:根据IMEI码识别用户(IPHONE获取不到IMEI)
    NSString* str_client_imei = loginInfoDict[@"UserLoginName"] ? loginInfoDict[@"UserLoginName"] : @"";
    
    // MDN编码:手机mdn码说明：IPhone版本必填，mdn码就是手机号码
    NSString* str_client_mdn = loginInfoDict[@"UserLoginName"] ? loginInfoDict[@"UserLoginName"] : @"";
    
    // 反馈信息:用户反馈信息（200汉字以下）
    NSString *fbText = _fbTextView.text ;  NSString* str_user_reply_message = @"";
    fbText = [fbText stringByReplacingOccurrencesOfString:@" " withString:@""];
    if ([fbText isEqualToString:@""]) {
        SIAlertView *alertView = [[SIAlertView alloc] initWithTitle:nil
                                                         andMessage:@"亲,输入不能为空哟"];
        [alertView addButtonWithTitle:@"确定"
                                 type:SIAlertViewButtonTypeDefault
                              handler:^(SIAlertView *alertView) {
                                  NSLog(@"取消");
                                  return ;
                              }];
        alertView.transitionStyle = SIAlertViewTransitionStyleBounce;
        [alertView show];
    } else{
         str_user_reply_message = _fbTextView.text;
    
  
    [SVProgressHUD showWithStatus:@"吐槽中..." maskType:SVProgressHUDMaskTypeGradient];
    // 上报周期:用户反馈日期时间戳
    NSString* str_reply_date = [[NSString alloc]initWithFormat:@"%lld", (long long)[[NSDate date] timeIntervalSince1970]];
    
    // 通用参数:备选参数
    NSString* str_remark = @"0";
    
    // MD5加密:效验合法性 规则：time+key做md5加密
    NSString* key = @"0c07b128fca8195eb6513ba7162bed86";
    NSString* str = [NSString stringWithFormat:@"%@%@", str_reply_date,key];
    NSString* str_sig = [[Utils MD5:str] lowercaseString];
    
    // 当前的时间戳:效验参数
    NSString* str_time = [[NSString alloc]initWithFormat:@"%lld", (long long)[[NSDate date] timeIntervalSince1970]];
    
    // 主题id，0为新话题,非0标示为content_id所示主题讨论内容
    NSString* str_content_id = @"0";
    
    // 终端信息:终端型号+操作系统版本信息+UA（用“|”分隔）
    NSString* str_client_info = [NSString stringWithFormat:@"%@|%@|UA", [UIDevice currentDevice].model, [UIDevice currentDevice].systemVersion];
    
    // 终端类型
    NSString* str_client_type = @"mobile_app";
    
    NSDictionary * params = [NSDictionary dictionaryWithObjectsAndKeys:
                             str_application_id, @"application_id",
                             str_app_version, @"app_version",
                             str_client_imei, @"client_imei",
                             str_client_mdn, @"client_mdn",
                             str_user_reply_message, @"user_reply_message",
                             str_reply_date, @"reply_date",
                             str_remark, @"remark",
                             str_sig, @"sig",
                             str_time, @"time",
                             str_content_id, @"content_id",
                             str_client_info, @"client_info",
                             str_client_type,@"client_type",
                             nil];
        
    [MyAppDelegate.feedbackEngine postJSONWithMethod:@"userReq"
                                              params:params
                                         onSucceeded:^(NSDictionary *dict) {
                                             
                                             [SVProgressHUD showSuccessWithStatus:@"吐槽成功！"];
                                             [[NSNotificationCenter defaultCenter] postNotificationName:@"刷新用户反馈列表" object:nil];
                                             [self.navigationController popViewControllerAnimated:YES];
                                             
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
}

#pragma mark - UITextViewDelegate

- (void)textViewDidChange:(UITextView *)textView
{
    if (textView.text.length > 0)
    {
        _tipView.hidden = YES;
    }
    else
    {
        _tipView.hidden = NO;
    }
}

@end
