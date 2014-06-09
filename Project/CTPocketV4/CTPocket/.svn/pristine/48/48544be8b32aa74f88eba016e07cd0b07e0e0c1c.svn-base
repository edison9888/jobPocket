//
//  CTPHelpVCtler.h
//  CTPocketv3
//
//  Created by lyh on 13-4-17.
//
//

#import "CTBaseViewController.h"
#import "UIWebView+SearchWebView.h"

@interface CTPHelpVCtler : CTBaseViewController
<UIWebViewDelegate>
{
    NSMutableArray* _helpContentList;
    NSMutableArray* _resultContentList;
    
    UITextField* _tfSearchContent;
    UIButton*    _btnHideKeyboard;
    
    UIWebView*   _webView;
}

- (void)clearResultArea;
- (void)resetView;

- (void)onSearchHelp;
- (void)onHideKeyboard;

@end
