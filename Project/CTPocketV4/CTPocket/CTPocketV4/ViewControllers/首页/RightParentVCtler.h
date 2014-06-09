//
//  RightParentVCtler.h
//  CTPocketV4
//
//  Created by Gong Xintao on 14-5-29.
//  Copyright (c) 2014年 广东亿迅科技有限公司. All rights reserved.
//

#import "CTBaseViewController.h"
@class MineRightManager;
@interface RightParentVCtler : CTBaseViewController

@property(strong,nonatomic)MineRightManager *manager;
@property(strong,nonatomic)NSString *shareContent;
@property(assign,nonatomic)BOOL recommendHiden;
-(void)resetRecommend ;
-(void)showShare;
@end
