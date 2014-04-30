//
//  QryBdSpec.m
//  CTPocketV4
//
//  Created by Y W on 14-3-19.
//  Copyright (c) 2014年 广东亿迅科技有限公司. All rights reserved.
//

#import "QryBdSpec.h"


@implementation ConfigModel

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dictionary
{
    return [[ConfigModel alloc] initWithDictionary:dictionary];
}

- (id)initWithDictionary:(NSDictionary *)dictionary
{
    self = [super init];
    if (self) {
        self.Floor = [[self objectOrNilForKey:@"Floor" fromDictionary:dictionary] integerValue];
        self.SpecName = [self objectOrNilForKey:@"SpecName" fromDictionary:dictionary];
        self.SpecValue = [self objectOrNilForKey:@"SpecValue" fromDictionary:dictionary];
        self.Pid = [self objectOrNilForKey:@"Pid" fromDictionary:dictionary];
        self.Pcode = [self objectOrNilForKey:@"Pcode" fromDictionary:dictionary];
        self.PicFlag = [[self objectOrNilForKey:@"PicFlag" fromDictionary:dictionary] boolValue];
        self.PicUrl = [self objectOrNilForKey:@"PicUrl" fromDictionary:dictionary];
        self.Columns = [[self objectOrNilForKey:@"Columns" fromDictionary:dictionary] integerValue];
    }
    return self;
}

@end


@implementation QryBdSpecModel

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dictionary
{
    return [[QryBdSpecModel alloc] initWithDictionary:dictionary];
}

- (id)initWithDictionary:(NSDictionary *)dictionary
{
    self = [super init];
    if (self) {
        self.TotalCount = [[self objectOrNilForKey:@"TotalCount" fromDictionary:dictionary] integerValue];
        self.DataList = [NSMutableArray array];
        NSDictionary *DataList = [self objectOrNilForKey:@"Configs" fromDictionary:dictionary];
        id Item = [DataList objectForKey:@"Item"];
        if ([Item isKindOfClass:[NSArray class]]) {
            for (NSDictionary *dictionary in Item) {
                [self.DataList addObject:[ConfigModel modelObjectWithDictionary:dictionary]];
            }
        } else if ([Item isKindOfClass:[NSDictionary class]]) {
            [self.DataList addObject:[ConfigModel modelObjectWithDictionary:Item]];
        }
    }
    return self;
}

@end



@interface QryBdSpec ()

@property (nonatomic, strong) CserviceOperation *cserviceOperation;

@end

@implementation QryBdSpec

- (void)qryBdSpecWithSalesId:(NSString *)Id finishBlock:(RequestFinishBlock)finishBlock
{
#ifdef DEBUG
    assert(Id != nil);
#endif
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:Id forKey:@"Id"];
    
    self.cserviceOperation = [MyAppDelegate.cserviceEngine postXMLWithCode:@"qryBdSpec"
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
