//
//  CTFeiYoungVCtler.m
//  CTPocketV4
//
//  Created by 许忠洲 on 14-1-10.
//  Copyright (c) 2014年 广东亿迅科技有限公司. All rights reserved.
//  飞Young

#import "CTFeiYoungVCtler.h"
#import "AppDelegate.h"
#import "SIAlertView.h"

#define kFYButtonTag 1000

@interface CTFeiYoungVCtler ()
@property (strong, nonatomic) UIScrollView *mScrollView;
@property (strong, nonatomic) UIButton *btnYY1;
@property (strong, nonatomic) UIButton *btnYY2;
@property (strong, nonatomic) UIButton *btnLL1;
@property (strong, nonatomic) UIButton *btnLL2;
@property (strong, nonatomic) UIButton *btnDX1;
@property (strong, nonatomic) UIButton *btnDX2;
@property (strong, nonatomic) UILabel *giftLabel;
@property (strong, nonatomic) UILabel *packageCountLabel;
@property (strong, nonatomic) UIImageView *detailBgImageView;
@property (strong, nonatomic) UILabel *detailLabel;
@property (strong, nonatomic) UIButton *packageBtn;
@end

@implementation CTFeiYoungVCtler

#pragma mark - Lazy Instantiation

- (UIScrollView *)mScrollView
{
    if (!_mScrollView) {
        _mScrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
        _mScrollView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
        _mScrollView.backgroundColor = [UIColor clearColor];
        [self.view addSubview:_mScrollView];
    }
    return _mScrollView;
}

- (UIImageView *)detailBgImageView
{
    if (!_detailBgImageView) {
        _detailBgImageView = [[UIImageView alloc] initWithFrame:CGRectMake(12, 244, 295, 106)];
        UIImage *image = [UIImage imageNamed:@"LeXiang3G_DetailBg"];
        UIImage *resizeImage = [image resizableImageWithCapInsets:UIEdgeInsetsMake(image.size.height/2, 0, image.size.height/2, 0)];
        _detailBgImageView.image = resizeImage;
        [self.mScrollView addSubview:_detailBgImageView];
    }
    return _detailBgImageView;
}

