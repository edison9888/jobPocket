//
//  CTPhoneInfoVCtler.m
//  CTPocketV4
//
//  Created by liuruxian on 13-11-19.
//  Copyright (c) 2013年 广东亿迅科技有限公司. All rights reserved.
//

#import "CTPhoneInfoVCtler.h"
#import "PagedFlowView.h"
#import "ImagePageControl.h"
#import "UIView+RoundRect.h"
#import "CserviceOperation.h"
#import "AppDelegate.h"
#import "CTContractChooseVCtler.h"
#import "CTPNewAddrVCtler.h"
#import "CTLoginVCtler.h"
#import "ToastAlertView.h"
#import "SVProgressHUD.h"
#import "SIAlertView.h"



@interface CTPhoneInfoVCtler () <PagedFlowViewDataSource,PagedFlowViewDelegate,UIScrollViewDelegate>
{
    PagedFlowView  *_pageFlowView;
    UILabel        *_phoneInfolabel;
    UILabel        *_pricelabel;
    UIButton       *_buyPhoneBtn;
    UIButton       *_rechargeBtn;
    UIButton       *_nextBtn;
    
    UIImageView    *_BGImageview;
    UIScrollView   *_BGScrollview;
    UIScrollView   *_AdvertiseScrollView;//可以不释放
    UIImageView    *_fixedImageview;
    UIImageView    *_variableImageview;
    
    NSInteger      _pageIndex;
    
    NSMutableArray *imageArray;
    NSMutableArray *_phoneImageArray;
    NSDictionary   *_SellInfoDict; //销售品信息
    
    //  天翼云卡
    BOOL           pageControlUsed ;
    int            distance;
    NSString       *_usrID;
    int            _curPage;
    //  天翼魔方
    
    NSTimer *_timer;
}
@property (nonatomic,strong) CserviceOperation *forContractTypeIDOpt;
@property (nonatomic,strong) CserviceOperation *barContractOpt;
@property (nonatomic, strong) CserviceOperation *phoneImageOpt;
@property (nonatomic, strong) CserviceOperation *stockOpt;
//@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIScrollView *bgScroll;
@end

@implementation CTPhoneInfoVCtler

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self._pageType = -1;
    }
    return self;
}

