//
//  EsNewsListNetAgent.m
//  xhgdzwyq
//
//  Created by apple on 13-12-3.
//  Copyright (c) 2013年 Eshore. All rights reserved.
//

#import "EsNewsListNetAgent.h"
#import "EsNewsItem.h"

@interface EsNewsListNetAgent()
{
    NSMutableArray* _newsList;      // 新闻列表，原始数据
    NSMutableArray* _dayNewsList;   // 按日期分的新闻列表
    int             _pageSize;
    int             _currentPage;
    int             _totalPage;
    int             _resultCount;
    NewsTableLoadingType _loadingType;
    NSDateFormatter*     _dateFormatter;
    
    NSMutableArray* _newsHeadlines; // 头条列表,只取一页前三条
    int             _headlineCurrentPage;
    int             _headlineTotalPage;
    int             _headlineResultCount;
}

@property (nonatomic, copy) void (^ newsCompletionBlock)(void);
@property (nonatomic, copy) void (^ headlinesCompletionBlock)(EsNewsListNetAgent* sender);

@end

@implementation EsNewsListNetAgent

@synthesize currentPage = _currentPage;
@synthesize totalPage = _totalPage;
@synthesize newsList = _newsList;
@synthesize dayNewsList = _dayNewsList;
@synthesize loadingType = _loadingType;
//@synthesize headlineCurrentPage = _headlineCurrentPage;
//@synthesize headlineTotalPage = _headlineTotalPage;
@synthesize newsHeadlines = _newsHeadlines;

- (id)init
{
    self = [super init];
    if (self)
    {
        _newsList = [NSMutableArray new];
        _dayNewsList = [NSMutableArray new];
        _pageSize = 20;
        _currentPage = 1;
        _totalPage = 0;
        _resultCount = 0;
        _newsHeadlines = [NSMutableArray new];
        _loadingType = NewsTableLoadingTypeNone;
        
        _dateFormatter = [NSDateFormatter new];
        [_dateFormatter setDateFormat:@"yyyy-MM-dd"];
        
        _newsHeadlines = [NSMutableArray new];
        _headlineCurrentPage = 1;
        _headlineResultCount = 0;
        _headlineTotalPage = 0;
    }
    
    return self;
}

- (void)dealloc
{
    self.newsCompletionBlock = nil;
    self.headlinesCompletionBlock = nil;
}

- (void)getNewsList:(int)page completion:(void(^)(void))completion
{
    [self getNewsList:page newslist:_newsList dayslist:_dayNewsList completion:completion];
}

- (void)getNewsList:(int)page newslist:(NSMutableArray* )newslist dayslist:(NSMutableArray* )dayslist completion:(void(^)(void))completion
{
    self.newsCompletionBlock = completion;
    
    NSString* token = @"";
    if ([Global sharedSingleton].userVerify.user.token)
    {
        token = [Global sharedSingleton].userVerify.user.token;
    }
    NSString* isHead = @"";    // 是否头条 0：不是1：是头条，为空则全部
    NSString* catalogId = @"";
    if (self.columnInfo.catalogId)
    {
        catalogId = [NSString stringWithFormat:@"%@", self.columnInfo.catalogId];
    }
    NSString* currentPage = [NSString stringWithFormat:@"%d", page];
    NSString* pageSize = [NSString stringWithFormat:@"%d", _pageSize];
    
    NSDictionary* params = @{@"token" : token,
                             @"isHead": isHead,
                             @"catalogId" : catalogId,
                             @"currentPage" : currentPage,
                             @"pageSize" : pageSize};
    
    __weak typeof(self) wself = self;
    BaseDataSource* net = [BaseDataSource new];
    [net startGetRequestWithParams:params method:@"getNewsList" completion:^(id responsedict)
     {
         [wself onNewsListFinish:net response:responsedict newslist:newslist dayslist:dayslist];
     }];
}

