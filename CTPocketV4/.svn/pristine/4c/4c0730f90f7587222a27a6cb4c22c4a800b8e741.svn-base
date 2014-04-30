//
//  CTQryCollected.m
//  CTPocketV4
//
//  Created by liuruxian on 14-1-10.
//  Copyright (c) 2014年 广东亿迅科技有限公司. All rights reserved.
//

#import "CTQryCollected.h"
#import "CTQryCollected_Model.h"
#import "Utils.h"

@interface CTQryCollected ()
{
    
}
@property (nonatomic, strong) CTQryCollected_Model *model;

@end


@implementation CTQryCollected

//单列模式
+ (CTQryCollected *) shareQryCollected
{
    static CTQryCollected *shareQryCollected = nil ;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken,^(){
        shareQryCollected = [[CTQryCollected alloc] init];
    });
    return shareQryCollected;
}

#pragma mark - block

- (void) qryCollectedNumFinishBlock : (QryCollectedFileFinishedBlock)finishBlock
{
    if (self.model) {
        if (finishBlock) {
            finishBlock(self.model,nil);
        }
        return ;
    }
    //查询收藏文件 (用户名为key 收藏链表为value)
}

- (void) qrycollectedWithDictionary
{
    //查询收藏文件 (用户名为key 收藏链表为value)
    [self loadCacheArea];
}

#pragma mark - fun

- (void)clearFileData
{
    NSMutableArray *dit = [NSMutableArray array];
    NSString * path = [[self getDocumentFolderByName:nil] stringByAppendingPathComponent:CTP_SAVE_COLLECT_LIST];
    BOOL ret = [dit writeToFile:path atomically:YES];
    NSLog(@"save area %d", ret);
}


- (NSString *)description
{
    return [NSString stringWithFormat:@"%@",self.collectedMutableDict];
}

- (void)saveCacheArea
{
    // 缓存到本地
    NSString * path = [[self getDocumentFolderByName:nil] stringByAppendingPathComponent:CTP_SAVE_COLLECT_LIST];
    BOOL ret = [self.collectedMutableDict writeToFile:path atomically:YES];
    NSLog(@"save area %d", ret);
}

- (void)loadCacheArea 
{
    NSString * path = [[self getDocumentFolderByName:nil] stringByAppendingPathComponent:CTP_SAVE_COLLECT_LIST];
    NSFileManager* fileMgr = [NSFileManager defaultManager];
    BOOL isDir = NO;
    if ([fileMgr fileExistsAtPath:path isDirectory:&isDir])
    {
        self.collectedMutableDict = [[NSMutableArray alloc] initWithContentsOfFile:path];
    }
    else{
        self.collectedMutableDict = [NSMutableArray array];
    }
}

-(NSString *) getDocumentFolderByName:(NSString *)foldername
{
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
                                                         NSUserDomainMask,
                                                         YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    if ([foldername length])
    {
        documentsDirectory = [documentsDirectory stringByAppendingPathComponent:foldername];
    }
    
    NSFileManager* fileMgr = [NSFileManager defaultManager];
    BOOL isDir = YES;
    if (![fileMgr fileExistsAtPath:documentsDirectory isDirectory:&isDir])
    {
        [fileMgr createDirectoryAtPath:documentsDirectory withIntermediateDirectories:YES attributes:nil error:nil];
    }
    
    return documentsDirectory;
}

@end
