//
//  COQueryVctler.h
//  CTPocketV4
//
//  Created by Mac-Eshore-01 on 14-1-17.
//  Copyright (c) 2014年 广东亿迅科技有限公司. All rights reserved.
//

// 我的订单

#import <UIKit/UIKit.h>
#import "CTBaseViewController.h"
#import "COQueryListVctler.h"

typedef void(^NavTabActionBlock)(int selIndex);

//////////////////////////////////////////////////
@interface NavTabView:UIView{
    NSMutableArray* titles;
    NavTabActionBlock _mActionBlock;
}

-(id)initWithFrame:(CGRect)frame acblock:(NavTabActionBlock)block;
-(void)selAtIndex:(NSInteger)index;
-(void)addTabItem:(NSString*)title select:(BOOL)sel;
@end

@interface COQueryVctler : CTBaseViewController{
    CQQVCStatus _vcstatus;
}
@end
