//
//  CTAddPackageVCtler.m
//  CTPocketV4
//
//  Created by Mac-Eshore-01 on 14-4-18.
//  Copyright (c) 2014年 广东亿迅科技有限公司. All rights reserved.
//

#import "CTAddPackageVCtler.h"
#import "CserviceOperation.h"
#import "AppDelegate.h"
#import "SIAlertView.h"
#import "SVProgressHUD.h"
#import "PropertiesView.h"
#import "OptPackageView.h"
#import "CanDoView.h"
#import "CTPackageSelectVCtler.h"
#import "CTWriteOrderInfoVCtler.h"
#import "CTPackageSelectVCtler.h"

#define kPackageSelectedLabelTag 1000

@interface CTAddPackageVCtler ()<PropertiesViewDelegate, OptPackageViewDelegate, CanDoViewDelegate>

@property (strong, nonatomic) UIScrollView *mScrollView;
@property (strong, nonatomic) PropertiesView *propertiesView;
@property (strong, nonatomic) OptPackageView *optPackageView;
@property (strong, nonatomic) CanDoView *canDoView;
@property (strong, nonatomic) UIButton *mButton;

@property (nonatomic, strong) CserviceOperation *qryComboTypeOpt;
@property (nonatomic, strong) CserviceOperation *qryPackageUniOpt;


@property (nonatomic, strong) NSMutableArray *comboItems;  //  可选套餐总类，数据从qryComboType接口获得
@property (nonatomic, strong) UIView *containerView;
@property (nonatomic, strong) NSMutableArray *vcs;
@property (nonatomic, strong) NSMutableArray *packages;

@end

@implementation CTAddPackageVCtler

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}


#pragma mark - Lazy Instantiation

- (NSMutableArray *)comboItems
{
    if (!_comboItems) {
        _comboItems = [[NSMutableArray alloc] init];
    }
    return _comboItems;
}

- (NSMutableArray *)vcs
{
    if (!_vcs) {
        _vcs = [[NSMutableArray alloc] init];
    }
    return _vcs;
}

- (NSMutableArray *)packages
{
    if (!_packages) {
        _packages = [[NSMutableArray alloc] init];
    }
    return _packages;
}

