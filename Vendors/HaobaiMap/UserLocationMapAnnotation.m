//
//  UserLocationMapAnnotation.m
//  CTPocketV4
//
//  Created by apple on 13-11-19.
//  Copyright (c) 2013年 广东亿迅科技有限公司. All rights reserved.
//

#import "UserLocationMapAnnotation.h"

@implementation UserLocationMapAnnotation

- (id)initWithLatitude:(CLLocationDegrees)latitude
		  andLongitude:(CLLocationDegrees)longitude {
	if (self = [super init]) {
		_latitude = latitude;
		_longitude = longitude;
	}
	return self;
}

- (CLLocationCoordinate2D)coordinate {
	CLLocationCoordinate2D coordinate;
	coordinate.latitude = _latitude;
	coordinate.longitude = _longitude;
	return coordinate;
}

- (void)setCoordinate:(CLLocationCoordinate2D)newCoordinate {
	_latitude = newCoordinate.latitude;
	_longitude = newCoordinate.longitude;
}

@end
