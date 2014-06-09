//
//  CTQryBalanceVCtler.m
//  CTPocketV4
//
//  Created by Mac-Eshore-01 on 13-11-5.
//  Copyright (c) 2013年 广东亿迅科技有限公司. All rights reserved.
//  当月话费

#import "CTQryBalanceVCtler.h"
#import "UIView+RoundRect.h"
#import "CserviceEngine.h"
#import "AppDelegate.h"
#import "Utils.h"
#import "Global.h"
#import "CTCycleTableView.h"
#import "CTPayHistoryVCtler.h"
#import "CTRechargeVCtler.h"
#import "SVProgressHUD.h"
#import "ToastAlertView.h"
#import "SIAlertView.h"

#define kTagLabCanuse       10901
#define kTagLabBillInfo     10902
#define kTagLabAcctBillInfo 10903
#define kTagCycTableView    10904

#define kTagTipLabel        10905

@interface CTQryBalanceVCtler ()
@property (strong, nonatomic)CserviceOperation *_QryOperation01;
@property (strong, nonatomic)CserviceOperation *_QryOperation02;
@property (strong, nonatomic)CserviceOperation *_QryOperation03;

-(void)setCycleTable;
-(void)setTipLabel;
-(void)onHistoryBution:(id)sender;
-(void)onRechargeBution:(id)sender;
-(void)onQryTypeSwithBution:(id)sender;
@end

