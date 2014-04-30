//
//  CTPPointExchangeVCtler.h
//  CTPocketv3
//
//  Created by apple on 13-4-27.
//
//

/*
 积分兑换
 */
#import "CTBaseViewController.h"

@interface CTPPointExchangeVCtler : CTBaseViewController
{
    UIWebView *     _webView;
    UIActivityIndicatorView * _activityviewInfo;
}

@property (nonatomic, copy) NSString * jumpUrl;

//是否要占满tabBar的位置
@property (nonatomic, assign)BOOL fullScreen;

@property (nonatomic, assign) BOOL isLogoTitle; // 是否显示电信logo＋掌上营业厅 这个标题

@property (nonatomic, assign) BOOL needBack2Rootview;   // 是否返回到tab首页

@end
