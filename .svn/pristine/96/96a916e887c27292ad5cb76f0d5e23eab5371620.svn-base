//
//  CTPInvoiceInfoVCtler.h
//  CTPocketv3
//
//  Created by lyh on 13-5-28.
//
//  发票信息

#import <UIKit/UIKit.h>
#import "CTBaseViewController.h"

@interface CTPInvoiceItem : NSObject
{
    int   _invoiceType;      // 0-选中，1－未选中
    int   _invoiceTitle;     // 0-个人，1－单位
    int   _itemListType;     // 0-明细，1－电脑配件，2－办公用品
}
@property(nonatomic)int   _invoiceType;
@property(nonatomic)int   _invoiceTitle;
@property(nonatomic)int   _itemListType;

@end


@interface CTPInvoiceInfoVCtler : CTBaseViewController
{
    UIImageView *   _greyBgView;
    UIScrollView *  _contentScroll;
    UITextField *   _tfOrgName;
    
    CTPInvoiceItem* _invoiceItem;
    
    NSDictionary* _salesProductInfoDict;  // 1. 销售品信息
    NSDictionary* _orderInfoDict;         // 2. 订单信息
    NSDictionary* _deliveryInfo;          // 3. 收货地址信息
    NSDictionary* _customerInfo;          // 5. 用户入网信息（裸终端类型订单无需此字段）
}
@property (nonatomic, retain) NSDictionary* _salesProductInfoDict;  // 1. 销售品信息
@property (nonatomic, retain) NSDictionary* _orderInfoDict;         // 2. 订单信息
@property (nonatomic, retain) NSDictionary* _deliveryInfo;          // 3. 收货地址信息
@property (nonatomic, retain) NSDictionary* _customerInfo;          // 5. 用户入网信息（裸终端类型订单无需此字段）

// added by zy=====
@property (nonatomic, retain) NSDictionary * ContractInfo;          // 3. 合约信息（裸终端类型订单无需此字段）
@property (nonatomic, retain) NSDictionary * PackageInfoDict;       // 4. 套餐信息（裸终端类型订单无需此字段）

@property (nonatomic, assign) BOOL  isModifyInvoiceinfo;            // 是否修改发票信息
@property (nonatomic, retain) NSDictionary *    invoiceInfo;        // 原始发票信息
// added by zy=====

-(void)setProductOrderInfo:(NSDictionary *)saleDict
                 orderInfo:(NSDictionary *)orderDict
               deliverInfo:(NSDictionary *)deliveryDict
              customerInfo:(NSDictionary *)customerDict;

-(NSDictionary*)getInvoiceInfo;

@end
