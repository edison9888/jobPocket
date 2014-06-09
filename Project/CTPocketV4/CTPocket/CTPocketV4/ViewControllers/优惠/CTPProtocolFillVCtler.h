//
//  CTPProtocolFillVCtler.h
//  CTPocketv3
//
//  Created by apple on 13-5-8.
//
//

/*
 入网协议填写
 */

#import "CTBaseViewController.h"

@interface CTPProtocolFillVCtler : CTBaseViewController
{
    UIImageView *       _greyBgView;
    UIScrollView *      _contentScroll;
    UINavigationBar *   _textfieldNaviBar;
    UITextField *       _nameText;
    UITextField *       _idText;
    UITextField *       _addrText;
    UITextField *       _postcodeText;
    UIButton *          _checkBtn;
    
    UIView *            _clickView;
}

@property (nonatomic, retain) NSDictionary * SalesproductInfoDict;  // 1. 销售品信息
@property (nonatomic, retain) NSDictionary * orderInfoDict;         // 2. 订单信息
@property (nonatomic, retain) NSDictionary * ContractInfo;          // 3. 合约信息（裸终端类型订单无需此字段）
@property (nonatomic, retain) NSDictionary * PackageInfoDict;       // 4. 套餐信息（裸终端类型订单无需此字段）
@property (nonatomic, retain) NSDictionary * NumberInfo;            // 5. 号码信息（裸终端类型订单无需此字段）

@end
