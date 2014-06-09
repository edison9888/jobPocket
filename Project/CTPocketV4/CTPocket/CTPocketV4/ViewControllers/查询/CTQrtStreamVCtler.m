//
//  CTQrtStreamVCtler.m
//  CTPocketV4
//
//  Created by Mac-Eshore-01 on 13-11-5.
//  Copyright (c) 2013年 广东亿迅科技有限公司. All rights reserved.
//  流量查询

#import "CTQrtStreamVCtler.h"
#import "UIView+RoundRect.h"
#import "CserviceEngine.h"
#import "AppDelegate.h"
#import "Utils.h"
#import "Global.h"
#import "SIAlertView.h"
#import "NSDate+Extensions.h"
#import "CTCycleTableView.h"
#import "SVProgressHUD.h"
#import "CTRechargeVCtler.h"
#import "ToastAlertView.h"
#import "CTFlowRemainingVCtler.h"

#define kTagLabavg_day          1001
#define kTagLabcur_use          1002
#define kTagLabStream_total     1003
#define kTagLabStream_Left      1004
#define kTagLabavgcan_use       1005
#define kTagCycTableView        1006
#define kTagCycTableLableft     1007
#define kTagCycTableLabRight    1008
#define kTagLabelStreamTip      1009

@interface CTQrtStreamVCtler ()
@property (strong, nonatomic)CserviceOperation *_QryOperation01;
@property (assign, nonatomic) int flowStatus;
@property (nonatomic, strong) UIButton *commitBnt;


@property (nonatomic, strong) UILabel *daysAvgWithUseFlow; //日均已用流量
@property (nonatomic, strong) UILabel *useFlow;//已用流量
@property (nonatomic, strong) UILabel *packageTotalFloew; //套餐总流量
@property (nonatomic, strong) UILabel *lessFlow ;//剩余流量
@property (nonatomic, strong) UILabel *daysAvgWithUnuseFlow ; //日均可用流量

@property (nonatomic, strong) UILabel *beginLab;
@property (nonatomic, strong) UILabel *endLab;


@property (strong, nonatomic) NSDictionary*     flowInfoDict;       // added by zy, 2013-12-6

- (void)queryFlowInfo;
-(void)onQryUnSuccess:(NSError *)engineError;
-(void)resetLabs:(NSDictionary*)data;
-(void)getSNEDate:(NSString**)start end:(NSString**)end;
-(NSString*)getValString:(float)svalue;
-(void)onStreamPackageBution:(id)sender;
@end

