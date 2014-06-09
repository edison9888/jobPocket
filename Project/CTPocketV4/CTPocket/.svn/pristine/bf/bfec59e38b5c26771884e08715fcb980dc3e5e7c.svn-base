//
//  CTPHelpVCtler.m
//  CTPocketv3
//
//  Created by lyh on 13-4-17.
//
//

#import "CTPHelpVCtler.h"
#import "UIView+RoundRect.h"

@interface CTPHelpVCtler ()
-(NSMutableString*)ganerateWebHtml:(BOOL)keyWord;
@end

@implementation CTPHelpVCtler

-(NSMutableString*)ganerateWebHtml:(BOOL)keyWord
{
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
        font-size: 12pt; \
        line-height: 18pt; \
        letter-spacing: -0.05px; \
        word-wrap: break-word; \
        -webkit-touch-callout:none;\
    } \
        \
    body \
    {     \
    margin: 10px;   \
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
    
    if (NO == keyWord) {
        for (NSString* item in _helpContentList) {
            NSArray* ary = [item componentsSeparatedByString:@"\n"];
            if ([ary count] <= 2) {
                continue;
            }
            [html appendString:@"<strong>"];
            [html appendString:(NSString*)[ary objectAtIndex:0]];
            [html appendString:@"</strong>"];
            [html appendString:@"<p>"];
            [html appendString:(NSString*)[ary objectAtIndex:1]];
            [html appendString:@"</p>"];
        }
    }else
    {
        for (NSString* item in _resultContentList) {
            NSArray* ary = [item componentsSeparatedByString:@"\n"];
            if ([ary count] <= 2) {
                continue;
            }
            
            NSMutableString* title = [NSMutableString stringWithString:(NSString*)[ary objectAtIndex:0]];
            NSMutableString* contt = [NSMutableString stringWithString:(NSString*)[ary objectAtIndex:1]];
            
            
            [html appendString:@"<strong>"];
            [html appendString:title];
            [html appendString:@"</strong>"];
            
            [html appendString:@"<p>"];
            [html appendString:contt];
            [html appendString:@"</p>"];
        }        
    }
    
    return html;
}

