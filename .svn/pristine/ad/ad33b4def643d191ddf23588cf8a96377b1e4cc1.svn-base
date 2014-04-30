//
//  QryBdSalesComInfo.m
//  CTPocketV4
//
//  Created by Y W on 14-3-18.
//  Copyright (c) 2014年 广东亿迅科技有限公司. All rights reserved.
//

#import "QryBdSalesComInfo.h"


@implementation PrestoreModel

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dictionary
{
    return [[PrestoreModel alloc] initWithDictionary:dictionary];
}

- (id)initWithDictionary:(NSDictionary *)dictionary
{
    self = [super init];
    if (self) {
        self.Code = [self objectOrNilForKey:@"Code" fromDictionary:dictionary];
        self.Name = [self objectOrNilForKey:@"Name" fromDictionary:dictionary];
        self.Amount = [[self objectOrNilForKey:@"Amount" fromDictionary:dictionary] floatValue];
        self.Tip = [self objectOrNilForKey:@"Tip" fromDictionary:dictionary];
    }
    return self;
}

@end



@implementation YckModel

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dictionary
{
    return [[YckModel alloc] initWithDictionary:dictionary];
}

- (id)initWithDictionary:(NSDictionary *)dictionary
{
    self = [super init];
    if (self) {
        self.Type = [[self objectOrNilForKey:@"Type" fromDictionary:dictionary] intValue];
        self.Default = [[self objectOrNilForKey:@"Default" fromDictionary:dictionary] boolValue];
        NSDictionary *PrestoreDictionary = [self objectOrNilForKey:@"Prestore" fromDictionary:dictionary];
        if (PrestoreDictionary) {
            self.Prestore = [PrestoreModel modelObjectWithDictionary:PrestoreDictionary];
        }
    }
    return self;
}

@end



@implementation PackageModel

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dictionary
{
    return [[PackageModel alloc] initWithDictionary:dictionary];
}

- (id)initWithDictionary:(NSDictionary *)dictionary
{
    self = [super init];
    if (self) {
        self.MinAmount = [self objectOrNilForKey:@"MinAmount" fromDictionary:dictionary];
        self.AmoutBack = [self objectOrNilForKey:@"AmoutBack" fromDictionary:dictionary];
        self.TsYy = [self objectOrNilForKey:@"TsYy" fromDictionary:dictionary];
        self.TsDx = [self objectOrNilForKey:@"TsDx" fromDictionary:dictionary];
        self.TsCx = [self objectOrNilForKey:@"TsCx" fromDictionary:dictionary];
        self.TsDcx = [self objectOrNilForKey:@"TsDcx" fromDictionary:dictionary];
        self.TsLl = [self objectOrNilForKey:@"TsLl" fromDictionary:dictionary];
        self.TsWifi = [self objectOrNilForKey:@"TsWifi" fromDictionary:dictionary];
    }
    return self;
}

@end





@implementation GiftModel

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dictionary
{
    return [[GiftModel alloc] initWithDictionary:dictionary];
}

- (id)initWithDictionary:(NSDictionary *)dictionary
{
    self = [super init];
    if (self) {
        self.GiftSalesProdId = [self objectOrNilForKey:@"GiftSalesProdId" fromDictionary:dictionary];
        self.GiftSalesProdCode = [self objectOrNilForKey:@"GiftSalesProdCode" fromDictionary:dictionary];
        self.Name = [self objectOrNilForKey:@"Name" fromDictionary:dictionary];
        self.IconUrl = [self objectOrNilForKey:@"IconUrl" fromDictionary:dictionary];
        self.Count = [self objectOrNilForKey:@"Count" fromDictionary:dictionary];
        self.Remark = [self objectOrNilForKey:@"Remark" fromDictionary:dictionary];
    }
    return self;
}

@end




@implementation PhotoAlbumModel

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dictionary
{
    return [[PhotoAlbumModel alloc] initWithDictionary:dictionary];
}

- (id)initWithDictionary:(NSDictionary *)dictionary
{
    self = [super init];
    if (self) {
        self.Defualt = [self objectOrNilForKey:@"Defualt" fromDictionary:dictionary];
        self.Url = [self objectOrNilForKey:@"Url" fromDictionary:dictionary];
    }
    return self;
}

@end





@implementation QryBdSalesComInfoModel

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dictionary
{
    return [[QryBdSalesComInfoModel alloc] initWithDictionary:dictionary];
}

