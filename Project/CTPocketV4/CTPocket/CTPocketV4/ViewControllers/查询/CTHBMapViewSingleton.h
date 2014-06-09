//
//  CTHBMapViewSingleton.h
//  CTPocketV4
//
//  Created by apple on 14-2-11.
//  Copyright (c) 2014年 广东亿迅科技有限公司. All rights reserved.
//

#import "MAMapView.h"

@interface CTHBMapViewSingleton : MAMapView

+ (CTHBMapViewSingleton *)sharedSingleton;

@end