@implementation CTQrtStreamVCtler

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.flowStatus = 0;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.title = @"流量查询";
    // 左按钮
    [self setLeftButton:[UIImage imageNamed:@"btn_back"]];
    
    {
        NSString* startDate    = @"";
        NSString* endsDate     = @"";
        [self getSNEDate:&startDate end:&endsDate];
        NSLog(@"start=%@,end=%@",startDate,endsDate);
        
        NSDictionary* logindict= [Global sharedInstance].loginInfoDict;
        NSString *PhoneNum = logindict[@"UserLoginName"] ? logindict[@"UserLoginName"] : @"";

        UILabel* numlab = [[UILabel alloc] initWithFrame:CGRectMake(10,15,300,22)];
        numlab.backgroundColor = [UIColor clearColor];
        numlab.font     = [UIFont systemFontOfSize:14];
        numlab.textColor= [UIColor blackColor];
        numlab.text     = [NSString stringWithFormat:@"查询号码：%@",PhoneNum];
        [self.view addSubview:numlab];
        
        UILabel* datelab = [[UILabel alloc] initWithFrame:CGRectMake(10,37,300,22)];
        datelab.backgroundColor = [UIColor clearColor];
        datelab.font     = [UIFont systemFontOfSize:14];
        datelab.textColor= [UIColor blackColor];
        datelab.text     = [NSString stringWithFormat:@"查询周期：%@-%@", startDate, endsDate];//@"查询周期：2013年10月1日-10月10日";
        [self.view addSubview:datelab];
    }
    
    {
        // div line
        UIImageView* divLine0 = [[UIImageView alloc] initWithFrame:CGRectMake(0,65, 320, 1)];
        divLine0.image = [UIImage imageNamed:@"recharge_horline_bg.png"];
        [self.view addSubview:divLine0];
        
        // div line
        UIImageView* divLine1 = [[UIImageView alloc] initWithFrame:CGRectMake(0,125, 110, 1)];
        divLine1.image = [UIImage imageNamed:@"recharge_horline_bg.png"];
        [self.view addSubview:divLine1];
    
        // div line
        UIImageView* divLine2 = [[UIImageView alloc] initWithFrame:CGRectMake(0,185, 320, 1)];
        divLine2.image = [UIImage imageNamed:@"recharge_horline_bg.png"];
        [self.view addSubview:divLine2];

        // div line
        UIImageView* divLin2 = [[UIImageView alloc] initWithFrame:CGRectMake(0,245, 320, 1)];
        divLin2.image = [UIImage imageNamed:@"recharge_horline_bg.png"];
        [self.view addSubview:divLin2];
        
        
        UIImageView* divLinV1 = [[UIImageView alloc] initWithFrame:CGRectMake(110,65,1,180)];
        divLinV1.image = [UIImage imageNamed:@"navigationBar_separatorV.png"];
        [self.view addSubview:divLinV1];
        
        UIImageView* divLinV2 = [[UIImageView alloc] initWithFrame:CGRectMake(215,185,1,60)];
        divLinV2.image = [UIImage imageNamed:@"navigationBar_separatorV.png"];
        [self.view addSubview:divLinV2];
        
        // grid
        {// 日均已用流量
            UILabel* mtitle = [[UILabel alloc] initWithFrame:CGRectMake(0,80,110,16)];
            mtitle.backgroundColor = [UIColor clearColor];
            mtitle.font     = [UIFont systemFontOfSize:14];
            mtitle.textColor= [UIColor blackColor];
            mtitle.textAlignment = UITextAlignmentCenter;
            mtitle.text     = @"日均已用流量";
            [self.view addSubview:mtitle];
            
            UILabel *useFlow =  [[UILabel alloc] initWithFrame:CGRectMake(38,CGRectGetMaxY(mtitle.frame)+4,0,12)];
            useFlow.backgroundColor = [UIColor clearColor];
            useFlow.font     = [UIFont boldSystemFontOfSize:14];
            useFlow.numberOfLines = 0;
            useFlow.textColor= [UIColor blackColor];
            useFlow.textAlignment = UITextAlignmentCenter;
            useFlow.text     = @"";
            [self.view addSubview:useFlow];
            
            self.daysAvgWithUseFlow = useFlow ;
//            UILabel *mark =  [[UILabel alloc] initWithFrame:CGRectMake(10,CGRectGetMaxY(useFlow.frame)+4,30,16)];
//            mark.backgroundColor = [UIColor clearColor];
//            mark.font     = [UIFont systemFontOfSize:10];
//            mark.numberOfLines = 0;
//            mark.textColor= [UIColor blackColor];
//            mark.textAlignment = UITextAlignmentCenter;
//            mark.text     = @"M";
//            [self.view addSubview:mark];
        }
        
        {// 已用流量
            UILabel* mtitle1 = [[UILabel alloc] initWithFrame:CGRectMake(0,140,110,16)];
            mtitle1.backgroundColor = [UIColor clearColor];
            mtitle1.font     = [UIFont systemFontOfSize:14];
            mtitle1.textColor= [UIColor blackColor];
            mtitle1.textAlignment = UITextAlignmentCenter;
            mtitle1.text     = @"已用流量";
            [self.view addSubview:mtitle1];
            
            UILabel* label = [[UILabel alloc] initWithFrame:CGRectMake(38,CGRectGetMaxY(mtitle1.frame)+4,16,12)];
            label.backgroundColor = [UIColor clearColor];
            label.font     = [UIFont boldSystemFontOfSize:14];
            label.textColor= [UIColor blackColor];
            label.textAlignment = UITextAlignmentCenter;
            label.text     = @"";
            [self.view addSubview:label];
            
            self.useFlow = label ; //
        }
        
        {// 套餐内3G总流量
            UILabel* mtitle = [[UILabel alloc] initWithFrame:CGRectMake(0,200,110,16)];
//            mtitle.tag = kTagLabStream_total;
            mtitle.backgroundColor = [UIColor clearColor];
//            mtitle.numberOfLines   = 2;
            mtitle.font     = [UIFont systemFontOfSize:14];
            mtitle.textAlignment = UITextAlignmentCenter;
            mtitle.textColor= [UIColor blackColor];
            mtitle.text     = @"套餐内3G总流量";
            [self.view addSubview:mtitle];
            
            UILabel* label = [[UILabel alloc] initWithFrame:CGRectMake(38,CGRectGetMaxY(mtitle.frame)+4,16,12)];
//            label.tag = kTagLabStream_total;
            label.backgroundColor = [UIColor clearColor];
//            label.numberOfLines   = 2;
            label.font     = [UIFont boldSystemFontOfSize:14];
            label.textAlignment = UITextAlignmentCenter;
            label.textColor= [UIColor blackColor];
            label.text     = @"";
            [self.view addSubview:label];
            
            self.packageTotalFloew = label ;
        }
        
        {// 剩余流量
            UILabel* mtitle = [[UILabel alloc] initWithFrame:CGRectMake(110,200,105,16)];
//            mtitle.tag = kTagLabStream_Left;
            mtitle.backgroundColor = [UIColor clearColor];
//            mtitle.numberOfLines   = 2;
            mtitle.font     = [UIFont systemFontOfSize:14];
            mtitle.textAlignment = UITextAlignmentCenter;
            mtitle.textColor= [UIColor blackColor];
            mtitle.text     = @"剩余流量";
            [self.view addSubview:mtitle];
            
            UILabel* label = [[UILabel alloc] initWithFrame:CGRectMake(143,CGRectGetMaxY(mtitle.frame)+4,16,12)];
//            label.tag = kTagLabStream_Left;
            label.backgroundColor = [UIColor clearColor];
//            label.numberOfLines   = 2;
            label.font     = [UIFont boldSystemFontOfSize:14];
            label.textAlignment = UITextAlignmentCenter;
            label.textColor= [UIColor blackColor];
            label.text     = @"";
            [self.view addSubview:label];
            
            self.lessFlow = label;
        }
        {// 日均可用流量
            UILabel* mtitle = [[UILabel alloc] initWithFrame:CGRectMake(215,200,105,16)];
//            mtitle.tag = kTagLabavgcan_use;
            mtitle.backgroundColor = [UIColor clearColor];
//            mtitle.numberOfLines   = 2;
            mtitle.font     = [UIFont systemFontOfSize:14];
            mtitle.textColor= [UIColor blackColor];
            mtitle.textAlignment = UITextAlignmentCenter;
            mtitle.text     = @"日均可用流量";
            [self.view addSubview:mtitle];
            
            UILabel* label = [[UILabel alloc] initWithFrame:CGRectMake(248,CGRectGetMaxY(mtitle.frame)+4,16,16)];
//            label.tag = kTagLabavgcan_use;
            label.backgroundColor = [UIColor clearColor];
//            label.numberOfLines   = 2;
            label.font     = [UIFont boldSystemFontOfSize:14];
            label.textColor= [UIColor blackColor];
            label.textAlignment = UITextAlignmentCenter;
            label.text     = @"";
            [self.view addSubview:label];
            
            self.daysAvgWithUnuseFlow = label;
        }
        
        {// 流量表
            CTCycleTableView* ctable = [[CTCycleTableView alloc] initWithFrame:CGRectMake(160,71,103,103)];
            ctable.tag     = kTagCycTableView;
            [self.view addSubview:ctable];
            
            UILabel* leftTip = [[UILabel alloc] initWithFrame:CGRectMake(160,158,20,22)];
            leftTip.tag = kTagCycTableLableft;
            leftTip.backgroundColor = [UIColor clearColor];
            leftTip.font     = [UIFont boldSystemFontOfSize:14];
            leftTip.textColor= [UIColor blackColor];
            leftTip.textAlignment = UITextAlignmentRight;
            leftTip.text     = @"0";
            [self.view addSubview:leftTip];
            self.beginLab = leftTip;
            
            UILabel* rightTip = [[UILabel alloc] initWithFrame:CGRectMake(248,158,60,22)];
            rightTip.tag = kTagCycTableLabRight;
            rightTip.backgroundColor = [UIColor clearColor];
            rightTip.font     = [UIFont boldSystemFontOfSize:14];
            rightTip.textColor= [UIColor blackColor];
            rightTip.textAlignment = UITextAlignmentLeft;
            rightTip.text     = @"-M";
            [self.view addSubview:rightTip];
            self.endLab = rightTip;
        }
    }
    
    {
        UILabel* mtitle = [[UILabel alloc] initWithFrame:CGRectMake(10,265,300,40)];
        mtitle.backgroundColor = [UIColor clearColor];
        mtitle.numberOfLines   = 2;
        mtitle.tag      = kTagLabelStreamTip;
        mtitle.font     = [UIFont systemFontOfSize:12];
        mtitle.textColor= [UIColor colorWithRed:233.0/255
                                          green:88.0/255
                                           blue:74.0/255
                                          alpha:1];
        /*TODO:tip
        1.已用流量<80%文字为“剩余流量充足，请放心使用”；
        2.已用流量>=80%文字，有流量包订购的省份为“剩余流量不足，建议追加流量包，每M流量最多节省50%费用”，
        3.没有流量包订购的省份为“剩余流量不足，建议购买流量卡，每M流量最多节省50%费用”
        */ 

        mtitle.text     = @"";//@"本月流量不足，建议追加流量包，每M流量最多节省50%";
        mtitle.textAlignment = UITextAlignmentCenter;
        [self.view addSubview:mtitle];
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(20,312,280,36);
        [button setBackgroundImage:[[UIImage imageNamed:@"common_alert_button.png"] stretchableImageWithLeftCapWidth:12 topCapHeight:12]
                          forState:UIControlStateNormal];
        [button dwMakeRoundCornerWithRadius:3];
        [button setTitle:@"购买流量卡" forState:UIControlStateNormal];
        [button addTarget:self action:@selector(onStreamPackageBution:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:button];
        self.commitBnt = button;
    }
    
    [self queryFlowInfo];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)onStreamPackageBution:(id)sender
{
    if (self.flowStatus==0) {
        
        // added by zy, 2013-12-5, 增加剩余流量跳转
        CTFlowRemainingVCtler* vctler = [CTFlowRemainingVCtler new];
        vctler.flowInfoDict = self.flowInfoDict;
        [self.navigationController pushViewController:vctler animated:YES];
        // added by zy, 2013-12-5, 增加剩余流量跳转
        
    }else{
        UINavigationController *nar =  MyAppDelegate.tabBarController.viewControllers[2] ;
        CTRechargeVCtler *vc =  (CTRechargeVCtler *)nar.viewControllers[0] ;
        [vc pageIndex:0];
        MyAppDelegate.tabBarController.selectedIndex = 2;
    }
}