- (id)init
{
    self = [super init];
    if (self) {
        // Custom initialization
        _helpContentList = [[NSMutableArray alloc] initWithObjects:nil];
        
        [_helpContentList addObject:@"Q1. 为什么掌厅客户端无法自动登录？\n答：您好，1、请提供您使用的手机品牌/型号，有可能是因为手机未获得标准的入网许可证所致，如港行、美行或者山寨手机等，建议您输入手机号和密码进行手动登录；2、如您手动登录仍无法访问,请提供您的手机号码、手机密码、手机型号、使用客户端版本号、登录时间等信息，使用客户端版本号通过手机自带的应用程序管理器获得，如：版本3.0.3（F），我们会及时为您处理解决。感谢您对掌厅客户端的使用及对中国电信的支持。\n"];
        
        [_helpContentList addObject:@"Q2. 为什么手动输入账号密码失败？\n答：您好，1、请您先核实您的帐号密码录入是否准确， 然后再次登录尝试。2、如您帐号密码正确仍无法登录,请提供您的手机号码、手机密码、手机型号、使用客户端版本号、登录时间等信息，使用客户端版本号通过手机自带的应用程序管理器获得，如：版本3.0.3（F），我们会及时为您处理解决。感谢您对掌厅客户端的使用及对中国电信的支持。\n"];
        
        [_helpContentList addObject:@"Q3. 积分显示错误，或者是积分不显示的原因？\n答：您好，1、请您登录网上营业厅（http://www.189.cn）查询积分是否与掌厅客户端显示不一致；2、如积分与网上营业厅显示不一致或者不显示，请提供您的手机号码、手机密码、手机型号、使用客户端版本号、登录时间等信息，使用客户端版本号通过手机自带的应用程序管理器获得，如：版本3.0.3（F），我们会及时为您处理解决。感谢您对掌厅客户端的使用及对中国电信的支持。\n"];
        
        [_helpContentList addObject:@"Q4. 费用查询（话费、余额）错误（或不显示）的原因？\n您好，1、请您登录网上营业厅（http://www.189.cn）查询话费、余额是否与掌厅客户端显示不一致；2、如话费、余额与网上营业厅显示不一致或者不显示，请提供您的手机号码、手机密码、手机型号、使用客户端版本号、登录时间等信息，使用客户端版本号通过手机自带的应用程序管理器获得，如：版本3.0.3（F），我们会及时为您处理解决。感谢您对掌厅客户端的使用及对中国电信的支持。\n"];
        
        [_helpContentList addObject:@"Q5. 为什么我的流量显示一直为空？\n答：您好，1、可能由于电信月出账期而导致流量显示为空，请您退出重新登录尝试是否显示；2、如仍显示为空，请提供您的手机号码、手机密码、手机型号、使用客户端版本号、登录时间等信息，使用客户端版本号通过手机自带的应用程序管理器获得，如：版本3.0.3（F），我们会及时为您处理解决。感谢您对掌厅客户端的使用及对中国电信的支持。\n"];
        
        [_helpContentList addObject:@"Q6. 为什么我的流量超出套餐后不显示？\n答：您好，流量数据只体现套餐内赠送流量的使用情况，如您的套餐内无赠送的流量（或已超出套餐内流量），则无法显示非套餐内流量的使用情况。感谢您对掌厅客户端的使用及对中国电信的支持。\n"];
        
        [_helpContentList addObject:@"Q7. 为什么我的流量卡流量不显示？\n答：您好，目前掌厅客户端暂不支持流量卡的流量查询，后续我们会及时向您提供此项功能。感谢您对掌厅客户端的使用及对中国电信的支持。\n"];
        
        [_helpContentList addObject:@"Q8. 为什么我的流量/话费/余额（等业务查询）显示不准确或是无显示？\n答：您好，1、请您登录网上营业厅（http://www.189.cn）查询流量/话费/余额是否与掌厅客户端显示不一致；2、如流量/话费/余额与网上营业厅显示不一致或者不显示，请提供您的手机号码、手机密码、手机型号、使用客户端版本号、登录时间等信息，使用客户端版本号通过手机自带的应用程序管理器获得，如：版本3.0.3（F），我们会及时为您处理解决。感谢您对掌厅客户端的使用及对中国电信的支持。\n"];
        
        [_helpContentList addObject:@"Q9. 为什么登录后显示的用户名与实际用户名不一致？\n答：您好，1、如果您属于政企客户，可能显示的是大客户的姓名；2、如果您不属于政企客户，请提供您的手机号码、手机密码、手机型号、使用客户端版本号、登录时间等信息，使用客户端版本号通过手机自带的应用程序管理器获得，如：版本3.0.3（F），我们及时为您处理解决。感谢您对掌厅客户端的使用及对中国电信的支持。\n"];
        
        [_helpContentList addObject:@"Q10. 为什么189邮箱等增值业务无法成功办理？\n答：您好，1、可能由于电信月出账期而导致增值业务办理失败，请您退出重新登录尝试办理；2、如您再次办理失败,请提供您的手机号码、手机密码、手机型号、使用客户端版本号、登录时间等信息，使用客户端版本号通过手机自带的应用程序管理器获得，如：版本3.0.3（F），我们会及时为您处理解决。感谢您对掌厅客户端的使用及对中国电信的支持。\n"];
        
        [_helpContentList addObject:@"Q11. 客户端上为什么无法变更套餐？\n答：您好，掌厅客户端目前仅支持增值业务的套餐变更，如189邮箱等增值业务，其他套餐变更暂不支持。感谢您对掌厅客户端的使用及对中国电信的支持。\n"];
        
        [_helpContentList addObject:@"Q12. 为什么终端类型比较少？\n答：您好，掌厅客户端提供的终端均为时下最受欢迎并热销的品牌型号，以方便您的快速选择，如您有其他需要，可以登录网上营业厅（http://www.189.cn）查看全部型号。感谢您对掌厅客户端的使用及对中国电信的支持。\n"];
        
        [_helpContentList addObject:@"Q13. 为什么订单无法下发成功？\n答：您好，1、您可在网络环境好的情况下再次尝试提交订单；2、如您在网络环境好的情况仍无法提交订单，请提供您的手机号码、手机密码、手机型号、使用客户端版本号、登录时间等信息，使用客户端版本号通过手机自带的应用程序管理器获得，如：版本3.0.3（F），我们会及时为您处理解决。感谢您对掌厅客户端的使用及对中国电信的支持。\n"];
        
        [_helpContentList addObject:@"Q14. 为什么无法成功支付？\n答：您好，1、您可在网络环境好的情况下再次尝试支付；2、如您在网络环境好的情况仍无法成功支付，请提供您的手机号码、手机密码、手机型号、使用客户端版本号、登录时间等信息，使用客户端版本号通过手机自带的应用程序管理器获得，如：版本3.0.3（F），我们会及时为您处理解决。感谢您对掌厅客户端的使用及对中国电信的支持。\n"];
        
        [_helpContentList addObject:@"Q15. 为什么没有号码供选？\n答：您好，请提供您的手机号码、手机密码、手机型号、使用客户端版本号、登录时间等信息，使用客户端版本号通过手机自带的应用程序管理器获得，如：版本3.0.3（F），我们会及时为您处理解决。感谢您对掌厅客户端的使用及对中国电信的支持。\n"];
        
        [_helpContentList addObject:@"Q16. 号卡购买后，想要退（换）货怎么办？\n答：您好，号卡售出后无法退货。如因号卡问题需要办理换卡，您可登录（http://www.189.cn）通过我的订单提出“换货申请“，在终端公司在核实用户提供的证据，并换货审核通过后，会通知您将问题号卡寄回，并重制新号卡寄回。感谢您对掌厅客户端的使用及对中国电信的支持。\n"];
        
        [_helpContentList addObject:@"Q17. 提示充值成功，但是没有相关的费用/流量到账？\n答：您好，1、您可登录网上营业厅（http://www.189.cn）进行查询费用/流量；2、如您查询后仍无到账，请提供您的手机号码、手机密码、手机型号、使用客户端版本号、登录时间、充值卡密码等信息，使用客户端版本号通过手机自带的应用程序管理器获得，如：版本3.0.3（F），我们会及时为您处理解决。感谢您对掌厅客户端的使用及对中国电信的支持。\n"];

        _resultContentList = [NSMutableArray new];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    [self setTitle:@"使用指南"];
    // 左按钮
    [self setLeftButton:[UIImage imageNamed:@"btn_back"]];
    
    CGFloat winWidth = self.view.bounds.size.width;
    int xOffset = 0;
    int yOffset = 0;
    {
        UIImageView* divLine = [[UIImageView alloc] initWithFrame:CGRectMake(0,yOffset,winWidth,2)];
        divLine.image = [UIImage imageNamed:@"div_line.png"];
        [self.view addSubview:divLine];
        yOffset += 2;
    }
    
    {
        yOffset += 8;
        if (_tfSearchContent) {
            _tfSearchContent = nil;
        }
        _tfSearchContent = [[UITextField alloc] initWithFrame:CGRectMake(20,yOffset,winWidth - 100,36)];
        _tfSearchContent.placeholder  = @"请简单完整的输入您的问题";
        _tfSearchContent.textColor    = [UIColor darkTextColor];
        _tfSearchContent.font         = [UIFont systemFontOfSize:15];
        _tfSearchContent.backgroundColor = [UIColor whiteColor];
        _tfSearchContent.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        _tfSearchContent.returnKeyType = UIReturnKeySearch;
        _tfSearchContent.clearButtonMode = UITextFieldViewModeWhileEditing;
        _tfSearchContent.delegate      = (id<UITextFieldDelegate>)self;
        {
            UIView *mView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 5, 10)];
            mView.backgroundColor = [UIColor clearColor];
            _tfSearchContent.leftView = mView;
            _tfSearchContent.leftViewMode = UITextFieldViewModeAlways;
        }
        [self.view addSubview:_tfSearchContent];
        xOffset = 20 + _tfSearchContent.frame.size.width;

        xOffset += 1;
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(xOffset, yOffset, 60, 36);
        button.backgroundColor = [UIColor colorWithRed:111/255. green:197/255. blue:55/255. alpha:1.00f];
        button.titleLabel.font = [UIFont systemFontOfSize:15.0f];
        [button setTitle:@"搜索" forState:UIControlStateNormal];
        [button addTarget:self action:@selector(onSearchHelp) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:button];
    }
    
    yOffset = 52;
    {
        UIImageView* divLine = [[UIImageView alloc] initWithFrame:CGRectMake(0,yOffset,winWidth,2)];
        divLine.image = [UIImage imageNamed:@"div_line.png"];
        [self.view addSubview:divLine];
        yOffset += 2;
    }
    
    {
        _webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, yOffset, winWidth, self.view.bounds.size.height - 54)];
        _webView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
        _webView.backgroundColor  = [UIColor clearColor];
        _webView.delegate   = self;
        [_webView setOpaque:NO];
        for(UIView *v in [[[_webView subviews] objectAtIndex:0] subviews])
        {
            if([v isKindOfClass:[UIImageView class]])
            {
                v.hidden = YES;
            }
        }
        [self.view addSubview:_webView];
        NSString* webHtml = [self ganerateWebHtml:NO];
        NSString *basePath = [[NSBundle mainBundle] resourcePath];
        NSURL *   baseURL  = [NSURL fileURLWithPath:basePath];
        [_webView loadHTMLString:webHtml baseURL:baseURL];
    }
    
    {
        UIButton *btnHideKeyboard = [UIButton buttonWithType:UIButtonTypeCustom];
        btnHideKeyboard.frame = CGRectMake(0,60, self.view.bounds.size.width, self.view.bounds.size.height);
        btnHideKeyboard.backgroundColor = [UIColor clearColor];
        [btnHideKeyboard addTarget:self action:@selector(onHideKeyboard) forControlEvents:UIControlEventTouchUpInside];
        _btnHideKeyboard = btnHideKeyboard;
        _btnHideKeyboard.hidden = YES;
        [self.view addSubview:btnHideKeyboard];
    }
}

