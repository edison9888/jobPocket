//
//  ERBaseDataSource.m
//
//
//  Created by apple on 13-4-16.
//
//

#import "BaseDataSource.h"
#import "SVHTTPRequest.h"
#import "EsNetworkPredefine.h"

@interface BaseDataSource()
{
    BOOL                _isLoading;
}

@property (nonatomic, strong) SVHTTPRequest *   httpReq;
@property (nonatomic, copy) void(^completionBlock)(id responsedict);

@end

@implementation BaseDataSource

@synthesize responseDict;
@synthesize httpReq;
@synthesize errorCode;
@synthesize errorMsg;

+ (NSString* )getErrorMsgByCode:(NSString* )errorCode
{
    NSString * errMsg = @"";
    if ([errorCode isEqualToString:NETWORK_OK])             errMsg = @"成功";
    if ([errorCode isEqualToString:NETWORK_ERR])            errMsg = @"失败";
    if ([errorCode isEqualToString:NETWORK_PARA_EMPTY])     errMsg = @"输入参数为空";
    if ([errorCode isEqualToString:NETWORK_NOTEXIST])       errMsg = @"查询的结果集不存在";
    if ([errorCode isEqualToString:NETWORK_CALLERR])        errMsg = @"调用出现异常";
    if ([errorCode isEqualToString:NETWORK_ERR_NET])        errMsg = @"网络故障";
    if ([errorCode isEqualToString:NETWORK_TIMEOUT_RSP])    errMsg = @"系统响应超时";
    if ([errorCode isEqualToString:NETWORK_TIMEOUT_STAMP])  errMsg = @"时间戳超时";
    if ([errorCode isEqualToString:NETWORK_NOPHONENUM])     errMsg = @"该号码暂未开通订阅服务";
    if ([errorCode isEqualToString:NETWORK_WRONGTOKE])      errMsg = @"token验证错误";
    if ([errorCode isEqualToString:NETWORK_TIMEOUT_TOKEN])  errMsg = @"Token 已过时";
    if ([errorCode isEqualToString:NETWORK_RSTEMPTY])       errMsg = @"结果为空";
    if ([errorCode isEqualToString:NETWORK_VERIFYERR])      errMsg = @"验证码验证失败或失效";
    if ([errorCode isEqualToString:NETWORK_ERR_SYS])        errMsg = @"系统异常";
    
    return errMsg;
}

- (void)dealloc
{
    [self cancel];
}

- (void)startGetRequestWithParams:(NSDictionary *)params method:(NSString *)method completion:(void(^)(id responsedict))completion
{
    [self startGetRequestWithParamsAndUrl:params method:method url:kServiceUrl completion:completion];
}

- (void)startGetRequestWithParamsAndUrl:(NSDictionary *)params method:(NSString *)method url:(NSString *)url completion:(void(^)(id responsedict))completion
{
    if (!url ||
        _isLoading)
    {
        return;
    }
    
    _isLoading = YES;
    self.responseDict = nil;
    [self.httpReq cancel];
    self.completionBlock = completion;
    
    if ([method length])
    {
        NSMutableDictionary * tmpDict = [NSMutableDictionary dictionaryWithDictionary:params];
        [tmpDict setObject:method forKey:@"method"];
        params = [NSDictionary dictionaryWithDictionary:tmpDict];
    }
    
    __weak typeof(self) wself = self;
    self.httpReq = [[SVHTTPClient sharedClient] GET:url parameters:params completion:^(id response, NSHTTPURLResponse *urlResponse, NSError *error)
    {
        [wself onFinish:response urlResponse:urlResponse error:error];
    }];
}

//带上传文件的post请求
- (void)startPostRequestWithParamsAndUrl:(NSDictionary *)params
                                  method:(NSString *)method
                                 upFiles:(NSArray*)upFiles
                              completion:(void(^)(id responsedict))completion
{
    [self startPostRequestWithParamsAndUrl:params
                                    method:method
                                       url:kServiceUrl
                                   upFiles:upFiles
                                completion:completion];
}

