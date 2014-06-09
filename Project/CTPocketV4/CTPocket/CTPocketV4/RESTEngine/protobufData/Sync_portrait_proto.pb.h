// Generated by the protocol buffer compiler.  DO NOT EDIT!

#import "ES_ProtocolBuffers.h"

#import "Upload_portrait_proto.pb.h"

@class Address;
@class Address_Builder;
@class Category;
@class Category_Builder;
@class Email;
@class Email_Builder;
@class Employed;
@class Employed_Builder;
@class InstantMessage;
@class InstantMessage_Builder;
@class Name;
@class Name_Builder;
@class Phone;
@class Phone_Builder;
@class PortraitData;
@class PortraitData_Builder;
@class PortraitSummary;
@class PortraitSummary_Builder;
@class Sms;
@class SmsSummary;
@class SmsSummary_Builder;
@class Sms_Builder;
@class SyncPortraitRequest;
@class SyncPortraitRequest_Builder;
@class SyncPortraitResponse;
@class SyncPortraitResponse_Builder;
@class UabError;
@class UabError_Builder;
@class UploadPortraitData;
@class UploadPortraitData_Builder;
@class UploadPortraitRequest;
@class UploadPortraitRequest_Builder;
@class UploadPortraitResponse;
@class UploadPortraitResponse_Builder;
@class Website;
@class Website_Builder;
#ifndef __has_feature
  #define __has_feature(x) 0 // Compatibility with non-clang compilers.
#endif // __has_feature

#ifndef NS_RETURNS_NOT_RETAINED
  #if __has_feature(attribute_ns_returns_not_retained)
    #define NS_RETURNS_NOT_RETAINED __attribute__((ns_returns_not_retained))
  #else
    #define NS_RETURNS_NOT_RETAINED
  #endif
#endif


@interface SyncPortraitProtoRoot : NSObject {
}
+ (ES_PBExtensionRegistry*) extensionRegistry;
+ (void) registerAllExtensions:(ES_PBMutableExtensionRegistry*) registry;
@end

@interface SyncPortraitRequest : ES_PBGeneratedMessage {
@private
  BOOL hasBusinessCardPortraitVersion_:1;
  int32_t businessCardPortraitVersion;
  ES_PBAppendableArray * portraitSummaryArray;
}
- (BOOL) hasBusinessCardPortraitVersion;
@property (readonly, retain) ES_PBArray * portraitSummary;
@property (readonly) int32_t businessCardPortraitVersion;
- (PortraitSummary*)portraitSummaryAtIndex:(NSUInteger)index;

+ (SyncPortraitRequest*) defaultInstance;
- (SyncPortraitRequest*) defaultInstance;

- (BOOL) isInitialized;
- (void) writeToCodedOutputStream:(ES_PBCodedOutputStream*) output;
- (SyncPortraitRequest_Builder*) builder;
+ (SyncPortraitRequest_Builder*) builder;
+ (SyncPortraitRequest_Builder*) builderWithPrototype:(SyncPortraitRequest*) prototype;
- (SyncPortraitRequest_Builder*) toBuilder;

+ (SyncPortraitRequest*) parseFromData:(NSData*) data;
+ (SyncPortraitRequest*) parseFromData:(NSData*) data extensionRegistry:(ES_PBExtensionRegistry*) extensionRegistry;
+ (SyncPortraitRequest*) parseFromInputStream:(NSInputStream*) input;
+ (SyncPortraitRequest*) parseFromInputStream:(NSInputStream*) input extensionRegistry:(ES_PBExtensionRegistry*) extensionRegistry;
+ (SyncPortraitRequest*) parseFromCodedInputStream:(ES_PBCodedInputStream*) input;
+ (SyncPortraitRequest*) parseFromCodedInputStream:(ES_PBCodedInputStream*) input extensionRegistry:(ES_PBExtensionRegistry*) extensionRegistry;
@end

@interface SyncPortraitRequest_Builder : ES_PBGeneratedMessage_Builder {
@private
  SyncPortraitRequest* result;
}

- (SyncPortraitRequest*) defaultInstance;

- (SyncPortraitRequest_Builder*) clear;
- (SyncPortraitRequest_Builder*) clone;

- (SyncPortraitRequest*) build;
- (SyncPortraitRequest*) buildPartial;

- (SyncPortraitRequest_Builder*) mergeFrom:(SyncPortraitRequest*) other;
- (SyncPortraitRequest_Builder*) mergeFromCodedInputStream:(ES_PBCodedInputStream*) input;
- (SyncPortraitRequest_Builder*) mergeFromCodedInputStream:(ES_PBCodedInputStream*) input extensionRegistry:(ES_PBExtensionRegistry*) extensionRegistry;

- (ES_PBAppendableArray *)portraitSummary;
- (PortraitSummary*)portraitSummaryAtIndex:(NSUInteger)index;
- (SyncPortraitRequest_Builder *)addPortraitSummary:(PortraitSummary*)value;
- (SyncPortraitRequest_Builder *)setPortraitSummaryArray:(NSArray *)array;
- (SyncPortraitRequest_Builder *)setPortraitSummaryValues:(const PortraitSummary* *)values count:(NSUInteger)count;
- (SyncPortraitRequest_Builder *)clearPortraitSummary;

