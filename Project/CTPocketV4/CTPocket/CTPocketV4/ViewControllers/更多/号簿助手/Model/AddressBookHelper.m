//
//  AddressBookHelper.m
//  CTPocketV4
//
//  Created by apple on 14-3-7.
//  Copyright (c) 2014年 广东亿迅科技有限公司. All rights reserved.
//

#import "AddressBookHelper.h"
#import "AddressBookAdpater.h"
#import "PersonObj.h"
#import "GroupObj.h"
#import "Utils.h"
#import "NSDataAdditions.h"
#import "XMLDictionary.h"
#import "SIAlertView.h"
#import "AddressBookLogger.h"

#import "HBZSNetworkEngine.h"
#import "Get_config_proto.pb.h"
#import "Auth_proto.pb.h"
#import "Get_user_cloud_summary_proto.pb.h"
#import "Get_contact_list_version_proto.pb.h"
#import "Upload_contact_info_proto.pb.h"

@interface AddressBookHelper()

@property (nonatomic, strong) AddressBookAdpater*   addrBookApdater;
@property (nonatomic, strong) AddressBookLogger*    addrBookLogger;

@property (nonatomic, strong) HBZSNetworkEngine*    netEngineConfigure;
@property (nonatomic, strong) HBZSNetworkOperation* netConfigure;
@property (nonatomic, strong) GetConfigResponse*    respConfigure;

@property (nonatomic, strong) HBZSNetworkEngine*    netEngineAuth;
@property (nonatomic, strong) HBZSNetworkOperation* netAuth;
@property (nonatomic, strong) AuthResponse*         respAuth;

@property (nonatomic, strong) HBZSNetworkEngine*            netEngineUserCloudSummary;
@property (nonatomic, strong) HBZSNetworkOperation*         netUserCloudSummary;
@property (nonatomic, strong) GetUserCloudSummaryResponse*  respUserCloudSummary;

@property (nonatomic, strong) HBZSNetworkEngine*            netEngineUploadAll;
@property (nonatomic, strong) HBZSNetworkOperation*         netUploadAll;
@property (nonatomic, strong) UploadContactInfoResponse*    respUploadAll;

@property (nonatomic, strong) HBZSNetworkEngine*            netEngineDownloadAll;
@property (nonatomic, strong) HBZSNetworkOperation*         netDownloadAll;

@property (nonatomic, assign) dispatch_queue_t              uploadSuccessQueue;
@property (nonatomic, assign) dispatch_queue_t              downloadSuccessQueue;

@end

@implementation AddressBookHelper

+ (NSData *)SimpleEncrypt:(NSString* )plainString byOffset:(int)offset bySalt:(int)salt
{
    if (!plainString.length)
    {
        return nil;
    }
    
    NSData *sourceData = [plainString dataUsingEncoding:NSUTF8StringEncoding];
    Byte *data = (Byte *)[sourceData bytes];
    int len = [sourceData length];
    
    for (int i =0; i<len; i++)
    {
        data[i] = (((data[i] << (8 - offset)) & 0x00FF) | data[i] >> offset);
        data[i] = (Byte)(data[i] ^ salt);
    }
    
    for (int i = 0; i < len/2; i++)
    {
        Byte temp = data[i];
        data[i] = data[len-i-1];
        data[len-i-1] = temp;
    }
	
    return [[NSData alloc] initWithBytes:data length:len];
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.addrBookApdater = [AddressBookAdpater new];
        self.addrBookLogger = [AddressBookLogger new];
        self.respConfigure = [Global sharedInstance].respConfigure;
        self.uploadSuccessQueue = dispatch_queue_create("com.eshore.ctpocket.abupload.success", DISPATCH_QUEUE_CONCURRENT);
        self.downloadSuccessQueue = dispatch_queue_create("com.eshore.ctpocket.abdownload.success", DISPATCH_QUEUE_CONCURRENT);
    }
    
    return self;
}

