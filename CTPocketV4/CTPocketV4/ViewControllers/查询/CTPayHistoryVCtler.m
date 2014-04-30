//
//  CTPayHistoryVCtler.m
//  CTPocketV4
//
//  Created by Mac-Eshore-01 on 13-11-5.
//  Copyright (c) 2013年 广东亿迅科技有限公司. All rights reserved.
//  历史账单

#import "CTPayHistoryVCtler.h"
#import "UIView+RoundRect.h"
#import "AppDelegate.h"
#import "CserviceEngine.h"
#import "SIAlertView.h"
#import "NSDate+Extensions.h"
#import "SVProgressHUD.h"
#import "CTRechargeVCtler.h"
#import "ToastAlertView.h"

#define kTagContentView  7890
#define kTagBtn_PreMonth 7891
#define kTagBtn_NxtMonth 7892
#define kTagBtn_CurMonth 7893

#define kTag_cntImage_01 8893
#define kTag_cntlabel_01 8894
#define kTag_cntImage_02 8895
#define kTag_cntlabel_02 8896

#define kTag_tiplabel    8897

@interface CTPayHistoryVCtler ()
@property (strong, nonatomic)CserviceOperation *_QryOperation01;
@property (strong, nonatomic)CserviceOperation *_QryOperation02;
@property (nonatomic, strong) UIView *testView;
-(void)setMonthLabs:(id)sender;
-(void)OnPreMonthAction:(id)sender;
-(void)OnNxtMonthAction:(id)sender;
-(BOOL)checkMonth:(NSDate*)month;
-(void)onChargeBtnAction:(id)sender;
@end

