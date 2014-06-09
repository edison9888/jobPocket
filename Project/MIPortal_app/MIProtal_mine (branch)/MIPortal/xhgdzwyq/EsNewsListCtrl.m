//
//  EsNewsListCtrl.m
//  xhgdzwyq
//
//  Created by Eshore on 13-11-17.
//  Copyright (c) 2013年 Eshore. All rights reserved.
//

#import "EsNewsListCtrl.h"
#import "EsNetworkPredefine.h"
#import "EsUserVerify.h"

@implementation EsNewsInfo

@end

@implementation EsNewsListCtrl

- (id)init
{
    self = [super init];
    if (self) {
        _userVerify = [[EsUserVerify alloc] init];
    }
    return self;
}

//从后台获取几条新闻
- (NSArray*)getNewsList:(NSInteger)num //num表示取几条新闻
{
    //获取新闻
    NSError *error;
    //获取新闻接口url
    NSString *getNewsListUrl = [NSString stringWithFormat:@"%@?method=getNewsList&token=%@&isHead=%d&catalogId=%d&currentPage=%d&pageSize=%d", IURL, [self.userVerify getToken], NO, 1, 1, num];
//    http://ip:port/news/iface.htm?method=getNewsList&token=【token值】&isHead=0&catalogId=1&currentPage=1&pageSize=10

    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:getNewsListUrl]];
    //向后台请求栏目数据
    NSData *response = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    if (nil == response) {
        //没有数据，可能是网络不通之类的
        //err log
        return nil;
    }
    NSDictionary *newsListDic = [NSJSONSerialization JSONObjectWithData:response options:NSJSONReadingMutableLeaves error:&error];
#warning wensj getSummary 消息，在获取成功时errorcode是空，要让智威修改
    NSString *errCode = [newsListDic objectForKey:@"errorcode"];
//    if (![errCode isEqualToString:NETWORK_OK]) {
    if (errCode != nil) {   //返回nil表示成功是不对的，后面要改
        //从后台获取新闻失败
        NSLog(@"err: get category error [%@]", errCode);
        //token发生错误表示要注销程序
        if ([errCode isEqualToString:NETWORK_WRONGTOKE] || [errCode isEqualToString:NETWORK_TIMEOUT_TOKEN]) {
#warning wensj token错误，启动认证失败注销处理
//            [self.verifyDelegate tokenErr];
        }
        return nil;
    }
    //成功获取到新闻
    NSMutableArray *newsListReturn = [[NSMutableArray alloc] init];
    NSNumber *categoryNum = [newsListDic objectForKey:@"resultcount"];
    if ([categoryNum isEqualToNumber:@(0)]) {
        //栏目数为空
        NSLog(@"err: category num is 0");
        return newsListReturn;
    }
    
    //栏目信息数据
    NSArray *newsList = [newsListDic objectForKey:@"resultlist"];
//    NSLog(@"%@", newsList);
    for (NSInteger i=0; i<newsList.count; i++) {
        id obj = [newsList objectAtIndex:i];
        EsNewsInfo *newsInfo = [[EsNewsInfo alloc] init];
        newsInfo.newsID = [obj objectForKey:@"newsId"];
        newsInfo.titleText = [obj objectForKey:@"newsTitle"];
        newsInfo.bgImgUrl = [obj objectForKey:@"headPicUrl"];
        newsInfo.summaryText = [obj objectForKey:@"newsSummary"];
        newsInfo.bImgable = [[obj objectForKey:@"isHead"] boolValue];
        newsInfo.releaseDate = [obj objectForKey:@"verifyDate"];
        
        [newsListReturn addObject:newsInfo];
    }

    return newsListReturn;
}

@end