- (void)dealloc
{
    DDLogInfo(@"%s", __func__);
    self.addrBookApdater = nil;
    if (self.uploadSuccessQueue) {
        dispatch_release(self.uploadSuccessQueue);
    }
    if (self.downloadSuccessQueue) {
        dispatch_release(self.downloadSuccessQueue);
    }
}

- (void)getAddressBookRef:(void(^)(ABAddressBookRef addrBookRef, BOOL hasPopedAlertMsg))completion
{
    ABAddressBookRef abRef = NULL;
    BOOL success = YES;
    BOOL popAlert = NO;
    do {
        float version = [[[UIDevice currentDevice] systemVersion] floatValue];
        if (version >= 6.0) {
            abRef = ABAddressBookCreateWithOptions(NULL, NULL);
            
            ABAuthorizationStatus status = ABAddressBookGetAuthorizationStatus();
            switch (status) {
                case kABAuthorizationStatusNotDetermined: //用户尚未选择
                {
                    dispatch_semaphore_t sema = dispatch_semaphore_create(0);
                    ABAddressBookRequestAccessWithCompletion(abRef, ^(bool granted, CFErrorRef error) {
                        dispatch_semaphore_signal(sema);
                        
                        if (!granted) {
                            SIAlertView *alertView = [[SIAlertView alloc] initWithTitle:@"访问通讯录失败"
                                                                             andMessage:@"请在设置-隐私-通讯录中打开应用的访问权限"];
                            [alertView addButtonWithTitle:@"好"
                                                     type:SIAlertViewButtonTypeDefault
                                                  handler:nil];
                            alertView.transitionStyle = SIAlertViewTransitionStyleFade;
                            [alertView performSelectorOnMainThread:@selector(show) withObject:nil waitUntilDone:NO];
                        } 
                        
                        if (completion) {
                            completion(granted?abRef:NULL, !granted);
                        }
                        
                        if (abRef) {
                            CFRelease(abRef);
                        }
                        
                    });
                    dispatch_semaphore_wait(sema, DISPATCH_TIME_FOREVER);
                    dispatch_release(sema);
                    success = NO;
                }break;
                case kABAuthorizationStatusAuthorized: //已经允许
                {
                    success = YES;
                }break;
                case kABAuthorizationStatusRestricted: //此应用程序未被授权访问, 当前用户也不能更改这个应用程序的状态
                case kABAuthorizationStatusDenied: //用户明确拒绝了不准访问
                {
                    SIAlertView *alertView = [[SIAlertView alloc] initWithTitle:@"访问通讯录失败"
                                                                     andMessage:@"请在设置-隐私-通讯录中打开应用的访问权限"];
                    [alertView addButtonWithTitle:@"好"
                                             type:SIAlertViewButtonTypeDefault
                                          handler:nil];
                    alertView.transitionStyle = SIAlertViewTransitionStyleFade;
                    [alertView performSelectorOnMainThread:@selector(show) withObject:nil waitUntilDone:NO];
                    popAlert = YES;
                }break;
                default:break;
            }
        } else {
            abRef = ABAddressBookCreate();
        }
    } while (0);
    
    if (success && completion) {
        completion(abRef,popAlert);
        
        if (abRef) {
            CFRelease(abRef);
        }
    }
}

- (void)readAddressBook:(void(^)(BOOL success, BOOL hasPopedAlertMsg))completion
{
    __weak typeof(self) wself = self;
    [self getAddressBookRef:^(ABAddressBookRef addrBookRef, BOOL hasPopedAlertMsg){
        if (addrBookRef == NULL) {
            if (completion) {
                completion(NO,hasPopedAlertMsg);
            }
        }
        else {
            [wself.addrBookApdater readRecordsFromAB:addrBookRef completion:^(BOOL success, BOOL hasPopedAlertMsg){
                if (completion) {
                    completion(success, hasPopedAlertMsg);
                }
            }];
        }
    }];
}

