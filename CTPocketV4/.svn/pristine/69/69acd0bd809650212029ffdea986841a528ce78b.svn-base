//
//  COrderWildProductFillVctrler.h
//  CTPocketV4
//
//  Created by apple on 14-3-26.
//  Copyright (c) 2014年 广东亿迅科技有限公司. All rights reserved.
//


// 百搭品订单填写

#import <UIKit/UIKit.h>
#import "CTBaseViewController.h"
#import "CRecipientEditView.h"
#import "QryBdSalesComInfo.h"
#import "CTPrettyNumData.h"
#import "CInvoiceEditView.h"

@interface COrderWildProductFillVctrler : CTBaseViewController
<CRecipientEditViewDelegate, CInvoiceEditViewDelegate,UITextFieldDelegate>
{
    
}

@property (nonatomic, strong) NSDictionary *info;
@property (nonatomic, strong) QryBdSalesComInfoModel *dataModel;
@property (nonatomic, strong) CTPrettyNumData *phoneData;
@property (nonatomic, strong) NSString *SalesProdId;

-(void)hiddenPicker;

@end
