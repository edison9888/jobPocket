//
//  EsLanmuCtrl.h
//  xhgdzwyq
//  获取栏目信息的控制类
//  Created by Eshore on 13-11-7.
//  Copyright (c) 2013年 Eshore. All rights reserved.
//  
//

#import <Foundation/Foundation.h>

//从后台获取的栏目信息，包括：ID，标题，背景图片，排序
@interface EsLanmuInfo : NSObject
@property (nonatomic, strong) NSString *lanmuID;
@property (nonatomic, strong) NSString *titleText;
@property (nonatomic, strong) NSString *bgImgUrl;
@property (nonatomic) NSInteger index;

//比较两个栏目信息是否完全一致
- (BOOL) isEqualToLanmu:(EsLanmuInfo *)lanmu;
@end

@protocol lanmuArrayChangedDelegate;
@protocol userVerifyDelegate;

@class EsUserVerify;
@interface EsLanmuCtrl : NSObject
//栏目数组，用来存放从后台获取的栏目原始数据
@property (nonatomic, strong) NSMutableArray *lanmuArray;
@property (nonatomic, weak) id<lanmuArrayChangedDelegate> delegate;
@property (nonatomic, strong) EsUserVerify *userVerify;
@property (nonatomic, weak) id<userVerifyDelegate> verifyDelegate;

//从后台获取全部栏目数据
- (NSArray*)getLanmus;

//从后台获取栏目数据，得到更新后的栏目集合，观察者会据此执行相关操作：栏目view更新栏目页面现实；model类更新本地数据库保存的栏目数据
- (void)getChanges;

@end

@protocol lanmuArrayChangedDelegate <NSObject>

- (void)lanmuItemDidChanged:(EsLanmuInfo *)lanmuItem atViewIndex:(NSInteger)vIndex;
@end

@protocol userVerifyDelegate <NSObject>

- (void)tokenErr;

@end