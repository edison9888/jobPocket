//
//  CTNumberSelectedVCtler.m
//  CTPocketV4
//
//  Created by Mac-Eshore-01 on 14-3-24.
//  Copyright (c) 2014年 广东亿迅科技有限公司. All rights reserved.
//

#import "CTNumberSelectedVCtler.h"
#import "UIView+RoundRect.h"
#import "CTHelperMap.h"
#import "CTCity.h"
#import "AppDelegate.h"
#import "CserviceOperation.h"
#import "SVProgressHUD.h"
#import "SIAlertView.h"
#import "CTLoadingCell.h"
#import "CTHelperMap.h"
#import "CTNumberSelectedCell.h"
#import "CTCitySelectedVCtler.h"
#import "CTShakeNumberVCtler.h"
#import "COrderWildProductFillVctrler.h"
#import "CTContractOrderConfirmVCtler.h"
#import "CTContractProductDetailVCtler.h"
#import "CTSelectPhoneVCtler.h"


NSString *const CTNumberSelectedNotification = @"selectedNumberNotification";

@interface CTNumberSelectedVCtler () <UITableViewDataSource,UITableViewDelegate
                                     ,UITextFieldDelegate,UIPickerViewDataSource ,UIPickerViewDelegate>

@property (nonatomic, strong) UIView *cityView;
@property (nonatomic, strong) UITextField *searchTextField;
@property (nonatomic, strong) UIButton *cityButton;
@property (nonatomic, strong) UIView *selectedView;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UITableView *numberTypeTableView;
@property (nonatomic, strong) UIView *headerView;
@property (nonatomic, strong) UIView *footView;
@property (nonatomic, strong) UIView *nSelNumView;
@property (nonatomic, strong) UIButton *coverButton;
@property (nonatomic, strong) UILabel *luckyNumLabel;
@property (nonatomic, strong) NSString *searchText;
@property (nonatomic, strong) UILabel *numAttributionLabel;
@property (nonatomic, strong) UILabel *phoneNumLabel;
@property (nonatomic, strong) UILabel *phoneNumInfoLabel;
@property (nonatomic, strong) UIButton *tipBtn;
@property (nonatomic, strong) UIView *pickerView;
@property (nonatomic, strong) UIPickerView *areaPicker;

@property (nonatomic, assign) tableViewType tabType;
@property (nonatomic, assign) numberType numberType ;

@property (nonatomic, assign) BOOL isClear;
@property (nonatomic, strong) CserviceOperation *qryNumByCnlOpt;

@property (nonatomic, assign) int pageIndex;
@property (nonatomic, assign) int pageSize;
@property (nonatomic, assign) int searchPageIndex;
@property (nonatomic, assign) int searchPageSize;

@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) NSMutableArray *searchArray;
@property (nonatomic, strong) NSMutableArray *numberTypeArray;
@property (nonatomic, strong) NSMutableArray *saveMoneyArray;

@property (nonatomic, strong) NSMutableArray *numberArray;
@property (nonatomic, strong) NSMutableArray *moneyArray;

@property (nonatomic, assign) BOOL isFinished;
@property (nonatomic, assign) BOOL isLoading;

@property (nonatomic, assign) BOOL isSearchFinished;
@property (nonatomic, assign) BOOL isSearchLoading;
@property (nonatomic, strong) CTCity *locateData;

//条件查询号码
@property (nonatomic, strong) NSString *MinPay;
@property (nonatomic, strong) NSString *MaxPay;

@property (nonatomic, strong) NSString *Headnumber ;// 号码三位开头数字
@property (nonatomic, strong) NSString *ContNumber; // 搜索
@property (nonatomic, strong) NSString *InNumber;
@property (nonatomic, strong) NSString *IsLast;
@property (nonatomic, strong) NSString *InFlag;

// pickerview 当前选中的位置
@property (nonatomic, assign) int moneyIndex;
@property (nonatomic, assign) int numberIndex;

@property (nonatomic, strong) UIView *arrowView;
@property (nonatomic, strong) UIView *tipView;

@end

@implementation CTNumberSelectedVCtler

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        //城市切换消息
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(selectedCityNotification:)
                                                     name:SELECTCITY_MSG object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(createPage)
                                                     name: CTNumberSelectedNotification object:Nil];
        _tabType = 0;    // 0 正常 1 搜索
        _numberType = 0; // 0 选择号码段  1 预存话费区间
        _moneyIndex = 0;
        _numberIndex = 0;
        _pageIndex = 1;
        _MaxPay = @"";
        _MinPay = @"";
        
        _Headnumber = @"";
        _InFlag = @"";
        _InNumber = @"";
        _IsLast = @"";
        _ContNumber = @"";
        _isCreate = NO;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    //定位信息
    if (!_isCreate) {
        self.locateData = [CTHelperMap shareHelperMap].areaInfo;
        [self qryNumByCnl:@""];
    }
    
    self.title = @"选择号码";
    self.view.backgroundColor = [UIColor whiteColor];
    [self setLeftButton:[UIImage imageNamed:@"btn_back.png"]];
    [self headerView];
    [self tableView];
    [self footView];
    [self coverButton];
    [self arrowView];
    [self tipView];
  
   
    [_tableView reloadData];
}

- (UIView *)tipView
{
    if (!_tipView) {
        UIView *tipView = [[UIView alloc] initWithFrame:CGRectMake(5, self.tableView.frame.origin.y,
                                                                   CGRectGetWidth(self.view.frame)-10, 40)];
        tipView.backgroundColor = [UIColor whiteColor];
        tipView.hidden = YES;
        [self.view addSubview:tipView];
        {
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 300, 40)];
            label.textAlignment = UITextAlignmentCenter ;
            label.backgroundColor = [UIColor clearColor];
            label.text = @"亲，没有更多可选号码啦~";
            label.textColor = [UIColor blackColor];
            label.font = [UIFont systemFontOfSize:14];
            [tipView addSubview:label];
            
            UIImageView *dividingImg = [[UIImageView alloc]initWithFrame:CGRectMake(3, CGRectGetMaxY(label.frame),CGRectGetWidth(tipView.frame)-6,1)];
            dividingImg.backgroundColor = [UIColor colorWithRed:220/255. green:220/255. blue:220/255. alpha:1];
            [tipView addSubview:dividingImg];
            _tipView = tipView;
        }
    }
    
    return _tipView;
}

- (UIView *)arrowView
{
    if (!_arrowView) {
        UIImage *image = [UIImage imageNamed:@"arrow_down"];
        _arrowView = [[UIView alloc] initWithFrame:CGRectMake(0,
                                                              (CGRectGetHeight(self.view.bounds))/2-50,
                                                              image.size.width, image.size.height)];
        
        _arrowView.hidden = YES ;
        _arrowView.autoresizingMask = UIViewAutoresizingFlexibleHeight ;
        UIImageView *upImageView = [[UIImageView alloc] initWithFrame:_arrowView.bounds];
        upImageView.Image = image ;
        [_arrowView addSubview:upImageView];
        [self.view addSubview:_arrowView];
        [self.view bringSubviewToFront:_arrowView];
    }
    
    return _arrowView ;
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
}

- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
}
- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    if (self.qryNumByCnlOpt) {
        [self.qryNumByCnlOpt cancel];
        self.qryNumByCnlOpt = nil;
    }
    if ([_pickerView isDescendantOfView:MyAppDelegate.window]) {
        [_pickerView removeFromSuperview];
        _pickerView = nil;
    }
    [_coverButton removeFromSuperview];
    _coverButton = nil;
    self.searchTextField = nil;
}

#pragma mark - data

- (NSMutableArray *)numberTypeArray
{
    if (!_numberTypeArray) {
        _numberTypeArray = [NSMutableArray arrayWithObjects:
                            @"全部",@"189",
                            @"133",@"177",
                            @"1700",@"尾号无4号码",
                            @"尾号含8",@"尾号含6",nil];
    }
    return _numberTypeArray;
}

- (NSMutableArray *)saveMoneyArray
{
    if (!_saveMoneyArray) {
        _saveMoneyArray = [NSMutableArray arrayWithObjects:
                           @"全部",
                           @"0元预存",
                           @"1-300元",
                           @"301-600元",
                           @"601-1000元",
                           @"1001-2000元",
                           @"2001-3000元",
                           @"3000元以上",nil];
    }
    
    return _saveMoneyArray;
}


- (NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    
    return _dataArray;
}

- (NSMutableArray *)searchArray
{
    if (!_searchArray) {
        _searchArray = [NSMutableArray array];
    }
    
    return _searchArray ;
}

#pragma mark - control

- (UIView *)pickerView
{
    if (!_pickerView) {
        _pickerView = [[UIView alloc] init];
        
        UIPickerView * picker = [[UIPickerView alloc] init];
        picker.dataSource     = (id<UIPickerViewDataSource>)self;
        picker.delegate       = (id<UIPickerViewDelegate>)self;
        [picker setBackgroundColor:[UIColor whiteColor]];
        picker.showsSelectionIndicator = YES;
        _areaPicker           = picker;
        
        _pickerView.frame = CGRectMake(0,
                                       CGRectGetHeight(MyAppDelegate.window.frame),
                                       CGRectGetWidth(_areaPicker.frame),
                                       CGRectGetHeight(_areaPicker.frame)+40);
        _pickerView.backgroundColor = [UIColor clearColor];
        [MyAppDelegate.window addSubview:_pickerView];
        
        _areaPicker.frame = CGRectMake(0, 40,
                                       CGRectGetWidth(_areaPicker.frame),
                                       CGRectGetHeight(_areaPicker.frame));
        
        [_pickerView addSubview:_areaPicker];
        
        //状态栏
        {
            UIView *statusView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, _pickerView.frame.size.width, 40)];
            statusView.backgroundColor = [UIColor colorWithRed:(9*16+7)/255. green:(9*16+7)/255. blue:(9*16+7)/255. alpha:1];
            [_pickerView addSubview:statusView];
            
            UIButton *cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
            [cancelBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            cancelBtn.titleLabel.font = [UIFont systemFontOfSize:18];
            cancelBtn.frame = CGRectMake(0, 0, 80, 40);
            [cancelBtn addTarget:self action:@selector(cancelAction) forControlEvents:UIControlEventTouchUpInside];
            [statusView addSubview:cancelBtn] ;
            
            UIButton *okBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            [okBtn setTitle:@"完成" forState:UIControlStateNormal];
            [okBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            okBtn.titleLabel.font = [UIFont systemFontOfSize:18];
            okBtn.frame = CGRectMake(320-80, 0, 80, 40);
            [okBtn addTarget:self action:@selector(doneAction) forControlEvents:UIControlEventTouchUpInside];
            [statusView addSubview:okBtn] ;
        }
    }

    return _pickerView;
}

- (UIButton *)coverButton
{
    //查询时使用得覆盖button
    if (!_coverButton) {
        UIButton *coverBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        coverBtn.backgroundColor = [UIColor clearColor];
        coverBtn.autoresizingMask = UIViewAutoresizingFlexibleHeight ;
        coverBtn.hidden = YES;
        
        coverBtn.frame = CGRectMake(0, 165,
                                    self.view.frame.size.width,
                                    self.view.frame.size.height - CGRectGetMaxY(self.cityView.frame));
        [coverBtn addTarget:self action:@selector(cancelkeyBoard) forControlEvents:UIControlEventTouchUpInside];
        [MyAppDelegate.window addSubview:coverBtn];
        [MyAppDelegate.window bringSubviewToFront:coverBtn];
        _coverButton = coverBtn;
    }
    return _coverButton;
}

- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(2,
                                                                   99,
                                                                   CGRectGetWidth(self.view.frame)-4,
                                                                   CGRectGetHeight(self.view.frame)-96-99)];//
        _tableView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth  ;
        _tableView.backgroundColor = [UIColor whiteColor];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone ;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [self.view addSubview:_tableView];
    }
    
    return _tableView ;
}

- (UIView *)headerView
{
    if (!_headerView) {
        _headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), 56+43)];
        _headerView.backgroundColor = [UIColor clearColor];
        _headerView.autoresizingMask = UIViewAutoresizingFlexibleWidth ;
        [self.view addSubview:_headerView];
        [_headerView addSubview:self.cityView];
        [self selectedView];
    }
    return _headerView ;
}

