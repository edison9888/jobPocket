//
//  CTDetailVCtler.m
//  CTPocketV4
//
//  Created by apple on 13-11-12.
//  Copyright (c) 2013年 广东亿迅科技有限公司. All rights reserved.
//

#import "CTDetailVCtler.h"

@interface CTDetailVCtler ()

@property (nonatomic, strong) UIWebView *webView;
@property (nonatomic, strong) UIActivityIndicatorView *activityViewInfo;

@end

@implementation CTDetailVCtler

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
    self.title = @"详情";
    [self setLeftButton:[UIImage imageNamed:@"btn_back"]];
    self.view.backgroundColor = [UIColor whiteColor];
   
    /* cancel by liuruxian 2014-05-04
    if (self.infoDict) {
        NSString *name = [NSString stringWithFormat:@"%@-%@",NSStringFromClass([self class]),self.infoDict[@"Title"]];
        [TrackingHelper trackPageLoadedState:name];
    }
    */
}

- (void) viewDidAppear:(BOOL)animated
{
    {
//        UIWebView * webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame))];
        UIWebView * webView = [[UIWebView alloc] initWithFrame:self.view.bounds];
        webView.delegate = (id<UIWebViewDelegate>)self;
        webView.backgroundColor = [UIColor whiteColor];
        webView.scalesPageToFit = YES;
        [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:([self.jumpUrl length] ? self.jumpUrl : @"http://jf.189.cn/wap")]]];
        
        self.webView = webView ;
        [self.view addSubview:webView];
        
    }
    {
        UIActivityIndicatorView * activityview = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        activityview.frame = CGRectMake(100, 250, 14, 14);
        activityview.center = self.view.center ;
        activityview.center = self.webView.center;
        activityview.hidesWhenStopped = YES;
        [self.view addSubview:activityview];
        self.activityViewInfo = activityview;
    }
}

- (void)webViewDidStartLoad:(UIWebView *)webView
{
    [self.activityViewInfo startAnimating];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    
    [self.activityViewInfo stopAnimating];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    [self.activityViewInfo stopAnimating];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
