//
//  EsNewsListNetAgent.h
//  xhgdzwyq
//
//  Created by apple on 13-12-3.
//  Copyright (c) 2013年 Eshore. All rights reserved.
//
// 新闻列表界面网络请求

#import <Foundation/Foundation.h>
#import "EsNewsColumn.h"

typedef enum NewsTableLoadingType
{
    NewsTableLoadingTypeNone = 0,
    NewsTableLoadingTypeRefresh,
    NewsTableLoadingTypeLoadingMore,
}NewsTableLoadingType;

@interface EsNewsListNetAgent : NSObject

@property (nonatomic, strong) EsNewsColumn* columnInfo;

@property (nonatomic, readonly) int      currentPage;
@property (nonatomic, readonly) int      totalPage;
@property (nonatomic, readonly) NSArray* newsList;
@property (nonatomic, readonly) NSArray* dayNewsList;
@property (nonatomic, assign) NewsTableLoadingType loadingType;

//@property (nonatomic, readonly) int      headlineCurrentPage;
//@property (nonatomic, readonly) int      headlineTotalPage;
@property (nonatomic, readonly) NSArray* newsHeadlines;

- (void)getNewsList:(int)page completion:(void(^)(void))completion;
- (void)refreshNewsList:(void(^)(void))listCompletion headlineCompletion:(void(^)(EsNewsListNetAgent* sender))headlineCompletion;

- (void)getHeadLines:(int)page completion:(void(^)(EsNewsListNetAgent* sender))completion;

@end