- (UIView *)cityView{
    if (!_cityView) {
        UIView *cityView = [[UIView alloc]initWithFrame:
                            CGRectMake(self.view.bounds.origin.x,
                                       1,
                                       CGRectGetWidth(self.view.frame),
                                       56)];
        cityView.backgroundColor = [UIColor colorWithRed:239/255.
                                                   green:239/255.
                                                    blue:239/255. alpha:1];
        _cityView = cityView;
        
        {
            //地址按钮
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            NSString *cityName = [NSString stringWithFormat:@"%@",self.locateData.cityname];
            if ([cityName hasSuffix:@"市"]) {
                cityName = [cityName substringToIndex:cityName.length-1];
            }
            [button setTitle:cityName forState:UIControlStateNormal];
            [button setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 15)];
            [button setBackgroundImage:[UIImage imageNamed:@"prettyNum_citybg_button.png"] forState:UIControlStateNormal];
            [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            button.titleLabel.font = [UIFont systemFontOfSize:14];
            button.frame = CGRectMake(6, (CGRectGetHeight(cityView.frame)-38)/2, 95, 38);
            [button addTarget:self action:@selector(citySelectedAction) forControlEvents:UIControlEventTouchUpInside];
            [self.cityView addSubview:button];
            self.cityButton = button;
            {
                UIImage *image = [UIImage imageNamed:@"prettyNum_arrow_icon.png"];
                UIImageView *imageView = [[UIImageView alloc]initWithFrame:
                                          CGRectMake(95-20,
                                                     (CGRectGetHeight(button.frame)-image.size.height)/2,
                                                     image.size.width,
                                                     image.size.height)];
                imageView.image = image ;
                [button addSubview:imageView];
            }
            
            UIImage *cancelImage = [UIImage imageNamed:@"prettyNum_citybg_button.png"];
            UIButton *searchBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            
            [searchBtn setBackgroundImage:cancelImage forState:UIControlStateNormal];
            [searchBtn addTarget:self
                          action:@selector(searchAction) forControlEvents:UIControlEventTouchUpInside];
            [searchBtn setTitle:@"搜索" forState:UIControlStateNormal];
            searchBtn.titleLabel.font = [UIFont systemFontOfSize:14];
            [searchBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            searchBtn.frame = CGRectMake(CGRectGetMaxX(button.frame) +10 + 200 - 48,
                                         (CGRectGetHeight(cityView.frame)-38)/2,
                                         45,
                                         38);
            [self.cityView addSubview:searchBtn];
            
            UIImage *image = [UIImage imageNamed:@"prettyNum_searchBar_bg.png"];
            CGRect rect = CGRectMake(CGRectGetMaxX(button.frame)+10,
                                     (CGRectGetHeight(cityView.frame)-38)/2,
                                     200,
                                     38);
            UITextField *textField = [[UITextField alloc] initWithFrame:rect];
            textField.delegate = self;
            textField.backgroundColor = [UIColor clearColor];
            textField.borderStyle = UITextBorderStyleNone;
            textField.background = image ;
            textField.textColor = [UIColor blackColor];
            textField.font = [UIFont systemFontOfSize:14];
            textField.clearButtonMode = UITextFieldViewModeNever;
            textField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
            textField.keyboardType = UIKeyboardTypeDecimalPad;
            textField.returnKeyType = UIReturnKeySearch;
            textField.enablesReturnKeyAutomatically = YES;
            textField.autocorrectionType = UITextAutocorrectionTypeNo;
            textField.autocapitalizationType = UITextAutocapitalizationTypeNone;
            [textField dwMakeRoundCornerWithRadius:5];
            
            {
                image = [UIImage imageNamed:@"SearchIcon.png"];
                UIView *view = [[UIView alloc] initWithFrame:
                                CGRectMake(0, 0, image.size.width + 12, textField.frame.size.height)];
                view.backgroundColor = [UIColor clearColor];
                UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
                imageView.backgroundColor = [UIColor clearColor];
                CGRect rect = imageView.frame;
                rect.origin.x = 8;
                rect.origin.y = ceilf((view.frame.size.height - rect.size.height) / 2);
                imageView.frame = rect;
                
                [view addSubview:imageView];
                
                textField.leftView = view;
                textField.leftViewMode = UITextFieldViewModeAlways;
            }
            
            {
                image = [UIImage imageNamed:@"prettyNum_cancel_icon.png"];
                
                UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
                button.backgroundColor = [UIColor clearColor];
                [button setImage:image forState:UIControlStateNormal];
                [button addTarget:self action:@selector(cancelSearchAction) forControlEvents:UIControlEventTouchUpInside];
                button.frame = CGRectMake(0, 0, image.size.width + 12, textField.frame.size.height);
                CGRect rect = button.frame;
                rect.origin.x = 8;
                rect.origin.y = ceilf((button.frame.size.height - rect.size.height) / 2);
                button.frame = rect;
                textField.rightView = button;
                
                textField.rightViewMode = UITextFieldViewModeAlways;
            }
            
            textField.placeholder = @"  自选尾号 (2-4位)";
            [self.cityView addSubview:textField];
            
            self.searchTextField = textField;
        }
    }
    return _cityView ;
}

- (UIView *)selectedView
{
    if (!_selectedView) {
        _selectedView = [[UIView alloc] initWithFrame:CGRectMake(0, 56, CGRectGetWidth(self.view.frame), 43)];
        _selectedView.backgroundColor = [UIColor clearColor];
        [_headerView addSubview:_selectedView];
        // 选择按钮
        {
            NSArray *titleAry = [NSArray arrayWithObjects:@"全部",@"全部", nil];
            float xPos = 0;
            for (int i=0; i<2; i++) {
                UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
                [button setTitle:titleAry[i] forState:UIControlStateNormal];
                [button setBackgroundImage:[UIImage imageNamed:@"recharge_unselected_bg.png"] forState:UIControlStateNormal];
                button.tag = 100+i;
                button.titleLabel.font = [UIFont systemFontOfSize:14];
                [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
                [button addTarget:self action:@selector(numberTypeAction:) forControlEvents:UIControlEventTouchUpInside];
                button.frame = CGRectMake(xPos, 0, CGRectGetWidth(_selectedView.frame)/2, CGRectGetHeight(_selectedView.frame));
                xPos = CGRectGetWidth(button.frame);
                [_selectedView addSubview:button];
                
                UIImage *image = [UIImage imageNamed:@"prettyNum_arrow_icon.png"];
                UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetWidth(button.frame)-14-image.size.width, (CGRectGetHeight(button.frame)-image.size.height)/2, image.size.width, image.size.height)];
                imageView.image = image;
                imageView.userInteractionEnabled = YES;
                [button addSubview:imageView];
            }
        }
    }
    
    return _selectedView;
}

