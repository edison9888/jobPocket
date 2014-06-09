//
//  EsLanmuCtrl.m
//  xhgdzwyq
//
//  Created by Eshore on 13-11-7.
//  Copyright (c) 2013年 Eshore. All rights reserved.
//

#import "EsLanmuCtrl.h"
#import "EsNetworkPredefine.h"
#import "EsUserVerify.h"

@implementation EsLanmuInfo

//比较两个栏目信息是否完全一致
- (BOOL) isEqualToLanmu:(EsLanmuInfo *)lanmu
{
#warning wensj 图片的判断，要考虑下，不要每次都load
    if (![self.lanmuID isEqual: lanmu.lanmuID] || ![self.titleText isEqual:lanmu.titleText] /*|| ![self.bgImg isEqual:lanmu.bgImg]*//*怎么获取NSData来着？*/ || self.index != lanmu.index) {
        return NO;
    }
    
    return YES;
}

@end


@implementation EsLanmuCtrl

- (id)init
{
    self = [super init];
    if (self) {
        _lanmuArray = [[NSMutableArray alloc] init];
        _userVerify = [[EsUserVerify alloc] init];
    }
    return self;
}

//只在开发初期调试用，模拟用户获取验证码和登录
- (void) prepareForDevelop
{
    //for development
    NSError *error;
    //发短信
    NSURLRequest *requestSms = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://app.xhzwyq.com:7101/news/iface.htm?method=getIdentifyCode&phone=13332832935"]];
    [NSURLConnection sendSynchronousRequest:requestSms returningResponse:nil error:nil];
    NSData *response1 = [NSURLConnection sendSynchronousRequest:requestSms returningResponse:nil error:nil];
    NSDictionary *smsDic = [NSJSONSerialization JSONObjectWithData:response1 options:NSJSONReadingMutableLeaves error:&error];
    NSLog(@"%@", [smsDic objectForKey:@"errorcode"]);
    
    //登录
    NSURLRequest *requestLogin = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://app.xhzwyq.com:7101/news/iface.htm?method=login&phone=13332832935&identifyCode=146874&loginStyle=1"]];
    [NSURLConnection sendSynchronousRequest:requestLogin returningResponse:nil error:nil];
    NSData *response2 = [NSURLConnection sendSynchronousRequest:requestLogin returningResponse:nil error:nil];
    NSDictionary *loginDic = [NSJSONSerialization JSONObjectWithData:response2 options:NSJSONReadingMutableLeaves error:&error];
    NSLog(@"%@", [loginDic objectForKey:@"token"]);
}

