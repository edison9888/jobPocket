//
//  CTQryValueAddVCtler.h
//  CTPocketV4
//
//  Created by Mac-Eshore-01 on 13-11-6.
//  Copyright (c) 2013年 广东亿迅科技有限公司. All rights reserved.
//  增值业务查询

#import <UIKit/UIKit.h>
#import "CTBaseViewController.h"
//#import "CTQryValueAddVCtler"

@interface AddValItem : UIView{
    UILabel* labName;
    UILabel* labMoney;
    UILabel* labUnie;
    
    UIButton* btnQuit;
}

@property(nonatomic,retain)NSDictionary* itemData;
//@property (nonatomic,strong) CTQryValueAddVCtler *parentVC;

@end

@interface CTQryValueAddVCtler : CTBaseViewController

@end
