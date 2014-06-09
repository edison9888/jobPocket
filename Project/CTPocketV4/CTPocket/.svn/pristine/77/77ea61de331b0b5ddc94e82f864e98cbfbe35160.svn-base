//
//  CTPointCardCode.m
//  CTPocketV4
//
//  Created by apple on 14-5-5.
//  Copyright (c) 2014年 广东亿迅科技有限公司. All rights reserved.
//

#import "CTPointCardCode.h"
#import "UIColor+Category.h"
#import "SVProgressHUD.h"
#import "IgUserInfo.h"
#import "SIAlertView.h"

@interface CTPointCardCode ()
{
    UILabel *_cardNameLabel;
    UILabel *_cardNum;
    UILabel *_cardPwd;
    UILabel *_cardDate;
}
@end

@implementation CTPointCardCode

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
        // 标题
        self.title = @"积分兑换记录";  // 查询卡密
        // 左按钮
        [self setLeftButton:[UIImage imageNamed:@"btn_back"]];
    }
    return self;
}

- (void)setLayoutView
{
    int xOffset = 35;
    int yOffset = 25;
    
    // 兑换礼品
    UILabel *nameLabel =  [[UILabel alloc] initWithFrame:CGRectMake(xOffset, yOffset, 107, 14)];
    nameLabel.backgroundColor = [UIColor clearColor];
    nameLabel.font = [UIFont systemFontOfSize:14.0f];
    nameLabel.textColor = [UIColor colorWithR:49 G:49 B:49 A:1];
    nameLabel.text = [NSString stringWithFormat:@"兑换礼品：         "];
    [self.view addSubview:nameLabel];
    _cardNameLabel = [[UILabel alloc] init];
    _cardNameLabel.backgroundColor = [UIColor clearColor];
    _cardNameLabel.font = [UIFont systemFontOfSize:14.0f];
    _cardNameLabel.textColor = [UIColor colorWithR:49 G:49 B:49 A:1];
    _cardNameLabel.text = self.commodityName?self.commodityName:@"";
    _cardNameLabel.textAlignment = UITextAlignmentLeft;
    _cardNameLabel.numberOfLines = 0;
    _cardNameLabel.lineBreakMode = UILineBreakModeWordWrap;
    _cardNameLabel.frame = CGRectMake(xOffset+107, yOffset, 170, CGRectGetHeight(_cardNameLabel.frame));
    [_cardNameLabel sizeToFit];
    [self.view addSubview:_cardNameLabel];
    
    yOffset = CGRectGetMaxY(_cardNameLabel.frame) + 14;
    // 卡号
    _cardNum =  [[UILabel alloc] initWithFrame:CGRectMake(xOffset, yOffset, 280, 14)];
    _cardNum.backgroundColor = [UIColor clearColor];
    _cardNum.font = [UIFont systemFontOfSize:14.0f];
    _cardNum.textColor = [UIColor colorWithR:49 G:49 B:49 A:1];
    _cardNum.text = [NSString stringWithFormat:@"卡       号：         %@", self.cardNo?self.cardNo:@""];
    [self.view addSubview:_cardNum];
    
    yOffset = CGRectGetMaxY(_cardNum.frame) + 14;
    // 密码
    _cardPwd =  [[UILabel alloc] initWithFrame:CGRectMake(xOffset, yOffset, 280, 14)];
    _cardPwd.backgroundColor = [UIColor clearColor];
    _cardPwd.font = [UIFont systemFontOfSize:14.0f];
    _cardPwd.textColor = [UIColor colorWithR:49 G:49 B:49 A:1];
    _cardPwd.text = [NSString stringWithFormat:@"密       码：         %@", self.passWd?self.passWd:@""];
    [self.view addSubview:_cardPwd];
    
    
    yOffset = CGRectGetMaxY(_cardPwd.frame) + 14;
    // 有效期
    _cardDate =  [[UILabel alloc] initWithFrame:CGRectMake(xOffset, yOffset, 280, 14)];
    _cardDate.backgroundColor = [UIColor clearColor];
    _cardDate.font = [UIFont systemFontOfSize:14.0f];
    _cardDate.textColor = [UIColor colorWithR:49 G:49 B:49 A:1];
    _cardDate.text = [NSString stringWithFormat:@"有  效  期：         %@", self.expressDate?self.expressDate:@""];
    [self.view addSubview:_cardDate];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self loadData];
}

- (void)loadData
{
    NSDictionary *loginInfoDict = [Global sharedInstance].loginInfoDict;
    NSString *DeviceNo = loginInfoDict[@"UserLoginName"];
    
    [SVProgressHUD showWithStatus:@"加载中..." maskType:SVProgressHUDMaskTypeGradient];
    
    [[IgUserInfo shareIgUserInfo] igUserInfoWithDeviceNo:DeviceNo finishBlock:^(NSDictionary *resultParams, NSError *error) {
        
        if (error) {
            [SVProgressHUD dismiss];
            return;
        }
        
        NSDictionary *data = resultParams[@"Data"];
        NSString *CustId = [data objectForKey:@"CustId"];
        NSDictionary *params;
        if (CustId) {
            
            params = @{@"CustId": CustId,
                       @"OrderId":self.orderId};
            
            [MyAppDelegate.cserviceEngine
             postXMLWithCode:@"igGetOrderPwd"
             params:params
             onSucceeded:^(NSDictionary *dict) {
                 NSLog(@"%@", dict);
                 [SVProgressHUD dismiss];
                 NSDictionary *dic = [dict objectForKey:@"Data"];
                 self.cardNo = [dic objectForKey:@"CardNo"];
                 self.passWd = [dic objectForKey:@"PassWd"];
                 self.expressDate = [dic objectForKey:@"Expressdate"];
                 
                 NSRange range = [_expressDate rangeOfString:@" "];
                 if (range.location != NSNotFound) {
                     _expressDate = [_expressDate substringToIndex:range.location];
                     _expressDate = [_expressDate stringByReplacingOccurrencesOfString:@"/" withString:@"-"];
                 }
                 [self setLayoutView];
             }
             onError:^(NSError *engineError) {
                 
                 [SVProgressHUD dismiss];
                 SIAlertView *alertView = [[SIAlertView alloc] initWithTitle:nil
                                                                  andMessage:engineError.userInfo[@"NSLocalizedDescription"]];
                 
                 [alertView addButtonWithTitle:@"确定"
                                          type:SIAlertViewButtonTypeDefault
                                       handler:^(SIAlertView *alertView){
                                       }];
                 alertView.transitionStyle = SIAlertViewTransitionStyleBounce;
                 [alertView show];
             }];
        }
    }];
    
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
