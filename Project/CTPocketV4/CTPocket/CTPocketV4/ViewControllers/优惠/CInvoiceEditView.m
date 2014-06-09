//
//  CInvoiceEditView.m
//  CTPocketV4
//
//  Created by apple on 14-3-25.
//  Copyright (c) 2014年 广东亿迅科技有限公司. All rights reserved.
//

#define TAG_PERSON_BTN 1
#define TAG_COMPANY_BTN 2
#define TAG_METRIAL_BTN 3
#define TAG_DETAIL_BTN 4

#import "CInvoiceEditView.h"
#import "SIAlertView.h"
#import "COrderWildProductFillVctrler.h"

@implementation CInvoiceEditView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
   
    if (self)
    {
        _metrialNum = 1;
        [self companyNo];
    }
    return self;
}

#pragma mark - CheckBtn

- (void)onServiceLienceCheckBtn:(UIButton* )btn
{
    
    int tag=btn.tag;

    switch (tag) {
        case TAG_PERSON_BTN:
        {
            BOOL selected=btn.selected;
            [self companyNo];
            btn.selected=!selected;
            break;
        }
            
        case TAG_COMPANY_BTN:
        {
            BOOL selected=btn.selected;
            [self companyYes];
            btn.selected=!selected;
            break;
        }
            
        case TAG_METRIAL_BTN:
        {
//            bool selected=btn.selected;
//            btn.selected=!selected;
            btn.selected = YES;
            if (btn.selected) {
                _metrialNum = 1;
                NSLog(@"meNum is %d", _metrialNum);
            }
            UIButton *btn_detail=(UIButton*)[self viewWithTag:TAG_DETAIL_BTN];
            btn_detail.selected= NO;
            break;
        }
        case TAG_DETAIL_BTN:
        {
//            bool selected=btn.selected;
//            btn.selected=!selected;
            btn.selected = YES;
            if (btn.selected) {
                _metrialNum = 0;
                NSLog(@"meNum is %d", _metrialNum);
            }
            UIButton *btn_detail=(UIButton*)[self viewWithTag:TAG_METRIAL_BTN];
            btn_detail.selected= NO;
            break;
        }
            
        default:
            break;
    }
}


#pragma mark - CompanyCheckbox

