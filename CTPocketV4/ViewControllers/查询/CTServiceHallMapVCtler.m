//
//  CTServiceHallMapVCtler.m
//  CTPocketV4
//
//  Created by apple on 13-11-19.
//  Copyright (c) 2013年 广东亿迅科技有限公司. All rights reserved.
//

#import "CTServiceHallMapVCtler.h"
#import "CalloutMapAnnotation.h"
#import "MAMapKit.h"
#import "BasicMapAnnotation.h"
#import "CalloutAnnotationView.h"
#import "AppDelegate.h"
#import "UserLocationMapAnnotation.h"
#import "CTHBMapViewSingleton.h"

#define kPointTag 88889

@interface CTServiceHallMapVCtler ()
{
    CTHBMapViewSingleton *      _haobaiMapview;
    MASearch *                  _mapSearch;
    CalloutMapAnnotation *      _calloutMapAnnotation;
    
    NSInteger                   _selectIndex;
    NSArray *                   _dataFromListView;
    NSMutableArray *            _mapDataList;
    BestToneOperation *         _requestOperation;
    BOOL                        _isVisible;
}

@property (nonatomic, strong) MAUserLocation *          userCurrentLocation;
@property (nonatomic, strong) MAReverseGeocodingInfo *  userAddrinfo;

@end

@implementation CTServiceHallMapVCtler

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onShowMapViewNotification:) name:kShowWifiMapView object:nil];
        _selectIndex = -1;
        _mapDataList = [NSMutableArray array];
        _isVisible = NO;
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onStopLocatingNotification) name:@"StopLocating" object:nil];
    }
    return self;
}

- (void)onStopLocatingNotification
{
    _haobaiMapview.hidden = YES;
    [_haobaiMapview setShowsUserLocation:NO];
    [_haobaiMapview setDelegate:nil];
    [_mapSearch setDelegate:nil];
    _mapSearch = nil;
}