/** modified by gongxt 禁用手势
- (void)viewDidAppear:(BOOL)animated{
    
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)])
    {
        self.navigationController.interactivePopGestureRecognizer.enabled = NO;
    }
}

- (void)viewDidDisappear:(BOOL)animated
{
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)])
    {
        self.navigationController.interactivePopGestureRecognizer.enabled = YES;
    }
}

- (void) dealloc
{
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)])
    {
        self.navigationController.interactivePopGestureRecognizer.enabled = YES;
    }
}
*/
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    // 标题
    self.title = @"选择套餐";
    // 左按钮
    [self setLeftButton:[UIImage imageNamed:@"btn_back"]];
    
    // 清空乐享,云卡,纯流量选中信息
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    if ([userDefaults objectForKey:@"LeXiang"]) {
        [userDefaults removeObjectForKey:@"LeXiang"];
    }
    if ([userDefaults objectForKey:@"YunKa"]) {
        [userDefaults removeObjectForKey:@"YunKa"];
    }
    if([userDefaults objectForKey:@"FeiYoung"])
    {
        [userDefaults removeObjectForKey:@"FeiYoung"];
    }
    
    
    [self showLoadingAnimated:YES];
    [self qryComboType];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UIScrollView *)mScrollView
{
    if (!_mScrollView) {
        _mScrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
        _mScrollView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
        _mScrollView.backgroundColor = [UIColor clearColor];
        
        // 左侧内容
        {
            // 绿线
            UIImageView *greenLineImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 2, 2, 280)];
            UIImage *greenLine = [UIImage imageNamed:@"LeXiangPackage_GreenLine@2x"];
            UIImage *greenLineResize = [greenLine resizableImageWithCapInsets:UIEdgeInsetsMake(greenLine.size.height/2, 0, greenLine.size.height/2, 0)];
            greenLineImage.image = greenLineResize;
            //            [_mScrollView addSubview:greenLineImage];
            
            // 号码
            {
                UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 25, 40, 41)];
                imageView.image = [UIImage imageNamed:@"LeXiangPackage_Gray@2x"];
                
                UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
                label.backgroundColor = [UIColor clearColor];
                label.font = [UIFont systemFontOfSize:14.0f];
                label.textColor = [UIColor whiteColor];
                label.textAlignment = UITextAlignmentCenter;
                label.text = @"号码";
                [imageView addSubview:label];
                
                //                [_mScrollView addSubview:imageView];
            }
            
            // 套餐
            {
                UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 114, 48, 41)];
                imageView.image = [UIImage imageNamed:@"LeXiangPackage_Green@2x"];
                
                UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 48, 40)];
                label.backgroundColor = [UIColor clearColor];
                label.font = [UIFont systemFontOfSize:16.0f];
                label.textColor = [UIColor whiteColor];
                label.textAlignment = UITextAlignmentCenter;
                label.text = @"套餐";
                [imageView addSubview:label];
                
                //                [_mScrollView addSubview:imageView];
            }
            
            // 订单
            {
                UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 198, 40, 41)];
                imageView.image = [UIImage imageNamed:@"LeXiangPackage_Gray@2x"];
                
                UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
                label.backgroundColor = [UIColor clearColor];
                label.font = [UIFont systemFontOfSize:14.0f];
                label.textColor = [UIColor whiteColor];
                label.textAlignment = UITextAlignmentCenter;
                label.text = @"订单";
                [imageView addSubview:label];
                
                //                [_mScrollView addSubview:imageView];
            }
            
            // 支付
            {
                UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 282, 40, 41)];
                imageView.image = [UIImage imageNamed:@"LeXiangPackage_Gray@2x"];
                
                UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
                label.backgroundColor = [UIColor clearColor];
                label.font = [UIFont systemFontOfSize:14.0f];
                label.textColor = [UIColor whiteColor];
                label.textAlignment = UITextAlignmentCenter;
                label.text = @"支付";
                [imageView addSubview:label];
                
                //                [_mScrollView addSubview:imageView];
            }
        }
        
        // packageImage
        {
            UIImageView *packageImage = [[UIImageView alloc] initWithFrame:CGRectMake(15, 14, 200, 37)];
            UIImage *image = [UIImage imageNamed:@"LeXiangPackage_Package@2x"];
            UIImage *img = [image resizableImageWithCapInsets:UIEdgeInsetsMake(image.size.height/2,
                                                                               image.size.width/2,
                                                                               image.size.height/2,
                                                                               image.size.width/2)];
            packageImage.image = img;
            
            UILabel *label = [[UILabel alloc] initWithFrame:packageImage.bounds];
            label.backgroundColor = [UIColor clearColor];
            label.font = [UIFont systemFontOfSize:15.0f];
            label.textColor = [UIColor blackColor];
            label.textAlignment = UITextAlignmentCenter;
            label.tag = kPackageSelectedLabelTag ;
            NSUInteger inx = [self.info[@"index"] integerValue];
            
            // 根据ComboType来显示套餐名
            if ([self.info[@"combo"][@"ComboType"] isEqualToString:@"883"]) {
                // 纯流量
                //                label.text = @"飞Young纯流量套餐";
                label.text = self.info[@"combo"][@"ComboName"];
            }
            else if ([self.info[@"combo"][@"ComboType"] isEqualToString:@"881"]) {
                // 云卡
                if ([self.info[@"package"][@"PackageItem"] isKindOfClass:[NSDictionary class]]) {
                    label.text = self.info[@"package"][@"PackageItem"][@"Name"];
                }
                else if ([self.info[@"package"][@"PackageItem"] isKindOfClass:[NSArray class]]) {
                    label.text = self.info[@"package"][@"PackageItem"][inx][@"Name"];
                }
            }
            else if ([self.info[@"combo"][@"ComboType"] isEqualToString:@"884"]) {
                // 乐享3G上网版
                if ([self.info[@"package"][@"PackageItem"] isKindOfClass:[NSDictionary class]]) {
                    label.text = [NSString stringWithFormat:@"%@%@元", self.info[@"combo"][@"ComboName"], self.info[@"package"][@"PackageItem"][@"Name"]];
                }
                else if ([self.info[@"package"][@"PackageItem"] isKindOfClass:[NSArray class]]) {
                    label.text = [NSString stringWithFormat:@"%@%@元", self.info[@"combo"][@"ComboName"], self.info[@"package"][@"PackageItem"][inx][@"Name"]];
                }
            }
            
            [packageImage addSubview:label];
            
            [_mScrollView addSubview:packageImage];
        }
        
        // 其他套餐选择
        {
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            btn.frame = CGRectMake(237, 13, 80, 38);
            [btn setTitleColor:[UIColor colorWithRed:0.44 green:0.78 blue:0.22 alpha:1] forState:UIControlStateNormal];
            [btn.titleLabel setFont:[UIFont boldSystemFontOfSize:15.0f]];
            [btn setTitle:@"其他套餐    " forState:UIControlStateNormal];
            [btn addTarget:self action:@selector(onBackAction) forControlEvents:UIControlEventTouchUpInside];
            [_mScrollView addSubview:btn];
        }
        
        // 左边分隔符
        {
            UIImageView *grayLine = [[UIImageView alloc] initWithFrame:CGRectMake(15, 75, 1, self.view.bounds.size.height-62)];
            grayLine.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleTopMargin;
            grayLine.image = [UIImage imageNamed:@"LeXiangPackage_GrayLine@2x"];
            //            [_mScrollView addSubview:grayLine];
        }
        
        [self.view addSubview:_mScrollView];
    }
    return _mScrollView;
}

