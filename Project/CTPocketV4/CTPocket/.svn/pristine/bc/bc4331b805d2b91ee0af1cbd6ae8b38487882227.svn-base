//
//  MineLoginedVCtler.h
//  CTPocketV4
//
//  Created by Gong Xintao on 14-5-26.
//  Copyright (c) 2014年 广东亿迅科技有限公司. All rights reserved.
//已经登录的右侧界面

#import "CTBaseViewController.h"
#import "RightParentVCtler.h"
#import "AutoScrollLabel.h"
@class CTBaseViewController;
@class MineRightManager;
@interface MineLoginedVCtler : RightParentVCtler<UITableViewDataSource,UITableViewDelegate>
@property(weak,nonatomic)IBOutlet UITableView *tableView;
@property(weak,nonatomic)IBOutlet UIButton *exitBtn;
//不再界面上显示，起着占位符的作用
@property(weak,nonatomic)IBOutlet UILabel *remarksLabel;
@property(weak,nonatomic)IBOutlet UIButton *recommendView;
-(IBAction)exit:(id)sender;
-(IBAction)showShare:(id)sender;
 

-(void)resetPoint:(NSString*)point;
-(void)resetUserName:(NSString *)useName;
@end