#pragma mark net
- (void)getConfigure:(void(^)(BOOL success, NSError* error))completion
{
    __weak typeof(self) wself = self;
    HBZSNetworkEngine* engine = [[HBZSNetworkEngine alloc] initWithDefaultSetting];
    self.netConfigure = [engine getRequestWithPath:@"uabconfig.uab"
                                        headerDict:nil
                         onDownloadProgressChanged:nil
                                       onSucceeded:^(NSData *responseData) {
                                           [wself onGetConfigureSucceed:responseData completion:completion];
                                       } onError:^(NSError *engineError) {
                                           [wself onGetConfigureFailed:engineError completion:completion];
                                       }];
    self.netEngineConfigure = engine;
}

- (void)onGetConfigureSucceed:(NSData *)responseData completion:(void(^)(BOOL success, NSError* error))completion
{
    self.respConfigure = [GetConfigResponse parseFromData:responseData];
    [Global sharedInstance].respConfigure = self.respConfigure;
    if (completion) {
        completion(YES,nil);
    }

    DDLogInfo(@"%s===>\n%@", __func__, self.respConfigure);
}

- (void)onGetConfigureFailed:(NSError *)engineError completion:(void(^)(BOOL success, NSError* error))completion
{
    DDLogInfo(@"%s===>\n%@", __func__, engineError);
    if (completion) {
        completion(NO,engineError);
    }
}

- (void)auth:(NSString* )phone completion:(void(^)(BOOL success, NSError* error))completion
{
    if (phone.length <= 0) {
        if (completion) {
            completion(NO, nil);
        }
        return;
    }
    
    NSString* phonenum = phone;
    NSString* account = [[[self class] SimpleEncrypt:phonenum
                                            byOffset:3
                                              bySalt:11] base64EncodedString];        // 加密账号
    
    NSString* signedAccount = [[[self class] SimpleEncrypt:account
                                                  byOffset:4
                                                    bySalt:9] md5Hash];                // 对加密后的账号进行签名
    
    AuthRequest* authReq = [[[[[AuthRequest builder]
                               setMethod:AuthMethodImsi]
                              setAccount:account]
                             setVerifySign:signedAccount]
                            build];
    
    NSString* url = self.respConfigure.authUrl;
    if ([url hasPrefix:@"http://"]) {
        url = [url substringFromIndex:7];
    }
    
    __weak typeof(self) wself = self;
    HBZSNetworkEngine* engine = [[HBZSNetworkEngine alloc] initWithHostName:url];
    self.netAuth = [engine postRequestWithData:[authReq data]
                                    headerDict:@{@"x-up-calling-line-id": phonenum}
                       onUploadProgressChanged:nil
                                   onSucceeded:^(NSData *responseData) {
                                       [wself onAuthSucceed:responseData completion:completion];
                                   } onError:^(NSError *engineError) {
                                       [wself onAuthFailed:engineError completion:completion];
                                   }];
    self.netEngineAuth = engine;
}

- (void)onAuthSucceed:(NSData *)responseData completion:(void(^)(BOOL success, NSError* error))completion
{
    self.respAuth = [AuthResponse parseFromData:responseData];
    if (completion) {
        completion(YES,nil);
    }
    DDLogInfo(@"%s===>\n%@", __func__, self.respAuth);
}

- (void)onAuthFailed:(NSError *)engineError completion:(void(^)(BOOL success, NSError* error))completion
{
    DDLogInfo(@"%s===>\n%@", __func__, engineError);
    if (completion) {
        completion(NO,engineError);
    }
}

- (BOOL)hasGetConfigureSuccess
{
    return (self.respConfigure ? YES : NO);
}

- (BOOL)hasAuthSuccess
{
    return (self.respAuth ? YES : NO);
}

- (BOOL)isAddrBookEmpty
{
    return !(self.addrBookApdater.contactList.count > 0);
}

