//
//  CTPMsgCenterDetailVCtler.m
//  CTPocketv3
//
//  Created by apple on 13-5-15.
//
//

#import "CTPMsgCenterDetailVCtler.h"

@interface CTPMsgCenterDetailVCtler ()

@end

@implementation CTPMsgCenterDetailVCtler

@synthesize infoDict;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)dealloc
{
    [_webView stopLoading];
    [_webView setDelegate:nil];
    self.infoDict = nil;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    {
        self.title  = @"消息内容";
        // 左按钮
        [self setLeftButton:[UIImage imageNamed:@"btn_back"]];
        
        if ([[self.infoDict objectForKey:@"Title"] isKindOfClass:[NSString class]] &&
            [[self.infoDict objectForKey:@"Title"] length])
        {
            self.title = [self.infoDict objectForKey:@"Title"];
        }
    }
    
    {
        UIWebView * webView = [[UIWebView alloc] initWithFrame:self.view.bounds];
        webView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
        webView.delegate = (id<UIWebViewDelegate>)self;
        webView.backgroundColor = [UIColor whiteColor];
        webView.scalesPageToFit = YES;
        //[webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://jf.ct10000.com/wap"]]];
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
    
    NSString *L = [self.infoDict objectForKey:@"L"];
    if (L && [L length] > 0) {
        if (![L hasPrefix:@"http://"]) {
            L = [NSString stringWithFormat:@"http://%@", L];
        }
        [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:L]]];
        
        return;
    }
    
    int LinkType = [[self.infoDict objectForKey:@"LinkType"] intValue];
    if (LinkType == 2)
    {
        NSString * Link = [self.infoDict objectForKey:@"Link"];
        if ([Link length] && [Link hasPrefix:@"http://"])
        {
            [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:Link]]];
        }
    }
    else if (LinkType == 0)
    {
        NSString * Title = [self.infoDict objectForKey:@"Title"];
        NSString * Detail = [self.infoDict objectForKey:@"Detail"];
        
        NSMutableString *html = [NSMutableString string];
        [html appendString:@"<!DOCTYPE html PUBLIC \"-//W3C//DTD XHTML 1.0 Transitional//EN\" \"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd\">"];
        [html appendString:@"<html>"];
        [html appendString:@"<head>"];
        [html appendString:@"<meta http-equiv=\"Content-type\" content=\"text/html; charset=UTF-8\" />"];
        [html appendString:@"<title>News Detail</title>"];
        [html appendString:@"<meta name=\"viewport\" content=\"width=device-width; minimum-scale=1.0; maximum-scale=1.0; user-scalable=0;\"/>"];
        [html appendString:@"<link rel=\"stylesheet\" type=\"text/css\" href=\"main.css\" media=\"screen\" />"];
        [html appendString:@"</head>"];
        [html appendString:@"<body style=\"background-color: transparent\">"];	// 背景透明
        
        [html appendString:@"<div>"];
        if ([Title isKindOfClass:[NSString class]] && [Title length])
        {
            [html appendFormat:@"<p class=\"Paragraph\"><strong><font style=\"font-size:15px;color:black;\">%@</font></strong></p>",Title];
        }
        if ([Detail isKindOfClass:[NSString class]] && [Detail length])
        {
            [html appendFormat:@"<p class=\"Paragraph\"><font style=\"font-family:helvetica;font-size:15px;color:black;\">%@</font></p>",Detail];
        }
        [html appendString:@"</div>"];
        
        [html appendString:@"<div id=\"footer\"></div>"];
        [html appendString:@"</body></html>"];
        
        [_webView loadHTMLString:html baseURL:nil];
    }
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    _webView = nil;
    _activityviewInfo = nil;
}

#pragma mark - nav

- (void)onLeftBtnAction:(id)sender
{
    [_webView stopLoading];
    [self.navigationController dismissModalViewControllerAnimated:YES];
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
