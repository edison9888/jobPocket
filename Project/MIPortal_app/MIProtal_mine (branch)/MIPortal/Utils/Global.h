//
//  Global.h
//  xhgdzwyq
//
//  Created by apple on 13-11-23.
//  Copyright (c) 2013年 Eshore. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EsUIStyle.h"

@interface Global : NSObject

@property (nonatomic, strong) EsUserVerify*     userVerify;
@property (nonatomic, strong) EsUIStyle*        uiStyle;
@property (nonatomic, readonly) NSArray*        columns;    // 栏目列表
@property (nonatomic, readonly, getter=getUpdateUrl) NSString*       updateUrl;  // 更新链接

@property (nonatomic, strong) NSString *parentModes;//分享到哪些项目
@property (nonatomic, strong) NSString *chooseModes;//选择了哪些项目
@property (nonatomic, ) int photoNum;        // 定义的图片数量

@property (nonatomic, strong) NSArray*  myVisibleModes;  //个人信息首页动态显示模块(暂无，固定写)

@property (nonatomic, strong) NSString *slefIcon;       // 个人头像

+ (Global *)sharedSingleton;

- (void)checkVersion:(void(^)(BOOL hasNewVersion))completion;
- (BOOL)checkHasNewVersion;

- (void)getNewsColumn:(void(^)(BOOL success))completion;

@end
