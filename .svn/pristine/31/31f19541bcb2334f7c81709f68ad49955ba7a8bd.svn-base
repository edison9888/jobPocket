//
//  CTPNumberPickerVCtler.h
//  CTPocketv3
//
//  Created by apple on 13-5-13.
//
//

/*
 天翼靓号
 */

#import "CTBaseViewController.h"
#import "EGORefreshTableHeaderView.h"

@interface CTPNumberPickerVCtler : CTBaseViewController
{
    UIImageView *   _greyBgView;
    UIScrollView *  _contentScroll;
    UIButton *      _provinceBtn;
    UIButton *      _cityBtn;
    UIPickerView *  _areaPicker;
    UINavigationBar *   _textfieldNaviBar;
    UIButton *      _numTypeBtn;
    UIButton *      _feeTypeBtn;
    UITextField *   _tailNumTf;
    UIButton *      _searchBtn;
    UITableView *   _numberListTable;
    UIButton *      _buyBtn;
    EGORefreshTableHeaderView * _footRefreshView;
    UIActivityIndicatorView * _activityviewInfoSearch;
    UIActivityIndicatorView * _activityviewInfoBuy;
    
    UIView *        _bottomView;
    UIButton *      _moneyBtn100;
    UIButton *      _moneyBtn50;
    UILabel *       _totalPayFeeLab;
    
    UIView *        _clickView;
    
    NSMutableDictionary *_netCitys;
    NSMutableArray *    _areaList;
    
    int             _selectedProvinceIdx;
    int             _selectedCityIdx;
    int             _selectedNumtypeIdx;
    int             _selectedFeetypeIdx;
    NSArray *       _numTypeArr;
    NSArray *       _feeTypeArr;
    
    int                 _TotalCount;
    int                 _pageNum;
    int                 _PageSize;
    BOOL                _isLoading;
    NSMutableArray *    _numberList;
    int                 _selectedRow;
    
    BOOL                _hasSetNumAttr;
}

@property (nonatomic, assign) BOOL  bIsprettyNumber;    // 是否是天翼靓号选择

@property (nonatomic, retain) NSDictionary * SalesproductInfoDict;  // 1. 销售品信息
@property (nonatomic, retain) NSDictionary * ContractInfo;          // 2. 合约信息（裸终端类型订单无需此字段）
@property (nonatomic, retain) NSDictionary * PackageInfoDict;       // 3. 套餐信息（裸终端类型订单无需此字段）
@property (nonatomic, retain) NSArray *      OptPackageList;       // 4. 可选包列表信息（裸终端类型订单无需此字段）

//add by liuruxian 2014-03-01
@property (nonatomic, strong) NSMutableDictionary *netCitys;
@property (nonatomic, strong) NSMutableArray      *areaList;
@property (nonatomic, strong) NSMutableArray      *numberList;
@property (nonatomic, strong) NSArray             *numTypeArr;
@property (nonatomic, strong) NSArray             *feeTypeArr;

@property (nonatomic, assign) int selectedProvinceIdx;
@property (nonatomic, assign) int selectedCityIdx;
@property (nonatomic, assign) int selectedFeetypeIdx;
@property (nonatomic, assign) int selectedNumtypeIdx;


@property (nonatomic, assign) int  TotalCount;
@property (nonatomic, assign) int  PageSize;
@property (nonatomic, assign) int  pageNum;
@property (nonatomic, assign) BOOL isLoading;
@property (nonatomic, assign) int  selectedRow;
@property (nonatomic, assign) BOOL hasSetNumAttr;

@property (nonatomic, strong)  UIButton * cityBtn;
@property (nonatomic, strong)  UIButton * provinceBtn;


@property (nonatomic, strong) UIButton * searchBtn;
@property (nonatomic, strong) UITableView * numberListTable;
@property (nonatomic, strong) UIButton * buyBtn;
@property (nonatomic, strong) EGORefreshTableHeaderView * footRefreshView;
@property (nonatomic, strong) UIActivityIndicatorView * activityviewInfoSearch;
@property (nonatomic, strong) UIActivityIndicatorView * activityviewInfoBuy;
@property (nonatomic, strong) UIView *        bottomView;

@end
