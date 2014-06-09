//
//  COrderComfirmVctler.m
//  CTPocketV4
//
//  Created by Mac-Eshore-01 on 14-1-17.
//  Copyright (c) 2014年 广东亿迅科技有限公司. All rights reserved.
//

// 订单确认：

#import "COQueryVctler.h"
#import "CserviceEngine.h"
#import "AppDelegate.h"
#import "SIAlertView.h"
#import "Utils.h"


@implementation NavTabView
- (id)initWithFrame:(CGRect)frame acblock:(NavTabActionBlock)block
{
    self = [super initWithFrame:frame];
    if (self) {
        titles = [NSMutableArray new];
        _mActionBlock = block;
    }
    return self;
}

-(void)TabBtnAction:(id)sender
{
    for (UIView* tv in [self subviews])
    {
        if ([tv isKindOfClass:[UIButton class]])
        {
            [(UIButton*)tv setSelected:NO];
        }
    }
    [(UIButton*)sender setSelected:YES];
    _mActionBlock([(UIButton*)sender tag]);
}

-(void)addTabItem:(NSString*)title select:(BOOL)sel
{
    UIImage *normalimg = [[UIImage imageNamed:@"recharge_unselected_bg.png"] stretchableImageWithLeftCapWidth:30 topCapHeight:30];
    UIImage *selected  = [[UIImage imageNamed:@"recharge_selected_bg.png"] stretchableImageWithLeftCapWidth:30 topCapHeight:30];
    
    UIButton* btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectZero;
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn.titleLabel setFont:[UIFont systemFontOfSize:14]];
    if (sel) {
        [btn setSelected:YES];
    }
    [btn addTarget:self action:@selector(TabBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:btn];
    
    NSMutableArray* btnary = [NSMutableArray new];
    for (UIView* tv in [self subviews]){
        if ([tv isKindOfClass:[UIButton class]]) {
            [btnary addObject:tv];
        }
    }
    
    int count = [btnary count];
    CGFloat width = self.frame.size.width/count;
    CGFloat xval  = 0;
    int     tag   = 0;
    for (UIButton* tbtn in btnary)
    {
        tbtn.tag   =  tag++;
        tbtn.frame = CGRectMake(xval, 0, width, self.frame.size.height);
        NSLog(@"btn.frame=%@",NSStringFromCGRect(tbtn.frame));
        [btn setBackgroundImage:normalimg forState:UIControlStateNormal];
        [btn setBackgroundImage:selected  forState:UIControlStateSelected];
        xval += width;
    }
}

-(void)selAtIndex:(NSInteger)index{
    NSMutableArray* btnary = [NSMutableArray new];
    for (UIView* tv in [self subviews]){
        if ([tv isKindOfClass:[UIButton class]]) {
            [btnary addObject:tv];
        }
    }

    for (UIButton* tbtn in btnary)
    {
        if (tbtn.tag == index)
        {
            [self TabBtnAction:tbtn];
            break;
        }
    }
}

@end

#define kTagScrollview    8900  // scrollview
#define kTagLabFrameTitle 8901  // 提示
#define kTagLabTxtField01 8902  // 收货人姓名
#define kTagLabTxtField02 8903  // 收货人手机号
#define kTagInputTxtField01 8904  // 输入框1
#define kTagInputTxtField02 8905  // 输入框2


@interface COQueryVctler ()
{
    UITextField*  _activTfView;
}
-(void)onTfHidden:(id)sender;
-(void)doQuery:(id)sender;
@end