- (void)initPackage
{
    NSUInteger inx = [self.info[@"index"] integerValue];
    
    [self.propertiesView removeFromSuperview];
    self.propertiesView = nil;
    
    if (!self.propertiesView) {
        self.propertiesView = [[PropertiesView alloc] initWithFrame:CGRectMake(15, 75, 0, 0)];
        [self.mScrollView addSubview:self.propertiesView];
    }
    self.propertiesView.delegate = self;
    if ([self.info[@"package"][@"PackageItem"] isKindOfClass:[NSDictionary class]]) {
        [self.propertiesView setContent:self.info[@"package"][@"PackageItem"][@"Properties"]];
    }
    else if ([self.info[@"package"][@"PackageItem"] isKindOfClass:[NSArray class]]) {  //是否默认套餐
        [self.propertiesView setContent:self.info[@"package"][@"PackageItem"][inx][@"Properties"]];
    }
    
    [self.optPackageView removeFromSuperview];
    self.optPackageView = nil;
    
    if (!self.optPackageView) {
        self.optPackageView = [[OptPackageView alloc] initWithFrame:CGRectMake(15, 127, 0, 0)];
         self.optPackageView.delegate = self;
        [self.mScrollView addSubview:self.optPackageView];
    }
   
    if ([self.info[@"package"][@"PackageItem"] isKindOfClass:[NSDictionary class]]) {
        if (self.info[@"package"][@"PackageItem"][@"OptionalPackage"] &&
            (self.info[@"package"][@"PackageItem"][@"OptionalPackage"] != [NSNull null])) {
            [self.optPackageView setContent:self.info[@"package"][@"PackageItem"][@"OptionalPackage"]];
        }
    }
    else if ([self.info[@"package"][@"PackageItem"] isKindOfClass:[NSArray class]]) {
        if (self.info[@"package"][@"PackageItem"][inx][@"OptionalPackage"] &&
            (self.info[@"package"][@"PackageItem"][inx][@"OptionalPackage"] != [NSNull null])) {
            [self.optPackageView setContent:self.info[@"package"][@"PackageItem"][inx][@"OptionalPackage"]];
        }
    }
    
    [self.canDoView removeFromSuperview];
    self.canDoView = nil;
    if (!self.canDoView) {
         self.canDoView = [[CanDoView alloc] initWithFrame:CGRectMake(15, self.optPackageView.frame.origin.y + self.optPackageView.frame.size.height, 0, 0)];
         self.canDoView.delegate = self;
        [self.mScrollView addSubview:self.canDoView];
    }
   
    if ([self.info[@"package"][@"PackageItem"] isKindOfClass:[NSDictionary class]]) {
        
        [self.canDoView setContent:self.info[@"package"][@"PackageItem"][@"Properties"]];
    }
    else if ([self.info[@"package"][@"PackageItem"] isKindOfClass:[NSArray class]]) {
        [self.canDoView setContent:self.info[@"package"][@"PackageItem"][inx][@"Properties"]];
    }
    
    if (!self.mButton) {
        self.mButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.mScrollView addSubview:self.mButton];
    }
    self.mButton.frame = CGRectMake((CGRectGetWidth(self.mScrollView.frame)-190)/2, self.canDoView.frame.origin.y + self.canDoView.frame.size.height + 18, 190, 38);
    [self.mButton setBackgroundImage:[UIImage imageNamed:@"LeXiangPackage_next@2x"] forState:UIControlStateNormal];
    [self.mButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.mButton setTitle:@"下一步，填订单" forState:UIControlStateNormal];
    [self.mButton addTarget:self
                     action:@selector(onNextAction)
           forControlEvents:UIControlEventTouchUpInside];

    [self setPackageSelected];
    // add by liuruxian 2014-02-25
    [self resetScrollViewContent];
}