@implementation CTPayHistoryVCtler

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
    self.title = @"历史话费";
	// 左按钮
    [self setLeftButton:[UIImage imageNamed:@"btn_back"]];
	// Do any additional setup after loading the view.
    
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    scrollView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:scrollView];
    
    {
        UILabel* mtitle = [[UILabel alloc] initWithFrame:CGRectMake(10,15,300,22)];
        mtitle.backgroundColor = [UIColor clearColor];
        mtitle.font     = [UIFont systemFontOfSize:14];
        mtitle.textColor= [UIColor blackColor];
        {
            NSDictionary* logindict= [Global sharedInstance].loginInfoDict;
            NSString *PhoneNum = logindict[@"UserLoginName"] ? logindict[@"UserLoginName"] : @"";
            mtitle.text = [NSString stringWithFormat:@"查询号码：%@",PhoneNum];
        }
        [scrollView addSubview:mtitle];
    }

    {
        // div line
        UIImageView* divLine = [[UIImageView alloc] initWithFrame:CGRectMake(0,48, 320, 1)];
        divLine.image = [UIImage imageNamed:@"recharge_horline_bg.png"];
        [scrollView addSubview:divLine];
    }

    
    {
        float yval = 58;
        UIView* cntView = [[UIView alloc] initWithFrame:CGRectMake(0,yval,320, 215)];
        cntView.tag     = kTagContentView;
        self.testView = cntView ;
        cntView.backgroundColor = [UIColor clearColor];
        [scrollView addSubview:cntView];
        {
            {
                UIImageView* imgview01 = [[UIImageView alloc] init];
                imgview01.tag   = kTag_cntImage_01;
                imgview01.frame = CGRectMake(75,cntView.frame.size.height,36,0);
                [cntView addSubview:imgview01];
                
                UILabel* mtitle = [[UILabel alloc] initWithFrame:CGRectMake(imgview01.frame.origin.x-30,
                                                                            imgview01.frame.origin.y-30,
                                                                            imgview01.frame.size.width + 60,22)];
                mtitle.backgroundColor = [UIColor clearColor];
                mtitle.tag      = kTag_cntlabel_01;
                mtitle.font     = [UIFont systemFontOfSize:14];
                mtitle.textColor= [UIColor blackColor];/*[UIColor colorWithRed:39.0/255
                                                  green:39.0/255
                                                   blue:39.0/255
                                                  alpha:1];*/
                mtitle.textAlignment = UITextAlignmentCenter;
                mtitle.text     = @"";
                [cntView addSubview:mtitle];
            }
            
            {
                UIImageView* imgview02 = [[UIImageView alloc] init];
                imgview02.tag   = kTag_cntImage_02;
                imgview02.frame = CGRectMake(205,cntView.frame.size.height,36,0);
                [cntView addSubview:imgview02];
                
                UILabel* mtitle = [[UILabel alloc] initWithFrame:CGRectMake(imgview02.frame.origin.x-30,
                                                                            imgview02.frame.origin.y-30,
                                                                            imgview02.frame.size.width + 60,22)];
                mtitle.tag      = kTag_cntlabel_02;
                mtitle.backgroundColor = [UIColor clearColor];
                mtitle.font     = [UIFont systemFontOfSize:14];
                mtitle.textColor= [UIColor blackColor];/*[UIColor colorWithRed:39.0/255
                                                  green:39.0/255
                                                   blue:39.0/255
                                                  alpha:1];*/
                mtitle.textAlignment = UITextAlignmentCenter;
                mtitle.text     = @"";
                [cntView addSubview:mtitle];
            }
        }
        
        // 覆盖的月份浮标
        UIButton *firstMonth = [UIButton buttonWithType:UIButtonTypeCustom];
        firstMonth.tag   = kTagBtn_PreMonth;
        firstMonth.frame = CGRectMake(0,yval+5,80,36);
        [firstMonth setBackgroundImage:[UIImage imageNamed:@"his_mth_01.png"]
                          forState:UIControlStateNormal];
        [firstMonth setTitle:@"" forState:UIControlStateNormal];
        [firstMonth setTitleColor:[UIColor whiteColor]
                     forState:UIControlStateNormal];
        [firstMonth.titleLabel setFont:[UIFont boldSystemFontOfSize:22]];
        [firstMonth addTarget:self
                       action:@selector(OnPreMonthAction:)
             forControlEvents:UIControlEventTouchUpInside];
        [scrollView addSubview:firstMonth];
        
        UILabel* centerMonth = [[UILabel alloc] initWithFrame:CGRectMake(80,yval+12,160,22)];
        centerMonth.tag      = kTagBtn_CurMonth;
        centerMonth.backgroundColor = [UIColor clearColor];
        centerMonth.font     = [UIFont boldSystemFontOfSize:/*22*/18];
        centerMonth.textColor= [UIColor colorWithRed:127/255. green:204/255. blue:71/255. alpha:1];//[UIColor colorWithRed:0.44 green:0.77 blue:0.22 alpha:1.00];   // modified by zy
        centerMonth.textAlignment = UITextAlignmentCenter;
        centerMonth.text = @"";
        [scrollView addSubview:centerMonth];
        
        //
        UIButton *lastMonth = [UIButton buttonWithType:UIButtonTypeCustom];
        lastMonth.tag   = kTagBtn_NxtMonth;
        lastMonth.frame = CGRectMake(240,yval+5,80,36);
        [lastMonth setBackgroundImage:[UIImage imageNamed:@"his_mth_02.png"]
                          forState:UIControlStateNormal];
        [lastMonth setTitle:@"" forState:UIControlStateNormal];
        [lastMonth addTarget:self
                       action:@selector(OnNxtMonthAction:)
             forControlEvents:UIControlEventTouchUpInside];
        [lastMonth setTitleColor:[UIColor whiteColor]
                         forState:UIControlStateNormal];
        [lastMonth.titleLabel setFont:[UIFont boldSystemFontOfSize:22]];
        [scrollView addSubview:lastMonth];
    }
    
    {
        // div line
        UIImageView* divLine = [[UIImageView alloc] initWithFrame:CGRectMake(0,273, 320, 1)];
        divLine.image = [UIImage imageNamed:@"recharge_horline_bg.png"];
        [scrollView addSubview:divLine];
    }
    
    {
        UILabel* mtitle = [[UILabel alloc] initWithFrame:CGRectMake(20,275,280,40)];
        mtitle.backgroundColor = [UIColor clearColor];
        mtitle.tag      = kTag_tiplabel;
        mtitle.numberOfLines   = 2;
        mtitle.font     = [UIFont systemFontOfSize:12];
        mtitle.textColor= [UIColor blackColor];/*[UIColor colorWithRed:39.0/255
                                          green:39.0/255
                                           blue:39.0/255
                                          alpha:1];*/
        mtitle.text     = @"";//@"9月话费比上月增加12元，请留意套餐使用情况，并及时充值。";
        [scrollView addSubview:mtitle];

        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(20,322,280,36);
        [button setBackgroundImage:[[UIImage imageNamed:@"common_alert_button.png"] stretchableImageWithLeftCapWidth:12 topCapHeight:12]
                          forState:UIControlStateNormal];
        [button dwMakeRoundCornerWithRadius:3];
        [button setTitle:@"充值" forState:UIControlStateNormal];
        [button addTarget:self
                   action:@selector(onChargeBtnAction:)
         forControlEvents:UIControlEventTouchUpInside];
        [scrollView addSubview:button];
    }