//从后台获取全部栏目数据
- (NSArray *)getLanmus
{
#if 1
//    [self prepareForDevelop];
#warning wensj 注意容错：没有栏目时、网络出错时、娶不到数据时
    //从后台获取当前有效的栏目,并按显示顺序排好后返回
#if 1
    //获取栏目
    NSError *error;
    //获取栏目接口url
    NSString *getCategoryUrl = [NSString stringWithFormat:@"%@?method=getSummary&token=%@", IURL, [self.userVerify getToken]];
#warning wensj 用于测试 aa6U8RegsZ
//    NSString *getCategoryUrl = [NSString stringWithFormat:@"%@?method=getSummary&token=%@", IURL, @"aa6U8RegsZ"];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:getCategoryUrl]];
    //向后台请求栏目数据
    NSData *response = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    if (nil == response) {
        //没有数据，可能是网络不同之类的
        //err log
        return nil;
    }
    NSDictionary *categoryDic = [NSJSONSerialization JSONObjectWithData:response options:NSJSONReadingMutableLeaves error:&error];
#warning wensj getSummary 消息，在获取成功时errorcode是空，要让智威修改
    NSString *errCode = [categoryDic objectForKey:@"errorcode"];
//    if (![errCode isEqualToString:NETWORK_OK]) {
    if (errCode != nil) {   //返回nil表示成功是不对的，后面要改
        //从后台获取栏目失败
        NSLog(@"err: get category error [%@]", errCode);
        //token发生错误表示要注销程序
        if ([errCode isEqualToString:NETWORK_WRONGTOKE] || [errCode isEqualToString:NETWORK_TIMEOUT_TOKEN]) {
            [self.verifyDelegate tokenErr];
        }
        return nil;
    }
    //成功获取到栏目
    NSMutableArray *categoriesReturn = [[NSMutableArray alloc] init];
    NSNumber *categoryNum = [categoryDic objectForKey:@"resultcount"];
    if ([categoryNum isEqualToNumber:@(0)]) {
        //栏目数为空
        NSLog(@"err: category num is 0");
        return categoriesReturn;
    }
    //栏目信息数据
    NSArray *categorys = [categoryDic objectForKey:@"resultlist"];
//    //...log 判断返回树木和世纪树木是否一致
    for (NSInteger i=0; i<categorys.count; i++) {
        id obj = [categorys objectAtIndex:i];
        EsLanmuInfo *lanmuInfo = [[EsLanmuInfo alloc] init];
        lanmuInfo.lanmuID = [obj objectForKey:@"catalogId"];
        lanmuInfo.titleText = [obj objectForKey:@"catalogName"];
#warning wensj 图片处理要改一下，不传图片数据，传路径，在需要显示时才吧图片load下来
//        lanmuInfo.bgImg = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[obj objectForKey:@"catalogPicUrl"]]]];
        lanmuInfo.bgImgUrl = [obj objectForKey:@"catalogPicUrl"];
        
        [categoriesReturn addObject:lanmuInfo];
    }
    
#else
    //for test
    NSInteger nLanmu4tst = 5;
    NSMutableArray *arrTst = [[NSMutableArray alloc] initWithCapacity:nLanmu4tst];
    for (NSInteger i=0; i<nLanmu4tst; i++) {
        EsLanmuInfo *lanmuInfo = [[EsLanmuInfo alloc] init];
        lanmuInfo.lanmuID = [[NSString alloc] initWithFormat:@"lm00%d", i];
        lanmuInfo.titleText = [[NSString alloc] initWithFormat:@"栏目00%d", i+1];
        lanmuInfo.bgImg = [UIImage imageNamed:@"morenlanmu"];
        lanmuInfo.index = i+1;
        
        [arrTst addObject:lanmuInfo];
    }
    return arrTst; //数组顺序就是栏目的先是顺序
#endif
    
    return categoriesReturn; //数组顺序就是栏目的先是顺序
#endif
}

- (void)getChanges
{
#if 0   //后面再优化，做成观察者模式
    //从后台获取栏目信息
#warning wensj 以后增加一个接口，可从后台获取最近一次更新的时间，直接判断有无更新，就不用每次舒心都下载全部栏目数据了
    NSArray *latestArr = [self getLanmus];
//    self.lanmuArray = latestArr;
    ////////
    
    //lanmuArray更新
    NSInteger i = 0;
    for (i=0; i<latestArr.count; i++) {
        BOOL bNotify = NO;
        if (i >= self.lanmuArray.count) {
            //增加一个栏目
            bNotify = YES;
            [self.lanmuArray addObject:[latestArr objectAtIndex:i]];
        }
        else if (![[latestArr objectAtIndex:i] isEqualToLanmu: [self.lanmuArray objectAtIndex:i]]) {
            //修改一个栏目
            bNotify = YES;
            [self.lanmuArray replaceObjectAtIndex:i withObject:[latestArr objectAtIndex:i]];
        }
        
        if (bNotify) {
            [self.delegate lanmuItemDidChanged:[self.lanmuArray objectAtIndex:i] atViewIndex:i];
        }
    }
    if (self.lanmuArray.count > i) {
        for (; i<self.lanmuArray.count; i++) {
            [self.delegate lanmuItemDidChanged:nil atViewIndex:i];
        }
        [self.lanmuArray re
    }
#endif
}


@end
