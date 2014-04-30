//
//  CTQryValueAddVCtler.m
//  CTPocketV4
//
//  Created by Mac-Eshore-01 on 13-11-6.
//  Copyright (c) 2013年 广东亿迅科技有限公司. All rights reserved.
//  增值业务查询

#import "CTQryValueAddVCtler.h"
#import "UIView+RoundRect.h"
#import "CserviceEngine.h"
#import "AppDelegate.h"
#import "SIAlertView.h"
#import "CTOrderSuccessVCtler.h"
#import "SVProgressHUD.h"
#import "CTValueAddedVCtler.h"

#define kTagViewScrollview 1928
#define ORDERSURCESS @"OrderSucesss"
#define ORDERFAILED  @"OrderFailed"


@interface CTQryValueAddVCtler ()

@property (strong, nonatomic) CserviceOperation *_QryOperation01;
@property (strong, nonatomic) UIScrollView *scrollView;
@property (strong, nonatomic) UILabel *tipLb;
@property (strong, nonatomic) UIButton *commitBtn;

-(void)getSNEDate:(NSString**)stdate end:(NSString**)enddate;
@end

@implementation AddValItem
@synthesize itemData;
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        labName        = [[UILabel alloc] initWithFrame:CGRectMake(2,2,110,36)];
        labName.tag              = 1;
        labName.numberOfLines    = 2;
        labName.backgroundColor  = [UIColor clearColor];
        labName.font             = [UIFont systemFontOfSize:14];
        labName.textColor        = [UIColor blackColor];
        labName.text             = @"";
        labName.textAlignment    = UITextAlignmentLeft;
        labName.numberOfLines    = 0;
        [self addSubview:labName];
        
        labMoney      = [[UILabel alloc] initWithFrame:CGRectMake(110,10,60,20)];
        labMoney.tag             = 2;
        labMoney.backgroundColor = [UIColor clearColor];
        labMoney.font            = [UIFont systemFontOfSize:14];
        labMoney.text            = @"";
        labMoney.textAlignment   = UITextAlignmentRight;
        labMoney.textColor       = [UIColor colorWithRed:233/255.0
                                                    green:90/255.0
                                                     blue:76/255.0
                                                    alpha:1];//(106, 106, 106, 1);
//        [self addSubview:labMoney];
        
        labUnie      = [[UILabel alloc] initWithFrame:CGRectMake(170,10,30,20)];
        labUnie.tag              = 3;
        labUnie.backgroundColor  = [UIColor clearColor];
        labUnie.font             = [UIFont systemFontOfSize:14];
        labUnie.text             = @"元";
        labUnie.textAlignment   = UITextAlignmentLeft;
        labUnie.textColor        = [UIColor colorWithRed:106/255.0
                                                  green:106/255.0
                                                   blue:106/255.0
                                                  alpha:1];//(106, 106, 106, 1);
//        [self addSubview:labUnie];
        
        btnQuit = [UIButton buttonWithType:UIButtonTypeCustom];
        btnQuit.frame = CGRectMake(235,7,24.5,24.5);
        [btnQuit dwMakeRoundCornerWithRadius:3];
        [btnQuit setTitle:@"-" forState:UIControlStateNormal];
        [btnQuit setImage:[UIImage imageNamed:@"qry_valadd_btn.png"] forState:UIControlStateNormal];
        [btnQuit addTarget:self action:@selector(onQryAttribution) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btnQuit];
        
        // div line
        UIImageView* divLine0 = [[UIImageView alloc] initWithFrame:CGRectMake(0,frame.size.height-1,frame.size.width,1)];
        divLine0.image = [UIImage imageNamed:@"recharge_horline_bg.png"];
        [self addSubview:divLine0];
    }
    return self;
}

-(void)setData:(NSDictionary*)dict
{
    itemData = dict ;
    labName.text  = [dict objectForKey:@"VProductName"];
//    labMoney.text = [dict objectForKey:@"ChargingPolicyCN"];
}

#pragma mark - action

