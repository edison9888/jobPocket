//
//  CTQryCollected.h
//  CTPocketV4
//
//  Created by liuruxian on 14-1-10.
//  Copyright (c) 2014年 广东亿迅科技有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CTPrettyNumData.h"
#import "CTQryCollected_Model.h"

typedef void (^QryCollectedFileFinishedBlock) (CTQryCollected_Model *data , NSError *error);


@interface CTQryCollected : NSObject

@property (nonatomic, strong) NSMutableArray *collectedMutableDict;
+ (CTQryCollected *)shareQryCollected ;
- (void) qryCollectedNumFinishBlock : (QryCollectedFileFinishedBlock)finishBlock;
- (void) qrycollectedWithDictionary ;
- (void)saveCacheArea ;
- (void)loadCacheArea;
- (void)clearFileData;

@end
