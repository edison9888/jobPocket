//
//  CTWriteOrderInfoVCtler.m
//  CTPocketV4
//
//  Created by 许忠洲 on 14-1-17.
//  Copyright (c) 2014年 广东亿迅科技有限公司. All rights reserved.
//  填写订单信息

#import "CTWriteOrderInfoVCtler.h"
#import "AppDelegate.h"
#import "SIAlertView.h"
#include "SVProgressHUD.h"
#import "COrderFillVctler.h"

@interface CTWriteOrderInfoVCtler ()
@property (strong, nonatomic) UIScrollView *mScrollView;
@property (strong, nonatomic) NSMutableArray *btns;
@property (strong, nonatomic) UILabel *tip;

@property (strong, nonatomic) NSMutableArray *cardBtns;

@property (strong, nonatomic) NSDictionary *uimCardSizeData;
@property (strong, nonatomic) NSDictionary *getPrestoresData;
@end

@implementation CTWriteOrderInfoVCtler

#pragma mark - Lazy Instantiation

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
                UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 114, 40, 41)];
                imageView.image = [UIImage imageNamed:@"LeXiangPackage_Gray@2x"];
                
                UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
                label.backgroundColor = [UIColor clearColor];
                label.font = [UIFont systemFontOfSize:14.0f];
                label.textColor = [UIColor whiteColor];
                label.textAlignment = UITextAlignmentCenter;
                label.text = @"套餐";
                [imageView addSubview:label];
                
//                [_mScrollView addSubview:imageView];
            }
            
            // 订单
            {
                UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 198, 48, 41)];
                imageView.image = [UIImage imageNamed:@"LeXiangPackage_Green@2x"];
                
                UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 48, 40)];
                label.backgroundColor = [UIColor clearColor];
                label.font = [UIFont systemFontOfSize:16.0f];
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
    }
    return _mScrollView;
}

- (NSMutableArray *)btns
{
    if (!_btns) {
        _btns = [[NSMutableArray alloc] init];
    }
    return _btns;
}

- (NSMutableArray *)cardBtns
{
    if (!_cardBtns) {
        _cardBtns = [[NSMutableArray alloc] init];
    }
    return _cardBtns;
}

#pragma Init

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
    
    // 标题
    self.title = @"填写订单信息";
    
    // 左按钮
    [self setLeftButton:[UIImage imageNamed:@"btn_back"]];
    
    [self showLoadingAnimated:YES];
    
    [self uimCardSize];
    [self getPrestores];
}

#pragma mark - Custom Method