- (void)onNewsListFinish:(BaseDataSource* )net response:(id)response newslist:(NSMutableArray* )newslist dayslist:(NSMutableArray* )dayslist
{
    NSString* tipmsg = @"对不起，新闻列表获取失败";
    _loadingType = NewsTableLoadingTypeNone;
    BOOL iserr = YES;
    do {
        if (!response)
        {
            if ([net.errorMsg length])
            {
                tipmsg = net.errorMsg;
            }
            break;
        }
        
        if ([net.errorCode length])
        {
            if ([net.errorMsg length])
            {
                tipmsg = net.errorMsg;
            }
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
            tipmsg = @"对不起，暂无新闻";
            break;
        }
        
        NSArray* readedlist = [Utils loadReadedNewsList];
        
        for (NSDictionary* dict in resultlist)
        {
            EsNewsItem* newitem = [[EsNewsItem alloc] initWithDictionary:dict];
            [newslist addObject:newitem];
            
            // 是否已读
            [readedlist enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop)
             {
                 if ([obj respondsToSelector:@selector(intValue)] && [obj intValue] == [newitem.newsId intValue])
                 {
                     newitem.readed = YES;
                     *stop = YES;
                 }
             }];
            
            NSString* dateStr = @"";
            if (newitem.verifyDate.length >= 10)
            {
                dateStr = [newitem.verifyDate substringToIndex:10];
            }
            if (!dateStr.length)
            {
                continue;
            }
            
            EsDayNews* dayitem = nil;
            for (EsDayNews* item in dayslist)
            {
                if ([item.verifyDate isEqualToString:dateStr])
                {
                    dayitem = item;
                    break;
                }
            }
            
            if (!dayitem)
            {
                dayitem = [EsDayNews new];
                dayitem.verifyDate = dateStr;
                dayitem.week = [self weekStringByDate:dateStr];
                dayitem.news = [NSMutableArray new];
                [dayslist addObject:dayitem];
            }
            [dayitem.news addObject:newitem];
        }
        iserr = NO;
        
        if (response[@"resultcount"] != [NSNull null] &&
            response[@"resultcount"] != nil)
        {
            _resultCount = [response[@"resultcount"] intValue];
        }
        
        if (response[@"currentPage"] != [NSNull null] &&
            response[@"currentPage"] != nil)
        {
            _currentPage = [response[@"currentPage"] intValue];
        }
        
        if (response[@"pageSize"] != [NSNull null] &&
            response[@"pageSize"] != nil)
        {
            _pageSize = [response[@"pageSize"] intValue];
        }
        
        if (response[@"totalPage"] != [NSNull null] &&
            response[@"totalPage"] != nil)
        {
            _totalPage = [response[@"totalPage"] intValue];
        }
        
        if ([dayslist count] && _currentPage < _totalPage)
        {
            _loadingType = NewsTableLoadingTypeLoadingMore;
        }
    } while (0);
    
    if (iserr)
    {
        ToastAlertView * alert = [ToastAlertView new];
        [alert showAlertMsg:tipmsg];
    }
    
    if (self.newsCompletionBlock)
    {
        self.newsCompletionBlock();
    }
}

// 2013-11-11格式
- (NSString*)weekStringByDate:(NSString*)datestr
{
    if (!datestr.length)
    {
        return @"";
    }
    
    NSString* today          = [_dateFormatter stringFromDate:[NSDate date]];
    if ([today isEqualToString:datestr])
    {
        return @"今天";
    }
    
    NSCalendar * calendar    = [NSCalendar currentCalendar];
    NSDateComponents * comps = [[NSDateComponents alloc] init];
    [comps setDay:-1];
    NSDate * dt              = [calendar dateByAddingComponents:comps toDate:[NSDate date] options:0];
    NSString* yesterday      = [_dateFormatter stringFromDate:dt];
    if ([yesterday isEqualToString:datestr])
    {
        return @"昨天";
    }
    
    [comps setDay:-2];
    dt                       = [calendar dateByAddingComponents:comps toDate:[NSDate date] options:0];
    NSString* beforeday      = [_dateFormatter stringFromDate:dt];
    if ([beforeday isEqualToString:datestr])
    {
        return @"前天";
    }
    
    NSString* weekstr        = [NSString string];
    dt                       = [_dateFormatter dateFromString:datestr];
#warning wensj 没编译通过的代码不要上传 低版本sdk报错
//    comps                    = [calendar components:NSCalendarUnitWeekday fromDate:dt];
    comps = [calendar components:NSWeekdayCalendarUnit fromDate:dt];
    switch (comps.weekday)
    {
        case 1:
        {
            weekstr          = @"星期日";
            break;
        }
        case 2:
        {
            weekstr          = @"星期一";
            break;
        }
        case 3:
        {
            weekstr          = @"星期二";
            break;
        }
        case 4:
        {
            weekstr          = @"星期三";
            break;
        }
        case 5:
        {
            weekstr          = @"星期四";
            break;
        }
        case 6:
        {
            weekstr          = @"星期五";
            break;
        }
        case 7:
        {
            weekstr          = @"星期六";
            break;
        }
        default:
            break;
    }
    
    return weekstr;
}