- (void)getUserCloudSummary:(void(^)(BOOL success, NSError* error, id resp))completion
{
    NSMutableString* Cookie = [NSMutableString new];
    if (self.respAuth.token) {
        [Cookie appendFormat:@"Token=%@;", self.respAuth.token];
    }
    if (self.respAuth.syncUserId) {
        [Cookie appendFormat:@"UserID=%lld;", self.respAuth.syncUserId];
    }
    
    __weak typeof(self) wself = self;
    NSString* url = self.respConfigure.getUserCloudSummaryUrl;
    if ([url hasPrefix:@"http://"]) {
        url = [url substringFromIndex:7];
    }
    HBZSNetworkEngine* engine = [[HBZSNetworkEngine alloc] initWithHostName:url];
    self.netUserCloudSummary = [engine getRequestWithPath:nil
                                               headerDict:@{@"Cookie": Cookie}
                                onDownloadProgressChanged:nil
                                              onSucceeded:^(NSData *responseData) {
                                                  [wself onGetUserCloudSummarySucceed:responseData completion:completion];
                                              } onError:^(NSError *engineError) {
                                                  [wself onGetUserCloudSummaryFailed:engineError completion:completion];
                                              }];
    self.netEngineUserCloudSummary = engine;
}

- (void)onGetUserCloudSummarySucceed:(NSData *)responseData completion:(void(^)(BOOL success, NSError* error, id resp))completion
{
    self.respUserCloudSummary = [GetUserCloudSummaryResponse parseFromData:responseData];
    if (completion) {
        completion(YES,nil, self.respUserCloudSummary);
    }
    DDLogInfo(@"%s===>\n %@", __func__, self.respUserCloudSummary);
}

- (void)onGetUserCloudSummaryFailed:(NSError *)engineError completion:(void(^)(BOOL success, NSError* error, id resp))completion
{
    DDLogInfo(@"%s===>\n%@", __func__, engineError);
    if (completion) {
        completion(NO,engineError, nil);
    }
}

- (void)uploadAll:(void(^)(BOOL success, NSError* error, int totalCnt))completion
  progressChanged:(void(^)(double progress))progressChanged
 totalCountSetter:(void(^)(int totalcnt))totalCountSetter
{
    DDLogInfo(@"************  %s date=%@  ************", __func__, [NSDate date]);
    
    // 全量上传
    NSMutableString* Cookie = [NSMutableString new];
    if (self.respAuth.token) {
        [Cookie appendFormat:@"Token=%@;", self.respAuth.token];
    }
    if (self.respAuth.syncUserId) {
        [Cookie appendFormat:@"UserID=%lld;", self.respAuth.syncUserId];
    }
    [Cookie appendString:@"SessionID=;"];
    [Cookie appendString:@"BatchNo=1;"];
    [Cookie appendString:@"NoMore=True;"];
    
    // contactInfolist  联系人信息列表。
    // groupInfoList    联系人分组信息列表。
    
    NSMutableArray* contacts = [NSMutableArray new];
    for (PersonObj* person in self.addrBookApdater.contactList) {
        Contact* item = [person toContact];
        if (item) {
            [contacts addObject:item];
        }
    }
    
    NSMutableArray* groups = [NSMutableArray new];
    for (GroupObj* group in self.addrBookApdater.groupList) {
        Group* item = [group toGroup];
        if (item) {
            [groups addObject:item];
        }
    }
    
    if (totalCountSetter) {
        totalCountSetter(contacts.count);
    }
    
    UploadContactInfoRequest* req = [[[[UploadContactInfoRequest builder]
                                       setContactInfoArray:[ES_PBArray arrayWithArray:contacts valueType:ES_PBArrayValueTypeObject]]
                                      setGroupInfoArray:[ES_PBArray arrayWithArray:groups valueType:ES_PBArrayValueTypeObject]]
                                     build];
    
    NSString* url = self.respConfigure.uploadAllUrlV2;
    if ([url hasPrefix:@"http://"]) {
        url = [url substringFromIndex:7];
    }
    __weak typeof(self) wself = self;
    HBZSNetworkEngine* engine = [[HBZSNetworkEngine alloc] initWithHostName:url];
    self.netUploadAll = [engine postRequestWithData:[req data]
                                          headerDict:@{@"Cookie": Cookie}
                             onUploadProgressChanged:^(double progress) {
                                 //DDLogInfo(@"upload progress %lf", progress);
                                 if (progressChanged) {
                                     progressChanged(progress*0.98);
                                 }
                             } onSucceeded:^(NSData *responseData) {
                                 dispatch_async(wself.uploadSuccessQueue, ^{
                                     [wself onUploadAllSucceed:responseData
                                                    completion:completion
                                               progressChanged:progressChanged];
                                 });
                             } onError:^(NSError *engineError) {
                                 [wself onUploadAllFailed:engineError completion:completion];
                             }];
    
    self.netEngineUploadAll = engine;
}