//带上传文件的post请求
- (void)startPostRequestWithParamsAndUrl:(NSDictionary *)params
                                 method:(NSString *)method
                                    url:(NSString *)url
                                upFiles:(NSArray*)upFiles
                             completion:(void(^)(id responsedict))completion
{
    if (!url || _isLoading)
    {
        return;
    }
    
    _isLoading = YES;
    self.responseDict = nil;
    [self.httpReq cancel];
    self.completionBlock = completion;
    
    if ([method length])
    {
        NSMutableDictionary * tmpDict = [NSMutableDictionary dictionaryWithDictionary:params];
        [tmpDict setObject:method forKey:@"method"];
        params = [NSDictionary dictionaryWithDictionary:tmpDict];
    }

    __weak typeof(self) wself = self;
    [[SVHTTPClient sharedClient] POST:url parameters:params upFiles:upFiles completion:^(id response, NSHTTPURLResponse *urlResponse, NSError *error) {
        [wself onFinish:response urlResponse:urlResponse error:error];
    }];
}

- (void)onFinish:(id)response urlResponse:(NSHTTPURLResponse *)urlResponse error:(NSError *)error
{
    _isLoading = NO;
    if ([response isKindOfClass:[NSData class]])
    {
        if ([response length])
        {
            NSDictionary *jsonObject = [NSJSONSerialization JSONObjectWithData:response options:NSJSONReadingAllowFragments error:nil];
            self.responseDict = jsonObject;
        }
    }
    else
    {
        self.responseDict = response;
    }
    
    if ([self.responseDict objectForKey:@"errorcode"] != [NSNull null] &&
        [self.responseDict objectForKey:@"errorcode"] != nil) {
        self.errorCode = [self.responseDict objectForKey:@"errorcode"];
    }
    self.errorMsg = [BaseDataSource getErrorMsgByCode:self.errorCode];
    
    if (!response || !urlResponse)
    {
        // 网络异常
        self.errorMsg = @"网络连接失败，请检查网络后重试";
    }
    
    if (([self.errorCode isEqualToString:NETWORK_WRONGTOKE] || [self.errorCode isEqualToString:NETWORK_TIMEOUT_TOKEN]) &&
        [Global sharedSingleton].userVerify.user.token.length)
    {
        [Global sharedSingleton].userVerify.user.token = nil;   // 将token置空
        UIAlertView* alert = [[UIAlertView alloc] initWithTitle:nil
                                                        message:@"对不起，登录超时，请重新登录."
                                                       delegate:(id<UIAlertViewDelegate>)self
                                              cancelButtonTitle:@"确定"
                                              otherButtonTitles:nil];
        [alert performSelector:@selector(show) onThread:[NSThread mainThread] withObject:nil waitUntilDone:NO];
    }
    else if (self.completionBlock)
    {
        self.completionBlock(self.responseDict);
    }
}

- (void)startPostRequestWithParams:(NSDictionary *)params method:(NSString *)method completion:(void(^)(id responsedict))completion
{
    [self startPostRequestWithParamsAndUrl:params method:method url:kServiceUrl completion:completion];
}

- (void)startPostRequestWithParamsAndUrl:(NSDictionary *)params method:(NSString *)method url:(NSString *)url completion:(void(^)(id responsedict))completion
{
    if (!url ||
        _isLoading)
    {
        return;
    }
    
    _isLoading = YES;
    self.responseDict = nil;
    [self.httpReq cancel];
    
    if ([method length])
    {
        NSMutableDictionary * tmpDict = [NSMutableDictionary dictionaryWithDictionary:params];
        [tmpDict setObject:method forKey:@"method"];
        params = [NSDictionary dictionaryWithDictionary:tmpDict];
    }
    
    __weak typeof(self) wself = self;
    self.httpReq = [[SVHTTPClient sharedClient] POST:url parameters:params completion:^(id response, NSHTTPURLResponse *urlResponse, NSError *error)
    {
        [wself onFinish:response urlResponse:urlResponse error:error];
    }];
}

- (void)cancel
{
    self.responseDict = nil;
    self.errorMsg = nil;
    [self.httpReq cancel];
    self.httpReq = nil;
}

#pragma mark UIAlertView
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0)
    {
        [[NSNotificationCenter defaultCenter] postNotificationName:kMsgAutoLogout object:nil];
    }
}

@end
