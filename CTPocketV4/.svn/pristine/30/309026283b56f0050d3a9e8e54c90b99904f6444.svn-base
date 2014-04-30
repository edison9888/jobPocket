//
//  CTQryServiceHallVCtler.m
//  CTPocketV4
//
//  Created by apple on 13-11-19.
//  Copyright (c) 2013年 广东亿迅科技有限公司. All rights reserved.
//

#import "CTQryServiceHallVCtler.h"
#import "CTServiceHallListVCtler.h"
#import "CTServiceHallMapVCtler.h"
#import "HaobaiMapHelper.h"

typedef enum ServiceHallViewType_
{
    ServiceHallViewTypeList = 0,
    ServiceHallViewTypeMap,
}ServiceHallViewType;

@interface CTQryServiceHallVCtler ()
{
    CTServiceHallListVCtler *      _listVCtler;
    CTServiceHallMapVCtler *       _mapVCtler;
    
    ServiceHallViewType            _viewType;
}

@end

@implementation CTQryServiceHallVCtler

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onShowMapViewNotification:) name:kShowWifiMapView object:nil];
    }
    return self;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.title = @"查询附近营业厅";
    self.view.backgroundColor = PAGEVIEW_BG_COLOR;
    [self setLeftButton:[UIImage imageNamed:@"btn_back"]];
    [self setRightButton:[UIImage imageNamed:@"icon_map"]];
    _viewType = ServiceHallViewTypeList;
    
    _listVCtler = [CTServiceHallListVCtler new];
    _listVCtler.view.frame = self.view.bounds;
    [self.view addSubview:_listVCtler.view];
    [self addChildViewController:_listVCtler];
    
    _mapVCtler = [CTServiceHallMapVCtler new];
    _mapVCtler.view.frame = self.view.bounds;
    [self addChildViewController:_mapVCtler];
    
    [HaobaiMapHelper checkLocationServiceEnableAndTipMsg];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [_mapVCtler addObserver:_listVCtler forKeyPath:@"userCurrentLocation" options:NSKeyValueObservingOptionNew context:nil];
    [_mapVCtler addObserver:_listVCtler forKeyPath:@"userAddrinfo" options:NSKeyValueObservingOptionNew context:nil];
    [_listVCtler addObserver:_mapVCtler forKeyPath:@"dataList" options:NSKeyValueObservingOptionNew context:nil];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [_mapVCtler removeObserver:_listVCtler forKeyPath:@"userCurrentLocation" context:nil];
    [_mapVCtler removeObserver:_listVCtler forKeyPath:@"userAddrinfo" context:nil];
    [_listVCtler removeObserver:_mapVCtler forKeyPath:@"dataList" context:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)onLeftBtnAction:(id)sender
{
    if (_viewType == ServiceHallViewTypeMap)
    {
        [self onRightBtnAction:nil];
    }
    else
    {
        if (self.isDismissMVC && [self respondsToSelector:@selector(dismissModalViewControllerAnimated:)])
        {
            [self dismissModalViewControllerAnimated:YES];
        }
        else
        {
            [self.navigationController popViewControllerAnimated:YES];
        }
    }
}

- (void)onRightBtnAction:(id)sender
{
    if (_viewType == ServiceHallViewTypeList)
    {
        _viewType = ServiceHallViewTypeMap;
        [self transitionFromViewController:_listVCtler
                          toViewController:_mapVCtler
                                  duration:0
                                   options:UIViewAnimationOptionCurveEaseInOut
                                animations:^{
                                    [UIView beginAnimations:@"show map" context:UIGraphicsGetCurrentContext()];
                                    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
                                    [UIView setAnimationDuration:0.5f];
                                    [UIView setAnimationDelegate:self];
                                    [self setRightButton:[UIImage imageNamed:@"icon_list"]];
                                    [UIView setAnimationTransition: UIViewAnimationTransitionFlipFromRight forView:self.view cache:YES];
                                    [UIView commitAnimations];
                                }
                                completion:nil];
    }
    else
    {
        _viewType = ServiceHallViewTypeList;
        [self transitionFromViewController:_mapVCtler
                          toViewController:_listVCtler
                                  duration:0
                                   options:UIViewAnimationOptionCurveEaseInOut
                                animations:^{
                                    [UIView beginAnimations:@"show list" context:UIGraphicsGetCurrentContext()];
                                    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
                                    [UIView setAnimationDuration:0.5f];
                                    [UIView setAnimationDelegate:self];
                                    [self setRightButton:[UIImage imageNamed:@"icon_map"]];
                                    [UIView setAnimationTransition: UIViewAnimationTransitionFlipFromLeft forView:self.view cache:YES];
                                    [UIView commitAnimations];
                                }
                                completion:nil];
    }
}

#pragma mark Notification
- (void)onShowMapViewNotification:(NSNotification *)notification
{
    [self onRightBtnAction:nil];
}

@end