- (void)onUploadAllSucceed:(NSData *)responseData
                completion:(void(^)(BOOL success, NSError* error, int totalCnt))completion
           progressChanged:(void(^)(double progress))progressChanged
{
    self.respUploadAll = [UploadContactInfoResponse parseFromData:responseData];
    
    if (progressChanged) {
        progressChanged(1.);
    }
    
    if (completion) {
        completion(YES,nil,self.addrBookApdater.contactList.count);
    }
    
    DDLogInfo(@"************  %s date=%@  ************", __func__, [NSDate date]);
}

- (void)onUploadAllFailed:(NSError *)engineError completion:(void(^)(BOOL success, NSError* error, int totalCnt))completion
{
    DDLogInfo(@"%s===>\n%@", __func__, engineError);
    if (completion) {
        completion(NO,engineError,0);
    }
}

- (void)downloadAll:(void(^)(BOOL success, NSError* error, int totalCnt))completion
    progressChanged:(void(^)(double progress))progressChanged
   totalCountSetter:(void(^)(int totalcnt))totalCountSetter
{
    // 全量下载
    NSMutableString* Cookie = [NSMutableString new];
    if (self.respAuth.token) {
        [Cookie appendFormat:@"Token=%@;", self.respAuth.token];
    }
    if (self.respAuth.syncUserId) {
        [Cookie appendFormat:@"UserID=%lld;", self.respAuth.syncUserId];
    }
    
    DDLogInfo(@"************  %s date=%@  ************", __func__, [NSDate date]);
    __weak typeof(self) wself = self;
    NSString* url = self.respConfigure.downloadAllUrl;
    if ([url hasPrefix:@"http://"]) {
        url = [url substringFromIndex:7];
    }
    HBZSNetworkEngine* engine = [[HBZSNetworkEngine alloc] initWithoutContentType:url];
    self.netDownloadAll = [engine getRequestWithPath:nil
                                          headerDict:@{@"Cookie": Cookie, @"Accept-Encoding":@"gzip"}
                           onDownloadProgressChanged:^(double progress) {
                               DDLogInfo(@"download progress %lf", progress);
                               if (progressChanged) {
                                   progressChanged(progress*0.01);   // 下载占比：0.01
                               }
                           } onSucceeded:^(NSData *responseData) {
                               dispatch_async(wself.downloadSuccessQueue, ^{
                                   [wself onDownloadAllSucceed:responseData
                                                    completion:completion
                                               progressChanged:progressChanged
                                              totalCountSetter:totalCountSetter];
                               });
                           } onError:^(NSError *engineError) {
                               [wself onDownloadAllFailed:engineError completion:completion];
                           }];
    self.netEngineDownloadAll = engine;
}

