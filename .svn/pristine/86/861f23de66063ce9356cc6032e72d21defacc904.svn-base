//
//  CTQryCity.m
//  CTPocketV4
//
//  Created by liuruxian on 14-1-12.
//  Copyright (c) 2014年 广东亿迅科技有限公司. All rights reserved.
//

#import "CTQryCity.h"

@interface CTQryCity ()

@property (nonatomic, strong) CTQryCity_Model *model;

@end

@implementation CTQryCity

+(CTQryCity *)shareQryCity
{
    static CTQryCity *shareQryCity = nil;
    static dispatch_once_t onceToken ;
    dispatch_once(&onceToken,^{
        shareQryCity = [[CTQryCity alloc] init];
    });
    
    return shareQryCity;
}

- (void) qryCityFinishBlock : (QryCityFinishBlock) finishBlock
{
    if(self.model){
        if (finishBlock) {
            finishBlock(self.model,nil);
        }
        return ;
    }
    
    NSArray *cityarray = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"city" ofType:@"plist"]];
    if (cityarray) {
        self.model = [CTQryCity_Model modelObjectWithDictionary:[NSDictionary dictionaryWithObject:cityarray forKey:kQryCityModel_CityModel]];
        if (finishBlock) {
            finishBlock(self.model,nil);
            return;
        }else{
            if (finishBlock) {
                finishBlock(nil,[self errorWithLocalizedDescription:@"加载城市失败"]);
            }
        }
    }
}

- (NSError *)errorWithLocalizedDescription:(NSString *)localizedDescription
{
    if (localizedDescription == nil || ![localizedDescription isKindOfClass:[NSString class]]) {
        return nil;
    }
    
    NSDictionary *userInfo = [NSDictionary dictionaryWithObjectsAndKeys:localizedDescription, NSLocalizedDescriptionKey, nil];
    return [NSError errorWithDomain:localizedDescription code:-1 userInfo:userInfo];
}


@end