@implementation CTQryBalanceVCtler

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
    self.title = @"话费查询";
    // 左按钮
    [self setLeftButton:[UIImage imageNamed:@"btn_back"]];
    _canUse = _hadUse = _hadOwn = -1;
    _queryType = 1;
    
    NSDictionary* logindict= [Global sharedInstance].loginInfoDict;
    NSString *PhoneNum = logindict[@"UserLoginName"] ? logindict[@"UserLoginName"] : @"";
	// Do any additional setup after loading the view.
    {
        UILabel* mtitle = [[UILabel alloc] initWithFrame:CGRectMake(10,20,220,22)];
        mtitle.backgroundColor = [UIColor clearColor];
        mtitle.font     = [UIFont systemFontOfSize:13];
        mtitle.textColor= [UIColor blackColor];
        mtitle.text     = [NSString stringWithFormat:@"查询号码：%@",PhoneNum];
        [self.view addSubview:mtitle];
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(236,13,73,33);
        [button dwMakeRoundCornerWithRadius:3];
        [button setBackgroundImage:[UIImage imageNamed:@"qry_btn_bg.png"]
                forState:UIControlStateNormal];
        [button.titleLabel setFont:[UIFont systemFontOfSize:13]];
        [button setTitleColor:[UIColor colorWithRed:61/255.0
                                              green:61/255.0
                                               blue:61/255.0
                                              alpha:1]
                     forState:UIControlStateNormal];
        [button setTitle:@"账户总话费" forState:UIControlStateNormal];
        [button addTarget:self action:@selector(onQryTypeSwithBution:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:button];
    }
    
    {
        UILabel* mtitle = [[UILabel alloc] initWithFrame:CGRectMake(10,61,220,22)];
        mtitle.backgroundColor = [UIColor clearColor];
        mtitle.font     = [UIFont systemFontOfSize:13];
        mtitle.textColor= [UIColor blackColor];
        
        NSDateFormatter *df1 = [[NSDateFormatter alloc] init];
        NSDateFormatter *df2 = [[NSDateFormatter alloc] init];
        [df1 setDateFormat:@"MM月dd日"];
        [df2 setDateFormat:@"yyyy年MM月1日"];
        
        mtitle.text     = [NSString stringWithFormat:@"计费日期：%@-%@", [df2 stringFromDate:[NSDate date]], [df1 stringFromDate:[NSDate date]]];
        [self.view addSubview:mtitle];
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(236,54,73,33);
        [button dwMakeRoundCornerWithRadius:3];
        [button setBackgroundImage:[UIImage imageNamed:@"qry_btn_bg.png"]
                          forState:UIControlStateNormal];

        [button setTitleColor:[UIColor colorWithRed:61/255.0
                                              green:61/255.0
                                               blue:61/255.0
                                              alpha:1]
                     forState:UIControlStateNormal];
        [button.titleLabel setFont:[UIFont systemFontOfSize:13]];
        [button setTitle:@"历史话费" forState:UIControlStateNormal];
        [button addTarget:self
                   action:@selector(onHistoryBution:)
         forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:button];
    }
    
    {
        // div line
        UIImageView* divLine = [[UIImageView alloc] initWithFrame:CGRectMake(10, 96, 300, 1)];
        divLine.image = [UIImage imageNamed:@"recharge_horline_bg.png"];
        [self.view addSubview:divLine];
    }
    
    {
        UILabel* cfee   = [[UILabel alloc] initWithFrame:CGRectMake(25,134,220,22)];
        cfee.tag        = kTagLabBillInfo;
        cfee.backgroundColor = [UIColor clearColor];
        cfee.font       = [UIFont systemFontOfSize:14];
        cfee.textColor  = [UIColor blackColor];
        cfee.text       = @"本月已付话费:加载中...";//@"当前话费:56.12元";
        [self.view addSubview:cfee];

        UILabel* ufee   = [[UILabel alloc] initWithFrame:CGRectMake(25,156,220,22)];
        ufee.tag        = kTagLabCanuse;
        ufee.backgroundColor = [UIColor clearColor];
        ufee.font       = [UIFont systemFontOfSize:14];
        ufee.textColor  = [UIColor blackColor];
        ufee.text       = @"话费余额:加载中...";//@"可用余额:90元";
        [self.view addSubview:ufee];

        UILabel* ofee   = [[UILabel alloc] initWithFrame:CGRectMake(25,178,220,22)];
        ofee.tag        = kTagLabAcctBillInfo;
        ofee.backgroundColor = [UIColor clearColor];
        ofee.font       = [UIFont systemFontOfSize:14];
        ofee.textColor  = [UIColor blackColor];
        ofee.text       = @"欠费金额:加载中...";//@"欠费金额:0元";
        [self.view addSubview:ofee];
        
        // 半圆表
        CTCycleTableView* ctable = [[CTCycleTableView alloc] initWithFrame:CGRectMake(180,118,105,105)];
        ctable.tag     = kTagCycTableView;
//        [self.view addSubview:ctable];
        
        UILabel* tip   = [[UILabel alloc] initWithFrame:CGRectMake(10,240,300,22)];
        tip .tag       = kTagTipLabel;
        tip.backgroundColor = [UIColor clearColor];
        tip.font       = [UIFont systemFontOfSize:12];
        tip.textColor  = [UIColor redColor];
        tip.textAlignment = UITextAlignmentCenter;
        tip.hidden     = YES;
        tip.text       = @"此号码余额不足，建议及时充值，避免停机。";
        [self.view addSubview:tip];
    }
    
    {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(20,266,280,36);
        [button setBackgroundImage:[[UIImage imageNamed:@"common_alert_button.png"] stretchableImageWithLeftCapWidth:12 topCapHeight:12]
                          forState:UIControlStateNormal];
        {
            UIImageView* cenicon = [[UIImageView alloc] initWithFrame:CGRectMake(104,9,26,18)];
            cenicon.image = [UIImage imageNamed:@"qry_icon_money.png"];
            cenicon.userInteractionEnabled = NO;
            [button addSubview:cenicon];
        }
        [button dwMakeRoundCornerWithRadius:3];
        [button setTitleEdgeInsets:UIEdgeInsetsMake(0, 28, 0, 0)];
        [button setTitle:@"充值" forState:UIControlStateNormal];
        [button addTarget:self
                   action:@selector(onRechargeBution:)
         forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:button];
    }
    
    {
        UILabel *tipLab = [[UILabel alloc] initWithFrame:CGRectMake(20, 10+266+36,290 , 30)];
        tipLab.font = [UIFont systemFontOfSize:12];
        tipLab.textColor = [UIColor colorWithRed:(9*16+6)/255. green:(9*16+5)/255. blue:(9*16+5)/255. alpha:1];
        tipLab.backgroundColor = [UIColor clearColor];
        tipLab.text = @"注：每月1-5日部分查询数据有所偏差，以致电10000号或当地营业厅的查询结果为准。";
        tipLab.numberOfLines = 0;
        [tipLab sizeToFit];
        [self.view addSubview:tipLab];
    }
    
    [self queryCanuse];
    [self queryBillInfo];
    [self queryAcctBillInfo];
}

