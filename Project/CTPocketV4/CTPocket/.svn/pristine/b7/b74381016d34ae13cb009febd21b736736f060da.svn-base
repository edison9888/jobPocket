/*--------------------------------------------
 *Name：CTgrChangeVCtler
 *Desc：套餐变更
 *Date：2014/07/03
 *Auth：lip
 *--------------------------------------------*/

#import "CTgrChangeVCtler.h"
#import "AppDelegate.h"

@interface CTgrChangeVCtler ()

@end

@implementation CTgrChangeVCtler
{
    UITCCell *cellFlow,*cellVoice,*cellSms;
    UILabel *labMsg2,*labPhone2,*labFlow2,*labTipCost;
    NSDictionary *dicData;
    double curCost;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // 标题
        self.title = @"套餐变更";
        // 左按钮
        [self setLeftButton:[UIImage imageNamed:@"btn_back"]];

    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onHideKeyboardTap)];
    tapGesture.cancelsTouchesInView = NO;
    [self.view addGestureRecognizer:tapGesture];
    
    [SVProgressHUD showWithStatus:@"请稍候..."];
    __weak id weakSelf = self;
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
                            BUSSINESS_SHOPID, @"ShopId",
                            [Global sharedInstance].loginInfoDict[@"UserLoginName"], @"Account",
                            @"1",@"Querycombo",
                            @"0", @"QueryType",nil];
    
	[MyAppDelegate.cserviceEngine postXMLWithCode:@"grComboInfo"
                                           params:params
                                      onSucceeded:^(NSDictionary *dict)
    {
        [SVProgressHUD dismiss];
        dicData = dict;
        [weakSelf initControl];
    } onError:^(NSError *engineError) {
        [SVProgressHUD dismiss];
        NSString *msg = engineError.userInfo[@"NSLocalizedDescription"];
        msg = msg ? msg:@"数据加载失败！";
        ToastAlertView *alert = [ToastAlertView new];
        [alert showAlertMsg:msg];
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/**
 *  绘制界面
 */
-(void)initControl
{
    NSDictionary *useComboInfo = dicData[@"Data"][@"UserComboInfo"];
    NSDictionary *smsConfig = dicData[@"Data"][@"ComboConfig"][@"SmsConfig"];
    NSDictionary *voiceConfig = dicData[@"Data"][@"ComboConfig"][@"VoiceConfig"];
    NSDictionary *flowConfig = dicData[@"Data"][@"ComboConfig"][@"FlowConfig"];
    curCost = [useComboInfo[@"ComboInfo"] doubleValue];
    
    CGSize mainSize = [UIScreen mainScreen].bounds.size;
    
    CGFloat spitW = 15,top=5,footH=150,labH = 23;
    CGFloat cx =0,cy=0;
    
    UIScrollView *scroll = [[UIScrollView alloc]initWithFrame:
                            CGRectMake(cx, cy, mainSize.width, mainSize.height-50-64)];
    //scroll.layer.borderWidth = 1;
    [self.view addSubview:scroll];
    
    UIView *tipView = [[UIView alloc]initWithFrame:CGRectMake(0, 10, 5, 28)];
    tipView.backgroundColor = RGB(111,197,55,1);
    [scroll addSubview:tipView];
    
    cx = spitW;
    cy = top;
    UILabel *labMonth = [self createLab];
    labMonth.frame = CGRectMake(cx, cy, 112, labH);
    labMonth.text = @"现有套餐月消费：";
    [scroll addSubview:labMonth];
    cx = CGRectGetMaxX(labMonth.frame);
    
    UILabel *labMonthCost = [self createLab];
    labMonthCost.text = useComboInfo[@"ComboInfo"];
    labMonthCost.textColor = RGB(115, 193, 69, 1);
    labMonthCost.font = [UIFont boldSystemFontOfSize:16];
    CGFloat tempW = [Utils widthForString:labMonthCost.text font:labMonthCost.font];
    labMonthCost.frame = CGRectMake(cx, cy, tempW, labH);
    [scroll addSubview:labMonthCost];
    cx = CGRectGetMaxX(labMonthCost.frame);
    
    UILabel *labYuan = [self createLab];
    labYuan.text = @"元";
    labYuan.frame = CGRectMake(cx, cy, 15, labH);
    [scroll addSubview:labYuan];
    
    cx = spitW;
    cy = CGRectGetMaxY(labMonth.frame);
    UILabel *labTC = [self createLab];
    labTC.text = @"套餐内容：";
    labTC.frame = CGRectMake(cx, cy, 70, labH);
    [scroll addSubview:labTC];
    cx = CGRectGetMaxX(labTC.frame);
    
    CGFloat iconWH = 20;
    UIImageView *iconPhone = [[UIImageView alloc]initWithFrame:CGRectMake(cx, cy+(labH-iconWH)/2, iconWH, iconWH)];
    iconPhone.backgroundColor = RGB(115, 193, 69, 1);
    [scroll addSubview:iconPhone];
    cx = CGRectGetMaxX(iconPhone.frame)+3;
    
    UILabel *labPhone = [self createLab];
    labPhone.text = [NSString stringWithFormat:@"%@分钟",useComboInfo[@"VoiceCount"]];
    tempW = [Utils widthForString:labPhone.text font:labPhone.font];
    labPhone.frame = CGRectMake(cx, cy, tempW, labH);
    [scroll addSubview:labPhone];
    cx = CGRectGetMaxX(labPhone.frame)+10;
    
    UIImageView *iconMsg = [[UIImageView alloc]initWithFrame:CGRectMake(cx, cy+(labH-iconWH)/2, iconWH, iconWH)];
    iconMsg.backgroundColor = RGB(115, 193, 69, 1);
    [scroll addSubview:iconMsg];
    cx = CGRectGetMaxX(iconMsg.frame)+3;
    
    UILabel *labMsg = [self createLab];
    labMsg.text = [NSString stringWithFormat:@"%@条",useComboInfo[@"SmsCount"]];
    tempW = [Utils widthForString:labMsg.text font:labMsg.font];
    labMsg.frame = CGRectMake(cx, cy, tempW, labH);
    [scroll addSubview:labMsg];
    cx = CGRectGetMaxX(labMsg.frame)+10;
    
    UIImageView *iconFlow = [[UIImageView alloc]initWithFrame:CGRectMake(cx, cy+(labH-iconWH)/2, iconWH, iconWH)];
    iconFlow.backgroundColor = RGB(115, 193, 69, 1);
    [scroll addSubview:iconFlow];
    cx = CGRectGetMaxX(iconFlow.frame)+3;
    
    UILabel *labFlow = [self createLab];
    labFlow.text = [NSString stringWithFormat:@"%@M",useComboInfo[@"FlowCount"]];
    tempW = [Utils widthForString:labFlow.text font:labFlow.font];
    labFlow.frame = CGRectMake(cx, cy, tempW, labH);
    [scroll addSubview:labFlow];
    
    cx = spitW;
    cy = CGRectGetMaxY(labTC.frame);
    UILabel *labTipTC = [self createLab];
    labTipTC.text = @"重新定制套餐，新套餐将于下月生效";
    labTipTC.frame = CGRectMake(cx, cy, mainSize.width-spitW*2, labH);
    [scroll addSubview:labTipTC];
    
    cx = spitW;
    cy = CGRectGetMaxY(labTipTC.frame)+10;
    cellFlow = [[UITCCell alloc]initWithPoint:CGPointMake(0, cy)];
    cellFlow.title = @"流量";
    cellFlow.minValue = 0;
    cellFlow.maxValue = [flowConfig[@"MaxValue"] integerValue];
    cellFlow.cvalue = [useComboInfo[@"FlowCount"] integerValue];
    cellFlow.unitPrice = [flowConfig[@"UnitPrice"] doubleValue];
    cellFlow.unitTile = @"M";
    cellFlow.index = 1;
    cellFlow.delegate = self;
    [scroll addSubview:cellFlow];
    cy = CGRectGetMaxY(cellFlow.frame)-1;
    
    cellVoice = [[UITCCell alloc]initWithPoint:CGPointMake(0, cy)];
    cellVoice.title = @"语音";
    cellVoice.minValue = 0;
    cellVoice.maxValue = [voiceConfig[@"MaxValue"] integerValue];
    cellVoice.cvalue = [useComboInfo[@"VoiceCount"] integerValue];
    cellVoice.unitPrice = [voiceConfig[@"UnitPrice"] doubleValue];
    cellVoice.unitTile = @"分钟";
    cellVoice.index = 2;
    cellVoice.delegate = self;
    [scroll addSubview:cellVoice];
    cy = CGRectGetMaxY(cellVoice.frame)-1;
    
    cellSms = [[UITCCell alloc]initWithPoint:CGPointMake(0, cy)];
    cellSms.title = @"短信";
    cellSms.minValue = 0;
    cellSms.maxValue = [smsConfig[@"MaxValue"] integerValue];
    cellSms.cvalue = [useComboInfo[@"SmsCount"] integerValue];
    cellSms.unitPrice = [smsConfig[@"UnitPrice"] doubleValue];
    cellSms.unitTile = @"条";
    cellSms.index = 3;
    cellSms.delegate = self;
    [scroll addSubview:cellSms];
    cy = CGRectGetMaxY(cellSms.frame)+10;
    
    CGFloat labw = mainSize.width-spitW*2;
    UILabel *labTip = [self createLab];
    labTip.font = [UIFont systemFontOfSize:12];
    labTip.numberOfLines = 0;
    labTip.text = @"温馨提示：此套餐每月最低消费20元，激活生效次月，将每月返还27.36元话费，可返还24个月，最多可返3000元。";
    CGFloat tempH = [Utils heightForString:labTip.text font:labTip.font andWidth:labw];
    labTip.frame = CGRectMake(cx, cy, labw, tempH);
    [scroll addSubview:labTip];
    cy = CGRectGetMaxY(labTip.frame);
    
    scroll.contentSize = CGSizeMake(0, cy+footH+10);
    
    
    /**********************************footView*******************************************/
    cx = 0;
    cy = mainSize.height-footH-50-64;
    UIView *footV = [[UIView alloc]initWithFrame:CGRectMake(cx, cy, mainSize.width, footH)];
    footV.backgroundColor = [RGB(240, 240, 240, 1) colorWithAlphaComponent:0.9];
    [self.view addSubview:footV];
    //footV.layer.borderWidth = 1;
    
    cx = spitW;
    cy = 0;
    UILabel *labPackage = [self createLab];
    labPackage.font = [UIFont boldSystemFontOfSize:13];
    labPackage.text = @"已选组合";
    labPackage.frame = CGRectMake(cx, cy, 60, labH);
    [footV addSubview:labPackage];
    
    cx = spitW;
    cy = CGRectGetMaxY(labPackage.frame)+5;
    CGFloat labW2 = 70;
    UIImageView *iconPhone2 = [[UIImageView alloc]initWithFrame:CGRectMake(cx, cy+(labH-iconWH)/2, iconWH, iconWH)];
    iconPhone2.backgroundColor = RGB(115, 193, 69, 1);
    [footV addSubview:iconPhone2];
    cx = CGRectGetMaxX(iconPhone2.frame)+3;
    
    labPhone2 = [self createLab];
    labPhone2.text = @"50分钟";
    labPhone2.frame = CGRectMake(cx, cy, labW2, labH);
    [footV addSubview:labPhone2];
    cx = CGRectGetMaxX(labPhone2.frame)+10;
    
    UIImageView *iconMsg2 = [[UIImageView alloc]initWithFrame:
                             CGRectMake(cx, cy+(labH-iconWH)/2, iconWH, iconWH)];
    iconMsg2.backgroundColor = RGB(115, 193, 69, 1);
    [footV addSubview:iconMsg2];
    cx = CGRectGetMaxX(iconMsg2.frame)+3;
    
    labMsg2 = [self createLab];
    labMsg2.text = @"50条";
    labMsg2.frame = CGRectMake(cx, cy, labW2, labH);
    [footV addSubview:labMsg2];
    cx = CGRectGetMaxX(labMsg2.frame)+10;
    
    UIImageView *iconFlow2 = [[UIImageView alloc]initWithFrame:
                              CGRectMake(cx, cy+(labH-iconWH)/2, iconWH, iconWH)];
    iconFlow2.backgroundColor = RGB(115, 193, 69, 1);
    [footV addSubview:iconFlow2];
    cx = CGRectGetMaxX(iconFlow2.frame)+3;
    
    labFlow2 = [self createLab];
    labFlow2.text = @"1G";
    labFlow2.frame = CGRectMake(cx, cy, labW2, labH);
    [footV addSubview:labFlow2];
    
    labH = 18;
    cx = spitW;
    cy = CGRectGetMaxY(labFlow2.frame)+5;
    UIFont *font12 = [UIFont systemFontOfSize:12];
    UILabel *labCY = [self createLab];
    labCY.font = font12;
    labCY.text = @"次月起返还：";
    labCY.frame = CGRectMake(cx, cy, 72, labH);
    [footV addSubview:labCY];
    cx = CGRectGetMaxX(labCY.frame);
    
    UILabel *labCYValue = [self createLab];
    labCYValue.text = @"10";
    labCYValue.font = [UIFont boldSystemFontOfSize:16];
    tempW = [Utils widthForString:labCYValue.text font:labCYValue.font];
    labCYValue.frame = CGRectMake(cx, cy, tempW, labH);
    [footV addSubview:labCYValue];
    cx = CGRectGetMaxX(labCYValue.frame);
    
    UILabel *labYuan1 = [self createLab];
    labYuan1.text = @"元";
    labYuan1.font = font12;
    labYuan1.frame = CGRectMake(cx, cy, 15, labH);
    [footV addSubview:labYuan1];
    
    cx = 160;
    UILabel *labTCCost = [self createLab];
    labTCCost.font = font12;
    labTCCost.text = @"套餐月消费：";
    labTCCost.frame = CGRectMake(cx, cy, 72, labH);
    [footV addSubview:labTCCost];
    cx = CGRectGetMaxX(labTCCost.frame);
    
    UILabel *labTCCostValue = [self createLab];
    labTCCostValue.text = @"10";
    labTCCostValue.font = [UIFont boldSystemFontOfSize:16];
    tempW = [Utils widthForString:labTCCostValue.text font:labTCCostValue.font];
    labTCCostValue.frame = CGRectMake(cx, cy, tempW, labH);
    [footV addSubview:labTCCostValue];
    cx = CGRectGetMaxX(labTCCostValue.frame);

    UILabel *labYuan2 = [self createLab];
    labYuan2.text = @"元";
    labYuan2.font = font12;
    labYuan2.frame = CGRectMake(cx, cy, 15, labH);
    [footV addSubview:labYuan2];

    cx = spitW;
    cy = CGRectGetMaxY(labCY.frame);
    labTipCost = [self createLab];
    labTipCost.font = font12;
    labTipCost.textColor = RGB(120, 179, 74, 1);
    labTipCost.text = @"比现有套餐月消费减少0元";
    labTipCost.frame = CGRectMake(cx, cy, mainSize.width-spitW*2, labH);
    [footV addSubview:labTipCost];
    
    cx = spitW;
    cy = CGRectGetMaxY(labTipCost.frame)+10;
    UIButton *btnSubmit = [UIButton buttonWithType:UIButtonTypeCustom];
    [btnSubmit setBackgroundImage:[UIImage imageNamed:@"recharge_commit_btn.png"] forState:UIControlStateNormal];
    [btnSubmit setBackgroundImage:[UIImage imageNamed:@"recharge_commit_btn_hl.png"] forState:UIControlStateHighlighted];
    [btnSubmit setTitle:@"确定" forState:UIControlStateNormal];
    btnSubmit.titleLabel.font = [UIFont boldSystemFontOfSize:16];
    btnSubmit.frame = CGRectMake(cx, cy, mainSize.width-spitW*2, 37);
    [btnSubmit addTarget:self action:@selector(btnSubmit_touch) forControlEvents:UIControlEventTouchUpInside];
    [footV addSubview:btnSubmit];
    
}

-(UILabel*)createLab
{
    UILabel *lab = [[UILabel alloc]init];
    lab.font = [UIFont systemFontOfSize:14];
    lab.backgroundColor = [UIColor clearColor];
    //lab.layer.borderWidth = 1;
    return lab;
}

#pragma mark - 事件操作
- (void)onHideKeyboardTap
{
    [cellVoice resignFirstResponder];
    [cellSms resignFirstResponder];
    [cellFlow resignFirstResponder];
}

-(void)changeValue:(int)value index:(int)index
{
    switch (index) {
        case 1:
        {
            labFlow2.text = [NSString stringWithFormat:@"%dM",value];
            break;
        }
        case 2:
        {
            labPhone2.text = [NSString stringWithFormat:@"%d分钟",value];
            break;
        }
        case 3:
        {
            labMsg2.text = [NSString stringWithFormat:@"%d条",value];
            break;
        }
    }
    
    double cost = curCost - (cellVoice.cost+cellSms.cost+cellFlow.cost);
    NSString *msg = @"增加";
    if(cost > 0)
        msg = @"减少";
    labTipCost.text = [NSString stringWithFormat:@"比现有套餐月消费%@%d元",msg,abs(cost)];
}

/**
 *  提交变更套餐
 */
-(void)btnSubmit_touch
{
    SIAlertView *alertView =
    [[SIAlertView alloc] initWithTitle:@"确认变更套餐"
                            andMessage:@"您确定将定制套餐资费变更为28元/月？\n套餐包含：\n语音：30分钟，流量：1.8G\n短信：30条"];
    [alertView addButtonWithTitle:@"确定"
                             type:SIAlertViewButtonTypeDefault
                          handler:^(SIAlertView *alertView){
                              [self grChange];
                          }];
    [alertView addButtonWithTitle:@"取消"
                             type:SIAlertViewButtonTypeCancel
                          handler:nil];
    alertView.transitionStyle = SIAlertViewTransitionStyleBounce;
    [alertView show];
}

/**
 *  变更套餐
 */
-(void)grChange
{
    [SVProgressHUD showWithStatus:@"请稍候..."];
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
                            BUSSINESS_SHOPID, @"ShopId",
                            [[[Global sharedInstance] custInfoDict] objectForKey:@"UserId"],@"UserId",
                            [Global sharedInstance].loginInfoDict[@"UserLoginName"], @"Account",
                            [NSString stringWithFormat:@"%d",cellVoice.cvalue],@"Voice",
                            [NSString stringWithFormat:@"%d",cellSms.cvalue], @"Sms",
                            [NSString stringWithFormat:@"%d",cellFlow.cvalue], @"Flow",nil];
    
	[MyAppDelegate.cserviceEngine postXMLWithCode:@"grChange"
                                           params:params
                                      onSucceeded:^(NSDictionary *dict)
     {
         [SVProgressHUD dismiss];
         
     } onError:^(NSError *engineError) {
         [SVProgressHUD dismiss];
         NSString *msg = engineError.userInfo[@"NSLocalizedDescription"];
         msg = msg ? msg:@"数据加载失败！";
         ToastAlertView *alert = [ToastAlertView new];
         [alert showAlertMsg:msg];
     }];
}
@end