- (void)setPackageSelected
{
    UILabel *label = (UILabel *)[_mScrollView viewWithTag:kPackageSelectedLabelTag];
    NSUInteger inx = [self.info[@"index"] integerValue];
    // 根据ComboType来显示套餐名
    if ([self.info[@"combo"][@"ComboType"] isEqualToString:@"883"]) {
        // 纯流量
        //                label.text = @"飞Young纯流量套餐";
        label.text = self.info[@"combo"][@"ComboName"];
    }
    else if ([self.info[@"combo"][@"ComboType"] isEqualToString:@"881"]) {
        // 云卡
        if ([self.info[@"package"][@"PackageItem"] isKindOfClass:[NSDictionary class]]) {
            label.text = self.info[@"package"][@"PackageItem"][@"Name"];
        }
        else if ([self.info[@"package"][@"PackageItem"] isKindOfClass:[NSArray class]]) {
            label.text = self.info[@"package"][@"PackageItem"][inx][@"Name"];
        }
    }
    else if ([self.info[@"combo"][@"ComboType"] isEqualToString:@"884"]) {
        // 乐享3G上网版
        if ([self.info[@"package"][@"PackageItem"] isKindOfClass:[NSDictionary class]]) {
            label.text = [NSString stringWithFormat:@"%@%@元", self.info[@"combo"][@"ComboName"], self.info[@"package"][@"PackageItem"][@"Name"]];
        }
        else if ([self.info[@"package"][@"PackageItem"] isKindOfClass:[NSArray class]]) {
            label.text = [NSString stringWithFormat:@"%@%@元", self.info[@"combo"][@"ComboName"], self.info[@"package"][@"PackageItem"][inx][@"Name"]];
        }
    }
    
    
}

- (void)resetScrollViewContent
{
    // 重新排版界面
    [UIView beginAnimations:@"Move Up" context:nil];
    [UIView setAnimationDuration:0.5];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    {
        CGRect optRect = self.optPackageView.frame;
        optRect.origin.y = self.propertiesView.frame.origin.y + self.propertiesView.frame.size.height;
        self.optPackageView.frame = optRect;
        
        CGRect canDoRect = self.canDoView.frame;
        canDoRect.origin.y = self.optPackageView.frame.origin.y + self.optPackageView.frame.size.height;
        self.canDoView.frame = canDoRect;
        
        CGRect btnRect = self.mButton.frame;
        btnRect.origin.y = self.canDoView.frame.origin.y + self.canDoView.frame.size.height + 18;
        self.mButton.frame = btnRect;
    }
    [UIView commitAnimations];
    
    self.mScrollView.contentSize = CGSizeMake(320, self.mButton.frame.origin.y + self.mButton.frame.size.height + 16);
}

