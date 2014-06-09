//
//  FilterSlsPrdList.h
//  CTPocketV4
//
//  Created by Y W on 14-3-24.
//  Copyright (c) 2014年 广东亿迅科技有限公司. All rights reserved.
//  筛选百搭销售品

#import "BaseModel.h"

#import "QryBdSalesComInfo.h"

/*
 *Sortby 排序条件：
 *1 按照销量升序
 *2 按照销量降序
 *3 按照价格升序
 *4 按照价格降序
 *5 按照套餐金额升序
 *6 按照套餐金额降序
 */

typedef NS_ENUM(NSUInteger, PhoneSortType) {
    PhoneSortTypeSalesAsc = 1,
    PhoneSortTypeSalesDes,
    PhoneSortTypePriceAsc,
    PhoneSortTypePriceDes,
    PhoneSortTypePackageAsc,
    PhoneSortTypePackageDes
};


@interface FilterSlsPrdListModel : BaseModelObject

@property (nonatomic, assign) NSUInteger TotalCount;
@property (nonatomic, strong) NSMutableArray *DataList;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dictionary;

@end


//Type 裸机 1、合约机 8、混合(不传)
typedef NS_ENUM(NSUInteger, PhoneType) {
    PhoneTypeAll = 0,
    PhoneTypeContract = 8,
    PhoneTypeNude = 1
};

@interface FilterSlsPrdList : BaseModel

- (void)filterSlsPrdListWithSortby:(PhoneSortType)Sortby Type:(PhoneType)Type Index:(NSUInteger)Index PageSize:(NSUInteger)PageSize KeyWord:(NSString *)KeyWord finishBlock:(RequestFinishBlock)finishBlock;

@end