- (void)queryFlowInfo
{
    NSDictionary* logindict= [Global sharedInstance].loginInfoDict;
    NSString *PhoneNum = logindict[@"UserLoginName"] ? logindict[@"UserLoginName"] : @"";
    NSDictionary *params   = [NSDictionary dictionaryWithObjectsAndKeys:
                              PhoneNum,@"PhoneNum",
                              nil];
    
    [SVProgressHUD showWithStatus:@"请稍候..." maskType:SVProgressHUDMaskTypeGradient];
    self._QryOperation01   = [MyAppDelegate.cserviceEngine postXMLWithCode:@"queryFlowInfo"
                                                                    params:params
                                                               onSucceeded:^(NSDictionary *dict) {
                                                                   [self resetLabs:dict];
                                                                   [SVProgressHUD dismiss];
                                                               } onError:^(NSError *engineError) {
                                                                   DDLogInfo(@"%s--%@", __func__, engineError);
//                                                                   [self onQryUnSuccess:engineError];
                                                                   
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
                                                                   else
                                                                   {
                                                                       ToastAlertView *alet = [ToastAlertView new];
                                                                       [alet showAlertMsg:@"网络繁忙,请稍后再试"];
                                                                   }
                                                                   
                                                               }];
}

-(void)getSNEDate:(NSString**)stdate end:(NSString**)enddate
{
    NSDate * today      = [NSDate date];
    NSDateFormatter * df= [NSDateFormatter new];
    [df setDateFormat:@"yyyy年MM月"];
    *stdate             = [NSString stringWithFormat:@"%@1日", [df stringFromDate:today]];
    [df setDateFormat:@"MM月dd日"];
    *enddate            = [df stringFromDate:today];
}