- (void)refreshNewsList:(void(^)(void))completion headlineCompletion:(void(^)(EsNewsListNetAgent* sender))headlineCompletion
{
    __block NSMutableArray* newslist = [NSMutableArray new];
    __block NSMutableArray* dayslist = [NSMutableArray new];
    [self getNewsList:1 newslist:newslist dayslist:dayslist completion:^
    {
        [_newsList removeAllObjects];
        [_newsList addObjectsFromArray:newslist];
        
        [_dayNewsList removeAllObjects];
        [_dayNewsList addObjectsFromArray:dayslist];
        
        if (completion)
        {
            completion();
        }
    }];
    
    __block NSMutableArray* headlines = [NSMutableArray new];
    [self getHeadLines:1 headlines:headlines completion:^(EsNewsListNetAgent *sender)
    {
        [_newsHeadlines removeAllObjects];
        [_newsHeadlines addObjectsFromArray:headlines];
        
        if (headlineCompletion)
        {
            headlineCompletion(sender);
        }
    }];
}

- (void)getHeadLines:(int)page completion:(void(^)(EsNewsListNetAgent* sender))completion
{
    [self getHeadLines:page headlines:_newsHeadlines completion:completion];
}

- (void)getHeadLines:(int)page headlines:(NSMutableArray* )headlines completion:(void(^)(EsNewsListNetAgent* sender))completion
{
    self.headlinesCompletionBlock = completion;
    
    NSString* token = @"";
    if ([Global sharedSingleton].userVerify.user.token)
    {
        token = [Global sharedSingleton].userVerify.user.token;
    }
    NSString* isHead = @"0";    // 是否头条 0：不是1：是头条，为空则全部
    NSString* catalogId = @"";
    if (self.columnInfo.catalogId)
    {
        catalogId = [NSString stringWithFormat:@"%@", self.columnInfo.catalogId];
    }
    NSString* currentPage = [NSString stringWithFormat:@"%d", page];
    NSString* pageSize = [NSString stringWithFormat:@"%d", _pageSize];
    
    NSDictionary* params = @{@"token" : token,
                             @"isHead": isHead,
                             @"catalogId" : catalogId,
                             @"currentPage" : currentPage,
                             @"pageSize" : pageSize};
    
    __weak typeof(self) wself = self;
    BaseDataSource* net = [BaseDataSource new];
    [net startGetRequestWithParams:params method:@"getNewsList" completion:^(id responsedict)
     {
         [wself onHeadlinesFinish:net headlines:headlines response:responsedict];
     }];
}

- (void)onHeadlinesFinish:(BaseDataSource* )net headlines:(NSMutableArray* )headlines response:(id)response
{
    NSString* tipmsg = @"对不起，头条获取失败";
    BOOL iserr = YES;
    do {
        if ([net.errorCode length])
        {
            if ([net.errorMsg length])
            {
                tipmsg = net.errorMsg;
            }
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
            tipmsg = @"对不起，暂无头条";
            break;
        }
        
        for (NSDictionary* dict in resultlist)
        {
            EsNewsItem* column = [[EsNewsItem alloc] initWithDictionary:dict];
            [headlines addObject:column];
        }
        iserr = NO;
        
        if (response[@"resultcount"] != [NSNull null] &&
            response[@"resultcount"] != nil)
        {
            _headlineResultCount = [response[@"resultcount"] intValue];
        }
        
        if (response[@"currentPage"] != [NSNull null] &&
            response[@"currentPage"] != nil)
        {
            _headlineCurrentPage = [response[@"currentPage"] intValue];
        }
        
        if (response[@"totalPage"] != [NSNull null] &&
            response[@"totalPage"] != nil)
        {
            _headlineTotalPage = [response[@"totalPage"] intValue];
        }
    } while (0);
    
    if (self.headlinesCompletionBlock)
    {
        self.headlinesCompletionBlock(self);
    }
}

@end