- (void)dealloc
{
    [_haobaiMapview setShowsUserLocation:NO];
    [_haobaiMapview setDelegate:nil];
    [_mapSearch setDelegate:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    {
        CTHBMapViewSingleton * mapView = [CTHBMapViewSingleton sharedSingleton];
        __weak typeof(self) wself = self;
        mapView.delegate = (id<MAMapViewDelegate>)wself;
        [mapView setShowsUserLocation:YES];
        mapView.hidden = YES;
        [self.view addSubview:mapView];
        _haobaiMapview = mapView;
        _haobaiMapview.frame = self.view.bounds;
    }
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    _haobaiMapview.hidden = NO;
    [self addAnnotationOnMap];
    _isVisible = YES;
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    _isVisible = NO;
    _selectIndex = -1;
    [_haobaiMapview removeAnnotations:[NSArray arrayWithArray:_haobaiMapview.annotations]];
    _calloutMapAnnotation = nil;
    _haobaiMapview.hidden = YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark Notification
- (void)onShowMapViewNotification:(NSNotification *)notification
{
    if ([[notification object] respondsToSelector:@selector(integerValue)])
    {
        _selectIndex = [[notification object] integerValue];
    }
}

#pragma mark private
- (void)addAnnotationOnMap
{
    NSArray * datalist = _dataFromListView;
    double maxdis = 0;
    
    [_haobaiMapview removeAnnotations:[NSArray arrayWithArray:_haobaiMapview.annotations]];
    if (self.userCurrentLocation && self.userCurrentLocation.location)
    {
        UserLocationMapAnnotation * pointAnnota = [UserLocationMapAnnotation new];
        pointAnnota.coordinate = self.userCurrentLocation.location.coordinate;
        [_haobaiMapview addAnnotation:pointAnnota];
    }
    
    for (NSDictionary * dict in datalist)
    {
        id coord = [dict objectForKey:@"coord"];
        if (![coord isKindOfClass:[NSString class]]) continue;
        
        NSArray * tmparr = [coord componentsSeparatedByString:@","];
        if ([tmparr count] != 2) continue;
        
        double longitude = [[tmparr objectAtIndex:1] doubleValue];
        double latitude = [[tmparr objectAtIndex:0] doubleValue];
        if (longitude == 0 || latitude == 0) continue;
        
        BasicMapAnnotation * pointAnnota = [BasicMapAnnotation new];
        pointAnnota.coordinate = (CLLocationCoordinate2D){latitude, longitude};
        pointAnnota.tag = [datalist indexOfObject:dict];
        [_haobaiMapview addAnnotation:pointAnnota];
        
        CLLocation * cllocation = [[CLLocation alloc] initWithLatitude:latitude longitude:longitude];
        maxdis = MAX([cllocation distanceFromLocation:self.userCurrentLocation.location], maxdis);
        
        if ([datalist indexOfObject:dict] == _selectIndex)
        {
            _calloutMapAnnotation = [[CalloutMapAnnotation alloc] initWithLatitude:pointAnnota.coordinate.latitude andLongitude:pointAnnota.coordinate.longitude];
            _calloutMapAnnotation.tag = pointAnnota.tag;
            [_haobaiMapview addAnnotation:_calloutMapAnnotation];
            [_haobaiMapview setCenterCoordinate:_calloutMapAnnotation.coordinate animated:YES];
        }
    }
    
    if (maxdis != 0)
    {
        MACoordinateRegion region = (MACoordinateRegion){(CLLocationCoordinate2D)(self.userCurrentLocation.location.coordinate),(MACoordinateSpan){0.06, 0.06}};
        [_haobaiMapview setRegion:region animated:NO];
    }
}

- (void)POISearch:(CLLocationCoordinate2D)currentMapCenterCoordinate2D andCityName:(NSString *)cityName;
{
    if (!cityName.length) return;
    
    NSDictionary * params   = [NSDictionary dictionaryWithObjectsAndKeys:
                               @"102", @"sid",
                               BESTTONE_POI_KEY, @"key",
                               cityName, @"city",
                               [NSString stringWithFormat:@"%f", currentMapCenterCoordinate2D.longitude], @"cenx",     // 113.344145    经度
                               [NSString stringWithFormat:@"%f", currentMapCenterCoordinate2D.latitude], @"ceny",      // 23.144814    纬度
                               @"10000", @"range",
                               @"16010100", @"featcode",
                               [NSString stringWithFormat:@"%d", 1], @"page",
                               [NSString stringWithFormat:@"%d", 20], @"rows",
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
    BOOL iserr = NO;
    NSString * tipmsg = @"";
    do
    {
        if (![result isKindOfClass:[NSDictionary class]])
        {
            iserr = YES;
            break;
        }
        
        NSDictionary * response = [result objectForKey:@"response"];
        if (![response isKindOfClass:[NSDictionary class]])
        {
            iserr = YES;
            break;
        }
        
        NSArray * docs = [response objectForKey:@"docs"];
        if (![docs isKindOfClass:[NSArray class]])
        {
            iserr = YES;
            break;
        }
        
        if ([docs count] <= 0)
        {
            iserr = YES;
            if ([[response objectForKey:@"error"] isKindOfClass:[NSString class]] &&
                [[response objectForKey:@"error"] length])
            {
                tipmsg = [response objectForKey:@"error"];
            }
            break;
        }
        
        NSMutableArray *addInfos = [NSMutableArray array];
        for (int i = 0; i < docs.count; i++)
        {
            NSDictionary *info = [docs objectAtIndex:i];
            if (![self array:_dataFromListView hasSameInfo:info] && ![self array:_mapDataList hasSameInfo:info])
            {
                [_mapDataList addObject:info];
                [addInfos addObject:info];
            }
        }
        
        [self addAnnotationByInfos:addInfos];
        break;
    } while (0);
}

- (BOOL)array:(NSArray *)infoArray hasSameInfo:(NSDictionary *)info
{
    if (!info || ![info isKindOfClass:[NSDictionary class]]) {
        return NO;
    }
    
    if (!infoArray || ![infoArray isKindOfClass:[NSArray class]]) {
        return NO;
    }
    
    NSString *district_name_1 = [info objectForKey:@"name"];
    NSString *hp_address_1 = [info objectForKey:@"addr"];
    
    NSDictionary *info_2 = nil;
    for (int i = 0; i < infoArray.count; i++) {
        info_2 = [infoArray objectAtIndex:i];
        if (info_2 && [info_2 isKindOfClass:[NSDictionary class]]) {
            
            NSString *district_name_2 = [info_2 objectForKey:@"name"];
            NSString *hp_address_2 = [info_2 objectForKey:@"addr"];
            
            if ([district_name_1 isEqualToString:district_name_2] && [hp_address_1 isEqualToString:hp_address_2]) {
                break;
            } else {
                info_2 = nil;
            }
        }
    }
    
    if (info_2) {
        return YES;
    } else {
        return NO;
    }
}

- (void)addAnnotationByInfos:(NSArray *)infos
{
    NSMutableArray *annotations = [NSMutableArray array];
    
    for (NSDictionary *info in infos) {
        id coord = [info objectForKey:@"coord"];
        if (![coord isKindOfClass:[NSString class]]) continue;
        
        NSArray * tmparr = [coord componentsSeparatedByString:@","];
        if ([tmparr count] != 2) continue;
        
        double longitude = [[tmparr objectAtIndex:1] doubleValue];
        double latitude = [[tmparr objectAtIndex:0] doubleValue];
        if (longitude == 0 || latitude == 0) continue;
        
        BasicMapAnnotation * pointAnnota = [BasicMapAnnotation new];
        pointAnnota.coordinate = (CLLocationCoordinate2D){latitude, longitude};
        pointAnnota.tag = kPointTag + [_mapDataList indexOfObject:info];
        [annotations addObject:pointAnnota];
    }
    
    if (annotations.count > 0) {
        [_haobaiMapview addAnnotations:annotations];
    }
}

#pragma mark MAMapViewDelegate
-(NSString *)mapViewSearchKey
{
    return BESTTONE_POI_KEY;
}

- (void)mapViewWillStartLocatingUser:(MAMapView *)mapView
{
    NSLog(@"%s", __func__);
    NSLog(@"%@", mapView);
//    [SVProgressHUD showWithStatus:@"查找中..." maskType:SVProgressHUDMaskTypeGradient];
}

-(BOOL)mapView:(MAMapView*)mapView shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
{
    return NO;
}

- (void)mapView:(MAMapView *)mapView didUpdateUserLocation:(MAUserLocation *)userLocation
{
    [mapView setShowsUserLocation:NO];
    
    if (!userLocation)
    {
        return;
    }
    DDLogInfo(@"%s %f %f", __func__, userLocation.location.coordinate.latitude, userLocation.location.coordinate.longitude);
    
    [mapView setCenterCoordinate:userLocation.location.coordinate animated:YES];
    self.userCurrentLocation = userLocation;
    
    if (!_mapSearch)
    {
        _mapSearch = [MASearch maSearchWithDelegate:(id<MASearchDelegate>)self];
    }
    
    MAReverseGeocodingSearchOption * opt = [MAReverseGeocodingSearchOption new];
    opt.config              = @"SPAS";
    opt.authKey             = BESTTONE_POI_KEY;
    opt.encode              = @"UTF-8";
    opt.x                   = [NSString stringWithFormat:@"%f", userLocation.location.coordinate.longitude];
    opt.y                   = [NSString stringWithFormat:@"%f", userLocation.location.coordinate.latitude];
    [_mapSearch reverseGeocodingSearchWithOption:opt];
}

- (void)mapView:(MAMapView *)mapView didFailToLocateUserWithError:(NSError *)error
{
    DDLogCInfo(@"%s %@", __func__, error);
    [mapView setShowsUserLocation:NO];
}

- (MAAnnotationView*)mapView:(MAMapView *)mapView viewForAnnotation:(id <MAAnnotation>)annotation
{
    if ([annotation isKindOfClass:[BasicMapAnnotation class]])
    {
        static NSString *mAAnnotationViewReuseIdentifier = @"MAAnnotationView ReuseIdentifier";
        MAAnnotationView *annotationView = [[MAAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:mAAnnotationViewReuseIdentifier];
        annotationView.canShowCallout = NO;
        
        int tag = ((BasicMapAnnotation *)annotation).tag;
        if (tag >= kPointTag) {
            annotationView.image = [UIImage imageNamed:@"annotation_map"];
        } else {
            annotationView.image = [CalloutAnnotationView getCharImageByIndex:((BasicMapAnnotation *)annotation).tag];
        }
        
        return annotationView;
    }
    else if ([annotation isKindOfClass:[UserLocationMapAnnotation class]])
    {
        static NSString *mAAnnotationViewReuseIdentifier = @"UserLocationMapAnnotation ReuseIdentifier";
        MAAnnotationView *annotationView = [[MAAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:mAAnnotationViewReuseIdentifier];
        annotationView.canShowCallout = NO;
        annotationView.image = [UIImage imageNamed:@"annotation_map2"];
        
        return annotationView;
    }
    else if ([annotation isKindOfClass:[CalloutMapAnnotation class]])
    {
        static NSString *calloutAnnotationViewReuseIdentifier = @"CalloutAnnotationView ReuseIdentifier";
        CalloutAnnotationView *annotationView = (CalloutAnnotationView *)[mapView dequeueResuableAnnotationWithIndentifier:calloutAnnotationViewReuseIdentifier];
        if (annotationView == nil) {
            annotationView = [[CalloutAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:calloutAnnotationViewReuseIdentifier];
            annotationView.canShowCallout = NO;
        }
        
        int tag = ((CalloutMapAnnotation *)annotation).tag;
        if (tag == kPointTag - 1)
        {
            NSMutableString * address = [NSMutableString string];
            if (self.userAddrinfo.province && self.userAddrinfo.province.name)
            {
                [address appendString:self.userAddrinfo.province.name];
            }
            
            if (self.userAddrinfo.city && self.userAddrinfo.city.name)
            {
                [address appendString:self.userAddrinfo.city.name];
            }
            
            if (self.userAddrinfo.district && self.userAddrinfo.district.name)
            {
                [address appendString:self.userAddrinfo.district.name];
            }
            
            if (self.userAddrinfo &&
                self.userAddrinfo.pois &&
                [self.userAddrinfo.pois count])
            {
                MAPOI * item = [self.userAddrinfo.pois objectAtIndex:0];
                [address appendString:item.address];
            }
            
            NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:@"您当前所在位置为: ", @"name", address, @"addr", nil];
            [annotationView setInfo:dic];
        }
        else if (tag < kPointTag)
        {
            NSDictionary * dict = [_dataFromListView objectAtIndex:tag];
            [annotationView setInfo:dict];
        } else {
            NSDictionary * dict = [_mapDataList objectAtIndex:tag - kPointTag];
            [annotationView setInfo:dict];
        }
        
        return annotationView;
    }
    
    return nil;
}

- (void)mapView:(MAMapView *)mapView didSelectAnnotationView:(MAAnnotationView *)view
{
    if ([view.annotation isKindOfClass:[BasicMapAnnotation class]])
    {
        BasicMapAnnotation * annotion = view.annotation;
        if (_calloutMapAnnotation &&
            _calloutMapAnnotation.longitude == annotion.coordinate.longitude &&
            _calloutMapAnnotation.latitude == annotion.coordinate.latitude)
        {
            return;
        }
        
        if (_calloutMapAnnotation)
        {
            [mapView removeAnnotation:_calloutMapAnnotation];
            _calloutMapAnnotation = nil;
        }
        
        _calloutMapAnnotation = [[CalloutMapAnnotation alloc] initWithLatitude:view.annotation.coordinate.latitude andLongitude:view.annotation.coordinate.longitude];
        _calloutMapAnnotation.tag = annotion.tag;
        [mapView addAnnotation:_calloutMapAnnotation];
        [mapView setCenterCoordinate:_calloutMapAnnotation.coordinate animated:YES];
	}
    else if ([view.annotation isKindOfClass:[UserLocationMapAnnotation class]])
    {
        UserLocationMapAnnotation * annotion = view.annotation;
        if (_calloutMapAnnotation &&
            _calloutMapAnnotation.longitude == annotion.coordinate.longitude &&
            _calloutMapAnnotation.latitude == annotion.coordinate.latitude)
        {
            return;
        }
        
        if (_calloutMapAnnotation)
        {
            [mapView removeAnnotation:_calloutMapAnnotation];
            _calloutMapAnnotation = nil;
        }
        
        _calloutMapAnnotation = [[CalloutMapAnnotation alloc] initWithLatitude:view.annotation.coordinate.latitude andLongitude:view.annotation.coordinate.longitude];
        _calloutMapAnnotation.tag = kPointTag - 1;
        [mapView addAnnotation:_calloutMapAnnotation];
        [mapView setCenterCoordinate:_calloutMapAnnotation.coordinate animated:YES];
	}
}

- (void)mapView:(MAMapView *)mapView didDeselectAnnotationView:(MAAnnotationView *)view
{
    if (_calloutMapAnnotation &&
        ![view isKindOfClass:[CalloutAnnotationView class]] &&
        _calloutMapAnnotation.longitude == view.annotation.coordinate.longitude &&
        _calloutMapAnnotation.latitude == view.annotation.coordinate.latitude)
    {
        [mapView removeAnnotation:_calloutMapAnnotation];
        _calloutMapAnnotation = nil;
    }
}

//拖动地图后会调用
- (void)mapView:(MAMapView *)mapView regionDidChangeAnimated:(BOOL)animated
{
    if (self.userCurrentLocation)
    {
        if (!_mapSearch)
        {
            _mapSearch = [MASearch maSearchWithDelegate:(id<MASearchDelegate>)self];
        }
        
        //    116.223343,39.956699
        MAReverseGeocodingSearchOption * opt = [MAReverseGeocodingSearchOption new];
        opt.config              = @"SPAS";
        opt.authKey             = BESTTONE_POI_KEY;
        opt.encode              = @"UTF-8";
        opt.x                   = [NSString stringWithFormat:@"%f", mapView.centerCoordinate.longitude];//@"116.223343";//
        opt.y                   = [NSString stringWithFormat:@"%f", mapView.centerCoordinate.latitude];//@"39.956699";//
        [_mapSearch reverseGeocodingSearchWithOption:opt];
    }
}

#pragma mark MASearchDelegate
-(void)search:(id)searchOption Error:(NSString*)errCode
{
    DDLogCInfo(@"search error %@", errCode);
}

-(void)reverseGeocodingSearch:(MAReverseGeocodingSearchOption*)geoCodingSearchOption Result:(MAReverseGeocodingSearchResult*)result
{
    if ([[result resultArray] count])
    {
        MAReverseGeocodingInfo * item = [[result resultArray] objectAtIndex:0];
        MAReverseGeocodingInfo * tmp  = [[MAReverseGeocodingInfo alloc] init];
        tmp.province   = item.province;
        tmp.city       = item.city;
        tmp.district   = item.district;
        tmp.pois       = item.pois;
        tmp.roads      = item.roads;
        tmp.crosses    = item.crosses;
        self.userAddrinfo = tmp;
        
        if (_isVisible)
        {
            NSString *city = self.userAddrinfo.city.name;
            if (city.length <= 0) {
                city = self.userAddrinfo.province.name;
            }
            if ([city rangeOfString:@"市"].location == NSIntegerMax)
            {
                city = [NSString stringWithFormat:@"%@市", city];
            }
            CLLocationDegrees longitude = [geoCodingSearchOption.x doubleValue];
            CLLocationDegrees latitude = [geoCodingSearchOption.y doubleValue];
            CLLocationCoordinate2D location = {latitude, longitude};
            [self POISearch:location andCityName:city];
        }
    }
}

- (void)mapViewDidStopLocatingUser:(MAMapView *)mapView
{
    NSLog(@"%s", __func__);
    NSLog(@"%@", mapView);
}

#pragma mark KVO
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if ([keyPath isEqualToString:@"dataList"])
    {
        _dataFromListView = [object valueForKey:@"dataList"];
        if (_isVisible)
        {
            [self addAnnotationOnMap];
        }
    }
}

@end