- (BOOL) hasBusinessCardPortraitVersion;
- (int32_t) businessCardPortraitVersion;
- (SyncPortraitRequest_Builder*) setBusinessCardPortraitVersion:(int32_t) value;
- (SyncPortraitRequest_Builder*) clearBusinessCardPortraitVersion;
@end

@interface SyncPortraitResponse : ES_PBGeneratedMessage {
@private
  BOOL hasIsNeedToDownloadBusinessCardPortrait_:1;
  BOOL isNeedToDownloadBusinessCardPortrait_:1;
  ES_PBAppendableArray * downloadPortraitIdArray;
  int32_t downloadPortraitIdMemoizedSerializedSize;
  ES_PBAppendableArray * deletedPortraitIdArray;
  int32_t deletedPortraitIdMemoizedSerializedSize;
}
- (BOOL) hasIsNeedToDownloadBusinessCardPortrait;
@property (readonly, retain) ES_PBArray * downloadPortraitId;
@property (readonly, retain) ES_PBArray * deletedPortraitId;
- (BOOL) isNeedToDownloadBusinessCardPortrait;
- (int32_t)downloadPortraitIdAtIndex:(NSUInteger)index;
- (int32_t)deletedPortraitIdAtIndex:(NSUInteger)index;

+ (SyncPortraitResponse*) defaultInstance;
- (SyncPortraitResponse*) defaultInstance;

- (BOOL) isInitialized;
- (void) writeToCodedOutputStream:(ES_PBCodedOutputStream*) output;
- (SyncPortraitResponse_Builder*) builder;
+ (SyncPortraitResponse_Builder*) builder;
+ (SyncPortraitResponse_Builder*) builderWithPrototype:(SyncPortraitResponse*) prototype;
- (SyncPortraitResponse_Builder*) toBuilder;

+ (SyncPortraitResponse*) parseFromData:(NSData*) data;
+ (SyncPortraitResponse*) parseFromData:(NSData*) data extensionRegistry:(ES_PBExtensionRegistry*) extensionRegistry;
+ (SyncPortraitResponse*) parseFromInputStream:(NSInputStream*) input;
+ (SyncPortraitResponse*) parseFromInputStream:(NSInputStream*) input extensionRegistry:(ES_PBExtensionRegistry*) extensionRegistry;
+ (SyncPortraitResponse*) parseFromCodedInputStream:(ES_PBCodedInputStream*) input;
+ (SyncPortraitResponse*) parseFromCodedInputStream:(ES_PBCodedInputStream*) input extensionRegistry:(ES_PBExtensionRegistry*) extensionRegistry;
@end

@interface SyncPortraitResponse_Builder : ES_PBGeneratedMessage_Builder {
@private
  SyncPortraitResponse* result;
}

- (SyncPortraitResponse*) defaultInstance;

- (SyncPortraitResponse_Builder*) clear;
- (SyncPortraitResponse_Builder*) clone;

- (SyncPortraitResponse*) build;
- (SyncPortraitResponse*) buildPartial;

- (SyncPortraitResponse_Builder*) mergeFrom:(SyncPortraitResponse*) other;
- (SyncPortraitResponse_Builder*) mergeFromCodedInputStream:(ES_PBCodedInputStream*) input;
- (SyncPortraitResponse_Builder*) mergeFromCodedInputStream:(ES_PBCodedInputStream*) input extensionRegistry:(ES_PBExtensionRegistry*) extensionRegistry;

- (ES_PBAppendableArray *)downloadPortraitId;
- (int32_t)downloadPortraitIdAtIndex:(NSUInteger)index;
- (SyncPortraitResponse_Builder *)addDownloadPortraitId:(int32_t)value;
- (SyncPortraitResponse_Builder *)setDownloadPortraitIdArray:(NSArray *)array;
- (SyncPortraitResponse_Builder *)setDownloadPortraitIdValues:(const int32_t *)values count:(NSUInteger)count;
- (SyncPortraitResponse_Builder *)clearDownloadPortraitId;

- (ES_PBAppendableArray *)deletedPortraitId;
- (int32_t)deletedPortraitIdAtIndex:(NSUInteger)index;
- (SyncPortraitResponse_Builder *)addDeletedPortraitId:(int32_t)value;
- (SyncPortraitResponse_Builder *)setDeletedPortraitIdArray:(NSArray *)array;
- (SyncPortraitResponse_Builder *)setDeletedPortraitIdValues:(const int32_t *)values count:(NSUInteger)count;
- (SyncPortraitResponse_Builder *)clearDeletedPortraitId;

- (BOOL) hasIsNeedToDownloadBusinessCardPortrait;
- (BOOL) isNeedToDownloadBusinessCardPortrait;
- (SyncPortraitResponse_Builder*) setIsNeedToDownloadBusinessCardPortrait:(BOOL) value;
- (SyncPortraitResponse_Builder*) clearIsNeedToDownloadBusinessCardPortrait;
@end

