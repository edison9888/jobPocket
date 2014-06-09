//
//  RightTableView_CTQueryVCtler.h
//  CTPocketV4
//
//  Created by Gong Xintao on 14-5-12.
//  Copyright (c) 2014年 广东亿迅科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

static NSString* subListTitle01[] = {
    @"话费查询#当前话费金额及可用余额#qry_subl_01.png",
    @"历史话费#近6个月的账单变化情况#qry_subl_02.png",
    @"流量查询#实时查询套餐流量变动#qry_subl_03.png",
    @"套餐查询#当前通话、流量、语音情况#qry_subl_04.png",
    @"增值业务查询#已订阅增值业务查询#qry_subl_05.png",
    @"缴费记录#清晰记录每笔交费#qry_subl_02.png",
};

static NSString* subListTitle02[] = {
    //@"在线业务办理#无需排队，多项业务快速办理#qry_subl_06.png",
    @"增值业务#彩铃/189邮箱/手机报......#qry_subl_07.png",
};

static NSString* subListTitle03[] = {
    @"积分查询#查询当前可用积分#qry_subl_12.png",
    @"积分兑换#免费兑换充值卡、流量卡#qry_subl_13.png",
    @"兑换记录#近6个月的积分兑换记录#qry_subl_14.png",
};

static NSString* subListTitle04[] = {
    @"附近wifi#热点随时找,wifi时长不浪费#wifi_near.png",
    @"周围营业厅#不走冤枉路,营业厅总在身边#yyet_near.png",
    @"小区宽带查询#光纤入户没，先来查查看#region_broadband",
};

static NSString* subListTitle05[] = {
    @"所有订单##qry_subl_08.png",
    @"待支付订单##qry_subl_09.png",
    @"待收货订单##qry_subl_10.png",
    @"已完成的订单##qry_subl_11.png",
    @"快速订单查询##qry_subl_15.png",
};



@protocol LeftTableViewDelegate;
@interface RightTableView_CTQueryVCtler : UITableView
 
@property(assign,nonatomic)int homeIndex;
@property(weak,nonatomic)id<LeftTableViewDelegate> leftTableviewDelegate;
+(instancetype)initialWithIndex:(int)index delegate:(id<LeftTableViewDelegate>)rightTableViewDelegate;
-(void)reloadWithHomeIndex:(int)index;
@end
