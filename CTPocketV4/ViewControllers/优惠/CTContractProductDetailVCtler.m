//
//  CTContractProductDetailVCtler.m
//  CTPocketV4
//
//  Created by Mac-Eshore-01 on 14-3-27.
//  Copyright (c) 2014年 广东亿迅科技有限公司. All rights reserved.
//

#import "CTContractProductDetailVCtler.h"

@interface CTContractProductDetailVCtler ()

@end

@implementation CTContractProductDetailVCtler

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {

    }
    return self;
}

- (id)init
{
    self = [super init];
    if (self) {

    }
    return self;
}

- (void)dealloc
{
    [_webView stopLoading];
    [_webView setDelegate:nil];
    self.jumpUrl = nil;
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.jumpUrl = @"http://diy.189.cn/client/webfile/html/pages/setMeal.html#";
    self.title = @"合约详情套餐说明";
    [self setLeftButton:[UIImage imageNamed:@"btn_back"]];
    {
        UIWebView * webView = [[UIWebView alloc] initWithFrame:
                               CGRectMake(0, self.view.bounds.origin.y-20,
                                          CGRectGetWidth(self.view.frame),
                                          CGRectGetHeight(self.view.frame)+20)];
        webView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleTopMargin ;
        webView.delegate = (id<UIWebViewDelegate>)self;
        webView.backgroundColor = [UIColor whiteColor];
        webView.scalesPageToFit = YES;
        [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:([self.jumpUrl length] ? self.jumpUrl : @"http://jf.189.cn/wap")]]];
        
        [self.view addSubview:webView];
        _webView = webView;
    }
    {
        UIActivityIndicatorView * activityview = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        activityview.frame = CGRectMake(0, 0, 14, 14);
        activityview.center = _webView.center;
        activityview.hidesWhenStopped = YES;
        [self.view addSubview:activityview];
        _activityviewInfo = activityview;

    }
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    [_webView stopLoading];
    _webView = nil;
    _activityviewInfo = nil;
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
#pragma mark - CTPNavBarDelegate
- (void) onLeftBtnAction:(id)sender
{
    [_webView stopLoading];
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark
- (void)webViewDidStartLoad:(UIWebView *)webView
{
    [_activityviewInfo startAnimating];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [_activityviewInfo stopAnimating];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    [_activityviewInfo stopAnimating];
}
@end
