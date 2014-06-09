//
//  QryBdSpec.h
//  CTPocketV4
//
//  Created by Y W on 14-3-19.
//  Copyright (c) 2014年 广东亿迅科技有限公司. All rights reserved.
//

#import "BaseModel.h"

@interface ConfigModel : BaseModelObject

@property (nonatomic, assign) NSUInteger Floor;     //必现   虚拟楼层
@property (nonatomic, strong) NSString *SpecName;   //必现   规格名称（如：颜色、内存、厚度）
@property (nonatomic, strong) NSString *SpecValue;	//必现   规格值（如：黑、16G、15mm）
@property (nonatomic, strong) NSString *Pid;        //必现   销售品ID
@property (nonatomic, strong) NSString *Pcode;      //必现   销售品编码
@property (nonatomic, assign) BOOL PicFlag;         //必现   规格图片有无  true:有  false:无
@property (nonatomic, strong) NSString *PicUrl;     //必现   规格图片地址
@property (nonatomic, assign) NSUInteger Columns;  //必现   该楼层一行最多展示多少个规格，如果超出该数值需要折行显示楼层

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dictionary;

@end


@interface QryBdSpecModel : BaseModelObject

@property (nonatomic, assign) NSUInteger TotalCount;        //必现   返回数据总条数
@property (nonatomic, strong) NSMutableArray *DataList;     //必现   销售品列表数据，可能包含多个Config对象

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dictionary;

@end


@interface QryBdSpec : BaseModel

- (void)qryBdSpecWithSalesId:(NSString *)Id finishBlock:(RequestFinishBlock)finishBlock;

@end