- (UIView *)footView
{
    if (!_footView) {
        _footView = [[UIView alloc] initWithFrame:CGRectMake(0,
                                                             CGRectGetMaxY(_tableView.frame),
                                                             CGRectGetWidth(self.view.frame),
                                                             96)];
        _footView.backgroundColor = [UIColor clearColor];
        _footView.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleWidth ;
        [self.view addSubview:_footView];
        {
            UIImageView *bgImageView = [[UIImageView alloc] initWithFrame:_footView.bounds];
            bgImageView.backgroundColor = [UIColor colorWithRed:239/255. green:239/255. blue:239/255. alpha:1];
            [_footView addSubview:bgImageView];
            
            //感叹号
            UIButton *tipButton = [UIButton buttonWithType:UIButtonTypeCustom];
            tipButton.frame = CGRectMake(14, 14, 33, 33);
            tipButton.backgroundColor = [UIColor clearColor];
            [tipButton setImage:[UIImage imageNamed:@"WriteOrderInfo_icon1.png"] forState:UIControlStateNormal];
            [tipButton addTarget:self action:@selector(tipForComsumes) forControlEvents:UIControlEventTouchUpInside];
            [_footView addSubview:tipButton];
            self.tipBtn = tipButton;
            
            UIView *nselView = [[UIView alloc]initWithFrame:CGRectMake(0,
                                                                       0,
                                                                       CGRectGetWidth(_footView.frame)-60,
                                                                       52)];
            
            nselView.backgroundColor = [UIColor colorWithRed:239/255. green:239/255. blue:239/255. alpha:1];
            [_footView addSubview:nselView];
            self.nSelNumView = nselView ;
            {
                UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(90, (CGRectGetHeight(nselView.frame)-18)/2, 150,18)];
                label.text = @"请先选择一个号码";
                label.textColor = [UIColor blackColor];
                label.font = [UIFont systemFontOfSize:18];
                label.backgroundColor = [UIColor clearColor];
                [nselView addSubview:label];
            }
            
            UILabel *numAttributionLab = [[UILabel alloc]initWithFrame:
                                          CGRectMake(50,
                                                     11,
                                                     80,
                                                     14)];
            numAttributionLab.backgroundColor = [UIColor clearColor];
            numAttributionLab.font = [UIFont systemFontOfSize:14];
            numAttributionLab.text = @"";
            numAttributionLab.textColor = [UIColor blackColor];
            self.numAttributionLabel = numAttributionLab;
            [_footView addSubview:numAttributionLab];
            
            UILabel *numLab = [[UILabel alloc]initWithFrame:
                               CGRectMake(134,
                                          9,
                                          170,
                                          16)];
            numLab.backgroundColor = [UIColor clearColor];
            numLab.textColor = [UIColor blackColor];
            numLab.text = @"";
            numLab.font = [UIFont boldSystemFontOfSize:18];
            [_footView addSubview:numLab];
            self.phoneNumLabel = numLab ;
            
            UILabel *prettyNumInfoLab = [[UILabel alloc]initWithFrame:
                                         CGRectMake(50,
                                                    18+13,
                                                    200,
                                                    14)];
            prettyNumInfoLab.backgroundColor = [UIColor clearColor];
            prettyNumInfoLab.text = @"";
            prettyNumInfoLab.textAlignment = UITextAlignmentCenter ;
            prettyNumInfoLab.font = [UIFont systemFontOfSize:14];
            prettyNumInfoLab.textColor = [UIColor blackColor];
            [_footView addSubview:prettyNumInfoLab];
            self.phoneNumInfoLabel = prettyNumInfoLab ;
            
            //摇一摇按钮
            UIImage *shakeImage = [UIImage imageNamed:@"prettyNum_shake_btn.png"];
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            button.frame = CGRectMake(CGRectGetMaxX(_footView.frame)-shakeImage.size.width, 6, shakeImage.size.width, shakeImage.size.height);
            [button setBackgroundImage:shakeImage forState:UIControlStateNormal];
            [button addTarget:self action:@selector(shakeAction) forControlEvents:UIControlEventTouchUpInside];
//            [_footView addSubview:button];
            
            UIButton *choosepackageBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            [choosepackageBtn setTitle:@"确定" forState:UIControlStateNormal];
            [choosepackageBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            choosepackageBtn.titleLabel.font = [UIFont systemFontOfSize:16];
            [choosepackageBtn setBackgroundImage:[UIImage imageNamed:@"recharge_commit_btn.png"] forState:UIControlStateNormal];
            [choosepackageBtn setBackgroundImage:[UIImage imageNamed:@"recharge_commit_btn_hl.png"] forState:UIControlStateHighlighted];
            choosepackageBtn.frame = CGRectMake(21, CGRectGetMaxY(prettyNumInfoLab.frame)+8, CGRectGetWidth(self.view.frame)-42, 38);
            [choosepackageBtn addTarget:self action:@selector(choosePackageAction) forControlEvents:UIControlEventTouchUpInside];
            [_footView addSubview:choosepackageBtn];
        }
        
        [self.nSelNumView bringSubviewToFront:_footView];
    }
    
    return _footView ;
}

#pragma mark - netWork

- (void)qryNumByCnl : (NSString *) searchText
{
    if (self.qryNumByCnlOpt) {
        [self.qryNumByCnlOpt cancel];
        self.qryNumByCnlOpt = nil;
    }
    
    NSString *ProvinceCode = self.locateData.provincecode;
    NSString *AreaCode = self.locateData.citycode;
    NSString *ShopId = ESHORE_ShopId;
    NSString *SalesproductId = self.SalesproductId;//销售品id//@"00000000F477F2D877C241B4E043433210AC91FE";
    NSString *PageIndex = [NSString stringWithFormat:@"%d",self.pageIndex];
    NSString *PageSize = @"20";
    NSString *Level = @"";
    NSString *PrettyPattern = @"";
    
    //筛选使用
    NSString *ContNumber = self.ContNumber?self.ContNumber:@""; // 号段选择
    NSString *MinPay = self.MinPay?self.MinPay:@"";         //     预存款区间
    NSString *MaxPay = self.MaxPay?self.MaxPay:@"";
    NSString *HeadNumber = self.Headnumber?self.Headnumber:@""; // 选择号段
    NSString *InFlag = self.InFlag;
    
    //搜索使用
    NSString *IsLast = self.IsLast;
    NSString *InNumber = self.InNumber;
    
    if (self.tabType == tabSearch) {
        IsLast = @"1";
        self.ContNumber = searchText;
        ContNumber = searchText;
        PageIndex = [NSString stringWithFormat:@"%d",self.searchPageIndex];
        PageSize = [NSString stringWithFormat:@"%d",self.searchPageSize];
    }
    else{
        
    }

    NSDictionary * params   = [NSDictionary dictionaryWithObjectsAndKeys:ProvinceCode,@"ProvinceCode",
                               AreaCode,@"AreaCode",
                               ShopId,@"ShopId",
                               SalesproductId,@"SalesproductId",
                               PageIndex,@"PageIndex",
                               PageSize,@"PageSize",
                               HeadNumber,@"Headnumber",
                               ContNumber,@"ContNumber",
                               Level,@"Level",
                               MinPay,@"MinPay",
                               MaxPay,@"MaxPay",
                               PrettyPattern,@"PrettyPattern",
                               InFlag,@"InFlag",
                               IsLast,@"IsLast",
                               InNumber,@"InNumber",
                               nil];
    
    __weak typeof(self) wself = self;
    self.qryNumByCnlOpt =[MyAppDelegate.cserviceEngine
                          postXMLWithCode:@"qryPhoneNumberBd"
                          params:params
                          onSucceeded:^(NSDictionary *dict) {
                              DDLogInfo(@"%s--%@", __func__, dict.description);
                              [wself onQryNumByCnlSuccess:dict];
                          } onError:^(NSError *engineError) {
                              DDLogInfo(@"%s--%@", __func__, engineError);
                              [wself onQryNumByCnlError:engineError];
                              [SVProgressHUD dismiss];
                          }];
}

- (void)onQryNumByCnlSuccess:(NSDictionary *)dict
{
    id Data = [dict objectForKey:@"Data"];
    //获取信息失败
    id Items = [Data objectForKey:@"Items"];
    id Item = [Items objectForKey:@"Item"];
    NSArray *array;
    if (Item && [Item isKindOfClass:[NSArray class]]) {
        array = [NSArray arrayWithArray:Item];
    } else if(Item && [Item isKindOfClass:[NSDictionary class]]){
        array = [NSArray arrayWithObjects:Item, nil];
    }
    
    if (self.tabType == tabNormal) {
        if (array.count<20) {
            self.isFinished = YES ;
        }else{
            self.pageIndex ++;
            self.isFinished = NO ;
        }
        for (int i=0; i<array.count; i++) {
             CTPrettyNumData *data = [CTPrettyNumData modelObjectWithDictionary:array[i]];
            [self.dataArray addObject:data];
        }
        
        self.isLoading = NO ;
        
        if (self.dataArray.count>0) {
            self.arrowView.hidden = YES;
        } else{
            self.tipView.hidden = NO ;
        }
    }
    else {
        if (array.count<20) {
            self.isSearchFinished = YES ;
        }else{
            self.searchPageIndex ++;
            self.isSearchFinished = NO ;
        }
        for (int i=0; i<array.count; i++) {
            CTPrettyNumData *data = [CTPrettyNumData modelObjectWithDictionary:array[i]];
            [self.searchArray addObject:data];
        }
        
        self.isSearchLoading = NO ;
        
        if (self.searchArray.count>0) {
            self.arrowView.hidden = YES;
        } else{
            self.tipView.hidden = NO ;
        }
    }
    
    [self.tableView reloadData];
}

