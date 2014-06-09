//
//  EsNewsListCtrl.h
//  xhgdzwyq
//
//  Created by Eshore on 13-11-17.
//  Copyright (c) 2013年 Eshore. All rights reserved.
//

#import <Foundation/Foundation.h>

//从后台获取的栏目新闻列表信息信息，包括：ID，标题，摘要，焦点标志，背景图片
@interface EsNewsInfo : NSObject
@property (nonatomic, strong) NSString *newsID;
@property (nonatomic, strong) NSString *titleText;
@property (nonatomic, strong) NSString *summaryText;
@property (nonatomic) BOOL bImgable;
@property (nonatomic, strong) NSString *bgImgUrl;
@property (nonatomic, strong) NSString *releaseDate;

@end

@class EsUserVerify;
@interface EsNewsListCtrl : NSObject

//栏目数组，用来存放从后台获取的栏目原始数据
@property (nonatomic, strong) NSMutableArray *newsArray;
@property (nonatomic, strong) EsUserVerify *userVerify;

//从后台获取几条新闻
- (NSArray*)getNewsList:(NSInteger)num; //num表示取几条新闻

@end