//    float ypos = 0;
    {
        UILabel *tipLab = [[UILabel alloc] initWithFrame:CGRectMake(20, 10+322+36,290 , 30)];
        tipLab.font = [UIFont systemFontOfSize:12];
        tipLab.textColor = [UIColor colorWithRed:(9*16+6)/255. green:(9*16+5)/255. blue:(9*16+5)/255. alpha:1];
        tipLab.backgroundColor = [UIColor clearColor];
        tipLab.text = @"注：每月1-5日部分查询数据有所偏差，以致电10000号或当地营业厅的查询结果为准。";
        tipLab.numberOfLines = 0;
        [tipLab sizeToFit];
        [scrollView addSubview:tipLab];
//        ypos = CGRectGetMaxY(tipLab.frame)+10;
    }
    
    scrollView.contentSize = CGSizeMake(self.view.bounds.size.width,520);
    // datas
    _monthPare = [[NSMutableArray alloc] initWithCapacity:2];
    {
        [self setMonthLabs:nil];
        NSCalendar * calendar    = [NSCalendar currentCalendar];
        NSDateComponents * comps = [[NSDateComponents alloc] init];
        [comps setMonth:-1];
        NSDate * newDate         = [calendar dateByAddingComponents:comps toDate:[NSDate date] options:0];
        NSDateFormatter * df     = [NSDateFormatter new];
        [df setDateFormat:@"yyyyMM"];
        NSString * month  = [df stringFromDate:newDate];
        [comps setMonth:-2];
        newDate           = [calendar dateByAddingComponents:comps toDate:[NSDate date] options:0];
        NSString * other  = [df stringFromDate:newDate];
        NSLog(@"months = :%@,%@",month,other);
        [self queryHistoryBilling:month other:other];
    }
    
    // 左右滑动手势
    {
        UISwipeGestureRecognizer *recognizer1 = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleRecognizer:)];
        [recognizer1 setDirection:UISwipeGestureRecognizerDirectionLeft];
        [self.testView addGestureRecognizer:recognizer1];
        UISwipeGestureRecognizer *recognizer2 = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleRecognizer:)];
        [recognizer2 setDirection:UISwipeGestureRecognizerDirectionRight];
        [self.testView addGestureRecognizer:recognizer2];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)queryHistoryBilling:(NSString*)month  other:(NSString*)other
{
    [_monthPare removeAllObjects];
    
    NSMutableDictionary* firstMonth = [[NSMutableDictionary alloc] init];
    [firstMonth setObject:month forKey:@"month"];
    [_monthPare addObject:firstMonth];

    NSMutableDictionary* secMonth = [[NSMutableDictionary alloc] init];
    [secMonth setObject:other forKey:@"month"];
    [_monthPare addObject:secMonth];
    
    NSDictionary* logindict= [Global sharedInstance].loginInfoDict;
    NSString *PhoneNum = logindict[@"UserLoginName"] ? logindict[@"UserLoginName"] : @"";
    
    NSDictionary *params   = [NSDictionary dictionaryWithObjectsAndKeys:
                              PhoneNum,@"PhoneNum",
                              month,@"Month",
                              nil];
    NSDictionary *params1   = [NSDictionary dictionaryWithObjectsAndKeys:
                               PhoneNum,@"PhoneNum",
                               other,@"Month",
                               nil];
    [SVProgressHUD showWithStatus:@"请稍候..." maskType:SVProgressHUDMaskTypeGradient];
    {
        self._QryOperation01   =
        [MyAppDelegate.cserviceEngine postXMLWithCode:@"queryBillInfoAll"
                                                                    params:params
                                                               onSucceeded:^(NSDictionary *dict){
                                                                   [self onFirstMonthDataBack:dict];
                                                                   [SVProgressHUD dismiss];
                                                               } onError:^(NSError *engineError){
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
                                                                       [self showToastView:@"网络繁忙,请稍后再试"];
                                                                   }
                                                               }];
    }
    {
        self._QryOperation02   =
        [MyAppDelegate.cserviceEngine postXMLWithCode:@"queryBillInfoAll"
                                               params:params1
                                          onSucceeded:^(NSDictionary *dict) {
                                              [self onSecondMonthDataBack:dict];
                                              [SVProgressHUD dismiss];
                                          } onError:^(NSError *engineError) {
                                              DDLogInfo(@"%s--%@", __func__, engineError);
//                                              [self onQryUnSuccess:engineError];
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
                                                  [self showToastView:@"网络繁忙,请稍后再试"];
                                              }
                                          }];
    }

}

