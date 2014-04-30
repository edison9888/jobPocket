//
//  CTHBMapViewSingleton.m
//  CTPocketV4
//
//  Created by apple on 14-2-11.
//  Copyright (c) 2014年 广东亿迅科技有限公司. All rights reserved.
//

#import "CTHBMapViewSingleton.h"

@implementation CTHBMapViewSingleton

+ (CTHBMapViewSingleton *)sharedSingleton
{
	static CTHBMapViewSingleton *__sharedSingleton;
	@synchronized(self)
	{
		if (!__sharedSingleton)
        {
			__sharedSingleton = [[CTHBMapViewSingleton alloc] initWithFrame:[UIScreen mainScreen].bounds];
            __sharedSingleton.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
            __sharedSingleton.mapType = MAMapTypeStandard;
            __sharedSingleton.clipsToBounds = YES;
		}
		return __sharedSingleton;
	}
}

@end
