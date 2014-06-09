//
//  CTValueAddedPackageVCtler.m
//  CTPocketV4
//
//  Created by 许忠洲 on 14-1-17.
//  Copyright (c) 2014年 广东亿迅科技有限公司. All rights reserved.
//  乐享3G增值业务包选择

#import "CTValueAddedPackageVCtler.h"
#import "PropertiesView.h"
#import "OptPackageView.h"
#import "CanDoView.h"
#import "CTWriteOrderInfoVCtler.h"
#import "SVProgressHUD.h"
#import "CTPrettyNumberVCtler.h"


@interface CTValueAddedPackageVCtler () <PropertiesViewDelegate, OptPackageViewDelegate, CanDoViewDelegate>
@property (strong, nonatomic) UIScrollView *mScrollView;
@property (strong, nonatomic) PropertiesView *propertiesView;
@property (strong, nonatomic) OptPackageView *optPackageView;
@property (strong, nonatomic) CanDoView *canDoView;
@property (strong, nonatomic) UIButton *mButton;
@end

@implementation CTValueAddedPackageVCtler

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

#pragma mark - Init

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
    self.title = @"选择套餐";
    
    // 左按钮
    [self setLeftButton:[UIImage imageNamed:@"btn_back"]];
    
    NSUInteger inx = [self.info[@"index"] integerValue];
    
    self.propertiesView = [[PropertiesView alloc] initWithFrame:CGRectMake(15, 75, 0, 0)];
    self.propertiesView.delegate = self;
    if ([self.info[@"package"][@"PackageItem"] isKindOfClass:[NSDictionary class]]) {
        [self.propertiesView setContent:self.info[@"package"][@"PackageItem"][@"Properties"]];
    }
    else if ([self.info[@"package"][@"PackageItem"] isKindOfClass:[NSArray class]]) {  //是否默认套餐
        [self.propertiesView setContent:self.info[@"package"][@"PackageItem"][inx][@"Properties"]];
    }
    [self.mScrollView addSubview:self.propertiesView];
    
    self.optPackageView = [[OptPackageView alloc] initWithFrame:CGRectMake(15, 127, 0, 0)];
    self.optPackageView.delegate = self;
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
    [self.mScrollView addSubview:self.optPackageView];
    
    self.canDoView = [[CanDoView alloc] initWithFrame:CGRectMake(15, self.optPackageView.frame.origin.y + self.optPackageView.frame.size.height, 0, 0)];
    self.canDoView.delegate = self;
    if ([self.info[@"package"][@"PackageItem"] isKindOfClass:[NSDictionary class]]) {
        [self.canDoView setContent:self.info[@"package"][@"PackageItem"][@"Properties"]];
    }
    else if ([self.info[@"package"][@"PackageItem"] isKindOfClass:[NSArray class]]) {
        [self.canDoView setContent:self.info[@"package"][@"PackageItem"][inx][@"Properties"]];
    }
    [self.mScrollView addSubview:self.canDoView];
    
    self.mButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.mButton.frame = CGRectMake((CGRectGetWidth(self.mScrollView.frame)-190)/2, self.canDoView.frame.origin.y + self.canDoView.frame.size.height + 18, 190, 38);
    [self.mButton setBackgroundImage:[UIImage imageNamed:@"LeXiangPackage_next@2x"] forState:UIControlStateNormal];
    [self.mButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.mButton setTitle:@"下一步，填订单" forState:UIControlStateNormal];
    [self.mButton addTarget:self
                     action:@selector(onNextAction)
           forControlEvents:UIControlEventTouchUpInside];
    [self.mScrollView addSubview:self.mButton];
    // add by liuruxian 2014-02-25
    [self resetScrollViewContent];
}

#pragma mark - Custom Methods

- (void)onBackAction
{
    [self.navigationController popViewControllerAnimated:NO];
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

#pragma mark - Nav

- (void)onLeftBtnAction:(id)sender
{
//    if (self.iSDefaultPackage) {
        /* 回退两层到CTPrettyNumberVCtler
        (
         "<CTPreferentialVCtler: 0x9d9b5c0>",
         "<CTPrettyNumberVCtler: 0x9e9e5f0>",
         "<CTPlanSelectVCtler: 0x13e09990>",
         "<CTValueAddedPackageVCtler: 0x14559f40>"
         )
         */
//
    [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:1] animated:YES];
//    NSArray *vcArray = self.navigationController.viewControllers ;
//    BOOL isExist = NO;
//    for (id vc in vcArray) {
//        if ([vc isKindOfClass:[CTPrettyNumberVCtler class]]) {
//            isExist = YES;
//            [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:1] animated:YES];
//        }
//    }
//    
//    if (!isExist) {
//        CTPrettyNumberVCtler *vc = [CTPrettyNumberVCtler new];
//        vc.jumpType = 1;
//        [self.navigationController pushViewController:vc animated:YES];
//    }
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