- (void)onQryNumByCnlError:(NSError *)engineError
{
    [SVProgressHUD dismiss];
    
    __weak __typeof(&*self)weakSelf = self;
    double delayInSeconds = 1.0;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        
        if (weakSelf.tabType == tabNormal) {
            weakSelf.isLoading = NO;
        } else{
            weakSelf.isSearchLoading = NO ;
        }
        
        if (self.pageIndex == 1) {
            self.tipView.hidden = YES ;
        }
        [weakSelf.tableView reloadData];
        
    });
    
    if ([engineError.userInfo objectForKey:@"ResultCode"])
    {
        if ([engineError.userInfo[@"ResultCode"] isEqualToString:@"X104"])
        {
            // 取消掉全部请求和回调，避免出现多个弹框
            [MyAppDelegate.cserviceEngine cancelAllOperations];
            // 提示重新登录
            SIAlertView *alertView = [[SIAlertView alloc] initWithTitle:nil
                                                             andMessage:@"长时间未登录，请重新登录。"];
            [alertView addButtonWithTitle:@"确定"
                                     type:SIAlertViewButtonTypeDefault
                                  handler:^(SIAlertView *alertView) {
                                      [MyAppDelegate showReloginVC];
                                      if (self.navigationController != nil)
                                      {
                                          [self.navigationController popViewControllerAnimated:NO];
                                      }
                                  }];
            alertView.transitionStyle = SIAlertViewTransitionStyleBounce;
            [alertView show];
        }
    }
    else{
    }
}

#pragma mark - fun

- (void)setBtnTitle
{
    if (self.numberType == number) {
        UIButton *btn = (UIButton *)[self.selectedView viewWithTag:100];
        [btn setTitle:_numberTypeArray[_numberIndex] forState:UIControlStateNormal];
    }
    else{
        UIButton *btn = (UIButton *)[self.selectedView viewWithTag:101];
        [btn setTitle:_saveMoneyArray[_moneyIndex] forState:UIControlStateNormal];
    }
}

- (void)getSeachCondition
{
    // 预存区
    if (self.moneyIndex == 0) {
        self.MaxPay = @"";
        self.MinPay = @"";
    }else if(self.moneyIndex == 1)
    {
        self.MaxPay = @"0";
        self.MinPay = @"0";
    }
    else if(self.moneyIndex<5){
        NSArray *array = [self.saveMoneyArray[_moneyIndex] componentsSeparatedByString:@"-"];
        self.MinPay = array[0];
        NSString *max = array[1];
        self.MaxPay = [max substringToIndex:max.length-1];
    } else {
        self.MinPay = @"3000";
        self.MaxPay = @"";
    }
    
    // 号段
    if(self.numberIndex==0)
    {
        self.InFlag = @"";
        self.Headnumber = @"";
//        self.ContNumber = @"";
        self.IsLast = @"";
        self.InNumber = @"";
    } else if(self.numberIndex<5)
    {
        self.InFlag = @"";
        self.IsLast = @"1";
        self.InFlag = @"";
        self.Headnumber = self.numberTypeArray[_numberIndex];
//        self.ContNumber = @"";
    } else
    {
        switch (self.numberIndex) {
            case 5:  // 无4
                self.InFlag = @"0";
                self.InNumber = @"4";
                
                self.Headnumber = @"";
//                self.ContNumber = @"";
                self.IsLast = @"";
                break;
            case 6:  // 含8
                self.InFlag = @"1";
                self.InNumber = @"8";
                
//                self.ContNumber = @"";
                self.IsLast = @"";
                self.Headnumber = @"";
                
                break;
            case 7:  // 含6
                
                self.InFlag = @"1";
                self.InNumber = @"6";
                
//                self.ContNumber = @"";
                self.IsLast = @"";
                self.Headnumber = @"";
                
                break;
        }
    }
}

- (void)cancelSearch
{
    /*  
         改变之前靓号的逻辑。由于条件的存在，搜索改变条件后，导致切换回未搜索时的数据则要重新请求数据。
    */
    
    if (self.tabType == tabSearch)
    {
        self.isLoading = NO;
        self.isFinished = NO;
        self.pageSize = 20;
        self.pageIndex = 1;
        
        self.isSearchFinished = NO;
        self.isSearchLoading = NO;
        self.searchPageSize = 20;
        self.searchPageIndex = 1;
     
        
        [self.dataArray removeAllObjects];
        [self.searchArray removeAllObjects];
        
        self.tipView.hidden = YES ;
        self.isLoading = YES;
        self.ContNumber = @"";
        self.IsLast = @"";
        [self qryNumByCnl:@""]; //调用一次数据接口,避免没有数据情况
    }
}

- (void) showSelectedInfo
{
    if (!self.selectedData) {
        self.phoneNumLabel.text = @"";
        self.phoneNumInfoLabel.text = @"";
        self.numAttributionLabel.text = @"";
        //显示view
        
        return ;
    }
    self.nSelNumView.hidden = YES ;
    
    self.luckyNumLabel.text = @"已选号码";
    
    NSString *cityName = [NSString stringWithFormat:@"%@",self.selectedData.City];
    if ([cityName hasSuffix:@"市"]) {
        cityName = [cityName substringToIndex:cityName.length-1];
    }
    self.numAttributionLabel.text = [NSString stringWithFormat:@"%@ %@",self.selectedData.Province,cityName];
    
    NSMutableString *phoneNum =  [NSMutableString stringWithString:self.selectedData.PhoneNumber] ;
    [phoneNum stringByReplacingOccurrencesOfString:@" " withString:@""];
    [phoneNum insertString:@" " atIndex:3];
    [phoneNum insertString:@" " atIndex:8];
    self.phoneNumLabel.text = phoneNum;
    
    NSString *pay = [NSString stringWithFormat:@"%0.f",[self.selectedData.PrepayMent floatValue]];
    NSString *consume = [NSString stringWithFormat:@"%0.f",[self.selectedData.MinAmount floatValue]];
    self.phoneNumInfoLabel.text = [NSString stringWithFormat:@"预存%@元 月最低消费%@元",pay,consume];
    
    if ([pay floatValue] > 0.0) {
        self.tipBtn.hidden = NO;
    } else {
        self.tipBtn.hidden = YES;
    }

}

- (void)loadMore
{
    if (self.tabType == tabNormal) {
        if (self.isFinished) {
            return;
        }
        
        if (!self.isLoading) {
            self.isLoading = YES ;
            [self qryNumByCnl:@""];
        }
    }else{
        if (self.isSearchFinished) {
            return;
        }
        
        if (!self.isSearchLoading) {
            self.isSearchLoading = YES ;
            [self qryNumByCnl:self.searchText];
        }
    }
}

- (void)showPicker
{
    if ([_pickerView isDescendantOfView:MyAppDelegate.window])
    {
        [UIView animateWithDuration:0.35 animations:^{
            self.pickerView.transform = CGAffineTransformMakeTranslation(0, -CGRectGetHeight(_pickerView.frame));
        } completion:^(BOOL finished) {
        }];
    }else{
        [self pickerView];
        [UIView animateWithDuration:0.35 animations:^{
            _pickerView.transform = CGAffineTransformMakeTranslation(0, -CGRectGetHeight(_pickerView.frame));
        } completion:^(BOOL finished) {
        }];
    }
}