-(void)onHistoryBution:(id)sender{
    CTPayHistoryVCtler* pVctl = [[CTPayHistoryVCtler alloc] init];
    [self.navigationController pushViewController:pVctl
                                         animated:YES];
}

-(void)onRechargeBution:(id)sender
{
    UINavigationController *nar =  MyAppDelegate.tabBarController.viewControllers[2] ;
    CTRechargeVCtler *vc =  (CTRechargeVCtler *)nar.viewControllers[0] ;
    [vc pageIndex:0];
    MyAppDelegate.tabBarController.selectedIndex = 2;
}

-(void)onQryTypeSwithBution:(id)sender
{
    UIButton* btn = (UIButton*)sender;
    if (_queryType == 1) {
        _queryType = 2;
        [btn setTitle:@"用户总话费" forState:UIControlStateNormal];
    }else{
        _queryType = 1;
        [btn setTitle:@"帐户总话费" forState:UIControlStateNormal];
    }
    
    {
        UILabel* labBillinfo = (UILabel*)[self.view viewWithTag:kTagLabBillInfo];
        UILabel* labAccBill  = (UILabel*)[self.view viewWithTag:kTagLabCanuse];
        
        labAccBill.text = @"话费余额：加载中...";
        labBillinfo.text= @"本月已付话费：加载中...";
        CTCycleTableView* ctable = (CTCycleTableView*)[self.view viewWithTag:kTagCycTableView];
        int  intper  = 0;
        NSString* strper= [NSString stringWithFormat:@"话费已用\r%d%@",intper,@"%"];
        [ctable setPersentVal:strper persent:0.0];
        [ctable setNeedsDisplay];
    }
    _canUse = _hadUse = -1;
    [self queryCanuse];
    [self queryBillInfo];
}

-(void)setCycleTable{
    CTCycleTableView* ctable = (CTCycleTableView*)[self.view viewWithTag:kTagCycTableView];
    if (!ctable) {
        return;
    }
    
    if (_canUse == -1 || _hadUse == -1) {
        return;
    }
    
    CGFloat fper = _hadUse / (_canUse + _hadUse);
    int  intper  = (int)(fper* 100);
    NSString* strper= [NSString stringWithFormat:@"话费已用\r%d%@",intper,@"%"];
    [ctable setPersentVal:strper persent:fper];

    [ctable setNeedsDisplay];
}

-(void)setTipLabel{
    UILabel * tip =  (UILabel*)[self.view viewWithTag:kTagTipLabel];
    if (_hadUse >= 0 && _hadOwn >= 0 && _canUse >= 0)
    {
        // 余额<话费+欠费情况则显示，否则隐藏
        if (_canUse < (_hadOwn + _hadUse))
        {
            tip.hidden = NO;
        }else{
            tip.hidden = YES;
        }
    }
}

- (void) showToastView : (NSString *) message
{
    ToastAlertView *alert = [ToastAlertView new];
    [alert showAlertMsg:message];
}

