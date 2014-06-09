//
//  MineNonLoginVCtler.h
//  CTPocketV4
//
//  Created by Gong Xintao on 14-5-26.
//  Copyright (c) 2014年 广东亿迅科技有限公司. All rights reserved.
//未登录的右侧界面

#import "CTBaseViewController.h"
#import "RightParentVCtler.h"
@class CTNavigationController;
@class MineRightManager;
@interface MineNonLoginVCtler : RightParentVCtler<UITableViewDataSource,UITableViewDelegate>
@property(weak,nonatomic)IBOutlet UITableView *tableView;
@property(weak,nonatomic)IBOutlet UIButton *btn_login;
@property(weak,nonatomic)IBOutlet UIButton *recommendView;
-(IBAction)login:(id)sender;
-(IBAction)showShare:(id)sender;


@end
