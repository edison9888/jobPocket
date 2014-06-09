//
//  EsNewsPageVCtler.h
//  xhgdzwyq
//
//  Created by apple on 13-12-2.
//  Copyright (c) 2013年 Eshore. All rights reserved.
//

#import <UIKit/UIKit.h>

@class EsNewsPageVCtler;

typedef enum BoundaryViewChangedDirection__
{
    BoundaryViewChangedDirectionNone = 0,
    BoundaryViewChangedDirectionLeft,
    BoundaryViewChangedDirectionRight,
}BoundaryViewChangedDirection;

@protocol EsNewsPageVCtlerDelegate <NSObject>

@optional
- (UIViewController *)pageViewController:(EsNewsPageVCtler *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController;
- (UIViewController *)pageViewController:(EsNewsPageVCtler *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController;
- (void)pageViewController:(EsNewsPageVCtler* )pageViewController transitionCompleted:(BOOL)transitionCompleted;

// 在边界拖动
- (void)pageViewController:(EsNewsPageVCtler *)pageViewController boundceDirection:(BoundaryViewChangedDirection)boundceDirection;

@end

@interface EsNewsPageVCtler : UIViewController

@property (nonatomic, weak) id<EsNewsPageVCtlerDelegate> delegate;
@property (nonatomic, strong) UIViewController* currentVCtler;
@property (nonatomic, strong) UIView*           leftBoundaryView;
@property (nonatomic, strong) UIView*           rightBoundaryView;

@end
