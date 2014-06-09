//
//  CTCallsRechargeVCtler.h
//  CTPocketV4
//
//  Created by apple on 13-10-31.
//  Copyright (c) 2013年 广东亿迅科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RechargeTypeView.h"
#import "CTRechargeVCtler.h"
#import "APLKeyboardControls.h"

@interface CTCallsRechargeVCtler : CTBaseViewController<UIScrollViewDelegate>

@property (nonatomic, assign) RechargeTypeView *rechargeView;
//@property (nonatomic, strong) CTRechargeVCtler *parentVCtler;
@property (nonatomic, strong) UITextField *phoneNumTextField;
@property (nonatomic, strong) UITextField *carPassWrdTextField;

//@property(strong,nonatomic)APLKeyboardControls *keyboardControls;

- (void) showView : (int) tag;

@end
