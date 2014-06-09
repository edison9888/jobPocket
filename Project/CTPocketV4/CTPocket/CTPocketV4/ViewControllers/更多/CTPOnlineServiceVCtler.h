//
//  CTPOnlineServiceVCtler.h
//  CTPocketv3
//
//  Created by lyh on 13-4-17.
//
//

#import "CTBaseViewController.h"

@interface CTPOnlineServiceVCtler : CTBaseViewController
<UIWebViewDelegate>
{
    UIActivityIndicatorView* _activeIndicatorView;
    UIWebView* _wvOnlineService;
}

@property (retain, nonatomic) UIWebView* _wvOnlineService;

@end