-(void)hiddenPicker{
    AppDelegate * app = (AppDelegate *)[UIApplication sharedApplication].delegate;
    if (![_pickerView isDescendantOfView:app.window]){
        return;
    }
    
    MyAppDelegate.tabBarController.tabbarView.userInteractionEnabled = YES;
    [UIView animateWithDuration:0.35 animations:^{
        _pickerView.transform = CGAffineTransformIdentity ;
    } completion:^(BOOL finished) {

    }];
}

- (void)onLeftBtnAction:(id)sender{
    if ([_pickerView isDescendantOfView:MyAppDelegate.window]) {
        [_pickerView removeFromSuperview];
        _pickerView = nil;
    }
    
    [self.searchTextField resignFirstResponder];
    
    NSArray *vcAry = self.navigationController.viewControllers;
    for (UIViewController *vc in vcAry) {
        if ([vc isKindOfClass:[CTSelectPhoneVCtler class]]) {
            [self.navigationController popToViewController:vc animated:YES];
        }
    }
}

- (void) createCellInView : (CTPrettyNumData *)data
                     cell : (CTNumberSelectView *)view
                viewIndex : (int) viewIndex
{
    if (data == nil) {
        [view setPrettynumInfo:nil viewIndex:viewIndex selectBlock:nil];
        return;
    }
    
    __weak __typeof(&*self)weakSelf = self;
    [view setPrettynumInfo:data viewIndex:viewIndex  selectBlock:^(CTPrettyNumData *data){
        weakSelf.selectedData = data;
        [weakSelf showSelectedInfo];
    }];
    
    if (data == self.selectedData) {
        [view setSelected:YES];
    }else{
        [view setSelected:NO];
    }
}

#pragma mark - tableview delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.numberTypeTableView) {
        if (indexPath.row==0) {
            return 70;
        }
         return 40;
    }
    if (indexPath.section == 1) {
        return 45;
    }
    return 62;
}
//cell响应事件
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];//选中后的反显颜色即刻消失
}

