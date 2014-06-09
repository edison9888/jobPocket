/*--------------------------------------------
 *Name：EsMineDetailViewCtler.h
 *Desc：我的界面详情模块
 *Date：2014/06/06
 *Auth：shanhq
 *--------------------------------------------*/

#import "BaseViewCtler.h"
#import "EsNewsColumn.h"

@interface EsMineDetailViewCtler : BaseViewCtler

@property (nonatomic, strong) EsNewsColumn* columnInfo;
@property (nonatomic) int currentPage;
@property (nonatomic) NSString* pageSize;
@property (nonatomic) NSInteger selectTag;

@end
