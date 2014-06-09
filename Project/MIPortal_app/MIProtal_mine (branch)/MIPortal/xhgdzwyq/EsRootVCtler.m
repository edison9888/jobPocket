//
//  EsRootVCtler.m
//  xhgdzwyq
//
//  Created by apple on 13-12-25.
//  Copyright (c) 2013年 Eshore. All rights reserved.
//

#import "EsRootVCtler.h"
#import "EsLoginVCtler.h"
#import "EsLoadingVCtler.h"
#import "EsHomeVCtler.h"
#import "EsNewsDetailViewController.h"
#import "EsAppDelegate.h"
#import "EsNewsVCtler.h"
#import "EsNavigationCtler.h"

@interface EsRootVCtler ()
{
    UIViewController*       _currentVCtler;
}

@end

@implementation EsRootVCtler

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
#if 0   // modified by zy, 2014-01-02
#warning wensj 状态栏总是有滑入效果，不够美
        //wensj status bar red
        UIView *statusBar_custom = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 20)];
        statusBar_custom.backgroundColor = kNavigationBarBGColor;
        [self.view addSubview:statusBar_custom];
        //----------
#endif
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(showHomeView)
                                                     name:kMsgLoginSuccess
                                                   object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(showLoginView)
                                                     name:kMsgAutoLoginFail
                                                   object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(onLogoutNotification)
                                                     name:kMsgAutoLogout
                                                   object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(onBack2NewsListNotification:)
                                                     name:kMsgBack2NewsList
                                                   object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(onRemoteNotification:)
                                                     name:kReceiveRemoteNotification
                                                   object:nil];
        
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
    
#warning wensj to zengy 测试代码要记得去掉；可利用“＃warning”来提醒
//    // for test
//    [self showLoginView];
//    return;
    
    if (self.isOpenPushNewsDetailView)
    {
        [self openPushNewspage:0];
    }
    else
    {
        [self showLoadingView];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)showLoadingView
{
    EsLoadingVCtler* vctler = [EsLoadingVCtler new];
    EsNavigationCtler* navctler = [[EsNavigationCtler alloc] initWithRootViewController:vctler];
    navctler.navigationBarHidden = YES;
    [self addChildViewController:navctler];
    
    navctler.view.frame = self.view.bounds;
    if (!_currentVCtler)
    {
        _currentVCtler = navctler;
        [self.view addSubview:navctler.view];
        return;
    }
    
    [self transitionFromViewController:_currentVCtler
                      toViewController:navctler
                              duration:0
                               options:UIViewAnimationOptionCurveEaseInOut
                            animations:nil
                            completion:^(BOOL finished) {
                                navctler.view.frame = self.view.bounds;
                                [_currentVCtler removeFromParentViewController];
                                _currentVCtler = navctler;
                            }];
}

- (void)showHomeView
{
    EsHomeVCtler* vctler = [EsHomeVCtler new];
    EsNavigationCtler* navctler = [[EsNavigationCtler alloc] initWithRootViewController:vctler];
    [self addChildViewController:navctler];
    
    navctler.view.frame = self.view.bounds;
    if (!_currentVCtler)
    {
        _currentVCtler = navctler;
        [self.view addSubview:navctler.view];
        return;
    }
    
    [self transitionFromViewController:_currentVCtler
                      toViewController:navctler
                              duration:0
                               options:UIViewAnimationOptionCurveEaseInOut
                            animations:nil
                            completion:^(BOOL finished) {
                                navctler.view.frame = self.view.bounds;
                                [_currentVCtler removeFromParentViewController];
                                _currentVCtler = navctler;
                            }];
}

- (void)showLoginView
{
    EsLoginVCtler* vctler = [EsLoginVCtler new];
    EsNavigationCtler* navCtler = [[EsNavigationCtler alloc] initWithRootViewController:vctler];
    [self addChildViewController:navCtler];
    
    navCtler.view.frame = self.view.bounds;
    if (!_currentVCtler)
    {
        _currentVCtler = navCtler;
        [self.view addSubview:navCtler.view];
        return;
    }
    
    [self transitionFromViewController:_currentVCtler
                      toViewController:navCtler
                              duration:0
                               options:UIViewAnimationOptionCurveEaseInOut
                            animations:nil
                            completion:^(BOOL finished) {
                                navCtler.view.frame = self.view.bounds;
                                [_currentVCtler removeFromParentViewController];
                                _currentVCtler = navCtler;
                            }];
}

- (void)onLogoutNotification
{
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:kLoginToken];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:kVerifyCode];
    [[NSUserDefaults standardUserDefaults] synchronize];
    [Global sharedSingleton].userVerify.user.token = nil;   // 将token置空
    [self showLoginView];
    
#if (kBestappSdkOpen)
    {
        NSArray* tagArr = @[@{@"category" : @"栏目", @"tags" : [NSArray array]}];
        [Bearing setTags:tagArr];
    }
#endif
}