- (void) onQryAttribution
{
    NSString *message = [NSString stringWithFormat:@"你确定要退订 %@ 吗?",labName.text];
    
    __block AddValItem *weakSelf = self;
    SIAlertView *alertView = [[SIAlertView alloc] initWithTitle:nil andMessage:message];
    [alertView addButtonWithTitle:@"取消"
                             type:SIAlertViewButtonTypeDefault
                          handler:^(SIAlertView *alertView) {
                              
                          }];
    [alertView addButtonWithTitle:@"退订"
                             type:SIAlertViewButtonTypeDefault
                          handler:^(SIAlertView *alertView) {
                              NSDictionary *loginInfoDict = [Global sharedInstance].loginInfoDict;
                              NSString *phoneNbr = loginInfoDict[@"UserLoginName"];
                              
                              NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
                                                      phoneNbr, @"PhoneNbr",
                                                      @"1", @"ActionType",
                                                      @"0", @"ProductOfferType",
                                                      itemData[@"ProductOfferId"], @"ProductOfferID", nil];
                              
                              [SVProgressHUD showWithStatus:@"请稍候..." maskType:SVProgressHUDMaskTypeGradient];
                              
                              [MyAppDelegate.cserviceEngine postXMLWithCode:@"productOfferInfo"
                                                                     params:params
                                                                onSucceeded:^(NSDictionary *dict) {
                                                                    //假如通知跳转
                                                      
                                                                    [SVProgressHUD dismiss];
                                                                    [[NSNotificationCenter defaultCenter]postNotificationName:ORDERSURCESS object:weakSelf.itemData];
                                                                    
                                                                } onError:^(NSError *engineError) {
                                                                    [SVProgressHUD dismiss];
                                                                    
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
                                                                    else
                                                                    {
                                                                        SIAlertView *alertView = [[SIAlertView alloc] initWithTitle:nil
                                                                                                                         andMessage:engineError.localizedDescription];
                                                                        [alertView addButtonWithTitle:@"确定"
                                                                                                 type:SIAlertViewButtonTypeDefault
                                                                                              handler:^(SIAlertView *alertView) {
                                                                                                  NSLog(@"取消");
                                                                                              }];
                                                                        alertView.transitionStyle = SIAlertViewTransitionStyleBounce;
                                                                        [alertView show];
                                                                    }
                                                                    
                                                                }];
                          }];
    alertView.transitionStyle = SIAlertViewTransitionStyleBounce;
    [alertView show];
}

@end;

@interface CTQryValueAddVCtler ()

@end

@implementation CTQryValueAddVCtler

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
    //加入通知事件
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(popOrderSucessVC:)
                                                 name:ORDERSURCESS
                                               object:nil];
    
    self.title = @"增值业务查询";
    // 左按钮
    [self setLeftButton:[UIImage imageNamed:@"btn_back"]];
    {
        UILabel* numlab = [[UILabel alloc] initWithFrame:CGRectMake(20,15,130,22)];
        numlab.backgroundColor = [UIColor clearColor];
        numlab.font     = [UIFont systemFontOfSize:14];
        numlab.textColor= [UIColor blackColor];
        numlab.text     = @"订购金额合计：";
//        [self.view addSubview:numlab];
        
        UILabel* monlab = [[UILabel alloc] initWithFrame:CGRectMake(130,15,150,22)];
        monlab.backgroundColor = [UIColor clearColor];
        monlab.font     = [UIFont systemFontOfSize:14];
        monlab.textColor= [UIColor colorWithRed:233/255.0
                                          green:90/255.0
                                           blue:76/255.0
                                          alpha:1];
        monlab.text     = @"10.10";
//        [self.view addSubview:monlab];

        
        UILabel* datelab = [[UILabel alloc] initWithFrame:CGRectMake(20,14,280,22)];
        datelab.backgroundColor = [UIColor clearColor];
        datelab.font     = [UIFont systemFontOfSize:14];
        datelab.textColor= [UIColor blackColor];
        {
            NSString* startDate    = @"";
            NSString* endsDate     = @"";
            [self getSNEDate:&startDate end:&endsDate];
            //NSLog(@"start=%@,end=%@",startDate,endsDate);
            datelab.text     = [NSString stringWithFormat:@"计费起始日期：%@-%@", startDate, endsDate];//@"计费起始日期：2013年10月1日-10月10日";
        }
        [self.view addSubview:datelab];
        
        // div line
        UIImageView* divLine0 = [[UIImageView alloc] initWithFrame:CGRectMake(18,50,284,1)];
        divLine0.image = [UIImage imageNamed:@"recharge_horline_bg.png"];
        [self.view addSubview:divLine0];
        
        
        UIScrollView *scroll = [[UIScrollView alloc]initWithFrame:CGRectMake(20,
                                                                             CGRectGetMaxY(divLine0.frame)+10,
                                                                             CGRectGetWidth(self.view.frame)-40,
                                                                             CGRectGetHeight(self.view.frame)-61-196)];
        scroll.autoresizingMask = UIViewAutoresizingFlexibleHeight;
        scroll.backgroundColor = [UIColor clearColor];
        [self.view addSubview:scroll];
        scroll.contentSize = scroll.frame.size ;
        self.scrollView = scroll ;
        
        CGRect rc       = CGRectMake(18,CGRectGetMaxY(scroll.frame),284,40);
        UILabel* mtitle = [[UILabel alloc] initWithFrame:rc];
        mtitle.backgroundColor = [UIColor clearColor];
        mtitle.numberOfLines   = 2;
        mtitle.font     = [UIFont systemFontOfSize:13];
        mtitle.textColor= [UIColor colorWithRed:233/255.0
                                          green:90/255.0
                                           blue:76/255.0
                                          alpha:1];
        
        mtitle.text     = @"注：本页数据内容仅供参考，详细情况请以当月出账数据为准。";
        self.tipLb = mtitle;
        [self.view addSubview:mtitle];
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(18,CGRectGetMaxY(mtitle.frame),CGRectGetWidth(self.view.frame)-36,36);
        [button dwMakeRoundCornerWithRadius:3];
        [button setBackgroundImage:[[UIImage imageNamed:@"common_alert_button.png"] stretchableImageWithLeftCapWidth:12 topCapHeight:12]
                          forState:UIControlStateNormal];
        [button setTitle:@"订购更多增值业务" forState:UIControlStateNormal];
        [button addTarget:self action:@selector(onValueAddedAction) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:button];
        self.commitBtn = button;
    }
    
    [self queryAvProducts];
}