- (UILabel *)detailLabel
{
    if (!_detailLabel) {
        _detailLabel = [[UILabel alloc] initWithFrame:CGRectMake(6, 24, 283, 0)];
        _detailLabel.backgroundColor = [UIColor clearColor];
        _detailLabel.font = [UIFont systemFontOfSize:12.0f];
        _detailLabel.textColor = [UIColor blackColor];
        [self.detailBgImageView addSubview:_detailLabel];
    }
    return _detailLabel;
}
- (UIButton *)packageBtn
{
    if (!_packageBtn) {
        _packageBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _packageBtn.frame = CGRectMake(24, 0, 272, 41);
        [_packageBtn setBackgroundImage:[UIImage imageNamed:@"recharge_commit_btn"] forState:UIControlStateNormal];
        [_packageBtn setTitle:@"确定" forState:UIControlStateNormal];
        [_packageBtn addTarget:self action:@selector(onPackageAction) forControlEvents:UIControlEventTouchUpInside];
        [self.mScrollView addSubview:_packageBtn];
    }
    return _packageBtn;
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
    
    // 基础套餐
    UILabel *titleLabel1 = [[UILabel alloc] initWithFrame:CGRectMake(20, 10, 100, 18)];
    titleLabel1.backgroundColor = [UIColor clearColor];
    titleLabel1.font = [UIFont boldSystemFontOfSize:16.0f];
    titleLabel1.textColor = [UIColor blackColor];
    titleLabel1.text = @"基础套餐";
    [self.mScrollView addSubview:titleLabel1];
    
    // 套餐加包
    UILabel *titleLabel2 = [[UILabel alloc] initWithFrame:CGRectMake(188, 10, 100, 18)];
    titleLabel2.backgroundColor = [UIColor clearColor];
    titleLabel2.font = [UIFont boldSystemFontOfSize:16.0f];
    titleLabel2.textColor = [UIColor blackColor];
    titleLabel2.text = @"套餐加包";
    [self.mScrollView addSubview:titleLabel2];
    
    // 基础套餐
    UIImageView *packageImageView = [[UIImageView alloc] initWithFrame:CGRectMake(14, 60, 63, 78)];
    packageImageView.image = [UIImage imageNamed:@"FeiYoung_Btn1"];
    [self.mScrollView addSubview:packageImageView];
    
    UILabel *packageLabel = [[UILabel alloc] initWithFrame:packageImageView.frame];
    packageLabel.backgroundColor = [UIColor clearColor];
    packageLabel.font = [UIFont boldSystemFontOfSize:15.0f];
    packageLabel.textColor = [UIColor colorWithRed:0.43 green:0.78 blue:0.22 alpha:1];
    packageLabel.textAlignment = UITextAlignmentCenter;
    packageLabel.numberOfLines = 3;
    packageLabel.text = @"300M\n省内流量\n19元/月";
    [self.mScrollView addSubview:packageLabel];
    
    // 加号
    UIImageView *icon1 = [[UIImageView alloc] initWithFrame:CGRectMake(82, 95, 11, 11)];
    icon1.image = [UIImage imageNamed:@"FeiYoung_Icon1@2x"];
    [self.mScrollView addSubview:icon1];
    
    // 语音套餐包
    UIView *packageView1 = [[UIView alloc] initWithFrame:CGRectMake(100, 34, 214, 40)];
    packageView1.backgroundColor = [UIColor colorWithRed:0.91 green:0.91 blue:0.91 alpha:1];
    {
        UIImageView *icon = [[UIImageView alloc] initWithFrame:CGRectMake(5, (40-12)/2, 22, 15)];
        icon.image = [UIImage imageNamed:@"FeiYoung_Icon2@2x"];
        [packageView1 addSubview:icon];
        
        UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(32, 0, 32, 40)];
        title.backgroundColor = [UIColor clearColor];
        title.font = [UIFont boldSystemFontOfSize:15.0f];
        title.textColor = [UIColor blackColor];
        title.text = @"语音";
        [packageView1 addSubview:title];
        
        //add by liuruxian 2014-03-06
        
        UIImage *img = [UIImage imageNamed:@"FeiYoung_Btn2@2x"];
        UIImage *img1 = [UIImage imageNamed:@"FeiYoung_Btn2_Selected@2x"];
        
        UIImage *image = [img resizableImageWithCapInsets:UIEdgeInsetsMake(img.size.height/2, img.size.width/2, img.size.height/2, img.size.width/2)];
        UIImage *image1 = [img1 resizableImageWithCapInsets:UIEdgeInsetsMake(img1.size.height/2, img1.size.width/2, img1.size.height/2, img1.size.width/2)];
        
        self.btnYY1 = [UIButton buttonWithType:UIButtonTypeCustom];
        self.btnYY1.frame = CGRectMake(66, 3, 66, 40-6);
        [self.btnYY1 setBackgroundImage:image/*[UIImage imageNamed:@"FeiYoung_Btn2@2x"]*/ forState:UIControlStateNormal];
        [self.btnYY1 setBackgroundImage:image1/*[UIImage imageNamed:@"FeiYoung_Btn2_Selected@2x"]*/ forState:UIControlStateSelected];
        self.btnYY1.titleLabel.font = [UIFont systemFontOfSize:15.0f];
        [self.btnYY1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self.btnYY1 setTitleColor:[UIColor colorWithRed:0.43 green:0.78 blue:0.22 alpha:1] forState:UIControlStateSelected];
//        [self.btnYY1 setTitle:@"70分钟" forState:UIControlStateNormal];
        [self.btnYY1 addTarget:self action:@selector(onPackageAction:) forControlEvents:UIControlEventTouchUpInside];
        self.btnYY1.tag = kFYButtonTag;//7120110000300001;
        [packageView1 addSubview:self.btnYY1];
        
        //add by liuruxian 2014-03-06
        UILabel *label = [[UILabel alloc] initWithFrame:self.btnYY1.bounds];
        label.backgroundColor = [UIColor clearColor];
        label.font = [UIFont systemFontOfSize:12];
        label.numberOfLines = 0;
        label.text = @"70分钟\n10元/月";
        label.textAlignment = UITextAlignmentCenter ;
        label.textColor = [UIColor blackColor];
        [self.btnYY1 addSubview:label];
        
        self.btnYY2 = [UIButton buttonWithType:UIButtonTypeCustom];
        self.btnYY2.frame = CGRectMake(142, 3, 66, 40-6);
        [self.btnYY2 setBackgroundImage:image/*[UIImage imageNamed:@"FeiYoung_Btn2@2x"]*/ forState:UIControlStateNormal];
        [self.btnYY2 setBackgroundImage:image1/*[UIImage imageNamed:@"FeiYoung_Btn2_Selected@2x"]*/ forState:UIControlStateSelected];
        self.btnYY2.titleLabel.font = [UIFont systemFontOfSize:15.0f];
        [self.btnYY2 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self.btnYY2 setTitleColor:[UIColor colorWithRed:0.43 green:0.78 blue:0.22 alpha:1] forState:UIControlStateSelected];
//        [self.btnYY2 setTitle:@"150分钟" forState:UIControlStateNormal];
        [self.btnYY2 addTarget:self action:@selector(onPackageAction:) forControlEvents:UIControlEventTouchUpInside];
        self.btnYY2.tag = kFYButtonTag+1;//7120110000300002;
        [packageView1 addSubview:self.btnYY2];
        
        //add by liuruxian 2014-03-06
        UILabel *label1 = [[UILabel alloc] initWithFrame:self.btnYY1.bounds];
        label1.backgroundColor = [UIColor clearColor];
        label1.font = [UIFont systemFontOfSize:12];
        label1.numberOfLines = 0;
        label1.text = @"150分钟\n20元/月";
        label1.textAlignment = UITextAlignmentCenter ;
        label1.textColor = [UIColor blackColor];
        [self.btnYY2 addSubview:label1];
    }
    [self.mScrollView addSubview:packageView1];
    
    // 流量套餐包
    UIView *packageView2 = [[UIView alloc] initWithFrame:CGRectMake(100, 34+48, 214, 40)];
    packageView2.backgroundColor = [UIColor colorWithRed:0.91 green:0.91 blue:0.91 alpha:1];
    {
        UIImageView *icon = [[UIImageView alloc] initWithFrame:CGRectMake(5, (40-12)/2, 22, 15)];
        icon.image = [UIImage imageNamed:@"FeiYoung_Icon3@2x"];
        [packageView2 addSubview:icon];
        
        UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(32, 0, 32, 40)];
        title.backgroundColor = [UIColor clearColor];
        title.font = [UIFont boldSystemFontOfSize:15.0f];
        title.textColor = [UIColor blackColor];
        title.text = @"流量";
        [packageView2 addSubview:title];
        
        self.btnLL1 = [UIButton buttonWithType:UIButtonTypeCustom];
        self.btnLL1.frame = CGRectMake(66, 3, 66, 40-6);
        [self.btnLL1 setBackgroundImage:[UIImage imageNamed:@"FeiYoung_Btn2@2x"] forState:UIControlStateNormal];
        [self.btnLL1 setBackgroundImage:[UIImage imageNamed:@"FeiYoung_Btn2_Selected@2x"] forState:UIControlStateSelected];
        self.btnLL1.titleLabel.font = [UIFont systemFontOfSize:15.0f];
        [self.btnLL1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self.btnLL1 setTitleColor:[UIColor colorWithRed:0.43 green:0.78 blue:0.22 alpha:1] forState:UIControlStateSelected];
