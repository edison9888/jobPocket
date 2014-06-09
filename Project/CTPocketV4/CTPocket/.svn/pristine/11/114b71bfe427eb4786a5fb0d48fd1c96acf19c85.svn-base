//
//  UserLocationMapAnnotation.h
//  CTPocketV4
//
//  Created by apple on 13-11-19.
//  Copyright (c) 2013年 广东亿迅科技有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MAMapKit.h"

@interface UserLocationMapAnnotation : NSObject <MAAnnotation>
{
	CLLocationDegrees _latitude;
	CLLocationDegrees _longitude;
	NSString *_title;
}

@property (nonatomic, strong) NSString *title;

- (id)initWithLatitude:(CLLocationDegrees)latitude
		  andLongitude:(CLLocationDegrees)longitude;
- (void)setCoordinate:(CLLocationCoordinate2D)newCoordinate;

@end