- (void)clearResultArea
{
    //_labHelpResult.text = @"";
}

- (void)resetView
{
    NSString* webHtml = nil;
    if ([_resultContentList count] <= 0) {
        webHtml = [self ganerateWebHtml:NO];
    }else{
        webHtml = [self ganerateWebHtml:YES];
    }
    
    NSString *basePath = [[NSBundle mainBundle] resourcePath];
    NSURL *   baseURL  = [NSURL fileURLWithPath:basePath];
    [_webView loadHTMLString:webHtml baseURL:baseURL];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - IBAction
- (void)onSearchHelp
{
    [self onHideKeyboard];
    
    if (_tfSearchContent.text.length == 0)
    {
        [_resultContentList removeAllObjects];
        [_resultContentList setArray:_helpContentList];
        [self resetView];
        
        return;
    }
    else
    {
        [_resultContentList removeAllObjects];
        
        if ([_helpContentList count] > 0)
        {
            for (NSString* help in _helpContentList)
            {
                NSRange range = [help rangeOfString:_tfSearchContent.text]; // 字符串查找,可以判断字符串中是否有
                
                if (range.location != NSNotFound)
                { 
                    [_resultContentList addObject:help];  
                }
            }
            
            if ([_resultContentList count] > 0)
            {
                [self clearResultArea];
                [self resetView];
            }
            else
            {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示！"
                                                                message:@"未找到您要查找的问题！"
                                                               delegate:nil
                                                      cancelButtonTitle:@"确定"
                                                      otherButtonTitles:nil];
                [alert show];
            }
        }
    
    }
}

- (void)onHideKeyboard
{
    // 关闭键盘
    [_tfSearchContent resignFirstResponder];
    _btnHideKeyboard.hidden = YES;
}


#pragma mark UITextfieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField.returnKeyType == UIReturnKeySearch)
    {
        if (textField.text.length == 0)
        {
            [_resultContentList removeAllObjects];
            [_resultContentList setArray:_helpContentList];
            [self resetView];
        }
        else
        {
            [self onSearchHelp];
        }
        [textField resignFirstResponder];
        return YES;
    }
    
    [textField resignFirstResponder];
    
    return YES;
}


- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    _btnHideKeyboard.hidden = NO;
    return YES;
}


- (BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
    _btnHideKeyboard.hidden = NO;
    return YES;
}



- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    if (_tfSearchContent && _tfSearchContent.text && [_tfSearchContent.text length] > 0) {
        [_webView highlightAllOccurencesOfString:_tfSearchContent.text];
    }
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    if (_tfSearchContent && _tfSearchContent.text && [_tfSearchContent.text length] > 0) {
        [_webView highlightAllOccurencesOfString:_tfSearchContent.text];
    }
}




@end
