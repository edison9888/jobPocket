//
//  EsAppDelegate.m
//  xhgdzwyq
//
//  Created by Eshore on 13-11-7.
//  Copyright (c) 2013年 Eshore. All rights reserved.
//

#import "EsAppDelegate.h"

//#import "EsViewController.h"
#import "EsLanmuViewController.h"
#import "EsRootVCtler.h"

#if (kBestappSdkOpen)
    #import "Bearing.h"
#endif

@implementation RemoteNotification

@end

@implementation EsAppDelegate

#pragma mark

- (BOOL)dealWithRemoteNotification:(NSDictionary*)userInfo
{
    NSLog(@"launchOptions : %@", userInfo);
    NSLog(@"收到推送消息 ： %@",[[userInfo objectForKey:@"aps"] objectForKey:@"alert"]);
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
#if (kBestappSdkOpen)
    {
        // bestapp sdk
        [Bearing setBadge:0];
        // bestapp sdk
    }
#endif
    
    RemoteNotification* notification = [RemoteNotification new];
    [self.remoteNotificationArray addObject:notification];
    do {
        if (userInfo[@"b"] == [NSNull null] ||
            userInfo[@"b"] == nil)
        {
            break;
        }
        
        NSString * b = userInfo[@"b"];
        NSArray * arr = [b componentsSeparatedByString:@"|"];
        if (arr.count < 2) break;
        
        NSString * type = arr[1];
        if ([type isEqualToString:@"s"])
        {
            // 普通推送通知
            break;
        }
        
        if ([type isEqualToString:@"p"])
        {
            // 打开指定页面+打开动态页面
            notification.remoteNotificationType = RemoteNotificationTypeOpenAppPage;
            if (arr.count < 3) break;
            notification.remoteNotificationContent = arr[2];
            return YES;
            break;
        }
        
        if ([type isEqualToString:@"l"])
        {
            // 打开网址
            notification.remoteNotificationType = RemoteNotificationTypeOpenWebPage;
            if (arr.count < 3) break;
            notification.remoteNotificationContent = arr[2];
            break;
        }
        
        if ([type isEqualToString:@"d"])
        {
            // 打开下载应用
            notification.remoteNotificationType = RemoteNotificationTypeOpenDownloadLink;
            if (arr.count < 3) break;
            notification.remoteNotificationContent = arr[2];
            break;
        }
        
        if ([type isEqualToString:@"t"])
        {
            // 打开透传消息
            notification.remoteNotificationType = RemoteNotificationTypeOpenThroughMsg;
            if (arr.count < 3) break;
            notification.remoteNotificationContent = arr[2];
            break;
        }
    } while (0);
    
    return NO;
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    NSLog(@"launchOptions %@", launchOptions);
    self.keyboardHeight = 0;
    self.remoteNotificationArray = [NSMutableArray new];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];

#if (kBestappSdkOpen)
    {
        int versionCode = kAppBuildVersion;
        [Bearing setApplicationId:kBestappSdkAppId clientKey:kBestappSdkAppKey versionCode:versionCode];
        // bestapp sdk在release时无法注册通知！！！所以改成应用注册通知，自己解析处理
    }
#endif
    [[UIApplication sharedApplication] registerForRemoteNotificationTypes:(UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeSound | UIRemoteNotificationTypeAlert)];
    
    BOOL openNewsView = NO;
    if (launchOptions!=nil && [launchOptions objectForKey:UIApplicationLaunchOptionsRemoteNotificationKey]!=nil)
    {
        //通知
        openNewsView = [self dealWithRemoteNotification:[launchOptions objectForKey:UIApplicationLaunchOptionsRemoteNotificationKey]];
    }
    
    EsRootVCtler* vctler = [EsRootVCtler new];
    vctler.isOpenPushNewsDetailView = openNewsView;
    self.window.rootViewController = vctler;
    
#if 0   // modified by zy, 2014-01-03
    //wensj red status bar
    self.window.backgroundColor=[UIColor redColor];
#endif
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    NSLog(@"%s", __func__);
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    [UIScreen mainScreen].brightness = [Global sharedSingleton].uiStyle.originBrightness;
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
#if (kBestappSdkOpen)
    {
        // bestapp sdk
        [Bearing setBadge:0];
        // bestapp sdk
    }
#endif
    [UIScreen mainScreen].brightness = [Global sharedSingleton].uiStyle.brightness;
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    NSLog(@"%s", __func__);
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    [UIScreen mainScreen].brightness = [Global sharedSingleton].uiStyle.originBrightness;
}

#pragma mark private
- (void)keyboardWillShow:(NSNotification *)notification
{
    NSDictionary *userInfo = [notification userInfo];
    NSValue* aValue = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect keyboardRect = [aValue CGRectValue];
    self.keyboardHeight = keyboardRect.size.height;
}

- (void)keyboardWillHide:(NSNotification *)notification
{
    self.keyboardHeight = 0;
}

#pragma mark Handling Remote Notifications
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo
{
    //http://developer.apple.com/library/mac/#documentation/NetworkingInternet/Conceptual/RemoteNotificationsPG/ApplePushService/ApplePushService.html
    if ([userInfo isKindOfClass:[NSNull class]])
    {
        return;
    }
    
    NSLog(@"%@",userInfo);
    NSString *applicationState = @"";
    //4.0
    if ( application.applicationState == UIApplicationStateActive )
    {
        //运行在前台
        applicationState = @"UIApplicationStateActive:The application is running in the foreground and currently receiving events.";
    }
    else if ( application.applicationState == UIApplicationStateInactive )
    {
        //运行在后台
        applicationState = @"UIApplicationStateInactive:The application is running in the foreground but is not receiving events. This might happen as a result of an interruption or because the application is transitioning to or from the background.";
    }
    else if ( application.applicationState == UIApplicationStateBackground )
    {
        //运行在后台
        applicationState = @"UIApplicationStateBackground:The application is running in the background.";
    }
    
    [self dealWithRemoteNotification:userInfo];
    [[NSNotificationCenter defaultCenter] postNotificationName:kReceiveRemoteNotification object:[NSNumber numberWithInt:self.remoteNotificationArray.count - 1]];
}

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
{
    NSLog(@"deviceToken: %@", deviceToken);
    NSString *token = [[deviceToken description] stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"<>"]];
    token = [token stringByReplacingOccurrencesOfString:@" " withString:@""];
    [[NSUserDefaults standardUserDefaults] setObject:token forKey:@"devicetoken"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
#if (kBestappSdkOpen)
    {
        // bestapp sdk
        [Bearing storeDeviceToken:deviceToken];
        // bestapp sdk
    }
#endif
}

- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error
{
    NSLog(@"Error in registration. Error: %@", error);
}

@end
