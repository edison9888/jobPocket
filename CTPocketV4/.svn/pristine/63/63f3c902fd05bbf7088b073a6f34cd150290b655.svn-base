//
//  CTPNewAddrVCtler.h
//  CTPocketv3
//
//  Created by apple on 13-4-26.
//
//

/*
 新增收货地址
 */

#import "CTBaseViewController.h"

@interface CTPNewAddrVCtler : CTBaseViewController
{
    UIImageView *       _greyBgView;
    UIScrollView *      _contentScroll;
    UITextField *       _nameTf;
    UITextField *       _phonenumTf;
    UITextField *       _postcodeTf;
    UIButton *          _countyBtn;
    UITextView *        _addrTf;
    UIButton *          _saveBtn;
    UINavigationBar *   _textfieldNaviBar;
    UIActivityIndicatorView * _activityviewInfo;
    UIPickerView *      _areaPicker;
    
    UIView *            _clickView;
    
    NSMutableDictionary *_netCitys;
    NSMutableDictionary *_netDistricts;
    NSMutableArray *    _areaList;
}

@property (nonatomic, retain) NSDictionary * userInfoDict;

@property (nonatomic, assign) BOOL           isSalesproduct;        // 是否为购买流程
@property (nonatomic, retain) NSDictionary * salesProductInfoDict;  // 1. 销售品信息
@property (nonatomic, retain) NSDictionary * orderInfoDict;         // 2. 订单信息
@property (nonatomic, retain) NSDictionary * ContractInfo;          // 3. 合约信息（裸终端类型订单无需此字段）
@property (nonatomic, retain) NSDictionary * PackageInfoDict;       // 4. 套餐信息（裸终端类型订单无需此字段）
@property (nonatomic, retain) NSDictionary * CustomerInfo;          // 5. 用户入网信息（裸终端类型订单无需此字段）

@property (nonatomic, assign) BOOL           isModifyAddrinfo;      // 购买流程中修改收货信息
@property (nonatomic, retain) NSDictionary * addrInfo;              // 原始收货信息

//add by liuruxian
@property (nonatomic, strong) NSMutableArray *areaList;
@property (nonatomic, strong) UIActivityIndicatorView * activityviewInfo ;
@property (nonatomic, strong) UIPickerView *      areaPicker;
@property (nonatomic, strong) UIScrollView *      contentScroll;
@property (nonatomic, strong) UIButton *          saveBtn;





@end