- (void) viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self setLeftButton:[UIImage imageNamed:@"btn_back_recharge.png"]];
    
    imageArray = [[NSMutableArray alloc]init];
    
    UIScrollView *scrollview = [[UIScrollView alloc]initWithFrame:self.view.bounds];
    scrollview.autoresizingMask = UIViewAutoresizingFlexibleHeight ;
    scrollview.backgroundColor = [UIColor clearColor];
    self.bgScroll = scrollview;
    [self.view addSubview:scrollview];
    
    int yOriginal = 0;
    {
        UIImageView *ScrollBGimageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, yOriginal, self.view.frame.size.width, 195)];
        ScrollBGimageView.userInteractionEnabled = YES;
        ScrollBGimageView.backgroundColor = [UIColor colorWithRed:220/255. green:220/255. blue:222/255. alpha:1];
        [self.bgScroll addSubview:ScrollBGimageView];
        {
            PagedFlowView *scroll = [[PagedFlowView alloc]initWithFrame:CGRectMake(0, 7, ScrollBGimageView.frame.size.width, 168)];
            scroll.backgroundColor = [UIColor clearColor];
            scroll.delegate = self;
            scroll.dataSource = self;
            scroll.minimumPageAlpha = 1;
            scroll.minimumPageScale = 0.8;
            _pageFlowView = scroll;
            [ScrollBGimageView addSubview:scroll];
            
            ImagePageControl *hPageControl = [[ImagePageControl alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(scroll.frame)+5, self.view.frame.size.width, 8)];
            scroll.pageControl = hPageControl;
            [hPageControl setCurrentPage:1];
            
            [hPageControl addTarget:self action:@selector(pageControlValueDidChange:) forControlEvents:UIControlEventValueChanged];
            hPageControl.backgroundColor = [UIColor clearColor];
            [ScrollBGimageView addSubview:hPageControl];
        }
        
        yOriginal = CGRectGetMaxY(ScrollBGimageView.frame) ;
    }
    {
        UIImage *image            = [UIImage imageNamed:@"contract_div.png"];
        UIImageView *imageview    = [[UIImageView alloc]initWithFrame:
                                     CGRectMake((self.view.frame.size.width-image.size.width)/2,
                                                yOriginal,
                                                image.size.width,
                                                image.size.height)];
        imageview.backgroundColor = [UIColor clearColor];
        imageview.image           = image;
        
        [self.bgScroll addSubview:imageview];
        yOriginal += imageview.frame.size.height;
    }
    //可变view
    {
        UIImageView *VariableImageview = [[UIImageView alloc]initWithFrame:CGRectMake(10,
                                                                                      yOriginal,
                                                                                      CGRectGetWidth(self.bgScroll.frame)-20,
                                                                                      self.bgScroll.frame.size.height - 15 - yOriginal)];
        VariableImageview.backgroundColor = [UIColor clearColor];
        VariableImageview.backgroundColor = [UIColor colorWithRed:235/255. green:235/255. blue:235/255. alpha:1];
        VariableImageview.userInteractionEnabled = YES;
        _variableImageview = VariableImageview;
        [self.bgScroll addSubview:_variableImageview];
    }
        //也许你还喜欢
    [self InitPage];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view
    if (_timer!=nil) {
        [_timer invalidate];
        _timer = nil;
    }
}
-(void)dealloc{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}
//合约机
-(void)ContractImageview : (NSDictionary *)dictionary
{
    int yOriginal = 0;
    {
        {
            UILabel *label1 = [[UILabel alloc]initWithFrame:CGRectMake(7,5, CGRectGetWidth(_variableImageview.frame)-10,36)];
            label1.numberOfLines = 0;
            label1.adjustsFontSizeToFitWidth = YES;
            label1.font = [UIFont systemFontOfSize:14];
            label1.backgroundColor = [UIColor clearColor];
            label1.textColor = [UIColor colorWithRed:102/255. green:102/255. blue:102/255. alpha:1];
            [_variableImageview addSubview:label1];
            label1.text = [dictionary objectForKey:@"Name"];
            [label1 sizeToFit];
            yOriginal = CGRectGetMaxY(label1.frame);
            
            UILabel *label2 = [[UILabel alloc]initWithFrame:
                               CGRectMake(7,
                                          yOriginal+5,
                                          CGRectGetWidth(_variableImageview.frame)-10 ,
                                          14)];
            label2.numberOfLines = 0;
            label2.font = [UIFont systemFontOfSize:14];
            label2.textColor = [UIColor colorWithRed:102/255. green:102/255. blue:102/255. alpha:1];
            label2.backgroundColor = [UIColor clearColor];
            [_variableImageview addSubview: label2];
            _pricelabel = label2;
            
            label2.text = [@"价格 : " stringByAppendingString:[dictionary objectForKey:@"Price"]];
            yOriginal = CGRectGetMaxY(label2.frame) ;
        }
        int xPos = 0 , yPos = 0;
        {
            UILabel *label1 = [[UILabel alloc]initWithFrame:CGRectMake(7, yOriginal+15, 45, 14)];
            label1.text = @"类 型 : ";
            label1.font = [UIFont systemFontOfSize:14];
            label1.backgroundColor = [UIColor clearColor];
            label1.textColor = [UIColor colorWithRed:102/255. green:102/255. blue:102/255. alpha:1];
            xPos = CGRectGetMaxX(label1.frame);
            [_variableImageview addSubview:label1];
 
            if (self._SfIdstr && self._SfIdstr.length!=0)
            {
                UIImage *image1 = [UIImage imageNamed:@"contract_BuyPhone.png"];
                UIImage *image2 = [UIImage imageNamed:@"contract_SaveMoney.png"];
                CGRect rect     = CGRectMake(xPos,yOriginal+8, image1.size.width, 28);
                
                UIButton *btn1  = [UIButton buttonWithType:UIButtonTypeCustom];
                
                btn1.frame = rect;
                [btn1 setTitle:@"购机送费" forState:UIControlStateNormal];
                btn1.titleLabel.font = [UIFont systemFontOfSize:14];
                [btn1 setBackgroundImage:image2 forState:UIControlStateNormal];
                [btn1 setBackgroundImage:image1 forState:UIControlStateSelected];
                [btn1 setTitleColor:[UIColor colorWithRed:102/255. green:102/255. blue:102/255. alpha:1] forState:UIControlStateNormal];
                [btn1 setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
                btn1.selected = YES;
                [btn1 addTarget:self action:@selector(BuyPhoneAction:) forControlEvents:UIControlEventTouchUpInside];
                [_variableImageview addSubview:btn1];
                _buyPhoneBtn = btn1;
                xPos = CGRectGetMaxX(btn1.frame) + 16;
            }
            if (self._BtIdstr && self._BtIdstr.length!=0)
            {
                UIImage *image1 = [UIImage imageNamed:@"contract_BuyPhone.png"];
                UIImage *image2 = [UIImage imageNamed:@"contract_SaveMoney.png"];
                CGRect rect     = CGRectMake(xPos,yOriginal+8, image2.size.width, 28);
                UIButton *btn1  = [UIButton buttonWithType:UIButtonTypeCustom];
                btn1.frame = rect;
                [btn1 setTitle:@"存费送机" forState:UIControlStateNormal];
                btn1.titleLabel.font = [UIFont systemFontOfSize:14];
                [btn1 setBackgroundImage:image2 forState:UIControlStateNormal];
                [btn1 setBackgroundImage:image1 forState:UIControlStateSelected];
                [btn1 setTitleColor:[UIColor colorWithRed:102/255. green:102/255. blue:102/255. alpha:1] forState:UIControlStateNormal];
                [btn1 setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
                [btn1 addTarget:self action:@selector(BuyPhoneAction:) forControlEvents:UIControlEventTouchUpInside];
                _buyPhoneBtn = btn1;
                _buyPhoneBtn.selected = YES ;
                yPos = CGRectGetMaxY(btn1.frame);
                [_variableImageview addSubview:btn1];
            }
            
            yOriginal = CGRectGetMaxY(label1.frame) + 15;
        }
        
        {
            UIImage *image = [UIImage imageNamed:@"contract_next.png"];
            CGRect rect = CGRectMake((_variableImageview.frame.size.width-image.size.width)/2, yOriginal, image.size.width, image.size.height);
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            btn.frame = rect;
            _nextBtn = btn;
            [btn setBackgroundImage:image forState:UIControlStateNormal];
            [btn setTitle:@"下一步" forState:UIControlStateNormal];
            [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            btn.titleLabel.font = [UIFont systemFontOfSize:14];
            btn.titleLabel.textAlignment = UIControlContentHorizontalAlignmentCenter | UIControlContentVerticalAlignmentCenter;
            [btn addTarget:self action:@selector(nextstepAction) forControlEvents:UIControlEventTouchUpInside];
            [_variableImageview addSubview:btn];
            
            yOriginal = CGRectGetMaxY(btn.frame) + 10;
        }
        
        CGRect rect = _variableImageview.frame ;
        rect.size.height = yOriginal + 196;
        _variableImageview.frame = rect;
        
        self.bgScroll.contentSize = CGSizeMake(self.bgScroll.frame.size.width, _variableImageview.frame.size.height);
    }
}
//裸机终端
-(void)BareFixImageview : (NSDictionary *)dictionary
{
    int yOriginal = 0;
    {
        UILabel *label1 = [[UILabel alloc]initWithFrame:CGRectMake(7,15, CGRectGetWidth(_variableImageview.frame)-10,36)];
        label1.numberOfLines = 0;
        label1.adjustsFontSizeToFitWidth = YES;
        label1.font = [UIFont systemFontOfSize:14];
        label1.backgroundColor = [UIColor clearColor];
        label1.textColor = [UIColor colorWithRed:102/255. green:102/255. blue:102/255. alpha:1];
        [_variableImageview addSubview:label1];
        label1.text = [dictionary objectForKey:@"Name"];
        [label1 sizeToFit];
        yOriginal = CGRectGetMaxY(label1.frame);
        
        UILabel *label2 = [[UILabel alloc]initWithFrame:
                           CGRectMake(7,
                                      yOriginal+8,
                                      CGRectGetWidth(_variableImageview.frame)-10 ,
                                      14)];
        label2.numberOfLines = 0;
        label2.font = [UIFont systemFontOfSize:14];
        label2.textColor = [UIColor colorWithRed:102/255. green:102/255. blue:102/255. alpha:1];
        label2.backgroundColor = [UIColor clearColor];
        [_variableImageview addSubview: label2];
        _pricelabel = label2;
        
        label2.text = [@"价格 : " stringByAppendingString:[dictionary objectForKey:@"Price"]];
        yOriginal = CGRectGetMaxY(label2.frame) +30;

        {
            UIImage *image = [UIImage imageNamed:@"contract_next.png"];
            CGRect rect = CGRectMake((_variableImageview.frame.size.width-image.size.width)/2, yOriginal, image.size.width, image.size.height);
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            btn.frame = rect;
            _nextBtn = btn;
            [btn setBackgroundImage:image forState:UIControlStateNormal];
            [btn setTitle:@"下一步" forState:UIControlStateNormal];
            [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            btn.titleLabel.font = [UIFont systemFontOfSize:14];
            btn.titleLabel.textAlignment = UIControlContentHorizontalAlignmentCenter | UIControlContentVerticalAlignmentCenter;
            [btn addTarget:self action:@selector(nextstepAction) forControlEvents:UIControlEventTouchUpInside];
            [_variableImageview addSubview:btn];
            
            yOriginal = CGRectGetMaxY(btn.frame) + 10;
        }
        
        CGRect rect = _variableImageview.frame ;
        rect.size.height = yOriginal + 196;
        _variableImageview.frame = rect;
        
        self.bgScroll.contentSize = CGSizeMake(self.bgScroll.frame.size.width, _variableImageview.frame.size.height);
    }
}

#pragma mark - fun

- (void) setPhoneInfo : (NSDictionary *) dictionary : (int) page
{
    //请求数据
    NSString *Id = [dictionary objectForKey:@"Link"];
    
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:Id,@"Id",nil];
    
    __block CTPhoneInfoVCtler *weakSelf = self ;
    [SVProgressHUD showWithStatus:@"请稍候..." maskType:SVProgressHUDMaskTypeGradient];
    
    [MyAppDelegate.cserviceEngine postXMLWithCode:@"qrySalesProductCompleteInfo"
                                           params:params
                                      onSucceeded:^(NSDictionary *dict)
                                            {
                                               id Data = [dict objectForKey:@"Data"];
                                               if (Data && [Data respondsToSelector:@selector(objectForKey:)])
                                               {
                                                   NSMutableDictionary *saleInfo = [NSMutableDictionary dictionaryWithDictionary:Data];
                                                   [saleInfo setObject:Id forKey:@"SalesProdId"];
                                                   [weakSelf ChoosePage:page Info:saleInfo UsrID:@""];
                                                   [self InitPage];
//                                                   [SVProgressHUD dismiss];
                                               }
                                           }onError:^(NSError *engineError){
                                               [SVProgressHUD dismiss];
                                               if ([engineError.userInfo objectForKey:@"ResultCode"])
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
                                               else{
                                                   ToastAlertView *alert = [ToastAlertView new];
                                                   [alert showAlertMsg:@"系统繁忙,请重新提交"];
                                               }
                                           }];
}
-(void)InitPage
{
    switch (self._pageType) {
        case 0:
        {
            [self getContractTypeID:_SellInfoDict];  //获取合约类型
        }
            break;
        case 1:
        {
            [self BareFixImageview:_SellInfoDict];
            [self initPhoneInfo];
        }
            break;
    }
}

- (void) initPhoneInfo
{
    //标题

    self.title =[_SellInfoDict objectForKey:@"Name"];
    switch (self._pageType) {
        case 0:
        {
            _phoneInfolabel.numberOfLines = 0;
            _phoneInfolabel.text = [_SellInfoDict objectForKey:@"Name"];
            [_phoneInfolabel sizeToFit];
        }
            break;
        case 1:
        {
           
        }
            break;
    }

    NSString  *price     = @"价格 : ";
    price                = [price stringByAppendingString:[_SellInfoDict objectForKey:@"Price"]];
    _pricelabel.text     = [price stringByAppendingString:@"元"];

    
    [self PhoneImageRequest:_SellInfoDict];
}
//页面进去判断
-(void)ChoosePage:(int)page Info:(NSDictionary*)dictionary UsrID:(NSString *)usrID
{
    self._pageType = page;
    _SellInfoDict = dictionary;
    _usrID = usrID;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//初始化参数
-(void)InitParames:(NSMutableArray *) array
{
    [_pageFlowView scrollToPage:0];
    [_pageFlowView reloadData];
}

#pragma mark  -  Action

//下一步
-(void)nextstepAction
{
    
    if (self.stockOpt) {
        [self.stockOpt cancel];
        self.stockOpt = nil;
    }
    
    NSDictionary * params   =  [NSDictionary dictionaryWithObjectsAndKeys:
                                [_SellInfoDict objectForKey:@"SalesProdId"],@"TermResCd",
                                nil];
    
    __block CTPhoneInfoVCtler *weakSelf = self;
   self.stockOpt = [MyAppDelegate.cserviceEngine postXMLWithCode:@"qryTermStockInfo"
                                         params:params
                                    onSucceeded:^(NSDictionary *dict) {
                                        DDLogInfo(@"%s--%@", __func__, dict.description);
                                        id Data = [dict objectForKey:@"Data"];
                                        if (Data && [Data respondsToSelector:@selector(objectForKey:)]) {
                                            id _stock;
                                            _stock = [Data objectForKey:@"Stock"];
                                            NSString * tipmsg = @"阿哦，你挑到爆款啦，被抢光啦，逛逛别的吧~";
                                            if ([_stock intValue]<1) {
                                                SIAlertView *alertView = [[SIAlertView alloc] initWithTitle:nil
                                                                                                 andMessage:tipmsg];
                                                [alertView addButtonWithTitle:@"确定"
                                                                         type:SIAlertViewButtonTypeDefault
                                                                      handler:^(SIAlertView *alertView) {
                                                                          
                                                                      }];
                                                alertView.transitionStyle = SIAlertViewTransitionStyleBounce;
                                                [alertView show];
                                            }else{  //跳转
                                                
                                                switch (weakSelf._pageType) {
                                                    case 0:
                                                    {
                                                        CTContractChooseVCtler *vc = [[CTContractChooseVCtler alloc]init];
                                                        if (weakSelf._SfIdstr && weakSelf._SfIdstr.length > 0) {
                                                            [vc setPhoneInfo:_SellInfoDict buyType:weakSelf._SfIdstr title:@"购机送费"];
                                                        }else{
                                                            [vc setPhoneInfo:_SellInfoDict buyType:weakSelf._BtIdstr title:@"存费送机"];
                                                        }
                                                        
                                                        [weakSelf.navigationController pushViewController:vc animated:YES];
                                                    }
                                                        break;
                                                    case 1:  //裸机
                                                    {
                                                        [weakSelf createShopCartOrder:_SellInfoDict userID:_usrID];
                                                    }
                                                        break;
                                                    case 2:  //积木式
                                                    {
                                                        
                                                    }
                                                        break;
                                                }
                                            }
                                            
                                        }
                                        [SVProgressHUD dismiss];
                                    } onError:^(NSError *engineError) {
                                        DDLogInfo(@"%s--%@", __func__, engineError);
                                        [SVProgressHUD dismiss];
                                        if ([engineError.userInfo objectForKey:@"ResultCode"])
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
                                            else{
                                                ToastAlertView *alert = [ToastAlertView new];
                                                [alert showAlertMsg:@"信息获取失败"];
                                            }
                                        }
                                    }];
}

-(void)BuyPhoneAction:(UIButton *)sender
{
    UIButton *btn = (UIButton *)sender;
    
    if (btn == _buyPhoneBtn) {
        if (btn.selected) {
            btn.selected = NO;
            _nextBtn.userInteractionEnabled = NO;
        }else{
            btn.selected = YES;
            _nextBtn.userInteractionEnabled = YES;
        }
//        _buyPhoneBtn.selected = YES;
//        _rechargeBtn.selected = NO;
        
    }else{
        _buyPhoneBtn.selected = NO;
        _rechargeBtn.selected = YES;
    }
    
}

#pragma mark - contractPhoneCtler delegate
-(void)phoneInfo:(NSDictionary *)phoneInfoDict
{
    if (phoneInfoDict != nil) {
        [self PhoneImageRequest:phoneInfoDict];
    }
}

#pragma mark - contractId net Work

//合约ID选择
-(void)getContractTypeID:(NSDictionary *)dictionary
{
//    if ([Global sharedInstance].isLogin == NO) {
//        CTLoginVCtler *vc = [[CTLoginVCtler alloc] init];
//        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
//        [MyAppDelegate.tabBarController presentViewController:nav animated:YES completion:^(void){
//        }];
//        return;
//    }
    
    if (self.forContractTypeIDOpt) {
        [self.forContractTypeIDOpt cancel];
        self.forContractTypeIDOpt = nil;
    }
    
    //网络请求
    {
        NSDictionary * params   =  [NSDictionary dictionaryWithObjectsAndKeys:
                                    [dictionary objectForKey:@"SalesProdId"],@"Salesproductid",
                                    nil];
        if ([SVProgressHUD isVisible]) {
            
        } else {
            [SVProgressHUD showWithStatus:@"请稍候..." maskType:SVProgressHUDMaskTypeGradient];
        }
        
        
        __block CTPhoneInfoVCtler *weakSelf = self;
        self.forContractTypeIDOpt =[MyAppDelegate.cserviceEngine postXMLWithCode:@"forContractTypeID"
                                                                           params:params
                  onSucceeded:^(NSDictionary *dict) {
                      DDLogInfo(@"%s--%@", __func__, dict.description);
                      id Data = [dict objectForKey:@"Data"];
                      if (Data && [Data respondsToSelector:@selector(objectForKey:)]) {
                          self._SfIdstr = [Data objectForKey:@"SfId"];
                          self._BtIdstr = [Data objectForKey:@"BtId"];
                          [weakSelf ContractImageview:_SellInfoDict];
                          [weakSelf initPhoneInfo];
                      }
                      [SVProgressHUD dismiss];
                  } onError:^(NSError *engineError) {
                      DDLogInfo(@"%s--%@", __func__, engineError);
                      [SVProgressHUD dismiss];
                      if ([engineError.userInfo objectForKey:@"ResultCode"])
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
                      else{
                          ToastAlertView *alert = [ToastAlertView new];
                          [alert showAlertMsg:@"系统繁忙,请重新提交"];
                      }
                  }];
    }
}

//创建订单
-(void)createShopCartOrder:(NSDictionary *)dictionary userID :(NSString *)userID
{
    if ([Global sharedInstance].isLogin == NO) {
        CTLoginVCtler *vc = [[CTLoginVCtler alloc] init];
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
        [MyAppDelegate.tabBarController presentViewController:nav animated:YES completion:^(void){
        }];
        return;
    }
    
    if (self.barContractOpt) {
        [self.barContractOpt cancel];
        self.barContractOpt = nil ;
    }

    NSString *ShopId         = ESHORE_ShopId;
    NSString *UserId         = [[Global sharedInstance].custInfoDict objectForKey:@"UserId"];
    NSString *GpFlag         = @"0" ;//普通订单
    
    NSDictionary *dic = [[NSDictionary alloc]initWithObjectsAndKeys:[dictionary objectForKey:@"SalesProdId"],@"SalesProId",@"1",@"Count" ,nil];
    NSDictionary *item       = [[NSDictionary alloc]initWithObjectsAndKeys:dic,@"Item", nil];
    NSArray *Items           = [[NSArray alloc]initWithObjects:item, nil];
    
    //发送请求
    NSDictionary * params    = [NSDictionary dictionaryWithObjectsAndKeys:
                                ShopId,   @"ShopId",
                                UserId,   @"UserId",
                                GpFlag,   @"GpFlag",
                                Items,    @"Items",
                                nil];
    
    [SVProgressHUD showWithStatus:@"请稍候..." maskType:SVProgressHUDMaskTypeGradient];
    
    __block CTPhoneInfoVCtler *weakSelf = self ;
    self.barContractOpt =[MyAppDelegate.cserviceEngine postXMLWithCode:@"createShopCartOrder"
                                                                      params:params
             onSucceeded:^(NSDictionary *dict) {
                 DDLogInfo(@"%s--%@", __func__, dict.description);
                 id Data = [dict objectForKey:@"Data"];
                 if (Data && [Data respondsToSelector:@selector(objectForKey:)]) {
                     //跳转订单
                     CTPNewAddrVCtler *picker    = [[CTPNewAddrVCtler alloc]init]; //号码选择
                     [weakSelf.navigationController pushViewController:picker animated:YES];
                     picker.isSalesproduct       = YES;
                     picker.salesProductInfoDict = _SellInfoDict;
                     picker.orderInfoDict        = Data;
                 }
                 [SVProgressHUD dismiss];
             } onError:^(NSError *engineError) {
                 DDLogInfo(@"%s--%@", __func__, engineError);
                 //token超时处理
                 {
                     [SVProgressHUD dismiss];
                     if ([engineError.userInfo objectForKey:@"ResultCode"])
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
                     else{
                         ToastAlertView *alert = [ToastAlertView new];
                         [alert showAlertMsg:@"系统繁忙,请重新提交"];
                     }
                 }
             }];
}

#pragma mark - netWork deleagate
//图片请求显示
-(void)PhoneImageRequest:(NSDictionary *)dictionary
{
    {
        if (self.phoneImageOpt) {
            [self.phoneImageOpt cancel];
            self.phoneImageOpt = nil ;
        }
    }
    
    NSDictionary * params           = [NSDictionary dictionaryWithObjectsAndKeys:
                                       [dictionary objectForKey:@"SalesProdId"],@"SalesProductId",
                                       nil];
    
//    [SVProgressHUD showWithStatus:@"请稍候..." maskType:SVProgressHUDMaskTypeGradient];
    
    self.phoneImageOpt =[MyAppDelegate.cserviceEngine postXMLWithCode:@"qrySalesProductAlbum"
                                                                params:params
                   onSucceeded:^(NSDictionary *dict) {
                       DDLogInfo(@"%s--%@", __func__, dict.description);
                       id Data = [dict objectForKey:@"Data"];
                       //获取信息失败
                       {
                           NSDictionary *DataList = [Data objectForKey:@"DataList"];
                           if (DataList && [DataList respondsToSelector:@selector(objectForKey:)]) {
                               id List = [DataList objectForKey:@"List"];
                               [imageArray removeAllObjects];
                               if (List && [List isKindOfClass:[NSArray class]]) {
                                   [imageArray addObjectsFromArray:List];
                               }
                               if (List && [List isKindOfClass:[NSDictionary class]]) {
                                   [imageArray addObject:List];
                               }
                               
                               [self InitParames:imageArray];
                           }
                       }
                       
                       [SVProgressHUD dismiss];
                       
                   } onError:^(NSError *engineError) {
                       DDLogInfo(@"%s--%@", __func__, engineError);
                       [SVProgressHUD dismiss];
                       if ([engineError.userInfo objectForKey:@"ResultCode"])
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
                       else{
                           ToastAlertView *alert = [ToastAlertView new];
                           [alert showAlertMsg:@"系统繁忙,请重新提交"];
                       }
                   }];
}

-(void)onleftBtnAction:(id)sender
{
    if (_timer!=nil) {
        [_timer invalidate];
        _timer = nil;
    }
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)onrightBtnAction:(id)sender
{

}

#pragma mark - PageFlowView delegate
- (CGSize)sizeForPageInFlowView:(PagedFlowView *)flowView;{ //返回当前页面的大小
    return CGSizeMake(205, 168);
}
- (void)didScrollToPage:(NSInteger)pageNumber inFlowView:(PagedFlowView *)flowView { //设定页面滚动的页码数
    NSLog(@"Scrolled to page # %d", pageNumber);
}
#pragma mark - PageFlowView DataSource
//返回显示View的个数
- (NSInteger)numberOfPagesInFlowView:(PagedFlowView *)flowView{
    return [imageArray count];
}
//返回给某列使用的View
- (UIView *)flowView:(PagedFlowView *)flowView cellForPageAtIndex:(NSInteger)index{
    
    
    NSDictionary * imageurl     = [imageArray objectAtIndex:index];
    NSURL *url = [NSURL URLWithString:[imageurl objectForKey:@"Url"]];
    
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 205, 168)];
    [imageView dwMakeRoundCornerWithRadius:5];
    imageView.backgroundColor = [UIColor whiteColor];
    [imageView setImageWithURL:url placeholderImage:[UIImage imageNamed:@"loadingImage2.png"]];
    
    return imageView;
}

- (void)pageControlValueDidChange:(UIPageControl *)sender {
    UIPageControl *pageControl = sender;
    _pageIndex = pageControl.currentPage;
    [_pageFlowView scrollToPage:pageControl.currentPage];
}

@end
