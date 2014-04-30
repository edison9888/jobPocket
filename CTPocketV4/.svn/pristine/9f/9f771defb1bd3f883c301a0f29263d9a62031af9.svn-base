//
//  CTPrettyNum_Model.h
//  CTPocketV4
//
//  Created by liuruxian on 14-1-9.
//  Copyright (c) 2014年 广东亿迅科技有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CTPrettyNumData :  NSObject <NSCoding>

@property (nonatomic, strong) NSString *PhoneNumber;  //号码
@property (nonatomic, strong) NSString *PrepayMent;   //预存款
@property (nonatomic, strong) NSString *Status;       //号码状态
@property (nonatomic, strong) NSString *MinAmount;    //保底金额
@property (nonatomic, strong) NSString *SalesProdId;  //销售品ID
@property (nonatomic, strong) NSString *Level;        //号码级别
@property (nonatomic, strong) NSString *TipText;      //靓号特征
@property (nonatomic, strong) NSString *HlStart;      //高亮开始位置
@property (nonatomic, strong) NSString *HlEnd;        //高亮结束位置
@property (nonatomic, strong) NSString *Province;     //所属市省名称
@property (nonatomic, strong) NSString *City;         //所属市名称
@property (nonatomic, strong) NSString *ProvinceCode; //所属省编码
@property (nonatomic, strong) NSString *CityCode;     //所属市编码
@property (nonatomic, strong) NSString *isCollected ;//收藏
@property (nonatomic, strong) NSString *TypeId ;        //类型
@property (nonatomic, strong) NSString *SpecialOffers;

+ (CTPrettyNumData *)modelObjectWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