//  靓号-套餐类型查询
- (void)qryComboType
{
    NSDictionary *params = @{@"SalesProdid": self.item[@"SalesProdId"],
                             @"Number": self.item[@"PhoneNumber"]};
    
    self.qryComboTypeOpt =  [MyAppDelegate.cserviceEngine postXMLWithCode:@"qryComboType"
                                                                   params:params
                                                              onSucceeded:^(NSDictionary *dict) {
                                                                  if ([dict[@"Data"][@"ComboItem"] isKindOfClass:[NSDictionary class]])
                                                                  {
                                                                      if ([dict[@"Data"][@"ComboItem"][@"ComboType"] isEqualToString:@"881"] ||
                                                                          [dict[@"Data"][@"ComboItem"][@"ComboType"] isEqualToString:@"883"] ||
                                                                          [dict[@"Data"][@"ComboItem"][@"ComboType"] isEqualToString:@"884"]) {
                                                                          [self.comboItems addObject:dict[@"Data"][@"ComboItem"]];
                                                                      }
                                                                  }
                                                                  else if ([dict[@"Data"][@"ComboItem"] isKindOfClass:[NSArray class]])
                                                                  {
                                                                      for (NSDictionary *item in dict[@"Data"][@"ComboItem"]) {
                                                                          if ([item[@"ComboType"] isEqualToString:@"881"] ||
                                                                              [item[@"ComboType"] isEqualToString:@"883"] ||
                                                                              [item[@"ComboType"] isEqualToString:@"884"]) {
                                                                              [self.comboItems addObject:item];
                                                                          }
                                                                      }
                                                                  }
                                                                  
                                                                  if ([self.comboItems count] > 0) {
                                                                      [self qryPackageUni];
                                                                  }
                                                              }
                                                                  onError:^(NSError *engineError) {
                                                                      [self hideLoadingViewAnimated:NO];
                                                                      [SVProgressHUD showErrorWithStatus:engineError.localizedDescription];
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
                                                                  }];
}

// 选择套餐（靓号通用）
- (void)qryPackageUni
{
    NSDictionary *params = @{@"ShopId": ESHORE_ShopId,
                             @"SalesproductId": self.item[@"SalesProdId"],
                             @"PhoneNumber": self.item[@"PhoneNumber"],
                             @"ComboType": @"881",
                             @"ConvertColumn": @"1"};
    
    self.qryPackageUniOpt = [MyAppDelegate.cserviceEngine postXMLWithCode:@"qryPackageUni"
                                                                   params:params
                                                              onSucceeded:^(NSDictionary *dict) {
                                                                  
                                                                  NSMutableArray *netPackage = [[NSMutableArray alloc] init];
                                                                  
                                                                  if ([dict[@"Data"][@"Package"] isKindOfClass:[NSDictionary class]])
                                                                  {
                                                                      [netPackage addObject:dict[@"Data"][@"Package"]];
                                                                  }
                                                                  else if ([dict[@"Data"][@"Package"] isKindOfClass:[NSArray class]])
                                                                  {
                                                                      [netPackage addObjectsFromArray:dict[@"Data"][@"Package"]];
                                                                  }
                                                                  
                                                                  // 匹配数据
                                                                  if ([netPackage count] > 0) {
                                                                      for (NSDictionary *info1 in self.comboItems) {
                                                                          BOOL isInit = NO;
                                                                          for (NSDictionary *info2 in netPackage) {
                                                                              if ([info1[@"ComboType"] isEqualToString:info2[@"Type"]]) {
                                                                                  isInit = YES;
                                                                                  [self.packages addObject:info2];
                                                                                  break;
                                                                              }
                                                                          }
                                                                          if (isInit == NO) {
                                                                              [self.packages addObject:[NSNull null]];
                                                                          }
                                                                      }
                                                                  }
                                                                  [self setDefaultPackage]; // 默认跳转
                                                                  [self hideLoadingViewAnimated:YES];
                                                                  
                                                              } onError:^(NSError *engineError) {
                                                                  [self hideLoadingViewAnimated:YES];
                                                                  [SVProgressHUD showErrorWithStatus:engineError.localizedDescription];
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
                                                              }];
}

