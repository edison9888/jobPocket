//
//  UIWebView+SearchWebView.h
//  CTPocketV4
//
//  Created by Mac-Eshore-01 on 13-11-1.
//  Copyright (c) 2013年 广东亿迅科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIWebView (SearchWebView)
-(NSInteger)highlightAllOccurencesOfString:(NSString*)str;
-(void)removeAllHighlights;
@end