- (void)uimCardSize
{
    NSDictionary *params = @{@"SalesProdId": self.info[@"item"][@"SalesProdId"],
                             @"ComboId": self.info[@"combo"][@"ComboId"]};
//    NSDictionary *params = @{@"SalesProdId": @"00000000D959113E34F81C72E043AA1410ACE77E",
//                             @"ComboId": @"00000000E499192AB95C5D7CE043AA1410AC29F0"};
    
    [MyAppDelegate.cserviceEngine postXMLWithCode:@"UimCardSize"
                                           params:params
                                      onSucceeded:^(NSDictionary *dict) {
                                          self.uimCardSizeData = dict;
                                          [self comboData];
                                          
                                      } onError:^(NSError *engineError) {
                                          
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

- (void)getPrestores
{
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setValue:self.info[@"item"][@"SalesProdId"] forKey:@"SalesProdId"];
    [params setValue:self.info[@"combo"][@"ComboType"] forKey:@"ComboType"];
    
    // 套餐明细ID，根据用户选择的套餐明细来指定。纯流量、积木套餐等无明细套餐，该字段省略。
    NSUInteger inx = [self.info[@"index"] integerValue];
    if ([self.info[@"combo"][@"ComboType"] isEqualToString:@"884"] || [self.info[@"combo"][@"ComboType"] isEqualToString:@"881"])
    {
        // 乐享3G上网版
        if ([self.info[@"package"][@"PackageItem"] isKindOfClass:[NSDictionary class]]) {
            [params setObject:self.info[@"package"][@"PackageItem"][@"Id"] forKey:@"ComboId"];
        }
        else if ([self.info[@"package"][@"PackageItem"] isKindOfClass:[NSArray class]]) {
            [params setObject:self.info[@"package"][@"PackageItem"][inx][@"Id"] forKey:@"ComboId"];
        }
    }
    
    [MyAppDelegate.cserviceEngine postXMLWithCode:@"getPrestores"
                                           params:params
                                      onSucceeded:^(NSDictionary *dict) {
                                          self.getPrestoresData = dict;
                                          [self comboData];
                                          
                                      } onError:^(NSError *engineError) {
                                          
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

- (void)comboData
{
    if (self.uimCardSizeData && self.getPrestoresData) {
        [self hideLoadingViewAnimated:YES];
        
        [self setScrollView];
    }
}

- (void)setScrollView
{
    [self.view addSubview:self.mScrollView];
    
    int originY = 14;
    
    UILabel *cardType = [[UILabel alloc] initWithFrame:CGRectMake(10, originY, 100, 15)];
    cardType.backgroundColor = [UIColor clearColor];
    cardType.font = [UIFont boldSystemFontOfSize:14.0f];
    cardType.textColor = [UIColor blackColor];
    cardType.text = @"选择手机卡类型";
    [self.mScrollView addSubview:cardType];
    originY = originY + 15 + 18;
    
    // 处理销售品卡尺寸配置信息
    NSMutableArray *listItem = [[NSMutableArray alloc] init];
    if (self.uimCardSizeData[@"Data"][@"ListItem"]) {
        if ([self.uimCardSizeData[@"Data"][@"ListItem"] isKindOfClass:[NSDictionary class]]) {
            [listItem addObject:self.uimCardSizeData[@"Data"][@"ListItem"]];
        }
        else if ([self.uimCardSizeData[@"Data"][@"ListItem"] isKindOfClass:[NSArray class]]) {
            [listItem addObjectsFromArray:self.uimCardSizeData[@"Data"][@"ListItem"]];
        }
    }
    if ([listItem count] > 0) {
        int originX = 22;
        int tag = 0;
        for (NSDictionary *dict in listItem) {
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            btn.frame = CGRectMake(originX, originY, 135, 34);
            [btn setBackgroundImage:[UIImage imageNamed:@"WriteOrderInfo_btn@2x"] forState:UIControlStateNormal];
            [btn setBackgroundImage:[UIImage imageNamed:@"WriteOrderInfo_btn_selected@2x"] forState:UIControlStateSelected];
            [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [btn setTitleColor:[UIColor colorWithRed:0.43 green:0.77 blue:0.21 alpha:1] forState:UIControlStateSelected];
            btn.titleLabel.font = [UIFont systemFontOfSize:14.0f];
            [btn setTitle:dict[@"Name"] forState:UIControlStateNormal];
            [btn addTarget:self
                    action:@selector(onCardBtnAction:)
          forControlEvents:UIControlEventTouchUpInside];
            btn.tag = tag;
            if (btn.tag == 0) {
                btn.selected = YES;
            }
            [self.mScrollView addSubview:btn];
            [self.cardBtns addObject:btn];
            if (originX == 22) {
                originX = 22+135+8;
            }
            else {
                originX = 22;
                originY = originY + 34 + 8;
            }
            tag++;
        }
        if (originX == 22+135+8) {
            originY = originY + 34 + 8;
        }
        originY = originY + 8;
    }
    
    UIImageView *sepatator1 = [[UIImageView alloc] initWithFrame:CGRectMake(22, originY, 280, 1)];
    sepatator1.image = [UIImage imageNamed:@"LeXiangPackage_Separator.png"];
    [self.mScrollView addSubview:sepatator1];
    originY = originY + 1;
    
    // 处理预存话费可选项
    NSMutableArray *configItems = [[NSMutableArray alloc] init];
    if (self.getPrestoresData[@"Data"][@"ConfigItem"]) {
        if ([self.getPrestoresData[@"Data"][@"ConfigItem"] isKindOfClass:[NSDictionary class]]) {
            [configItems addObject:self.getPrestoresData[@"Data"][@"ConfigItem"]];
        }
        else if ([self.getPrestoresData[@"Data"][@"ConfigItem"] isKindOfClass:[NSArray class]]) {
            [configItems addObjectsFromArray:self.getPrestoresData[@"Data"][@"ConfigItem"]];
        }
    }
    if ([configItems count] > 0) {
        
        // 显示预存话费可选项
        originY = originY + 15;
        
        // !
        UIImage *image = [UIImage imageNamed:@"WriteOrderInfo_icon1@2x"];
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(284, originY-4, 20, 20)];
        imageView.image = image;
        [self.mScrollView addSubview:imageView];
        
        UIButton *tBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        tBtn.frame = CGRectMake(284, originY-13, 30, 30);
//        tBtn.backgroundColor = [UIColor clearColor];
//        [tBtn setBackgroundImage:[UIImage imageNamed:@"WriteOrderInfo_icon1@2x"] forState:UIControlStateNormal];
        [tBtn addTarget:self
                 action:@selector(onTipAction)
       forControlEvents:UIControlEventTouchUpInside];
        [self.mScrollView addSubview:tBtn];
        
        // arrow
        UIImageView *arrow = [[UIImageView alloc] initWithFrame:CGRectMake(300, originY+12, 8, 14)];
        arrow.image = [UIImage imageNamed:@"WriteOrderInfo_icon2@2x"];
        [self.mScrollView addSubview:arrow];
        
        // 点击查看提示
        UILabel *tLabel = [[UILabel alloc] initWithFrame:CGRectMake(231, originY + 15 + 5, 70, 12)];
        tLabel.backgroundColor = [UIColor clearColor];
        tLabel.font = [UIFont boldSystemFontOfSize:11.0f];
        tLabel.textColor = [UIColor grayColor];
        tLabel.text = @"点击查看提示";
        [self.mScrollView addSubview:tLabel];
        
        UILabel *itemTitle = [[UILabel alloc] initWithFrame:CGRectMake(10, originY, 160, 15)];
        itemTitle.backgroundColor = [UIColor clearColor];
        itemTitle.font = [UIFont boldSystemFontOfSize:14.0f];
        itemTitle.textColor = [UIColor blackColor];
        itemTitle.text = @"选择号码激活预存话费";
        [self.mScrollView addSubview:itemTitle];
        originY = originY + 15 + 18;
        
        int originX = 22;
        BOOL isSelected = NO;
        int tag = 0;
        for (NSDictionary *dict in configItems) {
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            btn.frame = CGRectMake(originX, originY, 135, 34);
            [btn setBackgroundImage:[UIImage imageNamed:@"WriteOrderInfo_btn@2x"] forState:UIControlStateNormal];
            [btn setBackgroundImage:[UIImage imageNamed:@"WriteOrderInfo_btn_selected@2x"] forState:UIControlStateSelected];
            [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [btn setTitleColor:[UIColor colorWithRed:0.43 green:0.77 blue:0.21 alpha:1] forState:UIControlStateSelected];
            btn.titleLabel.font = [UIFont systemFontOfSize:14.0f];
            [btn setTitle:dict[@"Prestore"][@"Name"] forState:UIControlStateNormal];
            if (([dict[@"Default"] isEqualToString:@"true"]) &&
                (isSelected == NO)) {
                btn.selected = YES;
                isSelected = YES;
            }
            [btn addTarget:self
                    action:@selector(onPrestoreBtnAction:)
          forControlEvents:UIControlEventTouchUpInside];
            btn.tag = tag;
            [self.mScrollView addSubview:btn];
            [self.btns addObject:btn];
            if (originX == 22) {
                originX = 22+135+8;
            }
            else {
                originX = 22;
                originY = originY + 34 + 8;
            }
            tag++;
        }
        if (originX != 22) {
            originY = originY + 34 + 8;
        }
        
        // 促销政策
        int t = -1;
        for (UIButton *btn in self.btns) {
            if (btn.selected == YES) {
                t = btn.tag;
                break;
            }
        }
        if (t != -1) {
            NSString *tipStr = @"";
            if (configItems[t][@"Prestore"][@"Tip"] &&
                (![configItems[t][@"Prestore"][@"Tip"] isEqual:@"null"])) {
                self.tip = [[UILabel alloc] initWithFrame:CGRectMake(22, originY, 260, 30)];
                self.tip.backgroundColor = [UIColor clearColor];
                self.tip.font = [UIFont systemFontOfSize:14.0f];
                self.tip.textColor = [UIColor colorWithRed:0.93 green:0.36 blue:0.25 alpha:1];
                self.tip.numberOfLines = 2;
                tipStr = configItems[t][@"Prestore"][@"Tip"];
                self.tip.text = [NSString stringWithFormat:@"促销政策：%@", tipStr];
                [self.mScrollView addSubview:self.tip];
                 originY = originY + 30 + 8;
            }
            else {
//                tipStr = @"无";
                originY+=8;
            }
            
        }
        else {
//            self.tip.text = @"促销政策：无";
        }
        
        UIImageView *sepatator2 = [[UIImageView alloc] initWithFrame:CGRectMake(22, originY, 280, 1)];
        sepatator2.image = [UIImage imageNamed:@"LeXiangPackage_Separator.png"];
        [self.mScrollView addSubview:sepatator2];
        originY = originY + 1;
    }
    
    // 支付方式
    originY = originY + 15;
    
    UILabel *payTitle = [[UILabel alloc] initWithFrame:CGRectMake(10, originY, 100, 15)];
    payTitle.backgroundColor = [UIColor clearColor];
    payTitle.font = [UIFont boldSystemFontOfSize:14.0f];
    payTitle.textColor = [UIColor blackColor];
    payTitle.text = @"选择支付方式";
    [self.mScrollView addSubview:payTitle];
    originY = originY + 15 + 18;
    
    UIImageView *pay = [[UIImageView alloc] initWithFrame:CGRectMake(22, originY, 135, 34)];
    pay.image = [UIImage imageNamed:@"WriteOrderInfo_pay@2x"];
    [self.mScrollView addSubview:pay];
    
    UILabel *payLabel = [[UILabel alloc] initWithFrame:pay.bounds];
    payLabel.backgroundColor = [UIColor clearColor];
    payLabel.font = [UIFont systemFontOfSize:14.0f];
    payLabel.textColor = [UIColor colorWithRed:0.43 green:0.77 blue:0.21 alpha:1];
    payLabel.textAlignment = UITextAlignmentCenter;
    payLabel.text = @"在线支付";
    [pay addSubview:payLabel];
    
    int y = originY > 404 ? originY : 404;
    
    UIButton *commitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    commitBtn.frame = CGRectMake((CGRectGetWidth(self.mScrollView.frame)-190)/2, y, 190, 41);
    [commitBtn setBackgroundImage:[UIImage imageNamed:@"recharge_commit_btn"] forState:UIControlStateNormal];
    [commitBtn setTitle:@"下一步" forState:UIControlStateNormal];
    [commitBtn addTarget:self action:@selector(onCommitAction) forControlEvents:UIControlEventTouchUpInside];
    [self.mScrollView addSubview:commitBtn];
    
    self.mScrollView.contentSize = CGSizeMake(320, commitBtn.frame.origin.y  + commitBtn.frame.size.height + 10);
}

- (void)onCommitAction
{
    int selectedCard = -1;
    for (UIButton *button in self.cardBtns) {
        if (button.selected == YES) {
            selectedCard = button.tag;
            break;
        }
    }
    if (selectedCard == -1) {
        [SVProgressHUD showErrorWithStatus:@"请选择一个手机卡类型！"];
        return;
    }
    // 处理销售品卡尺寸配置信息
    NSMutableArray *listItem = [[NSMutableArray alloc] init];
    if (self.uimCardSizeData[@"Data"][@"ListItem"]) {
        if ([self.uimCardSizeData[@"Data"][@"ListItem"] isKindOfClass:[NSDictionary class]]) {
            [listItem addObject:self.uimCardSizeData[@"Data"][@"ListItem"]];
        }
        else if ([self.uimCardSizeData[@"Data"][@"ListItem"] isKindOfClass:[NSArray class]]) {
            [listItem addObjectsFromArray:self.uimCardSizeData[@"Data"][@"ListItem"]];
        }
    }
    NSString *UimCode = listItem[selectedCard][@"Code"];
    NSString *UimName = listItem[selectedCard][@"Name"];
    
    int selectedBtn = -1;
    if ([self.btns count] > 0) {
        for (UIButton *button in self.btns) {
            if (button.selected == YES) {
                selectedBtn = button.tag;
                break;
            }
        }
        if (selectedBtn == -1) {
            [SVProgressHUD showErrorWithStatus:@"请选择一个号码激活预存话费！"];
            return;
        }
    }
    // 处理预存话费可选项
    NSMutableArray *configItems = [[NSMutableArray alloc] init];
    if (self.getPrestoresData[@"Data"][@"ConfigItem"]) {
        if ([self.getPrestoresData[@"Data"][@"ConfigItem"] isKindOfClass:[NSDictionary class]]) {
            [configItems addObject:self.getPrestoresData[@"Data"][@"ConfigItem"]];
        }
        else if ([self.getPrestoresData[@"Data"][@"ConfigItem"] isKindOfClass:[NSArray class]]) {
            [configItems addObjectsFromArray:self.getPrestoresData[@"Data"][@"ConfigItem"]];
        }
    }
    
    NSString *CashSalesProdId = @"";
    if (selectedBtn != -1) {
        CashSalesProdId = configItems[selectedBtn][@"Prestore"][@"Code"];
    }
    

    NSMutableDictionary *infoDict = [[NSMutableDictionary alloc] initWithDictionary:self.info];
    [infoDict setObject:UimCode forKey:@"UimCode"];
    [infoDict setObject:UimName forKey:@"UimName"];
    [infoDict setObject:CashSalesProdId forKey:@"CashSalesProdId"];
    
    COrderFillVctler *vc = [[COrderFillVctler alloc] init];
    vc.info = infoDict;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)onTipAction
{
    SIAlertView *alertView = [[SIAlertView alloc] initWithTitle:@"重要提示"
                                                     andMessage:@"为保证您的号码能正常激活使用，需要您预存部分话费。\n话费预存部分请到当地电信话费营业厅按月索取发票。"];
    [alertView addButtonWithTitle:@"知道了"
                             type:SIAlertViewButtonTypeDefault
                          handler:^(SIAlertView *alertView) {
                              //
                          }];
    alertView.transitionStyle = SIAlertViewTransitionStyleBounce;
    [alertView show];
}

- (void)onCardBtnAction:(UIButton *)btn
{
    if (btn.selected) {
        // 选中以选项，不改变状态
    } else {
        for (UIButton *tBtn in self.cardBtns) {
            if ([tBtn isEqual:btn]) {
                btn.selected = !btn.selected;
            }
            else {
                tBtn.selected = NO;
            }
        }
    }
}

- (void)onPrestoreBtnAction:(UIButton *)btn
{
    for (UIButton *tBtn in self.btns) {
        if ([tBtn isEqual:btn]) {
            btn.selected = !btn.selected;
            
            NSMutableArray *configItems = [[NSMutableArray alloc] init];
            if (self.getPrestoresData[@"Data"][@"ConfigItem"]) {
                if ([self.getPrestoresData[@"Data"][@"ConfigItem"] isKindOfClass:[NSDictionary class]]) {
                    [configItems addObject:self.getPrestoresData[@"Data"][@"ConfigItem"]];
                }
                else if ([self.getPrestoresData[@"Data"][@"ConfigItem"] isKindOfClass:[NSArray class]]) {
                    [configItems addObjectsFromArray:self.getPrestoresData[@"Data"][@"ConfigItem"]];
                }
            }
            
            if (btn.selected == YES) {
                NSString *tipStr = @"";
                if ((configItems[btn.tag][@"Prestore"][@"Tip"]) &&
                    (![configItems[btn.tag][@"Prestore"][@"Tip"] isEqual:@"null"])) {
                    tipStr = configItems[btn.tag][@"Prestore"][@"Tip"];
                }
                else {
                    tipStr = @"无";
                }
                self.tip.text = [NSString stringWithFormat:@"促销政策：%@", tipStr];
            }
        }
        else {
            tBtn.selected = NO;
        }
    }
}

@end
