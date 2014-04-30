//
//  QryBdSalesComInfo.h
//  CTPocketV4
//
//  Created by Y W on 14-3-18.
//  Copyright (c) 2014年 广东亿迅科技有限公司. All rights reserved.
//

#import "BaseModel.h"


@interface PrestoreModel : BaseModelObject

@property (nonatomic, strong) NSString *Code;  //必现   现金预存款编码
@property (nonatomic, strong) NSString *Name;  //必现   现金预存款名称
@property (nonatomic, assign) CGFloat Amount;  //必现   现金预存款金额
@property (nonatomic, strong) NSString *Tip;   //必现   现金预存款促销语

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dictionary;

@end


@interface YckModel : BaseModelObject

@property (nonatomic, strong) PrestoreModel *Prestore;  //必现  现金预存款信息结构体
@property (nonatomic, assign) NSUInteger Type;          //必现  类型，取值：1:现金预存  2:现金补贴
@property (nonatomic, assign) BOOL Default;             //必现  是否默认勾选

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dictionary;

@end



@interface PackageModel : BaseModelObject

@property (nonatomic, strong) NSString *MinAmount;        //非必现  每月最低消费金额
@property (nonatomic, strong) NSString *AmoutBack;        //非必现  每月返还金额
@property (nonatomic, strong) NSString *TsYy;             //非必现  套餐包含语音
@property (nonatomic, strong) NSString *TsDx;             //非必现  套餐包含短信
@property (nonatomic, strong) NSString *TsCx;             //非必现  套餐包含彩信
@property (nonatomic, strong) NSString *TsDcx;            //非必现  套餐包含短彩信
@property (nonatomic, strong) NSString *TsLl;             //非必现  套餐包含流量
@property (nonatomic, strong) NSString *TsWifi;           //非必现  套餐包含wifi时长

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dictionary;

@end


@interface GiftModel : BaseModelObject

@property (nonatomic, strong) NSString *GiftSalesProdId;    //必现  赠品销售品ID
@property (nonatomic, strong) NSString *GiftSalesProdCode;  //必现  赠品销售品编码
@property (nonatomic, strong) NSString *Name;               //必现  赠品名称
@property (nonatomic, strong) NSString *IconUrl;            //必现  赠品图片URL
@property (nonatomic, strong) NSString *Count;              //必现  该赠品数量
@property (nonatomic, strong) NSString *Remark;             //必现  赠品备注信息

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dictionary;

@end


@interface PhotoAlbumModel : BaseModelObject

@property (nonatomic, strong) NSString *Defualt;            //必现  是否为默认图片（图标，ture：是 false：否）。
@property (nonatomic, strong) NSString *Url;                //必现  图片URL。

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dictionary;

@end


@interface QryBdSalesComInfoModel : BaseModelObject

@property (nonatomic, strong) NSString *SalesProdName;           //必现    销售品名称
@property (nonatomic, strong) NSString *SalesProdPicUrl;        //必现    销售品图标URL
@property (nonatomic, strong) NSString *SalesProdDisPicUrl;      //非必现  销售品图标右上角的优惠信息小图标
@property (nonatomic, strong) NSString *SalesProdDisInfo;        //非必现  销售品促销优惠信息 
@property (nonatomic, assign) float SalesProdDisPrice;           //必现    销售品促销价（销售价格）
@property (nonatomic, strong) NSString *SalesProdPicInfo;         //必现    销售品图文详情，多个图片URL，使用分号“;” 间隔。
@property (nonatomic, assign) BOOL WithNumber;          //必现    是否包含号码 true:是 false:否
@property (nonatomic, assign) NSUInteger Stock;         //必现    库存量
@property (nonatomic, strong) NSString *PackageUrl;	//非必现  销售品关联套餐信息URL
@property (nonatomic, strong) NSString *MarketPrice;    //必现    同销售品市场价格
@property (nonatomic, assign) NSUInteger SalesProdType; //必现    销售品类型，具体类型值参考附录中的数据类型规范。
@property (nonatomic, strong) NSString *SalesProdId;     //必现    销售品ID
@property (nonatomic, assign) NSUInteger AbType;        //必现    销售品AB类型
@property (nonatomic, assign) NSUInteger SalesProdZt;   //必现    销售状态：0:普通  1:收费预约  2:缺货登记
@property (nonatomic, strong) NSMutableArray *Yck;            //必现 预存款信息，只能包含1个Item
@property (nonatomic, strong) PackageModel *Package;    //非必现  销售品关联合约套餐简介
@property (nonatomic, strong) NSMutableArray *Gifts;           //非必现  销售品附带赠品数组，可能包含多个GiftItem。
@property (nonatomic, strong) NSMutableArray *PhotoAlbumList;	//必现    销售品图册，可能包含多个图册Item。

//filterSlsPrdList 接口的库存量
@property (nonatomic, assign) NSUInteger Kc;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dictionary;

@end


@interface QryBdSalesComInfo : BaseModel

- (void)qryBdSalesComInfoWithSalesId:(NSString *)saleId finishBlock:(RequestFinishBlock)finishBlock;

@end