//        [self.btnLL1 setTitle:@"60M" forState:UIControlStateNormal];
        [self.btnLL1 addTarget:self action:@selector(onPackageAction:) forControlEvents:UIControlEventTouchUpInside];
        self.btnLL1.tag = kFYButtonTag+2;//7240110000100002;
        [packageView2 addSubview:self.btnLL1];
        
        //add by liuruxian 2014-03-06
        UILabel *label = [[UILabel alloc] initWithFrame:self.btnYY1.bounds];
        label.backgroundColor = [UIColor clearColor];
        label.font = [UIFont systemFontOfSize:12];
        label.numberOfLines = 0;
        label.text = @"60M\n10元/月";
        label.textAlignment = UITextAlignmentCenter ;
        label.textColor = [UIColor blackColor];
        [self.btnLL1 addSubview:label];
        
        self.btnLL2 = [UIButton buttonWithType:UIButtonTypeCustom];
        self.btnLL2.frame = CGRectMake(142, 3, 66, 40-6);
        [self.btnLL2 setBackgroundImage:[UIImage imageNamed:@"FeiYoung_Btn2@2x"] forState:UIControlStateNormal];
        [self.btnLL2 setBackgroundImage:[UIImage imageNamed:@"FeiYoung_Btn2_Selected@2x"] forState:UIControlStateSelected];
        self.btnLL2.titleLabel.font = [UIFont systemFontOfSize:15.0f];
        [self.btnLL2 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self.btnLL2 setTitleColor:[UIColor colorWithRed:0.43 green:0.78 blue:0.22 alpha:1] forState:UIControlStateSelected];
