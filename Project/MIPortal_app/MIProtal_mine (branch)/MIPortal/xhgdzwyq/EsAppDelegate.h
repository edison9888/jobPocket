//
//  EsAppDelegate.h
//  xhgdzwyq
//
//  Created by Eshore on 13-11-7.
//  Copyright (c) 2013年 Eshore. All rights reserved.
//

#import <UIKit/UIKit.h>

#define MyAppDelegate ((EsAppDelegate *)[UIApplication sharedApplication].delegate)

typedef enum RemoteNotificationType_
{
    RemoteNotificationTypeNone = 0,     // 普通推送
    RemoteNotificationTypeOpenWebPage,  // 打开网址
    RemoteNotificationTypeOpenDownloadLink, // 打开应用下载地址
    RemoteNotificationTypeOpenAppPage,  // 打开应用内页面
    RemoteNotificationTypeOpenThroughMsg,  // 打开透传消息
}RemoteNotificationType;

@interface RemoteNotification : NSObject

@property (assign, nonatomic) RemoteNotificationType    remoteNotificationType;
@property (strong, nonatomic) NSString *                remoteNotificationContent;

@end

//@class EsViewController;

@interface EsAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

//@property (strong, nonatomic) EsViewController *viewController;
@property (strong, nonatomic) UIViewController *viewController;
@property (strong, nonatomic) UINavigationController *mainNavigationCtrl;

@property (assign, nonatomic) int                       keyboardHeight;

// remotePush
@property (strong, nonatomic) NSMutableArray *          remoteNotificationArray;

@end
