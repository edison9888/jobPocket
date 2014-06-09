/*--------------------------------------------
 *Name：EsMineListNetAgent.h
 *Desc：我的界面详情模块网络请求
 *Date：2014/06/06
 *Auth：shanhq
 *--------------------------------------------*/

#import <Foundation/Foundation.h>

#import "EsNewsColumn.h"
#import "EsNewsListNetAgent.h"

@interface EsMineListNetAgent : NSObject

@property (nonatomic) int      currentPage;
@property (nonatomic, readonly) int      pageSize;
@property (nonatomic, readonly) int      totalPage;
@property (nonatomic, readonly) NSArray* newsList;
@property (nonatomic, readonly) NSArray* dayNewsList;
@property (nonatomic, readonly) NSArray* reportList;
@property (nonatomic, assign) NewsTableLoadingType loadingType;

@property (nonatomic, readonly) NSArray* newsHeadlines;

@property (nonatomic, strong) NSDictionary *params;
@property (nonatomic, strong) NSString *method;

- (void)setParams:(NSDictionary *)params
       andSetMethod:(NSString*)method
         completion:(void (^)(void))completion;
- (void)refreshNewsList:(void(^)(void))listCompletion headlineCompletion:(void(^)(EsMineListNetAgent* sender))headlineCompletion;

@end