//        [self.btnLL2 setTitle:@"300M" forState:UIControlStateNormal];
        [self.btnLL2 addTarget:self action:@selector(onPackageAction:) forControlEvents:UIControlEventTouchUpInside];
        self.btnLL2.tag = kFYButtonTag+3;//7240110000100004;
        [packageView2 addSubview:self.btnLL2];
        
        //add by liuruxian 2014-03-06
        UILabel *label1 = [[UILabel alloc] initWithFrame:self.btnYY1.bounds];
        label1.backgroundColor = [UIColor clearColor];
        label1.font = [UIFont systemFontOfSize:12];
        label1.numberOfLines = 0;
        label1.text = @"300M\n30元/月";
        label1.textAlignment = UITextAlignmentCenter ;
        label1.textColor = [UIColor blackColor];
        [self.btnLL2 addSubview:label1];
    }
    [self.mScrollView addSubview:packageView2];
    
    // 短信套餐包
    UIView *packageView3 = [[UIView alloc] initWithFrame:CGRectMake(100, 34+48+48, 214, 40)];
    packageView3.backgroundColor = [UIColor colorWithRed:0.91 green:0.91 blue:0.91 alpha:1];
    {
        UIImageView *icon = [[UIImageView alloc] initWithFrame:CGRectMake(5, (40-12)/2, 22, 15)];
        icon.image = [UIImage imageNamed:@"FeiYoung_Icon4@2x"];
        [packageView3 addSubview:icon];
        
        UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(32, 0, 32, 40)];
        title.backgroundColor = [UIColor clearColor];
        title.font = [UIFont boldSystemFontOfSize:15.0f];
        title.textColor = [UIColor blackColor];
        title.text = @"短信";
        [packageView3 addSubview:title];
        
        self.btnDX1 = [UIButton buttonWithType:UIButtonTypeCustom];
        self.btnDX1.frame = CGRectMake(66, 3, 66, 40-6);
        [self.btnDX1 setBackgroundImage:[UIImage imageNamed:@"FeiYoung_Btn2@2x"] forState:UIControlStateNormal];
        [self.btnDX1 setBackgroundImage:[UIImage imageNamed:@"FeiYoung_Btn2_Selected@2x"] forState:UIControlStateSelected];
        self.btnDX1.titleLabel.font = [UIFont systemFontOfSize:15.0f];
        [self.btnDX1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self.btnDX1 setTitleColor:[UIColor colorWithRed:0.43 green:0.78 blue:0.22 alpha:1] forState:UIControlStateSelected];
//        [self.btnDX1 setTitle:@"80条" forState:UIControlStateNormal];
        [self.btnDX1 addTarget:self action:@selector(onPackageAction:) forControlEvents:UIControlEventTouchUpInside];
        self.btnDX1.tag = kFYButtonTag+4;//7320110000300001;
        [packageView3 addSubview:self.btnDX1];
        
        //add by liuruxian 2014-03-06
        UILabel *label = [[UILabel alloc] initWithFrame:self.btnYY1.bounds];
        label.backgroundColor = [UIColor clearColor];
        label.font = [UIFont systemFontOfSize:12];
        label.numberOfLines = 0;
        label.text = @"80条\n5元/月";
        label.textAlignment = UITextAlignmentCenter ;
        label.textColor = [UIColor blackColor];
        [self.btnDX1 addSubview:label];
        
        self.btnDX2 = [UIButton buttonWithType:UIButtonTypeCustom];
        self.btnDX2.frame = CGRectMake(142, 3, 66, 40-6);
        [self.btnDX2 setBackgroundImage:[UIImage imageNamed:@"FeiYoung_Btn2@2x"] forState:UIControlStateNormal];
        [self.btnDX2 setBackgroundImage:[UIImage imageNamed:@"FeiYoung_Btn2_Selected@2x"] forState:UIControlStateSelected];
        self.btnDX2.titleLabel.font = [UIFont systemFontOfSize:15.0f];
        [self.btnDX2 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self.btnDX2 setTitleColor:[UIColor colorWithRed:0.43 green:0.78 blue:0.22 alpha:1] forState:UIControlStateSelected];
