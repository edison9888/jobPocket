//
//  CTContractOrderConfirmVCtler.h
//  CTPocketV4
//
//  Created by Mac-Eshore-01 on 14-3-26.
//  Copyright (c) 2014年 广东亿迅科技有限公司. All rights reserved.
//

// 百搭品订单确认

#import "CTBaseViewController.h"

@interface CTContractOrderConfirmVCtler : CTBaseViewController
@property(nonatomic,strong)NSDictionary* selRecipientDict;
@property(nonatomic,strong)NSString* uName;
@property(nonatomic,strong)NSString* uID;
@property(nonatomic,strong)NSString* uAddress;
@property(nonatomic,strong)NSString* uPostCode;
@property (nonatomic, strong) NSDictionary *info;

// 发票接口属性
@property(nonatomic, strong)NSString* InvoiceType;        //发票类型
@property(nonatomic, strong)NSString* InvoiceContentType; //发票内容
@property(nonatomic, strong)NSString* InvoiceInfo;        //发票抬头
@property(nonatomic, strong)NSString* InvoiceInfoType;    //发票抬头类型

//订单接口
//@property(nonatomic, strong)NSString* OrderId;            //订单ID

//生成订单手机详情属性名
@property(nonatomic, strong)NSString* SalesName;           //订单商品名
@property(nonatomic, strong)NSString* Phone;               //入网号码
@property(nonatomic, strong)NSString* ContractDescription;            //合约内容
@property(nonatomic, strong)NSString* MinAmount;           //最低消费
@property(nonatomic, strong)NSString* ComboDescription;             //套餐类型
@property(nonatomic, strong)NSString* PrestoreNames ;          // 现金预存款


//订单生成接口
@property(nonatomic, strong)NSString* SalesProdId;       //销售品ID
@property(nonatomic, strong)NSString* PhoneNumber;          //手机号码 即入网号码
@property (nonatomic, assign) NSUInteger AbType;            //销售品AB类型
@property (nonatomic, assign) NSUInteger SalesProdType; //必现    销售品类型

@property (nonatomic, assign) BOOL BareMetal;   // 是否是裸机

@end
