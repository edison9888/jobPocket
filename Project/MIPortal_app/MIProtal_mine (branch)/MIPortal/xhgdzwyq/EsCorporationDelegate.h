//
//  EsCorporationDelegate.h
//  xhgdzwyq
//
//  Created by Eshore on 13-11-23.
//  Copyright (c) 2013年 Eshore. All rights reserved.
//

#ifndef xhgdzwyq_EsCorporationDelegate_h
#define xhgdzwyq_EsCorporationDelegate_h

@protocol EsCorporationDelegate <NSObject>

- (void) pushViewCtrl: (UIViewController *)vCtrl currentViewCtrl:(UIViewController *)curVCtrl;

- (void) popViewCtrlFromCurrentViewCtrl:(UIViewController *)curVCtrl;

@end

#endif