@implementation COQueryVctler

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title  = @"我的订单";
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    // 左按钮
    [self setLeftButton:[UIImage imageNamed:@"btn_back"]];
    
    self.view.backgroundColor = [UIColor colorWithRed:235/255.0
                                                green:235/255.0
                                                 blue:235/255.0
                                                alpha:1.0];

    _vcstatus = CQQ_Status_ByNetInfo;
    
    NavTabView * tabView =
    [[NavTabView alloc] initWithFrame:CGRectMake(0, 0,self.view.frame.size.width,40)
                             acblock:^(int selIndex){
                                 DLog(@"onTabselect ai Index %d",selIndex);
                                 UIScrollView* scbview = (UIScrollView*)[self.view viewWithTag:kTagScrollview];
                                 if (!scbview) {
                                     return ;
                                 }
                                 UILabel* tibTitle =  (UILabel*)[scbview viewWithTag:kTagLabFrameTitle];
                                 UILabel* labField01 =(UILabel*)[scbview viewWithTag:kTagLabTxtField01];
                                 UILabel* labField02 =(UILabel*)[scbview viewWithTag:kTagLabTxtField02];
                                 //UITextField* tf01   =(UITextField*)[scbview viewWithTag:kTagInputTxtField01];
                                 UITextField* tf02   =(UITextField*)[scbview viewWithTag:kTagInputTxtField02];
                                 if (selIndex == 0)
                                 {
                                    _vcstatus = CQQ_Status_ByNetInfo;
                                     tibTitle.text   = @"通过入网人信息查询";
                                     labField01.text = @"入网人姓名：";
                                     labField02.text = @"身份证号：";
                                     tf02.keyboardType = UIKeyboardTypeDefault;
                                 }else
                                 {
                                     _vcstatus = CQQ_Status_ByUseInfo;
                                     tibTitle.text   = @"通过收货人信息查询";//@"通过入网人信息查询"; // modified by zy, 2014-02-14
                                     labField01.text = @"收货人姓名：";
                                     labField02.text = @"收货人手机号：";
                                     tf02.keyboardType = UIKeyboardTypeNumberPad;
                                 }
                             }];
    [tabView addTabItem:@"通过入网人信息查询" select:NO];
    [tabView addTabItem:@"通过收货人信息查询" select:NO];
    [self.view addSubview:tabView];
    [tabView selAtIndex:0];
    
    UIScrollView* scrollview = [[UIScrollView alloc] initWithFrame:CGRectMake(0,40, self.view.frame.size.width,
                                                                              self.view.frame.size.height-tabView.frame.size.height)];
    scrollview.autoresizingMask = UIViewAutoresizingFlexibleHeight;
    [scrollview setBackgroundColor:[UIColor clearColor]];
    scrollview.tag = kTagScrollview;
    [self.view addSubview:scrollview];
    
    {
        UIButton* btnHidden = [UIButton buttonWithType:UIButtonTypeCustom];
        btnHidden.frame = CGRectMake(0,0,scrollview.frame.size.width,scrollview.frame.size.height);
        btnHidden.autoresizingMask = UIViewAutoresizingFlexibleHeight;
        [btnHidden addTarget:self
                      action:@selector(onTfHidden:)
            forControlEvents:UIControlEventTouchUpInside];
        [scrollview addSubview:btnHidden];
    }
    
    CGFloat xoffset = 30;
    CGFloat yoffset = 15;//15 + 40;
    CGRect  trect   = CGRectMake(xoffset, yoffset, self.view.frame.size.width-xoffset*2,30);
    {
        UILabel* labTip = [[UILabel alloc] initWithFrame:trect];
        labTip.backgroundColor = [UIColor clearColor];
        labTip.text = @"快速查询订单";
        labTip.font = [UIFont boldSystemFontOfSize:15];
        [scrollview addSubview:labTip];
    }
    yoffset += CGRectGetHeight(trect) + 15;
    UIImage* bgframe = [[UIImage imageNamed:@"per_content_bg.png"] stretchableImageWithLeftCapWidth:15 topCapHeight:15];
    UIImageView* bfrview = [[UIImageView alloc] initWithFrame:CGRectMake(xoffset-10, yoffset,
                                                                         self.view.frame.size.width-2*xoffset+20,174)];
    bfrview.image = bgframe;
    [scrollview addSubview:bfrview];
    
    {
        UILabel* labTip = [[UILabel alloc] initWithFrame:CGRectMake(xoffset,yoffset-10,
                                                                    140,20)];
        labTip.backgroundColor = [UIColor clearColor];
        labTip.text = @"通过入网人信息查询";
        labTip.tag  = kTagLabFrameTitle;
        labTip.font = [UIFont boldSystemFontOfSize:15];
        [scrollview addSubview:labTip];
    }
    
    {
        yoffset +=25;
        UILabel* labName = [[UILabel alloc] initWithFrame:CGRectMake(xoffset,yoffset,
                                                                    95,40)];
        labName.backgroundColor = [UIColor clearColor];
        labName.text = @"入网人姓名：";
        labName.tag  = kTagLabTxtField01;
        labName.font = [UIFont systemFontOfSize:14];
        labName.textAlignment = UITextAlignmentRight;
        [scrollview addSubview:labName];

        CGRect rightRc = CGRectMake(CGRectGetMaxX(labName.frame), yoffset, 165, 40);
        UITextField *txtFeild = [[UITextField alloc]initWithFrame:rightRc];
        txtFeild.backgroundColor =  [UIColor whiteColor];
        txtFeild.tag  = kTagInputTxtField01;
        txtFeild.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter ;
        txtFeild.returnKeyType = UIReturnKeyDone ;
        txtFeild.clearButtonMode = UITextFieldViewModeWhileEditing ; //点击清除
        txtFeild.keyboardType = UIKeyboardTypeDefault;
        txtFeild.font = [UIFont systemFontOfSize:14];
        [scrollview addSubview:txtFeild];
    }
    {
        yoffset += 40 + 10;
        UILabel* labAdds = [[UILabel alloc] initWithFrame:CGRectMake(xoffset-10,yoffset,
                                                                    105,40)];
        labAdds.backgroundColor = [UIColor clearColor];
        labAdds.text = @"身份证号：";
        labAdds.tag  = kTagLabTxtField02;
        labAdds.font = [UIFont systemFontOfSize:14];
        labAdds.textAlignment = UITextAlignmentRight;
        [scrollview addSubview:labAdds];
        
        CGRect rightRc = CGRectMake(CGRectGetMaxX(labAdds.frame), yoffset, 165, 40);
        UITextField *txtFeild = [[UITextField alloc]initWithFrame:rightRc];
        txtFeild.backgroundColor =  [UIColor whiteColor];
        txtFeild.tag  = kTagInputTxtField02;
        txtFeild.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter ;
        txtFeild.returnKeyType = UIReturnKeyDone ;
        txtFeild.clearButtonMode = UITextFieldViewModeWhileEditing ; //点击清除
        txtFeild.keyboardType = UIKeyboardTypeNumbersAndPunctuation;//UIKeyboardTypeDefault ;   // modified by zy, 2014-02-19
        txtFeild.font = [UIFont systemFontOfSize:14];
        [scrollview addSubview:txtFeild];
    }
    
    {
        yoffset += 40 + 10;
        UIButton* btnRead = [UIButton buttonWithType:UIButtonTypeSystem];
        btnRead.frame = CGRectMake((scrollview.frame.size.width-74)/2, yoffset,74,38);
        [btnRead setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [btnRead setTitle:@"查询" forState:UIControlStateNormal];
        UIImage* bgImg =
        [[UIImage imageNamed:@"myOrderBtn.png"] stretchableImageWithLeftCapWidth:20
                                                                    topCapHeight:20];
        [btnRead setBackgroundImage:bgImg forState:UIControlStateNormal];
        [btnRead addTarget:self
                      action:@selector(doQuery:)
            forControlEvents:UIControlEventTouchUpInside];

        [scrollview addSubview:btnRead];
    }
    
    {
        yoffset += 40 + 10;
        UILabel* labTip = [[UILabel alloc] initWithFrame:CGRectMake(xoffset,yoffset,
                                                                     self.view.frame.size.width-2*xoffset,20)];
        labTip.backgroundColor = [UIColor clearColor];
        labTip.text = @"温馨提示：";
        labTip.font = [UIFont boldSystemFontOfSize:15];
        [scrollview addSubview:labTip];

        yoffset += 20;
        UILabel* labTip1 = [[UILabel alloc] initWithFrame:CGRectMake(xoffset,yoffset,
                                                                     self.view.frame.size.width-2*xoffset,40)];
        labTip1.backgroundColor = [UIColor clearColor];
        labTip1.numberOfLines = 0;//2;  // iOS5.x上显示有问题，须指定为0，mofified by zy, 2014-02-13
        labTip1.text = @"1.你可以根据身份证号或者手机号码查询订单信息";
        labTip1.font = [UIFont systemFontOfSize:14];
        [scrollview addSubview:labTip1];
        [labTip1 sizeToFit];
        
        yoffset += CGRectGetHeight(labTip1.frame);
        UILabel* labTip2 = [[UILabel alloc] initWithFrame:CGRectMake(xoffset,yoffset,
                                                                     self.view.frame.size.width-2*xoffset,50)];
        labTip2.numberOfLines = 0;
        labTip2.backgroundColor = [UIColor clearColor];
        labTip2.text = @"2.飞Young套餐线上订单根据收货人姓名和身份证号码查询，终端订单根据收货人姓名和手机查询";
        labTip2.font = [UIFont systemFontOfSize:14];
        [scrollview addSubview:labTip2];
        [labTip2 sizeToFit];
        yoffset += CGRectGetHeight(labTip2.frame);
    }
    scrollview.contentSize = CGSizeMake(scrollview.frame.size.width,
                                        yoffset+10);
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewDidUnload{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
}


#pragma mark -
#pragma mark Notifications
- (void)keyboardWillShow:(NSNotification *)notification
{
    NSDictionary *userInfo = [notification userInfo];
    NSValue*  aValue   = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    NSString* duration = [userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey];
    NSString* Curve    = [userInfo objectForKey:UIKeyboardAnimationCurveUserInfoKey];
    CGRect keyboardRect = [aValue CGRectValue];
    int keyboadHeight = keyboardRect.size.height;
    
    UIScrollView* sbView = (UIScrollView*)[self.view viewWithTag:kTagScrollview];
    CGRect rc       = sbView.frame;
    rc.size.height  = [[UIScreen mainScreen] bounds].size.height - keyboadHeight - 64 - 40;//40 为navtab
    
    [UIView animateWithDuration:[duration floatValue]
                          delay:0.0
                        options:[Curve integerValue]
                     animations:^
     {
         sbView.frame = rc;
         if (_activTfView){
             [sbView scrollRectToVisible:CGRectInset(_activTfView.frame, 0, -8) animated:YES];
         }
     }completion:^(BOOL finished) {
         
     }];
}

- (void)keyboardWillHide:(NSNotification *)notification
{
    UIScrollView* sbView = (UIScrollView*)[self.view viewWithTag:kTagScrollview];
    CGRect rc       = sbView.frame;
    rc.size.height  = [[UIScreen mainScreen] bounds].size.height - 113;
    sbView.frame    = rc;
    if (_activTfView){
        [sbView scrollRectToVisible:_activTfView.frame animated:YES];
    }
}

#pragma mark -actions
-(void)onTfHidden:(id)sender{
    UIScrollView* scbview = (UIScrollView*)[self.view viewWithTag:kTagScrollview];
    if (!scbview) {
        return ;
    }
    UITextField* tfField01 = (UITextField*)[scbview viewWithTag:kTagInputTxtField01];
    UITextField* tfField02 = (UITextField*)[scbview viewWithTag:kTagInputTxtField02];
    [tfField01 resignFirstResponder];
    [tfField02 resignFirstResponder];
}

-(void)doQuery:(id)sender{
    UIScrollView* scbview = (UIScrollView*)[self.view viewWithTag:kTagScrollview];
    if (!scbview) {
        return ;
    }
    UITextField* tfField01 = (UITextField*)[scbview viewWithTag:kTagInputTxtField01];
    UITextField* tfField02 = (UITextField*)[scbview viewWithTag:kTagInputTxtField02];
    [tfField01 resignFirstResponder];
    [tfField02 resignFirstResponder];

    NSString* msg = @"";
    do {
        if ([tfField01.text length] <= 0)
        {
            switch (_vcstatus) {
                case CQQ_Status_ByNetInfo:
                {
                    msg = @"输入的信息不全，我们还没找到你的订单";//@"请输入入网人姓名";      // modified by zy, 2014-02-13
                }break;
                case CQQ_Status_ByUseInfo:
                {
                    msg = @"输入的信息不全，我们还没找到你的订单";//@"请输入收件人姓名";      // modified by zy, 2014-02-13
                }break;
                default:
                    break;
            }
            break;
        }
        
        switch (_vcstatus) {
            case CQQ_Status_ByNetInfo:
            {
                if ([tfField02.text length] <= 0)
                {
                    msg = @"输入的信息不全，我们还没找到你的订单";//@"请输入身份证号";       // modified by zy, 2014-02-13
                }else if([Utils isIDNumberValid:tfField02.text] == NO){
                    msg = @"请输入正确的身份证号";
                }
            }break;
            case CQQ_Status_ByUseInfo:
            {
                if ([tfField02.text length] <= 0)
                {
                    msg = @"输入的信息不全，我们还没找到你的订单";//@"收货人手机号：";       // modified by zy, 2014-02-13
                }else if ([Utils isMobileNumber:tfField02.text]==NO)
                {
                    msg = @"请输入正确的手机号码";
                }
            }break;
            default:
                break;
        }
        break;
    } while (0);
    
    if ([msg length] > 0) {
        SIAlertView *alertView = [[SIAlertView alloc] initWithTitle:nil
                                                         andMessage:msg];
        [alertView addButtonWithTitle:@"确定"
                                 type:SIAlertViewButtonTypeDefault
                              handler:^(SIAlertView *alertView) {
                              }];
        alertView.transitionStyle = SIAlertViewTransitionStyleBounce;
        [alertView show];
        return;
    }
    
    COQueryListVctler* listvc = [[COQueryListVctler alloc] init];
    listvc.QStatusType = _vcstatus;
    listvc.namestr = tfField01.text;
    listvc.codestr = tfField02.text;
    [self.navigationController pushViewController:listvc animated:YES];
}

@end
