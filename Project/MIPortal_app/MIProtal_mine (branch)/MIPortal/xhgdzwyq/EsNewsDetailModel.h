//
//  EsNewsDetailModel.h
//  xhgdzwyq
//
//  Created by apple on 13-11-24.
//  Copyright (c) 2013年 Eshore. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EsNewsDetailModel : JsonModel

@property (nonatomic, strong) NSNumber* newsId;
@property (nonatomic, strong) NSString* newsTitle;
@property (nonatomic, strong) NSString* newsContent;
@property (nonatomic, assign) NSString* isHead;         // 是否头条
@property (nonatomic, strong) NSString* headPicUrl;
@property (nonatomic, strong) NSString* verifyDate;     // 发布时间
@property (nonatomic, strong) NSString* newsSummary;
@property (nonatomic, strong) NSString* createUserName;       // 作者名字

@end