#pragma mark - netWork
// 可用余额
- (void)queryCanuse
{
    NSDictionary* logindict= [Global sharedInstance].loginInfoDict;
    NSString *PhoneNum = logindict[@"UserLoginName"] ? logindict[@"UserLoginName"] : @"";
    NSDictionary *params   = [NSDictionary dictionaryWithObjectsAndKeys:
                            PhoneNum,@"PhoneNum",
                            nil];
    if (_queryType == 1)
    {
        self._QryOperation01   = [MyAppDelegate.cserviceEngine postXMLWithCode:@"queryCanuse"
                                                                        params:params
                                                                   onSucceeded:^(NSDictionary *dict) {
                                                                       id  TotalBalance = [[dict objectForKey:@"Data"] objectForKey:@"TotalBalance"];
                                                                       UILabel* labAccBill = (UILabel*)[self.view viewWithTag:kTagLabCanuse];
                                                                       if(labAccBill){
                                                                           labAccBill.text = [NSString stringWithFormat:@"话费余额：%@元",TotalBalance];
                                                                       }
                                                                       _canUse = [TotalBalance floatValue];
//                                                                       [self setCycleTable];
                                                                       [self setTipLabel];
                                                                       //[SVProgressHUD dismiss];
                                                                   } onError:^(NSError *engineError) {
                                                                       DDLogInfo(@"%s--%@", __func__, engineError);
                                                                       
                                                                       //[SVProgressHUD dismiss];
                                                                       
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
                                                                           UILabel* labAccBill = (UILabel*)[self.view viewWithTag:kTagLabCanuse];
                                                                           if(labAccBill){
                                                                               labAccBill.text = @"话费余额：加载失败";
                                                                           }
                                                                           [self showToastView:@"网络繁忙,请稍后再试"];
                                                                       }
                                                                       
                                                                   }];
    }else
    {
        self._QryOperation01   = [MyAppDelegate.cserviceEngine postXMLWithCode:@"queryAll"
                                                                        params:params
                                                                   onSucceeded:^(NSDictionary *dict) {
                                                                       id  TotalBalance = [[dict objectForKey:@"Data"] objectForKey:@"TotalBalance"];
                                                                       UILabel* labAccBill = (UILabel*)[self.view viewWithTag:kTagLabCanuse];
                                                                       if(labAccBill){
                                                                           labAccBill.text = [NSString stringWithFormat:@"话费余额：%@元",TotalBalance];
                                                                       }
                                                                       _canUse = [TotalBalance floatValue];
                                                                       [self setCycleTable];
                                                                       [self setTipLabel];
                                                                       //[SVProgressHUD dismiss];
                                                                   } onError:^(NSError *engineError) {
                                                                       DDLogInfo(@"%s--%@", __func__, engineError);
                                                                       
                                                                       //[SVProgressHUD dismiss];
                                                                       
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
                                                                           UILabel* labAccBill = (UILabel*)[self.view viewWithTag:kTagLabCanuse];
                                                                           if(labAccBill){
                                                                               labAccBill.text = @"话费余额：加载失败";
                                                                           }
                                                                           
                                                                           [self showToastView:@"网络繁忙,请稍后再试"];
                                                                       }
                                                                   }];
    }
}


