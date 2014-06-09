//
//  CTWifiListVCtler.m
//  CTPocketV4
//
//  Created by apple on 13-11-14.
//  Copyright (c) 2013年 广东亿迅科技有限公司. All rights reserved.
//

#import "CTWifiListVCtler.h"
#import "CTWifiCell.h"
#import "CTDistancePickerView.h"
#import "MAMapKit.h"
#import "AppDelegate.h"
#import "BestToneEngine.h"
#import "CTWifiLoadingView.h"
#import "HaobaiMapHelper.h"

typedef enum WifiTableLoadingType__
{
    WifiTableLoadingTypeNone = 0,
    WifiTableLoadingTypeRefresh,
    WifiTableLoadingTypeLoadingMore,
}WifiTableLoadingType;

@interface CTWifiListVCtler ()
{
    UITableView *               _contentTable;
    CTDistancePickerView *      _distancePicker;
    
    MAUserLocation *            _userCurrentLocation;
    
    int                         _pageSize;
    int                         _pageNum;
    int                         _totalCount;
    NSMutableArray *            _dataList;
    WifiTableLoadingType        _loadingType;
    BestToneOperation *         _requestOperation;
    BOOL                        _isVisible;
}

@property (nonatomic, strong) NSMutableArray *  dataList;

@end

@implementation CTWifiListVCtler

@synthesize dataList = _dataList;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        _pageSize = 10;
        _pageNum = 0;
        _totalCount = 0;
        _dataList = [NSMutableArray new];
        _loadingType = WifiTableLoadingTypeNone;
    }
    return self;
}

- (void)dealloc
{
    DDLogCInfo(@"%s", __func__);
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    {
        CTDistancePickerView * v = [[CTDistancePickerView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), 100)];
        [self.view addSubview:v];
        _distancePicker          = v;
    }
    {
        UITableView * tv    = [[UITableView alloc] initWithFrame:CGRectMake((CGRectGetWidth(self.view.frame) - kCTWifiTableCellWidth)/2,
                                                                            CGRectGetMaxY(_distancePicker.frame),
                                                                            kCTWifiTableCellWidth,
                                                                            CGRectGetHeight(self.view.frame) - 115)
                                                           style:UITableViewStylePlain];
        tv.backgroundColor  = [UIColor clearColor];
        tv.separatorStyle   = UITableViewCellSeparatorStyleNone;
        tv.delegate         = (id<UITableViewDelegate>)self;
        tv.dataSource       = (id<UITableViewDataSource>)self;
        tv.autoresizingMask = UIViewAutoresizingFlexibleHeight;
        [self.view addSubview:tv];
        _contentTable       = tv;
        
        {
            UIView * grayView        = [[UIView alloc] initWithFrame:tv.bounds];
            grayView.backgroundColor = [UIColor lightGrayColor];
            grayView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
            tv.backgroundView        = grayView;
            
            UIView * maskView        = [[UIView alloc] initWithFrame:CGRectInset(grayView.frame, 1, 1)];
            maskView.backgroundColor = PAGEVIEW_BG_COLOR;
            maskView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
            [grayView addSubview:maskView];
        }
    }
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [_distancePicker addObserver:self forKeyPath:@"distance" options:NSKeyValueObservingOptionNew context:nil];
    _isVisible = YES;
    [self refreshData];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    if (_isVisible) {
        [_distancePicker removeObserver:self forKeyPath:@"distance" context:nil];
    }
    _isVisible = NO;
    [_requestOperation cancel];
    _requestOperation = nil;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark UITableView

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (_loadingType == WifiTableLoadingTypeLoadingMore)
    {
        return 2;
    }
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    int count = _dataList.count;
    tableView.backgroundView.hidden = !(_dataList.count > 0);
    
    UILabel * tipLab = (UILabel *)[tableView viewWithTag:65535];
    if (!tipLab)
    {
        tipLab                  = [[UILabel alloc] initWithFrame:CGRectMake(0, 40, CGRectGetWidth(tableView.backgroundView.frame), 40)];
        tipLab.tag              = 65535;
        tipLab.backgroundColor  = [UIColor clearColor];
        tipLab.textColor        = [UIColor colorWithRed:241/255. green:131/255. blue:119/255. alpha:1];
        tipLab.textAlignment    = UITextAlignmentCenter;
        tipLab.font             = [UIFont systemFontOfSize:14];
        tipLab.numberOfLines    = 2;
        [tableView addSubview:tipLab];
    }
    tipLab.text = [NSString stringWithFormat:@"附近%@米没有搜索到热点，向右划可搜更远", _distancePicker.distance];
    if (!_userCurrentLocation)
    {
        if ([HaobaiMapHelper checkLocationServiceEnable])
        {
            tipLab.text = @"玩命定位中...，请稍候";
        }
        else
        {
            tipLab.text = @"对不起，定位失败，请检查是否有打开定位服务或网络连接状况";
        }
    }
    
    tipLab.hidden = !(_dataList.count == 0 && _loadingType == WifiTableLoadingTypeNone);
    
    if (_loadingType == WifiTableLoadingTypeRefresh)
    {
        return 1;
    }
    else if (_loadingType == WifiTableLoadingTypeLoadingMore)
    {
        if (section == 0)
        {
            return _dataList.count;
        }
        else
        {
            return 1;
        }
    }
    
    return count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    BOOL needLoadingView = NO;
    if (_loadingType == WifiTableLoadingTypeRefresh)
    {
        needLoadingView = YES;
    }
    else if (_loadingType == WifiTableLoadingTypeLoadingMore && indexPath.section == 1)
    {
        needLoadingView = YES;
        [self POISearch:_pageNum+1];
    }
    
    if (needLoadingView)
    {
        static NSString * identifierStr = @"loading cell";
        CTWifiLoadingView * cell = (CTWifiLoadingView *)[tableView dequeueReusableCellWithIdentifier:identifierStr];
        if (!cell)
        {
            cell = [[CTWifiLoadingView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(tableView.frame), 40)];
        }
        return cell;
    }
    
    static NSString * identifierStr = @"wifi cell";
    CTWifiCell * cell = (CTWifiCell *)[tableView dequeueReusableCellWithIdentifier:identifierStr];
    if (!cell)
    {
        cell = [[CTWifiCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifierStr];
    }
    [cell setWifiInfo:_dataList[indexPath.row]];
    cell.tag = indexPath.row;
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return kCTWifiTableCellHight;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [[NSNotificationCenter defaultCenter] postNotificationName:kShowWifiMapView object:[NSNumber numberWithInteger:indexPath.row]];
}

