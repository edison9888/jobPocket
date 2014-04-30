//
//  FilterSlsPrdList.m
//  CTPocketV4
//
//  Created by Y W on 14-3-24.
//  Copyright (c) 2014年 广东亿迅科技有限公司. All rights reserved.
//

#import "FilterSlsPrdList.h"

#import "Utils.h"
@implementation FilterSlsPrdListModel

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dictionary
{
    return [[FilterSlsPrdListModel alloc] initWithDictionary:dictionary];
}

- (id)initWithDictionary:(NSDictionary *)dictionary
{
    self = [super init];
    if (self) {
        self.TotalCount = [[self objectOrNilForKey:@"TotalCount" fromDictionary:dictionary] integerValue];
        self.DataList = [NSMutableArray array];
        NSDictionary *Items = [self objectOrNilForKey:@"Items" fromDictionary:dictionary];
        id Item = [Items objectForKey:@"Item"];
        if ([Item isKindOfClass:[NSArray class]]) {
            for (NSDictionary *ItemsDictionary in Item) {
                [self.DataList addObject:[QryBdSalesComInfoModel modelObjectWithDictionary:ItemsDictionary]];
            }
        } else if ([Item isKindOfClass:[NSDictionary class]]) {
            [self.DataList addObject:[QryBdSalesComInfoModel modelObjectWithDictionary:Item]];
        }
    }
    return self;
}

@end








@interface FilterSlsPrdList ()

@property (nonatomic, strong) CserviceOperation *cserviceOperation;

@end

@implementation FilterSlsPrdList

- (void)filterSlsPrdListWithSortby:(PhoneSortType)Sortby Type:(PhoneType)Type Index:(NSUInteger)Index PageSize:(NSUInteger)PageSize KeyWord:(NSString *)KeyWord finishBlock:(RequestFinishBlock)finishBlock
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:ESHORE_ShopId forKey:@"ShopId"];
    
    if (Sortby) {
        [params setObject:[NSNumber numberWithUnsignedInteger:Sortby] forKey:@"Sortby"];
    }
    
    if (KeyWord) {
        NSString *encodeParam=[Utils encodedURLParameterString:KeyWord] ;
        [params setObject:encodeParam forKey:@"KeyWord"];
    }
    
    if (Type != PhoneTypeAll) {
        [params setObject:[NSNumber numberWithUnsignedInt:Type] forKey:@"Type"];
    }
    [params setObject:[NSNumber numberWithUnsignedInt:Index] forKey:@"Index"];
    [params setObject:[NSNumber numberWithUnsignedInt:PageSize] forKey:@"PageSize"];
    
    self.cserviceOperation = [MyAppDelegate.cserviceEngine postXMLWithCode:@"filterSlsPrdList"
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