- (void) showToastView : (NSString *) message
{
    ToastAlertView *alert = [ToastAlertView new];
    [alert showAlertMsg:message];
}

-(void)setMonthLabs:(id)sender
{
    UIButton* btn_pre = (UIButton*)[self.view viewWithTag:kTagBtn_PreMonth];
    UILabel*  lab_cur = (UILabel*)[self.view viewWithTag:kTagBtn_CurMonth];
    UIButton* btn_nxt = (UIButton*)[self.view viewWithTag:kTagBtn_NxtMonth];
    
    NSCalendar * calendar    = [NSCalendar currentCalendar];
    NSDateComponents * comps = [[NSDateComponents alloc] init];
    if (sender == NULL)
    {
        NSDate * newDate     = [calendar dateByAddingComponents:comps toDate:[NSDate date] options:0];
        NSDateFormatter * df = [NSDateFormatter new];
        [df setDateFormat:@"MM月"];
        // 左边
        [btn_nxt setTitle:[df stringFromDate:newDate]
                 forState:UIControlStateNormal];
        [btn_nxt setEnabled:NO];
        
        // 中间
        [comps setMonth:-1];
        newDate           = [calendar dateByAddingComponents:comps toDate:[NSDate date] options:0];
        [df setDateFormat:@"yyyy年MM月"];
        lab_cur.text      = [df stringFromDate:newDate];
        // 右边
        [comps setMonth:-2];
        [df setDateFormat:@"MM月"];
        newDate           = [calendar dateByAddingComponents:comps toDate:[NSDate date] options:0];
        [btn_pre setTitle:[df stringFromDate:newDate]
                 forState:UIControlStateNormal];
    }else
    {
        NSDate*  date     = (NSDate*)sender;
        NSDate * newDate  = [calendar dateByAddingComponents:comps toDate:date options:0];
        NSDateFormatter * df= [NSDateFormatter new];
        [df setDateFormat:@"MM月"];
        // 左边
        [btn_nxt setTitle:[df stringFromDate:newDate]
                 forState:UIControlStateNormal];
        if (NO == [self checkMonth:newDate])
        {
            [btn_nxt setEnabled:NO];
        }else
        {
            [btn_nxt setEnabled:YES];
        }

        // 中间
        [comps setMonth:-1];
        newDate           = [calendar dateByAddingComponents:comps toDate:date options:0];
        [df setDateFormat:@"yyyy年MM月"];
        lab_cur.text      = [df stringFromDate:newDate];
        // 右边
        [comps setMonth:-2];
        [df setDateFormat:@"MM月"];
        newDate           = [calendar dateByAddingComponents:comps toDate:date options:0];
        [btn_pre setTitle:[df stringFromDate:newDate]
                 forState:UIControlStateNormal];
        
        if (NO == [self checkMonth:newDate])
        {
            [btn_pre setEnabled:NO];
            NSLog(@"小于前6个月，不让用户点击.");
        }else
        {
            [btn_pre setEnabled:YES];
        }
    }
}


-(void)OnPreMonthAction:(id)sender
{
    UILabel*  lab_cur = (UILabel*)[self.view viewWithTag:kTagBtn_CurMonth];
    NSString* strmont = lab_cur.text;
    
    NSDateFormatter * df= [NSDateFormatter new];
    [df setDateFormat:@"yyyy年MM月"];
    NSDate*   date = [df dateFromString:strmont];
    [self setMonthLabs:date];
    
    // 计算将要请求的月份
    NSString* month = @"";
    NSString* other = @"";
    [df setDateFormat:@"yyyyMM"];
    NSCalendar * calendar    = [NSCalendar currentCalendar];
    NSDateComponents * comps = [[NSDateComponents alloc] init];
    [comps setMonth:-1];
    NSDate* lastMonth = [calendar dateByAddingComponents:comps toDate:date options:0];
    month = [df stringFromDate:lastMonth];
    
    [comps setMonth:-2];
    NSDate* llstMonth = [calendar dateByAddingComponents:comps toDate:date options:0];
    other = [df stringFromDate:llstMonth];

    [self queryHistoryBilling:month other:other];
}


