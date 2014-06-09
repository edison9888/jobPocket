//
//  EsSettingVCtler.m
//  xhgdzwyq
//
//  Created by apple on 13-11-27.
//  Copyright (c) 2013年 Eshore. All rights reserved.
//

#import "EsSettingVCtler.h"
#import "FlatButton.h"
#import <QuartzCore/QuartzCore.h>
#import "EsAnnouceVCtler.h"
#import "EsNoticeSettingVCtler.h"

#define kAlertViewTagLogout 1
#define kAlertViewTagUpdate 2

@interface EsSettingVCtler ()
{
    UITableView*    _contentTable;
    FlatButton*     _checkVersionBtn;
}

@end

@implementation EsSettingVCtler

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
    [self setBackButton];
    self.title = @"设置";
    
    int originX = 15;
    int originY = 40;
    NSArray* btnTexts = @[@"重要新闻提醒设置", @"版本检测", @"免责声明"];
    NSArray* actions = @[NSStringFromSelector(@selector(onNoticeSettingBtn:)),
                         NSStringFromSelector(@selector(onCheckVersionBtn:)),
                         NSStringFromSelector(@selector(onAnnouceBtn:))];
    
    for (NSString* title in btnTexts)
    {
        FlatButton* btn = [self addButton2View:CGRectMake(originX, originY, CGRectGetWidth(self.view.frame) - 2*originX, 36)
                                         title:title
                                        action:NSSelectorFromString(actions[[btnTexts indexOfObject:title]])];
        originY         = CGRectGetMaxY(btn.frame);
        if ([btnTexts indexOfObject:title] == btnTexts.count - 1)
        {
            originY     += 40;
        }
        else
        {
            originY     += 15;
        }
        
        if ([btnTexts indexOfObject:title] == 1)
        {
            _checkVersionBtn = btn;
        }
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
        [btn setTitle:@"注销登录" forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [btn.titleLabel setFont:[UIFont systemFontOfSize:15]];
        [btn addTarget:self action:@selector(onLogoutBtn) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:btn];
    }
    
    if ([[Global sharedSingleton] checkHasNewVersion])
    {
        UIImageView* iv = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_new"]];
        iv.frame = CGRectMake(CGRectGetMaxX(_checkVersionBtn.titleLabel.frame) + 10,
                              (CGRectGetHeight(_checkVersionBtn.frame) - iv.frame.size.height)/2,
                              iv.frame.size.width,
                              iv.frame.size.height);
        [_checkVersionBtn addSubview:iv];
    }
    else
    {
        UILabel* lab = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_checkVersionBtn.titleLabel.frame) + 10,
                                                                 0,
                                                                 CGRectGetWidth(_checkVersionBtn.frame),
                                                                 CGRectGetHeight(_checkVersionBtn.frame))];
        lab.backgroundColor = [UIColor clearColor];
        lab.font = [UIFont systemFontOfSize:15];
        lab.textColor = ([Global sharedSingleton].uiStyle.mode == UIStyleModeDay ? RGB(0x33, 0x33, 0x33, 1) : RGB(0x99, 0x99, 0x99, 1));
        lab.textAlignment = UITextAlignmentLeft;
        lab.text = [NSString stringWithFormat:@"V%@", APP_VERSION];
        [_checkVersionBtn addSubview:lab];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark private
- (FlatButton *)addButton2View:(CGRect)frame
                         title:(NSString* )title
                        action:(SEL)action
{
    FlatButton* btn = [FlatButton buttonWithType:UIButtonTypeCustom];
    btn.frame       = frame;
    [btn setBackgroundColor:([Global sharedSingleton].uiStyle.mode == UIStyleModeDay ? RGB(0xd6, 0xd6, 0xd6, 1) : RGB(102, 102, 102, 1))];
    [btn setTitle:(title ? title : @"") forState:UIControlStateNormal];
    [btn setTitleColor:([Global sharedSingleton].uiStyle.mode == UIStyleModeDay ? RGB(0x33, 0x33, 0x33, 1) : RGB(0x99, 0x99, 0x99, 1)) forState:UIControlStateNormal];
    [btn.titleLabel setFont:[UIFont systemFontOfSize:15]];
    [btn setTitleEdgeInsets:UIEdgeInsetsMake(0, 8, 0, 0)];
    [btn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
    btn.layer.cornerRadius = 5;
    [btn flatStyle];
    [btn addTarget:self action:action forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    {
        UIImageView* iv = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"grayarrow"]];
        iv.frame        = CGRectMake(CGRectGetWidth(frame) - 20 - CGRectGetWidth(iv.frame),
                                     (CGRectGetHeight(frame) - CGRectGetHeight(iv.frame))/2,
                                     CGRectGetWidth(iv.frame),
                                     CGRectGetHeight(iv.frame));
        [btn addSubview:iv];
    }
    
    return btn;
}

#pragma mark button
- (void)onLogoutBtn
{
    UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"要注销登录吗?"
                                                    message:@"注销登录后\n下次使用需要重新输入密码"
                                                   delegate:(id<UIAlertViewDelegate>)self
                                          cancelButtonTitle:@"否"
                                          otherButtonTitles:@"是", nil];
    alert.tag = kAlertViewTagLogout;
    [alert show];
}

- (void)onNoticeSettingBtn:(UIButton* )sender
{
    EsNoticeSettingVCtler* vctler = [EsNoticeSettingVCtler new];
    [self.navigationController pushViewController:vctler animated:YES];
}

- (void)onCheckVersionBtn:(UIButton* )sender
{
    if ([[Global sharedSingleton] checkHasNewVersion])
    {
        UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"新版本"
                                                        message:@"是否要更新到最新版~"
                                                       delegate:(id<UIAlertViewDelegate>)self
                                              cancelButtonTitle:@"稍后"
                                              otherButtonTitles:@"立即更新", nil];
        alert.tag = kAlertViewTagUpdate;
        [alert show];
    }
    else
    {
        ToastAlertView * alert = [ToastAlertView new];
        [alert showAlertMsg:@"已是最新版本~"];
    }
}

- (void)onAnnouceBtn:(UIButton* )sender
{
    EsAnnouceVCtler* vctler = [EsAnnouceVCtler new];
    [self.navigationController pushViewController:vctler animated:YES];
}

#pragma mark UIAlertView
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag == kAlertViewTagLogout)
    {
        if (buttonIndex == 1)
        {
            [[NSNotificationCenter defaultCenter] postNotificationName:kMsgAutoLogout object:nil];
        }
    }
    else if (alertView.tag == kAlertViewTagUpdate)
    {
        if (buttonIndex == 1)
        {
            NSURL *url = [NSURL URLWithString:[Global sharedSingleton].updateUrl];
            [[UIApplication sharedApplication] openURL:url];
        }
    }
}

@end