-(NSString*)getValString:(float)svalue
{
    NSString* UnitTypeId = @"M";
    NSString* strStream  = @"";
    CGFloat fvalue =  svalue/1024.0;
    
    if (fvalue > 1024)
    {
        UnitTypeId = @"G";
        strStream = [NSString stringWithFormat:@"%.2f%@", fvalue/1024.0, UnitTypeId];
    }
    else
    {
        UnitTypeId = @"M";
        strStream = [NSString stringWithFormat:@"%.2f%@", fvalue, UnitTypeId];
    }
    return strStream;
}

-(void)resetLabs:(NSDictionary*)data
{
    // added by zy, 2013-12-6
    if (data[@"Data"] != [NSNull null] &&
        data[@"Data"] != nil)
    {
        self.flowInfoDict = data[@"Data"];
    }
    // added by zy, 2013-12-6
    
    {   // 日均： 接口无返回，需要自己算
        NSNumber* used  = [[data objectForKey:@"Data"] objectForKey:@"UsedAmount"];

        NSDate * today  = [NSDate date];
        NSDate * fristDay = [today getFirstDayOfMonth];
        NSInteger btDays= [Utils getDayCountBetween:fristDay end:today];
        
        CGFloat  avg    = [used intValue]/btDays/1.0;
        NSString* str   = [self getValString:avg];
        //@"日均已用流量\rM";
        self.daysAvgWithUseFlow.text     = [NSString stringWithFormat:@"%@",[str substringToIndex:str.length-1]];
//        self.daysAvgWithUseFlow.numberOfLines = 0;
        [self.daysAvgWithUseFlow sizeToFit];
        
        UILabel *label1 = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.daysAvgWithUseFlow.frame), self.daysAvgWithUseFlow.frame.origin.y+4, 10, 10)];
        label1.text = [NSString stringWithFormat:@"%@",[str substringFromIndex:str.length-1]];
        label1.font = [UIFont systemFontOfSize:10];
        label1.backgroundColor = [UIColor clearColor];
