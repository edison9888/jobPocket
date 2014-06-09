//
//  EsNewsColumn.h
//  xhgdzwyq
//
//  Created by apple on 13-11-28.
//  Copyright (c) 2013年 Eshore. All rights reserved.
//

#import "JsonModel.h"

@interface EsNewsColumn : JsonModel

@property (nonatomic, strong) NSNumber* catalogId;
@property (nonatomic, strong) NSString* catalogName;
@property (nonatomic, strong) NSString* catalogPicUrl;
@property (nonatomic, strong) NSString* updateTime;
@property (nonatomic, assign) BOOL receivedPushMsg;     // 是否接收推送通知

@end