-(void)OnNxtMonthAction:(id)sender
{    
    UILabel*  lab_cur = (UILabel*)[self.view viewWithTag:kTagBtn_CurMonth];
    NSString* strmont = lab_cur.text;

    NSCalendar * calendar    = [NSCalendar currentCalendar];
    NSDateComponents * comps = [[NSDateComponents alloc] init];
    NSDateFormatter * df= [NSDateFormatter new];
    {
        [df setDateFormat:@"yyyy年MM月"];
        NSDate*   date = [df dateFromString:strmont];
        
        [comps setMonth:2];
        date = [calendar dateByAddingComponents:comps toDate:date options:0];
        [self setMonthLabs:date];
    }

    // 计算将要请求的月份
    NSString* month = @"";
    NSString* other = @"";
    {
        [df setDateFormat:@"yyyy年MM月"];
        NSDate*   date = [df dateFromString:strmont];
        [df setDateFormat:@"yyyyMM"];
        month  = [df stringFromDate:date];
        
        [comps setMonth:1];
        date = [calendar dateByAddingComponents:comps toDate:date options:0];
        other  = [df stringFromDate:date];

        [self queryHistoryBilling:other other:month];
    }
}


-(BOOL)checkMonth:(NSDate*)month
{
    NSDate* today = [NSDate date];
    
    unsigned int unitFlags = NSMonthCalendarUnit | NSDayCalendarUnit;
    NSCalendar * calendar  = [NSCalendar currentCalendar];
    
    if ([today isEarlierThanDate:month])
    {
        // 如果大于或者等于当前月
        return  NO;
    }else
    {
        // 如果小于前6个月，则提示智能查前6个月
        NSDateComponents *comps  = [calendar components:unitFlags fromDate:month  toDate:today  options:0];
        int months = [comps month];
        if(months == 0)
        {
            return NO;
        }else if (months > 6)
        {
            return  NO;
        }
    }
    
    return YES;
}

-(void)onFirstMonthDataBack:(NSDictionary*)dict{
    NSMutableDictionary* firstMonth = [_monthPare objectAtIndex:0];
    if (firstMonth)
    {
        NSDictionary*  data= (NSDictionary*)[dict objectForKey:@"Data"];
        NSString* valstr   = [data objectForKey:@"SumCharge"]?[data objectForKey:@"SumCharge"]:@"";
        [firstMonth setObject:valstr forKey:@"value"];
    }
    [self resetCntVIew];
}

-(void)onSecondMonthDataBack:(NSDictionary*)dict{
    NSMutableDictionary* secondMonth = [_monthPare objectAtIndex:1];
    if (secondMonth) {
        NSDictionary*  data= (NSDictionary*)[dict objectForKey:@"Data"];
        NSString* valstr   = [data objectForKey:@"SumCharge"]?[data objectForKey:@"SumCharge"]:@"";
        [secondMonth setObject:valstr forKey:@"value"];
    }
    [self resetCntVIew];
}

-(void)onChargeBtnAction:(id)sender
{
    UINavigationController *nar =  MyAppDelegate.tabBarController.viewControllers[2] ;
    CTRechargeVCtler *vc =  (CTRechargeVCtler *)nar.topViewController ;
    [vc pageIndex:0];
    MyAppDelegate.tabBarController.selectedIndex = 2;
}