- (void)onDownloadAllSucceed:(NSData *)responseData
                  completion:(void(^)(BOOL success, NSError* error, int totalCnt))completion
             progressChanged:(void(^)(double progress))progressChanged
            totalCountSetter:(void(^)(int totalcnt))totalCountSetter
{
    DDLogInfo(@"%s===>\n", __func__);
    
    __weak typeof(self) wself = self;
    [self getAddressBookRef:^(ABAddressBookRef addrBookRef, BOOL hasPopedAlertMsg){
        NSDictionary* results = [NSDictionary dictionaryWithXMLData:responseData];
        __block BOOL success = NO;
        __block double initPer = 0.01;
        __block double perSize = 0.01;
        
        do {
            // 1. 解析，占比：0.01
            [wself.addrBookApdater parseDictionary:results completion:^{
                if (totalCountSetter) {
                    totalCountSetter(wself.addrBookApdater.contactList.count);
                }
                initPer += perSize;
                if (progressChanged) {
                    progressChanged(initPer);
                }
                
                // 2. 备份，占比：0.01
                perSize = 0.01;
                success = [wself.addrBookApdater localBackupAddressBook:addrBookRef];
                initPer += perSize;
                if (progressChanged) {
                    progressChanged(initPer);
                }
                if (!success) {
                    return;
                }
                
                // 3. 全量删除本地记录，占比：0.01
                perSize = 0.01;
                success = [wself.addrBookApdater deleteAddressBook:addrBookRef];
                initPer += perSize;
                if (progressChanged) {
                    progressChanged(initPer);
                }
                if (!success) {
                    return;
                }
                
                // 4. 写入本地，占比：0.95
                perSize = 1. - initPer;
                success = [wself.addrBookApdater writeAllRecords2AB:addrBookRef progressChanged:progressChanged initPercent:initPer totalPercent:perSize];
                DDLogInfo(@"contacts %d", wself.addrBookApdater.contactList.count);
            }];
            
        } while (0);
        
        if (completion) {
            completion(success,nil,wself.addrBookApdater.contactList.count);
        }
        
        DDLogInfo(@"************  %s date=%@  ************", __func__, [NSDate date]);
        
    }];
    
}

- (void)onDownloadAllFailed:(NSError *)engineError completion:(void(^)(BOOL success, NSError* error, int totalCnt))completion
{
    DDLogInfo(@"%s===>\n%@", __func__, engineError);
    if (completion) {
        completion(NO,engineError,0);
    }
}

// 本地回滚
- (void)localRollback:(void(^)(BOOL success, int totalCnt, NSTimeInterval backupTimestamp))completion
      progressChanged:(void(^)(double progress))progressChanged
{
    __weak typeof(self) wself = self;
    [self getAddressBookRef:^(ABAddressBookRef addrBookRef, BOOL hasPopedAlertMsg){
        
        // 1. 全量删除本地记录，占比：0.01
        BOOL success = [wself.addrBookApdater deleteAddressBook:addrBookRef];
        if (!success) {
            completion(NO,0,0);
            return;
        }
        
        [wself.addrBookApdater rollbackLocalAddressBook:addrBookRef progressChanged:progressChanged completion:completion];
    }];
}

// 记录操作
- (void)saveLog:(NSDate*)time type:(ABLogType)type contacts:(int)contacts comment:(NSString*)comment success:(BOOL)success
{
    ABLogItem* log = [ABLogItem new];
    log.time = time?[time timeIntervalSince1970]:0;
    log.type = type;
    log.totalContact = contacts;
    log.comment = comment;
    log.success = success;
    [self.addrBookLogger saveLog:log];
}

- (NSArray*)loadABLog
{
    return [self.addrBookLogger loadABLog];
}

- (BOOL)checkIfSamePlatform
{
    return [self.addrBookLogger checkIfSamePlatform];
}

- (BOOL)localBackupCacheExist
{
    return [self.addrBookApdater localBackupCacheExist];
}

- (void)deleteLocalBackupCache // 删除本地备份
{
    [self.addrBookApdater deleteLocalBackupCache];
}

@end