#pragma  mark - NSNotification

- (void) popOrderSucessVC:(NSNotification *)obj
{
    NSDictionary *dict = [obj object];
    
    CTOrderSuccessVCtler *vc = [[CTOrderSuccessVCtler alloc] init];
    vc.actionType = 1;
    vc.prodName = dict[@"ProductOfferName"];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - fun

-(void)getSNEDate:(NSString**)stdate end:(NSString**)enddate
{
    NSDate * today      = [NSDate date];
    NSDateFormatter * df= [NSDateFormatter new];
    [df setDateFormat:@"yyyy年MM月"];
    *stdate             = [NSString stringWithFormat:@"%@1日", [df stringFromDate:today]];
    [df setDateFormat:@"MM月dd日"];
    *enddate            = [df stringFromDate:today];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)queryAvProducts
{
    NSDictionary* logindict= [Global sharedInstance].loginInfoDict;
    NSString *PhoneNum = logindict[@"UserLoginName"] ? logindict[@"UserLoginName"] : @"";
    NSDictionary *params   = [NSDictionary dictionaryWithObjectsAndKeys:
                              PhoneNum,@"PhoneNbr",
                              nil];
    [SVProgressHUD showWithStatus:@"请稍候..." maskType:SVProgressHUDMaskTypeGradient];
    self._QryOperation01   = [MyAppDelegate.cserviceEngine postXMLWithCode:@"qryProductInfo"
                                                                    params:params
                                                               onSucceeded:^(NSDictionary *dict) {
                                                                   [self resetLabs:dict];
                                                                   [SVProgressHUD dismiss];
                                                               } onError:^(NSError *engineError) {
                                                                   DDLogInfo(@"%s--%@", __func__, engineError);
                                                                   [self onQryUnSuccess:engineError];
                                                                   [SVProgressHUD dismiss];
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
                                                               }];

}

-(void)resetLabs:(NSDictionary*)data
{
//    CGFloat yval = 66,y = 0;
    CGFloat y = 0;
//    UIScrollView* scrolView = (UIScrollView*)[self.view viewWithTag:kTagViewScrollview];
//    if (!scrolView) {
//        scrolView = [[UIScrollView alloc] initWithFrame:CGRectMake(18,yval,284,
//                                                                   self.view.frame.size.height-66)];
//        scrolView.tag = kTagViewScrollview;
//        scrolView.backgroundColor = [UIColor clearColor];
//        scrolView.showsVerticalScrollIndicator = NO;
//        [self.view addSubview:scrolView];
//    }
    
//    for (UIView* tv in [scrolView subviews])
//    {
//        if ( [tv isKindOfClass:[UILabel class]]
//            ||[tv isKindOfClass:[AddValItem class]])
//        {
//            [tv removeFromSuperview];
//        }
//    }
    
    id ResultInfoList = [[data objectForKey:@"Data"] objectForKey:@"ResultInfo"];
    BOOL ishas = NO;
    if (ResultInfoList != [NSNull null])
    {
        //NSLog(@"class=%@",[ResultInfoList class]);
        if ([ResultInfoList isKindOfClass:[NSArray class]])
        {
            if([ResultInfoList count]>0)
            {
                ishas = YES ;
            }
            for (int i = 0; i< [ResultInfoList count]; i ++)
            {
                AddValItem* item = [[AddValItem alloc] initWithFrame:CGRectMake(0, y, 284, 40)];
                [item setData:[ResultInfoList objectAtIndex:i]];
                [self.scrollView addSubview:item];
                y += 40;
            }
            y += 10;
            ishas = YES;
        }else if(  [ResultInfoList isKindOfClass:[NSDictionary class]]
                 ||[ResultInfoList isKindOfClass:[NSMutableDictionary class]])
        {
            AddValItem* item = [[AddValItem alloc] initWithFrame:CGRectMake(0, y, 284, 40)];
            [item setData:ResultInfoList];
            [self.scrollView addSubview:item];
            y += 10;
            ishas = YES;
        }
    }else{
        ishas = NO;
    }
    
//    CGRect rc       = CGRectMake(0,y,284,40);
//    UILabel* mtitle = [[UILabel alloc] initWithFrame:rc];
//    mtitle.backgroundColor = [UIColor clearColor];
//    mtitle.numberOfLines   = 2;
//    mtitle.font     = [UIFont systemFontOfSize:13];
//    mtitle.textColor= [UIColor colorWithRed:233/255.0
//                                      green:90/255.0
//                                       blue:76/255.0
//                                      alpha:1];
//    
//    mtitle.text     = @"注：本页数据内容仅供参考，详细情况请以当月出账数据为准。";
//    scrolView == nil ? [self.view addSubview:mtitle]:[scrolView addSubview:mtitle];
//    
//    y       += 50;
//    yval    += 50;
//    rc       = CGRectMake(0,y,284,36);
//    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
//    button.frame = CGRectMake(0,y,284,36);
//    
//    [button dwMakeRoundCornerWithRadius:3];
//    [button setBackgroundImage:[[UIImage imageNamed:@"common_alert_button.png"] stretchableImageWithLeftCapWidth:12 topCapHeight:12]
//                      forState:UIControlStateNormal];
//    [button setTitle:@"订购更多增值业务" forState:UIControlStateNormal];
//    [button addTarget:self action:@selector(onValueAddedAction) forControlEvents:UIControlEventTouchUpInside];
//    [scrolView addSubview:button];
    if(!ishas)
    {
        self.tipLb.text = @"亲,目前你暂时没有订购任何增值业务";
        self.tipLb.textAlignment = UITextAlignmentCenter ;
        [self.commitBtn setTitle:@"订购增值业务" forState:UIControlStateNormal];
    }
    self.scrollView.contentSize = CGSizeMake(self.scrollView.frame.size.width, y);
}

-(void)onQryUnSuccess:(NSError *)engineError
{
//    CGFloat yval = 66;
//    UIScrollView* scrolView = (UIScrollView*)[self.view viewWithTag:kTagViewScrollview];
//    if (!scrolView) {
//        scrolView = [[UIScrollView alloc] initWithFrame:CGRectMake(18,yval,284,
//                                                                   self.view.frame.size.height-66)];
//        scrolView.tag = kTagViewScrollview;
//        scrolView.backgroundColor = [UIColor clearColor];
//        scrolView.showsVerticalScrollIndicator = NO;
//        [self.view addSubview:scrolView];
//    }

    {
        // 请求失败时的提示
        UILabel* mtitle = [[UILabel alloc] initWithFrame:CGRectMake(20, (self.scrollView.frame.size.height-60)/2, 280, 60)];
        mtitle.backgroundColor = [UIColor clearColor];
        mtitle.numberOfLines   = 2;
        mtitle.font     = [UIFont systemFontOfSize:13];
        mtitle.textColor= [UIColor colorWithRed:233/255.0
                                          green:90/255.0
                                           blue:76/255.0
                                          alpha:1];
        mtitle.text = [NSString stringWithFormat:@"查询失败,%@",[engineError localizedDescription]];//@"";
        [self.scrollView addSubview:mtitle];
    }
    
    SIAlertView *alertView = [[SIAlertView alloc] initWithTitle:nil
                                                     andMessage:engineError.localizedDescription];
    [alertView addButtonWithTitle:@"确定"
                             type:SIAlertViewButtonTypeDefault
                          handler:^(SIAlertView *alertView) {
                              NSLog(@"取消");
                          }];
    alertView.transitionStyle = SIAlertViewTransitionStyleBounce;
    [alertView show];
}

- (void)onValueAddedAction
{
    CTValueAddedVCtler *vc = [[CTValueAddedVCtler alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

@end
