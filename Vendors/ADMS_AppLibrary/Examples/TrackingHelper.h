//
//  TrackingHelper.h
//  Adobe Digital Marketing Suite
//

#import <Foundation/Foundation.h>

FOUNDATION_EXPORT NSString *const TRACKING_RSID;
FOUNDATION_EXPORT NSString *const TRACKING_SERVER;

@interface TrackingHelper : NSObject

+ (void) configureAppMeasurement;
+ (void) configureMediaMeasurement;

//Examples of Custom Event and AppState Tracking
//+ (void)trackCustomEvents:(NSString *)events;
//+ (void)trackCustomAppState:(NSString *)appState;

// 跟踪页面加载
+ (void)trackPageLoadedState:(NSString *)appState;

// 跟踪登录相关事件
+ (void)trackPage:(NSString *)appState events:(NSDictionary *)evtDic;

@end
