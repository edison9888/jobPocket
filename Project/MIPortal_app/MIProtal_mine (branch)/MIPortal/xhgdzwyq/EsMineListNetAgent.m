/*--------------------------------------------
 *Name：EsMineListNetAgent.h
 *Desc：我的界面详情模块网络请求
 *Date：2014/06/06
 *Auth：shanhq
 *--------------------------------------------*/

#import "EsMineListNetAgent.h"
#import "EsNewsItem.h"
#import "EsNewsDetailModel.h"

@interface EsMineListNetAgent()
{
    NSMutableArray* _newsList;      // 新闻列表，原始数据
    NSMutableArray* _dayNewsList;   // 按日期分的新闻列表
    NSMutableArray* _reportList;    // 上报列表
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
@property (nonatomic, copy) void (^ headlinesCompletionBlock)(EsMineListNetAgent* sender);

@end

@implementation EsMineListNetAgent

@synthesize newsHeadlines = _newsHeadlines;
@synthesize currentPage = _currentPage;
@synthesize pageSize = _pageSize;
@synthesize totalPage = _totalPage;
@synthesize newsList = _newsList;
@synthesize dayNewsList = _dayNewsList;
@synthesize reportList = _reportList;
@synthesize loadingType = _loadingType;

- (id)init
{
    self = [super init];
    if (self)
    {
        _newsList = [NSMutableArray new];
        _dayNewsList = [NSMutableArray new];
        _reportList = [NSMutableArray new];
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
- (void)setParams:(NSDictionary *)params
       andSetMethod:(NSString*)method
         completion:(void (^)(void))completion
{
    [self setParams:params
         andSetMethod:method
             newslist:_newsList
             dayslist:_dayNewsList
           completion:completion];
}

- (void)setParams:(NSDictionary *)params
       andSetMethod:(NSString*)method
           newslist:(NSMutableArray* )newslist
           dayslist:(NSMutableArray* )dayslist
         completion:(void(^)(void))completion
{
    self.newsCompletionBlock = completion;
    
    self.params = params;
    self.method = method;
    __weak typeof(self) wself = self;
    BaseDataSource* net = [BaseDataSource new];
    [net startGetRequestWithParams:params method:method completion:^(id responsedict)
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
            NSMutableDictionary *resultDic = [NSMutableDictionary dictionaryWithDictionary:dict];
            // 判断是否是汇报历史
            {
                if ([dict objectForKey:@"reportName"]) {
                    CLog(@"汇报历史");
                    NSMutableDictionary *reportDic = [NSMutableDictionary dictionary];
                    [reportDic setObject:[dict objectForKey:@"reportName"] forKey:@"newsTitle"];
                    [reportDic setObject:[dict objectForKey:@"reportContent"] forKey:@"newsSummary"];
                    [reportDic setObject:[dict objectForKey:@"reportContent"] forKey:@"newsContent"];
                    [reportDic setObject:[dict objectForKey:@"id"] forKey:@"newsId"];
                    [reportDic setObject:[dict objectForKey:@"createTime"] forKey:@"verifyDate"];
                    [reportDic setObject:[[[[Global sharedSingleton] userVerify] user] clientName] forKey:@"createUserName"];
                    [resultDic addEntriesFromDictionary:reportDic];
                    EsNewsDetailModel *reportDetail = [[EsNewsDetailModel alloc]initWithDictionary:reportDic];
                    [_reportList addObject:reportDetail];
                }
            }
            
            EsNewsItem* newitem = [[EsNewsItem alloc] initWithDictionary:resultDic];
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
        
        if ([newslist count] && _currentPage < _totalPage)
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

- (void)refreshNewsList:(void(^)(void))completion headlineCompletion:(void(^)(EsMineListNetAgent* sender))headlineCompletion
{
    if (completion)
    {
        completion();
    }
}
@end
