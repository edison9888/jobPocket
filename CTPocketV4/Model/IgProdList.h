//
//  IgProdList.h
//  CTPocketV4
//
//  Created by Y W on 14-3-11.
//  Copyright (c) 2014年 广东亿迅科技有限公司. All rights reserved.
//  商品信息查询

#import "BaseModel.h"

@interface IgProdList : BaseModel

- (void)igProdListWith:(NSUInteger)PageIndex PageSize:(NSUInteger)PageSize Sort:(NSUInteger)Sort MinPrice:(NSUInteger)MinPrice MaxPrice:(NSUInteger)MaxPrice CommdityId:(NSString *)CommdityId KeyWord:(NSString *)KeyWord CategoryId:(NSString *)CategoryId SmallCategoryId:(NSString *)SmallCategoryId finishBlock:(RequestFinishBlock)finishBlock;

@end