- (void)companyNo
{
    _checkNum = 0;
    
    [containView removeFromSuperview];
    containView=[[UIView alloc] initWithFrame:self.bounds];;
    [self addSubview:containView];
    int originY = 14;
    
    // 显示发票信息可选项
    originY = originY + 15;
    
    UILabel *itemTitle = [[UILabel alloc] initWithFrame:CGRectMake(64 - 49, originY - 4 - 10, 160, 15)];
    itemTitle.backgroundColor = [UIColor clearColor];
    itemTitle.font = [UIFont boldSystemFontOfSize:15.0f];
    itemTitle.textColor = [UIColor blackColor];
    itemTitle.text = @"选择发票信息";
    [containView addSubview:itemTitle];
    
    //外框绘制
    UIImage* image = [UIImage imageNamed:@"prettyNum_dividingLine_ver"];
    UIImageView* imageView = [[UIImageView alloc] initWithFrame:CGRectMake(64 - 49, originY + 15 + 5 - 4 + 10, 244, 1)];
    imageView.image = image;
    [containView addSubview:imageView];// --
    image = [UIImage imageNamed:@"prettyNum_dividingLine_ver@2x"];
    imageView = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetMinX(imageView.frame), CGRectGetMinY(imageView.frame) + CGRectGetHeight(imageView.frame), 1, 100)];
    imageView.image = image;
    [containView addSubview:imageView];// |
    image = [UIImage imageNamed:@"prettyNum_dividingLine_ver"];
    imageView = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetMinX(imageView.frame), CGRectGetMinY(imageView.frame) + CGRectGetHeight(imageView.frame) -2, 245, 1)];
    imageView.image = image;
    CGRect rect = imageView.frame;  //取第三横线frame
    [containView addSubview:imageView]; // --
    image = [UIImage imageNamed:@"prettyNum_dividingLine_ver@2x"];
    imageView = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetMinX(imageView.frame) + 244, originY + 15 + 5 - 4 + 10, 1, 101)];
    imageView.image = image;
    [containView addSubview:imageView]; // |
    
    //发票选项内容
    UILabel *invoiceLabel = [[UILabel alloc]initWithFrame:CGRectMake(64 - 49 + 10, originY + 15 + 5 - 4 + 10 + 10, 80, 35)];
    invoiceLabel.backgroundColor = [UIColor clearColor];
    invoiceLabel.text = @"发票抬头:";
    invoiceLabel.font = [UIFont systemFontOfSize:15.0f];
    [containView addSubview:invoiceLabel]; // 发票抬头
    invoiceLabel = [[UILabel alloc]initWithFrame:CGRectMake(64 - 49 + 10, CGRectGetMinY(rect) - 40, 70, 35)];
    invoiceLabel.backgroundColor = [UIColor clearColor];
    invoiceLabel.text = @"发票内容:";
    invoiceLabel.font = [UIFont systemFontOfSize:15.0f];
    [containView addSubview:invoiceLabel]; // 发票内容
    UIImage* img = [UIImage imageNamed:@"login_button1"];
    UIButton* btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(64 - 49 + 10 + CGRectGetWidth(invoiceLabel.frame), originY + 15 + 5 - 4 + 10 + 10, 30, 35);
    [btn setImage:img forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:@"login_button1_selected"] forState:UIControlStateSelected];
    [btn setImageEdgeInsets:UIEdgeInsetsMake((CGRectGetHeight(btn.frame) - img.size.height)/2,
                                             (CGRectGetWidth(btn.frame) - img.size.width)/2,
                                             (CGRectGetHeight(btn.frame) - img.size.height)/2,
                                             (CGRectGetWidth(btn.frame) - img.size.width)/2)];
    btn.selected = YES;
    [btn addTarget:self action:@selector(onServiceLienceCheckBtn:) forControlEvents:UIControlEventTouchUpInside];
    btn.tag = TAG_PERSON_BTN;
    [containView addSubview:btn]; // 个人checkbox
    invoiceLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMinX(btn.frame)+30, CGRectGetMinY(btn.frame), 40, 35)];
    invoiceLabel.backgroundColor = [UIColor clearColor];
    invoiceLabel.text = @"个人";
    invoiceLabel.font = [UIFont systemFontOfSize:15.0f];
    [containView addSubview:invoiceLabel]; // 个人Label
    img = [UIImage imageNamed:@"login_button1"];
    btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(CGRectGetMinX(invoiceLabel.frame)+60, CGRectGetMinY(invoiceLabel.frame), 30, 35);
    [btn setImage:img forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:@"login_button1_selected"] forState:UIControlStateSelected];
    [btn setImageEdgeInsets:UIEdgeInsetsMake((CGRectGetHeight(btn.frame) - img.size.height)/2,
                                             (CGRectGetWidth(btn.frame) - img.size.width)/2,
                                             (CGRectGetHeight(btn.frame) - img.size.height)/2,
                                             (CGRectGetWidth(btn.frame) - img.size.width)/2)];
    [btn addTarget:self action:@selector(onServiceLienceCheckBtn:) forControlEvents:UIControlEventTouchUpInside];
    btn.tag = TAG_COMPANY_BTN;
    [containView addSubview:btn]; // 公司checkbox
    invoiceLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMinX(btn.frame)+30, CGRectGetMinY(btn.frame), 40, 35)];
    invoiceLabel.backgroundColor = [UIColor clearColor];
    invoiceLabel.text = @"公司";
    invoiceLabel.font = [UIFont systemFontOfSize:15.0f];
    [containView addSubview:invoiceLabel]; // 公司Label
    img = [UIImage imageNamed:@"login_button1"];
    btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(64 - 49 + 10 + 70, CGRectGetMinY(rect) - 40, 30, 35);
    [btn setImage:img forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:@"login_button1_selected"] forState:UIControlStateSelected];
    [btn setImageEdgeInsets:UIEdgeInsetsMake((CGRectGetHeight(btn.frame) - img.size.height)/2,
                                             (CGRectGetWidth(btn.frame) - img.size.width)/2,
                                             (CGRectGetHeight(btn.frame) - img.size.height)/2,
                                             (CGRectGetWidth(btn.frame) - img.size.width)/2)];
    //btn.selected = YES;
    [btn addTarget:self action:@selector(onServiceLienceCheckBtn:) forControlEvents:UIControlEventTouchUpInside];
    btn.tag = TAG_METRIAL_BTN;
    [containView addSubview:btn]; // 通信器材checkbox
    invoiceLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMinX(btn.frame)+30, CGRectGetMinY(btn.frame), 60, 35)];
    invoiceLabel.backgroundColor = [UIColor clearColor];
    invoiceLabel.text = @"通信器材";
    invoiceLabel.font = [UIFont systemFontOfSize:15.0f];
    [containView addSubview:invoiceLabel]; // 通信器材Label
    img = [UIImage imageNamed:@"login_button1"];
    btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(CGRectGetMinX(invoiceLabel.frame)+60, CGRectGetMinY(invoiceLabel.frame), 30, 35);
    [btn setImage:img forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:@"login_button1_selected"] forState:UIControlStateSelected];
    [btn setImageEdgeInsets:UIEdgeInsetsMake((CGRectGetHeight(btn.frame) - img.size.height)/2,
                                             (CGRectGetWidth(btn.frame) - img.size.width)/2,
                                             (CGRectGetHeight(btn.frame) - img.size.height)/2,
                                             (CGRectGetWidth(btn.frame) - img.size.width)/2)];
    [btn addTarget:self action:@selector(onServiceLienceCheckBtn:) forControlEvents:UIControlEventTouchUpInside];
    btn.tag = TAG_DETAIL_BTN;
    [containView addSubview:btn]; // 明细checkbox
    invoiceLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMinX(btn.frame)+30, CGRectGetMinY(btn.frame), 40, 35)];
    invoiceLabel.backgroundColor = [UIColor clearColor];
    invoiceLabel.text = @"明细";
    invoiceLabel.font = [UIFont systemFontOfSize:15.0f];
    [containView addSubview:invoiceLabel]; // 明细Label
    
    // 支付方式
    originY = CGRectGetMinY(rect) + 20;
    
    UILabel *payTitle = [[UILabel alloc] initWithFrame:CGRectMake(64 - 49, originY, 100, 15)];
    payTitle.backgroundColor = [UIColor clearColor];
    payTitle.font = [UIFont boldSystemFontOfSize:15.0f];
    payTitle.textColor = [UIColor blackColor];
    payTitle.text = @"选择支付方式";
    [containView addSubview:payTitle];
    originY = originY + 15 + 18;
    
    UIImageView *pay = [[UIImageView alloc] initWithFrame:CGRectMake(64 - 49, originY, 96, 29)];
    pay.image = [UIImage imageNamed:@"WriteOrderInfo_pay@2x"];
    [containView addSubview:pay];
    
    UILabel *payLabel = [[UILabel alloc] initWithFrame:pay.bounds];
    payLabel.backgroundColor = [UIColor clearColor];
    payLabel.font = [UIFont systemFontOfSize:14.0f];
    payLabel.textColor = [UIColor colorWithRed:0.43 green:0.77 blue:0.21 alpha:1];
    payLabel.textAlignment = UITextAlignmentCenter;
    payLabel.text = @"在线支付";
    [pay addSubview:payLabel];
    
    if (_metrialNum == 1) {
        UIButton *btn = (UIButton *)[self viewWithTag:TAG_METRIAL_BTN];
        btn.selected = YES;
    }else
    {
        UIButton *btn = (UIButton *)[self viewWithTag:TAG_DETAIL_BTN];
        btn.selected = YES;
    }
}