// 当前费用
- (void)queryBillInfo
{
    NSDictionary* logindict= [Global sharedInstance].loginInfoDict;
    NSString *PhoneNum = logindict[@"UserLoginName"] ? logindict[@"UserLoginName"] : @"";
    NSString * Month        = @"";
    NSDateFormatter * df    = [NSDateFormatter new];
    [df setDateFormat:@"yyyyMM"];
    Month                   = [df stringFromDate:[NSDate date]];
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
                            PhoneNum,@"PhoneNum",
                            Month,@"Month",
                            nil];
    if (_queryType == 1)
    {
        self._QryOperation03 = [MyAppDelegate.cserviceEngine postXMLWithCode:@"queryBillInfoUser"
                                                                      params:params
                                                                 onSucceeded:^(NSDictionary *dict) {
                                                                     id SumCharge = [[dict objectForKey:@"Data"] objectForKey:@"SumCharge"];
                                                                     UILabel* labBillinfo = (UILabel*)[self.view viewWithTag:kTagLabBillInfo];
                                                                     if(labBillinfo){
                                                                         labBillinfo.text = [NSString stringWithFormat:@"本月已付话费：%@元",SumCharge];
                                                                     }
                                                                     _hadUse = [SumCharge floatValue];
                                                                     [self setCycleTable];
                                                                     [self setTipLabel];
                                                                     //[SVProgressHUD dismiss];
                                                                 } onError:^(NSError *engineError) {
                                                                     
                                                                     //[SVProgressHUD dismiss];
                                                                     
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
                                                                         UILabel* labBillinfo = (UILabel*)[self.view viewWithTag:kTagLabBillInfo];
                                                                         if(labBillinfo){
                                                                             labBillinfo.text = @"本月已付话费：加载失败";
                                                                         }
                                                                     }
                                                                     
                                                                 }];
    }else
    {
        self._QryOperation03 = [MyAppDelegate.cserviceEngine postXMLWithCode:@"queryBillInfo"
                                                                      params:params
                                                                 onSucceeded:^(NSDictionary *dict) {
                                                                     id SumCharge = [[dict objectForKey:@"Data"] objectForKey:@"SumCharge"];
                                                                     UILabel* labBillinfo = (UILabel*)[self.view viewWithTag:kTagLabBillInfo];
                                                                     if(labBillinfo){
                                                                         labBillinfo.text = [NSString stringWithFormat:@"本月已付话费：%@元",SumCharge];
                                                                     }
                                                                     _hadUse = [SumCharge floatValue];
                                                                     [self setCycleTable];
                                                                     [self setTipLabel];
                                                                     //[SVProgressHUD dismiss];
                                                                 } onError:^(NSError *engineError) {
                                                                     
                                                                     //[SVProgressHUD dismiss];
                                                                     
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
                                                                         UILabel* labBillinfo = (UILabel*)[self.view viewWithTag:kTagLabBillInfo];
                                                                         if(labBillinfo){
                                                                             labBillinfo.text = @"本月已付话费：加载失败";
                                                                         }
                                                                     }
                                                                 }];
    }
}

//欠费额度
- (void)queryAcctBillInfo
{
    NSDictionary* logindict= [Global sharedInstance].loginInfoDict;
    NSString *PhoneNum = logindict[@"UserLoginName"] ? logindict[@"UserLoginName"] : @"";
    
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
                            PhoneNum,@"PhoneNum",
                            nil];
    
    self._QryOperation02 = [MyAppDelegate.cserviceEngine postXMLWithCode:@"queryAcctBillInfo"
                                                                  params:params
                                                             onSucceeded:^(NSDictionary *dict) {
                                                                 id  ShouldCharge = [[dict objectForKey:@"Data"] objectForKey:@"ShouldCharge"];
                                                                 UILabel* labCanuse = (UILabel*)[self.view viewWithTag:kTagLabAcctBillInfo];
                                                                 if(labCanuse){
                                                                     labCanuse.text = [NSString stringWithFormat:@"欠费金额：%@元",ShouldCharge];
                                                                 }
                                                                 _hadOwn = [ShouldCharge floatValue];
                                                                 [self setTipLabel];
                                                                 //[SVProgressHUD dismiss];
                                                             } onError:^(NSError *engineError) {
                                                                 
                                                                 //[SVProgressHUD dismiss];
                                                                 
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
                                                                     UILabel* labCanuse = (UILabel*)[self.view viewWithTag:kTagLabAcctBillInfo];
                                                                     if(labCanuse){
                                                                         labCanuse.text = @"欠费金额：加载失败";
                                                                     }
                                                                 }
                                                             }];
}


-(void)loginFirst{
    if ([Global sharedInstance].isLogin == NO)
    {
        //[self loginFirst];
        return;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