#pragma mark - datasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == _numberTypeTableView) {
        if (_numberType == number) {
            return self.numberTypeArray.count;
        }
        return self.saveMoneyArray.count;
    }
    else{
        if (_tabType == tabNormal) {
            if (section==1) {
                if (self.isFinished) {
                    return 0;
                }else{
                    return 1;
                }
            }
            
            return (int)ceilf(self.dataArray.count / 2.0) ;
        }else{
            if (section==1) {
                if (self.isSearchFinished) {
                    return 0;
                }else{
                    return 1;
                }
            }
            
            return (int)ceilf(self.searchArray.count / 2.0) ;
        }
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (tableView == self.numberTypeTableView) {
        return 1;
    }
    if (self.tabType == tabNormal) {
        if (self.isFinished) {
            return 1;
        }
        return 2;
    }
    else{
        if (self.isSearchFinished) {
            return 1;
        }
        return 2;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==1) {
        static NSString *loadingCell = @"loadingCell";
        CTLoadingCell *cell = [tableView dequeueReusableCellWithIdentifier:loadingCell];
        if (cell == nil) {
            cell = [[CTLoadingCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:loadingCell];
            cell.selectionStyle = UITableViewCellSelectionStyleNone ;
            [cell setCellHeight:45];
        }
        if(self.tabType == tabNormal)
        {
            [cell setView:self.isLoading];
        } else {
            [cell setView:self.isSearchLoading];
        }
        return cell ;
        
    }
    else
    {
        if (self.tabType == tabNormal) {
            static NSString *CellIdentifier = @"TopCell";
            CTNumberSelectedCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
            if(cell == nil)
            {
                cell = [[CTNumberSelectedCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier ViewListCellType:topListCellType];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
            }
            int index = indexPath.row*2  ;
            if (index < self.dataArray.count) {
                CTPrettyNumData *data = [self.dataArray objectAtIndex:index];
                [self createCellInView:data cell:cell.leftView viewIndex:index];
            } else {
                [self createCellInView:nil cell:cell.leftView viewIndex:index] ;
            }
            
            index = indexPath.row*2+1;
            if (index<self.dataArray.count) {
                CTPrettyNumData *data = [self.dataArray objectAtIndex:index];
                [self createCellInView:data cell:cell.rightView viewIndex:index];
            } else {
                [self createCellInView:nil cell:cell.rightView viewIndex:index];
            }
            
            return cell;
        } else {
            static NSString *CellIdentifier = @"SearchCell";
            CTNumberSelectedCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
            if(cell == nil)
            {
                cell = [[CTNumberSelectedCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier ViewListCellType:topListCellType];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
            }
            
            int index = indexPath.row*2  ;
            if (index < self.searchArray.count) {
                CTPrettyNumData *data = [self.searchArray objectAtIndex:index];
                [self createCellInView:data cell:cell.leftView viewIndex:index];
            } else {
                [self createCellInView:nil cell:cell.leftView viewIndex:index] ;
            }
            
            index = indexPath.row*2+1;
            if (index<self.searchArray.count) {
                CTPrettyNumData *data = [self.searchArray objectAtIndex:index];
                [self createCellInView:data cell:cell.rightView viewIndex:index];
            } else {
                [self createCellInView:nil cell:cell.rightView viewIndex:index];
            }
            
            return cell ;
        }
    }
}

#pragma mark - Action

- (void) tipForComsumes
{
    /*
     如果能除净（商小数点后不大于2位），就按除净规则显示，如：
     预存话费 90 元，每月固定返还 3.75 元，激活后共返还 24 个月。
     
     如果不能除净，前23个月返还的金额是商取整数部分，第24个月返还剩下部分，如：
     预存话费 80 元，激活后共返还 24 个月，前 23 个月每月返还 3 元，第 24 个月返还 11 元。
     */
    
    NSString *message = @"";
    float pay = [self.selectedData.PrepayMent floatValue]/24.0 ;//;[self.selectedData.PrepayMent floatValue]/24;
    NSString *payStr = [NSString stringWithFormat:@"%0.3f",pay];
    NSString *lastStr = [payStr substringFromIndex:payStr.length-1];
    if ([lastStr integerValue]>0) {
        //不能整除
        int ret = floorf([self.selectedData.PrepayMent floatValue]/24.0) ; //向下取整
        message = [NSString stringWithFormat:@"预存话费%@元，激活后共返还24个月,前23个月每月返还%d元,第24个月返还%d元",self.selectedData.PrepayMent,ret,[self.selectedData.PrepayMent integerValue]-ret*23];
        
    } else {
        message = [NSString stringWithFormat:@"预存话费%@元,每月固定返还%0.2f元,激活后共返还24个月",self.selectedData.PrepayMent,pay];
    }
    
    
    SIAlertView *alertView = [[SIAlertView alloc] initWithTitle:@"重要提示"
                                                     andMessage:message];
    [alertView addButtonWithTitle:@"知道了"
                             type:SIAlertViewButtonTypeDefault
                          handler:^(SIAlertView *alertView) {
                          }];
    alertView.transitionStyle = SIAlertViewTransitionStyleBounce;
    [alertView show];
}


- (void)cancelAction
{
    [self cancelkeyBoard];
}

/*
inflag+contnumber
含8   inflag=1  contnumber=8
无4  inflag=2   contnumber=4
 */

- (void)doneAction
{
    if (self.qryNumByCnlOpt) {
        [self.qryNumByCnlOpt cancel];
        self.qryNumByCnlOpt = nil;
    }
    
    [self.searchArray removeAllObjects];
    [self.dataArray removeAllObjects];
    
    if (self.numberType == number) {
        _numberIndex = [_areaPicker selectedRowInComponent:0];
    } else {
        _moneyIndex = [_areaPicker selectedRowInComponent:0];
    }
    
    self.pageIndex = 1;
    self.searchPageIndex = 1;
    self.isLoading = NO;
    self.isFinished = NO;
    self.isSearchFinished = NO;
    self.isSearchLoading = NO;
    
    // 初始化参数
    self.tipView.hidden = YES;
    [self cancelkeyBoard];
    [self getSeachCondition];
    
    if (self.tabType == tabNormal) {
        self.isLoading = YES;
       [self qryNumByCnl:@""];
    }
    else{
        [self.searchArray removeAllObjects];
        [self.dataArray removeAllObjects];
        self.isSearchLoading = YES;
        [self qryNumByCnl:self.searchTextField.text];
    }
    
    [self.tableView reloadData];
    [self setBtnTitle];
}
//确定
- (void)choosePackageAction
{
    if (self.selectedData) {
        NSArray *VCAry = [self.navigationController viewControllers];
        for (UIViewController *vc in VCAry) {
            if ([vc isKindOfClass:[CTSelectPhoneVCtler class]]) {
                
                NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
                NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];
                
                [dictionary setObject:self.InFlag forKey:@"InFlag"];
                [dictionary setObject:self.IsLast forKey:@"IsLast"];
                [dictionary setObject:self.InNumber forKey:@"InNumber"];
                [dictionary setObject:self.ContNumber forKey:@"ContNumber"];
                [dictionary setObject:self.Headnumber forKey:@"Headnumber"];
                [dictionary setObject:self.SalesproductId forKey:@"SalesproductId"];
                [dictionary setObject:self.MaxPay forKey:@"MaxPay"];
                [dictionary setObject:self.MinPay forKey:@"MinPay"];
                [dictionary setObject:[self.locateData dictionaryRepresentation] forKey:@"locateData"];
                [dictionary setObject:[self.selectedData dictionaryRepresentation] forKey:@"selectedData"];
                [dictionary setObject:[NSNumber numberWithInt:self.numberType] forKey:@"numberType"];
                [dictionary setObject:[NSNumber numberWithInt:self.numberIndex] forKey:@"numberIndex"];
                [dictionary setObject:[NSNumber numberWithInt:self.moneyIndex] forKey:@"moneyIndex"];
                
                [defaults setObject:dictionary forKey:@"NumberSelectedInfo"];
                [defaults synchronize];
                
                CTSelectPhoneVCtler *tempVC = (CTSelectPhoneVCtler *)vc;
                tempVC.phoneData = self.selectedData ;
                [self.navigationController popToViewController:tempVC animated:YES];
            }
        }
    } else{
        SIAlertView *alertView = [[SIAlertView alloc] initWithTitle:nil
                                                         andMessage:@"亲，请选择一个靓号"];
        [alertView addButtonWithTitle:@"确定"
                                 type:SIAlertViewButtonTypeDefault
                              handler:^(SIAlertView *alertView) {
                                  
                              }];
        alertView.transitionStyle = SIAlertViewTransitionStyleBounce;
        [alertView show];
    }
}

- (void)shakeAction
{
    //摇一摇跳转要使用当前选中的城市编码
    CTShakeNumberVCtler *vc = [CTShakeNumberVCtler new];
    vc.jumpType = 1;
    vc.selectedCity = self.locateData;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)citySelectedAction
{
    [self hiddenPicker];
    [self.searchTextField resignFirstResponder];
    self.coverButton.hidden = YES;
    if (self.searchTextField.text.length == 0) {
        __weak __typeof(&*self)weakSelf = self;
        [UIView animateWithDuration:0.3
                         animations:^(void){
                             __strong __typeof(&*weakSelf)strongSelf = weakSelf;
                             if (!strongSelf) {
                                 return;
                             }
                             CGRect rect = strongSelf.searchTextField.frame;
                             if (rect.size.width < 150){
                                 rect.size.width += 52;
                                 strongSelf.searchTextField.frame = rect ;
                             }
                             
                         }completion:^(BOOL finish){
                             __strong __typeof(&*weakSelf)strongSelf = weakSelf;
                             if (!strongSelf) {
                                 return;
                             }
                         }];
    }
    
    CTCitySelectedVCtler *vc = [CTCitySelectedVCtler new];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)searchAction
{
    [self.searchTextField resignFirstResponder];
    if (self.qryNumByCnlOpt) {
        [self.qryNumByCnlOpt cancel];
        self.qryNumByCnlOpt = nil ;
    }
    
    //搜索消息
    if (!self.searchArray) {
        self.searchArray = [NSMutableArray array];
    }
    
    [self.searchArray removeAllObjects];
    
    self.tipView.hidden = YES;
    self.tabType = tabSearch ;
    self.searchPageSize = 20;
    self.searchPageIndex = 1;
    
    self.isSearchLoading = YES ;
    [self.tableView reloadData];

    [self qryNumByCnl:self.searchTextField.text];

}
// 号码选择
- (void)numberTypeAction:(UIButton *)sender
{
    [self.searchTextField resignFirstResponder];
    UIButton *btn = (UIButton *)sender;
    int index = btn.tag - 100;
    _numberType = index ;
    
    [self showPicker];
    [_areaPicker reloadAllComponents];
    if (_numberType == number) {
        [_areaPicker selectRow:_numberIndex inComponent:0 animated:YES];
    }
    else {
        [_areaPicker selectRow:_moneyIndex inComponent:0 animated:YES];
    }
    
    self.coverButton.hidden = NO;
}

//点击取消覆盖区域
- (void)cancelkeyBoard
{
    [self hiddenPicker];
    [self.searchTextField resignFirstResponder];
    self.coverButton.hidden = YES;
    if (self.searchTextField.text.length == 0)
    {
        __weak CTNumberSelectedVCtler * weakSelf = self;
        [UIView animateWithDuration:0.3
                         animations:^(void){
                             CGRect rect = weakSelf.searchTextField.frame;
                             {
                                 if (rect.size.width <200) {
                                     rect.size.width += 52;
                                     weakSelf.searchTextField.frame = rect ;
                                 }
                             }
                             
                         }completion:^(BOOL finish){
                            
                         }];
    }
}

#pragma mark - UITextFieldDelegate

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    [self hiddenPicker];
    __weak typeof(self)weakSelf = self;
    [UIView animateWithDuration:0.25
                     animations:^(void){
                         CGRect rect = weakSelf.searchTextField.frame;
                         rect.size.width= 200 -52;
                         weakSelf.searchTextField.frame = rect ;
                         weakSelf.coverButton.hidden = NO;
                     }completion:^(BOOL finish){
                         
                     }];
}

- (void) cancelSearchAction
{
    [self.searchTextField resignFirstResponder];
    self.isClear = YES;
    self.searchTextField.text = @"";
    //发送停止搜索消息
    __weak __typeof(&*self)weakSelf = self;
    [UIView animateWithDuration:0.3
                     animations:^(void){
                         CGRect rect = weakSelf.searchTextField.frame;
                         rect.size.width = 200;
                         weakSelf.searchTextField.frame = rect ;
                     }completion:^(BOOL finish){
                         weakSelf.coverButton.hidden = YES;
                     }];
    
    [self cancelSearch];
}

- (BOOL)textFieldShouldClear:(UITextField *)textField
{
    [textField resignFirstResponder];
    self.isClear = YES;
    //发送停止搜索消息
    __weak __typeof(&*self)weakSelf = self;
    [UIView animateWithDuration:0.3
                     animations:^(void){
                         CGRect rect = weakSelf.searchTextField.frame;
                         rect.size.width = 200;
                         weakSelf.searchTextField.frame = rect ;
                     }completion:^(BOOL finish){
                         weakSelf.coverButton.hidden = YES;
                     }];
    
    return YES;
}

#define NUMBERS  @"0123456789"
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSCharacterSet *cs    = [[NSCharacterSet characterSetWithCharactersInString:NUMBERS]invertedSet];
    NSString *filtered    = [[string componentsSeparatedByCharactersInSet:cs]componentsJoinedByString:@""];
    BOOL canChange        = [string isEqualToString:filtered];
    NSString * toBeString = [textField.text stringByReplacingCharactersInRange:range withString:string];
    if ([toBeString length]>4) {
        textField.text = [toBeString substringToIndex:4];
        canChange = NO ;
    }
    return canChange;
}