- (void)setDefaultPackage
{
    BOOL isDefault = NO;
    for (NSDictionary *dict in self.packages)
    {
        if ([dict[@"Type"] isEqualToString:@"884"])
        {
            NSMutableArray *packageItems = [[NSMutableArray alloc] init];
            if (dict[@"PackageItem"]) {
                if ([dict[@"PackageItem"] isKindOfClass:[NSDictionary class]]) {
                    [packageItems addObject:dict[@"PackageItem"]];
                }
                else if ([dict[@"PackageItem"] isKindOfClass:[NSArray class]]) {
                    [packageItems addObjectsFromArray:dict[@"PackageItem"]];
                }
                
                int j = 0;
                
                for (NSDictionary *packageItem in packageItems) {
                    if ([packageItem[@"Properties"][@"IS_DEFAULT"] isEqualToString:@"1"]) {
                        // 默认乐享3G上网版套餐
                        isDefault = YES;
                        break;
                    }
                    j++;
                }
                
                if (!isDefault) {  // 没有默认套餐,跳转到ctplanselectvctler
                    CTPackageSelectVCtler *vc = [CTPackageSelectVCtler new];
                    vc.packages = self.packages;
                    vc.comboItems = self.comboItems;
                    vc.item = self.item;
                    [self.navigationController pushViewController:vc animated:YES];
                }
                else
                {
                    // 显示默认套餐
                    self.iSDefaultPackage = YES;
                    NSDictionary *combo = nil;
                    for (NSDictionary *comboItem in self.comboItems) {
                        if ([comboItem[@"ComboType"] isEqualToString:@"884"]) {
                            combo = comboItem;
                            break;
                        }
                    }
                    
                    self.info = @{@"item": self.item,
                                @"index": [NSString stringWithFormat:@"%d", j],
                                @"combo": combo,
                                @"package": dict};
                    [self initPackage];  // 初始化选择套餐页面
                }
            }
            break;
        }
    }
    
    // 不存在乐享3G套餐
    if (!isDefault) {
        CTPackageSelectVCtler *vc = [CTPackageSelectVCtler new];
        vc.packages = self.packages;
        vc.comboItems = self.comboItems;
        vc.iSDefaultPackage = NO;
        vc.item = self.item;
        [self.navigationController pushViewController:vc animated:NO];
    }
}

- (void)onNextAction
{
    int selectedCount = 0;
    
    CTWriteOrderInfoVCtler *vc =  [[CTWriteOrderInfoVCtler alloc] init];
    
    if ([self.optPackageView.btns count] > 0) {
        for (UIButton *button in self.optPackageView.btns) {
            if (button.selected == YES) {
                selectedCount++;
            }
        }
        NSDictionary *tDict = nil;
        NSUInteger inx = [self.info[@"index"] integerValue];
        if ([self.info[@"package"][@"PackageItem"] isKindOfClass:[NSDictionary class]]) {
            tDict = self.info[@"package"][@"PackageItem"][@"OptionalPackage"];
        }
        else if ([self.info[@"package"][@"PackageItem"] isKindOfClass:[NSArray class]]) {
            tDict = self.info[@"package"][@"PackageItem"][inx][@"OptionalPackage"];
        }
        if (selectedCount < [tDict[@"MaxValueAddedServiceCount"] intValue]) {
            // 提示
            [SVProgressHUD showErrorWithStatus:[NSString stringWithFormat:@"未选择%@", tDict[@"OptName"]]];
            return;
        }
        //add by liuruxian
#define kBtnTag 1000
        
        // 拼装OptPackages数据
        NSMutableArray *OptProdIds = [[NSMutableArray alloc] init];
        for (UIButton *btn in self.optPackageView.btns) {
            if (btn.selected) {
                [OptProdIds addObject:@{@"Id": tDict[@"Services"][@"Item"][btn.tag-kBtnTag][@"Id"]}];
                DDLogInfo(@"选中的增值业务包编号 %d\n", btn.tag+kBtnTag);
            }
        }
        
        NSDictionary *OptPackages = @{@"OptSalesProdId": tDict[@"OptId"],
                                      @"OptProdId": OptProdIds};
        NSMutableDictionary *infoDict = [[NSMutableDictionary alloc] initWithDictionary:self.info];
        [infoDict setObject:OptPackages forKey:@"OptPackages"];
        
        vc.info = infoDict;
    }
    else {
        vc.info = self.info;
    }
    
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)onBackAction
{
    CTPackageSelectVCtler *vc = [CTPackageSelectVCtler new];
    
    vc.item = self.item;
    vc.iSDefaultPackage = self.iSDefaultPackage ;
    vc.info = self.info ;
    vc.packages = self.packages;
    vc.comboItems = self.comboItems;
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - PropertiesViewDelegate
- (void)resetPropertiesContent
{
    [self resetScrollViewContent];
}

#pragma mark - OptPackageViewDelegate
- (void)resetOptContent
{
    [self resetScrollViewContent];
}

#pragma mark - CanDoViewDelegate
- (void)resetCanDoContent
{
    [self resetScrollViewContent];
}

@end