//        [self.btnDX2 setTitle:@"200条" forState:UIControlStateNormal];
        [self.btnDX2 addTarget:self action:@selector(onPackageAction:) forControlEvents:UIControlEventTouchUpInside];
        self.btnDX2.tag = kFYButtonTag+5;//7320110000300002;
        [packageView3 addSubview:self.btnDX2];
        
        //add by liuruxian 2014-03-06
        UILabel *label1 = [[UILabel alloc] initWithFrame:self.btnYY1.bounds];
        label1.backgroundColor = [UIColor clearColor];
        label1.font = [UIFont systemFontOfSize:12];
        label1.numberOfLines = 0;
        label1.text = @"200条\n10元/月";
        label1.textAlignment = UITextAlignmentCenter ;
        label1.textColor = [UIColor blackColor];
        [self.btnDX2 addSubview:label1];
    }
    [self.mScrollView addSubview:packageView3];
    
    // 赠品
    self.giftLabel = [[UILabel alloc] initWithFrame:CGRectMake(50, 178, 220, 16)];
    self.giftLabel.backgroundColor = [UIColor clearColor];
    self.giftLabel.font = [UIFont systemFontOfSize:14.0f];
    self.giftLabel.textColor = [UIColor blackColor];
    self.giftLabel.text = @"赠品：查询中...";
    [self.mScrollView addSubview:self.giftLabel];
    
    [self getGifts];
    
    // 套餐合计
    UIView *packageCountView = [[UIView alloc] initWithFrame:CGRectMake(4, 202, 312, 38)];
    packageCountView.backgroundColor = [UIColor colorWithRed:0.91 green:0.91 blue:0.91 alpha:1];
    [self.mScrollView addSubview:packageCountView];
    
    UILabel *packTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(80, 0, 90, 38)];
    packTitleLabel.backgroundColor = [UIColor clearColor];
    packTitleLabel.font = [UIFont systemFontOfSize:18.0f];
    packTitleLabel.textColor = [UIColor blackColor];
    packTitleLabel.text = @"套餐合计：";
    [packageCountView addSubview:packTitleLabel];
    
    self.packageCountLabel = [[UILabel alloc] initWithFrame:CGRectMake(168, 0, 140, 38)];
    self.packageCountLabel.backgroundColor = [UIColor clearColor];
    self.packageCountLabel.font = [UIFont systemFontOfSize:18.0f];
    self.packageCountLabel.textColor = [UIColor redColor];
    self.packageCountLabel.text = @"19元/月";
    [packageCountView addSubview:self.packageCountLabel];
    
    // add by liuruxian 2014-04-21
    [self setSelectedBtn];
    // 设置下方详情内容
    [self resetDetailLabel];
}

// add by liuruxian 2014-04-21
- (void)setSelectedBtn
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSDictionary *dictionary = [userDefaults objectForKey:@"FeiYoung"];
    if (dictionary)
    {
        do{
            UIButton *button ; int tag = 0;
            if ([dictionary objectForKey:@"VoiceCode"]) {
                tag = [[dictionary objectForKey:@"VoiceCode"]integerValue];
                button = (UIButton *)[_mScrollView viewWithTag:tag];
                if (button) {
                    button.selected = YES;
                }
            }
            if ([dictionary objectForKey:@"FlowCode"]) {
                tag = [[dictionary objectForKey:@"FlowCode"] longLongValue];
                button = (UIButton *)[_mScrollView viewWithTag:tag];
                if (button) {
                    button.selected = YES;
                }
            }
            if ([dictionary objectForKey:@"SmsCode"]) {
                tag = [[dictionary objectForKey:@"SmsCode"] longLongValue];
                button = (UIButton *)[_mScrollView viewWithTag:tag];
                if (button) {
                    button.selected = YES;
                }
            }
            
            break;
            
        }while(YES) ;
        
        [self resetPrice];
        [self resetDetailLabel];
    }
}