- (id)initWithDictionary:(NSDictionary *)dictionary
{
    self = [super init];
    if (self) {
        self.SalesProdName = [self objectOrNilForKey:@"SalesProdName" fromDictionary:dictionary];
        self.SalesProdPicUrl = [self objectOrNilForKey:@"SalesProdPicUrl" fromDictionary:dictionary];
        self.SalesProdDisPicUrl = [self objectOrNilForKey:@"SalesProdDisPicUrl" fromDictionary:dictionary];
        self.SalesProdDisInfo = [self objectOrNilForKey:@"SalesProdDisInfo" fromDictionary:dictionary];
        self.SalesProdDisPrice = [[self objectOrNilForKey:@"SalesProdDisPrice" fromDictionary:dictionary] floatValue];
        self.SalesProdPicInfo = [self objectOrNilForKey:@"SalesProdPicInfo" fromDictionary:dictionary];
        self.WithNumber = [[self objectOrNilForKey:@"WithNumber" fromDictionary:dictionary] boolValue];
        self.Stock = [[self objectOrNilForKey:@"Stock" fromDictionary:dictionary] integerValue];
        self.PackageUrl = [self objectOrNilForKey:@"PackageUrl" fromDictionary:dictionary];
        self.MarketPrice = [self objectOrNilForKey:@"MarketPrice" fromDictionary:dictionary];
        self.SalesProdType = [[self objectOrNilForKey:@"SalesProdType" fromDictionary:dictionary] integerValue];
        self.SalesProdId = [self objectOrNilForKey:@"SalesProdId" fromDictionary:dictionary];
        self.AbType = [[self objectOrNilForKey:@"AbType" fromDictionary:dictionary] integerValue];
        
        self.Yck = [NSMutableArray array];
        
        /**
        NSDictionary *p1=@{@"Amount":@"100.0",@"Name":@"100元",@"Code":@"135010052",@"Tip":@"圣诞节方式"};
        NSDictionary *d1=@{@"Default":@"true",@"Type":@"1",@"Prestore":p1};
        [self.Yck addObject:[YckModel modelObjectWithDictionary:d1]];
        
        NSDictionary *p2=@{@"Amount":@"122.10",@"Name":@"122.10元",@"Code":@"135010034",@"Tip":@"sdfs"};
        NSDictionary *d2=@{@"Default":@"false",@"Type":@"1",@"Prestore":p2};
        [self.Yck addObject:[YckModel modelObjectWithDictionary:d2]];
        
        NSDictionary *p3=@{@"Amount":@"122.10",@"Name":@"122.10元",@"Code":@"135010034",@"Tip":@"是解放军时代雷锋精神的开发建设"};
        NSDictionary *d3=@{@"Default":@"false",@"Type":@"1",@"Prestore":p3};
        [self.Yck addObject:[YckModel modelObjectWithDictionary:d3]];
     */
         /* **/
        NSDictionary *Yck = [self objectOrNilForKey:@"Yck" fromDictionary:dictionary];
        id Item = [Yck objectForKey:@"Item"];
         
        if ([Item isKindOfClass:[NSArray class]]) {
            for (NSDictionary *dictionary in Item) {
                [self.Yck addObject:[YckModel modelObjectWithDictionary:dictionary]];
            }
        } else if ([Item isKindOfClass:[NSDictionary class]]) {
            [self.Yck addObject:[YckModel modelObjectWithDictionary:Item]];
        } 
   
        
        NSDictionary *PackageDictionary = [self objectOrNilForKey:@"Package" fromDictionary:dictionary];
        if (PackageDictionary) {
            self.Package = [PackageModel modelObjectWithDictionary:PackageDictionary];
        }
        
        self.Gifts = [NSMutableArray array];
        NSDictionary *Gifts = [self objectOrNilForKey:@"Gifts" fromDictionary:dictionary];
        id Item1 = [Gifts objectForKey:@"Item"];
        if ([Item1 isKindOfClass:[NSArray class]]) {
            for (NSDictionary *dictionary in Item1) {
                [self.Gifts addObject:[GiftModel modelObjectWithDictionary:dictionary]];
            }
        } else if ([Item1 isKindOfClass:[NSDictionary class]]) {
            [self.Gifts addObject:[GiftModel modelObjectWithDictionary:Item1]];
        }
        
        self.PhotoAlbumList = [NSMutableArray array];
        NSDictionary *PhotoAlbumList = [self objectOrNilForKey:@"PhotoAlbum" fromDictionary:dictionary];
        id Item2 = [PhotoAlbumList objectForKey:@"Item"];
        if ([Item2 isKindOfClass:[NSArray class]]) {
            for (NSDictionary *dictionary in Item2) {
                [self.PhotoAlbumList addObject:[PhotoAlbumModel modelObjectWithDictionary:dictionary]];
            }
        } else if ([Item2 isKindOfClass:[NSDictionary class]]) {
            [self.PhotoAlbumList addObject:[PhotoAlbumModel modelObjectWithDictionary:Item2]];
        }
    }
    return self;
}

@end



@interface QryBdSalesComInfo ()

@property (nonatomic, strong) CserviceOperation *cserviceOperation;

@end

@implementation QryBdSalesComInfo

- (void)qryBdSalesComInfoWithSalesId:(NSString *)saleId finishBlock:(RequestFinishBlock)finishBlock
{
#ifdef DEBUG
    assert(saleId != nil);
#endif
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:saleId forKey:@"Id"];
    
    self.cserviceOperation = [MyAppDelegate.cserviceEngine postXMLWithCode:@"qryBdSalesComInfo"
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