//        label.numberOfLines = 0;
        [label1 sizeToFit];
        [self.view addSubview:label1];
    }
    
    {   // 今日： 接口无返回，需要自己算
//        UILabel* mtitle = (UILabel*)[self.view viewWithTag:kTagLabcur_use];
        NSNumber* total = [[data objectForKey:@"Data"] objectForKey:@"UsedAmount"];
        NSString* tstr  = [self getValString:[total intValue]];
        
        self.useFlow.text     = [NSString stringWithFormat:@"%@",[tstr substringToIndex:tstr.length-1]];
//        self.useFlow.numberOfLines = 0;
        [self.useFlow sizeToFit];
        
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.useFlow.frame), self.useFlow.frame.origin.y+4, 10, 10)];
        label.text = [NSString stringWithFormat:@"%@",[tstr substringFromIndex:tstr.length-1]];
        label.font = [UIFont systemFontOfSize:10];
        label.backgroundColor = [UIColor clearColor];
//        label.numberOfLines = 0;
        [label sizeToFit];
        [self.view addSubview:label];
    }
    
    {   // 总量： 接口无返回，需要自己算
//        UILabel* mtitle = (UILabel*)[self.view viewWithTag:kTagLabStream_total];
        NSNumber* total = [[data objectForKey:@"Data"] objectForKey:@"AccAmount"];
        NSString* tstr  = [self getValString:[total intValue]];
        self.packageTotalFloew.text     = [NSString stringWithFormat:@"%@",[tstr substringToIndex:tstr.length-1]];
        
//        self.packageTotalFloew.numberOfLines = 0;
        [self.packageTotalFloew sizeToFit];
        
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.packageTotalFloew.frame), self.packageTotalFloew.frame.origin.y+4, 10, 10)];
        label.text = [NSString stringWithFormat:@"%@",[tstr substringFromIndex:tstr.length-1]];
        label.font = [UIFont systemFontOfSize:10];
        label.backgroundColor = [UIColor clearColor];
//        label.numberOfLines = 0;
        [label sizeToFit];
        [self.view addSubview:label];
    }
    
    {   // 剩余量： 接口无返回，需要自己算
//        UILabel* mtitle = (UILabel*)[self.view viewWithTag:kTagLabStream_Left];
        NSNumber* total = [[data objectForKey:@"Data"] objectForKey:@"AccAmount"];
        NSNumber* used  = [[data objectForKey:@"Data"] objectForKey:@"UsedAmount"];
        NSInteger left  = [total intValue] - [used intValue];
        NSString* svals = [self getValString:left];
        self.lessFlow.text     = [NSString stringWithFormat:@"%@",[svals substringToIndex:svals.length-1]];;
        
//        self.lessFlow.numberOfLines = 0;
        [self.lessFlow sizeToFit];
        
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.lessFlow.frame), self.lessFlow.frame.origin.y+4, 10, 10)];
        label.text = [NSString stringWithFormat:@"%@",[svals substringFromIndex:svals.length-1]];
        label.font = [UIFont systemFontOfSize:10];
        label.backgroundColor = [UIColor clearColor];
