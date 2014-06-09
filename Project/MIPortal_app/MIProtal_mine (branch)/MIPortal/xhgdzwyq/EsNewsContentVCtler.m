//
//  EsNewsContentVCtler.m
//  xhgdzwyq
//
//  Created by apple on 13-11-26.
//  Copyright (c) 2013年 Eshore. All rights reserved.
//

#import "EsNewsContentVCtler.h"
#import "EsNewsDetailModel.h"

@interface EsNewsContentVCtler ()
{
    UIWebView*      _webView;
    UIActivityIndicatorView* _inditorView;
    
    EsNewsDetailModel*      _newsDetail;
    BOOL                    _loading;
}

@end

@implementation EsNewsContentVCtler

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onUIChangeNotification:) name:kMsgChangeUIStyle object:nil];
    }
    return self;
}

- (void)dealloc
{
    NSLog(@"%s", __func__);
    [_webView setDelegate:nil];
    [_webView stopLoading];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    {
        UIWebView* webview = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame))];
        webview.delegate = (id<UIWebViewDelegate>)self;
        webview.backgroundColor = [UIColor clearColor];
        webview.opaque = NO;
        webview.dataDetectorTypes = UIDataDetectorTypeNone;
        webview.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
        for(UIView *v in [[[webview subviews] objectAtIndex:0] subviews])
        {
            if([v isKindOfClass:[UIImageView class]])
            {
                v.hidden = YES;
            }
        }
        [self.view addSubview:webview];
        _webView = webview;
    }
    
    {
        UIActivityIndicatorView* v = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:([Global sharedSingleton].uiStyle.mode == UIStyleModeDay ? UIActivityIndicatorViewStyleGray : UIActivityIndicatorViewStyleWhite)];
        v.center = _webView.center;
        v.hidesWhenStopped = YES;
        [self.view addSubview:v];
        _inditorView = v;
    }

    [self getNewsDetail];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark private
- (void)getNewsDetail
{
    NSString* token = @"";
    NSString* newsId = @"";
    
    if ([Global sharedSingleton].userVerify.user.token)
    {
        token = [Global sharedSingleton].userVerify.user.token;
    }
    if (self.newsInfo.newsId)
    {
        newsId = [NSString stringWithFormat:@"%@", self.newsInfo.newsId];
    }
    
    NSDictionary* params = @{ @"token" : token,
                              @"newsId" : newsId};
    if (_newsDetail) {
        
        [self resetUI];
        
        // 置为已读
        self.newsInfo.readed = YES;
        [Utils setNewsReadedByNewsId:self.newsInfo];
    }
    else
    {
        __weak typeof(self) wself = self;
        BaseDataSource* net = [BaseDataSource new];
        [_inditorView startAnimating];
        [net startGetRequestWithParams:params method:@"getNews" completion:^(id responsedict)
         {
             [_inditorView stopAnimating];
             [wself onGetDetailFinish:net response:responsedict];
         }];
    }
}

- (void)onGetDetailFinish:(BaseDataSource *)net response:(id)response
{
    if ([net.errorCode length])
    {
        NSString* tipmsg = @"对不起，新闻详情获取失败";
        ToastAlertView * alert = [ToastAlertView new];
        if ([net.errorMsg length])
        {
            tipmsg = net.errorMsg;
        }
        [alert performSelector:@selector(showAlertMsg:) onThread:[NSThread mainThread] withObject:tipmsg waitUntilDone:YES];
        return ;
    }
    
    _newsDetail = [[EsNewsDetailModel alloc] initWithDictionary:response];
    [self resetUI];
    
    // 置为已读
    self.newsInfo.readed = YES;
    [Utils setNewsReadedByNewsId:self.newsInfo];
}

