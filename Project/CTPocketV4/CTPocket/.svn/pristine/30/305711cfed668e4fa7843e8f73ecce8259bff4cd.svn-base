//
//  CTServiceHallListVCtler.m
//  CTPocketV4
//
//  Created by apple on 13-11-19.
//  Copyright (c) 2013年 广东亿迅科技有限公司. All rights reserved.
//

#import "CTServiceHallListVCtler.h"
#import "CTServiceHallCell.h"
#import "CTDistancePickerView.h"
#import "MAMapKit.h"
#import "AppDelegate.h"
#import "BestToneEngine.h"
#import "CTWifiLoadingView.h"
#import "HaobaiMapHelper.h"

typedef enum ServiceHallTableLoadingType__
{
    ServiceHallTableLoadingTypeNone = 0,
    ServiceHallTableLoadingTypeRefresh,
    ServiceHallTableLoadingTypeLoadingMore,
}ServiceHallTableLoadingType;

@interface CTServiceHallListVCtler ()
{
    UITableView *               _contentTable;
    CTDistancePickerView *      _distancePicker;
    
    MAUserLocation *            _userCurrentLocation;
    MAReverseGeocodingInfo *    _userAddrinfo;
    
    int                         _pageSize;
    int                         _pageNum;
    int                         _totalCount;
    NSMutableArray *            _dataList;
    ServiceHallTableLoadingType _loadingType;
    BestToneOperation *         _requestOperation;
    BOOL                        _isVisible;
}

@property (nonatomic, strong) NSMutableArray *  dataList;

@end

@implementation CTServiceHallListVCtler

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
        _loadingType = ServiceHallTableLoadingTypeNone;
        _isVisible = NO;
    }
    return self;
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
        UITableView * tv    = [[UITableView alloc] initWithFrame:CGRectMake((CGRectGetWidth(self.view.frame) - kCTServiceHallTableCellWidth)/2,
                                                                            CGRectGetMaxY(_distancePicker.frame),
                                                                            kCTServiceHallTableCellWidth,
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
    //modified by liuruxian 2014-05-13
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
    if (_loadingType == ServiceHallTableLoadingTypeLoadingMore)
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
    tipLab.text = [NSString stringWithFormat:@"附近%@米没有搜索到营业厅，向右划可搜更远", _distancePicker.distance];
    if (!_userCurrentLocation)
    {
        if ([HaobaiMapHelper checkLocationServiceEnable])
        {
            tipLab.text = @"玩命定位中...，请稍后";
        }
        else
        {
            tipLab.text = @"对不起，定位失败，请检查是否有打开定位服务或网络连接状况";
        }
    }
    
    tipLab.hidden = !(_dataList.count == 0 && _loadingType == ServiceHallTableLoadingTypeNone);
    
    if (_loadingType == ServiceHallTableLoadingTypeRefresh)
    {
        return 1;
    }
    else if (_loadingType == ServiceHallTableLoadingTypeLoadingMore)
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
    if (_loadingType == ServiceHallTableLoadingTypeRefresh)
    {
        needLoadingView = YES;
    }
    else if (_loadingType == ServiceHallTableLoadingTypeLoadingMore && indexPath.section == 1)
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
    
    static NSString * identifierStr = @"service cell";
    CTServiceHallCell * cell = (CTServiceHallCell *)[tableView dequeueReusableCellWithIdentifier:identifierStr];
    if (!cell)
    {
        cell = [[CTServiceHallCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifierStr];
    }
    [cell setServiceHallInfo:_dataList[indexPath.row]];
    cell.tag = indexPath.row;
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return kCTServiceHallTableCellHight;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [[NSNotificationCenter defaultCenter] postNotificationName:kShowWifiMapView object:[NSNumber numberWithInteger:indexPath.row]];
}

#pragma mark private
- (void)POISearch:(int)page
{
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
    
    NSString * city = @"";
    if (_userAddrinfo &&
        _userAddrinfo.city &&
        _userAddrinfo.city.name)
    {
        city = _userAddrinfo.city.name;
        if (city.length <= 0) {
            city = _userAddrinfo.province.name;
        }
        if ([city rangeOfString:@"市"].location == NSIntegerMax)
        {
            city = [NSString stringWithFormat:@"%@市", city];
        }
    }
    
    NSDictionary * params   = [NSDictionary dictionaryWithObjectsAndKeys:
                               @"102", @"sid",
                               BESTTONE_POI_KEY, @"key",
                               city, @"city",
                               [NSString stringWithFormat:@"%f", Longitude], @"cenx",     // 113.344145    经度
                               [NSString stringWithFormat:@"%f", Latitude], @"ceny",      // 23.144814    纬度
                               distance, @"range",
                               @"16010100", @"featcode",
                               [NSString stringWithFormat:@"%d", page], @"page",
                               [NSString stringWithFormat:@"%d", _pageSize], @"rows",
                               @"1", @"sort",
                               @"json", @"restype",
                               nil];
        
    __weak typeof(self) wself = self;
    [_requestOperation cancel];
    _requestOperation = [MyAppDelegate.bestToneEngine postJSONWithParams:params
                                                             onSucceeded:^(NSDictionary *dict) {
                                                                 [wself onPOISearchSuccess:dict];
                                                             } onError:^(NSError *engineError) {
                                                                 [wself onPOISearchSuccess:nil];
                                                             }];
}

- (void)onPOISearchSuccess:(NSDictionary * )result
{
    //    DDLogInfo(@"poi resutl %@", result);
    _loadingType = ServiceHallTableLoadingTypeNone;
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
            _loadingType = ServiceHallTableLoadingTypeLoadingMore;
        }
        break;
    } while (0);
    
    [_contentTable reloadData];
}

- (void)refreshData
{
    if (!_isVisible)
    {
        return;
    }
    
    if (!_dataList.count && _userAddrinfo)
    {
        _loadingType = ServiceHallTableLoadingTypeRefresh;
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
    }
    
    if ([keyPath isEqualToString:@"userAddrinfo"])
    {
        _userAddrinfo = [object valueForKey:@"userAddrinfo"];
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
            _loadingType = ServiceHallTableLoadingTypeRefresh;
            [_contentTable reloadData];
            [self POISearch:_pageNum+1];
        }
    }
}

@end