//        label.numberOfLines = 0;
        [label sizeToFit];
        [self.view addSubview:label];
    }
    
    {   // 日均可用： 接口无返回，需要自己算
//        UILabel* mtitle = (UILabel*)[self.view viewWithTag:kTagLabavgcan_use];

        NSNumber* total = [[data objectForKey:@"Data"] objectForKey:@"AccAmount"];
        NSNumber* used  = [[data objectForKey:@"Data"] objectForKey:@"UsedAmount"];
        NSInteger left  = [total intValue] - [used intValue];

        NSDate* today   = [NSDate date];
        NSDate* lastDay = [today getLastDayOfMonth];
        
        NSDateFormatter * df= [NSDateFormatter new];
        [df setDateFormat:@"yyyy年MM月dd日"];
        DDLogInfo(@"%s----%@", __func__,[df stringFromDate:lastDay]);
        
        NSInteger days  = [Utils getDayCountBetween:today end:lastDay];
        float leftavgAmount = left;
        if (days==0) {
            leftavgAmount /= 1;
        }else{
            leftavgAmount /= days;
        }
        
        NSString* svals = [self getValString:leftavgAmount];
        self.daysAvgWithUnuseFlow.text     = [NSString stringWithFormat:@"%@",[svals substringToIndex:svals.length-1]];
        [self.daysAvgWithUnuseFlow sizeToFit];
        
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.daysAvgWithUnuseFlow.frame), self.daysAvgWithUnuseFlow.frame.origin.y+4, 10, 10)];
        label.text = [NSString stringWithFormat:@"%@",[svals substringFromIndex:svals.length-1]];
        label.font = [UIFont systemFontOfSize:10];
        label.backgroundColor = [UIColor clearColor];
        label.numberOfLines = 0;
        [label sizeToFit];
        [self.view addSubview:label];
    }
    
    {   // 流量表
        CTCycleTableView* ctable = (CTCycleTableView*)[self.view viewWithTag:kTagCycTableView];
        NSNumber* total = [[data objectForKey:@"Data"] objectForKey:@"AccAmount"];
        NSNumber* used  = [[data objectForKey:@"Data"] objectForKey:@"UsedAmount"];
        
        CGFloat persent  = [used intValue]*1.0/[total intValue];
        NSString* strper = [NSString stringWithFormat:@"已用流量\r%d%@",(int)(persent*100),@"%"];
        [ctable setPersentVal:strper persent:persent];
        [ctable setNeedsDisplay];
        
        //圆环外的左右表示
        self.beginLab.text = @"0";
        [self.beginLab sizeToFit];
        
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.beginLab.frame), self.beginLab.frame.origin.y+4, 10, 10)];
        label.text = @"M";
        label.font = [UIFont systemFontOfSize:10];
        label.backgroundColor = [UIColor clearColor];
        label.numberOfLines = 0;
        [label sizeToFit];
        [self.view addSubview:label];
        
        
        NSString* tstr= [self getValString:[total intValue]];
//        UILabel* rtip = (UILabel*)[self.view viewWithTag:kTagCycTableLabRight];
        self.endLab.text     = [NSString stringWithFormat:@"%@",[tstr substringToIndex:tstr.length-1]];
        [self.endLab sizeToFit];
        
        UILabel *label1 = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.endLab.frame), self.endLab.frame.origin.y+4, 10, 10)];
        label1.text = [NSString stringWithFormat:@"%@",[tstr substringFromIndex:tstr.length-1]];
        label1.font = [UIFont systemFontOfSize:10];
        label1.backgroundColor = [UIColor clearColor];
        label1.numberOfLines = 0;
        [label1 sizeToFit];
        [self.view addSubview:label1];
        
        // 根据流量使用%来填写流量信息提示
        UILabel* mtitle = (UILabel*)[self.view viewWithTag:kTagLabelStreamTip];

        if(persent > 0.8)
        {
            self.flowStatus = 1;
            [self.commitBnt setTitle:@"购买超值流量卡" forState:UIControlStateNormal];
            mtitle.text = @"剩余流量不足，建议追加流量包，每M流量最多节省50%费用。";
            mtitle.textAlignment = UITextAlignmentLeft ;
        }else {
            self.flowStatus = 0;
            [self.commitBnt setTitle:@"剩余流量可以做什么" forState:UIControlStateNormal];
            mtitle.text = @"剩余流量充足，请放心使用。";
        }
        
    }
}

-(void)onQryUnSuccess:(NSError *)engineError
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

- (void) setText
{
    
}


@end