-(void)resetCntVIew
{
    NSMutableDictionary* firstMonth  = [_monthPare objectAtIndex:0];
    NSMutableDictionary* secondMonth = [_monthPare objectAtIndex:1];
    
    CGFloat val_month1   = 0;
    CGFloat val_month2   = 0;
        
    do
    {
        if ([NSNull null] != [firstMonth objectForKey:@"value"]) {
            val_month1 = [[firstMonth objectForKey:@"value"] floatValue];
        }
        
        if ([NSNull null] != [secondMonth objectForKey:@"value"]) {
            val_month2 = [[secondMonth objectForKey:@"value"] floatValue];
        }
    } while (0);
        
    UIView* cntView = [self.view viewWithTag:kTagContentView];
    if (!cntView) {
        return;
    }
    
    //@"9月话费比上月增加12元，请留意套餐使用情况，并及时充值。";
    UILabel *labTip      = (UILabel*)[self.view viewWithTag:kTag_tiplabel];
    if (labTip) {
        NSString* mont1  = [firstMonth objectForKey:@"month"];
//        NSString* mont2  = [secondMonth objectForKey:@"month"];
        NSString* att    = val_month1 > val_month2 ? @"增加":@"减少";
#if 0   // modified by zy, 2014-02-19
        labTip.text = [NSString stringWithFormat:@"%@月话费比%@月%@%0.1f元，请留意套餐使用情况，并及时充值。",
                       mont1,mont2,att,fabs((val_month1-val_month2))];
#else
        if (mont1.length >= 6)
        {
            mont1 = [mont1 substringFromIndex:4];
        }
        labTip.text = [NSString stringWithFormat:@"%d月话费比上月%@%0.1f元，请留意套餐使用情况，并及时充值。",
                       [mont1 intValue],att,fabs((val_month1-val_month2))];
#endif
    }
    
    // 定义坐标系及柱状图高度比例
    CGFloat max = MAX(val_month1,val_month2);
    max += 100;
    
    CGFloat rate01 = val_month2/max;
    CGFloat rate02 = val_month1/max;
    
    CGFloat height01 = rate01 * (cntView.frame.size.height-50);
    CGFloat height02 = rate02 * (cntView.frame.size.height-50);

    UIImageView* imgview01 = (UIImageView*)[cntView viewWithTag:kTag_cntImage_01];
    UIImageView* imgview02 = (UIImageView*)[cntView viewWithTag:kTag_cntImage_02];
    UILabel* mtitle1 = (UILabel*)[cntView viewWithTag:kTag_cntlabel_01];
    UILabel* mtitle2 = (UILabel*)[cntView viewWithTag:kTag_cntlabel_02];
    
    [UIView beginAnimations:@"nil" context:nil];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView animateWithDuration:0.35 animations:^(void){
        {
            UIImage* img    = [UIImage imageNamed:@"his_vgrd.png"];//(height01<height02 ? [UIImage imageNamed:@"his_vgrd.png"] : [UIImage imageNamed:@"his_vred.png"]);
            imgview01.image = [img resizableImageWithCapInsets:UIEdgeInsetsMake(img.size.height-1,
                                                                                img.size.width/2,
                                                                                1,
                                                                                img.size.width/2)];
            imgview01.frame = CGRectMake(75,cntView.frame.size.height-height01,36,height01);
            mtitle1.text    = [NSString stringWithFormat:@"%0.2f元",val_month2];
            mtitle1.frame   = CGRectMake(imgview01.frame.origin.x-30,
                                         imgview01.frame.origin.y-30,
                                         imgview01.frame.size.width + 60,22);
        }
        
        {
            UIImage* img    = [UIImage imageNamed:@"his_vred.png"];//(height01>height02 ? [UIImage imageNamed:@"his_vgrd.png"] : [UIImage imageNamed:@"his_vred.png"]);
            imgview02.image = [img resizableImageWithCapInsets:UIEdgeInsetsMake(img.size.height-1,
                                                                                img.size.width/2,
                                                                                1,
                                                                                img.size.width/2)];
            imgview02.frame = CGRectMake(205,cntView.frame.size.height-height02,36,height02);
            mtitle2.text    = [NSString stringWithFormat:@"%0.2f元",val_month1];
            mtitle2.frame   = CGRectMake(imgview02.frame.origin.x-30,
                                         imgview02.frame.origin.y-30,
                                         imgview02.frame.size.width + 60,22);
        }
    }];
    [UIView commitAnimations];
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

- (void)handleRecognizer:(UISwipeGestureRecognizer *)recognizer
{
    if (recognizer.direction == UISwipeGestureRecognizerDirectionLeft)
    {
        UIButton* btn_nxt = (UIButton*)[self.view viewWithTag:kTagBtn_NxtMonth];
        if (btn_nxt.enabled)
        {
            [self OnNxtMonthAction:nil];
        }
    }
    else if (recognizer.direction == UISwipeGestureRecognizerDirectionRight)
    {
        UIButton* btn_pre = (UIButton*)[self.view viewWithTag:kTagBtn_PreMonth];
        if (btn_pre.enabled)
        {
            [self OnPreMonthAction:nil];
        }
    }
}

@end
