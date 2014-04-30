//
//  CTRedeemVCtler.m
//  CTPocketV4
//
//  Created by Mac-Eshore-01 on 14-3-12.
//  Copyright (c) 2014年 广东亿迅科技有限公司. All rights reserved.
//

#import "CTRedeemVCtler.h"
#import "CTHotExchangeVCtler.h"
#import "CTPointSortVCtler.h"
#import "EGORefreshTableHeaderView.h"
#import "IgInfo.h"
#import "IgUserInfo.h"
#import "CTPointQueryVCtler.h"

#define kButtonTag 100
NSString * const QryPointNotificaion ;

@interface CTRedeemVCtler ()

@property (nonatomic, strong) UIView *selectedView;
@property (nonatomic, strong) CTHotExchangeVCtler *hotVCtler;
@property (nonatomic, strong) CTPointSortVCtler *pointSortVCtler;

@property (nonatomic, strong) CTBaseViewController *curVCtler;
@end

@implementation CTRedeemVCtler

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(qryPoint) name:QryPointNotificaion object:nil];
    }
    return self;
}

- (void) dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.title = @"积分兑换";
    [self setLeftButton:[UIImage imageNamed:@"btn_back"]];
    [self selectedView];
    [self addChildVctler];
}

#pragma mark - control

- (UIView *)selectedView{
    if (!_selectedView) {
        NSArray *title = [NSArray arrayWithObjects:@"热门兑换",@"积分排序", nil];
        NSArray *image1Ary = [NSArray arrayWithObjects:
                              @"recharge_selected_bg.png",
                              @"recharge_selected_right", nil];
        NSArray *image2Ary = [NSArray arrayWithObjects:
                              @"recharge_unselected_bg.png",
                              @"recharge_unselected_bg.png", nil];
        
       _selectedView = [[UIView alloc] initWithFrame:CGRectMake(0,
                                                                0,
                                                                self.view.bounds.size.width,
                                                                45)];
        [self.view addSubview:_selectedView];

        float xPos = 0;
        for (int i =0; i<2; i++) {
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            [button setTitle:title[i] forState:UIControlStateNormal];
            [button.titleLabel.text UTF8String];
            [button setBackgroundImage:[UIImage imageNamed:image1Ary[i]] forState:UIControlStateSelected];
            [button setBackgroundImage:[UIImage imageNamed:image2Ary[i]] forState:UIControlStateNormal];
            button.titleLabel.font = [UIFont systemFontOfSize:16];
            [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            button.tag = kButtonTag+i;
            button.frame = CGRectMake(xPos, 0, _selectedView.frame.size.width/2, _selectedView.frame.size.height);
            [button addTarget:self action:@selector(integrationTypeAction:) forControlEvents:UIControlEventTouchUpInside];
            [_selectedView addSubview:button];
            
            xPos = CGRectGetMaxX(button.frame);
        }
        
        UIButton *button = (UIButton *)[_selectedView viewWithTag:kButtonTag];
        button.selected = YES;
    }
    
    return _selectedView;
}

- (void)addChildVctler
{
    CTHotExchangeVCtler *hotVCtler = [[CTHotExchangeVCtler alloc] init];
    [self addChildViewController:hotVCtler];
    
    hotVCtler.view.frame = CGRectMake(self.view.bounds.origin.x,
                                      45,
                                      self.view.bounds.size.width,
                                      self.view.bounds.size.height-50);
    hotVCtler.view.backgroundColor = [UIColor clearColor];
    hotVCtler.view.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth ;
    [self.view addSubview:hotVCtler.view];
    [self didMoveToParentViewController:hotVCtler];
    self.hotVCtler = hotVCtler;
    self.curVCtler = hotVCtler ;
}

#pragma mark - function

- (void)selectedExchange:(int)type
{
    if (self.curVCtler) {
        
    }
    
    switch (type) {
        case 0:
        {
            if (!self.hotVCtler) {
                CTHotExchangeVCtler *hotVCtler = [[CTHotExchangeVCtler alloc] init];
                [self addChildViewController:hotVCtler];
                hotVCtler.view.frame = CGRectMake(self.view.bounds.origin.x,
                                                  45,
                                                  self.view.bounds.size.width,
                                                  self.view.bounds.size.height-45);
                hotVCtler.view.backgroundColor = [UIColor clearColor];
                [self.view addSubview:hotVCtler.view];
                self.hotVCtler = hotVCtler ;
            }
            
            if (self.curVCtler!=self.hotVCtler) {
                //                [self transitionFromViewController:self.curVCtler
                //                                  toViewController:self.hotVCtler
                //                                          duration:0.0f
                //                                           options:UIViewAnimationOptionCurveEaseInOut
                //                                        animations:nil
                //                                        completion:nil];
                [self.curVCtler.view removeFromSuperview];
                [self.view addSubview:self.hotVCtler.view];
            }
            
            self.curVCtler = self.hotVCtler ;
        }
            break;
        case 1:
        {
            if (!self.pointSortVCtler) {
                CTPointSortVCtler *pointSortVCtler = [[CTPointSortVCtler alloc] init];
                [self addChildViewController:pointSortVCtler];
                pointSortVCtler.view.frame = CGRectMake(self.view.bounds.origin.x,
                                                        45,
                                                        self.view.bounds.size.width,
                                                        self.view.bounds.size.height-45);
                pointSortVCtler.view.backgroundColor = [UIColor clearColor];
                [self.view addSubview:pointSortVCtler.view];
                self.pointSortVCtler = pointSortVCtler ;
            }
            
            if (self.curVCtler!=self.pointSortVCtler) {
                //                [self transitionFromViewController:self.curVCtler
                //                                  toViewController:self.pointSortVCtler
                //                                          duration:0
                //                                           options:UIViewAnimationOptionCurveEaseInOut
                //                                        animations:nil
                //                                        completion:nil];
                [self.curVCtler.view removeFromSuperview];
                [self.view addSubview:self.pointSortVCtler.view];
            }
            
            self.curVCtler = self.pointSortVCtler ;
        }
            break;
            
        default:
            break;
    }
}


#pragma mark - 个人积分查询

- (void)qryPoint
{
    [[IgInfo shareIgInfo] clear]; //清空信息
    
    NSDictionary *loginInfoDict = [Global sharedInstance].loginInfoDict;
    NSString *DeviceNo = loginInfoDict[@"UserLoginName"];
    
    [[IgUserInfo shareIgUserInfo] igUserInfoWithDeviceNo:DeviceNo finishBlock:^(NSDictionary *resultParams, NSError *error) {
        if (!error) {
            NSDictionary *data = resultParams[@"Data"];
            NSString *CustId = [data objectForKey:@"CustId"];
            if (CustId) {
                [[IgInfo shareIgInfo] igInfoWithDeviceNo:DeviceNo CustId:CustId finishBlock:^(NSDictionary *resultParams, NSError *error) {
                    if (error) {
                        return;
                    }
                }];
            } else {
              
            }
        } else {
           
        }
    }];
}

#pragma mark - Action

- (void)integrationTypeAction:(UIButton *)sender
{
    UIButton *btn = (UIButton *)sender ;
    int pageIndex = btn.tag - kButtonTag;
    [self selectedExchange:pageIndex];
    for (int i=0; i<2; i++) {
        UIButton *button = (UIButton *)[self.selectedView viewWithTag:kButtonTag+i];
        if (button.tag == btn.tag) {
            button.selected = YES;
        } else {
            button.selected = NO;
        }
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
