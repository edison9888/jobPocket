//
//  Global.m
//  xhgdzwyq
//
//  Created by apple on 13-11-23.
//  Copyright (c) 2013年 Eshore. All rights reserved.
//

#import "Global.h"
#import "EsNewsColumn.h"

@interface Global()
{
    NSMutableArray*             _newsColumns;       // 栏目列表
}

@property (nonatomic, strong) NSDictionary *    versionResult;  // 版本检测信息
@property (nonatomic, copy) void (^checkVersionCompletion)(BOOL hasNewVersion);

@property (nonatomic, copy) void (^getColumnsCompletion)(BOOL success);

@end

@implementation Global

@synthesize columns = _newsColumns;

+ (Global *)sharedSingleton
{
	static Global *sharedSingleton;
	@synchronized(self)
	{
		if (!sharedSingleton)
        {
			sharedSingleton = [[Global alloc] init];
		}
		return sharedSingleton;
	}
}

-(id)init
{
    if (self = [super init])
    {
        self.uiStyle = [EsUIStyle new];
        self.uiStyle.fontSize = 14;
        self.uiStyle.mode = UIStyleModeDay;
        self.uiStyle.originBrightness = [UIScreen mainScreen].brightness;
        self.uiStyle.brightness = self.uiStyle.originBrightness;
        
        NSUserDefaults* defaults = [NSUserDefaults standardUserDefaults];
        self.userVerify = [EsUserVerify new];
        self.userVerify.user.token = [defaults objectForKey:kLoginToken];
        self.userVerify.user.phone = [defaults objectForKey:kPhoneNumber];
    }
    return self;
}

- (void)dealloc
{
    [UIScreen mainScreen].brightness = self.uiStyle.originBrightness;
}

#pragma mark checkVersion
- (void)checkVersion:(void(^)(BOOL hasNewVersion))completion
{
    self.checkVersionCompletion = completion;
    NSDictionary * params   = [NSDictionary dictionaryWithObjectsAndKeys:
                               kAppIDInAppstore, @"id",nil];
    
    __weak typeof(self) wself = self;
    BaseDataSource* net = [BaseDataSource new];
    [net startGetRequestWithParamsAndUrl:params method:nil url:@"http://itunes.apple.com/lookup" completion:^(id responsedict)
     {
         [wself onCheckVersionFinish:responsedict];
     }];
}

- (void)onCheckVersionFinish:(id)response
{
    if ([response[@"results"] isKindOfClass:[NSArray class]] &&
        [response[@"results"] count] > 0)
    {
        self.versionResult = [response[@"results"] objectAtIndex:0];
    }
    if (self.checkVersionCompletion)
    {
        self.checkVersionCompletion([self checkHasNewVersion]);
    }
}

- (BOOL)checkHasNewVersion
{
    NSString *oldV = APP_VERSION;
    NSString * newV = [self.versionResult objectForKey:@"version"];
    if ([newV compare:oldV options:NSNumericSearch] == NSOrderedDescending)
    {
        return YES;
    }
    
    return NO;
}

- (NSString* )getUpdateUrl
{
    NSString* url = @"";
    // 更新   trackViewUrl字段
    if (self.versionResult[@"trackViewUrl"] != [NSNull null] &&
        self.versionResult[@"trackViewUrl"] != nil)
    {
        url = self.versionResult[@"trackViewUrl"];
    }
    
    return url;
}

#pragma mark getColumns
- (void)getNewsColumn:(void(^)(BOOL success))completion
{
    self.getColumnsCompletion = completion;
    _newsColumns = [NSMutableArray new];
    NSString* token = @"";
    if ([Global sharedSingleton].userVerify.user.token)
    {
        token = [Global sharedSingleton].userVerify.user.token;
    }
    
    __weak typeof(self) wself = self;
    BaseDataSource* net = [BaseDataSource new];
    [net startGetRequestWithParams:@{@"token": token} method:@"getSummary" completion:^(id responsedict)
     {
         [wself onNewsColumnFinish:net response:responsedict];
     }];
}

- (void)onNewsColumnFinish:(BaseDataSource* )net response:(id)response
{
    BOOL iserr = YES;
    do {
        if ([net.errorCode length])
        {
            break;
        }
        
        NSArray* resultlist = response[@"resultlist"];
        if (resultlist == (id)[NSNull null] ||
            resultlist == nil)
        {
            break;
        }
        
        if (resultlist.count <= 0)
        {
            break;
        }
        
        NSUserDefaults* def = [NSUserDefaults standardUserDefaults];
        NSString* key = [NSString stringWithFormat:@"%@_%@", [def stringForKey:kPhoneNumber], kPushMsgIDsNotReceive];
        NSString* ids = [def stringForKey:key];
        NSArray* rejectedArr = [ids componentsSeparatedByString:@","];
        NSMutableArray* receivedArr = [NSMutableArray new];
        
        for (NSDictionary* dict in resultlist)
        {
            EsNewsColumn* column = [[EsNewsColumn alloc] initWithDictionary:dict];
            column.receivedPushMsg = YES;
            [_newsColumns addObject:column];
            
            if ([rejectedArr containsObject:[NSString stringWithFormat:@"%@", column.catalogId]])
            {
                column.receivedPushMsg = NO;
            }
            else
            {
                [receivedArr addObject:[NSString stringWithFormat:@"%@", column.catalogId]];
            }
        }
        iserr = NO;
#if kAddLocalMode
        {
            //模拟服务器返回的数据，存到array中
            EsNewsColumn* column = [[EsNewsColumn alloc] init];
            column.catalogId = [NSNumber numberWithInt:-1];
            column.catalogName = @"工作汇报";
            column.catalogPicUrl = @"";
            column.receivedPushMsg = NO;//暂时不做推送实现
            //加到指定位置
            [_newsColumns insertObject:column atIndex:1];
            
        
        }
        
#endif
#if (kBestappSdkOpen)
        {
            // {category: "分类名", tags: ["标签名1", "标签名2", "标签名3"]}
            NSArray* tagArr = @[@{@"category" : @"栏目", @"tags" : receivedArr}];
            NSLog(@"tags: %@", tagArr);
            [Bearing setTags:tagArr];
        }
#endif
        
    } while (0);
    
    if (self.getColumnsCompletion)
    {
        self.getColumnsCompletion(!iserr);
    }
}

@end
