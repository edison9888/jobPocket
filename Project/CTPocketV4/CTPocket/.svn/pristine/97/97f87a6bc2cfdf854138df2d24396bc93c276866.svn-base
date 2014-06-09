//
//  IgProdList.m
//  CTPocketV4
//
//  Created by Y W on 14-3-11.
//  Copyright (c) 2014年 广东亿迅科技有限公司. All rights reserved.
//

#import "IgProdList.h"

@interface IgProdList ()

@property (nonatomic, strong) CserviceOperation *cserviceOperation;

@end


@implementation IgProdList

- (void)igProdListWith:(NSUInteger)PageIndex PageSize:(NSUInteger)PageSize Sort:(NSUInteger)Sort MinPrice:(NSUInteger)MinPrice MaxPrice:(NSUInteger)MaxPrice CommdityId:(NSString *)CommdityId KeyWord:(NSString *)KeyWord CategoryId:(NSString *)CategoryId SmallCategoryId:(NSString *)SmallCategoryId finishBlock:(RequestFinishBlock)finishBlock
{
    [self cancel];
    
#if DEBUG
    assert(Sort < 5);
#endif
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:[NSNumber numberWithUnsignedInt:PageIndex] forKey:@"PageIndex"];
    [params setObject:[NSNumber numberWithUnsignedInt:PageSize] forKey:@"PageSize"];
    [params setObject:[NSNumber numberWithUnsignedInt:Sort] forKey:@"Sort"];
    [params setObject:[NSNumber numberWithUnsignedInt:MinPrice] forKey:@"MinPrice"];
    [params setObject:[NSNumber numberWithUnsignedInt:MaxPrice] forKey:@"MaxPrice"];
    if (CommdityId.length > 0) {
        [params setObject:CommdityId forKey:@"CommdityId"];
    }
    if (KeyWord.length > 0) {
        [params setObject:KeyWord forKey:@"KeyWord"];
    }
    if (CategoryId.length > 0) {
        [params setObject:CategoryId forKey:@"CategoryId"];
    }
    if (SmallCategoryId.length > 0) {
        [params setObject:SmallCategoryId forKey:@"SmallCategoryId"];
    }
    
    
    self.cserviceOperation = [MyAppDelegate.cserviceEngine postXMLWithCode:@"igProdList"
                                           params:params
                                      onSucceeded:^(NSDictionary *dict) {
                                          if (finishBlock) {
                                              finishBlock(dict, nil);
                                          }
                                      } onError:^(NSError *engineError) {
                                          if (finishBlock) {
                                              finishBlock(nil, engineError);
                                          }
                                      }];
}

- (void)cancel
{
    if (self.cserviceOperation) {
        [self.cserviceOperation cancel];
        self.cserviceOperation = nil;
    }
}
@end