#pragma mark private
- (void)POISearch:(int)page
{
    DDLogCInfo(@"%s", __func__);
    if (!_userCurrentLocation)
    {
        DDLogCInfo(@"locating failed");
        return;
    }
    
    double Longitude = 0;
    double Latitude = 0;
    if (_userCurrentLocation &&
        _userCurrentLocation.location)
    {
        Longitude = _userCurrentLocation.location.coordinate.longitude;
        Latitude = _userCurrentLocation.location.coordinate.latitude;
    }
    
    NSString * distance = @"300";
    if ([_distancePicker.distance length])
    {
        distance = _distancePicker.distance;
    }
    
    NSDictionary * params   = [NSDictionary dictionaryWithObjectsAndKeys:
                               @"802", @"sid",
                               BESTTONE_POI_KEY, @"key",
                               [NSString stringWithFormat:@"%f", Longitude], @"cenx",     // 113.344145    经度
                               [NSString stringWithFormat:@"%f", Latitude], @"ceny",      // 23.144814    纬度
                               distance, @"range",
                               [NSString stringWithFormat:@"%d", page], @"page",
                               [NSString stringWithFormat:@"%d", _pageSize], @"rows",
                               @"json", @"restype",
                               nil];
    
    __weak typeof(self) wself = self;
    [_requestOperation cancel];
    _requestOperation = nil ;
    _requestOperation = [MyAppDelegate.bestToneEngine postJSONWithParams:params
                                                             onSucceeded:^(NSDictionary *dict) {
                                                                 [wself onPOISearchSuccess:dict];
                                                             } onError:^(NSError *engineError) {
                                                                 [wself onPOISearchSuccess:nil];
                                                             }];
}

- (void)onPOISearchSuccess:(NSDictionary * )result
{
    DDLogInfo(@"poi resutl %@", result);
    _loadingType = WifiTableLoadingTypeNone;
    do
    {
        if (![result isKindOfClass:[NSDictionary class]])
        {
            break;
        }
        
        NSDictionary * response = [result objectForKey:@"response"];
        if (![response isKindOfClass:[NSDictionary class]])
        {
            break;
        }
                
        NSArray * docs = [response objectForKey:@"docs"];
        if (![docs isKindOfClass:[NSArray class]])
        {
            break;
        }
        
        [self willChangeValueForKey:@"dataList"];
        [_dataList addObjectsFromArray:docs];
        [self didChangeValueForKey:@"dataList"];
        
        _pageNum = [[response objectForKey:@"page"] intValue];
        _totalCount = [[response objectForKey:@"count"] intValue];
        
        if ([_dataList count] && _pageNum*_pageSize < _totalCount)
        {
            _loadingType = WifiTableLoadingTypeLoadingMore;
        }
        break;
    } while (0);
    
    [_contentTable reloadData];
    DDLogInfo(@"indexPathsForVisibleRows %@", _contentTable.indexPathsForVisibleRows);
}

- (void)refreshData
{
    if (!_isVisible)
    {
        return;
    }
    
    if (!_dataList.count && _userCurrentLocation)
    {
        _loadingType = WifiTableLoadingTypeRefresh;
        [_contentTable reloadData];
        [self POISearch:_pageNum+1];
    }
}

#pragma mark KVO
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if ([keyPath isEqualToString:@"userCurrentLocation"])
    {
        _userCurrentLocation = [object valueForKey:@"userCurrentLocation"];
        [self refreshData];
    }
    
    if ([keyPath isEqualToString:@"distance"])
    {
        [_requestOperation cancel];
        _requestOperation = nil;
        _pageNum = 0;
        _totalCount = 0;
        [_dataList removeAllObjects];
        if (_userCurrentLocation)
        {
            _loadingType = WifiTableLoadingTypeRefresh;
            [_contentTable reloadData];
            [self POISearch:_pageNum+1];
        }
    }
}

@end
