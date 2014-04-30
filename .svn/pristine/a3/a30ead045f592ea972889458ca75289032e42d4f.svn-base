//
//  CInvoiceEditView.h
//  CTPocketV4
//
//  Created by apple on 14-3-25.
//  Copyright (c) 2014年 广东亿迅科技有限公司. All rights reserved.
//

// 自定义发票页面

@protocol CInvoiceEditViewDelegate <NSObject>
-(void)onHiddenInvoiceView:(id)sender;  // 隐藏、输入框等
@end

#import <UIKit/UIKit.h>

@interface CInvoiceEditView : UIView <UITextFieldDelegate>
{
    UIView *containView;
}

@property(nonatomic,assign)    id<CInvoiceEditViewDelegate> delegate;
@property (strong, nonatomic)UITextField *companyField;
@property NSInteger checkNum;
@property NSInteger metrialNum;

-(void)hiddenKeyBord;

@end