#pragma mark - Custom Methods

- (void)onPackageAction:(UIButton *)btn
{
    btn.selected = !btn.selected;
    
    if (btn == self.btnYY1) {
        if (self.btnYY2.selected == YES) {
            self.btnYY2.selected = NO;
        }
    }
    else if (btn == self.btnYY2) {
        if (self.btnYY1.selected == YES) {
            self.btnYY1.selected = NO;
        }
    }
    else if (btn == self.btnLL1) {
        if (self.btnLL2.selected == YES) {
            self.btnLL2.selected = NO;
        }
    }
    else if (btn == self.btnLL2) {
        if (self.btnLL1.selected == YES) {
            self.btnLL1.selected = NO;
        }
    }
    else if (btn == self.btnDX1) {
        if (self.btnDX2.selected == YES) {
            self.btnDX2.selected = NO;
        }
    }
    else if (btn == self.btnDX2) {
        if (self.btnDX1.selected == YES) {
            self.btnDX1.selected = NO;
        }
    }
    
    [self resetPrice];
    [self resetDetailLabel];
}

- (void)resetDetailLabel
{
    NSString *yy = @"0";
    NSString *ll = @"0";
    NSString *dx = @"0";
    
    if (self.btnYY1.selected) {
        yy = @"70";
    }
    else if (self.btnYY2.selected) {
        yy = @"150";
    }
    
    if (self.btnLL1.selected) {
        ll = @"60";
    }
    else if (self.btnLL2.selected) {
        ll = @"300";
    }
    
    if (self.btnDX1.selected) {
        dx = @"80";
    }
    else if (self.btnDX2.selected) {
        dx = @"200";
    }
    
    self.detailLabel.text = [NSString stringWithFormat:@"语音%@分钟/月,省内流量300M/月\n短信%@条/月,国内流量%@M/月。", yy, dx,ll];
    //add by liuruxian 2014-03-06
//    self.detailLabel.text = [NSString stringWithFormat:@"语音%@分钟/月,省内300M/月\n短信%@条/月,省外%@M/月。", yy, dx,ll];
    // 调整UI
    self.detailLabel.frame = CGRectMake(6, 24, 283, 0);
    self.detailLabel.numberOfLines = 0;
    [self.detailLabel sizeToFit];
    CGRect imageRect = self.detailBgImageView.frame;
    imageRect.size.height = 24.0f + self.detailLabel.frame.size.height + 10.0f;
    self.detailBgImageView.frame = imageRect;
    
    CGRect btnRect = self.packageBtn.frame;
    btnRect.origin.y = self.detailBgImageView.frame.origin.y + self.detailBgImageView.frame.size.height + 20.0f;
    self.packageBtn.frame = btnRect;
    
    self.mScrollView.contentSize = CGSizeMake(320, self.packageBtn.frame.origin.y + self.packageBtn.frame.size.height + 25.0f);}

- (void)resetPrice
{
    NSUInteger pCount = 19;
    
    if (self.btnYY1.selected) {
        pCount = pCount + 10;
    }
    else if (self.btnYY2.selected) {
        pCount = pCount + 20;
    }
    
    if (self.btnLL1.selected) {
        pCount = pCount + 10;
    }
    else if (self.btnLL2.selected) {
        pCount = pCount + 30;
    }
    
    if (self.btnDX1.selected) {
        pCount = pCount + 5;
    }
    else if (self.btnDX2.selected) {
        pCount = pCount + 10;
    }
    
    self.packageCountLabel.text = [NSString stringWithFormat:@"%d元/月", pCount];
}