- (void)companyYes
{
    _checkNum = 1;
    //_metrialNum = 1;
    
    [containView removeFromSuperview];
    containView=[[UIView alloc] initWithFrame:self.bounds];;
    [self addSubview:containView];
    
    CGRect frame = self.frame;
    UIButton* btnHidden = [UIButton buttonWithType:UIButtonTypeCustom];
    btnHidden.backgroundColor = [UIColor clearColor];
    btnHidden.frame = CGRectMake(0, 0, CGRectGetWidth(frame), CGRectGetHeight(frame));
    btnHidden.autoresizingMask = UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth;
    [btnHidden addTarget:self action:@selector(onBtnHidden:) forControlEvents:UIControlEventTouchUpInside];
    [containView addSubview:btnHidden];
    
    int originY = 14;
    
    // 显示发票信息可选项
    originY = originY + 15;
    
    UILabel *itemTitle = [[UILabel alloc] initWithFrame:CGRectMake(64 - 49, originY - 4 - 10, 160, 15)];
    itemTitle.backgroundColor = [UIColor clearColor];
    itemTitle.font = [UIFont boldSystemFontOfSize:15.0f];
    itemTitle.textColor = [UIColor blackColor];
    itemTitle.text = @"选择发票信息";
    [containView addSubview:itemTitle];
    
    //外框绘制
    UIImage* image = [UIImage imageNamed:@"prettyNum_dividingLine_ver"];
    UIImageView* imageView = [[UIImageView alloc] initWithFrame:CGRectMake(64 - 49, originY + 15 + 5 - 4 + 10, 244, 1)];
    imageView.image = image;
    [containView addSubview:imageView];// --
    image = [UIImage imageNamed:@"prettyNum_dividingLine_ver@2x"];
    imageView = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetMinX(imageView.frame), CGRectGetMinY(imageView.frame) + CGRectGetHeight(imageView.frame), 1, 100 + 50)];
    imageView.image = image;
    [containView addSubview:imageView];// |
    image = [UIImage imageNamed:@"prettyNum_dividingLine_ver"];
    imageView = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetMinX(imageView.frame), CGRectGetMinY(imageView.frame) + CGRectGetHeight(imageView.frame) -2, 245, 1)];
    imageView.image = image;
    CGRect rect = imageView.frame;  //取第三横线frame
    [containView addSubview:imageView]; // --
    image = [UIImage imageNamed:@"prettyNum_dividingLine_ver@2x"];
    imageView = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetMinX(imageView.frame) + 244, originY + 15 + 5 - 4 + 10, 1, 101 + 50)];
    imageView.image = image;
    [containView addSubview:imageView]; // |
    
    //发票选项内容
    UILabel *invoiceLabel = [[UILabel alloc]initWithFrame:CGRectMake(64 - 49 + 10, originY + 15 + 5 - 4 + 10 + 10, 80, 35)];
    invoiceLabel.backgroundColor = [UIColor clearColor];
    invoiceLabel.text = @"发票抬头:";
    invoiceLabel.font = [UIFont systemFontOfSize:15.0f];
    [containView addSubview:invoiceLabel]; // 发票抬头
    invoiceLabel = [[UILabel alloc]initWithFrame:CGRectMake(64 - 49 + 10, CGRectGetMinY(rect) - 40, 70, 35)];
    invoiceLabel.backgroundColor = [UIColor clearColor];
    invoiceLabel.text = @"发票内容:";
    invoiceLabel.font = [UIFont systemFontOfSize:15.0f];
    [containView addSubview:invoiceLabel]; // 发票内容
    UIImage* img = [UIImage imageNamed:@"login_button1"];
    UIButton* btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(64 - 49 + 10 + CGRectGetWidth(invoiceLabel.frame), originY + 15 + 5 - 4 + 10 + 10, 30, 35);
    [btn setImage:img forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:@"login_button1_selected"] forState:UIControlStateSelected];
    [btn setImageEdgeInsets:UIEdgeInsetsMake((CGRectGetHeight(btn.frame) - img.size.height)/2,
                                             (CGRectGetWidth(btn.frame) - img.size.width)/2,
                                             (CGRectGetHeight(btn.frame) - img.size.height)/2,
                                             (CGRectGetWidth(btn.frame) - img.size.width)/2)];
    btn.selected = NO;
    [btn addTarget:self action:@selector(onServiceLienceCheckBtn:) forControlEvents:UIControlEventTouchUpInside];
    btn.tag = TAG_PERSON_BTN;
    [containView addSubview:btn]; // 个人checkbox
    invoiceLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMinX(btn.frame)+30, CGRectGetMinY(btn.frame), 40, 35)];
    invoiceLabel.backgroundColor = [UIColor clearColor];
    invoiceLabel.text = @"个人";
    invoiceLabel.font = [UIFont systemFontOfSize:15.0f];
    [containView addSubview:invoiceLabel]; // 个人Label
    img = [UIImage imageNamed:@"login_button1"];
    btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(CGRectGetMinX(invoiceLabel.frame)+60, CGRectGetMinY(invoiceLabel.frame), 30, 35);
    [btn setImage:img forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:@"login_button1_selected"] forState:UIControlStateSelected];
    [btn setImageEdgeInsets:UIEdgeInsetsMake((CGRectGetHeight(btn.frame) - img.size.height)/2,
                                             (CGRectGetWidth(btn.frame) - img.size.width)/2,
                                             (CGRectGetHeight(btn.frame) - img.size.height)/2,
                                             (CGRectGetWidth(btn.frame) - img.size.width)/2)];
    [btn addTarget:self action:@selector(onServiceLienceCheckBtn:) forControlEvents:UIControlEventTouchUpInside];
    btn.tag = TAG_COMPANY_BTN;
    btn.selected = YES;
    [containView addSubview:btn]; // 公司checkbox
    invoiceLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMinX(btn.frame)+30, CGRectGetMinY(btn.frame), 40, 35)];
    invoiceLabel.backgroundColor = [UIColor clearColor];
    invoiceLabel.text = @"公司";
    invoiceLabel.font = [UIFont systemFontOfSize:15.0f];
    [containView addSubview:invoiceLabel]; // 公司Label
    img = [UIImage imageNamed:@"login_button1"];
    btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(64 - 49 + 10 + 70, CGRectGetMinY(rect) - 40, 30, 35);
    [btn setImage:img forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:@"login_button1_selected"] forState:UIControlStateSelected];
    [btn setImageEdgeInsets:UIEdgeInsetsMake((CGRectGetHeight(btn.frame) - img.size.height)/2,
                                             (CGRectGetWidth(btn.frame) - img.size.width)/2,
                                             (CGRectGetHeight(btn.frame) - img.size.height)/2,
                                             (CGRectGetWidth(btn.frame) - img.size.width)/2)];