#pragma mark - NSNotification

- (void)createPage
{
    
    if (self.qryNumByCnlOpt) {
        [self.qryNumByCnlOpt cancel];
        self.qryNumByCnlOpt = nil;
    }
    
    [self.dataArray removeAllObjects];
    [self.searchArray removeAllObjects];
    
    [self numberTypeArray];
    [self saveMoneyArray];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSDictionary *dictionary = [defaults objectForKey:@"NumberSelectedInfo"];
    
    self.InFlag = [dictionary objectForKey:@"InFlag"];
    self.IsLast = [dictionary objectForKey:@"IsLast"];
    self.InNumber = [dictionary objectForKey:@"InNumber"];
    self.ContNumber = [dictionary objectForKey:@"ContNumber"];
    self.Headnumber = [dictionary objectForKey:@"Headnumber"];
    self.SalesproductId = [dictionary objectForKey:@"SalesproductId"];
    self.MaxPay = [dictionary objectForKey:@"MaxPay"];
    self.MinPay = [dictionary objectForKey:@"MinPay"];
    self.locateData = [CTCity modelObjectWithDictionary:[dictionary objectForKey:@"locateData"]];
    self.numberType = [[dictionary objectForKey:@"numberType"] integerValue];
    self.moneyIndex = [[dictionary objectForKey:@"moneyIndex"] intValue];
    self.numberIndex = [[dictionary objectForKey:@"moneyIndex"] intValue];
    
    [self getSeachCondition];
    [self cityView];
    {
        [self.cityButton setTitle:self.locateData.cityname forState:UIControlStateNormal];
        UIButton *btn = (UIButton *)[self.selectedView viewWithTag:100];
        [btn setTitle:_numberTypeArray[_numberIndex] forState:UIControlStateNormal];
        btn = (UIButton *)[self.selectedView viewWithTag:101];
        [btn setTitle:_saveMoneyArray[_moneyIndex] forState:UIControlStateNormal];
    }
    
    if (self.numberType == tabSearch &&
        ![self.ContNumber isEqualToString:@""] &&
        [self.ContNumber length]>0)
    {
        [self textFieldDidBeginEditing:self.searchTextField] ;
        self.searchTextField.text = self.ContNumber ;
        [self qryNumByCnl:self.searchTextField.text];
    } else {
        [self qryNumByCnl:@""];
    }
}

- (void)selectedCityNotification:(NSNotification *)notificaton
{
    if (self.qryNumByCnlOpt ) {
        [self.qryNumByCnlOpt cancel];
        self.qryNumByCnlOpt = nil;
    }
    
    self.tipView.hidden = YES ;
    self.nSelNumView.hidden = NO ;
    self.selectedData = nil;
    [self  showSelectedInfo];
    
    //城市选择消息
    CTCity *city = [notificaton object];
    self.locateData = city ;
    NSString *cityName = [NSString stringWithFormat:@"%@",self.locateData.cityname];
    if ([cityName hasSuffix:@"市"]) {
        cityName = [cityName substringToIndex:cityName.length-1];
    }
    [self.cityButton setTitle:cityName forState:UIControlStateNormal];
    
    //清空数据
    [self.dataArray removeAllObjects];
    [self.searchArray removeAllObjects];
    [self.tableView reloadData];
    
    //测试城市选择
    self.pageIndex = 1;
    self.pageSize = 20;
    self.isFinished = NO;
    self.isLoading = NO;
    
    self.isSearchFinished = NO;
    self.isSearchLoading = NO;
    self.searchPageSize = 20;
    self.searchPageIndex = 1;
    
    //搜索状态
    if (self.tabType == tabNormal) {
        if (!self.isLoading) {
            [self qryNumByCnl:@""];
        }
        self.isLoading = YES;
        [self.tableView reloadData];
    } else
    {
        if (!self.isSearchLoading) {
            [self qryNumByCnl:self.searchTextField.text];
        }
        self.isSearchLoading = YES;
        [self.tableView reloadData];
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)aScrollView
{
    //判断是否到达底部
    CGPoint offset = aScrollView.contentOffset;
    CGRect bounds = aScrollView.bounds;
    CGSize size = aScrollView.contentSize;
    UIEdgeInsets inset = aScrollView.contentInset;
    float y = offset.y + bounds.size.height - inset.bottom;
    float h = size.height;
    
    float reload_distance = 10;
    if(y > h + reload_distance) {
        if (self.tabType == tabNormal) {
            if (self.isFinished) {
                return;
            }
            
            if (!self.isLoading) {
                self.isLoading = YES ;
                [self.tableView reloadData];
                [self qryNumByCnl:@""];
            }
        }else{
            if (self.isSearchFinished) {
                return;
            }
            
            if (!self.isSearchLoading) {
                self.isSearchLoading = YES ;
                [self.tableView reloadData];
                [self qryNumByCnl:self.searchTextField.text];
            }
        }
    }
}

#pragma mark - picker delegate

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if (self.numberType == number) {
        return [self.numberTypeArray count];
    }
    return [self.saveMoneyArray count];
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if (self.numberType == number) {
        return [self.numberTypeArray objectAtIndex:row];
    }
    return [self.saveMoneyArray objectAtIndex:row];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    switch (self.numberType) {
        case number: // 选择号段
        {
//            self.numberIndex = row;
        }
            break;
        case money: // 预存款区间
        {
//            self.moneyIndex = row;
        }
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

