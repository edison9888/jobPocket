/*=================================
 *Desc：导航条基类，
 *Date：2014/05/21
 *Auth：lip
 *=================================*/

#import <UIKit/UIKit.h>

@interface EsNavigationCtler : UINavigationController

@end

@interface UINavigationController(NavigationAnimation)

@property (nonatomic, assign) BOOL animating;

@end

