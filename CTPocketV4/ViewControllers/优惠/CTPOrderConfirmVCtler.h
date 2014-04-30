//
//  OrderConfirmVCtler.h
//  CTPocketv3
//
//  Created by apple on 13-6-4.
//
//

/*
 提交订单
 */

#import "CTBaseViewController.h"

@interface CTPOrderConfirmVCtler : CTBaseViewController
{
    UIScrollView *              _contentScroll;
    UIButton *                  _confirmBtn;
    UIButton *                  _addrBtn;
    UIButton *                  _invoiceBtn;
    UIActivityIndicatorView *   _activityviewInfo;
    
//    CTPBaseDataSource *         _netSubmit;
}

@property (nonatomic, retain) NSDictionary * salesProductInfoDict;  // 1. 销售品信息
@property (nonatomic, retain) NSDictionary * orderInfoDict;         // 2. 订单信息
@property (nonatomic, retain) NSDictionary * DeliveryInfo;          // 3. 收货地址信息
@property (nonatomic, retain) NSDictionary * InvoiceInfo;           // 4. 发票信息
@property (nonatomic, retain) NSDictionary * CustomerInfo;          // 5. 用户入网信息（裸终端类型订单无需此字段）
@property (nonatomic, retain) NSDictionary * ContractInfo;          // 6. 合约信息（裸终端类型订单无需此字段）
@property (nonatomic, retain) NSDictionary * PackageInfoDict;       // 7. 套餐信息（裸终端类型订单无需此字段）

@end