- (void)resetUI
{
    NSMutableString *htmlStr = [NSMutableString string];
    [htmlStr appendString:@"<!DOCTYPE html PUBLIC \"-//W3C//DTD XHTML 1.0 Transitional//EN\" \"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd\">"];
    [htmlStr appendString:@"<html>"];
    [htmlStr appendString:@"<head>"];
    [htmlStr appendString:@"<meta http-equiv=\"Content-type\" content=\"text/html; charset=UTF-8\" />"];
    [htmlStr appendString:@"<title>News Detail</title>"];
    [htmlStr appendString:@"<meta name=\"viewport\" content=\"width=device-width; minimum-scale=1.0; maximum-scale=1.0; user-scalable=0;\"/>"];
    [htmlStr appendString:@"<link rel=\"stylesheet\" type=\"text/css\" href=\"main.css\" media=\"screen\" />"];
    [htmlStr appendString:@"</head>"];
    [htmlStr appendString:@"<body style=\"background-color: transparent\">"];	// 背景透明
    [htmlStr appendString:@"<div>"];
    
    if ([_newsDetail.newsTitle length])
    {
        NSString* color = ([Global sharedSingleton].uiStyle.mode == UIStyleModeNight ? @"#aaaaaa" : @"#111111");
        [htmlStr appendFormat:@"<p class=\"title\"><font style=\"font-family:helvetica;font-size:20px;color:%@;\">%@</font></p>", color, _newsDetail.newsTitle];
    }
    
    if ([_newsDetail.verifyDate length])
    {
//        [htmlStr appendFormat:@"<p><div> <div style=\"float:left\"><span class=\"date\">%@</span></div><div style=\"float:right\">auto:%@</div></div></p>",_newsDetail.verifyDate,@"xxxxxx"];
        [htmlStr appendFormat:@"<p class=\"date\">%@<font style=\"float:right\">%@  编辑</font></p>",_newsDetail.verifyDate,_newsDetail.createUserName];
    }
    
    if ([Global sharedSingleton].uiStyle.mode == UIStyleModeNight)
    {
        [htmlStr appendString:@"<img src=\"grayline_nightmode@2x.png\" style=\"padding-top:2px;padding-bottom:24px;\"/>"];
    }
    else
    {
        [htmlStr appendString:@"<img src=\"grayline@2x.png\" style=\"padding-top:2px;padding-bottom:24px;\"/>"];
    }
    [htmlStr appendString:@"<p style=\"line-height: 12pt;\"></p>"];
    
    NSString* content = _newsDetail.newsContent;
    content = [Utils htmlTagFilter:content];
    if (content.length)
    {
        int fontsize = [Global sharedSingleton].uiStyle.fontSize;
        NSString* color = ([Global sharedSingleton].uiStyle.mode == UIStyleModeNight ? @"#aaaaaa" : @"#404040");
        if ([content hasPrefix:@"<p"])
        {
            [htmlStr appendFormat:@"<font style=\"font-family:helvetica;font-size:%dpx;color:%@;\">%@</font>", fontsize, color, content];
        }
        else
        {
            [htmlStr appendFormat:@"<p><font style=\"font-family:helvetica;font-size:%dpx;color:%@;\">%@</font></p>", fontsize, color, content];
        }
    }
    
    [htmlStr appendString:@"</div>"];
    [htmlStr appendString:@"<div id=\"footer\"></div>"];
    [htmlStr appendString:@"</body></html>"];
    
    NSLog(@"%@", htmlStr);
    NSString *basePath = [[NSBundle mainBundle] resourcePath];
    NSURL *   baseURL  = [NSURL fileURLWithPath:basePath];
    [_webView loadHTMLString:htmlStr baseURL:baseURL];
}

#pragma mark UIWebViewDelegate
- (void)webViewDidStartLoad:(UIWebView *)webView
{
    NSLog(@"%s", __func__);
    _loading = YES;
    [_inditorView startAnimating];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    NSLog(@"%s", __func__);
    if (!_loading)
    {
        return;
    }
    
    _loading = NO;
    [_inditorView stopAnimating];
    [[NSNotificationCenter defaultCenter] postNotificationName:kMsgChangeUIFinish object:nil];
    if (webView.hidden)
    {
        webView.hidden = NO;
    }
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    NSLog(@"%s", __func__);
}

#pragma mark notification
- (void)onUIChangeNotification:(id)sender
{
    if (_webView.loading)
    {
        [_webView stopLoading];
    }
    _inditorView.activityIndicatorViewStyle = ([Global sharedSingleton].uiStyle.mode == UIStyleModeDay ? UIActivityIndicatorViewStyleGray : UIActivityIndicatorViewStyleWhite);
    [_inditorView startAnimating];
    
    [NSThread detachNewThreadSelector:@selector(resetUI) toTarget:self withObject:nil];
}

@end