//    btn.selected = YES;
    [btn addTarget:self action:@selector(onServiceLienceCheckBtn:) forControlEvents:UIControlEventTouchUpInside];
    btn.tag = TAG_METRIAL_BTN;
    [containView addSubview:btn]; // 通信器材checkbox
    invoiceLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMinX(btn.frame)+30, CGRectGetMinY(btn.frame), 60, 35)];
    invoiceLabel.backgroundColor = [UIColor clearColor];
    invoiceLabel.text = @"通信器材";
    invoiceLabel.font = [UIFont systemFontOfSize:15.0f];
    [containView addSubview:invoiceLabel]; // 通信器材Label
    img = [UIImage imageNamed:@"login_button1"];
    btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(CGRectGetMinX(invoiceLabel.frame)+60, CGRectGetMinY(invoiceLabel.frame), 30, 35);
    [btn setImage:img forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:@"login_button1_selected"] forState:UIControlStateSelected];
    [btn setImageEdgeInsets:UIEdgeInsetsMake((CGRectGetHeight(btn.frame) - img.size.height)/2,
                                             (CGRectGetWidth(btn.frame) - img.size.width)/2,
                                             (CGRectGetHeight(btn.frame) - img.size.height)/2,
                                             (CGRectGetWidth(btn.frame) - img.size.width)/2)];
    [btn addTarget:self action:@selector(onServiceLienceCheckBtn:) forControlEvents:UIControlEventTouchUpInside];
    btn.tag = TAG_DETAIL_BTN;
    [containView addSubview:btn]; // 明细checkbox
    invoiceLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMinX(btn.frame)+30, CGRectGetMinY(btn.frame), 40, 35)];
    invoiceLabel.backgroundColor = [UIColor clearColor];
    invoiceLabel.text = @"明细";
    invoiceLabel.font = [UIFont systemFontOfSize:15.0f];
    [containView addSubview:invoiceLabel]; // 明细Label
    
    // UITextField 公司发票
    UITextField *textView = [[UITextField alloc]initWithFrame:CGRectMake(64 - 49 + 10, originY + 15 + 5 - 4 + 10 + 10 + 10 + 35, 220, 45)];
    textView.backgroundColor = [UIColor whiteColor];
    textView.clearButtonMode = UITextFieldViewModeWhileEditing;
    textView.returnKeyType = UIReturnKeyDone;
    textView.keyboardType = UIKeyboardTypeDefault;
    textView.font = [UIFont systemFontOfSize:13.0f];
    textView.placeholder = @"公司名称";
    [containView addSubview:textView];
    textView.delegate = self;
    _companyField = textView;
    
    // 支付方式
    originY = CGRectGetMinY(rect) + 20;
    
    UILabel *payTitle = [[UILabel alloc] initWithFrame:CGRectMake(64 - 49, originY, 100, 15)];
    payTitle.backgroundColor = [UIColor clearColor];
    payTitle.font = [UIFont boldSystemFontOfSize:15.0f];
    payTitle.textColor = [UIColor blackColor];
    payTitle.text = @"选择支付方式";
    [containView addSubview:payTitle];
    originY = originY + 15 + 18;
    
    UIImageView *pay = [[UIImageView alloc] initWithFrame:CGRectMake(64 - 49, originY, 96, 29)];
    pay.image = [UIImage imageNamed:@"WriteOrderInfo_pay@2x"];
    [containView addSubview:pay];
    
    UILabel *payLabel = [[UILabel alloc] initWithFrame:pay.bounds];
    payLabel.backgroundColor = [UIColor clearColor];
    payLabel.font = [UIFont systemFontOfSize:14.0f];
    payLabel.textColor = [UIColor colorWithRed:0.43 green:0.77 blue:0.21 alpha:1];
    payLabel.textAlignment = UITextAlignmentCenter;
    payLabel.text = @"在线支付";
    [pay addSubview:payLabel];
    
    if (_metrialNum == 1) {
        UIButton *btn = (UIButton *)[self viewWithTag:TAG_METRIAL_BTN];
        btn.selected = YES;
    }else
    {
        UIButton *btn = (UIButton *)[self viewWithTag:TAG_DETAIL_BTN];
        btn.selected = YES;
    }
}

# pragma mark hiddenKeyBoard

-(void)hiddenKeyBord
{
    [_companyField resignFirstResponder];
}

-(void)onBtnHidden:(id)sender
{
    if(_delegate && [_delegate respondsToSelector:@selector(onHiddenInvoiceView:)])
    {
        [_delegate onHiddenInvoiceView:self];
    }
}

#pragma mark - UITextView Delegate Methods

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if(_delegate && [_delegate respondsToSelector:@selector(onHiddenInvoiceView:)])
    {
        [_delegate onHiddenInvoiceView:self];
    }
    return YES;
}

@end
