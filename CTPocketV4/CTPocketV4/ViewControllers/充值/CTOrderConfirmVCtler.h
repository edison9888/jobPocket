//
//  CTOrderConfirmVCtler.h
//  CTPocketV4
//
//  Created by apple on 13-11-8.
//  Copyright (c) 2013年 广东亿迅科技有限公司. All rights reserved.
//

#import "CTBaseViewController.h"


typedef enum PAGETYPE{
    CONFIRMPAGE = 0,  //确认页
    BUYCARDCOMFIRMPAGE,
    BANKPAGE,
    CARDPAGE,
    BUTCARDPAGE
}PageType;


@interface CTOrderConfirmVCtler : CTBaseViewController


@property (nonatomic, assign) int pageType ;
@property (nonatomic, strong) NSMutableDictionary *rechargeInfoDict;
@property (nonatomic, assign) int rechargeType ; //充值类型  话费还是流量
@property (nonatomic,assign)  PageType page;

//订单信息  银行卡 和  流量卡信息
@property (nonatomic, strong) NSMutableDictionary *orderInfo ;
//@property (nonatomic, strong) NSMutableDictionary *flowsInfoDict;

@end
