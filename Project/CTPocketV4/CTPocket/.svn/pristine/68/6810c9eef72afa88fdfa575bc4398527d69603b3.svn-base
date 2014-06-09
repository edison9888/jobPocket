//
//  CTPaySucessVCtler.m
//  CTPocketV4
//
//  Created by quan on 14-5-28.
//  Copyright (c) 2014年 广东亿迅科技有限公司. All rights reserved.
//

#import "CTPaySucessVCtler.h"
#import "UIColor+Category.h"
#import "UIImage+Category.h"
#import "CTMyOrderListVCtler.h"
#import "COQueryVctler.h"

@interface CTPaySucessVCtler ()

@end

@implementation CTPaySucessVCtler

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
    

    CGFloat height = 150;
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(20, 50, CGRectGetWidth(self.view.frame) - 40, height)];
    view.backgroundColor = [UIColor grayColor];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(((CGRectGetWidth(view.frame) - 260)/2.0), 40, 260, 20)];
    label.font     = [UIFont systemFontOfSize:20.0];
    label.backgroundColor = [UIColor clearColor];
    label.text            = @"谢谢！你的订单已支付成功";
    label.textAlignment   = UITextAlignmentCenter;
    [view addSubview:label];
    
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(ceilf((CGRectGetWidth(view.frame) - 260)/2.0), ceilf((CGRectGetHeight(view.frame) - 20) - 36), 260, 36);
    [button setBackgroundImage:[UIImage imageWithColor:[UIColor colorWithR:94 G:189 B:42 A:1] cornerRadius:4] forState:UIControlStateNormal];
//    [button setBackgroundImage:[UIImage imageNamed:@"buyPhoneBtn_disable"] forState:UIControlStateHighlighted];
    [button addTarget:self action:@selector(action:) forControlEvents:UIControlEventTouchUpInside];
    [button setTitle:@"好的,我知道了" forState:UIControlStateNormal];
    [button.titleLabel setFont:[UIFont systemFontOfSize:15]];
    [button setBackgroundImage:[UIImage imageNamed:@"buyPhoneBtn_disable"] forState:UIControlStateDisabled];
    [view addSubview:button];

    
    [self.view addSubview:view];
    
}

- (void)action:(id )sender{
    
    NSDictionary *dict = [NSDictionary dictionaryWithObject:[NSNumber numberWithBool:self.sucessed] forKey:CTPayJump];
    [[NSNotificationCenter defaultCenter] postNotificationName:CTPayJump object:self userInfo:dict];
    
//    if (self.sucessed) {
//        
//        //判断是否登录
//        if ([Global sharedInstance].isLogin == YES) {
//            CTMyOrderListVCtler *vc = [[CTMyOrderListVCtler alloc] init];
//            vc.orderType = @"0";
//            [self.navigationController pushViewController:vc animated:YES];
//        } else {
//            COQueryVctler *vc = [[COQueryVctler alloc] init];
//            [self.navigationController pushViewController:vc
//                                                 animated:YES];
//        }
//    }
//    else
//    {
//        [self.navigationController popViewControllerAnimated:YES];
//    }
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
