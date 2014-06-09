//
//  EsNewsItem.h
//  xhgdzwyq
//
//  Created by apple on 13-11-28.
//  Copyright (c) 2013年 Eshore. All rights reserved.
//

#import "JsonModel.h"

@interface EsNewsItem : JsonModel

@property (nonatomic, strong) NSNumber* newsId;
@property (nonatomic, strong) NSString* newsTitle;
@property (nonatomic, strong) NSString* newsSummary;
@property (nonatomic, strong) NSString* isHead;         // 是否头条 0：不是1：是头条，为空则全部
@property (nonatomic, strong) NSString* verifyDate;
@property (nonatomic, strong) NSString* headPicUrl;
@property (nonatomic, assign) BOOL      readed;         // 是否忆读：0：未读，1：已读

@end

@interface EsDayNews : JsonModel

@property (nonatomic, strong) NSString* verifyDate;
@property (nonatomic, strong) NSString* week;
@property (nonatomic, strong) NSMutableArray*   news;

@end