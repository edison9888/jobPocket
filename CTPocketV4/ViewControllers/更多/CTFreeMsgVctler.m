//
//  CTFreeMsgVctler.m
//  CTPocketV4
//
//  Created by Mac-Eshore-01 on 13-11-1.
//  Copyright (c) 2013年 广东亿迅科技有限公司. All rights reserved.
//

#import "CTFreeMsgVctler.h"

@interface CTFreeMsgVctler ()
-(NSMutableString*)ganerateWebHtml:(int)msgnumber;
-(void)onDoSendsms:(id)sender;
-(void)onAddContract:(id)sender;
@end

@implementation CTFreeMsgVctler

-(NSMutableString*)ganerateWebHtml:(int)msgnumber{
    NSMutableString *html = [NSMutableString string];
    [html appendString:@"<!DOCTYPE html PUBLIC \"-//W3C//DTD XHTML 1.0 Transitional//EN\" \"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd\">"];
    [html appendString:@"<html>"];
    [html appendString:@"<head>"];
    [html appendString:@"<meta http-equiv=\"Content-type\" content=\"text/html; charset=UTF-8\" />"];
    [html appendString:@"<title>help info</title>"];
    [html appendString:@"<meta content=\"telephone=yes\"  name=\"format-detection\" />"];
    //[html appendString:@"<script type=\"text/javascript\" src=\"Images/highlight.js\" charset=UTF-8\" />"];
    [html appendString:@"<style  type=\"text/css\" >"];
    [html appendString:@"* { \
     margin: 0px; \
     padding:0px;  \
     font-family: helvetica, sans-serif; \
     font-size: 11pt; \
     line-height: 16pt; \
     letter-spacing: -0.05px; \
     word-wrap: break-word; \
     -webkit-touch-callout:none;\
     } \
     \
     body \
     {     \
     margin-left: 15px;   \
     margin-top: 15px;   \
     margin-top: 4px;   \
     padding:0px;    \
     background: transparent; \
     }   \
     \
     p   \
     {   \
     /*text-indent: 2em; em是相对单位，2em即现在一个字大小的两倍*/    \
     /*color: rgba(116,116,91,1); */\
     margin: 10px; \
     }   \
     \
     .footer {       \
     height: 40px;   \
     text-align: left;   \
     color: #aaa;            \
     font-size: 11pt;    \
     margin-top: 8px;    \
     line-height: 12pt;  \
     -webkit-user-select: none;  \
     }   \
     \
     .footer a { \
     font-weight: bold;  \
     font-size: 11pt;    \
     color: #789;        \
     line-height: 12pt;  \
     }"];
    
    [html appendString:@"</style>"];
    [html appendString:@"</head>"];
    [html appendString:@"<body style=\"background-color: transparent\" >"];
    [html appendFormat:@"尊敬的用户，你还可以免费发送<font color=\"green\">%d</font>条短信!",msgnumber];
    return html;
}

-(void)onDoSendsms:(id)sender{
    
}
-(void)onAddContract:(id)sender{
    
}


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
    self.title = @"更多";
    [self.view setBackgroundColor:PAGEVIEW_BG_COLOR];

    
    UIView* _cntView = [[UIView alloc] initWithFrame:self.view.frame];
    _cntView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_cntView];
    
    {
        UIWebView*_webView = [[UIWebView alloc] initWithFrame:CGRectMake(0,0,_cntView.frame.size.width,
                                                                         24)];
        _webView.backgroundColor  = [UIColor clearColor];
        [_webView setOpaque:NO];
        for(UIView *v in [[[_webView subviews] objectAtIndex:0] subviews]){
            if([v isKindOfClass:[UIImageView class]])
            {
                v.hidden = YES;
            }
        }
        [_cntView addSubview:_webView];
        [_webView.scrollView setScrollEnabled:NO];
        NSString* webHtml = [self ganerateWebHtml:20];
        NSString *basePath = [[NSBundle mainBundle] resourcePath];
        NSURL *   baseURL  = [NSURL fileURLWithPath:basePath];
        [_webView loadHTMLString:webHtml baseURL:baseURL];
    }
    
    {
        _tfPhoneNumber = [[UITextField alloc] initWithFrame:CGRectMake(15,40,_cntView.frame.size.width - 110,36)];
        _tfPhoneNumber.placeholder  = @"请简单完整的输入您的问题";
        _tfPhoneNumber.textColor    = [UIColor darkTextColor];
        _tfPhoneNumber.font         = [UIFont systemFontOfSize:15];
        _tfPhoneNumber.backgroundColor = [UIColor whiteColor];
        _tfPhoneNumber.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        _tfPhoneNumber.returnKeyType = UIReturnKeyDone;
        _tfPhoneNumber.clearButtonMode = UITextFieldViewModeWhileEditing;
        _tfPhoneNumber.delegate      = (id<UITextFieldDelegate>)self;
        [_cntView addSubview:_tfPhoneNumber];

        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(_tfPhoneNumber.frame.size.width +_tfPhoneNumber.frame.origin.x,
                                  40,60, 36);
        button.backgroundColor = [UIColor colorWithRed:39/255.0
                                                 green:169/255.0
                                                  blue:37/255.0
                                                 alpha:1];
        [button setTitle:@"联系人" forState:UIControlStateNormal];
        [button addTarget:self action:@selector(onAddContract:) forControlEvents:UIControlEventTouchUpInside];
        [_cntView addSubview:button];
    }
    
    {
        _tfMsgContent = [[UITextView  alloc] initWithFrame:CGRectMake(15, 90, _cntView.frame.size.width - 30,120)];
        _tfMsgContent.textColor = [UIColor blackColor];
        _tfMsgContent.font = [UIFont fontWithName:@"Arial" size:14.0];//设置字体名字和字体大小
        _tfMsgContent.backgroundColor = [UIColor whiteColor];//设置它的背景颜色
        _tfMsgContent.text = @"Now is the time for all good developers to come to serve their country.\nNow is the time for all good developers to come to serve their country.";//设置它显示的内容
        _tfMsgContent.returnKeyType = UIReturnKeyDefault;   //返回键的类型
        _tfMsgContent.keyboardType = UIKeyboardTypeDefault; //键盘类型
        _tfMsgContent.scrollEnabled = YES;//是否可以拖动
        [_cntView addSubview: _tfMsgContent];//加入到整个页面中
    }
    
    {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(15,230,_cntView.frame.size.width-30,36);
        button.backgroundColor = [UIColor colorWithRed:39/255.0
                                                 green:169/255.0
                                                  blue:37/255.0
                                                 alpha:1];
        [button setTitle:@"发送" forState:UIControlStateNormal];
        [button addTarget:self action:@selector(onDoSendsms:) forControlEvents:UIControlEventTouchUpInside];
        [_cntView addSubview:button];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