- (void)getGifts
{
    NSDictionary *params = @{@"SalesProdId": self.salesProdid};
    
    [MyAppDelegate.cserviceEngine postXMLWithCode:@"getGifts"
                                           params:params
                                      onSucceeded:^(NSDictionary *dict) {
                                          
                                          NSMutableArray *giftItems = [[NSMutableArray alloc] init];
                                          
                                          if (dict[@"Data"]) {
                                              if ([dict[@"Data"][@"GiftItem"] isKindOfClass:[NSDictionary class]]) {
                                                  [giftItems addObject:dict[@"Data"][@"GiftItem"]];
                                              }else if ([dict[@"Data"][@"GiftItem"] isKindOfClass:[NSArray class]]) {
                                                  [giftItems addObjectsFromArray:dict[@"Data"][@"GiftItem"]];
                                              }
                                              
                                              if ([giftItems count] > 0) {
                                                  NSMutableString *giftStr = [[NSMutableString alloc] init];
                                                  for (NSDictionary *giftItem in giftItems) {
                                                      [giftStr appendFormat:@"%@x%@ ", giftItem[@"Name"], giftItem[@"Count"]];
                                                  }
                                                  self.giftLabel.text = giftStr;
                                              }
                                              else {
                                                  self.giftLabel.text = @"赠品：无";
                                              }
                                              
                                          }
                                          else {
                                              self.giftLabel.text = @"赠品：无";
                                          }
                                      } onError:^(NSError *engineError) {
                                          
                                          self.giftLabel.text = @"";
                                          
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

- (void)onPackageAction
{
    // added by zy, 2014-02-17
    if (self.item[@"MinAmount"])
    {
        DDLogInfo(@"%f----%d", [self.item[@"MinAmount"] floatValue], [self.packageCountLabel.text intValue]);
        if ([self.item[@"MinAmount"] floatValue] > [self.packageCountLabel.text intValue])
        {
            
            NSString *message = [NSString stringWithFormat:@"该靓号的月最低消费%@元，请选择不低于%@元的套餐。", self.item[@"MinAmount"], self.item[@"MinAmount"]];
            
            SIAlertView *aletView = [[SIAlertView alloc] initWithTitle:nil
                                                            andMessage:message];
            [aletView addButtonWithTitle:@"确定"
                                    type:SIAlertViewButtonTypeDefault
                                 handler:^(SIAlertView *alertView) {
                                     //
                                 }];
            aletView.transitionStyle = SIAlertViewTransitionStyleBounce;
            [aletView show];
            
            return;
        }
    }
    
    // added by zy, 2014-02-17
    NSMutableDictionary *BlockInfo = [[NSMutableDictionary alloc] init];
    // 根据选择，构造一个和乐享3G一样的数据结构p
    NSString *TS_YY = @"BD:0";
    NSString *VoiceCode = nil;
    NSString *TC_YY_CANDO = @"每天打电话 0次";
    if (self.btnYY1.selected) {
        TS_YY = @"BD:70";
        VoiceCode = @"7120110000300001";
        TC_YY_CANDO = @"每天打电话 1~3次";
//        [BlockInfo setObject:@"7120110000300001" forKey:@"VoiceCode"];
        // modified by liuruxian 2014-04-21
        [BlockInfo setObject:[NSString stringWithFormat:@"%d",kFYButtonTag] forKey:@"VoiceCode"];
    }
    else if (self.btnYY2.selected) {
        TS_YY = @"BD:150";
        VoiceCode = @"7120110000300002";
        TC_YY_CANDO = @"每天打电话 2~5次";
//        [BlockInfo setObject:@"7120110000300002" forKey:@"VoiceCode"];
        // modified by liuruxian 2014-04-21
        [BlockInfo setObject:[NSString stringWithFormat:@"%d",kFYButtonTag+1] forKey:@"VoiceCode"];
    }
    
    NSString *TS_LL = @"300MB";
    NSString *FlowCode = nil;
    NSString *TC_LL_CANDO = @"下载游戏 60个<br>浏览视频 6个<br>下载歌曲 100首<br>阅读小说 5173篇";
    if (self.btnLL1.selected) {
        TS_LL = @"360MB";
        FlowCode = @"7240110000100002";
        TC_LL_CANDO = @"下载游戏 72个<br>浏览视频 8个<br>下载歌曲 120首<br>阅读小说 6207篇";
//        [BlockInfo setObject:@"7240110000100002" forKey:@"FlowCode"];
        // modified by liuruxian 2014-04-21
        [BlockInfo setObject:[NSString stringWithFormat:@"%d",kFYButtonTag+2] forKey:@"FlowCode"];
    }
    else if (self.btnLL2.selected) {
        TS_LL = @"600MB";
        FlowCode = @"7240110000100004";
        TC_LL_CANDO = @"下载游戏 120个<br>浏览视频 12个<br>下载歌曲 200首<br>阅读小说 10345篇";
//        [BlockInfo setObject:@"7240110000100004" forKey:@"FlowCode"];
        // modified by liuruxian 2014-04-21
        [BlockInfo setObject:[NSString stringWithFormat:@"%d",kFYButtonTag+3] forKey:@"FlowCode"];
    }
    
    NSString *TS_DX = @"0";
    NSString *SmsCode = nil;
    NSString *TC_DX_CANDO = @"每天发短信 0条";
    if (self.btnDX1.selected) {
        TS_DX = @"80";
        SmsCode = @"7320110000300001";
        TC_DX_CANDO = @"每天发短信 2~5条";
//        [BlockInfo setObject:@"7320110000300001" forKey:@"SmsCode"];
        // modified by liuruxian 2014-04-21
        [BlockInfo setObject:[NSString stringWithFormat:@"%d",kFYButtonTag+4] forKey:@"SmsCode"];
    }
    else if (self.btnDX2.selected) {
        TS_DX = @"200";
        SmsCode = @"7320110000300002";
        TC_DX_CANDO = @"每天发短信 6~9条";
//        [BlockInfo setObject:@"7320110000300002" forKey:@"SmsCode"];
        // modified by liuruxian 2014-04-21
        [BlockInfo setObject:[NSString stringWithFormat:@"%d",kFYButtonTag+5] forKey:@"SmsCode"];
    }

    
    NSDictionary *property = @{@"TS_NAME":@"纯流量套餐",
                               @"TS_YY": TS_YY,
                               @"TS_CX": @"0",
                               @"TS_LL": TS_LL,
                               @"TS_DX": TS_DX,
                               @"TS_WIFI": @"0",
                               @"SmsCode": (SmsCode ? SmsCode : [NSNull null]),
                               @"FlowCode": (FlowCode ? FlowCode : [NSNull null]),
                               @"VoiceCode": (VoiceCode ? VoiceCode : [NSNull null]),
                               @"TC_YY_CANDO": TC_YY_CANDO,
                               @"TC_LL_CANDO" : TC_LL_CANDO,
                               @"TC_DX_CANDO" : TC_DX_CANDO};
    
    NSDictionary *pItem = @{@"OptionalPackage": [NSNull null],
                            @"Name": @"飞Young纯流量",        //add by liuruxian 2014-03-06
                            @"Properties": property};
    
    NSDictionary *p = @{@"PackageName": self.package[@"PackageName"],
                        @"Type": self.package[@"Type"],
                        @"PackageItem": pItem};
    
    //add by liuruxian 2014-03-06
    NSString *price = self.packageCountLabel.text ;
    price = [price substringToIndex:price.length-2];
    price = [NSString stringWithFormat:@"飞Young纯流量%@",price];
    NSMutableDictionary *dictionary = [NSMutableDictionary dictionaryWithDictionary:self.combo];
    [dictionary setObject:price forKey:@"ComboName"];
    NSDictionary *tempCombo = [NSDictionary dictionaryWithDictionary:dictionary];
    
    if ([BlockInfo count] > 0) {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"选择飞Young"
                                                            object:@{@"index": @"0",
                                                                     @"combo": tempCombo/*self.combo*/,
                                                                     @"package": p,
                                                                     @"blockInfo": BlockInfo}];
    }
    else {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"选择飞Young"
                                                            object:@{@"index": @"0",
                                                                     @"combo":tempCombo /*self.combo*/,
                                                                     @"package": p}];
    }
    
    // add by liuruxian2014-04-21
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:BlockInfo forKey:@"FeiYoung"];
    [defaults synchronize];
}

@end