- (void)openPushNewspage:(int)index
{
    NSLog(@"%s", __func__);
    if ([Global sharedSingleton].columns.count <= 0)
    {
        [[Global sharedSingleton] getNewsColumn:nil];
    }
    
    NSDictionary* dict = [self parseNotificationContent:index];
    EsNewsDetailViewController* vctler = [EsNewsDetailViewController new];
    vctler.isRemotePushNews = YES;
    vctler.newsInfo = dict;
    
    EsNavigationCtler* navCtler = [[EsNavigationCtler alloc] initWithRootViewController:vctler];
    [self addChildViewController:navCtler];
    navCtler.view.frame = self.view.bounds;
    if (!_currentVCtler)
    {
        _currentVCtler = navCtler;
        [self.view addSubview:navCtler.view];
        return;
    }
    
    [self transitionFromViewController:_currentVCtler
                      toViewController:navCtler
                              duration:0
                               options:UIViewAnimationOptionCurveEaseInOut
                            animations:nil
                            completion:^(BOOL finished) {
                                navCtler.view.frame = self.view.bounds;
                                [_currentVCtler removeFromParentViewController];
                                _currentVCtler = navCtler;
                            }];
}

- (NSDictionary* )parseNotificationContent:(int)index
{
    // page=xqy_jm&id=1068&catalogAry=1_2_64
    NSMutableDictionary* paramsDict = nil;
    EsAppDelegate* app = (EsAppDelegate* )[UIApplication sharedApplication].delegate;
    RemoteNotification* pushmsg = nil;
    if (index >= 0 && index < app.remoteNotificationArray.count)
    {
        pushmsg = app.remoteNotificationArray[index];
    }
    if (pushmsg)
    {
        NSArray* paramsArr = [pushmsg.remoteNotificationContent componentsSeparatedByString:@"&"];
        paramsDict = [NSMutableDictionary dictionary];
        for (NSString* param in paramsArr)
        {
            NSArray* arr = [param componentsSeparatedByString:@"="];
            if (arr.count == 2)
            {
                [paramsDict setObject:arr[1] forKey:arr[0]];
            }
        }
    }
    
    return paramsDict;
}

- (void)onBack2NewsListNotification:(NSNotification* )notificaiton
{
    EsHomeVCtler* vctler = [EsHomeVCtler new];
    EsNavigationCtler* navctler = [[EsNavigationCtler alloc] initWithRootViewController:vctler];
    [self addChildViewController:navctler];
    
    {
        int selectcolumn = 0;
        {
            NSString* selectedColId = @"";
            NSDictionary* dict = [notificaiton object];
            NSString* columnIDs = @"";
            if (dict[@"catalogAry"] != [NSNull null] &&
                dict[@"catalogAry"] != nil)
            {
                columnIDs = dict[@"catalogAry"];
            }
            NSArray* pushColumnArr = [columnIDs componentsSeparatedByString:@"_"];
            
            NSUserDefaults* def = [NSUserDefaults standardUserDefaults];
            NSString* key = [NSString stringWithFormat:@"%@_%@", [def stringForKey:kPhoneNumber], kPushMsgIDsNotReceive];
            NSString* ids = [def stringForKey:key];
            NSMutableArray* notReceiveArr = [NSMutableArray arrayWithArray:[ids componentsSeparatedByString:@","]];
            
            for (NSString* val in pushColumnArr)
            {
                if (![notReceiveArr containsObject:val])
                {
                    selectedColId = val;
                    break;
                }
            }
            
            for (EsNewsColumn* column in [Global sharedSingleton].columns)
            {
                if ([column.catalogId intValue] == [selectedColId intValue])
                {
                    selectcolumn = [[Global sharedSingleton].columns indexOfObject:column];
                    break;
                }
            }
        }
        
        NSLog(@"%s %d", __func__, selectcolumn);
        EsNewsVCtler* newVc = [EsNewsVCtler new];
        newVc.selectColumn = selectcolumn;
        [navctler pushViewController:newVc animated:NO];
    }
    
    navctler.view.frame = self.view.bounds;
    if (!_currentVCtler)
    {
        _currentVCtler = navctler;
        [self.view addSubview:navctler.view];
        return;
    }
    
    [self transitionFromViewController:_currentVCtler
                      toViewController:navctler
                              duration:0
                               options:UIViewAnimationOptionCurveEaseInOut
                            animations:nil
                            completion:^(BOOL finished) {
                                navctler.view.frame = self.view.bounds;
                                [_currentVCtler removeFromParentViewController];
                                _currentVCtler = navctler;
                            }];
}

#define kAlertViewTagOpenPage   1000
- (void)onRemoteNotification:(NSNotification* )notification
{
    int index = [notification.object intValue];
    EsAppDelegate* app = (EsAppDelegate *)[UIApplication sharedApplication].delegate;
    RemoteNotification* pushmsg = nil;
    if (index >= 0 && index < app.remoteNotificationArray.count)
    {
        pushmsg = app.remoteNotificationArray[index];
    }
    
    if (pushmsg.remoteNotificationType == RemoteNotificationTypeOpenAppPage)
    {
        UIAlertView* alert = [[UIAlertView alloc] initWithTitle:nil
                                                        message:@"收到通知消息，是否查看?"
                                                       delegate:(id<UIAlertViewDelegate>)self
                                              cancelButtonTitle:@"查看"
                                              otherButtonTitles:@"忽略", nil];
        alert.tag = kAlertViewTagOpenPage + index;
        [alert show];
    }
    else
    {
        // TODO
    }
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag >= kAlertViewTagOpenPage && buttonIndex == 0)
    {
        [self openPushNewspage:alertView.tag - kAlertViewTagOpenPage];
    }
}

@end
