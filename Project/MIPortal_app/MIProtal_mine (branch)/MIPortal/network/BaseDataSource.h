//
//  BaseDataSource.h
//  
//
//  Created by apple on 13-4-16.
//
//

#import <Foundation/Foundation.h>

@interface BaseDataSource : NSObject

@property (nonatomic, copy) NSString*   errorCode;
@property (nonatomic, copy) NSString*   errorMsg;
@property (nonatomic, copy) id          responseDict;

+ (NSString* )getErrorMsgByCode:(NSString* )errorCode;

- (void)startGetRequestWithParams:(NSDictionary *)params method:(NSString *)method completion:(void(^)(id responsedict))completion;
- (void)startGetRequestWithParamsAndUrl:(NSDictionary *)params method:(NSString *)method url:(NSString *)url completion:(void(^)(id responsedict))completion;

//带上传文件的post请求
- (void)startPostRequestWithParamsAndUrl:(NSDictionary *)params
                                  method:(NSString *)method
                                 upFiles:(NSArray*)upFiles
                              completion:(void(^)(id responsedict))completion;

//带上传文件的post请求
- (void)startPostRequestWithParamsAndUrl:(NSDictionary *)params
                                  method:(NSString *)method
                                     url:(NSString *)url
                                 upFiles:(NSArray*)upFiles
                              completion:(void(^)(id responsedict))completion;

- (void)startPostRequestWithParams:(NSDictionary *)params method:(NSString *)method completion:(void(^)(id responsedict))completion;
- (void)startPostRequestWithParamsAndUrl:(NSDictionary *)params method:(NSString *)method url:(NSString *)url completion:(void(^)(id responsedict))completion;

- (void)cancel;

@end
