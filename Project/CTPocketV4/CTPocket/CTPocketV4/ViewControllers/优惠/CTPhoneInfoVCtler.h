//
//  CTPhoneInfoVCtler.h
//  CTPocketV4
//
//  Created by liuruxian on 13-11-19.
//  Copyright (c) 2013年 广东亿迅科技有限公司. All rights reserved.
//

#import "CTBaseViewController.h"
#import "CTContractPhoneVCtler.h"

@interface CTPhoneInfoVCtler : CTBaseViewController <ContractPhoneInfoDelegate>

@property (nonatomic,assign) int _pageType ;
@property (nonatomic,strong)    NSString       *_SfIdstr;//购机送费
@property (nonatomic,strong)    NSString       *_BtIdstr;//存费购机
//-(void)InitImageview:(int)pageType Info:(NSDictionary *)dictionary;
-(void)ChoosePage:(int)page Info:(NSDictionary*)dictionary UsrID:(NSString *)usrID;
- (void) setPhoneInfo : (NSDictionary *) dictionary : (int) page;

@end
