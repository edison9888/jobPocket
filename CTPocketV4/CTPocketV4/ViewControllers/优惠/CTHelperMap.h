//
//  CTHelperMap.h
//  CTPocketV4
//
//  Created by liuruxian on 14-1-15.
//  Copyright (c) 2014年 广东亿迅科技有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MAMapKit.h"
#import "MAMapView.h"
#import "MASearch.h"
#import "CTCity.h"
#import "HaobaiMapHelper.h"


typedef void (^GetAreaInfoBlock)(CTCity *phoneInfo,NSError *error);
typedef void (^LoactionBlock)(CTCity *phoneInfo, NSError *error) ;

@interface CTHelperMap : NSObject

@property (nonatomic, strong) MAMapView *mapView;
@property (nonatomic, strong) MASearch  *searchView;
@property (nonatomic, strong) MAUserLocation *userLocation;
@property (nonatomic, strong) CTCity *areaInfo;
@property (nonatomic, assign) BOOL isSuccess ;
@property (nonatomic, assign) BOOL isTip;
@property (nonatomic, assign) BOOL isLoacted;
@property (nonatomic, /*strong*/copy) GetAreaInfoBlock getAreaInfoBlock;    // modified by zy, 2014-02-21

+ (CTHelperMap *) shareHelperMap;
//- (BOOL) isOpenLocated;
- (void) setLocation : (LoactionBlock)finishBlock;
- (void) getAreaInfo : (GetAreaInfoBlock) Block;
- (void) qryAreaInfo;
@end
