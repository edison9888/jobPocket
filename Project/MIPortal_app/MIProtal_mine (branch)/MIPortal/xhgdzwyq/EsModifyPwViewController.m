//
//  EsModifyPwViewController.m
//  xhgdzwyq
//
//  Created by Wen Sijia on 13-12-16.
//  Copyright (c) 2013年 Eshore. All rights reserved.
//

#import "EsModifyPwViewController.h"

@interface EsModifyPwViewController ()

@end

@implementation EsModifyPwViewController

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
    // Do any additional setup after loading the view from its nib.
    [self setBackButton];
}
/*
 *设置返回按钮，左侧显示
 */
- (void)setBackButton
{
    UIImage * img = [UIImage imageNamed:@"button_back"];
    UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 0, img.size.width + 20, img.size.height);
    [btn setImage:img forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(onLeftBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem * baritem = [[UIBarButtonItem alloc] initWithCustomView:btn];
    self.navigationItem.leftBarButtonItem = baritem;
}

- (void)onLeftBtnAction:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    [self setPwOld:nil];
    [self setPwNew:nil];
    [self setPwNewAgain:nil];
    [super viewDidUnload];
}

- (IBAction)onModifyPw:(id)sender
{
    if ([self.pwOld.text isEqualToString:@""]) {
        UIAlertView *alertV = [[UIAlertView alloc] initWithTitle:@"原密码不能为空" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alertV show];
    }
    else if ([self.pwNew.text isEqualToString:@""])
    {
        UIAlertView *alertV = [[UIAlertView alloc] initWithTitle:@"新密码不能为空" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alertV show];
    }
    else if (![self.pwNewAgain.text isEqualToString:self.pwNew.text])
    {
        UIAlertView *alertV = [[UIAlertView alloc] initWithTitle:@"两次密码不一致" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alertV show];
    }
    else {
        NSString* token = @"";
        if ([Global sharedSingleton].userVerify.user.token)
        {
            token = [Global sharedSingleton].userVerify.user.token;
        }
        
        NSString* phone = @"";
        if ([Global sharedSingleton].userVerify.user.phone)
        {
            phone = [Global sharedSingleton].userVerify.user.phone;
        }
        
        NSDictionary* params = @{@"pwOld" : self.pwOld.text,
                                 @"pw" : self.pwNew.text,
                                 @"token" : token,
                                 @"phone" : phone};

        __weak typeof(self) wself = self;
        BaseDataSource* net = [BaseDataSource new];
        [net startGetRequestWithParams:params method:@"modifyPw" completion:^(id responsedict)
         {
             [wself onModifyPwFinish:net response:responsedict];
         }];
    }
}

- (void)onModifyPwFinish:(BaseDataSource* )net response:(NSDictionary* )response
{
    NSString* tipmsg = @"对不起，修改密码失败";
    BOOL iserr = YES;
    do {
        if ([net.errorCode length])
        {
            if ([net.errorMsg length])
            {
                tipmsg = net.errorMsg;
            }
            break;
        }
        
        iserr = NO;
        
    } while (0);
    
    if (iserr)
    {
        ToastAlertView * alert = [ToastAlertView new];
        [alert showAlertMsg:tipmsg];
    }
    else
    {
        ToastAlertView * alert = [ToastAlertView new];
        [alert showAlertMsg:@"修改密码成功"];
        [self onLeftBtnAction:nil];
    }
}

@end
