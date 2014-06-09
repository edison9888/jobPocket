//
//  CTContractChooseVCtler.h
//  CTPocketV4
//
//  Created by liuruxian on 13-11-19.
//  Copyright (c) 2013年 广东亿迅科技有限公司. All rights reserved.
//

#import "CTBaseViewController.h"

@interface CTContractChooseVCtler : CTBaseViewController

-(void)contractnetRequest:(NSDictionary *)dictionary contractID:(NSString*)contractID;
//-(void)getContractTypeID:(NSDictionary *)dictionary ;
-(void)setPhoneInfo:(NSDictionary *)dictionary buyType:(NSString *)buyType title :(NSString *)title;


@property (nonatomic,assign) NSDictionary   *_phoneInfo;
@property (nonatomic,assign) NSString       *_buyType;
@property (nonatomic,assign) NSString       *_contractName;
@property (nonatomic,assign) NSString       *_Title;

@property (nonatomic,assign) NSString       *_SfIdstr;//购机送费
@property (nonatomic,assign) NSString       *_BtIdstr;//存费购机

@end
